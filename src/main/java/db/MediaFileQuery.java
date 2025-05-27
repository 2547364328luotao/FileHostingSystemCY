package main.java.db;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class MediaFileQuery {

    /**
     * 根据文件名查询对应的 preview_url
     * @param filename 文件名
     * @return preview_url 字符串，没找到返回 null
     * @throws SQLException
     */
    public static String getPreviewUrlByFilename(String filename) throws SQLException {
        String sql = "SELECT preview_url FROM media_files WHERE filename = ? LIMIT 1";

        try (Connection conn = DBUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, filename);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    return rs.getString("preview_url");
                }
            }
        }
        return null; // 没找到
    }
}
