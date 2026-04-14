<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<jsp:include page="/WEB-INF/views/common/header.jsp" />

<div class="container d-flex justify-content-center align-items-center" style="min-height: 100vh;">
    <div class="col-12 col-md-8 col-lg-5 text-center">

        <div class="card auth-card shadow-sm border-0 p-5 bg-white border-top border-danger border-4">
            <div class="card-body">

                <div class="mb-4">
                    <div class="d-inline-flex align-items-center justify-content-center bg-danger bg-opacity-10 text-danger rounded-circle" style="width: 100px; height: 100px;">
                        <i class="bi bi-cone-striped" style="font-size: 3rem;"></i>
                    </div>
                </div>

                <h1 class="fw-bold text-dark display-4 mb-2">500</h1>
                <h4 class="fw-bold text-secondary mb-3">Internal Server Error</h4>
                <p class="text-muted mb-4">
                    We're sorry, but something went wrong on our end. Our engineering team has been notified and is working to fix the issue.
                </p>

                <c:if test="${not empty exception}">
                    <div class="alert alert-light border text-start small mb-4 overflow-auto" style="max-height: 100px;">
                        <span class="text-danger fw-semibold">Error Details:</span> ${exception.message}
                    </div>
                </c:if>

                <div class="d-flex justify-content-center gap-3 flex-wrap">
                    <button onclick="window.location.reload()" class="btn btn-light border fw-medium px-4">
                        <i class="bi bi-arrow-clockwise me-1"></i> Try Again
                    </button>
                    <a href="${pageContext.request.contextPath}/" class="btn btn-primary fw-semibold px-4 shadow-sm">
                        <i class="bi bi-house-door me-1"></i> Return Home
                    </a>
                </div>

            </div>
        </div>

    </div>
</div>

<jsp:include page="/WEB-INF/views/common/footer.jsp" />