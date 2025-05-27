package main.java.utils;

import java.io.IOException;
import java.net.URI;
import java.net.http.HttpClient;
import java.net.http.HttpRequest;
import java.net.http.HttpResponse;
public class AlistRefresher {

    /**
     * 强制刷新 Alist 指定目录
     * @param token 认证 Token
     * @param baseUrl Alist 地址，如 https://alist.xxx.xyz
     * @param path 要刷新的路径，如 /cloudflare
     * @return 返回响应 JSON 字符串
     * @throws IOException 网络异常
     * @throws InterruptedException 中断异常
     */
    public static String refreshAlistDirectory(String token, String baseUrl, String path)
            throws IOException, InterruptedException {

        String apiUrl = baseUrl + "/api/fs/list";

        String jsonBody = String.format("""
                {
                    "path": "%s",
                    "password": "",
                    "page": 1,
                    "per_page": 0,
                    "refresh": true
                }
                """, path);

        HttpRequest request = HttpRequest.newBuilder()
                .uri(URI.create(apiUrl))
                .POST(HttpRequest.BodyPublishers.ofString(jsonBody))
                .header("authorization", token)
                .header("content-type", "application/json;charset=UTF-8")
                .header("User-Agent", "JavaHttpClient")
                .header("Accept", "*/*")
                .build();

        HttpClient client = HttpClient.newHttpClient();
        HttpResponse<String> response = client.send(request, HttpResponse.BodyHandlers.ofString());

        return response.body();
    }
}
