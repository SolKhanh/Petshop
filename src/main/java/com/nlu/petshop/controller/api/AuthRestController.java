package com.nlu.petshop.controller.api;

import com.nlu.petshop.dto.UserRegisterDTO;
import com.nlu.petshop.entity.UserAccount;
import com.nlu.petshop.service.AuthService;
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
    public ResponseEntity<?> login(@RequestBody UserRegisterDTO dto) {
        UserAccount user = authService.login(dto.getUsername(), dto.getPassword());
        return ResponseEntity.ok(user); // Return user info for now, can replace with JWT later
    }
}
