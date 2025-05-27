package main.java.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import main.java.db.MediaFileQuery;
import main.java.utils.AlistDatabaseRefresher;
import main.java.utils.AlistRefresher;
import main.java.utils.AlistlistFiles;

import java.io.File;
import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

import static main.java.utils.AlistToken.getToken;
import static main.java.utils.AlistUploader.uploadFile;

@WebServlet("/upload")
@MultipartConfig
public class UploadServlet extends HttpServlet {
    //设置静态变量
    private static String Token = null;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/plain; charset=UTF-8");

        Part filePart = request.getPart("file");
        //文件名
        String fileName = getSubmittedFileName(filePart);

        String uploadDir = getServletContext().getRealPath("/tmp");
        File tmpDir = new File(uploadDir);
        if (!tmpDir.exists()) tmpDir.mkdirs();

        String tempFilePath = uploadDir + File.separator + fileName;
        filePart.write(tempFilePath);

//        response.getWriter().println("文件保存成功，临时路径如下：");
//        response.getWriter().println(tempFilePath);

        //调用Alister的接口上传文件到OSS
        String localFile = tempFilePath;
        //远程路径
        String url = "https://alist.5888888885.xyz";
        //账户密码
        String username = "luotao";
        String password = "20050508luo";
        //获取token
        try {
           Token = getToken(username,password,url);
           System.out.println("获取到的 Token 是：" + Token);
       } catch (Exception e) {
            e.printStackTrace();
       }

        //服务器中转上传文件
        try {
            String result = uploadFile(localFile, fileName, url,Token);
            System.out.println("上传结果: " + result);
        } catch (IOException | InterruptedException e) {
            e.printStackTrace();
        }

        //删除临时文件
        File file = new File(tempFilePath);
        if (file.exists()) {
            file.delete();
        }

        //更新alist列表信息
        String Alistpath = "/cloudflare";
        AlistRefresher alistRefresher = new AlistRefresher();
        try {
            alistRefresher.refreshAlistDirectory(Token, url,Alistpath);
            System.out.println("更新Alist列表完成！");
        } catch (InterruptedException e) {
            throw new RuntimeException(e);
        }

        //更新数据库信息
        String alistPath = "/cloudflare";

        AlistlistFiles alistClient = new AlistlistFiles(url, Token);

        try {
            List<AlistlistFiles.FileInfo> fileList = alistClient.listFiles(alistPath);
            System.out.println("获取文件数：" + fileList.size());

            AlistDatabaseRefresher.refreshDatabase(fileList, 1, url, alistPath);
            System.out.println("数据库刷新完成！");
        } catch (Exception e) {
            e.printStackTrace();
        }

        try {
            String previewUrl = MediaFileQuery.getPreviewUrlByFilename(fileName);
            if (previewUrl != null) {
                System.out.println("对应的预览地址为：" + previewUrl);
                response.getWriter().println("文件上传成功，预览地址为：" + previewUrl);
            } else {
                System.out.println("未找到文件：" + fileName);
                response.getWriter().println("文件上传成功，但未找到对应的预览地址！");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    private String getSubmittedFileName(Part part) {
        for (String content : part.getHeader("content-disposition").split(";")) {
            if (content.trim().startsWith("filename")) {
                return content.substring(content.indexOf('=') + 1).trim().replace("\"", "");
            }
        }
        return "unknown";
    }
}
