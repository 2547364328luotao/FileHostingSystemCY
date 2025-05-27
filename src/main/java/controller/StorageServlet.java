package main.java.controller;

import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;

import static main.java.db.StorageStats.getTotalStorageUsed;
import static main.java.db.StorageStats.formatSize;

@WebServlet("/storage")
public class StorageServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws IOException {
        response.setContentType("text/plain; charset=UTF-8");

        long totalBytes = getTotalStorageUsed();
        String humanReadable = formatSize(totalBytes);

        response.getWriter().println("当前存储使用总量: " + humanReadable);
    }
}
