<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fn" uri="jakarta.tags.functions" %>

<jsp:include page="/WEB-INF/views/common/header.jsp" />

<jsp:include page="/WEB-INF/views/common/navbar.jsp" />

<div class="container-fluid px-lg-5 py-5">

    <div class="d-flex align-items-center mb-4">
        <a href="<c:url value='/admin/complaints'/>" class="btn btn-light rounded-circle shadow-sm border-0 me-3 d-flex align-items-center justify-content-center" style="width: 45px; height: 45px;">
            <i class="bi bi-arrow-left text-muted fs-5"></i>
        </a>
        <div>
            <h4 class="fw-bold text-dark mb-0">Complaint Resolution Panel</h4>
            <p class="text-muted small mb-0">Tracking ID: <span class="fw-semibold text-dark">#CMPT-${complaint.id}</span></p>
        </div>
    </div>

    <c:if test="${not empty error}">
        <div class="alert alert-danger alert-dismissible fade show rounded-4 border-0 shadow-sm" role="alert">
            <div class="d-flex align-items-center">
                <div class="icon-circle bg-danger bg-opacity-10 text-danger me-3" style="width: 32px; height: 32px;">
                    <i class="bi bi-exclamation-triangle-fill"></i>
                </div>
                <div>${error}</div>
            </div>
            <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
        </div>
    </c:if>
    <c:if test="${not empty success}">
        <div class="alert alert-success alert-dismissible fade show rounded-4 border-0 shadow-sm" role="alert">
            <div class="d-flex align-items-center">
                <div class="icon-circle bg-success bg-opacity-10 text-success me-3" style="width: 32px; height: 32px;">
                    <i class="bi bi-check-circle-fill"></i>
                </div>
                <div>${success}</div>
            </div>
            <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
        </div>
    </c:if>

    <div class="row g-4">

        <div class="col-lg-7">
            <div class="card auth-card border-0 shadow-sm rounded-4 h-100">
                <div class="card-body p-4 p-md-5">

                    <div class="d-flex justify-content-between align-items-start mb-4 pb-4 border-bottom">
                        <div>
                            <h5 class="fw-semibold text-dark mb-2">${complaint.title}</h5>
                            <div class="d-flex align-items-center text-muted small gap-3">
                                <span><i class="bi bi-person me-1"></i> <span class="text-dark fw-medium">${complaint.user.fullName}</span></span>
                                <span><i class="bi bi-telephone me-1"></i> ${complaint.user.phoneNumber}</span>
                            </div>
                        </div>

                         <c:choose>
                            <c:when test="${complaint.status == 'PENDING'}">
                                <span class="badge bg-warning bg-opacity-10 text-warning px-3 py-2 rounded-pill fw-medium border border-warning border-opacity-25">Pending</span>
                            </c:when>
                            <c:when test="${complaint.status == 'IN_PROGRESS'}">
                                <span class="badge bg-primary bg-opacity-10 text-primary px-3 py-2 rounded-pill fw-medium border border-primary border-opacity-25">In Progress</span>
                            </c:when>
                            <c:when test="${complaint.status == 'RESOLVED'}">
                                <span class="badge bg-success bg-opacity-10 text-success px-3 py-2 rounded-pill fw-medium border border-success border-opacity-25">Resolved</span>
                            </c:when>
                            <c:when test="${complaint.status == 'REJECTED'}">
                                <span class="badge bg-danger bg-opacity-10 text-danger px-3 py-2 rounded-pill fw-medium border border-danger border-opacity-25">Rejected</span>
                            </c:when>
                            <c:otherwise>
                                <span class="badge bg-secondary bg-opacity-10 text-secondary px-3 py-2 rounded-pill fw-medium">${complaint.status}</span>
                            </c:otherwise>
                        </c:choose>
                    </div>

                    <div class="row g-3 mb-4">
                        <div class="col-sm-6">
                            <div class="p-3 bg-light rounded-4 h-100">
                                <div class="text-muted small text-uppercase tracking-wider fw-bold d-block mb-1">Category</div>
                                <div class="fw-medium text-dark"><i class="bi bi-tag text-muted me-2"></i>${complaint.category.name}</div>
                            </div>
                        </div>
                        <div class="col-sm-6">
                            <div class="p-3 bg-light rounded-4 h-100">
                                <div class="text-muted small text-uppercase tracking-wider fw-bold d-block mb-1">Location</div>
                                <div class="fw-medium text-dark"><i class="bi bi-geo-alt text-muted me-2"></i>${complaint.location}</div>
                            </div>
                        </div>
                    </div>

                    <div class="mb-5">
                        <h6 class="text-muted text-uppercase tracking-wider small fw-bold mb-3">Description provided by citizen</h6>
                        <div class="p-4 bg-light rounded-4">
                            <p class="text-dark mb-0 lh-lg" style="white-space: pre-wrap;">${complaint.description}</p>
                        </div>
                    </div>

                    <h6 class="text-muted text-uppercase tracking-wider small fw-bold mb-4">Recent History</h6>
                    <div class="position-relative ms-2">
                        <div class="position-absolute h-100 border-start border-2 border-primary border-opacity-25" style="left: 17px; top: 0;"></div>
                        <ul class="list-unstyled mb-0 position-relative z-1">
                            <c:forEach var="update" items="${updates}">
                                <li class="mb-4 position-relative">
                                    <div class="d-flex align-items-start">
                                        <div class="bg-white border text-primary border-primary rounded-circle d-flex align-items-center justify-content-center me-3 shadow-sm flex-shrink-0" style="width: 36px; height: 36px; margin-top: 2px;">
                                            <i class="bi bi-clock-history small"></i>
                                        </div>
                                        <div class="bg-light p-3 rounded-4 flex-grow-1 shadow-sm">
                                            <div class="d-flex justify-content-between align-items-center mb-2">
                                                <strong class="text-dark">${update.statusChangedTo}</strong>
                                                <small class="text-muted fw-medium">${fn:substring(update.updatedAt, 0, 10)}</small>
                                            </div>
                                            <p class="text-muted small mb-0 lh-base">${update.remarks} <span class="d-block mt-1 text-primary fw-medium" style="font-size: 0.75rem;">Recorded by ${update.updatedBy.fullName}</span></p>
                                        </div>
                                    </div>
                                </li>
                            </c:forEach>
                            <c:if test="${empty updates}">
                                <li class="text-muted small ms-5 fst-italic">No updates recorded yet.</li>
                            </c:if>
                        </ul>
                    </div>

                </div>
            </div>
        </div>

        <div class="col-lg-5">
            <div class="card auth-card border-0 shadow-sm rounded-4 h-100 position-relative overflow-hidden">
                <div class="position-absolute top-0 start-0 w-100 bg-dark" style="height: 4px;"></div>
                
                <div class="card-body p-4 p-md-5">
                    <h5 class="fw-semibold text-dark mb-4">
                        <div class="d-inline-flex align-items-center justify-content-center bg-dark bg-opacity-10 text-dark rounded-circle me-2" style="width: 36px; height: 36px;">
                            <i class="bi bi-pencil-square"></i>
                        </div>
                        Update Status
                    </h5>

                    <form action="<c:url value='/admin/complaints/update'/>" method="post">
                        <c:if test="${not empty _csrf}">
                            <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
                        </c:if>

                        <input type="hidden" name="complaintId" value="${complaint.id}">

                        <div class="mb-4">
                            <label for="status" class="form-label small fw-medium text-muted">Select New Status</label>
                            <select class="form-select form-select-lg bg-light border-0 shadow-none px-3 text-dark" id="status" name="status" required ${complaint.status == 'RESOLVED' || complaint.status == 'REJECTED' ? 'disabled' : ''}>
                                <option value="" disabled selected>Choose action...</option>
                                <c:if test="${complaint.status == 'PENDING'}">
                                    <option value="IN_PROGRESS" class="fw-medium">Mark as In Progress</option>
                                    <option value="REJECTED" class="text-danger fw-medium">Reject Complaint</option>
                                </c:if>
                                <c:if test="${complaint.status == 'IN_PROGRESS'}">
                                    <option value="RESOLVED" class="text-success fw-medium">Mark as Resolved</option>
                                </c:if>
                            </select>
                        </div>

                        <div class="mb-4">
                            <label for="remarks" class="form-label small fw-medium text-muted">Admin Remarks (Visible to Citizen)</label>
                            <textarea class="form-control bg-light border-0 shadow-none p-3" id="remarks" name="remarks" rows="5" placeholder="Provide an official response or notes here e.g., A team has been dispatched..." required ${complaint.status == 'RESOLVED' || complaint.status == 'REJECTED' ? 'disabled' : ''}></textarea>
                        </div>

                        <c:choose>
                            <c:when test="${complaint.status == 'RESOLVED' || complaint.status == 'REJECTED'}">
                                <div class="bg-secondary bg-opacity-10 rounded-4 p-3 d-flex align-items-center text-secondary small fw-medium">
                                    <i class="bi bi-lock-fill fs-5 me-3"></i> 
                                    This complaint is permanently closed and cannot be modified further.
                                </div>
                            </c:when>
                            <c:otherwise>
                                <button type="submit" class="btn btn-dark w-100 py-3 rounded-pill fw-medium shadow-sm d-flex align-items-center justify-content-center">
                                    <i class="bi bi-send me-2"></i> Update & Notify Citizen
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

<jsp:include page="/WEB-INF/views/common/footer.jsp" />