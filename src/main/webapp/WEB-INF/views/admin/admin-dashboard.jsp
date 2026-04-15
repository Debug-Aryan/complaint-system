<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<jsp:include page="/WEB-INF/views/common/header.jsp" />
<jsp:include page="/WEB-INF/views/common/navbar.jsp" />

<div class="container-fluid py-4 px-lg-5">

    <!-- Welcome Section -->
    <div class="row mb-5 align-items-center">
        <div class="col-md-8">
            <span class="badge bg-danger bg-opacity-10 text-danger px-3 py-2 rounded-pill fw-semibold mb-3">
                <i class="bi bi-shield-lock me-1"></i> Administrator Access
            </span>
            <h2 class="fw-bold text-dark mb-2">System Overview</h2>
            <p class="text-muted mb-0">
                Welcome back, ${pageContext.request.userPrincipal.principal.fullName}. Here is the current platform status.
            </p>
        </div>
        <div class="col-md-4 text-md-end mt-4 mt-md-0">
            <a href="<c:url value='/admin/complaints'/>" class="btn btn-primary rounded-pill px-4 py-2 fw-medium shadow-sm transition-all">
                <i class="bi bi-kanban me-2"></i> Manage All Complaints
            </a>
        </div>
    </div>

    <!-- Live Statistics Cards -->
    <h5 class="fw-bold mb-4 text-dark">Live Statistics</h5>
    <div class="row g-4 mb-5">

        <div class="col-12 col-sm-6 col-xl-3">
            <div class="card auth-card shadow-sm border-0 h-100 transition-all">
                <div class="card-body p-4 d-flex align-items-center">
                    <div class="icon-circle bg-primary bg-opacity-10 text-primary me-3 flex-shrink-0">
                        <i class="bi bi-collection"></i>
                    </div>
                    <div>
                        <p class="text-muted small fw-semibold text-uppercase tracking-wider mb-1">Total Submissions</p>
                        <h2 class="fw-bold text-dark mb-0">${totalComplaints}</h2>
                    </div>
                </div>
            </div>
        </div>

        <div class="col-12 col-sm-6 col-xl-3">
            <div class="card auth-card shadow-sm border-0 h-100 transition-all">
                <div class="card-body p-4 d-flex align-items-center">
                    <div class="icon-circle bg-warning bg-opacity-10 text-warning me-3 flex-shrink-0">
                        <i class="bi bi-hourglass-split"></i>
                    </div>
                    <div>
                        <p class="text-muted small fw-semibold text-uppercase tracking-wider mb-1">Pending Action</p>
                        <h2 class="fw-bold text-dark mb-0">${pendingCount}</h2>
                    </div>
                </div>
            </div>
        </div>

        <div class="col-12 col-sm-6 col-xl-3">
            <div class="card auth-card shadow-sm border-0 h-100 transition-all">
                <div class="card-body p-4 d-flex align-items-center">
                    <div class="icon-circle bg-info bg-opacity-10 text-info me-3 flex-shrink-0">
                        <i class="bi bi-tools"></i>
                    </div>
                    <div>
                        <p class="text-muted small fw-semibold text-uppercase tracking-wider mb-1">In Progress</p>
                        <h2 class="fw-bold text-dark mb-0">${inProgressComplaints}</h2>
                    </div>
                </div>
            </div>
        </div>

        <div class="col-12 col-sm-6 col-xl-3">
            <div class="card auth-card shadow-sm border-0 h-100 transition-all">
                <div class="card-body p-4 d-flex align-items-center">
                    <div class="icon-circle bg-success bg-opacity-10 text-success me-3 flex-shrink-0">
                        <i class="bi bi-check-circle"></i>
                    </div>
                    <div>
                        <p class="text-muted small fw-semibold text-uppercase tracking-wider mb-1">Resolved Issues</p>
                        <h2 class="fw-bold text-dark mb-0">${resolvedCount}</h2>
                    </div>
                </div>
            </div>
        </div>

    </div>

    <!-- Quick Actions -->
    <h5 class="fw-bold mb-4 text-dark">System Controls</h5>
    <div class="row g-4 mb-5">

        <!-- Process Complaints -->
        <div class="col-md-6 col-xl-4">
            <a href="<c:url value='/admin/complaints'/>" class="text-decoration-none">
                <div class="card auth-card action-card p-4 h-100 shadow-sm d-flex flex-row align-items-center">
                    <div class="icon-circle bg-primary bg-opacity-10 text-primary me-4 flex-shrink-0">
                        <i class="bi bi-inboxes"></i>
                    </div>
                    <div>
                        <h5 class="fw-bold text-dark mb-1">Process Complaints</h5>
                        <p class="text-muted small mb-0">
                            Review, assign, and update the status of citizen reports.
                        </p>
                    </div>
                    <div class="ms-auto text-primary">
                        <i class="bi bi-chevron-right fs-5"></i>
                    </div>
                </div>
            </a>
        </div>

        <!-- Generate Reports -->
        <div class="col-md-6 col-xl-4">
            <a href="<c:url value='/admin/reports'/>" class="text-decoration-none">
                <div class="card auth-card action-card p-4 h-100 shadow-sm d-flex flex-row align-items-center">
                    <div class="icon-circle bg-secondary bg-opacity-10 text-secondary me-4 flex-shrink-0">
                        <i class="bi bi-file-earmark-bar-graph"></i>
                    </div>
                    <div>
                        <h5 class="fw-bold text-dark mb-1">Generate Reports</h5>
                        <p class="text-muted small mb-0">
                            Export system analytics and performance metrics as PDF/CSV.
                        </p>
                    </div>
                    <div class="ms-auto text-secondary">
                        <i class="bi bi-chevron-right fs-5"></i>
                    </div>
                </div>
            </a>
        </div>

    </div>

</div>

<jsp:include page="/WEB-INF/views/common/footer.jsp" />