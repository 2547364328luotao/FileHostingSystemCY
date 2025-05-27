package main.java.utils;
import java.io.IOException;
import java.net.URI;
import java.net.http.HttpClient;
import java.net.http.HttpRequest;
import java.net.http.HttpResponse;
import java.nio.charset.StandardCharsets;

import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;

public class AlistToken {

    private static final String LOGIN_URL = "/api/auth/login";
    private static final ObjectMapper objectMapper = new ObjectMapper();

    /**
     * 登录 Alist 获取 token
     *
     * @param username 用户名
     * @param password 密码
     * @return token 字符串
     * @throws IOException 网络或解析异常
     * @throws InterruptedException 请求被中断
     */
    public static String getToken(String username, String password,String baseUrl) throws IOException, InterruptedException {
        String jsonBody = String.format("{\"username\": \"%s\", \"password\": \"%s\"}", username, password);

        HttpClient client = HttpClient.newHttpClient();

        HttpRequest request = HttpRequest.newBuilder()
                .uri(URI.create(baseUrl + LOGIN_URL))
                .header("Content-Type", "application/json")
                .POST(HttpRequest.BodyPublishers.ofString(jsonBody, StandardCharsets.UTF_8))
                .build();

        HttpResponse<String> response = client.send(request, HttpResponse.BodyHandlers.ofString());

        if (response.statusCode() == 200) {
            JsonNode root = objectMapper.readTree(response.body());
            return root.path("data").path("token").asText();
        } else {
            throw new RuntimeException("登录失败: 状态码 = " + response.statusCode() + ", 返回内容: " + response.body());
        }
    }

    // 示例
//    public static void main(String[] args) {
//        try {
//            String token = login("luotao", "20050508luo");
//            System.out.println("获取到的 Token 是：" + token);
//        } catch (Exception e) {
//            e.printStackTrace();
//        }
//    }
}
