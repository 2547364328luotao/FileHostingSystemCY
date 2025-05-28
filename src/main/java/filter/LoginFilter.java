package main.java.filter;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.util.Arrays;
import java.util.List;

/**
 * 登录过滤器 - 保护需要登录才能访问的资源
 * 可以根据需要调整过滤的URL模式
 */
@WebFilter(urlPatterns = {"/upload", "/user/*", "/admin/*"})
public class LoginFilter implements Filter {
    
    // 不需要登录就能访问的路径
    private static final List<String> EXCLUDED_PATHS = Arrays.asList(
        "/login",
        "/register",
        "/logout",
        "/index.jsp",
        "/sign-in.jsp",
        "/assets",
        "/css",
        "/js",
        "/images",
        "/storage"
    );

    @Override
    public void init(FilterConfig filterConfig) throws ServletException {
        // 初始化代码（如果需要）
    }

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {
        
        HttpServletRequest httpRequest = (HttpServletRequest) request;
        HttpServletResponse httpResponse = (HttpServletResponse) response;
        
        String requestURI = httpRequest.getRequestURI();
        String contextPath = httpRequest.getContextPath();
        
        // 移除上下文路径，获取相对路径
        String relativePath = requestURI.substring(contextPath.length());
        
        // 检查是否是排除的路径
        if (isExcludedPath(relativePath)) {
            chain.doFilter(request, response);
            return;
        }
        
        // 检查用户是否已登录
        HttpSession session = httpRequest.getSession(false);
        boolean isLoggedIn = (session != null && session.getAttribute("userId") != null);
        
        if (isLoggedIn) {
            // 用户已登录，继续处理请求
            chain.doFilter(request, response);
        } else {
            // 用户未登录，根据请求类型返回不同响应
            String contentType = httpRequest.getHeader("Content-Type");
            String accept = httpRequest.getHeader("Accept");
            
            // 判断是否是AJAX请求
            boolean isAjaxRequest = "XMLHttpRequest".equals(httpRequest.getHeader("X-Requested-With")) ||
                                  (accept != null && accept.contains("application/json")) ||
                                  (contentType != null && contentType.contains("application/json"));
            
            if (isAjaxRequest) {
                // AJAX请求，返回JSON响应
                httpResponse.setStatus(HttpServletResponse.SC_UNAUTHORIZED);
                httpResponse.setContentType("application/json; charset=UTF-8");
                httpResponse.getWriter().write("{\"success\": false, \"message\": \"请先登录\", \"needLogin\": true}");
            } else {
                // 普通请求，重定向到登录页面
                httpResponse.sendRedirect(contextPath + "/sign-in.jsp?redirect=" + java.net.URLEncoder.encode(requestURI, "UTF-8"));
            }
        }
    }
    
    /**
     * 检查路径是否在排除列表中
     * @param path 请求路径
     * @return 如果在排除列表中返回true
     */
    private boolean isExcludedPath(String path) {
        for (String excludedPath : EXCLUDED_PATHS) {
            if (path.startsWith(excludedPath)) {
                return true;
            }
        }
        return false;
    }

    @Override
    public void destroy() {
        // 清理代码（如果需要）
    }
}