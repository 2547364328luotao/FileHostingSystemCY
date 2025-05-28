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

@WebServlet("/login")
public class LoginServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("application/json; charset=UTF-8");
        
        // 获取请求参数
        String username = request.getParameter("username");
        String password = request.getParameter("password");

    }
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("application/json; charset=UTF-8");

    }
    

    
    /**
     * 用户实体类
     */
    private static class User {
        private int id;
        private String username;
        private String email;
        
        public User(int id, String username, String email) {
            this.id = id;
            this.username = username;
            this.email = email;
        }
        
        public int getId() {
            return id;
        }
        
        public String getUsername() {
            return username;
        }
        
        public String getEmail() {
            return email;
        }
    }
}