package com.nlu.petshop.service.impl;


import com.nlu.petshop.dto.request.AddItemToCartRequestDTO;
import com.nlu.petshop.dto.request.UpdateCartItemRequestDTO;
import com.nlu.petshop.dto.response.CartDTO;
import com.nlu.petshop.dto.response.CartItemDTO;
import com.nlu.petshop.entity.Cart;
import com.nlu.petshop.entity.CartItem;
import com.nlu.petshop.entity.Product;
import com.nlu.petshop.entity.UserAccount;
import com.nlu.petshop.exception.ProductNotFoundException;
import com.nlu.petshop.exception.NotEnoughStockException;
import com.nlu.petshop.repository.CartItemRepository;
import com.nlu.petshop.repository.CartRepository;
import com.nlu.petshop.repository.ProductRepository;
import com.nlu.petshop.repository.UserAccountRepository;
import com.nlu.petshop.service.CartService;
import jakarta.persistence.EntityNotFoundException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.Optional;
import java.util.stream.Collectors;

@Service
public class CartServiceImpl implements CartService {

    private final CartRepository cartRepository;
    private final CartItemRepository cartItemRepository;
    private final ProductRepository productRepository;
    private final UserAccountRepository userAccountRepository;

    @Autowired
    public CartServiceImpl(CartRepository cartRepository,
                           CartItemRepository cartItemRepository,
                           ProductRepository productRepository,
                           UserAccountRepository userAccountRepository) {
        this.cartRepository = cartRepository;
        this.cartItemRepository = cartItemRepository;
        this.productRepository = productRepository;
        this.userAccountRepository = userAccountRepository;
    }

    private Cart getOrCreateCartByUserId(Long userId) {
        UserAccount user = userAccountRepository.findById(userId)
                .orElseThrow(() -> new EntityNotFoundException("error.user.notFound")); // Key cho messages.properties

        return cartRepository.findByUserId(userId).orElseGet(() -> {
            Cart newCart = new Cart(user);
            return cartRepository.save(newCart);
        });
    }

    private CartDTO convertCartToCartDTO(Cart cart) {
        if (cart == null) {
            return new CartDTO(null, (cart != null && cart.getUser() != null) ? cart.getUser().getId() : null, List.of(), 0.0, 0);
        }

        List<CartItemDTO> itemDTOs = cart.getCartItems().stream().map(cartItem -> {
            Product product = cartItem.getProduct();
            double currentPrice = product.getSalePrice() != null && product.getSalePrice() > 0 && product.getSalePrice() < product.getPrice()
                    ? product.getSalePrice()
                    : product.getPrice();
            return new CartItemDTO(
                    product.getId(),
                    product.getName(),
                    cartItem.getQuantity(),
                    cartItem.getPriceAtAddition(),
                    currentPrice,
                    product.getImage(),
                    cartItem.getQuantity() * cartItem.getPriceAtAddition()
            );
        }).collect(Collectors.toList());

        double totalAmount = itemDTOs.stream().mapToDouble(CartItemDTO::getSubTotal).sum();
        int totalItemsCount = itemDTOs.stream().mapToInt(CartItemDTO::getQuantity).sum();
        Long userId = (cart.getUser() != null) ? cart.getUser().getId() : null;

        return new CartDTO(cart.getId(), userId, itemDTOs, totalAmount, totalItemsCount);
    }

    @Override
    @Transactional(readOnly = true)
    public CartDTO getCartByUserId(Long userId) {
        Cart cart = getOrCreateCartByUserId(userId);
        return convertCartToCartDTO(cart);
    }

    @Override
    @Transactional
    public CartDTO addItemToCart(Long userId, AddItemToCartRequestDTO requestDTO) {
        Cart cart = getOrCreateCartByUserId(userId);
        Product product = productRepository.findById(requestDTO.getProductId())
                .orElseThrow(() -> new ProductNotFoundException("error.product.notFound"));

        if (!"active".equalsIgnoreCase(product.getStatus()) || product.getQuantity() == null || product.getQuantity() <= 0) {
            throw new NotEnoughStockException("error.product.outOfStock");
        }

        int requestedQuantity = requestDTO.getQuantity();

        Optional<CartItem> existingItemOpt = cart.getCartItems().stream()
                .filter(item -> item.getProduct().getId().equals(requestDTO.getProductId()))
                .findFirst();

        if (existingItemOpt.isPresent()) {
            CartItem existingItem = existingItemOpt.get();
            int newQuantity = existingItem.getQuantity() + requestedQuantity;
            if (product.getQuantity() < newQuantity) {
                throw new NotEnoughStockException("error.product.notEnoughStock");
            }
            existingItem.setQuantity(newQuantity);
            cartItemRepository.save(existingItem);
        } else {
            if (product.getQuantity() < requestedQuantity) {
                throw new NotEnoughStockException("error.product.notEnoughStock");
            }
            double priceToAdd = product.getSalePrice() != null && product.getSalePrice() > 0 && product.getSalePrice() < product.getPrice()
                    ? product.getSalePrice()
                    : product.getPrice();

            CartItem newItem = new CartItem(cart, product, requestedQuantity, priceToAdd);
            cart.getCartItems().add(newItem);
        }
        cartRepository.save(cart);
        return convertCartToCartDTO(cart);
    }

    @Override
    @Transactional
    public CartDTO updateCartItemQuantity(Long userId, Integer productId, UpdateCartItemRequestDTO requestDTO) {
        Cart cart = getOrCreateCartByUserId(userId);
        Product product = productRepository.findById(productId)
                .orElseThrow(() -> new ProductNotFoundException("error.product.notFound"));

        CartItem itemToUpdate = cart.getCartItems().stream()
                .filter(item -> item.getProduct().getId().equals(productId))
                .findFirst()
                .orElseThrow(() -> new EntityNotFoundException("error.cart.itemNotFound"));

        int newQuantity = requestDTO.getQuantity();
        if (newQuantity < 0) {
            throw new IllegalArgumentException("error.cart.invalidQuantity");
        }

        if (newQuantity == 0) {
            cart.removeCartItem(itemToUpdate);
        } else {
            if (product.getQuantity() < newQuantity) {
                throw new NotEnoughStockException("error.product.notEnoughStock");
            }
            itemToUpdate.setQuantity(newQuantity);
            cartItemRepository.save(itemToUpdate);
        }
        cartRepository.save(cart);
        return convertCartToCartDTO(cart);
    }

    @Override
    @Transactional
    public CartDTO removeItemFromCart(Long userId, Integer productId) {
        Cart cart = getOrCreateCartByUserId(userId);
        CartItem itemToRemove = cart.getCartItems().stream()
                .filter(item -> item.getProduct().getId().equals(productId))
                .findFirst()
                .orElseThrow(() -> new EntityNotFoundException("error.cart.itemNotFound"));

        cart.removeCartItem(itemToRemove);
        cartRepository.save(cart);
        return convertCartToCartDTO(cart);
    }

    @Override
    @Transactional
    public void clearCart(Long userId) {
        Cart cart = getOrCreateCartByUserId(userId);
        cart.getCartItems().clear();
        cartRepository.save(cart);
    }
}