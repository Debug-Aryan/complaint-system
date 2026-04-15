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
            <a href="<c:url value='/admin/reports'/>" class="btn btn-light border bg-white shadow-sm text-dark px-3 py-2 rounded-pill fw-medium transition-all">
                <i class="bi bi-file-earmark-bar-graph me-1"></i> Analytics
            </a>
            <button class="btn btn-white border bg-white shadow-sm text-muted px-3 py-2 rounded-pill transition-all" onclick="window.location.reload();">
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
                </c:otherwise>
            </c:choose>

        </div>
    </div>

</div>

<jsp:include page="/WEB-INF/views/common/footer.jsp" />

<jsp:include page="/WEB-INF/views/common/footer.jsp" />