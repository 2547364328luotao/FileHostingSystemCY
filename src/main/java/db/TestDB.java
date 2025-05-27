package main.java.db;

import main.java.db.DBUtil;

import java.sql.Connection;

public class TestDB {
    public static void main(String[] args) {
        try (Connection conn = DBUtil.getConnection()) {
            if (conn != null && !conn.isClosed()) {
                System.out.println("数据库连接成功！");
            } else {
                System.out.println("数据库连接失败！");
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
