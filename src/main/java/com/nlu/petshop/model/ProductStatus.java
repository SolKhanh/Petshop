package com.nlu.petshop.model;

public enum ProductStatus {
    ACTIVE("Đang bán"),
    INACTIVE("Ngừng bán"),
    OUT_OF_STOCK("Hết hàng"),
    DELETED("Đã xóa");

    private final String displayName;

    ProductStatus(String displayName) {
        this.displayName = displayName;
    }

    public String getDisplayName() {
        return displayName;
    }
}
