package com.nlu.petshop.controller.api;

import com.nlu.petshop.dto.request.LoginRequestDTO;
import com.nlu.petshop.dto.request.UserRegisterDTO;
import com.nlu.petshop.dto.response.AuthResponseDTO;
import com.nlu.petshop.dto.response.UserResponseDTO;
import com.nlu.petshop.entity.UserAccount;
import com.nlu.petshop.service.AuthService;
import com.nlu.petshop.service.JwtService;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.validation.Valid;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.ResponseEntity;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/api/auth")
public class AuthRestController {

    @Autowired
    private AuthService authService;

    @Autowired
    private JwtService jwtService;

    @Autowired
    private AuthenticationManager authenticationManager;

    @Autowired
    private UserDetailsService userDetailsService;

    @Value("${jwt.expiration}")
    private long jwtExpiration;

    @PostMapping("/register")
    public ResponseEntity<UserResponseDTO> register(@Valid @RequestBody UserRegisterDTO dto) {
        UserAccount user = authService.register(dto);
        UserResponseDTO responseDto = authService.convertToUserResponseDTO(user);
        return ResponseEntity.ok(responseDto);
    }

    @PostMapping("/login")
    public ResponseEntity<AuthResponseDTO> login(@Valid @RequestBody LoginRequestDTO dto, HttpServletResponse response) {

        authenticationManager.authenticate(
                new UsernamePasswordAuthenticationToken(dto.getUsername(), dto.getPassword())
        );

        // Lấy thông tin người dùng
        UserDetails userDetails = userDetailsService.loadUserByUsername(dto.getUsername());

        // Tạo JWT token
        String jwtToken = jwtService.generateToken(userDetails);


        // Tạo cookie và gắn token
        Cookie cookie = new Cookie("jwtToken", jwtToken);
        cookie.setHttpOnly(true); // Ngăn JS đọc được cookie (bảo mật chống XSS)
        cookie.setSecure(false); // ⚠️ Để true nếu chạy HTTPS (nên để true trong môi trường production)
        cookie.setPath("/"); // Áp dụng cho toàn bộ domain
        cookie.setMaxAge(3600000/1000); // Thời gian sống: 7 ngày

        // Đưa cookie vào response
        response.addCookie(cookie);

        // Trả về token nếu bạn vẫn cần dùng phía client (có thể bỏ nếu không cần)
        return ResponseEntity.ok(new AuthResponseDTO(jwtToken));
    }
    @PostMapping("/logout")
    public ResponseEntity<String> logout(HttpServletResponse response) {
        Cookie cookie = new Cookie("jwtToken", null); // null hoặc ""
        cookie.setHttpOnly(true);
        cookie.setSecure(false); // true nếu dùng HTTPS
        cookie.setPath("/");
        cookie.setMaxAge(0); // Xóa cookie

        response.addCookie(cookie);

        return ResponseEntity.ok("Đăng xuất thành công!");
    }

=
}