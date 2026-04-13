package com.project.complaintsystem.serviceImpl;

import com.project.complaintsystem.exception.ResourceNotFoundException;
import com.project.complaintsystem.model.User;
import com.project.complaintsystem.repository.UserRepository;
import com.project.complaintsystem.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class UserServiceImpl implements UserService {

    @Autowired
    private UserRepository userRepository;

    @Override
    public User getUserProfile(Long userId) {
        return userRepository.findById(userId)
                .orElseThrow(() -> new ResourceNotFoundException("User profile not found."));
    }

    @Override
    public User updateProfile(Long userId, User updatedData) {
        User existingUser = getUserProfile(userId);

        // Update allowable fields (preventing role/email changes here for security)
        existingUser.setFullName(updatedData.getFullName());
        existingUser.setPhoneNumber(updatedData.getPhoneNumber());

        return userRepository.save(existingUser);
    }
}