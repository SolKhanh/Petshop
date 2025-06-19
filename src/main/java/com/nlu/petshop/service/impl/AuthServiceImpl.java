package com.nlu.petshop.service.impl;

import com.nlu.petshop.dto.request.UserProfileUpdateDTO;
import com.nlu.petshop.dto.request.UserRegisterDTO;
import com.nlu.petshop.dto.response.UserResponseDTO;
import com.nlu.petshop.entity.*;
import com.nlu.petshop.model.AccountStatus;
import com.nlu.petshop.repository.*;
import com.nlu.petshop.service.AuthService;
import jakarta.persistence.EntityNotFoundException;
import jakarta.transaction.Transactional;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import java.util.Optional;
import java.util.Set;
import java.util.stream.Collectors;

@Service
public class AuthServiceImpl implements AuthService {

    @Autowired private UserAccountRepository userRepo;
    @Autowired private RoleRepository roleRepo;
    @Autowired private UserRoleRepository userRoleRepo;
    @Autowired private PasswordEncoder passwordEncoder;
    @Autowired private InforUserRepository inforUserRepo;
//    private UserAccount user;

    @Override
    public UserAccount register(UserRegisterDTO dto) {
        UserAccount user = new UserAccount();
        System.out.println("Username: " + dto.getUsername());
        user.setUsername(dto.getUsername());
        user.setPassword(passwordEncoder.encode(dto.getPassword()));
        user.setStatus(AccountStatus.ACTIVE);

        // Tạo inforUser
        // Tạo inforUser và set thông tin từ dto
        InforUser infor = new InforUser();
        infor.setName(dto.getName());
        infor.setEmail(dto.getEmail());
        infor.setPhone(dto.getPhone());
        infor.setAddress(dto.getAddress());
        infor.setAvt(dto.getAvatar() != null ? dto.getAvatar() : "img/user/avatar.png");

// Thiết lập liên kết 2 chiều
        infor.setUser(user);
        user.setInforUser(infor);

        userRepo.save(user);

        // Assign default role
        Role role = roleRepo.findById("USER")
                .orElseThrow(() -> new RuntimeException("Default role USER not found in database")); // đảm bảo có role USER
        System.out.println("Available roles: " + roleRepo.findAll());
        UserRole userRole = new UserRole();
        userRole.setUser(user);
        userRole.setRole(role);
        userRoleRepo.save(userRole);

        return user;
    }

//    login đã xử lí trong controller


    @Override
    public UserAccount getCurrentUser() {
        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        if (authentication == null || !authentication.isAuthenticated() || "anonymousUser".equals(authentication.getPrincipal())) {
            throw new IllegalStateException("Không có người dùng nào được xác thực.");
        }
        String username = authentication.getName();
        return userRepo.findByUsername(username)
                .orElseThrow(() -> new UsernameNotFoundException("Người dùng đã xác thực '" + username + "' không được tìm thấy trong CSDL."));
    }

    @Override
    public Optional<UserAccount> getUserByUsername(String username) {
        return userRepo.findByUsername(username);
    }
    public UserResponseDTO convertToUserResponseDTO(UserAccount user) {
        UserResponseDTO dto = new UserResponseDTO();
        dto.setId(user.getId());
        dto.setUsername(user.getUsername());
        dto.setStatus(user.getStatus().name());
        dto.setEmail(user.getInforUser().getEmail());
        dto.setName(user.getInforUser().getName());
        dto.setPhone(user.getInforUser().getPhone());
        dto.setAddress(user.getInforUser().getAddress());
        dto.setAvatar(user.getInforUser().getAvt());
        // Lấy tên vai trò
        if (user.getUserRoles() != null) {
            Set<String> roleNames = user.getUserRoles().stream()
                    .map(userRole -> userRole.getRole().getName())
                    .collect(Collectors.toSet());
            dto.setRoles(roleNames);
        }
        return dto;
    }

}
