package main.java.db;

import com.mchange.v2.c3p0.ComboPooledDataSource;
import java.io.IOException;
import java.io.InputStream;
import java.sql.Connection;
import java.sql.SQLException;
import java.util.Properties;

/**
 * DBUtil - 使用c3p0连接池的数据库连接工具类
 */
public class DBUtil {

    private static ComboPooledDataSource dataSource;

    static {
        try {
            // 初始化c3p0连接池
            initDataSource();
        } catch (Exception e) {
            e.printStackTrace();
            throw new ExceptionInInitializerError("数据库连接池初始化失败: " + e.getMessage());
        }
    }

    /**
     * 初始化数据源
     */
    private static void initDataSource() throws Exception {
        dataSource = new ComboPooledDataSource();
        
        // 读取配置文件
        Properties props = new Properties();
        try (InputStream is = DBUtil.class.getClassLoader().getResourceAsStream("db.properties")) {
            if (is != null) {
                props.load(is);
            } else {
                throw new IOException("无法找到db.properties配置文件");
            }
        }
        
        // 设置数据库驱动
        dataSource.setDriverClass("com.mysql.cj.jdbc.Driver");
        
        // 设置数据库连接信息
        dataSource.setJdbcUrl(props.getProperty("db.url", "jdbc:mysql://110.42.102.224:3306/alist_media?useSSL=false&serverTimezone=UTC"));
        dataSource.setUser(props.getProperty("db.username", "root"));
        dataSource.setPassword(props.getProperty("db.password", "mysql_FrKS2a"));
        
        // 设置连接池参数（从配置文件读取，如果没有则使用默认值）
        dataSource.setInitialPoolSize(Integer.parseInt(props.getProperty("c3p0.initialPoolSize", "5")));
        dataSource.setMinPoolSize(Integer.parseInt(props.getProperty("c3p0.minPoolSize", "5")));
        dataSource.setMaxPoolSize(Integer.parseInt(props.getProperty("c3p0.maxPoolSize", "20")));
        dataSource.setMaxIdleTime(Integer.parseInt(props.getProperty("c3p0.maxIdleTime", "1800")));
        dataSource.setAcquireIncrement(Integer.parseInt(props.getProperty("c3p0.acquireIncrement", "3")));
        dataSource.setMaxStatements(Integer.parseInt(props.getProperty("c3p0.maxStatements", "100")));
        dataSource.setIdleConnectionTestPeriod(Integer.parseInt(props.getProperty("c3p0.idleConnectionTestPeriod", "60")));
        dataSource.setAcquireRetryAttempts(Integer.parseInt(props.getProperty("c3p0.acquireRetryAttempts", "30")));
        dataSource.setBreakAfterAcquireFailure(Boolean.parseBoolean(props.getProperty("c3p0.breakAfterAcquireFailure", "false")));
        dataSource.setTestConnectionOnCheckout(Boolean.parseBoolean(props.getProperty("c3p0.testConnectionOnCheckout", "false")));
    }

    /**
     * 获取数据库连接
     */
    public static Connection getConnection() throws SQLException {
        return dataSource.getConnection();
    }

    /**
     * 获取数据源（用于其他需要DataSource的场景）
     */
    public static ComboPooledDataSource getDataSource() {
        return dataSource;
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

    /**
     * 关闭连接池（应用程序关闭时调用）
     */
    public static void closeDataSource() {
        if (dataSource != null) {
            try {
                dataSource.close();
                System.out.println("数据库连接池已关闭");
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
    }
}
