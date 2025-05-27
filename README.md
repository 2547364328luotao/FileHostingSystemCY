# FileHostingSystem - 基于Alist的文件托管系统 🚀

## 项目简介 📝

这是一个基于Alist的文件托管系统，提供文件上传、存储和管理功能。系统使用Java Servlet技术构建，集成了Alist作为底层存储服务。

## 技术栈 🛠️

- Java Servlet 🍵
- MySQL数据库 🗄️
- Jackson JSON处理库 📦
- OkHttp客户端 🌐

## 项目结构 🌲

```
src/main/
├── java/
│   ├── controller/     # Servlet控制器
│   ├── db/            # 数据库相关工具类
│   ├── filter/        # 过滤器
│   ├── model/         # 数据模型
│   ├── service/       # 业务逻辑
│   └── utils/         # 工具类
└── resources/         # 配置文件

web/
├── WEB-INF/
│   ├── lib/          # 依赖库
│   └── web.xml       # Web应用配置
├── index.jsp         # 首页
└── upload.jsp        # 上传页面
```

## 核心功能 ⭐

### 1. Alist集成 🔗

- **文件列表获取**：通过AlistlistFiles类实现与Alist服务的通信，获取文件列表。 📋
- **文件上传**：AlistUploader类提供文件上传功能。 ⬆️
- **认证管理**：AlistToken类处理Alist的token获取和管理。 🔑

### 2. 数据库管理 💾

- **连接管理**：DBUtil类提供数据库连接池和资源管理。 🔌
- **文件信息查询**：MediaFileQuery类实现文件信息的查询功能。 🔍
- **存储统计**：StorageStats类提供存储使用量统计功能。 📊

### 3. 数据同步 🔄

AlistDatabaseRefresher类实现了Alist文件系统与本地数据库的同步功能：

- 支持全量数据刷新 🔄
- 文件类型自动识别（图片、视频、音频等） 🎯
- 批量数据处理 📦

## 配置说明 ⚙️

### 数据库配置 🗄️

数据库连接信息在DBUtil.java中配置：

```java
private static final String URL = "jdbc:mysql://[host]:[port]/[database]";
private static final String USERNAME = "[username]";
private static final String PASSWORD = "[password]";
```

### Alist配置 🛠️

Alist服务配置示例：

```java
String baseUrl = "https://your-alist-domain";
String alistPath = "/your-storage-path";
```

## 部署说明 🚀

1. 配置数据库连接信息 📝
2. 配置Alist服务地址和认证信息 🔧
3. 部署到Servlet容器（如Tomcat） 🌐
4. 访问系统首页进行文件管理 ✨

## 注意事项 ⚠️

1. 确保Alist服务可用且配置正确 ✅
2. 定期同步Alist与数据库数据 🔄
3. 监控存储使用量 📊
4. 注意token的有效期管理 ⏰

> 开心工作，快乐编码！(〃'▽'〃) 🎉