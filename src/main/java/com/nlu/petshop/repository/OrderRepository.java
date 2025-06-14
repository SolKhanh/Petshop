package com.nlu.petshop.repository;

import com.nlu.petshop.entity.Order;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

@Repository
public interface OrderRepository extends JpaRepository<Order, Long> {
    Page<Order> findByUserIdOrderByOrderDateDesc(Long userId, Pageable pageable);
    @Query("SELECT CASE WHEN COUNT(o) > 0 THEN TRUE ELSE FALSE END " +
            "FROM Order o JOIN o.orderDetails od " +
            "WHERE o.user.id = :userId " +
            "AND od.product.id = :productId " +
            "AND o.status = com.nlu.petshop.model.OrderStatus.DELIVERED")
    boolean hasUserPurchasedProduct(@Param("userId") Long userId, @Param("productId") Integer productId);
}