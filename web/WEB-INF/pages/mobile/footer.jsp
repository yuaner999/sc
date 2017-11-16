<%@page pageEncoding="UTF-8"%>
<nav class="navigator ani-up no-ani">
    <ul class="nav">
        <li>
            <a href="/views/mobile/index.form" onclick="goToPage('index')">
                <i class="icon home {{navSele==0?'sele':''}}"></i>
                <span>首页</span>
            </a>
        </li>
        <li>
            <a href="/views/mobile/activityList.form">
                <i class="icon active {{navSele==1?'sele':''}}"></i>
                <span>校园活动</span>
            </a>
        </li>
        <li>
            <a href="/views/mobile/news.form" onclick="goToPage('news')">
                <i class="icon news {{navSele==2?'sele':''}}"></i>
                <span>先锋领航</span>
            </a>
        </li>
        <li>
            <a href="/views/mobile/userCenter.form">
                <i class="icon user {{navSele==3?'sele':''}}"></i>
                <span>用户中心</span>
            </a>
        </li>
    </ul>
</nav>
<script type="text/javascript">
    function goToPage(page) {
        if (page = "index") {
            sessionStorage.setItem('indexStatus', 'true');
        }
        if (page = "news") {
            window.sessionStorage["newsloadtype"] = 0;
        }

    }
</script>