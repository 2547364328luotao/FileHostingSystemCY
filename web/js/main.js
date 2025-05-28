$(function () {
    // 根据hash加载对应页面
    function loadPage() {
        var hash = window.location.hash || '#home';
        var pageUrl = hash.substring(1) + '.jsp';
        $('.nav-link').removeClass('active');
        $('a[href="' + pageUrl + '"]').addClass('active');
        $('#main-content').load(pageUrl);
    }

    // 初始加载和hash变化时加载页面
    $(window).on('hashchange', loadPage);
    loadPage();

    // 点击导航链接时更新hash
    $('.nav-link').click(function (e) {
        e.preventDefault();
        var pageUrl = $(this).attr('href');
        window.location.hash = pageUrl.replace('.jsp', '');
    });
});
