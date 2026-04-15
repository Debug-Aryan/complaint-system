<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<jsp:include page="/WEB-INF/views/common/header.jsp" />

<jsp:include page="/WEB-INF/views/common/navbar.jsp" />

<div class="container py-5">
    <!-- Welcome Header -->
    <div class="row mb-5 align-items-center">
        <div class="col-md-8">
            <h2 class="fw-bold text-dark mb-2">
                Welcome back, ${pageContext.request.userPrincipal.principal.fullName} 👋
            </h2>
            <p class="text-secondary mb-0 fs-5">What would you like to do today?</p>
        </div>
    </div>

    <!-- Quick Actions Grid -->
    <div class="row g-4">
        <!-- Submit Action -->
        <div class="col-md-6 col-lg-5">
            <a href="<c:url value='/user/submit'/>" class="text-decoration-none text-dark">
                <div class="card action-card h-100 p-4 border-0 shadow-sm rounded-4">
                    <div class="d-flex align-items-start">
                        <div class="icon-circle bg-primary bg-opacity-10 text-primary me-4">
                            <i class="bi bi-pencil-square"></i>
                        </div>
                        <div>
                            <h4 class="fw-bold mb-1">Submit Complaint</h4>
                            <p class="text-muted small mb-0">Lodge a new grievance or report an issue in your area with details and photos.</p>
                        </div>
                    </div>
                </div>
            </a>
        </div>

        <!-- View Action -->
        <div class="col-md-6 col-lg-5">
            <a href="<c:url value='/user/complaints'/>" class="text-decoration-none text-dark">
                <div class="card action-card h-100 p-4 border-0 shadow-sm rounded-4">
                    <div class="d-flex align-items-start">
                        <div class="icon-circle bg-success bg-opacity-10 text-success me-4">
                            <i class="bi bi-card-checklist"></i>
                        </div>
                        <div>
                            <h4 class="fw-bold mb-1">My Complaints</h4>
                            <p class="text-muted small mb-0">Track the real-time status, read updates from the administration, and view history.</p>
                        </div>
                    </div>
                </div>
            </a>
        </div>
    </div>

</div>

<jsp:include page="/WEB-INF/views/common/footer.jsp" />