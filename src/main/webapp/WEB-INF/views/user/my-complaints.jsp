<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fn" uri="jakarta.tags.functions" %>

<jsp:include page="/WEB-INF/views/common/header.jsp" />

<jsp:include page="/WEB-INF/views/common/navbar.jsp" />

<div class="container py-5">

    <div class="d-flex flex-column flex-md-row justify-content-between align-items-md-center mb-5">
        <div class="mb-3 mb-md-0">
            <div class="d-flex align-items-center mb-2">
                <div class="icon-circle bg-success bg-opacity-10 text-success me-3" style="width: 48px; height: 48px; font-size: 1.5rem;">
                    <i class="bi bi-card-checklist"></i>
                </div>
                <h2 class="fw-bold text-dark mb-0">My Complaints</h2>
            </div>
            <p class="text-secondary fs-6 ms-1 mb-0">Track the real-time status and updates of your reported issues.</p>
        </div>
        <a href="<c:url value='/user/submit'/>" class="btn btn-primary px-4 py-2 rounded-3 shadow-sm fw-semibold d-inline-flex align-items-center">
            <i class="bi bi-plus-lg me-2"></i> New Complaint
        </a>
    </div>

    <div class="card auth-card shadow-sm border-0 rounded-4 overflow-hidden">
        <div class="card-body p-0">

            <c:choose>
                <%-- IF NO COMPLAINTS EXIST --%>
                <c:when test="${empty complaints}">
                    <div class="text-center py-5 my-4">
                        <div class="bg-light rounded-circle d-inline-flex align-items-center justify-content-center mb-3" style="width: 80px; height: 80px;">
                            <i class="bi bi-inbox text-muted fs-1"></i>
                        </div>
                        <h4 class="fw-bold text-dark">No complaints found</h4>
                        <p class="text-secondary mb-4">You haven't registered any issues with us yet.</p>
                        <a href="<c:url value='/user/submit'/>" class="btn btn-outline-primary px-4 py-2 fw-medium rounded-pill">
                            Submit your first issue
                        </a>
                    </div>
                </c:when>

                <%-- IF COMPLAINTS EXIST --%>
                <c:otherwise>
                    <div class="table-responsive">
                        <table class="table table-borderless table-hover align-middle mb-0">
                            <thead class="bg-light border-bottom text-muted small text-uppercase tracking-wider">
                                <tr>
                                    <th class="ps-4 py-3 fw-semibold">Tracking ID</th>
                                    <th class="py-3 fw-semibold">Title</th>
                                    <th class="py-3 fw-semibold">Category</th>
                                    <th class="py-3 fw-semibold">Date</th>
                                    <th class="py-3 fw-semibold">Status</th>
                                    <th class="pe-4 py-3 fw-semibold text-end">Action</th>
                                </tr>
                            </thead>
                            <tbody class="border-top-0">
                                <c:forEach var="complaint" items="${complaints}">
                                    <tr class="border-bottom">
                                        <td class="ps-4 py-4">
                                            <span class="badge bg-light text-dark border px-2 py-1 font-monospace fs-6">#CMPT-${complaint.id}</span>
                                        </td>
                                        <td class="py-4">
                                            <span class="d-block fw-semibold text-dark text-truncate" style="max-width: 250px;" title="${complaint.title}">
                                                ${complaint.title}
                                            </span>
                                        </td>
                                        <td class="py-4 text-secondary small fw-medium">
                                            <i class="bi bi-tag me-1 text-muted"></i> ${complaint.category.name}
                                        </td>

                                        <td class="py-4 text-secondary small">
                                            <i class="bi bi-calendar3 me-1 text-muted"></i> ${fn:substring(complaint.createdAt, 0, 10)}
                                        </td>

                                        <td class="py-4">
                                            <c:choose>
                                                <c:when test="${complaint.status == 'PENDING'}">
                                                    <span class="badge bg-warning bg-opacity-10 text-warning px-3 py-2 rounded-pill small border border-warning border-opacity-25">Pending</span>
                                                </c:when>
                                                <c:when test="${complaint.status == 'IN_PROGRESS'}">
                                                    <span class="badge bg-primary bg-opacity-10 text-primary px-3 py-2 rounded-pill small border border-primary border-opacity-25">In Progress</span>
                                                </c:when>
                                                <c:when test="${complaint.status == 'RESOLVED'}">
                                                    <span class="badge bg-success bg-opacity-10 text-success px-3 py-2 rounded-pill small border border-success border-opacity-25">Resolved</span>
                                                </c:when>
                                                <c:when test="${complaint.status == 'REJECTED'}">
                                                    <span class="badge bg-danger bg-opacity-10 text-danger px-3 py-2 rounded-pill small border border-danger border-opacity-25">Rejected</span>
                                                </c:when>
                                            </c:choose>
                                        </td>
                                        <td class="pe-4 py-4 text-end">
                                            <a href="<c:url value='/user/complaints/${complaint.id}'/>" class="btn btn-sm btn-light bg-white border shadow-sm text-primary fw-medium px-3 rounded-3 hover-lift">
                                                View <i class="bi bi-arrow-right ms-1 small"></i>
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