package com.nlu.petshop.dto.request;

import lombok.Data;

@Data
public class UserProfileUpdateDTO {
    private String name;
    private String email;
    private String phone;
    private String address;
    private String avt;
}