package main.java.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import main.java.db.DBUtil;

import java.io.IOException;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.regex.Pattern;

@WebServlet("/register")
public class RegisterServlet extends HttpServlet {
    
    // 邮箱格式验证正则表达式
    private static final Pattern EMAIL_PATTERN = Pattern.compile(
        "^[a-zA-Z0-9_+&*-]+(?:\\.[a-zA-Z0-9_+&*-]+)*@(?:[a-zA-Z0-9-]+\\.)+[a-zA-Z]{2,7}$"
    );

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("application/json; charset=UTF-8");
        
        // 获取请求参数
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String email = request.getParameter("email");
        
        // 参数验证
        String validationError = validateInput(username, password, email);
        if (validationError != null) {
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            response.getWriter().write("{\"success\": false, \"message\": \"" + validationError + "\"}");
            return;
        }
        
        try {
            // 检查用户名是否已存在
            if (isUsernameExists(username.trim())) {
                response.setStatus(HttpServletResponse.SC_CONFLICT);
                response.getWriter().write("{\"success\": false, \"message\": \"用户名已存在\"}");
                return;
            }
            
            // 创建用户
            int userId = createUser(username.trim(), password, email != null ? email.trim() : null);
            
            if (userId > 0) {
                // 注册成功，自动登录
                HttpSession session = request.getSession();
                session.setAttribute("userId", userId);
                session.setAttribute("username", username.trim());
                session.setAttribute("email", email != null ? email.trim() : null);
                session.setMaxInactiveInterval(30 * 60); // 30分钟
                
                response.getWriter().write("{\"success\": true, \"message\": \"注册成功\", \"user\": {\"id\": " + userId + ", \"username\": \"" + username.trim() + "\", \"email\": \"" + (email != null ? email.trim() : "") + "\"}}");
            } else {
                response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
                response.getWriter().write("{\"success\": false, \"message\": \"注册失败，请稍后重试\"}");
            }
            
        } catch (SQLException e) {
            e.printStackTrace();
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            response.getWriter().write("{\"success\": false, \"message\": \"数据库连接错误\"}");
        } catch (Exception e) {
            e.printStackTrace();
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            response.getWriter().write("{\"success\": false, \"message\": \"服务器内部错误\"}");
        }
    }
    
    /**
     * 验证输入参数
     * @param username 用户名
     * @param password 密码
     * @param email 邮箱
     * @return 错误信息，如果验证通过返回null
     */
    private String validateInput(String username, String password, String email) {
        // 用户名验证
        if (username == null || username.trim().isEmpty()) {
            return "用户名不能为空";
        }
        if (username.trim().length() < 3 || username.trim().length() > 50) {
            return "用户名长度必须在3-50个字符之间";
        }
        if (!username.trim().matches("^[a-zA-Z0-9_]+$")) {
            return "用户名只能包含字母、数字和下划线";
        }
        
        // 密码验证
        if (password == null || password.isEmpty()) {
            return "密码不能为空";
        }
        if (password.length() < 6 || password.length() > 100) {
            return "密码长度必须在6-100个字符之间";
        }
        
        // 邮箱验证（可选）
        if (email != null && !email.trim().isEmpty()) {
            if (email.trim().length() > 100) {
                return "邮箱地址过长";
            }
            if (!EMAIL_PATTERN.matcher(email.trim()).matches()) {
                return "邮箱格式不正确";
            }
        }
        
        return null;
    }
    
    /**
     * 检查用户名是否已存在
     * @param username 用户名
     * @return 如果存在返回true，否则返回false
     * @throws SQLException
     */
    private boolean isUsernameExists(String username) throws SQLException {
        String sql = "SELECT COUNT(*) FROM users WHERE username = ?";
        
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setString(1, username);
            
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt(1) > 0;
                }
            }
        }
        
        return false;
    }
    
    /**
     * 创建新用户
     * @param username 用户名
     * @param password 密码
     * @param email 邮箱
     * @return 新用户的ID，如果创建失败返回-1
     * @throws SQLException
     */
    private int createUser(String username, String password, String email) throws SQLException {
        String sql = "INSERT INTO users (username, password_hash, email) VALUES (?, ?, ?)";
        
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql, PreparedStatement.RETURN_GENERATED_KEYS)) {
            
            stmt.setString(1, username);
            stmt.setString(2, password);
            stmt.setString(3, email);
            
            int affectedRows = stmt.executeUpdate();
            
            if (affectedRows > 0) {
                try (ResultSet generatedKeys = stmt.getGeneratedKeys()) {
                    if (generatedKeys.next()) {
                        return generatedKeys.getInt(1);
                    }
                }
            }
        }
        
        return -1;
    }
    

}