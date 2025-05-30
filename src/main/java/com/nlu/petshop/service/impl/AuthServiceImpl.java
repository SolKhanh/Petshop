package com.nlu.petshop.service.impl;

import com.nlu.petshop.dto.request.UserRegisterDTO;
import com.nlu.petshop.dto.response.UserResponseDTO;
import com.nlu.petshop.entity.*;
import com.nlu.petshop.repository.*;
import com.nlu.petshop.service.AuthService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import java.util.Set;
import java.util.stream.Collectors;

@Service
public class AuthServiceImpl implements AuthService {

    @Autowired private UserAccountRepository userRepo;
    @Autowired private RoleRepository roleRepo;
    @Autowired private UserRoleRepository userRoleRepo;
    @Autowired private PasswordEncoder passwordEncoder;
    private UserAccount user;

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

    @Override
    public UserAccount login(String username, String password) {
        // tạm thời chưa có JWT, chỉ check login
        UserAccount user = userRepo.findByUsername(username)
                .orElseThrow(() -> new RuntimeException("Invalid credentials"));

        if (!passwordEncoder.matches(password, user.getPassword())) {
            throw new RuntimeException("Invalid credentials");
        }
        this.user = user;
        return user;
    }

    @Override
    public UserAccount getCurrentUser() {
        if (user == null) {
            throw new RuntimeException("not logged in");
        }
        return user;
    }

    @Override
    public UserAccount updateCurrentUser(UserRegisterDTO dto) {
        if (user == null) {
            throw new RuntimeException("not logged in");
        }
        this.user.setUsername(dto.getUsername());
        this.user.setPassword(passwordEncoder.encode(dto.getPassword()));

        userRepo.save(user);

        return user;
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
}
