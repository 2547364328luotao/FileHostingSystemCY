package main.java.utils;

import main.java.db.DBUtil;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.List;

public class AlistDatabaseRefresher {

    /**
     * 从 Alist 文件列表刷新数据库，清空原表重新写入
     * @param files    从 Alist 获取的文件列表
     * @param userId   关联的用户ID
     * @param baseUrl  Alist 基础地址，如 https://alist.5888888885.xyz
     * @param alistPath  Alist 目录路径，如 /cloudflare
     * @throws SQLException
     */
    public static void refreshDatabase(List<AlistlistFiles.FileInfo> files, int userId, String baseUrl, String alistPath) throws SQLException {
        try (Connection conn = DBUtil.getConnection()) {
            conn.setAutoCommit(false);

            // 清空旧数据
            try (PreparedStatement clearStmt = conn.prepareStatement("TRUNCATE TABLE media_files")) {
                clearStmt.executeUpdate();
            }

            // 插入新数据
            String insertSQL = "INSERT INTO media_files " +
                    "(user_id, filename, file_type, size, alist_path, preview_url) " +
                    "VALUES (?, ?, ?, ?, ?, ?)";

            try (PreparedStatement stmt = conn.prepareStatement(insertSQL)) {
                for (AlistlistFiles.FileInfo file : files) {
                    String fileName = file.getName();
                    String fileType = mapFileType(fileName);
                    long fileSize = file.getSize();

                    String fullAlistPath = alistPath + "/" + fileName;
                    String previewUrl = baseUrl + "/d" + fullAlistPath;

                    stmt.setInt(1, userId);
                    stmt.setString(2, fileName);
                    stmt.setString(3, fileType);
                    stmt.setLong(4, fileSize);
                    stmt.setString(5, fullAlistPath);
                    stmt.setString(6, previewUrl);

                    stmt.addBatch();
                }
                stmt.executeBatch();
            }

            conn.commit();
        }
    }

    /**
     * 根据文件扩展名映射类型
     */
    private static String mapFileType(String fileName) {
        String ext = "";
        int dotIndex = fileName.lastIndexOf('.');
        if (dotIndex >= 0 && dotIndex < fileName.length() - 1) {
            ext = fileName.substring(dotIndex + 1).toLowerCase();
        }

        String[] images = {"jpg", "jpeg", "png", "gif", "bmp", "webp", "tiff", "svg"};
        String[] videos = {"mp4", "avi", "mov", "mkv", "flv", "wmv", "webm", "mpeg"};
        String[] audios = {"mp3", "wav", "aac", "flac", "ogg", "m4a"};

        for (String image : images) {
            if (image.equals(ext)) return "image";
        }
        for (String video : videos) {
            if (video.equals(ext)) return "video";
        }
        for (String audio : audios) {
            if (audio.equals(ext)) return "audio";
        }

        return "other";
    }
}
