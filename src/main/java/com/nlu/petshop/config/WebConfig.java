package com.nlu.petshop.config;

import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.ViewResolverRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;
import org.springframework.web.servlet.config.annotation.ResourceHandlerRegistry;
import org.springframework.web.servlet.config.annotation.DefaultServletHandlerConfigurer;

@Configuration
public class WebConfig implements WebMvcConfigurer {

    // Cho phép DispatcherServlet xử lý yêu cầu mặc định nếu không tìm thấy controller
//    @Override
//    public void configureDefaultServletHandling(DefaultServletHandlerConfigurer configurer) {
//        configurer.enable();
//    }
}

