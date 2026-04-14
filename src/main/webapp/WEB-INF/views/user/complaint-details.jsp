<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fn" uri="jakarta.tags.functions" %>

<jsp:include page="/WEB-INF/views/common/header.jsp" />

<jsp:include page="/WEB-INF/views/common/navbar.jsp" />

<div class="container py-5">

    <div class="d-flex align-items-center mb-4">
        <a href="<c:url value='/user/complaints'/>" class="btn btn-light border text-muted me-3 rounded-circle" style="width: 40px; height: 40px; display: flex; align-items: center; justify-content: center;">
            <i class="bi bi-arrow-left"></i>
        </a>
        <div>
            <h4 class="fw-bold text-dark mb-0">Complaint #CMPT-${complaint.id}</h4>
            <p class="text-muted small mb-0">Submitted on ${fn:substring(complaint.createdAt, 0, 10)}</p>
        </div>
    </div>

    <div class="row g-4">

        <div class="col-lg-7">
            <div class="card auth-card shadow-sm h-100 p-4">
                <div class="card-body p-0">

                    <div class="d-flex justify-content-between align-items-start mb-4 border-bottom pb-3">
                        <h5 class="fw-bold text-dark mb-0">${complaint.title}</h5>

                        <c:choose>
                            <c:when test="${complaint.status == 'PENDING'}">
                                <span class="badge bg-warning text-dark px-3 py-2 rounded-pill">Pending</span>
                            </c:when>
                            <c:when test="${complaint.status == 'IN_PROGRESS'}">
                                <span class="badge bg-primary px-3 py-2 rounded-pill">In Progress</span>
                            </c:when>
                            <c:when test="${complaint.status == 'RESOLVED'}">
                                <span class="badge bg-success px-3 py-2 rounded-pill">Resolved</span>
                            </c:when>
                            <c:when test="${complaint.status == 'REJECTED'}">
                                <span class="badge bg-danger px-3 py-2 rounded-pill">Rejected</span>
                            </c:when>
                        </c:choose>
                    </div>

                    <div class="row mb-4">
                        <div class="col-sm-6 mb-3">
                            <span class="text-muted small text-uppercase tracking-wide d-block mb-1">Category</span>
                            <span class="fw-semibold text-dark"><i class="bi bi-tag text-primary me-1"></i> ${complaint.category.name}</span>
                        </div>
                        <div class="col-sm-6 mb-3">
                            <span class="text-muted small text-uppercase tracking-wide d-block mb-1">Location</span>
                            <span class="fw-semibold text-dark"><i class="bi bi-geo-alt text-danger me-1"></i> ${complaint.location}</span>
                        </div>
                    </div>

                    <div class="bg-light p-3 rounded-3 border">
                        <span class="text-muted small text-uppercase tracking-wide d-block mb-2">Detailed Description</span>
                        <p class="text-dark mb-0" style="white-space: pre-wrap;">${complaint.description}</p>
                    </div>

                </div>
            </div>
        </div>

        <div class="col-lg-5">
            <div class="card auth-card shadow-sm h-100 p-4 bg-white">
                <div class="card-body p-0">
                    <h5 class="fw-bold text-dark mb-4 border-bottom pb-3">
                        <i class="bi bi-clock-history text-primary me-2"></i> Progress Timeline
                    </h5>

                    <ul class="timeline">
                        <c:forEach var="update" items="${updates}" varStatus="status">
                            <li class="timeline-item">
                                <div class="timeline-icon ${update.statusChangedTo == 'RESOLVED' ? 'border-success' : (update.statusChangedTo == 'REJECTED' ? 'border-danger' : 'border-primary')}"></div>

                                <div class="timeline-content">
                                    <div class="d-flex justify-content-between align-items-center mb-1">
                                        <strong class="text-dark small text-uppercase tracking-wide">${update.statusChangedTo}</strong>
                                        <small class="text-muted" style="font-size: 0.75rem;">
                                            ${fn:substring(update.updatedAt, 0, 10)}
                                        </small>
                                    </div>
                                    <p class="text-muted small mb-0 mt-2 border-top pt-2">
                                        <i class="bi bi-chat-left-text me-1"></i> ${update.remarks}
                                    </p>
                                    <div class="text-end mt-1">
                                        <small class="text-muted" style="font-size: 0.7rem;">- Updated by ${update.updatedBy.fullName}</small>
                                    </div>
                                </div>
                            </li>
                        </c:forEach>
                    </ul>

                </div>
            </div>
        </div>

    </div>
</div>

<jsp:include page="/WEB-INF/views/common/footer.jsp" />