package com.project.complaintsystem.serviceImpl;

import com.project.complaintsystem.dto.ComplaintDTO;
import com.project.complaintsystem.enums.ComplaintStatus;
import com.project.complaintsystem.exception.BadRequestException;
import com.project.complaintsystem.exception.ResourceNotFoundException;
import com.project.complaintsystem.model.Category;
import com.project.complaintsystem.model.Complaint;
import com.project.complaintsystem.model.ComplaintUpdate;
import com.project.complaintsystem.model.User;
import com.project.complaintsystem.repository.CategoryRepository;
import com.project.complaintsystem.repository.ComplaintRepository;
import com.project.complaintsystem.repository.ComplaintUpdateRepository;
import com.project.complaintsystem.repository.UserRepository;
import com.project.complaintsystem.service.ComplaintService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.LocalDateTime;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
public class ComplaintServiceImpl implements ComplaintService {

    @Autowired
    private ComplaintRepository complaintRepository;

    @Autowired
    private ComplaintUpdateRepository updateRepository;

    @Autowired
    private UserRepository userRepository;

    @Autowired
    private CategoryRepository categoryRepository;

    @Override
    @Transactional // Ensures both Complaint and History are saved, or both fail together
    public Complaint createComplaint(Long userId, ComplaintDTO dto) {

        // 1. Get logged-in user
        User user = userRepository.findById(userId)
                .orElseThrow(() -> new ResourceNotFoundException("User not found."));

        // 2. Fetch category
        Category category = categoryRepository.findById(dto.getCategoryId())
                .orElseThrow(() -> new ResourceNotFoundException("Category not found."));

        // 3. Create Complaint
        Complaint complaint = new Complaint();
        complaint.setUser(user);
        complaint.setCategory(category);
        complaint.setTitle(dto.getTitle());
        complaint.setDescription(dto.getDescription());
        complaint.setLocation(dto.getLocation());
        complaint.setStatus(ComplaintStatus.PENDING); // Set default status

        // 4. Save complaint
        Complaint savedComplaint = complaintRepository.save(complaint);

        // 5. Create initial update in history tracking
        createHistoryRecord(savedComplaint, user, ComplaintStatus.PENDING, "Complaint registered successfully.");

        return savedComplaint;
    }

    @Override
    public List<Complaint> getUserComplaints(Long userId) {
        // Find complaints by user and sort latest first
        return complaintRepository.findByUserIdOrderByCreatedAtDesc(userId);
    }

    @Override
    public List<Complaint> getAllComplaints(ComplaintStatus status) {
        // Optional filter by status for Admin
        if (status != null) {
            return complaintRepository.findByStatus(status);
        }
        return complaintRepository.findAllByOrderByCreatedAtDesc();
    }

    @Override
    public List<Complaint> getFilteredComplaints(List<Long> categoryIds, List<String> statuses) {
        List<ComplaintStatus> statusEnumList = null;
        if (statuses != null && !statuses.isEmpty()) {
            statusEnumList = statuses.stream()
                    .map(ComplaintStatus::valueOf)
                    .collect(java.util.stream.Collectors.toList());
        }
        
        // If lists are passed as empty instead of null, let's treat them as null for query
        List<Long> finalCategoryIds = (categoryIds == null || categoryIds.isEmpty()) ? null : categoryIds;
        List<ComplaintStatus> finalStatuses = (statusEnumList == null || statusEnumList.isEmpty()) ? null : statusEnumList;
        
        return complaintRepository.findFilteredComplaints(finalCategoryIds, finalStatuses);
    }

    @Override
    @Transactional
    public Complaint updateComplaintStatus(Long complaintId, Long adminId, ComplaintStatus newStatus, String remarks) {

        // 1. Fetch complaint and admin
        Complaint complaint = complaintRepository.findById(complaintId)
                .orElseThrow(() -> new ResourceNotFoundException("Complaint not found."));

        User admin = userRepository.findById(adminId)
                .orElseThrow(() -> new ResourceNotFoundException("Admin not found."));

        // 2. Validate status transition (Prevent invalid jumps)
        validateStatusTransition(complaint.getStatus(), newStatus);

        // 3. Update complaint
        complaint.setStatus(newStatus);
        Complaint updatedComplaint = complaintRepository.save(complaint);

        // 4. Add update entry with remarks
        createHistoryRecord(updatedComplaint, admin, newStatus, remarks);

        return updatedComplaint;
    }

    @Override
    public Map<String, Object> getComplaintDetails(Long complaintId) {
        // 1. Fetch Complaint
        Complaint complaint = complaintRepository.findById(complaintId)
                .orElseThrow(() -> new ResourceNotFoundException("Complaint not found."));

        // 2. Fetch History Timeline
        List<ComplaintUpdate> updates = updateRepository.findByComplaintIdOrderByUpdatedAtDesc(complaintId);

        // 3. Combine and return
        Map<String, Object> response = new HashMap<>();
        response.put("complaint", complaint);
        response.put("timeline", updates);

        return response;
    }

    // ==========================================
    // HELPER METHODS
    // ==========================================

    private void createHistoryRecord(Complaint complaint, User user, ComplaintStatus status, String remarks) {
        ComplaintUpdate update = new ComplaintUpdate();
        update.setComplaint(complaint);
        update.setUpdatedBy(user);
        update.setStatusChangedTo(status);
        update.setRemarks(remarks);
        updateRepository.save(update);
    }

    private void validateStatusTransition(ComplaintStatus currentStatus, ComplaintStatus newStatus) {
        if (currentStatus == newStatus) {
            throw new BadRequestException("Complaint is already in " + newStatus + " status.");
        }

        // Once resolved or rejected, no further changes are allowed
        if (currentStatus == ComplaintStatus.RESOLVED || currentStatus == ComplaintStatus.REJECTED) {
            throw new BadRequestException("Cannot update status. Complaint is already closed.");
        }

        // Must-go from PENDING to IN_PROGRESS before being RESOLVED
        if (currentStatus == ComplaintStatus.PENDING && newStatus == ComplaintStatus.RESOLVED) {
            throw new BadRequestException("Invalid transition. Complaint must be moved to IN_PROGRESS before being RESOLVED.");
        }
    }
    @Override
    public List<Complaint> getComplaintsByDateRange(LocalDateTime start, LocalDateTime end) {
        return complaintRepository.findByCreatedAtBetween(start, end);
    }
}