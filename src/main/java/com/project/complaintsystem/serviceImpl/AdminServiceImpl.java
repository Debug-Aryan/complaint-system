package com.project.complaintsystem.serviceImpl;

import com.project.complaintsystem.enums.ComplaintStatus;
import com.project.complaintsystem.model.Complaint;
import com.project.complaintsystem.repository.ComplaintRepository;
import com.project.complaintsystem.service.AdminService;
import com.project.complaintsystem.service.ComplaintService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
public class AdminServiceImpl implements AdminService {

    @Autowired
    private ComplaintRepository complaintRepository;

    @Autowired
    private ComplaintService complaintService;

    @Override
    public Map<String, Long> getDashboardStatistics() {
        Map<String, Long> stats = new HashMap<>();

        // 1. Total Complaints
        stats.put("totalComplaints", complaintRepository.count());

        // 2. Count by Status
        stats.put("pendingComplaints", complaintRepository.countByStatus(ComplaintStatus.PENDING));
        stats.put("inProgressComplaints", complaintRepository.countByStatus(ComplaintStatus.IN_PROGRESS));
        stats.put("resolvedComplaints", complaintRepository.countByStatus(ComplaintStatus.RESOLVED));
        stats.put("rejectedComplaints", complaintRepository.countByStatus(ComplaintStatus.REJECTED));

        return stats;
    }

    @Override
    public List<Complaint> getFilteredComplaints(ComplaintStatus status, Integer categoryId) {
        // Apply dynamic filters based on what the admin selects in the UI

        if (status != null && categoryId != null) {
            // Filter by BOTH Status and Category
            return complaintRepository.findByStatusAndCategoryIdOrderByCreatedAtDesc(status, categoryId);
        } else if (status != null) {
            // Filter ONLY by Status
            return complaintRepository.findByStatus(status);
        } else if (categoryId != null) {
            // Filter ONLY by Category
            return complaintRepository.findByCategoryIdOrderByCreatedAtDesc(categoryId);
        }

        // If no filters are applied, return all
        return complaintRepository.findAllByOrderByCreatedAtDesc();
    }

    @Override
    public Complaint processComplaint(Long complaintId, Long adminId, ComplaintStatus newStatus, String remarks) {
        // We delegate this to the ComplaintService because it already contains
        // the strict "@Transactional" logic and status validation rules we wrote earlier.
        // This keeps our Admin logic clean and prevents code duplication!
        return complaintService.updateComplaintStatus(complaintId, adminId, newStatus, remarks);
    }
}