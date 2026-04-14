<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<nav class="navbar navbar-expand-lg navbar-light bg-white shadow-sm sticky-top py-3">
    <div class="container">

        <a class="navbar-brand fw-bold text-primary d-flex align-items-center" href="<c:url value='/'/>">
            <i class="bi bi-shield-check me-2 fs-4"></i>
            Smart Complaint
        </a>

        <button class="navbar-toggler border-0 shadow-none" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
        </button>

        <div class="collapse navbar-collapse" id="navbarNav">

            <ul class="navbar-nav me-auto mb-2 mb-lg-0 fw-medium">

                <c:if test="${pageContext.request.isUserInRole('CITIZEN')}">
                    <li class="nav-item">
                        <a class="nav-link px-3" href="<c:url value='/user/dashboard'/>">
                            <i class="bi bi-house-door me-1"></i> Dashboard
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link px-3" href="<c:url value='/user/submit'/>">
                            <i class="bi bi-plus-circle me-1"></i> New Complaint
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link px-3" href="<c:url value='/user/complaints'/>">
                            <i class="bi bi-card-list me-1"></i> My Complaints
                        </a>
                    </li>
                </c:if>

                <c:if test="${pageContext.request.isUserInRole('ADMIN')}">
                    <li class="nav-item">
                        <a class="nav-link px-3" href="<c:url value='/admin/dashboard'/>">
                            <i class="bi bi-speedometer2 me-1"></i> Admin Panel
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link px-3" href="<c:url value='/admin/complaints'/>">
                            <i class="bi bi-kanban me-1"></i> Manage Complaints
                        </a>
                    </li>
                </c:if>

            </ul>

            <ul class="navbar-nav ms-auto align-items-center">
                <c:choose>
                    <c:when test="${not empty pageContext.request.userPrincipal}">

                        <li class="nav-item me-3 d-none d-lg-block">
                            <span class="text-muted small">Welcome, </span>
                            <span class="fw-bold text-dark">${pageContext.request.userPrincipal.name}</span>
                        </li>

                        <li class="nav-item">
                            <form action="<c:url value='/logout'/>" method="post" class="m-0">
                                <c:if test="${not empty _csrf}">
                                    <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
                                </c:if>
                                <button type="submit" class="btn btn-outline-danger btn-sm rounded-pill px-4 fw-semibold">
                                    <i class="bi bi-box-arrow-right me-1"></i> Logout
                                </button>
                            </form>
                        </li>

                    </c:when>
                    <c:otherwise>
                        <li class="nav-item">
                            <a class="btn btn-primary btn-sm rounded-pill px-4 fw-semibold" href="<c:url value='/login'/>">Login</a>
                        </li>
                    </c:otherwise>
                </c:choose>
            </ul>

        </div>
    </div>
</nav>