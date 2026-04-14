package com.project.complaintsystem.controller;

import com.project.complaintsystem.model.Complaint;
import com.project.complaintsystem.service.CategoryService;
import com.project.complaintsystem.service.ComplaintService;
import com.project.complaintsystem.dto.ComplaintDTO;
import com.project.complaintsystem.security.CustomUserDetails;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.Map;

@Controller
@RequestMapping("/complaints")
public class ComplaintController {

    private final ComplaintService complaintService;
    private final CategoryService categoryService;

    public ComplaintController(ComplaintService complaintService, CategoryService categoryService) {
        this.complaintService = complaintService;
        this.categoryService = categoryService;
    }

    @GetMapping("/submit")
    public String showSubmitForm(Model model) {
        model.addAttribute("complaint", new Complaint());
        model.addAttribute("categories", categoryService.getAllCategories());

        return "user/submit-complaint";
    }

    @PostMapping("/submit")
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

    @GetMapping("/{id}")
    public String viewComplaintDetails(@PathVariable Long id,
                                       @AuthenticationPrincipal CustomUserDetails principal,
                                       Authentication authentication,
                                       Model model) {

        // Service returns complaint + timeline in a map
        Map<String, Object> details = complaintService.getComplaintDetails(id);
        Complaint complaint = (Complaint) details.get("complaint");

        // Security check: Ensure user owns this complaint OR user is an admin
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