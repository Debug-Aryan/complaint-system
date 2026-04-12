package com.project.complaintsystem.repository;

import com.project.complaintsystem.enums.UserRole;
import com.project.complaintsystem.model.Role;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.Optional;

@Repository
public interface RoleRepository extends JpaRepository<Role, Integer> {

    // Used to assign the default role during user registration
    Optional<Role> findByRoleName(UserRole roleName);
}