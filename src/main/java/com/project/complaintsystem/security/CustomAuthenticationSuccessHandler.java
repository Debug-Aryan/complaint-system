package com.project.complaintsystem.security;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.web.authentication.AuthenticationSuccessHandler;
import org.springframework.stereotype.Component;

import java.io.IOException;

@Component
public class CustomAuthenticationSuccessHandler implements AuthenticationSuccessHandler {

    @Override
    public void onAuthenticationSuccess(HttpServletRequest request,
                                        HttpServletResponse response,
                                        Authentication authentication) throws IOException, ServletException {

        // Optional compatibility: keep existing JSP/session reads working
        Object principal = authentication.getPrincipal();
        if (principal instanceof CustomUserDetails customUserDetails) {
            HttpSession session = request.getSession(true);
            session.setAttribute("userId", customUserDetails.getId());
            session.setAttribute("role", customUserDetails.getRole().name());
        }

        String targetUrl = resolveTargetUrl(authentication);
        response.sendRedirect(request.getContextPath() + targetUrl);
    }

    private String resolveTargetUrl(Authentication authentication) {
        for (GrantedAuthority authority : authentication.getAuthorities()) {
            String role = authority.getAuthority();
            if ("ROLE_ADMIN".equals(role)) {
                return "/admin/dashboard";
            }
        }
        return "/user/dashboard";
    }
}
