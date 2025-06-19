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

        Cookie jwtCookie = new Cookie("jwtToken", jwtToken);
        jwtCookie.setHttpOnly(true);
        jwtCookie.setSecure(false);
        jwtCookie.setPath("/");
        jwtCookie.setMaxAge((int) (jwtExpiration / 1000));

        response.addCookie(jwtCookie);

        return ResponseEntity.ok(new AuthResponseDTO(jwtToken));
    }

    @PostMapping("/logout")
    public ResponseEntity<?> logout(HttpServletResponse response) {
        Cookie cookie = new Cookie("jwtToken", null);
        cookie.setPath("/");
        cookie.setHttpOnly(true);
        cookie.setMaxAge(0);

        response.addCookie(cookie);

        return ResponseEntity.ok("Logout successful");
    }
}