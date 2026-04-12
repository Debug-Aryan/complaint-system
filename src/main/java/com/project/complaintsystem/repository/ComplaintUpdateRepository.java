package com.project.complaintsystem.repository;

import com.project.complaintsystem.model.ComplaintUpdate;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface ComplaintUpdateRepository extends JpaRepository<ComplaintUpdate, Long> {

    // Fetch the update history for a specific complaint, showing the latest updates first
    List<ComplaintUpdate> findByComplaintIdOrderByUpdatedAtDesc(Long complaintId);
}