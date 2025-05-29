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

}