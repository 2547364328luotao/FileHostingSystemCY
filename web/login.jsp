<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="description" content="AlistFHS Cloud SU - 用户登录">
    <title>用户登录 - AlistFHS Cloud SU</title>
    
    <!-- 引入Google字体 -->
    <link href="https://fonts.googleapis.com/css?family=Nunito:400,600,700,800|Roboto:400,500,700" rel="stylesheet">
    
    <!-- 引入动画库 -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/vendor/animate/animate.min.css" type="text/css">
    
    <!-- Boomerang UI Kit 主题样式文件 -->
    <link type="text/css" href="${pageContext.request.contextPath}/assets/css/theme.css" rel="stylesheet">
    
    <style>
        .login-container {
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
        }
        
        .login-card {
            background: rgba(255, 255, 255, 0.95);
            backdrop-filter: blur(10px);
            border-radius: 20px;
            padding: 40px;
            box-shadow: 0 20px 40px rgba(0, 0, 0, 0.1);
            border: 1px solid rgba(255, 255, 255, 0.2);
            width: 100%;
            max-width: 400px;
        }
        
        .login-header {
            text-align: center;
            margin-bottom: 30px;
        }
        
        .login-header h2 {
            color: #333;
            font-weight: 600;
            margin-bottom: 10px;
        }
        
        .login-header p {
            color: #666;
            margin: 0;
        }
        
        .form-group {
            margin-bottom: 20px;
        }
        
        .form-group label {
            display: block;
            margin-bottom: 8px;
            color: #333;
            font-weight: 500;
        }
        
        .form-control {
            width: 100%;
            padding: 12px 16px;
            border: 2px solid #e1e5e9;
            border-radius: 10px;
            font-size: 16px;
            transition: all 0.3s ease;
            box-sizing: border-box;
        }
        
        .form-control:focus {
            outline: none;
            border-color: #667eea;
            box-shadow: 0 0 0 3px rgba(102, 126, 234, 0.1);
        }
        
        .btn-login {
            width: 100%;
            padding: 14px;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            border: none;
            border-radius: 10px;
            font-size: 16px;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s ease;
            margin-bottom: 20px;
        }
        
        .btn-login:hover {
            transform: translateY(-2px);
            box-shadow: 0 8px 25px rgba(102, 126, 234, 0.3);
        }
        
        .btn-login:disabled {
            opacity: 0.6;
            cursor: not-allowed;
            transform: none;
        }
        
        .alert {
            padding: 12px 16px;
            border-radius: 8px;
            margin-bottom: 20px;
            font-size: 14px;
        }
        
        .alert-success {
            background-color: #d4edda;
            border: 1px solid #c3e6cb;
            color: #155724;
        }
        
        .alert-error {
            background-color: #f8d7da;
            border: 1px solid #f5c6cb;
            color: #721c24;
        }
        
        .register-link {
            text-align: center;
            margin-top: 20px;
        }
        
        .register-link a {
            color: #667eea;
            text-decoration: none;
            font-weight: 500;
        }
        
        .register-link a:hover {
            text-decoration: underline;
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
    </style>
</head>
<body>
    <div class="login-container">
        <div class="login-card">
            <div class="login-header">
                <h2>用户登录</h2>
                <p>欢迎回到 AlistFHS Cloud SU</p>
            </div>
            
            <div id="alertContainer"></div>
            
            <form id="loginForm">
                <div class="form-group">
                    <label for="username">用户名</label>
                    <input type="text" id="username" name="username" class="form-control" required>
                </div>
                
                <div class="form-group">
                    <label for="password">密码</label>
                    <input type="password" id="password" name="password" class="form-control" required>
                </div>
                
                <button type="submit" id="loginBtn" class="btn-login">
                    <span id="loginBtnText">登录</span>
                </button>
            </form>
            
            <div class="register-link">
                <p>还没有账户？ <a href="register.jsp">立即注册</a></p>
            </div>
        </div>
    </div>
    
    <script>
        document.getElementById('loginForm').addEventListener('submit', function(e) {
            e.preventDefault();
            
            const username = document.getElementById('username').value.trim();
            const password = document.getElementById('password').value;
            const loginBtn = document.getElementById('loginBtn');
            const loginBtnText = document.getElementById('loginBtnText');
            const alertContainer = document.getElementById('alertContainer');
            
            // 清除之前的提示
            alertContainer.innerHTML = '';
            
            // 基本验证
            if (!username || !password) {
                showAlert('请填写用户名和密码', 'error');
                return;
            }
            
            // 禁用按钮，显示加载状态
            loginBtn.disabled = true;
            loginBtnText.innerHTML = '<span class="loading-spinner"></span>登录中...';
            
            // 发送登录请求
            const formData = new FormData();
            formData.append('username', username);
            formData.append('password', password);
            
            fetch('${pageContext.request.contextPath}/login', {
                method: 'POST',
                body: formData
            })
            .then(response => response.json())
            .then(data => {
                if (data.success) {
                    showAlert('登录成功，正在跳转...', 'success');
                    
                    // 获取重定向URL
                    const urlParams = new URLSearchParams(window.location.search);
                    const redirectUrl = urlParams.get('redirect') || '${pageContext.request.contextPath}/index.jsp';
                    
                    // 延迟跳转
                    setTimeout(() => {
                        window.location.href = redirectUrl;
                    }, 1000);
                } else {
                    showAlert(data.message || '登录失败', 'error');
                }
            })
            .catch(error => {
                console.error('登录请求失败:', error);
                showAlert('网络错误，请稍后重试', 'error');
            })
            .finally(() => {
                // 恢复按钮状态
                loginBtn.disabled = false;
                loginBtnText.textContent = '登录';
            });
        });
        
        function showAlert(message, type) {
            const alertContainer = document.getElementById('alertContainer');
            const alertClass = type === 'success' ? 'alert-success' : 'alert-error';
            
            alertContainer.innerHTML = `
                <div class="alert ${alertClass}">
                    ${message}
                </div>
            `;
        }
        
        // 检查是否已登录
        fetch('${pageContext.request.contextPath}/login')
        .then(response => response.json())
        .then(data => {
            if (data.success && data.loggedIn) {
                // 已登录，重定向
                const urlParams = new URLSearchParams(window.location.search);
                const redirectUrl = urlParams.get('redirect') || '${pageContext.request.contextPath}/index.jsp';
                window.location.href = redirectUrl;
            }
        })
        .catch(error => {
            console.error('检查登录状态失败:', error);
        });
    </script>
</body>
</html>