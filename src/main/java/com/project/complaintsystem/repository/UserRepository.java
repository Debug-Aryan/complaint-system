package com.project.complaintsystem.repository;

import com.project.complaintsystem.model.User;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.Optional;

@Repository
public interface UserRepository extends JpaRepository<User, Long> {

    // Used for user login and Spring Security UserDetailsService
    Optional<User> findByEmail(String email);

    // Used to validate if an email is already registered
    boolean existsByEmail(String email);
}