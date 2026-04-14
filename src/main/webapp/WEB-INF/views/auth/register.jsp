<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<jsp:include page="/WEB-INF/views/common/header.jsp" />

<jsp:include page="/WEB-INF/views/common/navbar.jsp" />

<div class="container d-flex justify-content-center align-items-center py-5" style="min-height: 100vh;">
    <div class="col-12 col-md-8 col-lg-5">

        <div class="card auth-card p-4">
            <div class="card-body">
                <div class="text-center mb-4">
                    <i class="bi bi-person-plus text-primary" style="font-size: 2.5rem;"></i>
                    <h3 class="mt-2 fw-bold">Create an Account</h3>
                    <p class="text-muted small">Join the Smart Complaint System</p>
                </div>

                <c:if test="${not empty error}">
                    <div class="alert alert-danger py-2 small rounded-3" role="alert">
                        <i class="bi bi-exclamation-triangle me-1"></i> ${error}
                    </div>
                </c:if>
                <c:if test="${not empty success}">
                    <div class="alert alert-success py-2 small rounded-3" role="alert">
                        <i class="bi bi-check-circle me-1"></i> ${success} <a href="${pageContext.request.contextPath}/login" class="alert-link">Login here</a>.
                    </div>
                </c:if>

                <form action="<c:url value='/register'/>" method="post">

                    <c:if test="${not empty _csrf}">
                        <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
                    </c:if>

                    <div class="mb-3">
                        <label for="fullName" class="form-label small fw-semibold">Name</label>
                        <input type="text" class="form-control" id="fullName" name="fullName" placeholder="John Doe" required>
                    </div>

                    <div class="mb-3">
                        <label for="email" class="form-label small fw-semibold">Email address</label>
                        <input type="email" class="form-control" id="email" name="email" placeholder="name@example.com" required>
                    </div>

                    <div class="row">
                        <div class="col-md-6 mb-3">
                            <label for="password" class="form-label small fw-semibold">Password</label>
                            <input type="password" class="form-control" id="password" name="password" placeholder="••••••••" required>
                        </div>
                        <div class="col-md-6 mb-4">
                            <label for="phoneNumber" class="form-label small fw-semibold">Phone Number</label>
                            <input type="tel" class="form-control" id="phoneNumber" name="phoneNumber" placeholder="+1234567890" required>
                        </div>
                    </div>

                    <c:set var="selectedRole" value="${empty param.roleName ? 'ROLE_CITIZEN' : param.roleName}" />
                    <div class="mb-4">
                        <label for="roleName" class="form-label small fw-semibold">Role</label>
                        <select class="form-select" id="roleName" name="roleName" required>
                            <option value="ROLE_CITIZEN" ${selectedRole == 'ROLE_CITIZEN' ? 'selected' : ''}>Citizen</option>
                            <option value="ROLE_ADMIN" ${selectedRole == 'ROLE_ADMIN' ? 'selected' : ''}>Admin</option>
                        </select>
                    </div>

                    <button type="submit" class="btn btn-primary w-100 mb-3">Create Account</button>

                    <div class="text-center small">
                        <span class="text-muted">Already have an account?</span>
                        <a href="<c:url value='/login'/>" class="text-decoration-none fw-semibold">Sign in</a>
                    </div>
                </form>

            </div>
        </div>

    </div>
</div>

<jsp:include page="/WEB-INF/views/common/footer.jsp" />