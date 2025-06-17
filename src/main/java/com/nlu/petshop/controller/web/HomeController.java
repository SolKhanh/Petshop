package com.nlu.petshop.controller.web; // Hoặc package controller của bạn

import com.nlu.petshop.dto.response.CategoryDTO;
import com.nlu.petshop.dto.response.ProductDTO;
//import com.nlu.petshop.entity.UserAccount; // Entity UserAccount của bạn
import com.nlu.petshop.service.CategoryService;
import com.nlu.petshop.service.ProductService;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import java.util.List;

@Controller
public class HomeController {

    private final ProductService productService;
    private final CategoryService categoryService;

    @Autowired
    public HomeController(ProductService productService,
                          CategoryService categoryService) {
        this.productService = productService;
        this.categoryService = categoryService;
    }

    @GetMapping("/")
    public String homePage(Model model, HttpSession session) {
        // Lấy thông tin người dùng từ session (nếu có)
//        UserAccount user = (UserAccount) session.getAttribute("user"); // Tên attribute này cần khớp với khi bạn set lúc đăng nhập
//        if (user != null) {
//            model.addAttribute("user", user);
//        }
//
//        String orderNotice = (String) session.getAttribute("orderNotice");
//        if (orderNotice != null) {
//            model.addAttribute("orderNotice", orderNotice);
//            session.removeAttribute("orderNotice");
//        }

        Pageable topEight = PageRequest.of(0, 8, Sort.by(Sort.Direction.DESC, "createdAt")); // Lấy 8 sản phẩm mới nhất
        List<ProductDTO> bestProducts = productService.getAllProducts(topEight).getContent();
        model.addAttribute("bestProducts", bestProducts);

        // Lấy danh sách Categories (5 categories đầu tiên)
        // getTopCategories() trong CategoryService
        List<CategoryDTO> categories = categoryService.getAllCategories();
        model.addAttribute("categories", categories.size() > 5 ? categories.subList(0,5) : categories);



        return "index"; // Trả về tên file /WEB-INF/views/index.jsp
    }

    @GetMapping("/login")
    public String showLoginPage() {
        return "login"; // Trả về /WEB-INF/views/login.jsp
    }

    @GetMapping("/register")
    public String showRegisterPage() {
        return "register";
    }

    @GetMapping("/profile")
    public String showProfilePage() {
        return "profile";
    }

    @GetMapping("/cart")
    public String showCartPage() {
        return "cart";
    }

    @GetMapping("/order")
    public String showOrderPage() {
        return "order";
    }

    @GetMapping("/orderhistory")
    public String showOrdersPage() { return "orderhistory"; }
}