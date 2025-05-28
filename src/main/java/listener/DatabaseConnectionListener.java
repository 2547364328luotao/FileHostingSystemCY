package main.java.listener;

import jakarta.servlet.ServletContextEvent;
import jakarta.servlet.ServletContextListener;
import jakarta.servlet.annotation.WebListener;
import main.java.db.DBUtil;

/**
 * 数据库连接池生命周期监听器
 * 在应用程序启动时初始化连接池，关闭时释放连接池资源
 */
@WebListener
public class DatabaseConnectionListener implements ServletContextListener {

    @Override
    public void contextInitialized(ServletContextEvent sce) {
        System.out.println("应用程序启动，数据库连接池已初始化");
        // 连接池在DBUtil的静态代码块中已经初始化
    }

    @Override
    public void contextDestroyed(ServletContextEvent sce) {
        System.out.println("应用程序关闭，正在关闭数据库连接池...");
        DBUtil.closeDataSource();
    }
}