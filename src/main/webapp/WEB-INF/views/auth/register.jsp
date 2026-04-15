<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<jsp:include page="/WEB-INF/views/common/header.jsp" />

<jsp:include page="/WEB-INF/views/common/navbar.jsp">
    <jsp:param name="hideAuthButtons" value="true" />
</jsp:include>

<div class="container-fluid p-0">
    <div class="row g-0 auth-viewport">
        <!-- Left Side: Gradient/Branding -->
        <div class="col-lg-6 d-none d-lg-flex bg-primary bg-gradient align-items-center justify-content-center text-white position-relative overflow-hidden">
            <div class="text-center position-relative z-3 px-5">
                <i class="bi bi-people-fill display-1 mb-4"></i>
                <h1 class="fw-bold display-4 mb-3">Join Us Today</h1>
                <p class="lead fw-light px-4">Register in seconds to enjoy seamless access to the Smart Complaint System.</p>
            </div>
            <!-- Decorative circles -->
            <div class="position-absolute rounded-circle bg-white" style="width: 500px; height: 500px; top: -150px; right: -150px; opacity: 0.1; z-index: 0;"></div>
            <div class="position-absolute rounded-circle bg-white" style="width: 300px; height: 300px; bottom: 50px; left: -100px; opacity: 0.1; z-index: 0;"></div>
        </div>

        <!-- Right Side: Register Form -->
        <div class="col-12 col-lg-6 d-flex align-items-center justify-content-center bg-white shadow-lg py-5 px-3 px-sm-5 mx-auto">
            <div class="w-100" style="max-width: 500px;">
                <div class="text-center mb-4 d-lg-none">
                    <i class="bi bi-person-plus text-primary" style="font-size: 3.5rem;"></i>
                </div>
                
                <h2 class="fw-bold mb-2">Create an Account</h2>
                <p class="text-muted mb-4 small">Enter your details to register.</p>

                <c:if test="${not empty error}">
                    <div class="alert alert-danger py-2 small rounded-3 d-flex align-items-center" role="alert">
                        <i class="bi bi-exclamation-triangle-fill flex-shrink-0 me-2"></i>
                        <div>${error}</div>
                    </div>
                </c:if>
                <c:if test="${not empty success}">
                    <div class="alert alert-success py-2 small rounded-3 d-flex align-items-center" role="alert">
                        <i class="bi bi-check-circle-fill flex-shrink-0 me-2"></i>
                        <div>${success} <a href="${pageContext.request.contextPath}/login" class="alert-link">Login here</a>.</div>
                    </div>
                </c:if>

                <form action="<c:url value='/register'/>" method="post">

                    <c:if test="${not empty _csrf}">
                        <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
                    </c:if>

                    <div class="form-floating mb-3">
                        <input type="text" class="form-control" id="fullName" name="fullName" placeholder="John Doe" required>
                        <label for="fullName" class="text-muted">Full Name</label>
                    </div>

                    <div class="form-floating mb-3">
                        <input type="email" class="form-control" id="email" name="email" placeholder="name@example.com" required>
                        <label for="email" class="text-muted">Email address</label>
                    </div>

                    <c:set var="selectedRole" value="${empty param.roleName ? 'ROLE_CITIZEN' : param.roleName}" />
                    <div class="row g-3 mb-3">
                        <div class="col-md-6">
                            <div class="form-floating">
                                <select class="form-select" id="roleName" name="roleName" required>
                                    <option value="ROLE_CITIZEN" ${selectedRole == 'ROLE_CITIZEN' ? 'selected' : ''}>Citizen</option>
                                    <option value="ROLE_ADMIN" ${selectedRole == 'ROLE_ADMIN' ? 'selected' : ''}>Admin</option>
                                </select>
                                <label for="roleName" class="text-muted">Role</label>
                            </div>
                        </div>
                        <div class="col-md-6">
                            <div class="form-floating">
                                <input type="tel" class="form-control" id="phoneNumber" name="phoneNumber" placeholder="+1234567890" required>
                                <label for="phoneNumber" class="text-muted">Phone Number</label>
                            </div>
                        </div>
                    </div>

                    <div class="form-floating mb-4">
                        <input type="password" class="form-control" id="password" name="password" placeholder="Password" required>
                        <label for="password" class="text-muted">Password</label>
                        <div class="form-text mt-1"><i class="bi bi-info-circle me-1"></i>Use 8+ characters for a stronger password.</div>
                    </div>

                    <button type="submit" class="btn btn-primary w-100 py-3 mb-4 fw-bold shadow-sm rounded-pill transition-all">Create Account</button>

                    <div class="text-center small">
                        <span class="text-muted">Already have an account?</span>
                        <a href="<c:url value='/login'/>" class="text-decoration-none fw-semibold ms-1">Sign in here</a>
                    </div>
                </form>

            </div>
        </div>
    </div>
</div>

<jsp:include page="/WEB-INF/views/common/footer.jsp" />