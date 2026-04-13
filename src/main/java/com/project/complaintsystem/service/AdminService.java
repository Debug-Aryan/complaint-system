package com.project.complaintsystem.service;

import com.project.complaintsystem.enums.ComplaintStatus;
import com.project.complaintsystem.model.Complaint;

import java.util.List;
import java.util.Map;

public interface AdminService {

    // 📊 Dashboard Statistics
    Map<String, Long> getDashboardStatistics();

    // 📋 Manage Complaints (with Filters)
    List<Complaint> getFilteredComplaints(ComplaintStatus status, Integer categoryId);

    // 📝 Add Remarks / Assign
    // (Note: We reuse the robust logic we built in ComplaintService for this)
    Complaint processComplaint(Long complaintId, Long adminId, ComplaintStatus newStatus, String remarks);
}