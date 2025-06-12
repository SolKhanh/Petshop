package com.nlu.petshop.service;


import com.nlu.petshop.dto.request.CreateOrderRequestDTO;
import com.nlu.petshop.dto.response.OrderDTO;
import com.nlu.petshop.model.OrderStatus;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.transaction.annotation.Transactional;

public interface OrderService {

    OrderDTO createOrder(Long userId, CreateOrderRequestDTO requestDTO);

    Page<OrderDTO> getOrderHistoryForUser(Long userId, Pageable pageable);

    OrderDTO getOrderDetailsForUser(Long userId, Long orderId);
    //Admin
    Page<OrderDTO> getAllOrders(Pageable pageable);

    @Transactional(readOnly = true)
    OrderDTO getOrderById(Long orderId);

    OrderDTO updateOrderStatus(Long orderId, OrderStatus newStatus);
}