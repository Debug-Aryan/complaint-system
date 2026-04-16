<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<jsp:include page="/WEB-INF/views/common/header.jsp" />

<div class="container-fluid p-0">
    <div class="row g-0 auth-viewport min-vh-100">
        <!-- Left Side: Gradient/Branding -->
        <div class="col-lg-6 d-none d-lg-flex bg-primary bg-gradient align-items-center justify-content-center text-white position-relative overflow-hidden">
            <div class="text-center position-relative z-3 px-5">
                <i class="bi bi-shield-check display-1 mb-4"></i>
                <h1 class="fw-bold display-4 mb-3">Smart Complaint System</h1>
                <p class="lead fw-light px-4">Experience a seamless, transparent, and secure way to resolve your issues.</p>
            </div>
            <!-- Decorative circles -->
            <div class="position-absolute rounded-circle bg-white" style="width: 400px; height: 400px; top: -100px; left: -100px; opacity: 0.1; z-index: 0;"></div>
            <div class="position-absolute rounded-circle bg-white" style="width: 600px; height: 600px; bottom: -200px; right: -200px; opacity: 0.1; z-index: 0;"></div>
        </div>

        <!-- Right Side: Login Form -->
        <div class="col-12 col-lg-6 d-flex align-items-center justify-content-center bg-white shadow-lg py-5 px-3 px-sm-5 mx-auto">
            <div class="w-100" style="max-width: 450px;">
                <div class="text-center mb-5 d-lg-none">
                    <i class="bi bi-shield-lock text-primary" style="font-size: 3.5rem;"></i>
                </div>
                
                <h2 class="fw-bold mb-2">Welcome Back</h2>
                <p class="text-muted mb-4 small">Please enter your details to sign in.</p>

                <c:if test="${param.error != null}">
                    <div class="alert alert-danger py-2 small rounded-3 d-flex align-items-center" role="alert">
                        <i class="bi bi-exclamation-triangle-fill flex-shrink-0 me-2"></i>
                        <div>Invalid email or password.</div>
                    </div>
                </c:if>
                <c:if test="${param.logout != null}">
                    <div class="alert alert-success py-2 small rounded-3 d-flex align-items-center" role="alert">
                        <i class="bi bi-check-circle-fill flex-shrink-0 me-2"></i>
                        <div>You have been logged out successfully.</div>
                    </div>
                </c:if>

                <form action="<c:url value='/login'/>" method="post">

                    <c:if test="${not empty _csrf}">
                        <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
                    </c:if>

                    <div class="form-floating mb-3">
                        <input type="email" class="form-control" id="email" name="email" placeholder="name@example.com" required autofocus>
                        <label for="email" class="text-muted">Email address</label>
                    </div>

                    <div class="form-floating mb-4">
                        <input type="password" class="form-control" id="password" name="password" placeholder="Password" required>
                        <label for="password" class="text-muted">Password</label>
                    </div>

                    <button type="submit" class="btn btn-primary w-100 py-3 mb-4 fw-bold shadow-sm rounded-pill transition-all">Sign In</button>

                    <div class="text-center small">
                        <span class="text-muted">Don't have an account?</span>
                        <a href="<c:url value='/register'/>" class="text-decoration-none fw-semibold ms-1">Create an account</a>
                    </div>
                </form>

            </div>
        </div>
    </div>
</div>

<jsp:include page="/WEB-INF/views/common/footer.jsp">
    <jsp:param name="hideAuthButtons" value="true" />
</jsp:include>
