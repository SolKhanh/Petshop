package com.nlu.petshop.entity;

import jakarta.persistence.*;
import lombok.Setter;

import java.io.Serializable;

@Entity
@Table(name = "user_role")
public class UserRole implements Serializable {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Setter
    @ManyToOne
    @JoinColumn(name = "user_id")
    private UserAccount user;

    @Setter
    @ManyToOne
    @JoinColumn(name = "role_id")
    private Role role;

    // Getters and Setters
}