package com.nlu.petshop.entity;

import jakarta.persistence.*;
import lombok.*;

import java.io.Serializable;
import java.util.List;

@Entity
@Table(name = "user_accounts")
@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class UserAccount implements Serializable {

    @Id
    @Column(name = "user_id")
    private String id;

    private String username;

    @Column(name = "encrypted_password")
    private String passMaHoa;

    @Transient
    private String pass; // không lưu field này vào DB

    private boolean status;
    private String name;
    private String email;
    private String phone;
    private String address;
    private String avt;

    @Column(name = "is_admin")
    private boolean isAdmin;

    private int price;
    private int quantity;

    @OneToMany(cascade = CascadeType.ALL, fetch = FetchType.LAZY)
    @JoinColumn(name = "user_id") // Liên kết một chiều, không có @ManyToOne ngược lại trong AdminRole
    private List<AdminRole> role;
}
