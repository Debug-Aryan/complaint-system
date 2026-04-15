package com.project.complaintsystem.controller;

import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.CellStyle;
import org.apache.poi.ss.usermodel.Font;
import com.project.complaintsystem.enums.ComplaintStatus;
import com.project.complaintsystem.security.CustomUserDetails;
import com.project.complaintsystem.service.AdminService;
import com.project.complaintsystem.service.ComplaintService;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;

import java.time.LocalDate;
import java.util.List;
import com.project.complaintsystem.model.Complaint;

import com.fasterxml.jackson.databind.ObjectMapper;
import jakarta.servlet.http.HttpServletResponse;   // ✅ FIXED IMPORT

import java.time.LocalDateTime;
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

    // ================= DASHBOARD =================

    @GetMapping("/dashboard")
    public String showDashboard(Model model) {
        Map<String, Long> stats = adminService.getDashboardStatistics();

        model.addAttribute("stats", stats);
        model.addAttribute("totalComplaints", stats.getOrDefault("totalComplaints", 0L));
        model.addAttribute("pendingCount", stats.getOrDefault("pendingComplaints", 0L));
        model.addAttribute("resolvedCount", stats.getOrDefault("resolvedComplaints", 0L));

        model.addAttribute("pendingComplaints", stats.getOrDefault("pendingComplaints", 0L));
        model.addAttribute("inProgressComplaints", stats.getOrDefault("inProgressComplaints", 0L));
        model.addAttribute("resolvedComplaints", stats.getOrDefault("resolvedComplaints", 0L));
        model.addAttribute("rejectedComplaints", stats.getOrDefault("rejectedComplaints", 0L));

        return "admin/admin-dashboard";
    }

    // ================= COMPLAINT MANAGEMENT =================

    @GetMapping("/complaints")
    public String manageComplaints(Model model) {
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

    // ================= REPORTS PAGE =================

    @GetMapping("/reports")
    public String showReportsPage(Model model) throws Exception {

        ObjectMapper mapper = new ObjectMapper();

        // 🥧 Pie Chart
        model.addAttribute("statusStatsJson",
                mapper.writeValueAsString(adminService.getComplaintStatusStats()));

        // 📊 Bar Chart
        model.addAttribute("categoryStatsJson",
                mapper.writeValueAsString(adminService.getCategoryStats()));

        // 📈 Line Chart (Monthly)
        model.addAttribute("monthlyStatsJson",
                mapper.writeValueAsString(adminService.getDailyTrendsCurrentMonth()));

        // ⚠️ KEEP (used for filter + CSV)
        model.addAttribute("trendStatsJson",
                mapper.writeValueAsString(adminService.getComplaintTrends()));

        return "admin/reports";
    }

    // ================= FILTER (AJAX) =================

//    @PostMapping("/reports/filter")
//    @ResponseBody
//    public Map<String, Long> getFilteredData(
//            @RequestParam String from,
//            @RequestParam String to) {
//
//        LocalDateTime start = LocalDateTime.parse(from);
//        LocalDateTime end = LocalDateTime.parse(to);
//
//        return adminService.getComplaintTrendsByDateRange(start, end);
//    }

    // ================= DOWNLOAD CSV =================

    @GetMapping("/reports/download")
    public void downloadExcel(
            @RequestParam String from,
            @RequestParam String to,
            HttpServletResponse response) throws Exception {

        LocalDate startDate = LocalDate.parse(from);
        LocalDate endDate = LocalDate.parse(to);

        LocalDateTime start = startDate.atStartOfDay();
        LocalDateTime end = endDate.atTime(23, 59, 59);



        response.setContentType("application/vnd.openxmlformats-officedocument.spreadsheetml.sheet");
        response.setHeader("Content-Disposition", "attachment; filename=complaint_report.xlsx");

        Workbook workbook = new XSSFWorkbook();
        Sheet sheet = workbook.createSheet("Report");

        int rowNum = 0;

// ===== STYLES =====
        CellStyle titleStyle = workbook.createCellStyle();
        Font titleFont = workbook.createFont();
        titleFont.setBold(true);
        titleFont.setFontHeightInPoints((short) 16);
        titleStyle.setFont(titleFont);

        CellStyle headerStyle = workbook.createCellStyle();
        Font headerFont = workbook.createFont();
        headerFont.setBold(true);
        headerStyle.setFont(headerFont);

// ================= TITLE =================
        Row title = sheet.createRow(rowNum++);
        Cell titleCell = title.createCell(0);
        titleCell.setCellValue("SMART COMPLAINT SYSTEM REPORT");
        titleCell.setCellStyle(titleStyle);

        rowNum++; // space

// ================= SUMMARY =================
        Map<String, Long> summary = adminService.getDashboardStatistics();

        long total = summary.getOrDefault("totalComplaints", 0L);
        long resolved = summary.getOrDefault("resolvedComplaints", 0L);
        double rate = (total == 0) ? 0 : (resolved * 100.0 / total);

// Section Title
        Row summaryTitle = sheet.createRow(rowNum++);
        Cell st = summaryTitle.createCell(0);
        st.setCellValue("COMPLAINT SUMMARY");
        st.setCellStyle(headerStyle);

// Header Row
        Row header = sheet.createRow(rowNum++);
        header.createCell(0).setCellValue("Metric");
        header.createCell(1).setCellValue("Value");

// Data
        String[][] summaryData = {
                {"Total Complaints", String.valueOf(total)},
                {"Resolved", String.valueOf(resolved)},
                {"Pending", String.valueOf(summary.getOrDefault("pendingComplaints", 0L))},
                {"In Progress", String.valueOf(summary.getOrDefault("inProgressComplaints", 0L))},
                {"Rejected", String.valueOf(summary.getOrDefault("rejectedComplaints", 0L))},
                {"Resolution Rate (%)", String.format("%.2f", rate)}
        };

        for (String[] data : summaryData) {
            Row row = sheet.createRow(rowNum++);
            row.createCell(0).setCellValue(data[0]);
            row.createCell(1).setCellValue(data[1]);
        }

        rowNum += 2; // spacing

// ================= CATEGORY =================
        Row catTitle = sheet.createRow(rowNum++);
        Cell ct = catTitle.createCell(0);
        ct.setCellValue("CATEGORY REPORT");
        ct.setCellStyle(headerStyle);

        Map<String, Long> category = adminService.getCategoryStats();

        for (Map.Entry<String, Long> e : category.entrySet()) {
            Row row = sheet.createRow(rowNum++);
            row.createCell(0).setCellValue(e.getKey());
            row.createCell(1).setCellValue(e.getValue());
        }

        rowNum += 2;

// ================= MONTHLY =================
        Row monthTitle = sheet.createRow(rowNum++);
        Cell mt = monthTitle.createCell(0);
        mt.setCellValue("MONTHLY TREND");
        mt.setCellStyle(headerStyle);

        Map<String, Long> monthly = adminService.getDailyTrendsCurrentMonth();

        for (Map.Entry<String, Long> e : monthly.entrySet()) {
            Row row = sheet.createRow(rowNum++);
            row.createCell(0).setCellValue(e.getKey());
            row.createCell(1).setCellValue(e.getValue());
        }

        rowNum += 2;

// ================= DETAILED =================
        Row detailTitle = sheet.createRow(rowNum++);
        Cell dt = detailTitle.createCell(0);
        dt.setCellValue("DETAILED COMPLAINTS");
        dt.setCellStyle(headerStyle);

// Header
        Row detailHeader = sheet.createRow(rowNum++);
        String[] headers = {"ID", "Category", "Status", "Location", "Created Date"};

        for (int i = 0; i < headers.length; i++) {
            Cell cell = detailHeader.createCell(i);
            cell.setCellValue(headers[i]);
            cell.setCellStyle(headerStyle);
        }

// Data
        List<Complaint> list = complaintService.getComplaintsByDateRange(start, end);

        for (Complaint c : list) {
            Row row = sheet.createRow(rowNum++);
            row.createCell(0).setCellValue(c.getId());
            row.createCell(1).setCellValue(c.getCategory().getName());
            row.createCell(2).setCellValue(c.getStatus().name());
            row.createCell(3).setCellValue(c.getLocation());
            row.createCell(4).setCellValue(c.getCreatedAt().toLocalDate().toString());
        }

// ================= AUTO SIZE =================
        for (int i = 0; i < 5; i++) {
            sheet.autoSizeColumn(i);
        }

// ================= WRITE =================
        workbook.write(response.getOutputStream());
        workbook.close();
    }
}