package com.project.complaintsystem.controller;

import com.project.complaintsystem.security.CustomUserDetails;
import com.project.complaintsystem.dto.ComplaintDTO;
import com.project.complaintsystem.model.Complaint;
import com.project.complaintsystem.service.CategoryService;
import com.project.complaintsystem.service.ComplaintService;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RequestMapping;

import java.util.Map;

@Controller
@RequestMapping("/user")
public class UserController {

    private final ComplaintService complaintService;
    private final CategoryService categoryService;

    public UserController(ComplaintService complaintService, CategoryService categoryService) {
        this.complaintService = complaintService;
        this.categoryService = categoryService;
    }

    @GetMapping("/dashboard")
    public String showDashboard(@AuthenticationPrincipal CustomUserDetails principal, Model model) {
        Long userId = principal.getId();
        model.addAttribute("recentComplaints", complaintService.getUserComplaints(userId));

        return "user/dashboard";
    }

    @GetMapping("/complaints")
    public String showMyComplaints(@AuthenticationPrincipal CustomUserDetails principal, Model model) {
        Long userId = principal.getId();
        model.addAttribute("complaints", complaintService.getUserComplaints(userId));

        return "user/my-complaints";
    }

    @GetMapping("/submit")
    public String showSubmitComplaintForm(Model model) {
        model.addAttribute("complaint", new Complaint());
        model.addAttribute("categories", categoryService.getAllCategories());
        return "user/submit-complaint";
    }

    @PostMapping("/complaints")
    public String submitComplaint(@ModelAttribute Complaint complaint,
                                  @RequestParam Integer categoryId,
                                  @AuthenticationPrincipal CustomUserDetails principal) {

        Long userId = principal.getId();

        ComplaintDTO dto = new ComplaintDTO();
        dto.setTitle(complaint.getTitle());
        dto.setDescription(complaint.getDescription());
        dto.setLocation(complaint.getLocation());
        dto.setCategoryId(categoryId);

        complaintService.createComplaint(userId, dto);
        return "redirect:/user/complaints";
    }

    @GetMapping("/complaints/{id}")
    public String viewComplaintDetails(@PathVariable Long id,
                                       @AuthenticationPrincipal CustomUserDetails principal,
                                       Authentication authentication,
                                       Model model) {

        Map<String, Object> details = complaintService.getComplaintDetails(id);
        Complaint complaint = (Complaint) details.get("complaint");

        Long currentUserId = principal.getId();
        boolean isAdmin = authentication.getAuthorities().stream()
                .anyMatch(a -> "ROLE_ADMIN".equals(a.getAuthority()));

        if (!complaint.getUser().getId().equals(currentUserId) && !isAdmin) {
            return "redirect:/user/dashboard";
        }

        model.addAttribute("complaint", complaint);
        model.addAttribute("updates", details.get("timeline"));
        model.addAttribute("timeline", details.get("timeline"));
        return "user/complaint-details";
    }
}