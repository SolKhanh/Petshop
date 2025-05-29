package com.nlu.petshop.entity;

import jakarta.persistence.Column;
import jakarta.persistence.Embeddable;
import lombok.*;

import java.io.Serializable;
import java.util.Objects;

@Embeddable
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@ToString
public class AdminRoleId implements Serializable {

    @Column(name = "id_user")
    private String idUser;

    @Column(name = "table_name")
    private String tableName;

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (!(o instanceof AdminRoleId)) return false;
        AdminRoleId that = (AdminRoleId) o;
        return Objects.equals(idUser, that.idUser) &&
                Objects.equals(tableName, that.tableName);
    }

    @Override
    public int hashCode() {
        return Objects.hash(idUser, tableName);
    }
}