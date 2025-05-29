package com.nlu.petshop.controller.web;

import com.nlu.petshop.dto.response.ProductDTO;
import com.nlu.petshop.service.ProductService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
public class ProductPageController {
    private final ProductService productService;
    // private final CategoryService categoryService;

    @Autowired
    public ProductPageController(ProductService productService) {
        this.productService = productService;
        // this.categoryService = categoryService;
    }
    @GetMapping("/shop") // Hoặc URL bạn muốn cho trang danh sách sản phẩm
    public String shopPage(
            Model model,
            @RequestParam(name = "page", defaultValue = "0") int page, // Tham số trang, mặc định là trang 0
            @RequestParam(name = "size", defaultValue = "9") int size,  // Số sản phẩm mỗi trang, mặc định là 9
            @RequestParam(name = "sort", defaultValue = "name,asc") String[] sort, // Tham số sắp xếp, ví dụ: name,asc hoặc price,desc
            @RequestParam(name = "categoryId", required = false) Integer categoryId // Tham số categoryId (tùy chọn)
            // Thêm các tham số khác nếu bạn có filter theo giá, size, etc.
    ) {
        // Xử lý sắp xếp
        // Mặc định sort[0] là trường sắp xếp, sort[1] là hướng (asc/desc)
        String sortField = sort[0];
        Sort.Direction direction = Sort.Direction.ASC; // Mặc định tăng dần
        if (sort.length > 1 && sort[1].equalsIgnoreCase("desc")) {
            direction = Sort.Direction.DESC;
        }
        Sort sortOrder = Sort.by(direction, sortField);

        Pageable pageable = PageRequest.of(page, size, sortOrder);

        Page<ProductDTO> productPage;

        if (categoryId != null) {
            // Nếu có categoryId, lọc sản phẩm theo category
            productPage = productService.getProductsByCategoryId(categoryId, pageable);
            model.addAttribute("selectedCategoryId", categoryId); // Để JSP biết category nào đang được chọn
        } else {
            // Nếu không, lấy tất cả sản phẩm
            productPage = productService.getAllProducts(pageable);
        }

        model.addAttribute("productPage", productPage); // Đưa đối tượng Page vào model
        model.addAttribute("pageTitle", "Cửa hàng sản phẩm");

        // model.addAttribute("categories", categoryService.getAllCategories());

        return "shop";
    }
//    @GetMapping("/products/{productId}") // Ví dụ URL: /products/101
//    public String productDetailPage(@PathVariable("productId") Integer productId, Model model /*, HttpSession session*/) {
//        try {
//            ProductDTO product = productService.getProductById(productId);
//            model.addAttribute("product", product);
//            model.addAttribute("pageTitle", product.getName()); // Đặt tiêu đề trang là tên sản phẩm
//
//            // Lấy sản phẩm liên quan
//            if (product.getCategoryId() != null) {
//                Pageable relatedProductsPageable = PageRequest.of(0, 4, Sort.by(Sort.Direction.DESC, "createdAt"));
//                List<ProductDTO> relatedProducts = productService.getProductsByCategoryId(product.getCategoryId(), relatedProductsPageable)
//                        .getContent()
//                        .stream()
//                        .filter(p -> !p.getId().equals(productId)) // Loại trừ sản phẩm hiện tại
//                        .collect(java.util.stream.Collectors.toList());
//                model.addAttribute("relatedProducts", relatedProducts);
//            }
//
//            // Phần hình ảnh chi tiết (additionalImages) nếu có trong ProductDTO
//            // model.addAttribute("productImages", product.getAdditionalImages());
//
//
//            // Tạm thời chưa xử lý User, Comment, Lịch sử xem
//            // UserAccount user = (UserAccount) session.getAttribute("user");
//            // if (user != null) {
//            // model.addAttribute("user", user);
//            // }
//
//        } catch (RuntimeException e) {
////            model.addAttribute("errorMessage", "Không tìm thấy sản phẩm bạn yêu cầu.");
////            return "error-page"; // Trả về một trang lỗi chung (bạn cần tạo error-page.jsp)
//        }
//        return "product-details"; // Trả về /WEB-INF/views/product-details.jsp
//    }
}