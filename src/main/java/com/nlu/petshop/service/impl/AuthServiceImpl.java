package com.nlu.petshop.service.impl;

import com.nlu.petshop.dto.request.UserProfileUpdateDTO;
import com.nlu.petshop.dto.request.UserRegisterDTO;
import com.nlu.petshop.dto.response.UserResponseDTO;
import com.nlu.petshop.entity.*;
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
        user.setStatus(1);

        // Tạo inforUser
        InforUser infor = new InforUser();
        infor.setIdUser(user.getId());
        infor.setUser(user);
        infor.setAvt("img/user/avatar.png"); // hoặc null

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
        dto.setStatus(user.getStatus());
        // Lấy tên vai trò
        if (user.getUserRoles() != null) {
            Set<String> roleNames = user.getUserRoles().stream()
                    .map(userRole -> userRole.getRole().getName())
                    .collect(Collectors.toSet());
            dto.setRoles(roleNames);
        }
        return dto;
    }
    @Override
    @Transactional
    public UserResponseDTO updateUserProfile(Long userId, UserProfileUpdateDTO dto) {
        // Tìm UserAccount và InforUser liên quan
        UserAccount user = userRepo.findById(userId)
                .orElseThrow(() -> new EntityNotFoundException("User not found"));
        InforUser inforUser = user.getInforUser();
        if (inforUser == null) {
            //nếu InforUser chưa được tạo
            inforUser = new InforUser();
            inforUser.setUser(user);
        }

        // Chỉ cập nhật các trường từ DTO mới
        if (dto.getName() != null) inforUser.setName(dto.getName());
        if (dto.getEmail() != null) inforUser.setEmail(dto.getEmail());
        if (dto.getPhone() != null) inforUser.setPhone(dto.getPhone());
        if (dto.getAddress() != null) inforUser.setAddress(dto.getAddress());
        if (dto.getAvt() != null) inforUser.setAvt(dto.getAvt());

        inforUserRepo.save(inforUser);

        return convertToUserResponseDTO(user);
    }
}
