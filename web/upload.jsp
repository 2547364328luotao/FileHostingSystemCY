<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Alist 云存储上传</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, sans-serif;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            min-height: 100vh;
            display: flex;
            justify-content: center;
            align-items: center;
            padding: 20px;
        }

        .container {
            background: rgba(255, 255, 255, 0.95);
            backdrop-filter: blur(10px);
            border-radius: 24px;
            padding: 40px;
            box-shadow: 0 20px 40px rgba(0, 0, 0, 0.1);
            width: 100%;
            max-width: 600px;
            border: 1px solid rgba(255, 255, 255, 0.2);
        }

        .header {
            text-align: center;
            margin-bottom: 40px;
        }

        .header h1 {
            color: #333;
            font-size: 32px;
            font-weight: 700;
            margin-bottom: 8px;
            background: linear-gradient(135deg, #667eea, #764ba2);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            background-clip: text;
        }

        .header p {
            color: #666;
            font-size: 16px;
        }

        .upload-section {
            margin-bottom: 30px;
            padding: 30px;
            border: 2px dashed #e1e5e9;
            border-radius: 16px;
            transition: all 0.3s ease;
            position: relative;
            overflow: hidden;
        }

        .upload-section:hover {
            border-color: #667eea;
            background: rgba(102, 126, 234, 0.05);
        }

        .upload-section.dragover {
            border-color: #667eea;
            background: rgba(102, 126, 234, 0.1);
            transform: scale(1.02);
        }

        .upload-section.uploading {
            pointer-events: none;
            opacity: 0.7;
        }

        .upload-icon {
            font-size: 48px;
            margin-bottom: 16px;
            display: block;
            text-align: center;
        }

        .upload-section h3 {
            color: #333;
            font-size: 20px;
            margin-bottom: 8px;
            text-align: center;
        }

        .upload-section p {
            color: #666;
            font-size: 14px;
            text-align: center;
            margin-bottom: 20px;
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
            padding: 12px 24px;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            border: none;
            border-radius: 12px;
            font-size: 16px;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s ease;
            text-align: center;
        }

        .file-input-button:hover {
            transform: translateY(-2px);
            box-shadow: 0 8px 25px rgba(102, 126, 234, 0.3);
        }

        .upload-button {
            width: 100%;
            padding: 14px;
            background: linear-gradient(135deg, #4CAF50 0%, #45a049 100%);
            color: white;
            border: none;
            border-radius: 12px;
            font-size: 16px;
            font-weight: 600;
            cursor: pointer;
            margin-top: 15px;
            transition: all 0.3s ease;
            opacity: 0.7;
            pointer-events: none;
        }

        .upload-button:enabled {
            opacity: 1;
            pointer-events: auto;
        }

        .upload-button:enabled:hover {
            transform: translateY(-2px);
            box-shadow: 0 8px 25px rgba(76, 175, 80, 0.3);
        }

        .upload-button.uploading {
            background: linear-gradient(135deg, #ff9800 0%, #f57c00 100%);
            cursor: not-allowed;
        }

        .file-info {
            margin-top: 15px;
            padding: 12px;
            background: rgba(102, 126, 234, 0.1);
            border-radius: 8px;
            font-size: 14px;
            color: #333;
            display: none;
        }

        .progress-container {
            margin-top: 15px;
            display: none;
        }

        .progress-bar {
            width: 100%;
            height: 8px;
            background: #e1e5e9;
            border-radius: 4px;
            overflow: hidden;
            margin-bottom: 8px;
        }

        .progress-fill {
            height: 100%;
            background: linear-gradient(90deg, #4CAF50, #45a049);
            width: 0%;
            transition: width 0.3s ease;
            border-radius: 4px;
        }

        .progress-text {
            font-size: 12px;
            color: #666;
            text-align: center;
        }

        .result {
            margin-top: 20px;
            padding: 15px;
            border-radius: 8px;
            font-size: 14px;
            display: none;
            position: relative;
        }

        .result.success {
            background: rgba(76, 175, 80, 0.1);
            color: #2e7d32;
            border: 1px solid rgba(76, 175, 80, 0.2);
        }

        .result.error {
            background: rgba(244, 67, 54, 0.1);
            color: #c62828;
            border: 1px solid rgba(244, 67, 54, 0.2);
        }

        .copy-button {
            background: rgba(102, 126, 234, 0.1);
            border: 1px solid rgba(102, 126, 234, 0.3);
            color: #667eea;
            padding: 4px 8px;
            border-radius: 4px;
            font-size: 12px;
            cursor: pointer;
            margin-left: 8px;
            transition: all 0.2s ease;
        }

        .copy-button:hover {
            background: rgba(102, 126, 234, 0.2);
        }

        .file-preview {
            margin-top: 15px;
            text-align: center;
            display: none;
        }

        .file-preview img {
            max-width: 100%;
            max-height: 200px;
            border-radius: 8px;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
        }

        .file-preview video {
            max-width: 100%;
            max-height: 200px;
            border-radius: 8px;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
        }

        .loading-spinner {
            display: inline-block;
            width: 16px;
            height: 16px;
            border: 2px solid rgba(255, 255, 255, 0.3);
            border-radius: 50%;
            border-top-color: white;
            animation: spin 1s ease-in-out infinite;
            margin-right: 8px;
        }

        @keyframes spin {
            to { transform: rotate(360deg); }
        }

        .status-steps {
            margin-top: 15px;
            font-size: 12px;
            color: #666;
            line-height: 1.5;
            display: none;
        }

        .step {
            margin-bottom: 4px;
        }

        .step.completed {
            color: #4CAF50;
        }

        .step.current {
            color: #667eea;
            font-weight: 600;
        }

        @media (max-width: 600px) {
            .container {
                margin: 20px;
                padding: 30px 20px;
            }

            .header h1 {
                font-size: 24px;
            }
        }

        #storage-info {
            position: fixed;      /* 固定定位，方便从顶部滑入 */
            top: -50px;           /* 初始位置：在视口顶部外面 */
            left: 50%;            /* 水平居中 */
            transform: translateX(-50%);
            background-color: #f0f0f0; /* 可以根据需要调整背景色 */
            padding: 10px 20px;
            border-radius: 5px;
            box-shadow: 0 2px 8px rgba(0,0,0,0.15);
            font-weight: bold;
            animation: slideDown 0.7s ease forwards;
            /* forwards 保持动画结束时的状态 */
        }

        @keyframes slideDown {
            0% {
                top: -50px;
                opacity: 0;
            }
            100% {
                top: 20px;   /* 最终位置离顶部20px */
                opacity: 1;
            }
        }

    </style>
</head>
<body>
<div id="storage-info">正在加载存储信息...</div>
<div class="container">
    <div class="header">
        <h1>Alist 云存储</h1>
        <p>支持图片和视频文件上传到云端存储</p>
    </div>

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
</body>
</html>