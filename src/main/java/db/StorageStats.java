package main.java.db;

import main.java.db.DBUtil;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class StorageStats {

    /**
     * 获取当前数据库中所有文件的总存储大小（单位：字节）
     */
    public static long getTotalStorageUsed() {
        String sql = "SELECT SUM(size) AS total FROM media_files";

        try (Connection conn = DBUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {

            if (rs.next()) {
                return rs.getLong("total");
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return 0L;
    }

    /**
     * 将字节数转换为可读格式（如 MB、GB）
     */
    public static String formatSize(long bytes) {
        if (bytes >= 1024L * 1024 * 1024)
            return String.format("%.2f GB", bytes / (1024.0 * 1024 * 1024));
        else if (bytes >= 1024L * 1024)
            return String.format("%.2f MB", bytes / (1024.0 * 1024));
        else if (bytes >= 1024L)
            return String.format("%.2f KB", bytes / 1024.0);
        else
            return bytes + " B";
    }
}
