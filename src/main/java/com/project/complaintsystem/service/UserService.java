package com.project.complaintsystem.service;

import com.project.complaintsystem.model.User;

public interface UserService {
    User getUserProfile(Long userId);
    User updateProfile(Long userId, User updatedData);
}