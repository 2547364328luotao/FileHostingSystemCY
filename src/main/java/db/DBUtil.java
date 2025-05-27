package main.java.db;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

/**
 * DBUtil - 简单的数据库连接工具类
 * 先用硬编码方式连接数据库，方便调试。
 */
public class DBUtil {

    // 直接写死数据库连接信息，方便测试，后续可改为读取配置文件
    private static final String URL = "jdbc:mysql://110.42.102.224:3306/alist_media?useSSL=false&serverTimezone=UTC";
    private static final String USERNAME = "root";
    private static final String PASSWORD = "mysql_FrKS2a";

    static {
        try {
            // 注册驱动（JDBC4.0+可省略）
            Class.forName("com.mysql.cj.jdbc.Driver");
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
            throw new ExceptionInInitializerError("数据库驱动注册失败: " + e.getMessage());
        }
    }

    /**
     * 获取数据库连接
     */
    public static Connection getConnection() throws SQLException {
        return DriverManager.getConnection(URL, USERNAME, PASSWORD);
    }

    /**
     * 关闭资源，支持多参数
     */
    public static void close(AutoCloseable... resources) {
        for (AutoCloseable res : resources) {
            if (res != null) {
                try {
                    res.close();
                } catch (Exception e) {
                    e.printStackTrace();
                }
            }
        }
    }
}
