package com.nlu.petshop.repository;

import com.nlu.petshop.entity.AdminRole;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface AdminRoleRepository extends JpaRepository<AdminRole, Long> {
    AdminRole findByUserIdAndTableNameAndPermission(String userId, String table, int permission);
    void deleteByUserIdAndTableNameAndPermission(String userId, String table, int permission);
}
