<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<jsp:include page="/WEB-INF/views/common/header.jsp" />

<div class="container d-flex justify-content-center align-items-center" style="min-height: 100vh;">
    <div class="col-12 col-md-8 col-lg-5 text-center">

        <div class="card auth-card shadow-sm border-0 p-5 bg-white">
            <div class="card-body">

                <div class="mb-4">
                    <div class="d-inline-flex align-items-center justify-content-center bg-primary bg-opacity-10 text-primary rounded-circle" style="width: 100px; height: 100px;">
                        <i class="bi bi-compass" style="font-size: 3rem;"></i>
                    </div>
                </div>

                <h1 class="fw-bold text-dark display-4 mb-2">404</h1>
                <h4 class="fw-bold text-secondary mb-3">Page Not Found</h4>
                <p class="text-muted mb-4">
                    Oops! It looks like you've wandered off the map. The page you are looking for doesn't exist or has been moved.
                </p>

                <div class="d-flex justify-content-center gap-3">
                    <button onclick="history.back()" class="btn btn-light border fw-medium px-4">
                        <i class="bi bi-arrow-left me-1"></i> Go Back
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