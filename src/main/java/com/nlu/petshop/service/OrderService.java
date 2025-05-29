package com.nlu.petshop.service;


import com.nlu.petshop.dto.request.CreateOrderRequestDTO;
import com.nlu.petshop.dto.response.OrderDTO;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;

public interface OrderService {

    OrderDTO createOrder(Long userId, CreateOrderRequestDTO requestDTO);

    Page<OrderDTO> getOrderHistoryForUser(Long userId, Pageable pageable);

    OrderDTO getOrderDetailsForUser(Long userId, Long orderId);

    // Page<OrderDTO> getAllOrders(Pageable pageable);
    // OrderDTO updateOrderStatus(Long orderId, String newStatus);
}