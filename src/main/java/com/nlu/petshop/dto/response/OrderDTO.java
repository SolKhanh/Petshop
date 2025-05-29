package com.nlu.petshop.dto.response;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import java.util.Date;
import java.util.List;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class OrderDTO {
    private Long id;
    private Long userId;
    private Date orderDate;
    private String status;
    private Double totalAmount;
    private String customerName;
    private String shippingAddress;
    private String phone;
    private String email;
    private String note;
    private List<OrderDetailDTO> items;
    private Date createdAt;
    private Date updatedAt;
}