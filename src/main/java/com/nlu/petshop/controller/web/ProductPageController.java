package com.nlu.petshop.controller.web;

import com.nlu.petshop.dto.request.ProductFilterDTO;
import com.nlu.petshop.dto.response.ProductDTO;
import com.nlu.petshop.service.CategoryService;
import com.nlu.petshop.service.ProductService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.List;

@Controller
public class ProductPageController {
    private final ProductService productService;
    @Autowired
    private final CategoryService categoryService;

    @Autowired
    public ProductPageController(ProductService productService, CategoryService categoryService) {
        this.productService = productService;
         this.categoryService = categoryService;
    }
    @GetMapping("/shop")
    public String shopPage(
            Model model,
            @RequestParam(name = "page", defaultValue = "0") int page,
            @RequestParam(name = "size", defaultValue = "9") int size,
            @RequestParam(name = "sort", defaultValue = "name,asc") String[] sort,
            @RequestParam(name = "categoryId", required = false) Integer categoryId,
            @RequestParam(name = "minPrice", required = false) Double minPrice,
            @RequestParam(name = "maxPrice", required = false) Double maxPrice,
            @RequestParam(name = "search", required = false) String keyword
    ) {
        String sortField = sort[0];
        Sort.Direction direction = Sort.Direction.ASC;
        if (sort.length > 1 && sort[1].equalsIgnoreCase("desc")) {
            direction = Sort.Direction.DESC;
        }
        Pageable pageable = PageRequest.of(page, size, Sort.by(direction, sortField));

        ProductFilterDTO filter = new ProductFilterDTO();
        filter.setKeyword(keyword);
        filter.setCategoryId(categoryId);
        filter.setMinPrice(minPrice);
        filter.setMaxPrice(maxPrice);

        Page<ProductDTO> productPage = productService.searchAndFilterProducts(filter, pageable);

        model.addAttribute("productPage", productPage);
        model.addAttribute("pageTitle", "Sản phẩm");
        model.addAttribute("selectedCategoryId", categoryId);
        model.addAttribute("minPrice", minPrice);
        model.addAttribute("maxPrice", maxPrice);
        model.addAttribute("search", keyword);

        model.addAttribute("categories", categoryService.getAllCategories()); // << Thêm dòng này

        return "shop";
    }
    @GetMapping("/products/{productId}") // Ví dụ URL: /products/101
    public String productDetailPage(@PathVariable("productId") Integer productId, Model model /*, HttpSession session*/) {
        try {
            ProductDTO product = productService.getProductById(productId);
            model.addAttribute("product", product);
            model.addAttribute("pageTitle", product.getName()); // Đặt tiêu đề trang là tên sản phẩm

            // Lấy sản phẩm liên quan
            if (product.getCategoryId() != null) {
                Pageable relatedProductsPageable = PageRequest.of(0, 4, Sort.by(Sort.Direction.DESC, "createdAt"));
                List<ProductDTO> relatedProducts = productService.getProductsByCategoryId(product.getCategoryId(), relatedProductsPageable)
                        .getContent()
                        .stream()
                        .filter(p -> !p.getId().equals(productId)) // Loại trừ sản phẩm hiện tại
                        .collect(java.util.stream.Collectors.toList());
                model.addAttribute("relatedProducts", relatedProducts);
            }

            // Phần hình ảnh chi tiết (additionalImages) nếu có trong ProductDTO
            // model.addAttribute("productImages", product.getAdditionalImages());


            // Tạm thời chưa xử lý User, Comment, Lịch sử xem
            // UserAccount user = (UserAccount) session.getAttribute("user");
            // if (user != null) {
            // model.addAttribute("user", user);
            // }

        } catch (RuntimeException e) {
//            model.addAttribute("errorMessage", "Không tìm thấy sản phẩm bạn yêu cầu.");
//            return "error-page"; // Trả về một trang lỗi chung (bạn cần tạo error-page.jsp)
        }
        return "product-details"; // Trả về /WEB-INF/views/product-details.jsp
    }
}