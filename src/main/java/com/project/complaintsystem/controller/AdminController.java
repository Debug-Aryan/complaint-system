package com.project.complaintsystem.controller;

import com.project.complaintsystem.enums.ComplaintStatus;
import com.project.complaintsystem.security.CustomUserDetails;
import com.project.complaintsystem.service.AdminService;
import com.project.complaintsystem.service.ComplaintService;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.security.core.annotation.AuthenticationPrincipal;

import java.util.Map;

@Controller
@RequestMapping("/admin")
public class AdminController {

    private final AdminService adminService;
    private final ComplaintService complaintService;

    public AdminController(AdminService adminService, ComplaintService complaintService) {
        this.adminService = adminService;
        this.complaintService = complaintService;
    }

    @GetMapping("/dashboard")
    public String showDashboard(Model model) {
        Map<String, Long> stats = adminService.getDashboardStatistics();
        model.addAttribute("stats", stats);

        model.addAttribute("totalComplaints", stats.getOrDefault("totalComplaints", 0L));
        model.addAttribute("pendingCount", stats.getOrDefault("pendingComplaints", 0L));
        model.addAttribute("resolvedCount", stats.getOrDefault("resolvedComplaints", 0L));

        // Backward-compatible names used by some JSPs
        model.addAttribute("pendingComplaints", stats.getOrDefault("pendingComplaints", 0L));
        model.addAttribute("inProgressComplaints", stats.getOrDefault("inProgressComplaints", 0L));
        model.addAttribute("resolvedComplaints", stats.getOrDefault("resolvedComplaints", 0L));
        model.addAttribute("rejectedComplaints", stats.getOrDefault("rejectedComplaints", 0L));
        return "admin/admin-dashboard";
    }

    @GetMapping("/complaints")
    public String manageComplaints(Model model) {
        // No filter selected in UI -> fetch all
        model.addAttribute("complaints", complaintService.getAllComplaints(null));
        return "admin/manage-complaints";
    }

    @GetMapping("/complaints/{id}")
    public String viewComplaintDetails(@PathVariable Long id, Model model) {
        var details = complaintService.getComplaintDetails(id);
        model.addAttribute("complaint", details.get("complaint"));
        model.addAttribute("updates", details.get("timeline"));
        model.addAttribute("timeline", details.get("timeline"));
        return "admin/complaint-details";
    }

    @PostMapping("/complaints/update")
    public String updateComplaintStatus(@RequestParam Long complaintId,
                                        @RequestParam ComplaintStatus status,
                                        @RequestParam String remarks,
                                        @AuthenticationPrincipal CustomUserDetails principal) {

        Long adminId = principal.getId();
        complaintService.updateComplaintStatus(complaintId, adminId, status, remarks);

        return "redirect:/admin/complaints";
    }

    @PostMapping("/complaints/{id}/update")
    public String updateComplaintStatusByPath(@PathVariable Long id,
                                              @RequestParam ComplaintStatus status,
                                              @RequestParam String remarks,
                                              @AuthenticationPrincipal CustomUserDetails principal) {

        Long adminId = principal.getId();
        complaintService.updateComplaintStatus(id, adminId, status, remarks);

        return "redirect:/admin/complaints";
    }
}