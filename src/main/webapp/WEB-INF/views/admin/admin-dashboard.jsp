<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<jsp:include page="/WEB-INF/views/common/header.jsp" />

<jsp:include page="/WEB-INF/views/common/navbar.jsp" />

<div class="container py-5">

    <div class="row mb-4 align-items-center flex-wrap">
        <div class="col-md-8">
            <span class="badge bg-danger bg-opacity-10 text-danger mb-2 px-3 py-2 rounded-pill fw-semibold">
                <i class="bi bi-shield-lock me-1"></i> Administrator Access
            </span>
            <h2 class="fw-bold text-dark mb-1">
                System Overview
            </h2>
            <p class="text-muted">Welcome back, ${pageContext.request.userPrincipal.name}. Here is the current platform status.</p>
        </div>
        <div class="col-md-4 text-md-end mt-3 mt-md-0">
            <a href="<c:url value='/admin/complaints'/>" class="btn btn-primary px-4 shadow-sm">
                <i class="bi bi-kanban me-1"></i> Manage All Complaints
            </a>
        </div>
    </div>

    <h5 class="fw-bold mb-3 text-secondary">Live Statistics</h5>
    <div class="row g-4 mb-5">

        <div class="col-6 col-lg-3">
            <div class="card auth-card shadow-sm border-0 h-100 border-bottom border-primary border-4">
                <div class="card-body p-4 text-center">
                    <div class="text-primary mb-2"><i class="bi bi-collection fs-1"></i></div>
                    <h2 class="fw-bold text-dark mb-0">${totalComplaints}</h2>
                    <span class="text-muted small text-uppercase tracking-wide">Total Submissions</span>
                </div>
            </div>
        </div>

        <div class="col-6 col-lg-3">
            <div class="card auth-card shadow-sm border-0 h-100 border-bottom border-warning border-4">
                <div class="card-body p-4 text-center">
                    <div class="text-warning mb-2"><i class="bi bi-hourglass-split fs-1"></i></div>
                    <h2 class="fw-bold text-dark mb-0">${pendingCount}</h2>
                    <span class="text-muted small text-uppercase tracking-wide">Pending Action</span>
                </div>
            </div>
        </div>

        <div class="col-6 col-lg-3">
            <div class="card auth-card shadow-sm border-0 h-100 border-bottom border-info border-4">
                <div class="card-body p-4 text-center">
                    <div class="text-info mb-2"><i class="bi bi-tools fs-1"></i></div>
                    <h2 class="fw-bold text-dark mb-0">${inProgressComplaints}</h2>
                    <span class="text-muted small text-uppercase tracking-wide">In Progress</span>
                </div>
            </div>
        </div>

        <div class="col-6 col-lg-3">
            <div class="card auth-card shadow-sm border-0 h-100 border-bottom border-success border-4">
                <div class="card-body p-4 text-center">
                    <div class="text-success mb-2"><i class="bi bi-check-circle fs-1"></i></div>
                    <h2 class="fw-bold text-dark mb-0">${resolvedCount}</h2>
                    <span class="text-muted small text-uppercase tracking-wide">Resolved Issues</span>
                </div>
            </div>
        </div>

    </div>

    <h5 class="fw-bold mb-3 text-secondary">System Controls</h5>
    <div class="row g-4">

        <div class="col-md-6">
            <a href="<c:url value='/admin/complaints'/>" class="text-decoration-none">
                <div class="card auth-card action-card p-4 h-100 shadow-sm d-flex flex-row align-items-center">
                    <div class="icon-circle bg-primary bg-opacity-10 text-primary me-4 flex-shrink-0">
                        <i class="bi bi-inboxes"></i>
                    </div>
                    <div>
                        <h5 class="fw-bold text-dark mb-1">Process Complaints</h5>
                        <p class="text-muted small mb-0">Review, assign, and update the status of citizen reports.</p>
                    </div>
                </div>
            </a>
        </div>

        <div class="col-md-6">
            <a href="#" class="text-decoration-none" onclick="return false;">
                <div class="card auth-card action-card p-4 h-100 shadow-sm d-flex flex-row align-items-center">
                    <div class="icon-circle bg-secondary bg-opacity-10 text-secondary me-4 flex-shrink-0">
                        <i class="bi bi-file-earmark-bar-graph"></i>
                    </div>
                    <div>
                        <h5 class="fw-bold text-dark mb-1">Generate Reports <span class="badge bg-secondary ms-2" style="font-size: 0.65rem;">Coming Soon</span></h5>
                        <p class="text-muted small mb-0">Export system analytics and performance metrics as PDF/CSV.</p>
                    </div>
                </div>
            </a>
        </div>

    </div>

</div>

<jsp:include page="/WEB-INF/views/common/footer.jsp" />