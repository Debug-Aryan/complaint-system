<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

    <c:if test="${not param.hideAuthButtons}">
        </div> <!-- End of .main-content -->
    </div> <!-- End of .app-wrapper -->
    </c:if>

    <!-- Bootstrap Bundle with Popper -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>

    <!-- Custom Script -->
    <script src="${pageContext.request.contextPath}/js/script.js"></script>
    
    <c:if test="${not param.hideAuthButtons}">
    <script>
        document.addEventListener("DOMContentLoaded", function() {
            const sidebarBtn = document.getElementById('sidebarToggle');
            const sidebar = document.getElementById('sidebar');
            const backdrop = document.getElementById('sidebarBackdrop');

            if(sidebarBtn && sidebar && backdrop) {
                // Mobile Menu Toggle
                sidebarBtn.addEventListener('click', function() {
                    sidebar.classList.toggle('show');
                    backdrop.classList.toggle('show');
                });

                backdrop.addEventListener('click', function() {
                    sidebar.classList.remove('show');
                    backdrop.classList.remove('show');
                });
            }
        });
    </script>
    </c:if>
</body>
</html>