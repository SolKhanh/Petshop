package com.nlu.petshop.controller.api;

import com.nlu.petshop.dto.request.UserProfileUpdateDTO;
import com.nlu.petshop.dto.request.UserRegisterDTO;
import com.nlu.petshop.dto.response.UserResponseDTO;
import com.nlu.petshop.entity.UserAccount;
import com.nlu.petshop.service.AuthService;
import jakarta.validation.Valid;
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
    public ResponseEntity<UserResponseDTO> updateUserProfile(@Valid @RequestBody UserProfileUpdateDTO dto) {
        // Lấy userId của người dùng đã đăng nhập từ SecurityContext
        Long userId = authService.getCurrentUser().getId();

        UserResponseDTO updatedUser = authService.updateUserProfile(userId, dto);
        return ResponseEntity.ok(updatedUser);
    }
}
