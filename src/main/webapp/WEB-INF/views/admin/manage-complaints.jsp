<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fn" uri="jakarta.tags.functions" %>

<jsp:include page="/WEB-INF/views/common/header.jsp" />

<jsp:include page="/WEB-INF/views/common/navbar.jsp" />

<div class="container py-5">

    <div class="d-flex justify-content-between align-items-center mb-4 flex-wrap">
        <div>
            <h3 class="fw-bold text-dark mb-1">Manage Complaints</h3>
            <p class="text-muted mb-0">Review, filter, and process citizen grievances.</p>
        </div>
    </div>

    <div class="card auth-card shadow-sm border-0">
        <div class="card-body p-0">

            <c:choose>
                <c:when test="${empty complaints}">
                    <div class="text-center py-5">
                        <i class="bi bi-search text-muted mb-3" style="font-size: 3rem;"></i>
                        <h5 class="fw-bold text-dark">No complaints found</h5>
                        <p class="text-muted small">Try adjusting your filters.</p>
                    </div>
                </c:when>
                <c:otherwise>
                    <div class="table-responsive">
                        <table class="table table-hover align-middle mb-0">
                            <thead class="bg-light text-muted small text-uppercase tracking-wide">
                                <tr>
                                    <th class="ps-4 py-3">ID</th>
                                    <th class="py-3">Citizen Name</th>
                                    <th class="py-3">Issue Category</th>
                                    <th class="py-3">Date</th>
                                    <th class="py-3">Status</th>
                                    <th class="py-3">Remarks</th>
                                    <th class="pe-4 py-3 text-end">Update</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach var="complaint" items="${complaints}">
                                    <tr>
                                        <td class="ps-4 fw-semibold text-dark">#${complaint.id}</td>
                                        <td>
                                            <span class="d-block text-dark fw-medium">${complaint.user.fullName}</span>
                                            <span class="text-muted small">${complaint.user.email}</span>
                                        </td>
                                        <td>
                                            <span class="badge bg-secondary bg-opacity-10 text-secondary border">
                                                ${complaint.category.name}
                                            </span>
                                        </td>
                                        <td class="text-muted small">${fn:substring(complaint.createdAt, 0, 10)}</td>
                                        <td>
                                            <c:choose>
                                                <c:when test="${complaint.status == 'PENDING'}">
                                                    <span class="badge bg-warning text-dark px-3 py-2 rounded-pill small">Pending</span>
                                                </c:when>
                                                <c:when test="${complaint.status == 'IN_PROGRESS'}">
                                                    <span class="badge bg-primary px-3 py-2 rounded-pill small">In Progress</span>
                                                </c:when>
                                                <c:when test="${complaint.status == 'RESOLVED'}">
                                                    <span class="badge bg-success px-3 py-2 rounded-pill small">Resolved</span>
                                                </c:when>
                                                <c:when test="${complaint.status == 'REJECTED'}">
                                                    <span class="badge bg-danger px-3 py-2 rounded-pill small">Rejected</span>
                                                </c:when>
                                            </c:choose>
                                        </td>
                                        <td>
                                            <form action="<c:url value='/admin/complaints/update'/>" method="post" class="d-flex gap-2">
                                                <c:if test="${not empty _csrf}">
                                                    <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
                                                </c:if>
                                                <input type="hidden" name="complaintId" value="${complaint.id}" />
                                                <select class="form-select form-select-sm" name="status" required ${complaint.status == 'RESOLVED' || complaint.status == 'REJECTED' ? 'disabled' : ''}>
                                                    <option value="" disabled selected>Change status...</option>
                                                    <c:if test="${complaint.status == 'PENDING'}">
                                                        <option value="IN_PROGRESS">IN_PROGRESS</option>
                                                        <option value="REJECTED">REJECTED</option>
                                                    </c:if>
                                                    <c:if test="${complaint.status == 'IN_PROGRESS'}">
                                                        <option value="RESOLVED">RESOLVED</option>
                                                    </c:if>
                                                </select>
                                                <input class="form-control form-control-sm" name="remarks" placeholder="Remarks" required ${complaint.status == 'RESOLVED' || complaint.status == 'REJECTED' ? 'disabled' : ''} />
                                                <button class="btn btn-sm btn-primary" type="submit" ${complaint.status == 'RESOLVED' || complaint.status == 'REJECTED' ? 'disabled' : ''}>Save</button>
                                            </form>
                                        </td>
                                        <td class="pe-4 text-end">
                                            <a class="btn btn-sm btn-outline-secondary" href="<c:url value='/admin/complaints/${complaint.id}'/>">View</a>
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