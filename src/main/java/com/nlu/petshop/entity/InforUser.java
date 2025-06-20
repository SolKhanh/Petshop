package com.nlu.petshop.entity;

import com.fasterxml.jackson.annotation.JsonIgnore;
import jakarta.persistence.*;
import jakarta.persistence.*;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
@Entity
@Table(name = "infor_user")
public class InforUser {

    @Id
    @Column(name = "id_user")
    private Long idUser;

    private String name;
    private String email;
    private String phone;
    private String address;
    @Column(length = 1024)
    private String avt;

    @OneToOne
    @MapsId
    @JoinColumn(name = "id_user")
    @JsonIgnore
    private UserAccount user;

    // Getters and Setters
}
