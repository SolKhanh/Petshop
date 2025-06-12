package com.nlu.petshop.dto.request;

import jakarta.validation.constraints.*;
import lombok.Data;

@Data
public class ProductCreateRequestDTO {
    @NotBlank(message = "Tên sản phẩm không được để trống")
    @Size(min = 3, max = 255, message = "Tên sản phẩm phải từ 3 đến 255 ký tự")
    private String name;

    @NotNull(message = "Giá sản phẩm không được để trống")
    @Positive(message = "Giá sản phẩm phải là số dương")
    private Double price;

    @Size(max = 500, message = "Mô tả ngắn không quá 500 ký tự")
    private String description;

    @NotNull(message = "Mô tả chi tiết không được để trống")
    private String detail;

    @NotNull(message = "Số lượng không được để trống")
    @Min(value = 0, message = "Số lượng không thể âm")
    private Integer quantity;

    @NotBlank(message = "Đường dẫn ảnh không được để trống")
    private String image; //

    private Double salePrice; //

    @NotBlank(message = "Trạng thái không được để trống")
    private String status; //"active", "inactive"

    private String giong;
    private String mausac;
    private String cannang;
    private String size;
    private Integer warranty; // bảo hành (tháng)

    @NotNull(message = "ID danh mục không được để trống")
    private Integer categoryId; //
}