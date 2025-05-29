package com.nlu.petshop.service.impl;

import com.nlu.petshop.dto.request.CreateOrderRequestDTO;
import com.nlu.petshop.dto.response.OrderDTO;
import com.nlu.petshop.dto.response.OrderDetailDTO;
import com.nlu.petshop.dto.response.CartDTO;
import com.nlu.petshop.dto.response.CartItemDTO;
import com.nlu.petshop.entity.Order;
import com.nlu.petshop.entity.OrderDetail;
import com.nlu.petshop.entity.Product;
import com.nlu.petshop.entity.UserAccount;
import com.nlu.petshop.exception.NotEnoughStockException;
import com.nlu.petshop.exception.ProductNotFoundException;
import com.nlu.petshop.repository.OrderRepository;
import com.nlu.petshop.repository.ProductRepository;
import com.nlu.petshop.repository.UserAccountRepository;
import com.nlu.petshop.service.CartService;
import com.nlu.petshop.service.OrderService;
import jakarta.persistence.EntityNotFoundException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.stream.Collectors;

@Service
public class OrderServiceImpl implements OrderService {

    private final OrderRepository orderRepository;
    private final ProductRepository productRepository;
    private final UserAccountRepository userAccountRepository;
    private final CartService cartService;

    @Autowired
    public OrderServiceImpl(OrderRepository orderRepository,
                            ProductRepository productRepository,
                            UserAccountRepository userAccountRepository,
                            CartService cartService) {
        this.orderRepository = orderRepository;
        this.productRepository = productRepository;
        this.userAccountRepository = userAccountRepository;
        this.cartService = cartService;
    }

    private OrderDTO convertToOrderDTO(Order order) {
        if (order == null) {
            return null;
        }

        List<OrderDetailDTO> detailDTOs = order.getOrderDetails().stream()
                .map(detail -> new OrderDetailDTO(
                        detail.getProduct().getId(),
                        detail.getProductName(),
                        detail.getQuantity(),
                        detail.getPrice(),
                        detail.getQuantity() * detail.getPrice()))
                .collect(Collectors.toList());

        Long userId = (order.getUser() != null) ? order.getUser().getId() : null;

        return new OrderDTO(
                order.getId(),
                userId,
                order.getOrderDate(),
                order.getStatus(),
                order.getTotalAmount(),
                order.getCustomerName(),
                order.getShippingAddress(),
                order.getPhone(),
                order.getEmail(),
                order.getNote(),
                detailDTOs,
                order.getCreatedAt(),
                order.getUpdatedAt());
    }

    @Override
    @Transactional
    public OrderDTO createOrder(Long userId, CreateOrderRequestDTO requestDTO) {
        UserAccount user = userAccountRepository.findById(userId)
                .orElseThrow(() -> new EntityNotFoundException("error.user.notFound"));

        CartDTO cartDTO = cartService.getCartByUserId(userId);

        if (cartDTO.getItems() == null || cartDTO.getItems().isEmpty()) {
            throw new IllegalStateException("error.cart.empty");
        }

        Order order = new Order();
        order.setUser(user);
        order.setCustomerName(requestDTO.getCustomerName());
        order.setShippingAddress(requestDTO.getShippingAddress());
        order.setPhone(requestDTO.getPhone());
        order.setEmail(requestDTO.getEmail());
        order.setNote(requestDTO.getNote());

        double calculatedTotalAmount = 0;

        for (CartItemDTO cartItemDTO : cartDTO.getItems()) {
            Product product = productRepository.findById(cartItemDTO.getProductId())
                    .orElseThrow(() -> new ProductNotFoundException("error.product.notFound.with.id" + cartItemDTO.getProductId()));

            if (product.getQuantity() == null || product.getQuantity() < cartItemDTO.getQuantity()) {
                throw new NotEnoughStockException("error.product.notEnoughStock.with.name" + product.getName());
            }

            OrderDetail detail = new OrderDetail();
            detail.setOrder(order);
            detail.setProduct(product);
            detail.setProductName(product.getName());
            detail.setQuantity(cartItemDTO.getQuantity());
            detail.setPrice(cartItemDTO.getPriceAtAddition());
            order.getOrderDetails().add(detail);

            product.setQuantity(product.getQuantity() - cartItemDTO.getQuantity());
            productRepository.save(product);

            calculatedTotalAmount += cartItemDTO.getSubTotal();
        }

        order.setTotalAmount(calculatedTotalAmount);
        Order savedOrder = orderRepository.save(order);

        cartService.clearCart(userId);

        return convertToOrderDTO(savedOrder);
    }

    @Override
    @Transactional(readOnly = true)
    public Page<OrderDTO> getOrderHistoryForUser(Long userId, Pageable pageable) {
        userAccountRepository.findById(userId)
                .orElseThrow(() -> new EntityNotFoundException("error.user.notFound"));
        Page<Order> orderPage = orderRepository.findByUserIdOrderByOrderDateDesc(userId, pageable);
        return orderPage.map(this::convertToOrderDTO);
    }

    @Override
    @Transactional(readOnly = true)
    public OrderDTO getOrderDetailsForUser(Long userId, Long orderId) {
        userAccountRepository.findById(userId)
                .orElseThrow(() -> new EntityNotFoundException("error.user.notFound"));
        Order order = orderRepository.findById(orderId)
                .orElseThrow(() -> new EntityNotFoundException("error.order.notFound"));

        if (!order.getUser().getId().equals(userId)) {
            throw new SecurityException("error.order.accessDenied");
        }
        return convertToOrderDTO(order);
    }
}