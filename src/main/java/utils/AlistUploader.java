package main.java.utils;

import java.io.IOException;
import java.net.URI;
import java.net.URLEncoder;
import java.net.http.HttpClient;
import java.net.http.HttpRequest;
import java.net.http.HttpResponse;
import java.nio.charset.StandardCharsets;
import java.nio.file.Files;
import java.nio.file.Path;

public class AlistUploader {

    public static String uploadFile(String localFilePath, String flieName, String alistUploadUrl, String token) throws IOException, InterruptedException {
        // 完整路径
        alistUploadUrl = alistUploadUrl + "/api/fs/put";
        // 读取文件字节
        Path filePath = Path.of(localFilePath);
        byte[] fileBytes = Files.readAllBytes(filePath);

        // 构建远程路径
        String remoteFilePath = "/cloudflare/"+flieName;

        // 编码远程路径
        String encodedRemotePath = URLEncoder.encode(remoteFilePath, StandardCharsets.UTF_8);

        // 构建请求
        HttpRequest request = HttpRequest.newBuilder()
                .uri(URI.create(alistUploadUrl))
                .PUT(HttpRequest.BodyPublishers.ofByteArray(fileBytes))
                .header("authorization", token)
                .header("file-path", encodedRemotePath)
                .header("User-Agent", "Java HttpClient")
                .header("Accept", "*/*")
                .header("Content-Type", "application/octet-stream")
                .build();

        // 发送请求
        HttpClient client = HttpClient.newHttpClient();
        HttpResponse<String> response = client.send(request, HttpResponse.BodyHandlers.ofString());

        // 返回响应体
        return response.body();
    }

    // 简单测试主方法
    public static void main(String[] args) {
        String localFile = "C:\\Code\\Java\\servlet\\AlistMedia\\out\\artifacts\\AlistMedia_Web_exploded\\tmp\\cover (2).jpg";
        String remotePath = "cover (2).jpg";
        String url = "https://alist.5888888885.xyz";
        String token = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VybmFtZSI6Imx1b3RhbyIsInB3ZF90cyI6MTc0NzM3MjU3MCwiZXhwIjoxNzQ4MTc2MDg4LCJuYmYiOjE3NDgwMDMyODgsImlhdCI6MTc0ODAwMzI4OH0.EZvUuuDmW7Iu-9M9lLYiUHWBS87IuZpMOKlNhugVwI8";

        try {
            String result = uploadFile(localFile, remotePath, url, token);
            System.out.println("上传结果: " + result);
        } catch (IOException | InterruptedException e) {
            e.printStackTrace();
        }
    }
}
