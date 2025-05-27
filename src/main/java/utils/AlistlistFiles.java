package main.java.utils;

import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;

import java.io.File;
import java.io.IOException;
import java.net.URI;
import java.net.http.HttpClient;
import java.net.http.HttpRequest;
import java.net.http.HttpResponse;
import java.nio.charset.StandardCharsets;
import java.util.ArrayList;
import java.util.List;
import java.io.File;
import java.io.IOException;
import java.net.URI;
import java.net.http.*;
import java.nio.file.Files;
import java.util.ArrayList;
import java.util.List;


/**
 * AlistlistFiles 用于调用 Alist 文件管理系统 REST API，
 * 支持带令牌的 POST 请求获取指定路径下的文件和文件夹列表。
 */
public class AlistlistFiles {

    private final String baseUrl;          // Alist服务器基础URL，例如 "https://alist.example.com"
    private final String token;            // 访问令牌，API调用时放到 Authorization header
    private final HttpClient httpClient;  // Java HttpClient实例
    private final ObjectMapper objectMapper;  // JSON解析器

    /**
     * 构造函数，AlistlistFiles
     *
     * @param baseUrl Alist服务器基础URL，不带路径部分
     * @param token   访问令牌，放在请求头 Authorization
     */
    public AlistlistFiles(String baseUrl, String token) {
        this.baseUrl = baseUrl;
        this.token = token;
        this.httpClient = HttpClient.newHttpClient();
        this.objectMapper = new ObjectMapper();
    }

    /**
     * 获取指定路径下的文件和文件夹列表
     * 使用POST请求，Content-Type: application/json，
     * 请求体示例：
     * {
     *     "path": "/t",
     *     "password": "",
     *     "page": 1,
     *     "per_page": 0,
     *     "refresh": false
     * }
     *
     * @param path 服务器路径
     * @return 文件列表
     * @throws IOException
     * @throws InterruptedException
     */
    public List<FileInfo> listFiles(String path) throws IOException, InterruptedException {
        String url = baseUrl + "/api/fs/list";

        // 请求体json字符串，path参数根据调用时传入设置
        String jsonBody = "{\n" +
                "    \"path\": \"" + path + "\",\n" +
                "    \"password\": \"\",\n" +
                "    \"page\": 1,\n" +
                "    \"per_page\": 0,\n" +
                "    \"refresh\": false\n" +
                "}";

        HttpRequest request = HttpRequest.newBuilder()
                .uri(URI.create(url))
                .header("Authorization", token)                // 令牌放在Authorization头
                .header("Content-Type", "application/json")   // 请求体类型
                .POST(HttpRequest.BodyPublishers.ofString(jsonBody, StandardCharsets.UTF_8))
                .build();

        HttpResponse<String> response = httpClient.send(request, HttpResponse.BodyHandlers.ofString());

        if (response.statusCode() != 200) {
            throw new RuntimeException("请求失败，状态码：" + response.statusCode());
        }

        String body = response.body();
        JsonNode root = objectMapper.readTree(body);

        List<FileInfo> fileList = new ArrayList<>();

        if (root.has("data") && root.get("data").has("content")) {
            JsonNode content = root.get("data").get("content");

            for (JsonNode fileNode : content) {
                FileInfo fileInfo = new FileInfo();

                fileInfo.setName(fileNode.get("name").asText());
                fileInfo.setSize(fileNode.get("size").asLong());
                fileInfo.setTime(fileNode.get("modified").asText());
                fileInfo.setType(fileNode.get("is_dir").asBoolean() ? "folder" : "file");

                fileList.add(fileInfo);
            }
        } else {
            System.out.println("未找到 data.content 节点，接口返回可能有误");
        }

        return fileList;
    }

    public static class FileInfo {
        private String name;
        private long size;
        private String time;
        private String type;

        public String getName() { return name; }
        public void setName(String name) { this.name = name; }

        public long getSize() { return size; }
        public void setSize(long size) { this.size = size; }

        public String getTime() { return time; }
        public void setTime(String time) { this.time = time; }

        public String getType() { return type; }
        public void setType(String type) { this.type = type; }

        @Override
        public String toString() {
            return "FileInfo{" +
                    "name='" + name + '\'' +
                    ", size=" + size +
                    ", time='" + time + '\'' +
                    ", type='" + type + '\'' +
                    '}';
        }
    }
}
