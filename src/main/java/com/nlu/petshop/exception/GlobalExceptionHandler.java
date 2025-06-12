package com.nlu.petshop.exception;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.MessageSource;
import org.springframework.context.i18n.LocaleContextHolder;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.context.request.WebRequest;
import org.springframework.web.servlet.mvc.method.annotation.ResponseEntityExceptionHandler;

import java.util.Date;
import java.util.HashMap;
import java.util.Locale;
import java.util.Map;

@ControllerAdvice
public class GlobalExceptionHandler extends ResponseEntityExceptionHandler {

    @Autowired
    private MessageSource messageSource;

    private Map<String, Object> createErrorBody(String resolvedMessage, String path, Map<String, String> validationErrors) {
        Map<String, Object> body = new HashMap<>();
        body.put("timestamp", new Date().getTime());
        body.put("status", HttpStatus.NOT_FOUND.value());
        body.put("error", HttpStatus.NOT_FOUND.getReasonPhrase());
        body.put("message", resolvedMessage);
        if (validationErrors != null && !validationErrors.isEmpty()) {
            body.put("errors", validationErrors);
        }
        body.put("path", path.replace("uri=", ""));
        return body;
    }

    private Map<String, Object> createErrorBody(String resolvedMessage, String path) {
        return createErrorBody(resolvedMessage, path, null);
    }
    @ExceptionHandler(ProductNotFoundException.class)
    public ResponseEntity<Object> handleProductNotFoundException(ProductNotFoundException ex, WebRequest request) {
        System.out.println("abcdef: "); // LOG

        Locale locale = LocaleContextHolder.getLocale();
        String errorMessage = messageSource.getMessage(ex.getMessage(), null, "Product not found", locale);
        Map<String, Object> body = createErrorBody(errorMessage, request.getDescription(false));
        return new ResponseEntity<>(body, HttpStatus.NOT_FOUND);
    }
}