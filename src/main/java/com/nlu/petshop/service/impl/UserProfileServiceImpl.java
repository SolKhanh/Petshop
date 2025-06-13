package com.nlu.petshop.service.impl;

import com.nlu.petshop.dto.request.ChangePasswordDTO;
import com.nlu.petshop.dto.request.UserProfileUpdateDTO;
import com.nlu.petshop.dto.response.UserResponseDTO;
import com.nlu.petshop.entity.InforUser;
import com.nlu.petshop.entity.UserAccount;
import com.nlu.petshop.repository.InforUserRepository;
import com.nlu.petshop.repository.UserAccountRepository;
import com.nlu.petshop.service.AuthService;
import com.nlu.petshop.service.UserProfileService;
import jakarta.persistence.EntityNotFoundException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
public class UserProfileServiceImpl implements UserProfileService {

    @Autowired
    private UserAccountRepository userAccountRepository;

    @Autowired
    private InforUserRepository inforUserRepository;

    @Autowired
    private PasswordEncoder passwordEncoder;

    @Autowired
    private AuthService authService;

    @Override
    @Transactional
    public UserResponseDTO updateUserProfile(Long userId, UserProfileUpdateDTO profileUpdateDTO) {
        UserAccount user = userAccountRepository.findById(userId)
                .orElseThrow(() -> new EntityNotFoundException("error.user.notFound"));

        InforUser inforUser = user.getInforUser();
        if (inforUser == null) {
            throw new EntityNotFoundException("Không tìm thấy thông tin profile để cập nhật.");
        }

        updateInforUser(profileUpdateDTO, inforUser, inforUserRepository);

        return authService.convertToUserResponseDTO(user);
    }

    static void updateInforUser(UserProfileUpdateDTO profileUpdateDTO, InforUser inforUser, InforUserRepository inforUserRepository) {
        if (profileUpdateDTO.getName() != null) inforUser.setName(profileUpdateDTO.getName());
        if (profileUpdateDTO.getEmail() != null) inforUser.setEmail(profileUpdateDTO.getEmail());
        if (profileUpdateDTO.getPhone() != null) inforUser.setPhone(profileUpdateDTO.getPhone());
        if (profileUpdateDTO.getAddress() != null) inforUser.setAddress(profileUpdateDTO.getAddress());
        if (profileUpdateDTO.getAvt() != null) inforUser.setAvt(profileUpdateDTO.getAvt());

        inforUserRepository.save(inforUser);
    }

    @Override
    @Transactional
    public void changePassword(Long userId, ChangePasswordDTO dto) {
        if (!dto.getNewPassword().equals(dto.getConfirmNewPassword())) {
            throw new IllegalArgumentException("Mật khẩu mới và mật khẩu xác nhận không khớp.");
        }

        UserAccount user = userAccountRepository.findById(userId)
                .orElseThrow(() -> new EntityNotFoundException("error.user.notFound"));

        // Xác thực mật khẩu cũ
        if (!passwordEncoder.matches(dto.getOldPassword(), user.getPassword())) {
            throw new IllegalArgumentException("Mật khẩu cũ không chính xác.");
        }

        // Cập nhật mật khẩu mới đã mã hóa
        user.setPassword(passwordEncoder.encode(dto.getNewPassword()));
        userAccountRepository.save(user);
    }
}