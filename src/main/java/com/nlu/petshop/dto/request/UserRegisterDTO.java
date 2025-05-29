package com.nlu.petshop.dto.request;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class UserRegisterDTO {
    private String username;
    private String password;
    private String email;
    private String name;
    private String phone;
    private String address;
    private String avatar;

}
