package com.nlu.petshop.entity;

import jakarta.persistence.*;
import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.NoArgsConstructor;
import lombok.ToString;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

@Data
@NoArgsConstructor
@Entity
@Table(name = "carts")
public class Cart {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @OneToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "user_id", nullable = false, unique = true)
    @ToString.Exclude // tránh lặp UserAccount
    @EqualsAndHashCode.Exclude // tránh vấn đề lazy loading/proxy khi so sánh
    private UserAccount user;

    @Temporal(TemporalType.TIMESTAMP)
    @Column(name = "created_at", nullable = false, updatable = false)
    private Date createdAt;

    @Temporal(TemporalType.TIMESTAMP)
    @Column(name = "updated_at", nullable = false)
    private Date updatedAt;

    @OneToMany(mappedBy = "cart", cascade = CascadeType.ALL, orphanRemoval = true, fetch = FetchType.LAZY)
    @ToString.Exclude // khong in ds
    @EqualsAndHashCode.Exclude //
    private List<CartItem> cartItems = new ArrayList<>();

    public Cart(UserAccount user) {
        this.user = user;
    }

    @PrePersist
    protected void onCreate() {
        createdAt = new Date();
        updatedAt = new Date();
    }

    @PreUpdate
    protected void onUpdate() {
        updatedAt = new Date();
    }

    public void addCartItem(Product product, int quantity, double priceAtAddition) {
        CartItem item = new CartItem(this, product, quantity, priceAtAddition);
        this.cartItems.add(item);
    }

    public void removeCartItem(CartItem item) {
        if (item != null) {
            this.cartItems.remove(item);
            item.setCart(null);
        }
    }
}