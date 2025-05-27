<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>图床上传</title>
</head>
<body>
<h2>上传图片</h2>
<form action="upload.jsp" method="post" enctype="multipart/form-data">
    <input type="file" name="image" accept="image/*" required><br><br>
    <input type="submit" value="上传">
</form>
</body>
</html>
