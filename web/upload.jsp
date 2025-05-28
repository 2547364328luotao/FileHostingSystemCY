<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <!-- 基本页面信息设置 -->
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <meta name="description" content="AlistFHS Cloud SU - 文件上传">
  <meta name="author" content="Webpixels">
  <title>文件上传 - AlistFHS Cloud SU</title>

  <!-- 引入Google字体 - Nunito和Roboto字体系列 -->
  <link href="https://fonts.googleapis.com/css?family=Nunito:400,600,700,800|Roboto:400,500,700" rel="stylesheet">

  <!-- 引入动画库 -->
  <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/vendor/animate/animate.min.css" type="text/css">

  <!-- Boomerang UI Kit 主题样式文件 -->
  <link type="text/css" href="${pageContext.request.contextPath}/assets/css/theme.css" rel="stylesheet">

  <!-- 演示样式文件 - 实际项目中可以不使用 -->
  <link type="text/css" href="${pageContext.request.contextPath}/assets/css/demo.css" rel="stylesheet">

  <style>
    /* 自定义样式 */
    .spotlight {
      min-height: 100vh;
    }    /* 透明导航栏样式 */
    .navbar-transparent {
      position: absolute;
      top: 0;
      left: 0;
      right: 0;
      z-index: 1000;
      background: rgba(0, 0, 0, 0.1) !important;
      backdrop-filter: blur(10px);
      -webkit-backdrop-filter: blur(10px);
    }

    /* 上传区域样式 */
    .upload-container {
      background: rgba(255, 255, 255, 0.95);
      backdrop-filter: blur(10px);
      border-radius: 24px;
      padding: 40px;
      box-shadow: 0 20px 40px rgba(0, 0, 0, 0.1);
      border: 1px solid rgba(255, 255, 255, 0.2);
      margin-top: 120px;
    }

    .upload-section {
      margin-bottom: 30px;
      padding: 40px;
      border: 2px dashed rgba(255, 255, 255, 0.3);
      border-radius: 20px;
      transition: all 0.3s ease;
      position: relative;
      overflow: hidden;
      background: rgba(255, 255, 255, 0.1);
    }

    .upload-section:hover {
      border-color: rgba(255, 255, 255, 0.6);
      background: rgba(255, 255, 255, 0.15);
      transform: translateY(-2px);
    }

    .upload-section.dragover {
      border-color: rgba(255, 255, 255, 0.8);
      background: rgba(255, 255, 255, 0.2);
      transform: scale(1.02);
    }

    .upload-section.uploading {
      pointer-events: none;
      opacity: 0.7;
    }

    .upload-icon {
      font-size: 64px;
      margin-bottom: 20px;
      display: block;
      text-align: center;
      color: white;
    }

    .upload-section h3 {
      color: white;
      font-size: 24px;
      font-weight: 600;
      margin-bottom: 12px;
      text-align: center;
    }

    .upload-section p {
      color: rgba(255, 255, 255, 0.8);
      font-size: 16px;
      text-align: center;
      margin-bottom: 30px;
      line-height: 1.6;
    }

    .file-input-wrapper {
      position: relative;
      display: inline-block;
      width: 100%;
    }

    .file-input {
      opacity: 0;
      position: absolute;
      width: 100%;
      height: 100%;
      cursor: pointer;
    }

    .file-input-button {
      display: block;
      width: 100%;
      padding: 16px 32px;
      background: rgba(255, 255, 255, 0.2);
      color: white;
      border: 2px solid rgba(255, 255, 255, 0.3);
      border-radius: 50px;
      font-size: 18px;
      font-weight: 600;
      cursor: pointer;
      transition: all 0.3s ease;
      text-align: center;
      backdrop-filter: blur(10px);
    }

    .file-input-button:hover {
      background: rgba(255, 255, 255, 0.3);
      border-color: rgba(255, 255, 255, 0.5);
      transform: translateY(-3px);
      box-shadow: 0 10px 30px rgba(0, 0, 0, 0.2);
    }

    .upload-button {
      width: 100%;
      padding: 16px;
      background: linear-gradient(135deg, #28a745 0%, #20c997 100%);
      color: white;
      border: none;
      border-radius: 50px;
      font-size: 18px;
      font-weight: 600;
      cursor: pointer;
      margin-top: 20px;
      transition: all 0.3s ease;
      opacity: 0.7;
      pointer-events: none;
      box-shadow: 0 8px 25px rgba(40, 167, 69, 0.3);
    }

    .upload-button:enabled {
      opacity: 1;
      pointer-events: auto;
    }

    .upload-button:enabled:hover {
      transform: translateY(-3px);
      box-shadow: 0 12px 35px rgba(40, 167, 69, 0.4);
    }

    .upload-button.uploading {
      background: linear-gradient(135deg, #ffc107 0%, #fd7e14 100%);
      cursor: not-allowed;
    }

    .file-info {
      margin-top: 20px;
      padding: 20px;
      background: rgba(255, 255, 255, 0.15);
      border-radius: 16px;
      font-size: 15px;
      color: white;
      display: none;
      backdrop-filter: blur(10px);
      border: 1px solid rgba(255, 255, 255, 0.2);
    }

    .progress-container {
      margin-top: 20px;
      display: none;
    }

    .progress-bar {
      width: 100%;
      height: 12px;
      background: rgba(255, 255, 255, 0.2);
      border-radius: 6px;
      overflow: hidden;
      margin-bottom: 12px;
      backdrop-filter: blur(10px);
    }

    .progress-fill {
      height: 100%;
      background: linear-gradient(90deg, #28a745, #20c997);
      width: 0%;
      transition: width 0.3s ease;
      border-radius: 6px;
      box-shadow: 0 0 10px rgba(40, 167, 69, 0.5);
    }

    .progress-text {
      font-size: 14px;
      color: rgba(255, 255, 255, 0.9);
      text-align: center;
      font-weight: 500;
    }

    .result {
      margin-top: 25px;
      padding: 20px;
      border-radius: 16px;
      font-size: 15px;
      display: none;
      position: relative;
      backdrop-filter: blur(10px);
    }

    .result.success {
      background: rgba(40, 167, 69, 0.2);
      color: #d4edda;
      border: 1px solid rgba(40, 167, 69, 0.3);
    }

    .result.error {
      background: rgba(220, 53, 69, 0.2);
      color: #f8d7da;
      border: 1px solid rgba(220, 53, 69, 0.3);
    }

    .copy-button {
      background: rgba(255, 255, 255, 0.2);
      border: 1px solid rgba(255, 255, 255, 0.3);
      color: white;
      padding: 8px 16px;
      border-radius: 20px;
      font-size: 13px;
      cursor: pointer;
      margin-left: 12px;
      transition: all 0.3s ease;
      backdrop-filter: blur(10px);
    }

    .copy-button:hover {
      background: rgba(255, 255, 255, 0.3);
      transform: translateY(-1px);
    }

    .file-preview {
      margin-top: 20px;
      text-align: center;
      display: none;
    }

    .file-preview img {
      max-width: 100%;
      max-height: 250px;
      border-radius: 16px;
      box-shadow: 0 8px 25px rgba(0, 0, 0, 0.3);
      border: 2px solid rgba(255, 255, 255, 0.2);
    }

    .file-preview video {
      max-width: 100%;
      max-height: 250px;
      border-radius: 16px;
      box-shadow: 0 8px 25px rgba(0, 0, 0, 0.3);
      border: 2px solid rgba(255, 255, 255, 0.2);
    }

    .loading-spinner {
      display: inline-block;
      width: 18px;
      height: 18px;
      border: 2px solid rgba(255, 255, 255, 0.3);
      border-radius: 50%;
      border-top-color: white;
      animation: spin 1s ease-in-out infinite;
      margin-right: 10px;
    }

    @keyframes spin {
      to { transform: rotate(360deg); }
    }

    .status-steps {
      margin-top: 20px;
      font-size: 14px;
      color: rgba(255, 255, 255, 0.8);
      line-height: 1.6;
      display: none;
    }

    .step {
      margin-bottom: 8px;
      padding: 4px 0;
    }

    .step.completed {
      color: #d4edda;
    }

    .step.current {
      color: white;
      font-weight: 600;
    }

    @media (max-width: 600px) {
      .upload-container {
        padding: 15px;
        margin: 15px;
      }

      .upload-section {
        padding: 30px 20px;
      }

      .upload-section h2 {
        font-size: 28px;
        margin-bottom: 15px;
      }

      .upload-section p {
        font-size: 16px;
        margin-bottom: 25px;
      }

      .file-input-button, .upload-button {
        padding: 14px 24px;
        font-size: 16px;
        margin: 8px 0;
      }

      .file-info, .result {
        padding: 15px;
        font-size: 14px;
      }

      .copy-button {
        padding: 6px 12px;
        font-size: 12px;
        margin-left: 8px;
      }
    }

    #storage-info {
      position: fixed;
      top: -60px;
      left: 50%;
      transform: translateX(-50%);
      background: rgba(255, 255, 255, 0.15);
      padding: 15px 25px;
      border-radius: 25px;
      box-shadow: 0 8px 25px rgba(0, 0, 0, 0.3);
      font-weight: 600;
      color: white;
      backdrop-filter: blur(15px);
      border: 1px solid rgba(255, 255, 255, 0.2);
      animation: slideDown 0.8s ease forwards;
      font-size: 14px;
      z-index: 1000;
    }

    @keyframes slideDown {
      0% {
        top: -60px;
        opacity: 0;
        transform: translateX(-50%) translateY(-10px);
      }
      100% {
        top: 25px;
        opacity: 1;
        transform: translateX(-50%) translateY(0);
      }
    }

    </style>
</head>
<body>
<div id="storage-info">正在加载存储信息...</div>

<!-- Navigation -->
<nav class="navbar navbar-expand-lg navbar-transparent fixed-top">
    <div class="container">
        <a class="navbar-brand" href="index.jsp">
            <img src="assets/img/brand/light.svg" alt="Boomerang" id="navbar-logo">
        </a>
        <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbar-primary" aria-controls="navbar-primary" aria-expanded="false" aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="navbar-primary">
            <ul class="navbar-nav ml-auto">
                <li class="nav-item">
                    <a class="nav-link" href="index.jsp">Overview</a>
                </li>
                <li class="nav-item dropdown">
                    <a class="nav-link dropdown-toggle" href="#" id="navbar-primary_dropdown_1" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">Pages</a>
                    <div class="dropdown-menu" aria-labelledby="navbar-primary_dropdown_1">
                        <a class="dropdown-item" href="index.jsp">Homepage</a>
                        <a class="dropdown-item" href="about.jsp">About us</a>
                        <a class="dropdown-item" href="signin.jsp">Sign in</a>
                        <a class="dropdown-item" href="contact.jsp">Contact</a>
                        <a class="dropdown-item" href="upload.jsp">Upload</a>
                    </div>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="#">Docs</a>
                </li>
            </ul>
            <ul class="navbar-nav align-items-lg-center ml-lg-auto">
                <li class="nav-item">
                    <a class="nav-link nav-link-icon" href="#">
                        <i class="fab fa-facebook-square"></i>
                        <span class="nav-link-inner--text d-lg-none">Facebook</span>
                    </a>
                </li>
                <li class="nav-item">
                    <a class="nav-link nav-link-icon" href="#">
                        <i class="fab fa-instagram"></i>
                        <span class="nav-link-inner--text d-lg-none">Instagram</span>
                    </a>
                </li>
                <li class="nav-item">
                    <a class="nav-link nav-link-icon" href="#">
                        <i class="fab fa-twitter-square"></i>
                        <span class="nav-link-inner--text d-lg-none">Twitter</span>
                    </a>
                </li>
                <li class="nav-item">
                    <a class="nav-link nav-link-icon" href="#">
                        <i class="fab fa-github-square"></i>
                        <span class="nav-link-inner--text d-lg-none">Github</span>
                    </a>
                </li>
                <li class="nav-item ml-lg-4">
                    <a href="signin.jsp" class="btn btn-neutral btn-icon">
                        <span class="btn-inner--icon">
                            <i class="fas fa-user mr-2"></i>
                        </span>
                        <span class="nav-link-inner--text">Login</span>
                    </a>
                </li>
            </ul>
        </div>
    </div>
</nav>

<!-- Main content -->
<div class="main-content">
    <section class="section section-lg section-hero section-shaped">
        <div class="shape shape-style-1 shape-primary">
            <span class="span-150"></span>
            <span class="span-50"></span>
            <span class="span-50"></span>
            <span class="span-75"></span>
            <span class="span-100"></span>
            <span class="span-75"></span>
            <span class="span-50"></span>
            <span class="span-100"></span>
            <span class="span-50"></span>
            <span class="span-100"></span>
        </div>
        <div class="container shape-container d-flex align-items-center py-lg">
            <div class="col px-0">
                <div class="row align-items-center justify-content-center">
                    <div class="col-lg-8 text-center">
                        <img src="assets/img/brand/white.svg" style="width: 200px;" class="img-fluid">
                        <h1 class="text-white display-1 font-weight-bold">文件上传</h1>
                        <h2 class="display-4 font-weight-normal text-white">支持图片和视频文件上传到云端存储</h2>
                    </div>
                </div>
            </div>
        </div>
    </section>
</div>

<div class="upload-container">

    <form id="uploadForm" enctype="multipart/form-data">
        <div class="upload-section" id="uploadSection">
            <div class="upload-icon">☁️</div>
            <h3>文件上传</h3>
            <p>支持图片: JPG、PNG、GIF、WebP | 视频: MP4、AVI、MOV、WebM</p>
            <div class="file-input-wrapper">
                <input type="file" name="file" class="file-input" id="fileInput" accept="image/*,video/*">
                <button type="button" class="file-input-button">选择文件</button>
            </div>

            <div class="file-preview" id="filePreview"></div>
            <div class="file-info" id="fileInfo"></div>

            <div class="progress-container" id="progressContainer">
                <div class="progress-bar">
                    <div class="progress-fill" id="progressFill"></div>
                </div>
                <div class="progress-text" id="progressText">准备上传...</div>
            </div>

            <div class="status-steps" id="statusSteps">
                <div class="step" id="step1">1⃣ 文件验证</div>
                <div class="step" id="step2">2⃣ 上传到服务器</div>
                <div class="step" id="step3">3⃣ 传输到云存储</div>
                <div class="step" id="step4">4⃣ 更新文件索引</div>
                <div class="step" id="step5">5⃣ 生成预览链接</div>
            </div>

            <button type="submit" class="upload-button" id="uploadBtn">
                <span id="uploadBtnText">上传文件</span>
            </button>

            <div class="result" id="result"></div>
        </div>
    </form>
</div>

<script>
        fetch('/AlistMedia_Web_exploded/storage')
        .then(res => res.text())
        .then(text => {
        document.getElementById('storage-info').innerText = text;
    })
        .catch(err => {
        console.error('获取存储信息失败', err);
        document.getElementById('storage-info').innerText = '获取存储信息失败';
    });
    // 所有变量声明
    var fileInput = document.getElementById('fileInput');
    var fileInfo = document.getElementById('fileInfo');
    var filePreview = document.getElementById('filePreview');
    var uploadBtn = document.getElementById('uploadBtn');
    var uploadBtnText = document.getElementById('uploadBtnText');
    var progressContainer = document.getElementById('progressContainer');
    var progressFill = document.getElementById('progressFill');
    var progressText = document.getElementById('progressText');
    var result = document.getElementById('result');
    var uploadSection = document.getElementById('uploadSection');
    var statusSteps = document.getElementById('statusSteps');

    var selectedFile = null;

    // 文件选择处理
    fileInput.addEventListener('change', function(e) {
        var file = e.target.files[0];
        if (file) {
            selectedFile = file;
            displayFileInfo(file);
            showFilePreview(file);
            uploadBtn.disabled = false;
            result.style.display = 'none';
        }
    });

    // 显示文件信息
    function displayFileInfo(file) {
        var fileSize = (file.size / (1024 * 1024)).toFixed(2);
        var fileType = file.type || '未知类型';
        var fileDate = new Date(file.lastModified).toLocaleString('zh-CN');

        fileInfo.innerHTML = '<div><strong>文件名:</strong> ' + file.name + '</div>' +
            '<div><strong>大小:</strong> ' + fileSize + ' MB</div>' +
            '<div><strong>类型:</strong> ' + fileType + '</div>' +
            '<div><strong>最后修改:</strong> ' + fileDate + '</div>';
        fileInfo.style.display = 'block';
    }

    // 显示文件预览
    function showFilePreview(file) {
        var reader = new FileReader();

        if (file.type.indexOf('image/') === 0) {
            reader.onload = function(e) {
                filePreview.innerHTML = '<img src="' + e.target.result + '" alt="预览图片">';
                filePreview.style.display = 'block';
            };
            reader.readAsDataURL(file);
        } else if (file.type.indexOf('video/') === 0) {
            reader.onload = function(e) {
                filePreview.innerHTML = '<video controls><source src="' + e.target.result + '" type="' + file.type + '"></video>';
                filePreview.style.display = 'block';
            };
            reader.readAsDataURL(file);
        } else {
            filePreview.style.display = 'none';
        }
    }

    // 拖拽上传
    uploadSection.addEventListener('dragover', function(e) {
        e.preventDefault();
        uploadSection.classList.add('dragover');
    });

    uploadSection.addEventListener('dragleave', function(e) {
        e.preventDefault();
        uploadSection.classList.remove('dragover');
    });

    uploadSection.addEventListener('drop', function(e) {
        e.preventDefault();
        uploadSection.classList.remove('dragover');

        var files = e.dataTransfer.files;
        if (files.length > 0) {
            var file = files[0];

            if (file.type.indexOf('image/') === 0 || file.type.indexOf('video/') === 0) {
                fileInput.files = files;
                selectedFile = file;
                displayFileInfo(file);
                showFilePreview(file);
                uploadBtn.disabled = false;
                result.style.display = 'none';
            } else {
                showResult('error', '请选择图片或视频文件！');
            }
        }
    });

    // 更新上传步骤状态
    function updateStepStatus(stepNumber, status) {
        var steps = ['step1', 'step2', 'step3', 'step4', 'step5'];
        status = status || 'current';

        // 清除所有步骤的状态
        for (var i = 0; i < steps.length; i++) {
            var step = document.getElementById(steps[i]);
            step.classList.remove('current', 'completed');
        }

        // 设置已完成的步骤
        for (var i = 1; i < stepNumber; i++) {
            document.getElementById('step' + i).classList.add('completed');
        }

        // 设置当前步骤
        if (stepNumber <= 5) {
            document.getElementById('step' + stepNumber).classList.add(status);
        }
    }

    // 显示结果
    function showResult(type, message, url) {
        result.className = 'result ' + type;

        var content = message;
        if (type === 'success' && url) {
            content += '<br><br><strong>预览链接:</strong><br>';
            content += '<span style="word-break: break-all; background: rgba(0,0,0,0.05); padding: 4px 8px; border-radius: 4px; display: inline-block; margin-top: 4px;">' + url + '</span>';
            content += '<button class="copy-button" onclick="copyToClipboard(\'' + url + '\')">复制链接</button>';
        }

        result.innerHTML = content;
        result.style.display = 'block';
    }

    // 复制到剪贴板
    function copyToClipboard(text) {
        if (navigator.clipboard) {
            navigator.clipboard.writeText(text).then(function() {
                var button = event.target;
                var originalText = button.textContent;
                button.textContent = '已复制!';
                button.style.background = 'rgba(76, 175, 80, 0.2)';
                button.style.color = '#4CAF50';

                setTimeout(function() {
                    button.textContent = originalText;
                    button.style.background = '';
                    button.style.color = '';
                }, 2000);
            });
        } else {
            // 降级处理
            var textArea = document.createElement('textarea');
            textArea.value = text;
            document.body.appendChild(textArea);
            textArea.select();
            document.execCommand('copy');
            document.body.removeChild(textArea);

            var button = event.target;
            var originalText = button.textContent;
            button.textContent = '已复制!';
            setTimeout(function() {
                button.textContent = originalText;
            }, 2000);
        }
    }

    // 表单提交
    document.getElementById('uploadForm').addEventListener('submit', function(e) {
        e.preventDefault();

        if (!selectedFile) {
            showResult('error', '请先选择文件！');
            return;
        }

        // 开始上传流程
        uploadSection.classList.add('uploading');
        uploadBtn.disabled = true;
        uploadBtn.classList.add('uploading');
        uploadBtnText.innerHTML = '<span class="loading-spinner"></span>上传中...';

        progressContainer.style.display = 'block';
        statusSteps.style.display = 'block';
        result.style.display = 'none';

        // 创建FormData
        var formData = new FormData();
        formData.append('file', selectedFile);

        // 模拟上传步骤进度
        updateStepStatus(1, 'current');
        progressText.textContent = '验证文件...';
        progressFill.style.width = '10%';

        setTimeout(function() {
            updateStepStatus(2, 'current');
            progressText.textContent = '上传到服务器...';
            progressFill.style.width = '30%';
        }, 500);

        // 实际上传请求
        var xhr = new XMLHttpRequest();
        xhr.open('POST', 'upload', true);

        xhr.onload = function() {
            if (xhr.status === 200) {
                var data = xhr.responseText;

                // 模拟剩余步骤
                updateStepStatus(3, 'current');
                progressText.textContent = '传输到云存储...';
                progressFill.style.width = '60%';

                setTimeout(function() {
                    updateStepStatus(4, 'current');
                    progressText.textContent = '更新文件索引...';
                    progressFill.style.width = '80%';

                    setTimeout(function() {
                        updateStepStatus(5, 'current');
                        progressText.textContent = '生成预览链接...';
                        progressFill.style.width = '100%';

                        setTimeout(function() {
                            // 完成上传
                            updateStepStatus(6, 'completed');
                            progressText.textContent = '上传完成！';

                            // 解析返回的数据，提取预览URL
                            var previewUrlMatch = data.match(/预览地址为：(.+)/);
                            var previewUrl = previewUrlMatch ? previewUrlMatch[1].trim() : null;

                            showResult('success', data, previewUrl);
                            resetUploadState();
                        }, 500);
                    }, 800);
                }, 800);
            } else {
                showResult('error', 'HTTP ' + xhr.status + ': ' + xhr.statusText);
                resetUploadState();
            }
        };

        xhr.onerror = function() {
            showResult('error', '网络错误，请检查连接');
            resetUploadState();
        };

        xhr.send(formData);
    });

    // 重置上传状态
    function resetUploadState() {
        uploadSection.classList.remove('uploading');
        uploadBtn.disabled = false;
        uploadBtn.classList.remove('uploading');
        uploadBtnText.textContent = '上传文件';
        progressContainer.style.display = 'none';
        statusSteps.style.display = 'none';
        progressFill.style.width = '0%';
    }
</script>

<!-- Core -->
<script src="assets/vendor/jquery/jquery.min.js"></script>
<script src="assets/vendor/popper/popper.min.js"></script>
<script src="assets/vendor/bootstrap/bootstrap.min.js"></script>
<script src="assets/vendor/headroom/headroom.min.js"></script>
<!-- Optional JS -->
<script src="assets/vendor/onscreen/onscreen.min.js"></script>
<script src="assets/vendor/nouislider/js/nouislider.min.js"></script>
<script src="assets/vendor/bootstrap-datepicker/js/bootstrap-datepicker.min.js"></script>
<!-- Argon JS -->
<script src="assets/js/argon.js?v=1.0.1"></script>
</body>
</html>