package com.project.complaintsystem.service;

import com.project.complaintsystem.dto.ComplaintDTO;
import com.project.complaintsystem.enums.ComplaintStatus;
import com.project.complaintsystem.model.Complaint;
import com.project.complaintsystem.model.ComplaintUpdate;
import org.springframework.data.domain.Page;

import java.time.LocalDateTime;
import java.util.List;
import java.util.Map;

public interface ComplaintService {

    // 📌 Create Complaint
    Complaint createComplaint(Long userId, ComplaintDTO complaintDTO);

    // 📋 Get User Complaints
    List<Complaint> getUserComplaints(Long userId);

    // 🌐 Get All Complaints (Admin)
    List<Complaint> getAllComplaints(ComplaintStatus status);
    List<Complaint> getComplaintsByDateRange(LocalDateTime start, LocalDateTime end);
    List<Complaint> getFilteredComplaints(List<Long> categoryIds, List<String> statuses);

        Page<Complaint> getPaginatedComplaints(
            List<Long> categoryIds,
            List<String> statuses,
            int page,
            int size
        );

    // 🔄 Update Complaint Status (Admin)
    Complaint updateComplaintStatus(Long complaintId, Long adminId, ComplaintStatus newStatus, String remarks);

    // 🔍 Get Complaint Details (Includes History)
    Map<String, Object> getComplaintDetails(Long complaintId);
}