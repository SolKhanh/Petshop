package com.nlu.petshop.service;

import com.nlu.petshop.dto.request.UserRegisterDTO;
import com.nlu.petshop.dto.response.UserResponseDTO;
import com.nlu.petshop.entity.UserAccount;

public interface AuthService {
    UserAccount register(UserRegisterDTO dto);
    UserAccount login(String username, String password);
    UserAccount getCurrentUser();
    UserAccount updateCurrentUser(UserRegisterDTO dto);
    UserResponseDTO convertToUserResponseDTO(UserAccount user);
}
