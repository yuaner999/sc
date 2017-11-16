<%--
  Created by IntelliJ IDEA.
  User: lirf
  Date: 2017/6/12
  Time: 9:18
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <!--确保适当的绘制和触屏缩放-->
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no">
    <title>第二课堂成绩单</title>
    <script type="text/javascript" charset="utf-8">
        //  	预加载图片
        function preloadImg(srcArr) {
            if (srcArr instanceof Array) {
                for (var i = 0; i < srcArr.length; i++) {
                    var oImg = new Image();
                    oImg.src = srcArr[i];
                }
            }
        }
        //    	预加载登录背景
        preloadImg([
            '<%=request.getContextPath()%>/asset_mobile/images/login_bg_02.jpg',
        ]);
    </script>
    <link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/asset_mobile/css/common.css"/>
    <link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/asset_mobile/css/layout.css"/>
    <link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/asset_mobile/css/login.css"/>
    <!--layer-->
    <script src="<%=request.getContextPath()%>/asset_mobile/js/layer_mobile/layer.js" type="text/javascript"
            charset="utf-8"></script>
    <!--封装好的好理解layer-->
    <script src="<%=request.getContextPath()%>/asset_mobile/js/layer-packaged.js" type="text/javascript"
            charset="utf-8"></script>
    <!--引入jQuery-->
    <script type="text/javascript" src="<%=request.getContextPath()%>/asset/js/jquery-1.8.3.min.js"></script>
    <script src="<%=request.getContextPath()%>/asset/js/jquery.md5.js" type="text/javascript"></script>
    <script type="text/javascript" src="<%=request.getContextPath()%>/asset/js/jquery.cookie.js"></script>
    <!--<script type="text/javascript" src="<%=request.getContextPath()%>/asset/js/jquery-1.11.1.min.js"></script>-->
    <!--<script type="text/javascript" src="<%=request.getContextPath()%>/asset/js/common.js"></script>-->
    <!--<script type="text/javascript" src="http://res.wx.qq.com/open/js/jweixin-1.0.0.js"></script>-->
</head>
<body>
<div class="container" id="app">
    <div id="logo"></div>
</div>
</body>
</html>
<script>
    /* 微信公众号
     //TODO:修改为真正的公众号
     var appid = "wxcdc3f23be57f6aeb";//真正公众号
     //    var appid = "wx6ad1ef40f83fb65c";//真正公众号
     //    var pageName = GetQueryString("pageName");//指定跳转到哪个页面
     //    var taxiId = GetQueryString("taxiId");//出租车ID
     console.log("********************************************start");
     //    console.log(pageName);
     var uri = "";//url地址

     //http://219.216.96.15:8088
     //    uri = "http://secondsource.tunnel.qydev.com/No_Intercept/WeChat/getAccessTokenByCode.form";
     uri = "http://sct.neu.edu.cn/No_Intercept/WeChat/getAccessTokenByCode.form";
     console.log(uri);
     console.log("********************************************end");
     var redirect_uri = encodeURIComponent(uri);//urlencode解码：decodeURIComponent()-真正公众号
     var url = "https://open.weixin.qq.com/connect/oauth2/authorize?appid=" + appid
     + "&redirect_uri=" + redirect_uri
     + "&response_type=code&scope=snsapi_userinfo&state=STATE#wechat_redirect";
     window.location.href = url;
     */
    //使用cookie
    //    $.cookie("studentid", "test", { expires: 30 });
    //  	预加载图片
    $(function () {
        var studentid = $.cookie().studentId;
        var passwd = $.cookie().passwd;

        l_loading('正在尝试自动登录...');
        if (studentid == null || passwd == null) {
            $.cookie("studentId", "", { expires: 30, path: '/'});
            $.cookie("passwd", "", { expires: 30, path: '/'});
        }

        if (studentid == null || passwd == null || studentid == "" || passwd == "" ||
            studentid == "null" || passwd == "null") {
            setTimeout(function () {
                l_closeAll();
                l_msg("自动登录失败,请输入用户名和密码登录", 2, function () {
                    $.cookie("studentId", null, { path: '/' });
                    $.cookie("passwd", null, { path: '/' });
                    window.location.href = "/views/mobile/login.form";
                });
            }, 3000)
        } else {
            $.post("/AppLogin/SystemLogin.form", {
                username: studentid,
                password: $.md5(passwd)
            }, function (data) {
//                l_closeAll();
                if (data == "1") {
                    setTimeout(function () {
                        l_closeAll();
                        $.cookie("studentId", studentid);
                        $.cookie("passwd", passwd);
                        sessionStorage.setItem('indexStatus', 'true');
                        window.location.href = "/views/mobile/index.form";
                    }, 3000);

                } else {
                    setTimeout(function () {
                        l_closeAll();
                        l_msg("自动登录失败,请输入用户名和密码登录", 2, function () {
                            $.cookie("studentId", null, { path: '/' });
                            $.cookie("passwd", null, { path: '/' });
                            window.location.href = "/views/mobile/index.form";
                        });
                    }, 3000)
                }
            });
        }
    });
</script>
