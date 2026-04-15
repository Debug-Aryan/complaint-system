<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<jsp:include page="/WEB-INF/views/common/header.jsp" />

<jsp:include page="/WEB-INF/views/common/navbar.jsp" />

<div class="container py-5 d-flex justify-content-center">
    <div class="col-12 col-lg-8">

        <div class="mb-4 text-center">
            <div class="icon-circle bg-primary bg-opacity-10 text-primary mx-auto mb-3" style="width: 72px; height: 72px; font-size: 2rem;">
                <i class="bi bi-megaphone"></i>
            </div>
            <h2 class="fw-bold text-dark mb-2">Register New Complaint</h2>
            <p class="text-secondary fs-5">Please provide accurate details to help us resolve the issue faster.</p>
        </div>

        <div class="card auth-card p-4 shadow-sm rounded-4 border-0">
            <div class="card-body p-sm-4">

                <c:if test="${not empty error}">
                    <div class="alert alert-danger py-3 small rounded-3 border-0 bg-danger bg-opacity-10 text-danger" role="alert">
                        <i class="bi bi-exclamation-triangle-fill me-2 fs-5 align-middle"></i> ${error}
                    </div>
                </c:if>
                <c:if test="${not empty success}">
                    <div class="alert alert-success py-3 small rounded-3 border-0 bg-success bg-opacity-10 text-success" role="alert">
                        <i class="bi bi-check-circle-fill me-2 fs-5 align-middle"></i> ${success}
                        <a href="<c:url value='/user/complaints'/>" class="alert-link ms-1">View My Complaints</a>
                    </div>
                </c:if>

                <form action="<c:url value='/user/complaints'/>" method="post">

                    <c:if test="${not empty _csrf}">
                        <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
                    </c:if>

                    <div class="row gx-4 mt-2">

                        <div class="col-md-6 mb-4">
                            <label for="title" class="form-label small fw-semibold text-secondary text-uppercase tracking-wider">Complaint Title</label>
                            <input type="text" class="form-control form-control-lg fs-6 bg-light border-0" id="title" name="title" placeholder="e.g., Broken Streetlight" required autofocus>
                        </div>

                        <div class="col-md-6 mb-4">
                            <label for="categoryId" class="form-label small fw-semibold text-secondary text-uppercase tracking-wider">Category</label>
                            <select class="form-select form-select-lg fs-6 bg-light border-0 text-dark" id="categoryId" name="categoryId" required>
                                <option value="" disabled selected>Select an issue category...</option>
                                <c:forEach var="cat" items="${categories}">
                                    <option value="${cat.id}">${cat.name}</option>
                                </c:forEach>
                            </select>
                        </div>

                        <div class="col-12 mb-4">
                            <label for="location" class="form-label small fw-semibold text-secondary text-uppercase tracking-wider">Exact Location / Landmark</label>
                            <div class="input-group input-group-lg">
                                <span class="input-group-text bg-light border-0 text-muted px-4"><i class="bi bi-geo-alt"></i></span>
                                <input type="text" class="form-control fs-6 bg-light border-0 ps-2" id="location" name="location" placeholder="Street name, landmark, or specific area" required>
                            </div>
                        </div>

                        <div class="col-12 mb-4">
                            <label for="description" class="form-label small fw-semibold text-secondary text-uppercase tracking-wider">Detailed Description</label>
                            <textarea class="form-control form-control-lg fs-6 bg-light border-0" id="description" name="description" rows="5" placeholder="Describe the issue in detail. What exactly is the problem, and how long has it been occurring?" required style="resize: none;"></textarea>
                        </div>

                    </div>

                    <div class="d-flex justify-content-between align-items-center mt-3 pt-4 border-top">
                        <a href="<c:url value='/user/dashboard'/>" class="btn btn-link text-muted fw-medium text-decoration-none px-0">
                            <i class="bi bi-arrow-left me-1"></i> Back to Dashboard
                        </a>
                        <button type="submit" class="btn btn-primary btn-lg px-5 fw-semibold rounded-3 shadow-sm">
                            Submit Complaint <i class="bi bi-arrow-right ms-2"></i>
                        </button>
                    </div>

                </form>

            </div>
        </div>
    </div>
</div>

<jsp:include page="/WEB-INF/views/common/footer.jsp" />