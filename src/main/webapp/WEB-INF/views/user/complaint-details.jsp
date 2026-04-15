<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fn" uri="jakarta.tags.functions" %>

<jsp:include page="/WEB-INF/views/common/header.jsp" />

<jsp:include page="/WEB-INF/views/common/navbar.jsp" />

<div class="container py-5">

    <!-- Header Actions -->
    <div class="d-flex flex-column flex-md-row align-items-md-center justify-content-between mb-4 border-bottom pb-4">
        <div class="d-flex align-items-center">
            <a href="<c:url value='/user/complaints'/>" class="btn btn-light bg-white border shadow-sm text-primary me-3 rounded-circle d-inline-flex align-items-center justify-content-center hover-lift" style="width: 48px; height: 48px; font-size: 1.25rem;">
                <i class="bi bi-arrow-left"></i>
            </a>
            <div>
                <div class="d-flex align-items-center mb-1">
                    <span class="badge bg-light text-secondary border px-2 py-1 font-monospace me-2">#CMPT-${complaint.id}</span>
                    <c:choose>
                        <c:when test="${complaint.status == 'PENDING'}">
                            <span class="badge bg-warning bg-opacity-10 text-warning border border-warning border-opacity-25 px-2 py-1">Pending</span>
                        </c:when>
                        <c:when test="${complaint.status == 'IN_PROGRESS'}">
                            <span class="badge bg-primary bg-opacity-10 text-primary border border-primary border-opacity-25 px-2 py-1">In Progress</span>
                        </c:when>
                        <c:when test="${complaint.status == 'RESOLVED'}">
                            <span class="badge bg-success bg-opacity-10 text-success border border-success border-opacity-25 px-2 py-1">Resolved</span>
                        </c:when>
                        <c:when test="${complaint.status == 'REJECTED'}">
                            <span class="badge bg-danger bg-opacity-10 text-danger border border-danger border-opacity-25 px-2 py-1">Rejected</span>
                        </c:when>
                    </c:choose>
                </div>
                <h3 class="fw-bold text-dark mb-0">${complaint.title}</h3>
            </div>
        </div>
        <div class="text-md-end mt-3 mt-md-0">
            <p class="text-secondary small fw-medium mb-0">
                <i class="bi bi-calendar3 me-1 text-muted"></i> Submitted on ${fn:substring(complaint.createdAt, 0, 10)}
            </p>
        </div>
    </div>

    <div class="row g-4">

        <!-- Main Details Card -->
        <div class="col-lg-7">
            <div class="card auth-card shadow-sm border-0 rounded-4 h-100 p-0 overflow-hidden">
                <div class="card-header bg-light border-bottom px-4 py-3">
                    <h6 class="fw-bold text-dark text-uppercase tracking-wider mb-0"><i class="bi bi-info-circle me-2 text-primary"></i> Complaint Details</h6>
                </div>
                <div class="card-body px-4 py-4">

                    <div class="row mb-5">
                        <div class="col-sm-6 mb-3 mb-sm-0">
                            <span class="text-muted small text-uppercase tracking-wider d-block mb-2">Category</span>
                            <div class="d-flex align-items-center">
                                <div class="bg-primary bg-opacity-10 rounded text-primary p-2 me-2">
                                    <i class="bi bi-tag-fill"></i>
                                </div>
                                <span class="fw-semibold text-dark fs-6">${complaint.category.name}</span>
                            </div>
                        </div>
                        <div class="col-sm-6">
                            <span class="text-muted small text-uppercase tracking-wider d-block mb-2">Location / Landmark</span>
                            <div class="d-flex align-items-center">
                                <div class="bg-danger bg-opacity-10 rounded text-danger p-2 me-2">
                                    <i class="bi bi-geo-alt-fill"></i>
                                </div>
                                <span class="fw-semibold text-dark fs-6">${complaint.location}</span>
                            </div>
                        </div>
                    </div>

                    <div class="mt-2">
                        <span class="text-muted small text-uppercase tracking-wider d-block mb-3">Detailed Description</span>
                        <div class="bg-light p-4 rounded-4 border-0 text-secondary" style="font-size: 1rem; line-height: 1.6;">
                            <p class="mb-0" style="white-space: pre-wrap;">${complaint.description}</p>
                        </div>
                    </div>

                </div>
            </div>
        </div>

        <!-- Timeline Card -->
        <div class="col-lg-5">
            <div class="card auth-card shadow-sm border-0 rounded-4 h-100 p-0 overflow-hidden">
                <div class="card-header bg-light border-bottom px-4 py-3">
                    <h6 class="fw-bold text-dark text-uppercase tracking-wider mb-0"><i class="bi bi-clock-history me-2 text-primary"></i> Progress Timeline</h6>
                </div>
                <div class="card-body px-4 py-4">

                    <ul class="timeline">
                        <c:forEach var="update" items="${updates}" varStatus="status">
                            <c:set var="statusColor" value="${update.statusChangedTo == 'RESOLVED' ? 'border-success' : (update.statusChangedTo == 'REJECTED' ? 'border-danger' : (update.statusChangedTo == 'PENDING' ? 'border-warning' : 'border-primary'))}" />
                            <li class="timeline-item">
                                <div class="timeline-icon ${statusColor}"></div>

                                <div class="timeline-content shadow-sm border-0 bg-white">
                                    <div class="d-flex flex-wrap justify-content-between align-items-center mb-2">
                                        <c:choose>
                                            <c:when test="${update.statusChangedTo == 'PENDING'}"><span class="badge bg-warning bg-opacity-10 text-warning px-2 border border-warning border-opacity-25 rounded-pill small">PENDING</span></c:when>
                                            <c:when test="${update.statusChangedTo == 'IN_PROGRESS'}"><span class="badge bg-primary bg-opacity-10 text-primary px-2 border border-primary border-opacity-25 rounded-pill small">IN PROGRESS</span></c:when>
                                            <c:when test="${update.statusChangedTo == 'RESOLVED'}"><span class="badge bg-success bg-opacity-10 text-success px-2 border border-success border-opacity-25 rounded-pill small">RESOLVED</span></c:when>
                                            <c:when test="${update.statusChangedTo == 'REJECTED'}"><span class="badge bg-danger bg-opacity-10 text-danger px-2 border border-danger border-opacity-25 rounded-pill small">REJECTED</span></c:when>
                                        </c:choose>
                                        <small class="text-secondary fw-medium" style="font-size: 0.75rem;">
                                            <i class="bi bi-calendar-event me-1"></i> ${fn:substring(update.updatedAt, 0, 10)}
                                        </small>
                                    </div>
                                    <div class="bg-light p-3 rounded-3 mt-2">
                                        <p class="text-dark small mb-0 fw-medium">
                                            <i class="bi bi-chat-left-quote text-muted me-2"></i> "${update.remarks}"
                                        </p>
                                    </div>
                                    <div class="d-flex align-items-center mt-3 border-top pt-2">
                                        <div class="bg-secondary bg-opacity-10 rounded-circle d-flex align-items-center justify-content-center me-2" style="width: 24px; height: 24px;">
                                            <i class="bi bi-person-fill text-secondary" style="font-size: 0.8rem;"></i>
                                        </div>
                                        <small class="text-secondary" style="font-size: 0.8rem;">Updated by <span class="fw-semibold text-dark">${update.updatedBy.fullName}</span></small>
                                    </div>
                                </div>
                            </li>
                        </c:forEach>
                    </ul>

                    <c:if test="${empty updates}">
                        <div class="text-center py-4 text-muted">
                            <i class="bi bi-hourglass-split d-block mb-2 fs-2 opacity-50"></i>
                            <span class="small fw-medium">Waiting for administration to review.</span>
                        </div>
                    </c:if>

                </div>
            </div>
        </div>

    </div>
</div>

<jsp:include page="/WEB-INF/views/common/footer.jsp" />