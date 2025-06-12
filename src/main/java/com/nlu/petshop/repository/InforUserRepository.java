package com.nlu.petshop.repository;

import com.nlu.petshop.entity.InforUser;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface InforUserRepository extends JpaRepository<InforUser, Long> {
}