package com.nlu.petshop.controller.admin; // Đặt trong package admin để rõ ràng

import com.nlu.petshop.dto.request.OrderStatusUpdateRequestDTO;
import com.nlu.petshop.dto.response.OrderDTO;
import com.nlu.petshop.service.OrderService;
import jakarta.validation.Valid;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/api/admin/orders")

public class AdminOrderController {

    private final OrderService orderService;

    @Autowired
    public AdminOrderController(OrderService orderService) {
        this.orderService = orderService;
    }

    @GetMapping
    public ResponseEntity<Page<OrderDTO>> getAllOrders(
            @RequestParam(defaultValue = "0") int page,
            @RequestParam(defaultValue = "10") int size,
            @RequestParam(defaultValue = "orderDate,desc") String[] sort) {

        String sortField = sort[0];
        Sort.Direction direction = sort.length > 1 && sort[1].equalsIgnoreCase("asc") ? Sort.Direction.ASC : Sort.Direction.DESC;
        Pageable pageable = PageRequest.of(page, size, Sort.by(direction, sortField));

        Page<OrderDTO> orderPage = orderService.getAllOrders(pageable);
        return ResponseEntity.ok(orderPage);
    }

    @GetMapping("/{orderId}")
    public ResponseEntity<OrderDTO> getOrderDetailsForAdmin(@PathVariable Long orderId) {
        // Admin có thể xem bất kỳ đơn hàng nào, không cần userId
        OrderDTO order = orderService.getOrderById(orderId);
        return ResponseEntity.ok(order);
    }

    @PutMapping("/{orderId}/status")
    public ResponseEntity<OrderDTO> updateOrderStatus(
            @PathVariable Long orderId,
            @Valid @RequestBody OrderStatusUpdateRequestDTO statusUpdateDTO) {

        OrderDTO updatedOrder = orderService.updateOrderStatus(orderId, statusUpdateDTO.getNewStatus());
        return ResponseEntity.ok(updatedOrder);
    }
}
