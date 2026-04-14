<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<jsp:include page="/WEB-INF/views/common/header.jsp" />

<jsp:include page="/WEB-INF/views/common/navbar.jsp" />

<div class="container py-5">

    <div class="row mb-4 align-items-center">
        <div class="col-md-8">
            <h2 class="fw-bold text-dark mb-1">
                Welcome, ${pageContext.request.userPrincipal.name}
            </h2>
            <p class="text-muted mb-0">Use the actions below to manage your complaints.</p>
        </div>
    </div>

    <div class="d-flex gap-3 flex-wrap">
        <a class="btn btn-primary" href="<c:url value='/user/submit'/>">
            <i class="bi bi-plus-circle me-1"></i> Submit Complaint
        </a>
        <a class="btn btn-outline-primary" href="<c:url value='/user/complaints'/>">
            <i class="bi bi-card-list me-1"></i> My Complaints
        </a>
    </div>

</div>

<jsp:include page="/WEB-INF/views/common/footer.jsp" />