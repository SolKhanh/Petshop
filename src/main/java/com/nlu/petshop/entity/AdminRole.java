package com.nlu.petshop.entity;

import jakarta.persistence.*;
import lombok.*;

import java.io.Serializable;

@Entity
@Table(name = "admin_roles")
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@ToString
public class AdminRole implements Serializable {

    @Id
    @Column(name = "table_name", nullable = false)
    private String tableName;

    @Column(name = "permission", nullable = false)
    private int permission;
}
