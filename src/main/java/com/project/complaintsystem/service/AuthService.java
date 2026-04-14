package com.project.complaintsystem.service;

import com.project.complaintsystem.enums.UserRole;
import com.project.complaintsystem.model.User;

public interface AuthService {
    User registerUser(User user);
    
    User registerUser(User user, UserRole role);
}