package com.example.CICD.controller;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class BasicApi {

    @GetMapping("/hello")
    public String hello() {
        return "Hello, World!";
    }



}
