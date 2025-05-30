package com.nlu.petshop.controller.api;

import com.nlu.petshop.dto.request.UserRegisterDTO;
import com.nlu.petshop.dto.response.UserResponseDTO;
import com.nlu.petshop.entity.UserAccount;
import com.nlu.petshop.service.AuthService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/api/users")
public class UserRestController {

    @Autowired
    private AuthService authService;

    @GetMapping("/me")
    public ResponseEntity<?> getCurrentUser() {
        UserAccount user = authService.getCurrentUser(); // Will return the logged-in user
        UserResponseDTO res = authService.convertToUserResponseDTO(user);
        return ResponseEntity.ok(res);
    }

    @PutMapping("/me")
    public ResponseEntity<?> updateUser(@RequestBody UserRegisterDTO dto) {
        UserAccount updatedUser = authService.updateCurrentUser(dto);
        UserResponseDTO res = authService.convertToUserResponseDTO(updatedUser);
        return ResponseEntity.ok(res);
    }
}
