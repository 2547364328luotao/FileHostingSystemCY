package main.java.utils;

import java.io.IOException;
import java.util.List;

public class MainTest {
    public static void main(String[] args) {
        //配置alist地址
        String baseUrl = "https://alist.5888888885.xyz";
        String Alistoken = "alist-decf52dc-4e08-47f6-be4a-01756df1549709FTjcUzSZ87JWhK1EBdraJ8L6CZUUIdZ8jeqvHstGjgQwGhPR66pk6LIHoOFJBl";
        String uername = "luotao";
        String password = "20050508luo";


        //Alist路径
        String alistPath = "/cloudflare";

        //创建Alist实例
        AlistlistFiles alistlistFiles = new AlistlistFiles(baseUrl, Alistoken);

//        try {
//            //获取Alist目录下的文件列表
//            List<AlistlistFiles.FileInfo> fileList = alistlistFiles.listFiles(alistPath);
//            //打印flileList
//            for (AlistlistFiles.FileInfo fileInfo : fileList) {
//                System.out.println(fileInfo.toString());
//            }
//
//        } catch (IOException e) {
//            throw new RuntimeException(e);
//        } catch (InterruptedException e) {
//            throw new RuntimeException(e);
//        }

        //获取Token
        AlistToken alistToken = new AlistToken();
        try {
            String token = alistToken.getToken(uername, password, baseUrl);
            System.out.println(token);
        } catch (IOException e) {
            throw new RuntimeException(e);
        } catch (InterruptedException e) {
            throw new RuntimeException(e);
        }
    }
}
