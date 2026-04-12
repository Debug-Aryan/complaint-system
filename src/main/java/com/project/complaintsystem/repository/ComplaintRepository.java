package com.project.complaintsystem.repository;

import com.project.complaintsystem.enums.ComplaintStatus;
import com.project.complaintsystem.model.Complaint;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface ComplaintRepository extends JpaRepository<Complaint, Long> {

    // For Citizens: Fetch all complaints they have submitted, newest first
    List<Complaint> findByUserIdOrderByCreatedAtDesc(Long userId);

    // For Admins: Filter complaints by their current status (e.g., all PENDING)
    List<Complaint> findByStatus(ComplaintStatus status);

    // For Admins: Get all complaints across the system, newest first
    List<Complaint> findAllByOrderByCreatedAtDesc();
}