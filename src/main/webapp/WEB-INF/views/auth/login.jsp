<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<jsp:include page="/WEB-INF/views/common/header.jsp" />

<jsp:include page="/WEB-INF/views/common/navbar.jsp" />

<div class="container d-flex justify-content-center align-items-center" style="min-height: 100vh;">
    <div class="col-12 col-md-6 col-lg-4">

        <div class="card auth-card p-4">
            <div class="card-body">
                <div class="text-center mb-4">
                    <i class="bi bi-shield-lock text-primary" style="font-size: 2.5rem;"></i>
                    <h3 class="mt-2 fw-bold">Welcome Back</h3>
                    <p class="text-muted small">Sign in to your account</p>
                </div>

                <c:if test="${param.error != null}">
                    <div class="alert alert-danger py-2 small rounded-3" role="alert">
                        <i class="bi bi-exclamation-circle me-1"></i> Invalid email or password.
                    </div>
                </c:if>
                <c:if test="${param.logout != null}">
                    <div class="alert alert-success py-2 small rounded-3" role="alert">
                        <i class="bi bi-check-circle me-1"></i> You have been logged out successfully.
                    </div>
                </c:if>

                <form action="<c:url value='/login'/>" method="post">

                    <c:if test="${not empty _csrf}">
                        <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
                    </c:if>

                    <div class="mb-3">
                        <label for="email" class="form-label small fw-semibold">Email address</label>
                        <input type="email" class="form-control" id="email" name="email" placeholder="name@example.com" required autofocus>
                    </div>

                    <div class="mb-4">
                        <label for="password" class="form-label small fw-semibold">Password</label>
                        <input type="password" class="form-control" id="password" name="password" placeholder="••••••••" required>
                    </div>

                    <button type="submit" class="btn btn-primary w-100 mb-3">Sign In</button>

                    <div class="text-center small">
                        <span class="text-muted">Don't have an account?</span>
                        <a href="<c:url value='/register'/>" class="text-decoration-none fw-semibold">Register here</a>
                    </div>
                </form>

            </div>
        </div>
        </div>
</div>

<jsp:include page="/WEB-INF/views/common/footer.jsp" />