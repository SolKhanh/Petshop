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

    // PHƯƠNG THỨC TẠM THỜI ĐỂ LẤY USER ID - CẦN THAY THẾ BẰNG SPRING SECURITY SAU NÀY
    private Long getCurrentUserId() {
         return 1L;
    }


    @PostMapping
    public ResponseEntity<?> createOrder(@Valid @RequestBody CreateOrderRequestDTO requestDTO) {
        try {
            Long userId = getCurrentUserId();
            OrderDTO order = orderService.createOrder(userId, requestDTO);
            return ResponseEntity.status(HttpStatus.CREATED).body(order);
        } catch (IllegalStateException e) {
            return ResponseEntity.status(HttpStatus.UNAUTHORIZED).body(e.getMessage());
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.BAD_REQUEST).body(e.getMessage());
        }
    }

    @GetMapping("/my-orders")
    public ResponseEntity<?> getMyOrderHistory(
            @RequestParam(defaultValue = "0") int page,
            @RequestParam(defaultValue = "10") int size,
            @RequestParam(defaultValue = "orderDate,desc") String[] sort) {
        try {
            Long userId = getCurrentUserId();

            String sortField = sort[0];
            Sort.Direction direction = Sort.Direction.DESC;
            if (sort.length > 1 && sort[1].equalsIgnoreCase("asc")) {
                direction = Sort.Direction.ASC;
            }
            Pageable pageable = PageRequest.of(page, size, Sort.by(direction, sortField));

            Page<OrderDTO> orderPage = orderService.getOrderHistoryForUser(userId, pageable);
            return ResponseEntity.ok(orderPage);
        } catch (IllegalStateException e) {
            return ResponseEntity.status(HttpStatus.UNAUTHORIZED).body(e.getMessage());
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("Lỗi khi lấy lịch sử đơn hàng.");
        }
    }

    @GetMapping("/{orderId}")
    public ResponseEntity<?> getMyOrderDetails(@PathVariable Long orderId) {
        try {
            Long userId = getCurrentUserId();
            OrderDTO order = orderService.getOrderDetailsForUser(userId, orderId);
            return ResponseEntity.ok(order);
        } catch (IllegalStateException e) {
            return ResponseEntity.status(HttpStatus.UNAUTHORIZED).body(e.getMessage());
        } catch (SecurityException se) {
            return ResponseEntity.status(HttpStatus.FORBIDDEN).body(se.getMessage());
        }
        catch (Exception e) {
            return ResponseEntity.status(HttpStatus.NOT_FOUND).body(e.getMessage());
        }
    }
}