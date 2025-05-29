package com.nlu.petshop.repository;

import com.nlu.petshop.entity.AdminRole;
import com.nlu.petshop.entity.AdminRoleId;
import org.springframework.data.jpa.repository.JpaRepository;

public interface AdminRoleRepository extends JpaRepository<AdminRole, AdminRoleId> {}
