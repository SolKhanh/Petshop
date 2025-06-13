package com.nlu.petshop.controller.api;

import com.nlu.petshop.dto.request.ChangePasswordDTO;
import com.nlu.petshop.dto.request.UserProfileUpdateDTO;
import com.nlu.petshop.dto.response.UserResponseDTO;
import com.nlu.petshop.entity.UserAccount;
import com.nlu.petshop.service.AuthService;
import com.nlu.petshop.service.UserProfileService;
import jakarta.validation.Valid;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/api/users/me")
public class UserRestController {

    @Autowired
    private AuthService authService;

    @Autowired
    private UserProfileService userProfileService;

    @GetMapping("/profile")
    public ResponseEntity<?> getCurrentUser() {
        UserAccount user = authService.getCurrentUser();
        UserResponseDTO res = authService.convertToUserResponseDTO(user);
        return ResponseEntity.ok(res);
    }

    @PutMapping("/profile")
    public ResponseEntity<UserResponseDTO> updateUserProfile(@Valid @RequestBody UserProfileUpdateDTO dto) {
        Long userId = authService.getCurrentUser().getId();
        UserResponseDTO updatedUser = userProfileService.updateUserProfile(userId, dto);
        return ResponseEntity.ok(updatedUser);
    }

    @PostMapping("/change-password")
    public ResponseEntity<String> changePassword(@Valid @RequestBody ChangePasswordDTO dto) {
        Long userId = authService.getCurrentUser().getId();
        userProfileService.changePassword(userId, dto);
        return ResponseEntity.ok("Đổi mật khẩu thành công.");
    }
}
