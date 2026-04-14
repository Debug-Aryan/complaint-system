<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fn" uri="jakarta.tags.functions" %>

<jsp:include page="/WEB-INF/views/common/header.jsp" />

<jsp:include page="/WEB-INF/views/common/navbar.jsp" />

<div class="container py-5">

    <div class="d-flex align-items-center mb-4">
        <a href="<c:url value='/admin/complaints'/>" class="btn btn-light border text-muted me-3 rounded-circle" style="width: 40px; height: 40px; display: flex; align-items: center; justify-content: center;">
            <i class="bi bi-arrow-left"></i>
        </a>
        <div>
            <h4 class="fw-bold text-dark mb-0">Complaint Resolution Panel</h4>
            <p class="text-muted small mb-0">Tracking ID: #CMPT-${complaint.id}</p>
        </div>
    </div>

    <c:if test="${not empty error}">
        <div class="alert alert-danger py-2 small rounded-3 mb-4" role="alert">
            <i class="bi bi-exclamation-triangle me-1"></i> ${error}
        </div>
    </c:if>
    <c:if test="${not empty success}">
        <div class="alert alert-success py-2 small rounded-3 mb-4" role="alert">
            <i class="bi bi-check-circle me-1"></i> ${success}
        </div>
    </c:if>

    <div class="row g-4">

        <div class="col-lg-7">
            <div class="card auth-card shadow-sm h-100 p-4">
                <div class="card-body p-0">

                    <div class="d-flex justify-content-between align-items-start mb-4 border-bottom pb-3">
                        <div>
                            <h5 class="fw-bold text-dark mb-1">${complaint.title}</h5>
                            <span class="text-muted small">Submitted by: <span class="text-dark fw-semibold">${complaint.user.fullName}</span> (${complaint.user.phoneNumber})</span>
                        </div>

                        <span class="badge ${complaint.status == 'PENDING' ? 'bg-warning text-dark' : (complaint.status == 'RESOLVED' ? 'bg-success' : (complaint.status == 'REJECTED' ? 'bg-danger' : 'bg-primary'))} px-3 py-2 rounded-pill">
                            Current: ${complaint.status}
                        </span>
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

                    <div class="bg-light p-3 rounded-3 border mb-4">
                        <span class="text-muted small text-uppercase tracking-wide d-block mb-2">Description provided by citizen</span>
                        <p class="text-dark mb-0" style="white-space: pre-wrap;">${complaint.description}</p>
                    </div>

                    <h6 class="fw-bold text-secondary mb-3 mt-4">Recent History</h6>
                    <ul class="timeline mb-0">
                        <c:forEach var="update" items="${updates}">
                            <li class="timeline-item mb-2 pb-2 border-bottom">
                                <div class="timeline-icon bg-light border-secondary" style="width: 12px; height: 12px; left: -1.95rem; top: 5px;"></div>
                                <div class="d-flex justify-content-between">
                                    <strong class="text-dark small">${update.statusChangedTo}</strong>
                                    <small class="text-muted">${fn:substring(update.updatedAt, 0, 10)}</small>
                                </div>
                                <p class="text-muted small mb-0">${update.remarks} <span class="fst-italic" style="font-size: 0.7rem;">(${update.updatedBy.fullName})</span></p>
                            </li>
                        </c:forEach>
                    </ul>

                </div>
            </div>
        </div>

        <div class="col-lg-5">
            <div class="card auth-card shadow-sm h-100 p-4 border-top border-primary border-4">
                <div class="card-body p-0">
                    <h5 class="fw-bold text-dark mb-4">
                        <i class="bi bi-pencil-square text-primary me-2"></i> Update Status
                    </h5>

                    <form action="<c:url value='/admin/complaints/update'/>" method="post">
                        <c:if test="${not empty _csrf}">
                            <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
                        </c:if>

                        <input type="hidden" name="complaintId" value="${complaint.id}">

                        <div class="mb-4">
                            <label for="status" class="form-label small fw-semibold text-muted">Select New Status</label>
                            <select class="form-select form-select-lg text-dark fw-medium" id="status" name="status" required ${complaint.status == 'RESOLVED' || complaint.status == 'REJECTED' ? 'disabled' : ''}>
                                <option value="" disabled selected>Choose action...</option>
                                <c:if test="${complaint.status == 'PENDING'}">
                                    <option value="IN_PROGRESS">Mark as In Progress</option>
                                    <option value="REJECTED">Reject Complaint</option>
                                </c:if>
                                <c:if test="${complaint.status == 'IN_PROGRESS'}">
                                    <option value="RESOLVED">Mark as Resolved</option>
                                </c:if>
                            </select>
                        </div>

                        <div class="mb-4">
                            <label for="remarks" class="form-label small fw-semibold text-muted">Admin Remarks (Visible to Citizen)</label>
                            <textarea class="form-control bg-light" id="remarks" name="remarks" rows="4" placeholder="e.g., A team has been dispatched to fix the pothole..." required ${complaint.status == 'RESOLVED' || complaint.status == 'REJECTED' ? 'disabled' : ''}></textarea>
                        </div>

                        <c:choose>
                            <c:when test="${complaint.status == 'RESOLVED' || complaint.status == 'REJECTED'}">
                                <div class="alert alert-secondary py-2 small text-center mb-0">
                                    <i class="bi bi-lock-fill me-1"></i> This complaint is closed and cannot be updated.
                                </div>
                            </c:when>
                            <c:otherwise>
                                <button type="submit" class="btn btn-primary w-100 py-2 fw-bold shadow-sm">
                                    Update & Notify Citizen
                                </button>
                            </c:otherwise>
                        </c:choose>

                    </form>

                </div>
            </div>
        </div>

    </div>
</div>

<jsp:include page="/WEB-INF/views/common/footer.jsp" />