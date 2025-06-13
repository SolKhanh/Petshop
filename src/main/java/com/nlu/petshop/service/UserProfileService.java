package com.nlu.petshop.service;

import com.nlu.petshop.dto.request.ChangePasswordDTO;
import com.nlu.petshop.dto.request.UserProfileUpdateDTO;
import com.nlu.petshop.dto.response.UserResponseDTO;

public interface UserProfileService {
    UserResponseDTO updateUserProfile(Long userId, UserProfileUpdateDTO profileUpdateDTO);

    void changePassword(Long userId, ChangePasswordDTO changePasswordRequestDTO);
}
