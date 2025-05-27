# FileHostingSystem - 基于Alist的文件托管系统 🚀

> 武汉城市学院2025上半年Web课程设计 🎓

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

### 详细项目构成说明 🏗️

#### 数据库ER图

![数据库ER图](https://raw.githubusercontent.com/2547364328luotao/FileHostingSystemCY/d5a7f4ba8757d54e575680a1dc101d78763077bc/web/image/ER%E5%9B%BE.drawio.svg)

#### 项目数据流顶层图

![项目数据流顶层图](https://raw.githubusercontent.com/2547364328luotao/FileHostingSystemCY/f74959085c0a5217c9f22496730ce1a70f5fe9fc/web/image/%E6%95%B0%E6%8D%AE%E6%B5%81%E5%9B%BE-Page-1.drawio.svg)


#### 1. 目录结构与模块划分

- `src/main/java/`
  - `controller/`：包含所有Servlet控制器类，负责处理前端请求、文件上传、文件列表刷新等核心业务流程。
  - `db/`：数据库操作相关类，如`DBUtil`，提供数据库连接池、SQL执行、事务管理等功能。
  - `filter/`：过滤器相关类，用于权限校验、请求拦截等。
  - `model/`：数据模型类，定义文件、用户等实体的数据结构。
  - `service/`：业务逻辑层，封装如文件同步、用户管理等核心服务。
  - `utils/`：工具类集合，包括Alist API对接、Token管理、文件上传、数据库同步等。
    - `AlistToken.java`：实现Alist登录与Token获取。
    - `AlistlistFiles.java`：封装Alist文件列表API，支持目录内容获取与解析。
    - `AlistUploader.java`：实现文件上传到Alist存储，支持大文件分片、进度回调。
    - `AlistDatabaseRefresher.java`：负责Alist与本地数据库的数据同步，自动识别文件类型并批量写入。
    - `AlistRefresher.java`：用于强制刷新Alist目录缓存，确保数据实时性。
    - `MainTest.java`、`AlistlistFilesTest.java`：测试与演示主类，便于开发调试。

- `src/main/resources/`
  - `db.properties`：数据库连接配置文件。

- `web/`
  - `WEB-INF/`：Web应用配置与依赖库目录。
    - `web.xml`：Servlet与过滤器等Web应用配置。
    - `lib/`：第三方依赖库（如Jackson、OkHttp等）。
  - `index.jsp`：文件管理主页面，展示文件列表、支持搜索与筛选。
  - `upload.jsp`：文件上传页面，支持拖拽上传、进度显示、类型预览，前端交互体验友好。

#### 2. Builder 相关说明

本项目采用Builder设计思想进行部分对象的构建与初始化，提升代码可读性与扩展性。例如：
- 文件信息（FileInfo）对象通过setter链式调用快速构建。
- 数据库操作、Alist API调用等均采用分层解耦，便于后续扩展和维护。

#### 3. 主要流程说明

- 用户通过`upload.jsp`上传文件，`UploadServlet`接收并保存至服务器临时目录。
- 后端调用`AlistUploader`上传文件到Alist云存储。
- 上传完成后，`AlistRefresher`刷新Alist目录，`AlistlistFiles`获取最新文件列表。
- `AlistDatabaseRefresher`将Alist文件信息同步到本地数据库，自动识别文件类型。
- 前端页面实时展示上传进度与结果，支持预览和下载。

---

### 核心类说明 📚

#### 1. 工具类（utils）

- **AlistToken** 🔑
  - 处理Alist系统的身份认证
  - 实现登录获取token的功能
  - 支持token的自动刷新和管理

- **AlistlistFiles** 📋
  - 实现与Alist API的通信
  - 获取文件列表和目录结构
  - 支持文件信息的解析和封装

- **AlistUploader** ⬆️
  - 处理文件上传到Alist存储
  - 支持大文件分片上传
  - 提供上传进度回调

- **AlistDatabaseRefresher** 🔄
  - 同步Alist文件系统与本地数据库
  - 实现文件类型自动识别
  - 维护文件元数据

#### 2. 数据库（db）

- **DBUtil** 🗃️
  - 数据库连接池管理
  - 提供统一的数据库操作接口
  - 支持事务管理

#### 3. Web界面

- **upload.jsp** 📤
  - 现代化的文件上传界面
  - 支持拖拽上传
  - 实时显示上传进度
  - 文件类型预览

- **index.jsp** 🏠
  - 文件管理主界面
  - 文件列表展示
  - 支持文件搜索和筛选

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