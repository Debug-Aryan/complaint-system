<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fn" uri="jakarta.tags.functions" %>

<c:set var="hideAuthButtons" value="${param.hideAuthButtons == 'true'}" />
<c:set var="currentUrl" value="${requestScope['jakarta.servlet.forward.request_uri']}" />

<c:choose>
<c:when test="${hideAuthButtons}">
    <!-- Top Navbar for Auth Pages only -->
    <nav class="navbar navbar-expand-lg navbar-light bg-white shadow-sm sticky-top py-3">
        <div class="container">
            <a class="navbar-brand fw-bold text-primary d-flex align-items-center" href="<c:url value='/'/>">
                <i class="bi bi-shield-check me-2 fs-4"></i> Smart Complaint
            </a>
        </div>
    </nav>
</c:when>

<c:otherwise>
    <!-- Sidebar Application Layout for Logged in Users -->
    <div class="app-wrapper">
        
        <div class="sidebar-backdrop" id="sidebarBackdrop"></div>

        <!-- Sidebar -->
        <div class="sidebar-wrapper" id="sidebar">
            <a class="sidebar-brand fw-bold" href="<c:url value='/'/>">
                <div class="bg-primary bg-opacity-10 text-primary rounded d-flex align-items-center justify-content-center me-2" style="width: 36px; height: 36px;">
                    <i class="bi bi-shield-check"></i>
                </div>
                <span>Smart Complaint</span>
            </a>

            <div class="d-flex flex-column flex-grow-1 p-3">
                <p class="text-secondary small fw-bold text-uppercase tracking-wider mb-2 px-2">Navigation</p>
                <div class="nav flex-column">
                    <c:if test="${pageContext.request.isUserInRole('CITIZEN')}">
                        <a class="sidebar-link ${fn:contains(currentUrl, '/user/dashboard') ? 'active' : ''}" href="<c:url value='/user/dashboard'/>">
                            <i class="bi bi-house-door me-2"></i> Dashboard
                        </a>
                        <a class="sidebar-link ${fn:contains(currentUrl, '/user/submit') ? 'active' : ''}" href="<c:url value='/user/submit'/>">
                            <i class="bi bi-plus-circle me-2"></i> New Complaint
                        </a>
                        <a class="sidebar-link ${fn:contains(currentUrl, '/user/complaints') and not fn:contains(currentUrl, '/submit') ? 'active' : ''}" href="<c:url value='/user/complaints'/>">
                            <i class="bi bi-card-list me-2"></i> My Complaints
                        </a>
                    </c:if>

                    <c:if test="${pageContext.request.isUserInRole('ADMIN')}">
                        <a class="sidebar-link ${fn:contains(currentUrl, '/admin/dashboard') ? 'active' : ''}" href="<c:url value='/admin/dashboard'/>">
                            <i class="bi bi-speedometer2 me-2"></i> Admin Panel
                        </a>
                        <a class="sidebar-link ${fn:contains(currentUrl, '/admin/complaints') ? 'active' : ''}" href="<c:url value='/admin/complaints'/>">
                            <i class="bi bi-kanban me-2"></i> Manage Complaints
                        </a>
                        <a class="sidebar-link ${fn:contains(currentUrl, '/admin/reports') ? 'active' : ''}" href="<c:url value='/admin/reports'/>">
                            <i class="bi bi-bar-chart me-2"></i> Reports
                        </a>
                    </c:if>
                </div>

                <div class="mt-auto">
                    <p class="text-secondary small fw-bold text-uppercase tracking-wider mb-2 px-2">Account</p>
                    <div class="bg-light rounded-3 p-3 mb-2 d-flex align-items-center">
                        <div class="bg-white border rounded-circle d-flex align-items-center justify-content-center me-2 text-primary fw-bold" style="width: 32px; height: 32px;">
                            ${fn:substring(pageContext.request.userPrincipal.principal.fullName, 0, 1)}
                        </div>
                        <div class="text-truncate">
                            <span class="d-block fw-semibold text-dark text-truncate" style="font-size: 0.9rem;">${pageContext.request.userPrincipal.principal.fullName}</span>
                            <span class="d-block text-muted text-truncate" style="font-size: 0.75rem;">${pageContext.request.userPrincipal.name}</span>
                        </div>
                    </div>
                    
                    <form action="<c:url value='/logout'/>" method="post" class="m-0 w-100">
                        <c:if test="${not empty _csrf}">
                            <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
                        </c:if>
                        <button type="submit" class="sidebar-link w-100 border-0 bg-transparent text-danger">
                            <i class="bi bi-box-arrow-right text-danger me-2"></i> Logout
                        </button>
                    </form>
                </div>
            </div>
        </div>

        <!-- Main Content Area -->
        <div class="main-content d-flex flex-column">

            <!-- Mobile Topbar Header -->
            <div class="d-lg-none bg-white border-bottom shadow-sm d-flex align-items-center justify-content-between px-3 py-3 sticky-top">
                <a class="fw-bold text-primary text-decoration-none d-flex align-items-center" href="<c:url value='/'/>">
                    <i class="bi bi-shield-check me-2 fs-4"></i> Smart Complaint
                </a>
                <button type="button" class="btn border-0 p-1 bg-light text-primary rounded" id="sidebarToggle">
                    <i class="bi bi-list fs-3"></i>
                </button>
            </div>
</c:otherwise>
</c:choose>
