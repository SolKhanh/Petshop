package com.nlu.petshop.controller.api;

import com.nlu.petshop.dto.request.CreateOrderRequestDTO;
import com.nlu.petshop.dto.response.OrderDTO;
import com.nlu.petshop.entity.UserAccount;
import com.nlu.petshop.service.AuthService;
import com.nlu.petshop.service.OrderService;
import jakarta.validation.Valid;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/api/orders")
public class OrderRestController {

    private final OrderService orderService;
    private final AuthService authService;


    @Autowired
    public OrderRestController(OrderService orderService, AuthService authService) {
        this.orderService = orderService;
        this.authService = authService;
    }

    private Long getCurrentUserId() {
         return authService.getCurrentUser().getId();
    }


    @PostMapping
    public ResponseEntity<?> createOrder(@Valid @RequestBody CreateOrderRequestDTO requestDTO) {
            Long userId = getCurrentUserId();
            OrderDTO order = orderService.createOrder(userId, requestDTO);
            return ResponseEntity.status(HttpStatus.CREATED).body(order);
    }

    @GetMapping("/my-orders")
    public ResponseEntity<?> getMyOrderHistory(
            @RequestParam(defaultValue = "0") int page,
            @RequestParam(defaultValue = "10") int size,
            @RequestParam(defaultValue = "orderDate,desc") String[] sort) {
            Long userId = getCurrentUserId();

            String sortField = sort[0];
            Sort.Direction direction = Sort.Direction.DESC;
            if (sort.length > 1 && sort[1].equalsIgnoreCase("asc")) {
                direction = Sort.Direction.ASC;
            }
            Pageable pageable = PageRequest.of(page, size, Sort.by(direction, sortField));

            Page<OrderDTO> orderPage = orderService.getOrderHistoryForUser(userId, pageable);
            return ResponseEntity.ok(orderPage);
    }

    @GetMapping("/{orderId}")
    public ResponseEntity<?> getMyOrderDetails(@PathVariable Long orderId) {
            Long userId = getCurrentUserId();
            OrderDTO order = orderService.getOrderDetailsForUser(userId, orderId);
            return ResponseEntity.ok(order);
    }
}