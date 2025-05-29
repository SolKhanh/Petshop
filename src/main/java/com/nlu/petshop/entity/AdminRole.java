package com.nlu.petshop.entity;

import jakarta.persistence.*;
import lombok.*;

import java.io.Serializable;

@Entity
@Table(name = "adminpermission")
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@ToString
public class AdminRole implements Serializable {

    @EmbeddedId
    private AdminRoleId id;

    @Column(name = "permission", nullable = false)
    private int permission; // 1: thêm; 2: sửa; 3: xóa
}