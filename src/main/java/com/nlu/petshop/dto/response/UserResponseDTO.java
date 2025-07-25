package com.nlu.petshop.dto.response;

import com.nlu.petshop.entity.UserAccount;
import lombok.Data;
import java.util.Set;
import java.util.stream.Collectors;

@Data
public class UserResponseDTO {
    private Long id;
    private String username;
    private String status;
     private String email;
     private String name;
     private String phone;
     private String address;
     private String avatar;
    private Set<String> roles;

    public static UserResponseDTO fromEntity(UserAccount user) {
        if (user == null) return null;
        UserResponseDTO dto = new UserResponseDTO();
        dto.setId(user.getId());
        dto.setUsername(user.getUsername());
        dto.setStatus(user.getStatus().name());
         dto.setEmail(user.getInforUser().getEmail());
         dto.setName(user.getInforUser().getName());
         dto.setPhone(user.getInforUser().getPhone());
         dto.setAddress(user.getInforUser().getAddress());
         dto.setAvatar(user.getInforUser().getAvt());

        if (user.getUserRoles() != null) {
            dto.setRoles(user.getUserRoles().stream()
                    .map(userRole -> userRole.getRole().getName()) // Lấy tên từ Role entity
                    .collect(Collectors.toSet()));
        }
        return dto;
    }
}