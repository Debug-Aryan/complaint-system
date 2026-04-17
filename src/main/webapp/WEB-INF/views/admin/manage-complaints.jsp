<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fn" uri="jakarta.tags.functions" %>

<jsp:include page="/WEB-INF/views/common/header.jsp" />
<jsp:include page="/WEB-INF/views/common/navbar.jsp" />

<div class="container-fluid py-4 px-lg-5">

    <!-- Page Header & Metrics -->
    <div class="d-flex justify-content-between align-items-end mb-4 flex-wrap gap-3">
        <div>
            <span class="badge bg-primary bg-opacity-10 text-primary px-3 py-2 rounded-pill fw-semibold mb-2">
                <i class="bi bi-kanban me-1"></i> Complaint Tracking
            </span>
            <h2 class="fw-bold text-dark mb-1">Manage Complaints</h2>
            <p class="text-muted mb-0">Review, filter, and process citizen grievances in real-time.</p>
        </div>
        <div class="d-flex gap-2">
            <!-- Filter Wrapper -->
            <div class="position-relative">
                <button id="filterDropdownBtn" class="btn btn-outline-primary shadow-sm px-3 py-2 rounded-pill fw-medium transition-all" type="button">
                    <i class="bi bi-funnel me-1"></i> Filter
                </button>

                <!-- Floating Filter Panel -->
                <div id="floatingFilterPanel" class="d-none bg-white p-3 rounded-3" style="position: absolute; top: calc(100% + 10px); right: 0; z-index: 1000; width: 280px; box-shadow: 0 4px 12px rgba(0,0,0,0.15); max-height: calc(100vh - 150px); flex-direction: column;">
                    <form method="get" action="<c:url value='/admin/complaints'/>" class="m-0 d-flex flex-column h-100">
                        <!-- Search Bar (UI Only) -->
                        <div class="mb-3">
                            <input type="text" placeholder="Search filters..." class="form-control form-control-sm bg-light border-0 shadow-none py-2 px-3 rounded-3">
                        </div>

                        <hr class="mt-0 mb-2 border-light">

                        <!-- Scrollable Accordion Content -->
                        <div class="flex-grow-1 overflow-y-auto mb-3 pe-1 h-100" style="max-height: 250px;">
                            <div class="accordion accordion-flush" id="filterAccordion">
                                <!-- Category Filter -->
                                <div class="accordion-item border-0 mb-1">
                                    <h2 class="accordion-header" id="headingCategory">
                                        <button class="accordion-button px-0 py-2 bg-transparent shadow-none fw-semibold text-dark rounded-0 collapsed border-0" type="button" data-bs-toggle="collapse" data-bs-target="#collapseCategory" aria-expanded="false" aria-controls="collapseCategory" style="font-size: 0.95rem;">
                                            Category
                                        </button>
                                    </h2>
                                    <div id="collapseCategory" class="accordion-collapse collapse" aria-labelledby="headingCategory">
                                        <div class="accordion-body px-0 pt-2 pb-2">
                                            <div class="d-flex flex-column gap-2">
                                                <c:forEach var="category" items="${categories}">
                                                    <div class="form-check custom-checkbox mb-0">
                                                        <input class="form-check-input shadow-none" type="checkbox" name="categoryIds" value="${category.id}" id="cat_${category.id}"
                                                            ${not empty selectedCategories and selectedCategories.contains(category.id) ? 'checked' : ''}>
                                                        <label class="form-check-label text-muted small" for="cat_${category.id}">
                                                            ${category.name}
                                                        </label>
                                                    </div>
                                                </c:forEach>
                                            </div>
                                        </div>
                                    </div>
                                </div>

                                <!-- Status Filter -->
                                <div class="accordion-item border-0">
                                    <h2 class="accordion-header" id="headingStatus">
                                        <button class="accordion-button px-0 py-2 bg-transparent shadow-none fw-semibold text-dark rounded-0 collapsed border-0" type="button" data-bs-toggle="collapse" data-bs-target="#collapseStatus" aria-expanded="false" aria-controls="collapseStatus" style="font-size: 0.95rem;">
                                            Status
                                        </button>
                                    </h2>
                                    <div id="collapseStatus" class="accordion-collapse collapse" aria-labelledby="headingStatus">
                                        <div class="accordion-body px-0 pt-2 pb-2">
                                            <div class="d-flex flex-column gap-2">
                                                <c:forEach var="status" items="${allStatuses}">
                                                    <div class="form-check custom-checkbox mb-0">
                                                        <input class="form-check-input shadow-none" type="checkbox" name="statuses" value="${status.name()}" id="status_${status}"
                                                            ${not empty selectedStatuses and selectedStatuses.contains(status.name()) ? 'checked' : ''}>
                                                        <label class="form-check-label text-muted small" for="status_${status}">
                                                            ${status}
                                                        </label>
                                                    </div>
                                                </c:forEach>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <!-- Submit Button -->
                        <div class="pt-3 border-top mt-auto bg-white">
                            <button type="submit" class="btn btn-primary w-100 fw-medium shadow-sm py-2 rounded-3">Apply</button>
                        </div>
                    </form>
                </div>
            </div>

            <a href="<c:url value='/admin/reports'/>" class="btn btn-light border bg-white shadow-sm text-dark px-3 py-2 rounded-pill fw-medium transition-all">
                <i class="bi bi-file-earmark-bar-graph me-1"></i> Analytics
            </a>
            <c:url var="refreshUrl" value="/admin/complaints"/>
            <button class="btn btn-white border bg-white shadow-sm text-muted px-3 py-2 rounded-pill transition-all" onclick="window.location.href='${refreshUrl}'">
                <i class="bi bi-arrow-clockwise"></i> Refresh
            </button>
        </div>
    </div>

    <!-- Data Table Container -->
    <div class="card auth-card shadow-sm border-0 mb-5">
        <div class="card-body p-0">

            <c:choose>
                <c:when test="${empty complaints}">
                    <div class="text-center py-5">
                        <div class="bg-light rounded-circle d-inline-flex justify-content-center align-items-center mb-3" style="width: 80px; height: 80px;">
                            <i class="bi bi-inbox text-muted fs-1"></i>
                        </div>
                        <h4 class="fw-bold text-dark">No complaints found</h4>
                        <p class="text-muted mb-0">There are currently no active grievances submitted by citizens.</p>
                    </div>
                </c:when>
                <c:otherwise>
                    <div class="table-responsive">
                        <table class="table table-hover align-middle mb-0 border-top-0">
                            <thead class="bg-light text-muted small text-uppercase tracking-wider" style="letter-spacing: 0.5px;">
                                <tr>
                                    <th class="ps-4 py-3 border-bottom-0 fw-semibold">ID</th>
                                    <th class="py-3 border-bottom-0 fw-semibold">Citizen Information</th>
                                    <th class="py-3 border-bottom-0 fw-semibold">Category</th>
                                    <th class="py-3 border-bottom-0 fw-semibold">Date Submitted</th>
                                    <th class="py-3 border-bottom-0 fw-semibold">Status</th>
                                    <th class="py-3 border-bottom-0 fw-semibold" colspan="2">Resolution & Action</th>
                                </tr>
                            </thead>
                            <tbody class="border-top-0">
                                <c:forEach var="complaint" items="${complaints}">
                                    <tr>
                                        <!-- ID -->
                                        <td class="ps-4 fw-semibold text-dark">
                                            <a href="<c:url value='/admin/complaints/${complaint.id}'/>" class="text-decoration-none text-primary bg-primary bg-opacity-10 px-2 py-1 rounded">
                                                #${complaint.id}
                                            </a>
                                        </td>
                                        
                                        <!-- Citizen Information -->
                                        <td>
                                            <div class="d-flex align-items-center">
                                                <div>
                                                    <span class="d-block text-dark fw-bold">${complaint.user.fullName}</span>
                                                    <span class="text-muted small"><i class="bi bi-envelope me-1"></i>${complaint.user.email}</span>
                                                </div>
                                            </div>
                                        </td>

                                        <!-- Issue Category -->
                                        <td>
                                            <span class="badge border text-dark fw-medium px-2 py-1 bg-light">
                                                ${complaint.category.name}
                                            </span>
                                        </td>

                                        <!-- Date -->
                                        <td>
                                            <span class="text-secondary fw-medium"><i class="bi bi-calendar3 me-1 text-muted"></i>${fn:substring(complaint.createdAt, 0, 10)}</span>
                                        </td>

                                        <!-- Status Badge -->
                                        <td>
                                            <c:choose>
                                                <c:when test="${complaint.status == 'PENDING'}">
                                                    <span class="badge bg-warning bg-opacity-10 text-warning px-3 py-2 rounded-pill border border-warning fw-semibold">
                                                        <i class="bi bi-circle-half me-1"></i> Pending
                                                    </span>
                                                </c:when>
                                                <c:when test="${complaint.status == 'IN_PROGRESS'}">
                                                    <span class="badge bg-primary bg-opacity-10 text-primary px-3 py-2 rounded-pill border border-primary fw-semibold">
                                                        <i class="bi bi-tools me-1"></i> In Progress
                                                    </span>
                                                </c:when>
                                                <c:when test="${complaint.status == 'RESOLVED'}">
                                                    <span class="badge bg-success bg-opacity-10 text-success px-3 py-2 rounded-pill border border-success fw-semibold">
                                                        <i class="bi bi-check-circle me-1"></i> Resolved
                                                    </span>
                                                </c:when>
                                                <c:when test="${complaint.status == 'REJECTED'}">
                                                    <span class="badge bg-danger bg-opacity-10 text-danger px-3 py-2 rounded-pill border border-danger fw-semibold">
                                                        <i class="bi bi-x-circle me-1"></i> Rejected
                                                    </span>
                                                </c:when>
                                            </c:choose>
                                        </td>

                                        <!-- Quick Action Form -->
                                        <td>
                                            <form action="<c:url value='/admin/complaints/update'/>" method="post" class="d-flex align-items-center gap-2 m-0 bg-light p-2 rounded-3 border">
                                                <c:if test="${not empty _csrf}">
                                                    <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
                                                </c:if>
                                                <input type="hidden" name="complaintId" value="${complaint.id}" />
                                                
                                                <select class="form-select form-select-sm border-0 shadow-none bg-white rounded flex-shrink-0" style="width: 140px;" name="status" required ${complaint.status == 'RESOLVED' || complaint.status == 'REJECTED' ? 'disabled' : ''}>
                                                    <option value="" disabled selected>Update state</option>
                                                    <c:if test="${complaint.status == 'PENDING'}">
                                                        <option value="IN_PROGRESS">In Progress</option>
                                                        <option value="REJECTED">Reject</option>
                                                    </c:if>
                                                    <c:if test="${complaint.status == 'IN_PROGRESS'}">
                                                        <option value="RESOLVED">Resolve</option>
                                                    </c:if>
                                                </select>
                                                
                                                <input class="form-control form-control-sm border-0 shadow-none bg-white rounded" name="remarks" placeholder="Add remarks..." required ${complaint.status == 'RESOLVED' || complaint.status == 'REJECTED' ? 'disabled' : ''} />
                                                
                                                <button class="btn btn-sm btn-primary rounded transition-all px-3 fw-medium flex-shrink-0" type="submit" ${complaint.status == 'RESOLVED' || complaint.status == 'REJECTED' ? 'disabled' : ''}>
                                                    <i class="bi bi-send-check"></i>
                                                </button>
                                            </form>
                                        </td>

                                        <!-- View Details Link -->
                                        <td class="pe-4 text-end">
                                            <a class="btn btn-sm btn-white text-primary border shadow-sm rounded-pill px-3 fw-medium transition-all" href="<c:url value='/admin/complaints/${complaint.id}'/>">
                                                View <i class="bi bi-arrow-right ms-1"></i>
                                            </a>
                                        </td>

                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                    </div>

                    <div class="pagination-container">
                        <c:if test="${totalPages > 1}">

                            <c:if test="${currentPage > 0}">
                                <c:url var="prevUrl" value="/admin/complaints">
                                    <c:param name="page" value="${currentPage - 1}" />
                                    <c:param name="size" value="${size}" />
                                    <c:forEach var="catId" items="${selectedCategories}">
                                        <c:param name="categoryIds" value="${catId}" />
                                    </c:forEach>
                                    <c:forEach var="st" items="${selectedStatuses}">
                                        <c:param name="statuses" value="${st}" />
                                    </c:forEach>
                                </c:url>
                                <a href="${prevUrl}">Previous</a>
                            </c:if>

                            <c:forEach begin="0" end="${totalPages - 1}" var="i">
                                <c:url var="pageUrl" value="/admin/complaints">
                                    <c:param name="page" value="${i}" />
                                    <c:param name="size" value="${size}" />
                                    <c:forEach var="catId" items="${selectedCategories}">
                                        <c:param name="categoryIds" value="${catId}" />
                                    </c:forEach>
                                    <c:forEach var="st" items="${selectedStatuses}">
                                        <c:param name="statuses" value="${st}" />
                                    </c:forEach>
                                </c:url>
                                <a href="${pageUrl}" class="${i == currentPage ? 'active-page' : ''}">
                                    ${i + 1}
                                </a>
                            </c:forEach>

                            <c:if test="${currentPage < totalPages - 1}">
                                <c:url var="nextUrl" value="/admin/complaints">
                                    <c:param name="page" value="${currentPage + 1}" />
                                    <c:param name="size" value="${size}" />
                                    <c:forEach var="catId" items="${selectedCategories}">
                                        <c:param name="categoryIds" value="${catId}" />
                                    </c:forEach>
                                    <c:forEach var="st" items="${selectedStatuses}">
                                        <c:param name="statuses" value="${st}" />
                                    </c:forEach>
                                </c:url>
                                <a href="${nextUrl}">Next</a>
                            </c:if>

                        </c:if>
                    </div>
                </c:otherwise>
            </c:choose>

        </div>
    </div>

</div>

<script>
document.addEventListener("DOMContentLoaded", function () {
    const filterBtn = document.getElementById("filterDropdownBtn");
    const filterPanel = document.getElementById("floatingFilterPanel");
    
    // Toggle Panel
    filterBtn.addEventListener("click", function (e) {
        e.stopPropagation();
        filterPanel.classList.toggle("d-none");
    });
    
    // Create the text filter logic
    const searchInput = filterPanel.querySelector('input[type="text"]');
    searchInput.addEventListener("input", function(e) {
        const text = e.target.value.toLowerCase();
        const checkboxes = filterPanel.querySelectorAll('.form-check');
        checkboxes.forEach(function(box) {
            const label = box.querySelector('label').innerText.toLowerCase();
            box.style.display = label.includes(text) ? '' : 'none';
        });
        
        // ensure accordions are open to show search results
        if(text.trim() !== "") {
            document.querySelectorAll('.accordion-collapse').forEach(function(collapse) {
                collapse.classList.add('show');
            });
            document.querySelectorAll('.accordion-button').forEach(function(btn) {
                btn.classList.remove('collapsed');
                btn.setAttribute("aria-expanded", "true");
            });
        }
    });

    // Close on outside click
    document.addEventListener("click", function (e) {
        if (!filterPanel.contains(e.target) && e.target !== filterBtn) {
            filterPanel.classList.add("d-none");
        }
    });
});
</script>

<jsp:include page="/WEB-INF/views/common/footer.jsp" />