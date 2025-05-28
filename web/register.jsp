<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="description" content="AlistFHS Cloud SU - 用户注册">
    <title>用户注册 - AlistFHS Cloud SU</title>
    
    <!-- 引入Google字体 -->
    <link href="https://fonts.googleapis.com/css?family=Nunito:400,600,700,800|Roboto:400,500,700" rel="stylesheet">
    
    <!-- 引入动画库 -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/vendor/animate/animate.min.css" type="text/css">
    
    <!-- Boomerang UI Kit 主题样式文件 -->
    <link type="text/css" href="${pageContext.request.contextPath}/assets/css/theme.css" rel="stylesheet">
    
    <style>
        .register-container {
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            padding: 20px 0;
        }
        
        .register-card {
            background: rgba(255, 255, 255, 0.95);
            backdrop-filter: blur(10px);
            border-radius: 20px;
            padding: 40px;
            box-shadow: 0 20px 40px rgba(0, 0, 0, 0.1);
            border: 1px solid rgba(255, 255, 255, 0.2);
            width: 100%;
            max-width: 450px;
        }
        
        .register-header {
            text-align: center;
            margin-bottom: 30px;
        }
        
        .register-header h2 {
            color: #333;
            font-weight: 600;
            margin-bottom: 10px;
        }
        
        .register-header p {
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
        
        .form-control.error {
            border-color: #dc3545;
        }
        
        .form-control.success {
            border-color: #28a745;
        }
        
        .form-text {
            font-size: 12px;
            color: #666;
            margin-top: 5px;
        }
        
        .form-text.error {
            color: #dc3545;
        }
        
        .btn-register {
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
        
        .btn-register:hover {
            transform: translateY(-2px);
            box-shadow: 0 8px 25px rgba(102, 126, 234, 0.3);
        }
        
        .btn-register:disabled {
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
        
        .login-link {
            text-align: center;
            margin-top: 20px;
        }
        
        .login-link a {
            color: #667eea;
            text-decoration: none;
            font-weight: 500;
        }
        
        .login-link a:hover {
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
        
        .password-strength {
            margin-top: 5px;
        }
        
        .strength-bar {
            height: 4px;
            background-color: #e1e5e9;
            border-radius: 2px;
            overflow: hidden;
        }
        
        .strength-fill {
            height: 100%;
            width: 0%;
            transition: all 0.3s ease;
        }
        
        .strength-weak { background-color: #dc3545; }
        .strength-medium { background-color: #ffc107; }
        .strength-strong { background-color: #28a745; }
    </style>
</head>
<body>
    <div class="register-container">
        <div class="register-card">
            <div class="register-header">
                <h2>用户注册</h2>
                <p>创建您的 AlistFHS Cloud SU 账户</p>
            </div>
            
            <div id="alertContainer"></div>
            
            <form id="registerForm">
                <div class="form-group">
                    <label for="username">用户名 *</label>
                    <input type="text" id="username" name="username" class="form-control" required>
                    <div class="form-text" id="usernameHelp">用户名长度为3-20个字符，只能包含字母、数字和下划线</div>
                </div>
                
                <div class="form-group">
                    <label for="email">邮箱</label>
                    <input type="email" id="email" name="email" class="form-control">
                    <div class="form-text">可选，用于找回密码</div>
                </div>
                
                <div class="form-group">
                    <label for="password">密码 *</label>
                    <input type="password" id="password" name="password" class="form-control" required>
                    <div class="password-strength">
                        <div class="strength-bar">
                            <div class="strength-fill" id="strengthFill"></div>
                        </div>
                        <div class="form-text" id="passwordHelp">密码长度至少6个字符</div>
                    </div>
                </div>
                
                <div class="form-group">
                    <label for="confirmPassword">确认密码 *</label>
                    <input type="password" id="confirmPassword" name="confirmPassword" class="form-control" required>
                    <div class="form-text" id="confirmPasswordHelp"></div>
                </div>
                
                <button type="submit" id="registerBtn" class="btn-register">
                    <span id="registerBtnText">注册</span>
                </button>
            </form>
            
            <div class="login-link">
                <p>已有账户？ <a href="login.jsp">立即登录</a></p>
            </div>
        </div>
    </div>
    
    <script>
        const usernameInput = document.getElementById('username');
        const emailInput = document.getElementById('email');
        const passwordInput = document.getElementById('password');
        const confirmPasswordInput = document.getElementById('confirmPassword');
        const registerForm = document.getElementById('registerForm');
        
        // 用户名验证
        usernameInput.addEventListener('blur', function() {
            const username = this.value.trim();
            const helpText = document.getElementById('usernameHelp');
            
            if (username.length === 0) {
                this.className = 'form-control';
                helpText.textContent = '用户名长度为3-20个字符，只能包含字母、数字和下划线';
                helpText.className = 'form-text';
                return;
            }
            
            if (username.length < 3 || username.length > 20) {
                this.className = 'form-control error';
                helpText.textContent = '用户名长度必须为3-20个字符';
                helpText.className = 'form-text error';
                return;
            }
            
            if (!/^[a-zA-Z0-9_]+$/.test(username)) {
                this.className = 'form-control error';
                helpText.textContent = '用户名只能包含字母、数字和下划线';
                helpText.className = 'form-text error';
                return;
            }
            
            this.className = 'form-control success';
            helpText.textContent = '用户名格式正确';
            helpText.className = 'form-text';
        });
        
        // 密码强度检查
        passwordInput.addEventListener('input', function() {
            const password = this.value;
            const strengthFill = document.getElementById('strengthFill');
            const helpText = document.getElementById('passwordHelp');
            
            if (password.length === 0) {
                strengthFill.style.width = '0%';
                helpText.textContent = '密码长度至少6个字符';
                helpText.className = 'form-text';
                return;
            }
            
            let strength = 0;
            if (password.length >= 6) strength++;
            if (password.length >= 8) strength++;
            if (/[a-z]/.test(password) && /[A-Z]/.test(password)) strength++;
            if (/\d/.test(password)) strength++;
            if (/[^\w\s]/.test(password)) strength++;
            
            const percentage = (strength / 5) * 100;
            strengthFill.style.width = percentage + '%';
            
            if (strength <= 2) {
                strengthFill.className = 'strength-fill strength-weak';
                helpText.textContent = '密码强度：弱';
            } else if (strength <= 3) {
                strengthFill.className = 'strength-fill strength-medium';
                helpText.textContent = '密码强度：中等';
            } else {
                strengthFill.className = 'strength-fill strength-strong';
                helpText.textContent = '密码强度：强';
            }
            
            // 检查确认密码
            checkPasswordMatch();
        });
        
        // 确认密码检查
        confirmPasswordInput.addEventListener('input', checkPasswordMatch);
        
        function checkPasswordMatch() {
            const password = passwordInput.value;
            const confirmPassword = confirmPasswordInput.value;
            const helpText = document.getElementById('confirmPasswordHelp');
            
            if (confirmPassword.length === 0) {
                confirmPasswordInput.className = 'form-control';
                helpText.textContent = '';
                return;
            }
            
            if (password === confirmPassword) {
                confirmPasswordInput.className = 'form-control success';
                helpText.textContent = '密码匹配';
                helpText.className = 'form-text';
            } else {
                confirmPasswordInput.className = 'form-control error';
                helpText.textContent = '密码不匹配';
                helpText.className = 'form-text error';
            }
        }
        
        // 表单提交
        registerForm.addEventListener('submit', function(e) {
            e.preventDefault();
            
            const username = usernameInput.value.trim();
            const email = emailInput.value.trim();
            const password = passwordInput.value;
            const confirmPassword = confirmPasswordInput.value;
            const registerBtn = document.getElementById('registerBtn');
            const registerBtnText = document.getElementById('registerBtnText');
            const alertContainer = document.getElementById('alertContainer');
            
            // 清除之前的提示
            alertContainer.innerHTML = '';
            
            // 验证
            if (!username || !password || !confirmPassword) {
                showAlert('请填写所有必填字段', 'error');
                return;
            }
            
            if (username.length < 3 || username.length > 20) {
                showAlert('用户名长度必须为3-20个字符', 'error');
                return;
            }
            
            if (!/^[a-zA-Z0-9_]+$/.test(username)) {
                showAlert('用户名只能包含字母、数字和下划线', 'error');
                return;
            }
            
            if (password.length < 6) {
                showAlert('密码长度至少6个字符', 'error');
                return;
            }
            
            if (password !== confirmPassword) {
                showAlert('两次输入的密码不一致', 'error');
                return;
            }
            
            if (email && !/^[^\s@]+@[^\s@]+\.[^\s@]+$/.test(email)) {
                showAlert('邮箱格式不正确', 'error');
                return;
            }
            
            // 禁用按钮，显示加载状态
            registerBtn.disabled = true;
            registerBtnText.innerHTML = '<span class="loading-spinner"></span>注册中...';
            
            // 发送注册请求
            const formData = new FormData();
            formData.append('username', username);
            formData.append('password', password);
            if (email) formData.append('email', email);
            
            fetch('${pageContext.request.contextPath}/register', {
                method: 'POST',
                body: formData
            })
            .then(response => response.json())
            .then(data => {
                if (data.success) {
                    showAlert('注册成功！正在跳转到首页...', 'success');
                    
                    // 延迟跳转
                    setTimeout(() => {
                        window.location.href = '${pageContext.request.contextPath}/index.jsp';
                    }, 1500);
                } else {
                    showAlert(data.message || '注册失败', 'error');
                }
            })
            .catch(error => {
                console.error('注册请求失败:', error);
                showAlert('网络错误，请稍后重试', 'error');
            })
            .finally(() => {
                // 恢复按钮状态
                registerBtn.disabled = false;
                registerBtnText.textContent = '注册';
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
                // 已登录，重定向到首页
                window.location.href = '${pageContext.request.contextPath}/index.jsp';
            }
        })
        .catch(error => {
            console.error('检查登录状态失败:', error);
        });
    </script>
</body>
</html>