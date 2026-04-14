<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<jsp:include page="/WEB-INF/views/common/header.jsp" />

<jsp:include page="/WEB-INF/views/common/navbar.jsp" />

<div class="container py-5 d-flex justify-content-center">
    <div class="col-12 col-lg-8">

        <div class="mb-4">
            <h3 class="fw-bold text-dark d-flex align-items-center">
                <i class="bi bi-megaphone text-primary me-2"></i> Register New Complaint
            </h3>
            <p class="text-muted">Please provide accurate details to help us resolve the issue faster.</p>
        </div>

        <div class="card auth-card p-4 shadow-sm">
            <div class="card-body p-sm-3">

                <c:if test="${not empty error}">
                    <div class="alert alert-danger py-2 small rounded-3" role="alert">
                        <i class="bi bi-exclamation-triangle me-1"></i> ${error}
                    </div>
                </c:if>
                <c:if test="${not empty success}">
                    <div class="alert alert-success py-2 small rounded-3" role="alert">
                        <i class="bi bi-check-circle me-1"></i> ${success}
                        <a href="<c:url value='/user/complaints'/>" class="alert-link">View My Complaints</a>.
                    </div>
                </c:if>

                <form action="<c:url value='/user/complaints'/>" method="post">

                    <c:if test="${not empty _csrf}">
                        <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
                    </c:if>

                    <div class="row gx-4">

                        <div class="col-md-6 mb-4">
                            <label for="title" class="form-label small fw-semibold">Complaint Title</label>
                            <input type="text" class="form-control" id="title" name="title" placeholder="e.g., Broken Streetlight" required autofocus>
                        </div>

                        <div class="col-md-6 mb-4">
                            <label for="categoryId" class="form-label small fw-semibold">Category</label>
                            <select class="form-select text-dark" id="categoryId" name="categoryId" required>
                                <option value="" disabled selected>Select an issue category...</option>
                                <c:forEach var="cat" items="${categories}">
                                    <option value="${cat.id}">${cat.name}</option>
                                </c:forEach>
                            </select>
                        </div>

                        <div class="col-12 mb-4">
                            <label for="location" class="form-label small fw-semibold">Exact Location / Landmark</label>
                            <div class="input-group">
                                <span class="input-group-text bg-light border-end-0"><i class="bi bi-geo-alt text-muted"></i></span>
                                <input type="text" class="form-control border-start-0 ps-0" id="location" name="location" placeholder="Street name, landmark, or specific area" required>
                            </div>
                        </div>

                        <div class="col-12 mb-4">
                            <label for="description" class="form-label small fw-semibold">Detailed Description</label>
                            <textarea class="form-control bg-light" id="description" name="description" rows="5" placeholder="Describe the issue in detail. What exactly is the problem, and how long has it been occurring?" required style="resize: none;"></textarea>
                        </div>

                    </div>

                    <div class="d-flex justify-content-between align-items-center mt-2 border-top pt-4">
                        <a href="<c:url value='/user/dashboard'/>" class="btn btn-light text-muted fw-medium px-4">Cancel</a>
                        <button type="submit" class="btn btn-primary px-5 fw-semibold shadow-sm">
                            <i class="bi bi-send me-1"></i> Submit Complaint
                        </button>
                    </div>

                </form>

            </div>
        </div>
        </div>
</div>

<jsp:include page="/WEB-INF/views/common/footer.jsp" />