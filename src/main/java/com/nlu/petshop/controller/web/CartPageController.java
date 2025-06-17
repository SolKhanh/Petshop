package com.nlu.petshop.controller.web;

import com.nlu.petshop.dto.response.CartDTO;
import com.nlu.petshop.service.CartService;
import com.nlu.petshop.service.impl.CartServiceImpl;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class CartPageController {

    private final CartService cartService;

    @Autowired
    public CartPageController(CartService cartService) {
        this.cartService = cartService;
    }

    // Phương thức này sẽ lấy giỏ hàng của người dùng
//    @GetMapping("/cart")
//    public String viewCartPage(Model model) {
//        try {
//            Long userId = 1L; // Sử dụng id người dùng hiện tại (cần thay thế bằng Spring Security sau)
//            CartDTO cart = cartService.getCartByUserId(userId);
//            model.addAttribute("cart", cart); // Chuyển giỏ hàng vào model
//            return "cart"; // Trả về trang cart.jsp
//        } catch (Exception e) {
//            model.addAttribute("errorMessage", "Lỗi khi lấy giỏ hàng.");
//            return "login"; // Trả về trang lỗi nếu có lỗi xảy ra
//        }
//    }
}