<%--
  Created by IntelliJ IDEA.
  User: liulei
  Date: 2016/4/22
  Time: 10:35
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java"  pageEncoding="UTF-8" %>
<html>
<head>
    <link rel="Shortcut Icon" href="<%=request.getContextPath()%>/asset/image/neu.jpg" type="image/x-icon">
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
    <!--兼容360浏览器，防止布局乱-->
    <meta http-equiv=X-UA-Compatible content="IE=edge,chrome=1">
    <title>共青团“第二课堂成绩单”</title>
    <link rel="stylesheet" href="<%=request.getContextPath()%>/asset/css/common.css" />
    <link rel="stylesheet" href="<%=request.getContextPath()%>/asset/css/manage/login.css" />
    <script type="text/javascript" src="<%=request.getContextPath()%>/asset/js/jquery-1.8.3.min.js" ></script>
    <script type="text/javascript" src="<%=request.getContextPath()%>/asset/js/jquery.md5.js" ></script>
    <script type="text/javascript" src="<%=request.getContextPath()%>/asset/js/common.js" ></script>
    <script type="text/javascript" src="<%=request.getContextPath()%>/asset/layer/layer.js" ></script>
    <script type="text/javascript">
        $(function(){
            //加载背景图片
            //加载背景图片
            imgLoad(BackgroundImg, function() {
                $(".background").eq(0).fadeIn("fast");
                var i = 0;
                var timeOut = setInterval(function(){
                    if(i<2){
                        i++;
                    }else {
                        i = 0;
                    }
                    $(".background").fadeOut("fast");
                    $(".background").eq(i).fadeIn("fast");
                },3000);
            });
            //点击登录
            $("#Login").click(function(){
                var username = $.trim($("#UserName").val());
                var password = $.md5($("#Password").val());
                var logintype=$("#login_type").val();
                if(username==""){
                    layer.msg("请输入用户名");
                    return;
                }
                if(password==""){
                    layer.msg("请输入密码");
                    return;
                }
                var loginLoad = layer.load(1, {
                    shade: [0.1,'#000'] //0.1透明度的白色背景
                });
                //登录验证
                $.post("/Login/SystemLogin.form",{
                    username:username,
                    password:password,
                    type:logintype
                },function(data){
                    if(data=="1"){//登录成功
                        window.location = "menu.form";
                    }else {//登录失败
                        layer.close(loginLoad);
                        var str=data.substring("|");
                        if(str[0]=="1"){
                            window.location.href = "/views/font/index.form";
                        }else{
                            layer.msg(data);
                            return;
                        }
                    }
                });
            });
            //绑定Enter键
            $("#Password").keyup(function(e){
                if(e.keyCode==13){
                    $("#Login").click();
                }
            });
            if(getUrlParam("type")){
                $("#login_type").find("option[value='"+getUrlParam("type")+"']").attr("selected",true);
            }
        });
        function imgLoad(img, callback) {
            var timer = setInterval(function() {
                if (img.complete) {
                    callback(img);
                    clearInterval(timer);
                }
            }, 50);
        }
        function change_role() {
            window.location = "login.form?type="+$("#login_type").val();
        }

        //获取url中的参数
        function getUrlParam(name) {
            var reg = new RegExp("(^|&)" + name + "=([^&]*)(&|$)"); //构造一个含有目标参数的正则表达式对象
            var r = window.location.search.substr(1).match(reg);  //匹配目标参数
            if (r != null) return unescape(r[2]); return null; //返回参数值
        }
    </script>
</head>
<body>
    <img src="<%=request.getContextPath()%>/asset/image/manage/BG1.jpg" style="display: none;" class="background" id="BackgroundImg"/>
    <img src="<%=request.getContextPath()%>/asset/image/manage/BG2.jpg" style="display: none;" class="background" />
    <img src="<%=request.getContextPath()%>/asset/image/manage/BG3.jpg" style="display: none;" class="background" />
    <div style="top:10px; position: absolute; right: 10px;">
        <select name="login_type" id="login_type" class="input" style="padding-left:10px; width:100px;" onchange="change_role();" >
            <option value="1">系统</option>
            <option value="2">校团委</option>
            <option value="3">学院团委</option>
            <option value="4">职能部门</option>
            <option value="5">年级团总支</option>
            <option value="6">班级团支部</option>
            <option value="7">学生</option>
        </select>
    </div>
    <div class="login_div">
        <img src="<%=request.getContextPath()%>/asset/image/manage/neu_logo.png" class="logo_img" height="80px"/>
        <div class="title_div" style="padding-top: 20px;">共青团“第二课堂成绩单”信息认证平台</div>
        <div class="input_div">
            <input type="text" name="" id="UserName" value="" placeholder="用户名" class="input input_username" /><br />
            <input type="password" name="" id="Password" value="" placeholder="密码" class="input input_password" />

            <div class="login_btn"><img src="<%=request.getContextPath()%>/asset/image/manage/login_btn.png" width="50px" height="50px" id="Login"/></div>
        </div>
    </div>
</body>
</html>