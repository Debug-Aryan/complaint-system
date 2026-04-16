package com.project.complaintsystem.util;

import com.project.complaintsystem.enums.ComplaintStatus;
import com.project.complaintsystem.model.Category;
import com.project.complaintsystem.model.Complaint;
import com.project.complaintsystem.model.ComplaintUpdate;
import com.project.complaintsystem.model.User;
import com.project.complaintsystem.repository.CategoryRepository;
import com.project.complaintsystem.repository.ComplaintRepository;
import com.project.complaintsystem.repository.ComplaintUpdateRepository;
import com.project.complaintsystem.repository.UserRepository;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.boot.CommandLineRunner;
import org.springframework.core.annotation.Order;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.Random;
import java.util.function.Function;
import java.util.stream.Collectors;

@Component
@Order(4)
@Transactional
public class ComplaintSeeder implements CommandLineRunner {

    private static final Logger log = LoggerFactory.getLogger(ComplaintSeeder.class);

    private static final String ADMIN_EMAIL = "admin@smartcomplaint.com";

    private final UserRepository userRepository;
    private final CategoryRepository categoryRepository;
    private final ComplaintRepository complaintRepository;
    private final ComplaintUpdateRepository complaintUpdateRepository;

    public ComplaintSeeder(UserRepository userRepository,
                           CategoryRepository categoryRepository,
                           ComplaintRepository complaintRepository,
                           ComplaintUpdateRepository complaintUpdateRepository) {
        this.userRepository = userRepository;
        this.categoryRepository = categoryRepository;
        this.complaintRepository = complaintRepository;
        this.complaintUpdateRepository = complaintUpdateRepository;
    }

    @Override
    public void run(String... args) {
        if (complaintRepository.count() > 0) {
            log.info("Complaint seeding skipped: complaints already exist.");
            return;
        }

        List<User> users = userRepository.findAll();
        if (users.isEmpty()) {
            throw new IllegalStateException("No users found for complaint seeding. Ensure UserSeeder (@Order(3)) ran successfully.");
        }

        List<Category> categories = categoryRepository.findAll();
        if (categories.isEmpty()) {
            throw new IllegalStateException("No categories found for complaint seeding. Ensure CategorySeeder (@Order(2)) ran successfully.");
        }

        User admin = userRepository.findByEmail(ADMIN_EMAIL)
                .orElseThrow(() -> new IllegalStateException("Admin user not found: " + ADMIN_EMAIL));

        List<User> citizenUsers = users.stream()
                .filter(u -> u.getEmail() != null && !ADMIN_EMAIL.equalsIgnoreCase(u.getEmail()))
                .toList();
        if (citizenUsers.isEmpty()) {
            citizenUsers = users;
        }

        Map<String, Category> categoryByName = categories.stream()
                .filter(c -> c.getName() != null)
                .collect(Collectors.toMap(Category::getName, Function.identity(), (a, b) -> a));

        List<SeedComplaint> seedComplaints = List.of(
                new SeedComplaint("Potholes on Main Road", "Large potholes causing traffic disruption and accidents."),
                new SeedComplaint("Irregular Water Supply", "Water supply is inconsistent and unavailable for long hours."),
                new SeedComplaint("Frequent Power Cuts", "Unexpected electricity outages affecting daily life."),
                new SeedComplaint("Garbage Not Collected", "Waste has not been collected for several days."),
                new SeedComplaint("Street Lights Not Working", "Multiple street lights are non-functional at night."),
                new SeedComplaint("Drainage Blockage", "Sewage water overflowing due to blocked drains."),
                new SeedComplaint("Noise Pollution at Night", "Loud noises disturbing residents during night hours."),
                new SeedComplaint("Illegal Parking Issue", "Vehicles blocking roads and creating congestion."),
                new SeedComplaint("Air Pollution from Factories", "Excessive smoke causing breathing problems."),
                new SeedComplaint("Water Leakage in Pipeline", "Continuous leakage wasting clean water."),
                new SeedComplaint("Broken Traffic Signal", "Traffic signals not functioning properly."),
                new SeedComplaint("Stray Animals on Road", "Cattle/dogs creating danger for commuters."),
                new SeedComplaint("Poor Road Construction", "Recently built road already damaged."),
                new SeedComplaint("Unhygienic Public Toilets", "Public sanitation facilities are not maintained."),
                new SeedComplaint("Delay in Government Services", "Applications pending without updates."),
                new SeedComplaint("Unauthorized Construction", "Illegal buildings without proper approval."),
                new SeedComplaint("Mosquito Breeding Issue", "Stagnant water leading to mosquito growth."),
                new SeedComplaint("Water Contamination", "Drinking water has bad smell and impurities."),
                new SeedComplaint("Public Transport Delay", "Buses running late or not arriving."),
                new SeedComplaint("Other Issue", "Any complaint not covered in above categories.")
        );

        List<String> locations = List.of(
                "Mehsana, Gujarat",
                "Ahmedabad, Gujarat",
                "Surat, Gujarat",
                "Vadodara, Gujarat",
                "Rajkot, Gujarat",
                "Mumbai, Maharashtra",
                "Pune, Maharashtra",
                "Nagpur, Maharashtra",
                "Nashik, Maharashtra",
                "Delhi, India",
                "Noida, Uttar Pradesh",
                "Lucknow, Uttar Pradesh",
                "Kanpur, Uttar Pradesh",
                "Jaipur, Rajasthan",
                "Udaipur, Rajasthan",
                "Kota, Rajasthan",
                "Bhopal, Madhya Pradesh",
                "Indore, Madhya Pradesh",
                "Patna, Bihar",
                "Ranchi, Jharkhand",
                "Kolkata, West Bengal",
                "Siliguri, West Bengal",
                "Chennai, Tamil Nadu",
                "Coimbatore, Tamil Nadu",
                "Bengaluru, Karnataka",
                "Mysuru, Karnataka",
                "Hyderabad, Telangana",
                "Warangal, Telangana",
                "Kochi, Kerala",
                "Thiruvananthapuram, Kerala"
        );

        Random random = new Random(42);
        LocalDateTime endOfApril = LocalDateTime.of(2026, 4, 30, 23, 59, 59);

        List<Complaint> complaintsToInsert = new ArrayList<>(150);

        for (int i = 0; i < 150; i++) {
            SeedComplaint seed = seedComplaints.get(random.nextInt(seedComplaints.size()));
            User user = citizenUsers.get(random.nextInt(citizenUsers.size()));
            String location = locations.get(random.nextInt(locations.size()));

            ComplaintStatus status = weightedStatus(random);

            LocalDateTime createdAt = randomAprilDateTime(random);
            LocalDateTime updatedAt = computeUpdatedAt(createdAt, status, random, endOfApril);

            Category category = pickCategoryForTitle(seed.title, categories, categoryByName, random);

            Complaint complaint = new Complaint();
            complaint.setUser(user);
            complaint.setCategory(category);
            complaint.setTitle(seed.title);
            complaint.setDescription(seed.description);
            complaint.setLocation(location);
            complaint.setStatus(status);
            complaint.setCreatedAt(createdAt);
            complaint.setUpdatedAt(updatedAt);

            complaintsToInsert.add(complaint);
        }

        List<Complaint> savedComplaints = complaintRepository.saveAll(complaintsToInsert);

        List<ComplaintUpdate> updatesToInsert = new ArrayList<>(savedComplaints.size() * 2);
        for (Complaint complaint : savedComplaints) {
            ComplaintUpdate initial = new ComplaintUpdate();
            initial.setComplaint(complaint);
            initial.setUpdatedBy(complaint.getUser());
            initial.setRemarks("Complaint submitted.");
            initial.setStatusChangedTo(ComplaintStatus.PENDING);
            initial.setUpdatedAt(complaint.getCreatedAt());
            updatesToInsert.add(initial);

            if (complaint.getStatus() != ComplaintStatus.PENDING) {
                ComplaintUpdate adminUpdate = new ComplaintUpdate();
                adminUpdate.setComplaint(complaint);
                adminUpdate.setUpdatedBy(admin);
                adminUpdate.setStatusChangedTo(complaint.getStatus());
                adminUpdate.setRemarks(adminRemarksFor(complaint.getStatus()));
                adminUpdate.setUpdatedAt(complaint.getUpdatedAt());
                updatesToInsert.add(adminUpdate);
            }
        }

        complaintUpdateRepository.saveAll(updatesToInsert);

        log.info("✅ Complaints seeded");
    }

    private static ComplaintStatus weightedStatus(Random random) {
        int roll = random.nextInt(100) + 1; // 1..100
        if (roll <= 20) {
            return ComplaintStatus.PENDING;
        }
        if (roll <= 50) {
            return ComplaintStatus.IN_PROGRESS;
        }
        return ComplaintStatus.RESOLVED;
    }

    private static LocalDateTime randomAprilDateTime(Random random) {
        int day = random.nextInt(30) + 1;
        int hour = random.nextInt(24);
        int minute = random.nextInt(60);
        int second = random.nextInt(60);
        return LocalDateTime.of(2026, 4, day, hour, minute, second);
    }

    private static LocalDateTime computeUpdatedAt(LocalDateTime createdAt,
                                                 ComplaintStatus status,
                                                 Random random,
                                                 LocalDateTime endOfApril) {
        if (status == ComplaintStatus.PENDING) {
            return createdAt;
        }

        int hoursToAdd = (status == ComplaintStatus.IN_PROGRESS)
                ? (random.nextInt(72) + 1)   // 1..72 hours
                : (random.nextInt(336) + 6); // 6..341 hours (~up to 14 days)

        LocalDateTime candidate = createdAt.plusHours(hoursToAdd);
        if (candidate.isAfter(endOfApril)) {
            return endOfApril;
        }
        return candidate;
    }

    private static Category pickCategoryForTitle(String title,
                                                 List<Category> allCategories,
                                                 Map<String, Category> categoryByName,
                                                 Random random) {
        String desiredName = categoryNameForTitle(title);
        if (desiredName != null) {
            Category mapped = categoryByName.get(desiredName);
            if (mapped != null) {
                return mapped;
            }
        }
        return allCategories.get(random.nextInt(allCategories.size()));
    }

    private static String categoryNameForTitle(String title) {
        return switch (title) {
            case "Potholes on Main Road" -> "Infrastructure Issues";
            case "Irregular Water Supply" -> "Water Supply";
            case "Frequent Power Cuts" -> "Electricity Issues";
            case "Garbage Not Collected" -> "Sanitation & Waste Management";
            case "Street Lights Not Working" -> "Public Safety";
            case "Drainage Blockage" -> "Sanitation & Waste Management";
            case "Noise Pollution at Night" -> "Environmental Concerns";
            case "Illegal Parking Issue" -> "Traffic & Transportation";
            case "Air Pollution from Factories" -> "Environmental Concerns";
            case "Water Leakage in Pipeline" -> "Water Supply";
            case "Broken Traffic Signal" -> "Traffic & Transportation";
            case "Stray Animals on Road" -> "Public Safety";
            case "Poor Road Construction" -> "Infrastructure Issues";
            case "Unhygienic Public Toilets" -> "Sanitation & Waste Management";
            case "Delay in Government Services" -> "Government Services";
            case "Unauthorized Construction" -> "Government Services";
            case "Mosquito Breeding Issue" -> "Healthcare Services";
            case "Water Contamination" -> "Water Supply";
            case "Public Transport Delay" -> "Traffic & Transportation";
            case "Other Issue" -> "Other";
            default -> null;
        };
    }

    private static String adminRemarksFor(ComplaintStatus status) {
        return switch (status) {
            case IN_PROGRESS -> "Marked as IN_PROGRESS. Team assigned for investigation.";
            case RESOLVED -> "Marked as RESOLVED after verification.";
            default -> "Status updated.";
        };
    }

    private record SeedComplaint(String title, String description) {
    }
}
