<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <!-- 基本页面信息设置 -->
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <meta name="description" content="Boomerang UI Kit - 完整页面组件">
  <meta name="author" content="Webpixels">
  <title>AlistFHS Cloud SU - Boomerang UI Kit</title>

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
    }

    /* 手动编写的动画效果 */
    @keyframes bounceInDown {
      0% {
        opacity: 0;
        transform: translate3d(0, -3000px, 0) scaleY(3);
      }
      60% {
        opacity: 1;
        transform: translate3d(0, 25px, 0) scaleY(0.9);
      }
      75% {
        transform: translate3d(0, -10px, 0) scaleY(0.95);
      }
      90% {
        transform: translate3d(0, 5px, 0) scaleY(0.985);
      }
      100% {
        opacity: 1;
        transform: translate3d(0, 0, 0) scaleY(1);
      }
    }

    @keyframes fadeInUp {
      0% {
        opacity: 0;
        transform: translate3d(0, 100%, 0);
      }
      100% {
        opacity: 1;
        transform: translate3d(0, 0, 0);
      }
    }

    /* 应用动画 */
    .brand-icon {
      animation: bounceInDown 1s ease-out 1s both;
    }

    .main-title {
      animation: fadeInUp 1s ease-out 2s both;
    }

    .description-text {
      animation: fadeInUp 1s ease-out 2.5s both;
    }

    /* 透明导航栏样式 */
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
  </style>
</head>
<body>
<!-- ========== 顶部导航栏组件 ========== -->
<nav class="navbar navbar-expand-lg navbar-dark navbar-transparent py-4">
  <div class="container">
    <a class="navbar-brand" href="./"><strong>AlistFHS</strong> Cloud SU</a>

    <button class="navbar-toggler" type="button" data-action="offcanvas-open" data-target="#navbar_main" aria-controls="navbar_main" aria-expanded="false" aria-label="Toggle navigation">
      <span class="navbar-toggler-icon"></span>
    </button>

    <div class="navbar-collapse offcanvas-collapse" id="navbar_main">
      <ul class="navbar-nav ml-auto align-items-lg-center">
        <h6 class="dropdown-header font-weight-600 d-lg-none px-0">Menu</h6>

        <li class="nav-item active">
          <a class="nav-link" href="${pageContext.request.contextPath}/index.jsp">Overview</a>
        </li>

        <li class="nav-item dropdown">
          <a class="nav-link dropdown-toggle" href="#" id="navbar_main_dropdown_1" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">Pages</a>
          <div class="dropdown-menu" aria-labelledby="navbar_1_dropdown_1">
            <a class="dropdown-item" href="${pageContext.request.contextPath}/pages/homepage.jsp">Homepage</a>
            <a class="dropdown-item" href="${pageContext.request.contextPath}/pages/about.jsp">About us</a>
            <a class="dropdown-item" href="${pageContext.request.contextPath}/pages/sign-in.jsp">Sign in</a>
            <a class="dropdown-item" href="${pageContext.request.contextPath}/pages/contact.jsp">Contact</a>
          </div>
        </li>

        <li class="nav-item">
          <a class="nav-link" href="${pageContext.request.contextPath}/docs/introduction.jsp">Docs</a>
        </li>

        <li class="nav-item ml-lg-4">
          <a href="${pageContext.request.contextPath}/sign-in.jsp" class="btn btn-sm bg-white btn-icon mr-2 text-success">
            <span class="btn-inner--icon"><i class="fas fa-sign-in-alt mr-2"></i></span>
            <span class="btn-inner--text">登录/注册</span>
          </a>
        </li>

        <li class="nav-item">
          <a href="#" class="nav-link nav-link-icon"><svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" viewBox="0 0 24 24"><path fill="none" stroke="currentColor" stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M3 10a4 4 0 0 1 4-4h10a4 4 0 0 1 4 4v6a4 4 0 0 1-4 4H7a4 4 0 0 1-4-4zm5-7l2 3m6-3l-2 3m-5 7v-2m6 0v2"/></svg></a>
        </li>
        <li class="nav-item">
          <a href="#" class="nav-link nav-link-icon"><svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" viewBox="0 0 24 24"><g fill="none"><path d="m12.593 23.258l-.011.002l-.071.035l-.02.004l-.014-.004l-.071-.035q-.016-.005-.024.005l-.004.01l-.017.428l.005.02l.01.013l.104.074l.015.004l.012-.004l.104-.074l.012-.016l.004-.017l-.017-.427q-.004-.016-.017-.018m.265-.113l-.013.002l-.185.093l-.01.01l-.003.011l.018.43l.005.012l.008.007l.201.093q.019.005.029-.008l.004-.014l-.034-.614q-.005-.018-.02-.022m-.715.002a.02.02 0 0 0-.027.006l-.006.014l-.034.614q.001.018.017.024l.015-.002l.201-.093l.01-.008l.004-.011l.017-.43l-.003-.012l-.01-.01z"/><path fill="currentColor" d="M10 3c4.071 0 7.7 2.67 7.982 6.368c2.304.862 4.018 2.81 4.018 5.26c0 1.867-1.026 3.472-2.52 4.493a2.3 2.3 0 0 0-.022.439l.014.44a1 1 0 0 1-1 1c-.758 0-1.46-.247-2.054-.71a8 8 0 0 1-1.105.078c-2.767 0-5.322-1.491-6.284-3.751a9 9 0 0 1-.454-.058c-.716.567-1.54.885-2.464.885a1 1 0 0 1-1-1l.005-.203l.018-.41a2.1 2.1 0 0 0-.058-.608C3.248 14.004 2 12.073 2 9.833C2 5.896 5.76 3 10 3m5.313 7.889c-2.768 0-4.688 1.837-4.688 3.74c0 1.902 1.92 3.74 4.688 3.74a6 6 0 0 0 1.078-.101c.434-.082.819.1 1.15.36c.099-.433.324-.842.706-1.088C19.363 16.82 20 15.753 20 14.629c0-1.903-1.92-3.74-4.687-3.74M10 5C6.508 5 4 7.327 4 9.833c0 1.477.837 2.858 2.264 3.777c.531.343.76.957.83 1.559l.482-.342c.308-.208.63-.366 1.05-.288c.056-3.286 3.203-5.65 6.687-5.65q.288 0 .573.021C15.362 6.784 13.059 5 10 5m3.62 8a1 1 0 1 1 0 2a1 1 0 0 1 0-2M17 13a1 1 0 1 1 0 2a1 1 0 0 1 0-2M8 7a1 1 0 1 1 0 2a1 1 0 0 1 0-2m4 0a1 1 0 1 1 0 2a1 1 0 0 1 0-2"/></g></svg></a>
        </li>
        <li class="nav-item">
          <a href="#" class="nav-link nav-link-icon"><svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" viewBox="0 0 24 24"><g fill="none" stroke="currentColor" stroke-linecap="round" stroke-linejoin="round" stroke-width="2"><path stroke-dasharray="20" stroke-dashoffset="20" d="M21 5l-2.5 15M21 5l-12 8.5"><animate fill="freeze" attributeName="stroke-dashoffset" dur="0.4s" values="20;0"/></path><path stroke-dasharray="24" stroke-dashoffset="24" d="M21 5l-19 7.5"><animate fill="freeze" attributeName="stroke-dashoffset" dur="0.4s" values="24;0"/></path><path stroke-dasharray="14" stroke-dashoffset="14" d="M18.5 20l-9.5 -6.5"><animate fill="freeze" attributeName="stroke-dashoffset" begin="0.4s" dur="0.3s" values="14;0"/></path><path stroke-dasharray="10" stroke-dashoffset="10" d="M2 12.5l7 1"><animate fill="freeze" attributeName="stroke-dashoffset" begin="0.4s" dur="0.3s" values="10;0"/></path><path stroke-dasharray="8" stroke-dashoffset="8" d="M12 16l-3 3M9 13.5l0 5.5"><animate fill="freeze" attributeName="stroke-dashoffset" begin="0.7s" dur="0.3s" values="8;0"/></path></g></svg></a>
        </li>
        <li class="nav-item">
          <a href="https://github.com/2547364328luotao/FileHostingSystemCY" class="nav-link nav-link-icon"><svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" viewBox="0 0 24 24"><mask id="IconifyId1971632191cd242eb3" width="24" height="24" x="0" y="0"><g fill="#fff"><ellipse cx="9.5" cy="9" rx="1.5" ry="1"/><ellipse cx="14.5" cy="9" rx="1.5" ry="1"/></g></mask><g fill="none" stroke="currentColor" stroke-linecap="round" stroke-linejoin="round" stroke-width="2"><path stroke-dasharray="32" stroke-dashoffset="32" d="M12 4c1.67 0 2.61 0.4 3 0.5c0.53 -0.43 1.94 -1.5 3.5 -1.5c0.34 1 0.29 2.22 0 3c0.75 1 1 2 1 3.5c0 2.19 -0.48 3.58 -1.5 4.5c-1.02 0.92 -2.11 1.37 -3.5 1.5c0.65 0.54 0.5 1.87 0.5 2.5c0 0.73 0 3 0 3M12 4c-1.67 0 -2.61 0.4 -3 0.5c-0.53 -0.43 -1.94 -1.5 -3.5 -1.5c-0.34 1 -0.29 2.22 0 3c-0.75 1 -1 2 -1 3.5c0 2.19 0.48 3.58 1.5 4.5c1.02 0.92 2.11 1.37 3.5 1.5c-0.65 0.54 -0.5 1.87 -0.5 2.5c0 0.73 0 3 0 3"><animate fill="freeze" attributeName="stroke-dashoffset" dur="0.7s" values="32;0"/></path><path stroke-dasharray="10" stroke-dashoffset="10" d="M9 19c-1.406 0-2.844-.563-3.688-1.188C4.47 17.188 4.22 16.157 3 15.5"><animate attributeName="d" dur="3s" repeatCount="indefinite" values="M9 19c-1.406 0-2.844-.563-3.688-1.188C4.47 17.188 4.22 16.157 3 15.5;M9 19c-1.406 0-3-.5-4-.5-.532 0-1 0-2-.5;M9 19c-1.406 0-2.844-.563-3.688-1.188C4.47 17.188 4.22 16.157 3 15.5"/><animate fill="freeze" attributeName="stroke-dashoffset" begin="0.8s" dur="0.2s" values="10;0"/></path></g><rect width="8" height="4" x="8" y="11" fill="currentColor" mask="url(#IconifyId1971632191cd242eb3)"><animate attributeName="y" dur="10s" keyTimes="0;0.45;0.46;0.54;0.55;1" repeatCount="indefinite" values="11;11;7;7;11;11"/></rect></svg></a>
        </li>
      </ul>
    </div>
  </div>
</nav>

<!-- ========== 主体封面区域组件 ========== -->
<main class="main">
  <section class="spotlight parallax bg-cover bg-size--cover" data-spotlight="fullscreen" style="background-image: url('${pageContext.request.contextPath}/assets/images/backgrounds/alpine-4552654.jpg')">
    <span class="mask bg-dark alpha-1"></span>

    <div class="spotlight-holder py-lg pt-lg-xl">
      <div class="container d-flex align-items-center no-padding">
        <div class="col">
          <div class="row cols-xs-space align-items-center text-center text-md-left justify-content-center">
            <div class="col-7">
              <div class="text-center mt-5">
                <img src="${pageContext.request.contextPath}/assets/images/brand/icon.png"
                     style="width: 250px;"
                     class="img-fluid brand-icon">

                <h2 class="heading display-4 font-weight-400 text-white mt-5 main-title">
                  <span class="font-weight-700">AlistFHS</span> Cloud SU
                </h2>

                <p class="lead text-white mt-3 lh-180 c-white description-text">
                  Let everyone enjoy the high-speed of the times without bandwidth anxiety<strong class="text-white">CloudFlare</strong>
                </p>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
  </section>
</main>

<!-- JavaScript依赖 -->
<script src="${pageContext.request.contextPath}/assets/vendor/jquery/jquery.min.js"></script>
<script src="${pageContext.request.contextPath}/assets/vendor/popper/popper.min.js"></script>
<script src="${pageContext.request.contextPath}/assets/js/bootstrap/bootstrap.min.js"></script>
<script src="${pageContext.request.contextPath}/assets/vendor/fontawesome/js/fontawesome-all.min.js" defer></script>
<script src="${pageContext.request.contextPath}/assets/js/theme.js"></script>
</body>
</html>