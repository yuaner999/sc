<%--
  Created by IntelliJ IDEA.
  User: lirf
  Date: 2017/6/6
  Time: 8:35
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport"
          content="width=device-width,initial-scale=1,minimum-scale=1,maximum-scale=1,user-scalable=no"/>
    <title>第二课堂成绩单登录</title>
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
    <!--vue框架-->
    <script src="<%=request.getContextPath()%>/asset_mobile/js/vue.min.js"></script>
    <script src="<%=request.getContextPath()%>/asset_mobile/js/zepto.1.2.0.min.js" type="text/javascript"
            charset="utf-8"></script>
    <%--<script src="<%=request.getContextPath()%>/asset_mobile/js/common.js" type="text/javascript" charset="utf-8"></script>--%>
    <!--layer-->
    <script src="<%=request.getContextPath()%>/asset_mobile/js/layer_mobile/layer.js" type="text/javascript"
            charset="utf-8"></script>
    <!--封装好的好理解layer-->
    <script src="<%=request.getContextPath()%>/asset_mobile/js/layer-packaged.js" type="text/javascript"
            charset="utf-8"></script>
    <!--引入jQuery-->
    <script type="text/javascript" src="<%=request.getContextPath()%>/asset/js/jquery-1.8.3.min.js"></script>
    <script src="<%=request.getContextPath()%>/asset/js/jquery.md5.js" type="text/javascript"></script>
    <script src="<%=request.getContextPath()%>/asset/js/jquery.cookie.js" type="text/javascript"></script>
</head>
<%--<%@include file="../mobile/CheckWeixin.jsp"%>--%>

<body>
<div class="container" id="app">
    <div id="logo"></div>
    <div class="form" hidden>
        <div class="input-row radius">
		    	<span class="iconbox">
		    		<i class="icon user"></i>
		    	</span>
            <input
                    v-model="userName"
                    type="text" placeholder="请输入用户名" maxlength="16">
        </div>
        <div class="input-row radius">
		    	<span class="iconbox">
		    		<i class="icon pword"></i>
		    	</span>
            <input
                    v-model="passWord"
                    type="password" placeholder="请输入密码" maxlength="16">
        </div>
        <div class="button-row radius">
            <button
                    v-on:click='login()'
                    type="button" class="blue-btn block col-100 blue-bg">登录
            </button>
        </div>
        <div class="forget">
            <i class="icon"></i>
            <span onclick="forgetPwd()">忘记密码</span>
        </div>
    </div>
</div>
<!--js部分-->
<script type="text/javascript">
    $(function () {
        var studentid = $.cookie().studentId;
        var passwd = $.cookie().passwd;
        if (studentid == null || passwd == null || studentid == "" || passwd == "" ||
            studentid == "null" || passwd == "null") {
            $(".form").fadeIn("fast");
        } else {
            $.post("/AppLogin/SystemLogin.form", {
                username: studentid,
                password: $.md5(passwd)
            }, function (data) {
                if (data == "1") {
                    setTimeout(function () {
                        $.cookie("studentId", studentid);
                        $.cookie("passwd", passwd);
                        sessionStorage.setItem('indexStatus', 'true');
                        window.location.href = "/views/mobile/index.form";
                    }, 1500);
                } else {
                    $(".form").fadeIn("fast");
                }
            });
        }
    });

    var openid = "";
    <%--var openid = "${openid}";--%>
//    if (!openid) {
//        window.location = "/views/index.form"
//    }
    var data = {
        userName: '',
        passWord: ''
    };
    var studentid = "";
    var passwd = "";
    var app = new Vue({
        el: '#app',
        data: data,//传入一个对象，这个对象的属性类似$scope.xxx
        methods: {
            //登录事件
            login: function () {
                l_loading('加载中...');
                if (!data.userName || !data.passWord) {
                    l_closeAll();
                    l_msg("学号或密码为空", 2);
                } else if (isNaN(data.userName)) {
                    l_closeAll();
                    l_msg("学号必须为数字", 2);
                } else {
                    studentid = data.userName;
                    passwd = data.passWord;
                    $.post("/AppLogin/SystemLogin.form", {
                        username: data.userName,
                        password: $.md5(data.passWord),
                        openid: openid
                    }, function (data) {
                        l_closeAll();
                        if (data == "1") {
                            l_msg('登录成功', 2, function () {
                                $.cookie("studentId", studentid, { path: '/' });
                                $.cookie("passwd", passwd, { path: '/' });
                                sessionStorage.setItem('indexStatus', 'true');
                                window.location.href = "/views/mobile/index.form"
                            });
                        } else {
                            l_msg(data, 2, function () {
                                $.cookie("studentId", null, { path: '/' });
                                $.cookie("passwd", null, { path: '/' });
                                return;
                            });
                        }
                    });
                }
            }
        }
    });
    function forgetPwd() {
        window.location.href = "/views/mobile/forgetPwd.form"
    }
</script>
</body>
</html>
