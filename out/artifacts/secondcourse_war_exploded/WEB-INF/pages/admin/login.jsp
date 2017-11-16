<%--
  Created by IntelliJ IDEA.
  User: liulei
  Date: 2016/4/22
  Time: 10:35
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
    <!--兼容360浏览器，防止布局乱-->
    <meta http-equiv=X-UA-Compatible content="IE=edge,chrome=1">
    <title>东北大学学生处</title>
    <link rel="stylesheet" href="<%=request.getContextPath()%>/asset/css/common.css" />
    <link rel="stylesheet" href="<%=request.getContextPath()%>/asset/css/manage/login.css" />
    <script type="text/javascript" src="<%=request.getContextPath()%>/asset/js/jquery-1.8.3.min.js" ></script>
    <script type="text/javascript" src="<%=request.getContextPath()%>/asset/js/jquery.md5.js" ></script>
    <script type="text/javascript" src="<%=request.getContextPath()%>/asset/js/common.js" ></script>
    <script type="text/javascript" src="<%=request.getContextPath()%>/asset/layer/layer.js" ></script>
    <script type="text/javascript">
        $(function(){
            //加载背景图片
            imgLoad(BackgroundImg, function() {
                $("#BackgroundImg").fadeIn("fast");
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
                        layer.msg(data);
                        return;
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
    <img src="<%=request.getContextPath()%>/asset/image/manage/login_bg.png" style="display: none;" class="background" id="BackgroundImg"/>
    <div style="top:10px; position: absolute; right: 10px;">
        <select name="login_type" id="login_type" class="input" style="padding-left:10px; width:100px;" onchange="change_role();" >
            <option value="1">系统</option>
            <option value="2">学生处</option>
            <option value="3">学院</option>
            <option value="4">辅导员</option>
        </select>
    </div>
    <div class="login_div">
        <%--<img src="<%=request.getContextPath()%>/asset/image/manage/logo.png" class="logo_img" width="80px" height="80px"/>--%>
        <div class="title_div" style="padding-top: 60px;">学生处信息管理系统</div>
        <div class="input_div">
            <input type="text" name="" id="UserName" value="" placeholder="用户名" class="input input_username" /><br />
            <input type="password" name="" id="Password" value="" placeholder="密码" class="input input_password" />

            <div class="login_btn"><img src="<%=request.getContextPath()%>/asset/image/manage/login_btn.png" width="50px" height="50px" id="Login"/></div>
        </div>
    </div>
</body>
</html>