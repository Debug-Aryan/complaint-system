package com.project.complaintsystem.controller;

import com.project.complaintsystem.model.Complaint;
import com.project.complaintsystem.service.CategoryService;
import com.project.complaintsystem.service.ComplaintService;
import com.project.complaintsystem.dto.ComplaintDTO;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.Map;

@Controller
@RequestMapping("/complaints")
public class ComplaintController {

    @Autowired
    private ComplaintService complaintService;

    @Autowired
    private CategoryService categoryService;

    @GetMapping("/submit")
    public String showSubmitForm(HttpSession session, Model model) {
        if (session.getAttribute("userId") == null) return "redirect:/login";

        model.addAttribute("complaint", new Complaint());
        model.addAttribute("categories", categoryService.getAllCategories());

        return "user/submit-complaint";
    }

    @PostMapping("/submit")
    public String submitComplaint(@ModelAttribute Complaint complaint,
                                  @RequestParam Integer categoryId,
                                  HttpSession session) {

        Long userId = (Long) session.getAttribute("userId");
        if (userId == null) return "redirect:/login";

        ComplaintDTO dto = new ComplaintDTO();
        dto.setTitle(complaint.getTitle());
        dto.setDescription(complaint.getDescription());
        dto.setLocation(complaint.getLocation());
        dto.setCategoryId(categoryId);

        complaintService.createComplaint(userId, dto);

        return "redirect:/user/complaints";
    }

    @GetMapping("/{id}")
    public String viewComplaintDetails(@PathVariable Long id, HttpSession session, Model model) {
        if (session.getAttribute("userId") == null) return "redirect:/login";

        // Service returns complaint + timeline in a map
        Map<String, Object> details = complaintService.getComplaintDetails(id);
        Complaint complaint = (Complaint) details.get("complaint");

        // Security check: Ensure user owns this complaint OR user is an admin
        Long sessionUserId = (Long) session.getAttribute("userId");
        String role = (String) session.getAttribute("role");

        if (!complaint.getUser().getId().equals(sessionUserId) && !"ADMIN".equals(role)) {
            return "redirect:/user/dashboard";
        }

        model.addAttribute("complaint", complaint);
        model.addAttribute("timeline", details.get("timeline"));
        return "shared/complaint-details";
    }
}