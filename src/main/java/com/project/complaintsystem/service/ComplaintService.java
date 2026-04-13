package com.project.complaintsystem.service;

import com.project.complaintsystem.dto.ComplaintDTO;
import com.project.complaintsystem.enums.ComplaintStatus;
import com.project.complaintsystem.model.Complaint;
import com.project.complaintsystem.model.ComplaintUpdate;

import java.util.List;
import java.util.Map;

public interface ComplaintService {

    // 📌 Create Complaint
    Complaint createComplaint(Long userId, ComplaintDTO complaintDTO);

    // 📋 Get User Complaints
    List<Complaint> getUserComplaints(Long userId);

    // 🌐 Get All Complaints (Admin)
    List<Complaint> getAllComplaints(ComplaintStatus status);

    // 🔄 Update Complaint Status (Admin)
    Complaint updateComplaintStatus(Long complaintId, Long adminId, ComplaintStatus newStatus, String remarks);

    // 🔍 Get Complaint Details (Includes History)
    Map<String, Object> getComplaintDetails(Long complaintId);
}