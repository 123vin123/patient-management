package com.pm.authservice;

import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;

public class Solution {
    public static void main(String[] args) {
        BCryptPasswordEncoder encoder = new BCryptPasswordEncoder();
        System.out.println(encoder.encode("password123"));
    }
}
