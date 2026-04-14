<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fn" uri="jakarta.tags.functions" %>

<jsp:include page="/WEB-INF/views/common/header.jsp" />

<jsp:include page="/WEB-INF/views/common/navbar.jsp" />

<div class="container py-5">

    <div class="d-flex justify-content-between align-items-center mb-4 flex-wrap">
        <div>
            <h3 class="fw-bold text-dark mb-1">My Complaints</h3>
            <p class="text-muted mb-0">Track the status of your reported issues.</p>
        </div>
        <a href="<c:url value='/user/submit'/>" class="btn btn-primary shadow-sm mt-3 mt-md-0">
            <i class="bi bi-plus-lg me-1"></i> New Complaint
        </a>
    </div>

    <div class="card auth-card shadow-sm border-0">
        <div class="card-body p-0">

            <c:choose>
                <%-- IF NO COMPLAINTS EXIST --%>
                <c:when test="${empty complaints}">
                    <div class="text-center py-5">
                        <i class="bi bi-inbox text-muted mb-3" style="font-size: 4rem;"></i>
                        <h5 class="fw-bold text-dark">No complaints found</h5>
                        <p class="text-muted small">You haven't registered any complaints yet.</p>
                        <a href="<c:url value='/user/submit'/>" class="btn btn-outline-primary mt-2">Submit your first issue</a>
                    </div>
                </c:when>

                <%-- IF COMPLAINTS EXIST --%>
                <c:otherwise>
                    <div class="table-responsive">
                        <table class="table table-hover align-middle mb-0">
                            <thead class="bg-light text-muted small text-uppercase tracking-wide">
                                <tr>
                                    <th class="ps-4 py-3">Tracking ID</th>
                                    <th class="py-3">Title</th>
                                    <th class="py-3">Category</th>
                                    <th class="py-3">Date</th>
                                    <th class="py-3">Status</th>
                                    <th class="pe-4 py-3 text-end">Action</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach var="complaint" items="${complaints}">
                                    <tr>
                                        <td class="ps-4 fw-semibold text-dark">#CMPT-${complaint.id}</td>
                                        <td>
                                            <span class="d-block text-truncate" style="max-width: 250px;" title="${complaint.title}">
                                                ${complaint.title}
                                            </span>
                                        </td>
                                        <td class="text-muted small">${complaint.category.name}</td>

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
                                        <td class="pe-4 text-end">
                                            <a href="<c:url value='/user/complaints/${complaint.id}'/>" class="btn btn-sm btn-light border fw-medium text-primary">
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