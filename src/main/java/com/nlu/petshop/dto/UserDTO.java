package com.nlu.petshop.dto;

import com.nlu.petshop.entity.AdminRole;
import com.nlu.petshop.entity.UserAccount;
import lombok.*;

import java.util.List;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class UserDTO {
    private String id;
    private String username;
    private boolean status;
    private String name;
    private String email;
    private String phone;
    private String address;
    private String avt;
    private boolean isAdmin;
    private int price;
    private int quantity;
    private List<AdminRole> role;

    // Constructor chuyển từ Entity sang DTO
    public UserDTO(UserAccount user) {
        this.id = user.getId();
        this.username = user.getUsername();
        this.status = user.isStatus();
        this.name = user.getName();
        this.email = user.getEmail();
        this.phone = user.getPhone();
        this.address = user.getAddress();
        this.avt = user.getAvt();
        this.isAdmin = user.isAdmin();
        this.price = user.getPrice();
        this.quantity = user.getQuantity();
        this.role = user.getRole();
    }
}
