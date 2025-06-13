package com.nlu.petshop.service;

import com.nlu.petshop.dto.request.UserProfileUpdateDTO;
import com.nlu.petshop.dto.request.UserRegisterDTO;
import com.nlu.petshop.dto.response.UserResponseDTO;
import com.nlu.petshop.entity.UserAccount;

import java.util.Optional;

public interface AuthService {
    UserAccount register(UserRegisterDTO dto);
    UserAccount getCurrentUser();
    Optional<UserAccount> getUserByUsername(String username);
    UserResponseDTO convertToUserResponseDTO(UserAccount user);
}
