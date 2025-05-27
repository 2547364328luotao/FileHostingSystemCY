package main.java.utils;

import main.java.db.DBUtil;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.List;

public class AlistlistFilesTest {

    public static void main(String[] args) {
        // Alist 服务地址及令牌
        String baseUrl = "https://alist.5888888885.xyz";
        String token = "alist-decf52dc-4e08-47f6-be4a-01756df1549709FTjcUzSZ87JWhK1EBdraJ8L6CZUUIdZ8jeqvHstGjgQwGhPR66pk6LIHoOFJBl";

        // 要读取的 Alist 路径（如 /cloudflare）
        String alistPath = "/cloudflare";

        // 初始化 Alist 客户端
        AlistlistFiles alistClient = new AlistlistFiles(baseUrl, token);

        try {
            // 获取文件列表
            List<AlistlistFiles.FileInfo> fileList = alistClient.listFiles(alistPath);
            System.out.println("获取文件数：" + fileList.size());

            // 刷新数据库，默认 user_id = 1
            refreshDatabase(fileList, 1, baseUrl, alistPath);
            System.out.println("数据库刷新完成！");
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    /**
     * 写入数据库
     */
    private static void refreshDatabase(List<AlistlistFiles.FileInfo> files, int userId, String baseUrl, String alistPath) throws SQLException {
        try (Connection conn = DBUtil.getConnection()) {
            conn.setAutoCommit(false);

            try (PreparedStatement clearStmt = conn.prepareStatement("TRUNCATE TABLE media_files")) {
                clearStmt.executeUpdate();
            }

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
     * 文件类型映射：根据扩展名判断
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
