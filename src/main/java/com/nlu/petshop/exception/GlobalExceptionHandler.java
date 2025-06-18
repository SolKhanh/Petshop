package com.nlu.petshop.exception;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.MessageSource;
import org.springframework.context.i18n.LocaleContextHolder;
import org.springframework.validation.FieldError;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.HttpStatusCode;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.MethodArgumentNotValidException;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.context.request.WebRequest;
import org.springframework.web.servlet.mvc.method.annotation.ResponseEntityExceptionHandler;

import java.util.Date;
import java.util.HashMap;
import java.util.Locale;
import java.util.Map;
import java.util.stream.Collectors;

@ControllerAdvice
public class GlobalExceptionHandler extends ResponseEntityExceptionHandler {

    @Autowired
    private MessageSource messageSource;

    private Map<String, Object> createErrorBody(HttpStatus status, String resolvedMessage, String path) {
        Map<String, Object> body = new HashMap<>();
        body.put("timestamp", new Date().getTime());
        body.put("status", status.value());
        body.put("error", status.getReasonPhrase());
        body.put("message", resolvedMessage);
        body.put("path", path.replace("uri=", ""));
        return body;
    }

    private Map<String, Object> createErrorBody(String resolvedMessage, String path) {
        return createErrorBody(null, resolvedMessage, path );
    }

    @ExceptionHandler(ProductNotFoundException.class)
    public ResponseEntity<Object> handleProductNotFoundException(ProductNotFoundException ex, WebRequest request) {
        String errorMessage = messageSource.getMessage(ex.getMessage(), null, "Sản phẩm không tìm thấy.", LocaleContextHolder.getLocale());
        Map<String, Object> body = createErrorBody(HttpStatus.NOT_FOUND, errorMessage, request.getDescription(false));
        return new ResponseEntity<>(body, HttpStatus.NOT_FOUND);
    }

    @ExceptionHandler(NotEnoughStockException.class)
    public ResponseEntity<Object> handleNotEnoughStockException(NotEnoughStockException ex, WebRequest request) {
        String errorMessage = messageSource.getMessage(ex.getMessage(), null, "Không đủ hàng trong kho.", LocaleContextHolder.getLocale());
        Map<String, Object> body = createErrorBody(HttpStatus.BAD_REQUEST, errorMessage, request.getDescription(false));
        return new ResponseEntity<>(body, HttpStatus.BAD_REQUEST);
    }

    @ExceptionHandler(jakarta.persistence.EntityNotFoundException.class)
    public ResponseEntity<Object> handleJakartaEntityNotFoundException(jakarta.persistence.EntityNotFoundException ex, WebRequest request) {
        String messageKey = ex.getMessage() != null ? ex.getMessage() : "error.resource.notfound";
        String errorMessage = messageSource.getMessage(messageKey, null, "Không tìm thấy tài nguyên.", LocaleContextHolder.getLocale());
        Map<String, Object> body = createErrorBody(HttpStatus.NOT_FOUND, errorMessage, request.getDescription(false));
        return new ResponseEntity<>(body, HttpStatus.NOT_FOUND);
    }

    @Override
    protected ResponseEntity<Object> handleMethodArgumentNotValid(
            MethodArgumentNotValidException ex, HttpHeaders headers, HttpStatusCode status, WebRequest request) {
        Map<String, String> validationErrors = ex.getBindingResult().getFieldErrors().stream()
                .collect(Collectors.toMap(FieldError::getField, FieldError::getDefaultMessage));

        //  body response riêng cho validation
        Map<String, Object> body = new HashMap<>();
        body.put("timestamp", new Date().getTime());
        body.put("status", status.value());
        body.put("error", "Bad Request");
        body.put("message", "Dữ liệu đầu vào không hợp lệ.");
        body.put("errors", validationErrors);
        body.put("path", request.getDescription(false).replace("uri=", ""));

        return new ResponseEntity<>(body, headers, status);
    }

    @ExceptionHandler(Exception.class)
    public ResponseEntity<Object> handleGenericException(Exception ex, WebRequest request) {
        ex.printStackTrace();
        String errorMessage = messageSource.getMessage("error.generic", null, "Đã có lỗi xảy ra.", LocaleContextHolder.getLocale());
        Map<String, Object> body = createErrorBody(HttpStatus.INTERNAL_SERVER_ERROR, errorMessage, request.getDescription(false));
        return new ResponseEntity<>(body, HttpStatus.INTERNAL_SERVER_ERROR);
    }
}