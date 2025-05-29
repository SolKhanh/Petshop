package com.nlu.petshop.controller.api;

import com.nlu.petshop.dto.request.LoginRequestDTO;
import com.nlu.petshop.dto.request.UserRegisterDTO;
import com.nlu.petshop.dto.response.UserResponseDTO;
import com.nlu.petshop.entity.UserAccount;
import com.nlu.petshop.service.AuthService;
import jakarta.validation.Valid;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/api/auth")
public class AuthRestController {

    @Autowired
    private AuthService authService;

    @PostMapping("/register")
    public ResponseEntity<?> register(@RequestBody UserRegisterDTO dto) {
        UserAccount user = authService.register(dto);
        return ResponseEntity.ok(user);
    }

    @PostMapping("/login")
    public ResponseEntity<?> login(@Valid @RequestBody LoginRequestDTO dto) {
        UserAccount user = authService.login(dto.getUsername(), dto.getPassword());
        UserResponseDTO responseDto = authService.convertToUserResponseDTO(user);
        //sau này sẽ trả về JWT Token
        return ResponseEntity.ok(responseDto);
    }
}
