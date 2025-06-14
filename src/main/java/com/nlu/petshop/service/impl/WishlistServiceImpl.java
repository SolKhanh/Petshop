package com.nlu.petshop.service.impl;

import com.nlu.petshop.dto.request.AddToWishlistRequestDTO;
import com.nlu.petshop.dto.response.WishlistDTO;
import com.nlu.petshop.dto.response.WishlistItemDTO;
import com.nlu.petshop.entity.*;
import com.nlu.petshop.exception.ProductNotFoundException;
import com.nlu.petshop.repository.*;
import com.nlu.petshop.service.WishlistService;
import jakarta.persistence.EntityNotFoundException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.stream.Collectors;

@Service
public class WishlistServiceImpl implements WishlistService {

    @Autowired private WishlistRepository wishlistRepository;
    @Autowired private WishlistItemRepository wishlistItemRepository;
    @Autowired private UserAccountRepository userAccountRepository;
    @Autowired private ProductRepository productRepository;

    private Wishlist getOrCreateWishlistByUserId(Long userId) {
        UserAccount user = userAccountRepository.findById(userId)
                .orElseThrow(() -> new EntityNotFoundException("error.user.notFound"));

        return wishlistRepository.findByUserId(userId).orElseGet(() -> {
            Wishlist newWishlist = new Wishlist(user);
            return wishlistRepository.save(newWishlist);
        });
    }

    private WishlistDTO convertToDTO(Wishlist wishlist) {
        List<WishlistItemDTO> itemDTOs = wishlist.getWishlistItems().stream()
                .map(item -> {
                    Product product = item.getProduct();
                    return new WishlistItemDTO(
                            product.getId(),
                            product.getName(),
                            product.getSalePrice() != null ? product.getSalePrice() : product.getPrice(),
                            product.getImage(),
                            product.getStatus().name(),
                            item.getAddedAt()
                    );
                })
                .collect(Collectors.toList());
        return new WishlistDTO(wishlist.getId(), wishlist.getUser().getId(), itemDTOs, itemDTOs.size());
    }

    @Override
    @Transactional(readOnly = true)
    public WishlistDTO getWishlistByUserId(Long userId) {
        Wishlist wishlist = getOrCreateWishlistByUserId(userId);
        return convertToDTO(wishlist);
    }

    @Override
    @Transactional
    public WishlistDTO addItemToWishlist(Long userId, AddToWishlistRequestDTO requestDTO) {
        Wishlist wishlist = getOrCreateWishlistByUserId(userId);
        Integer productId = requestDTO.getProductId();

        boolean itemExists = wishlist.getWishlistItems().stream()
                .anyMatch(item -> item.getProduct().getId().equals(productId));

        if (itemExists) {
            return convertToDTO(wishlist);
        }

        Product product = productRepository.findById(productId)
                .orElseThrow(() -> new ProductNotFoundException("error.product.notFound"));

        WishlistItem newItem = new WishlistItem(wishlist, product);
        wishlistItemRepository.save(newItem);

        // Cần tải lại wishlist để có item mới nhất
        Wishlist updatedWishlist = wishlistRepository.findById(wishlist.getId()).get();
        return convertToDTO(updatedWishlist);
    }

    @Override
    @Transactional
    public void removeItemFromWishlist(Long userId, Integer productId) {
        Wishlist wishlist = getOrCreateWishlistByUserId(userId);
        WishlistItem itemToRemove = wishlistItemRepository.findByWishlistIdAndProductId(wishlist.getId(), productId)
                .orElseThrow(() -> new EntityNotFoundException("Sản phẩm không có trong wishlist để xóa."));

        wishlistItemRepository.delete(itemToRemove);
    }
}