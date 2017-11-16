<%--
  Created by IntelliJ IDEA.
  User: admin
  Date: 2016/8/27
  Time: 15:44
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java"  pageEncoding="UTF-8" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01//EN"
"http://www.w3.org/TR/html4/strict.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" lang="en">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=9; IE=8; IE=7; IE=EDGE">
    <title>登录</title>
    <link href="<%=request.getContextPath()%>/asset_font_old/css/login.css" rel="stylesheet" type="text/css" />
    <link rel="stylesheet" href="<%=request.getContextPath()%>/asset/css/font/login_reg.css" />

    <link rel="Shortcut Icon" href="<%=request.getContextPath()%>/asset/image/neu.jpg" type="image/x-icon">
    <script type="text/javascript" src="<%=request.getContextPath()%>/asset_font_old/js/jquery-1.11.1.min.js"></script>
    <script type="text/javascript" src="<%=request.getContextPath()%>/asset_font_old/js/respond.js"></script>
    <script type="text/javascript" src="<%=request.getContextPath()%>/asset_font_old/js/login.js"></script>

    <script type="text/javascript" src="<%=request.getContextPath()%>/asset/js/jquery-1.8.3.min.js" ></script>
    <script type="text/javascript" src="<%=request.getContextPath()%>/asset/js/jquery.md5.js" ></script>
    <script type="text/javascript" src="<%=request.getContextPath()%>/asset/js/common.js" ></script>
    <script type="text/javascript" src="<%=request.getContextPath()%>/asset/layer/layer.js" ></script>
    <script type="text/javascript">
        $(function(){
            <%--$("#studentID").blur(function(){--%>
                <%--var username = $.trim($("#studentID").val());--%>
                <%--if(username==""||username==null){--%>
                    <%--$("#idimg").html('<img src="<%=request.getContextPath()%>/asset_font_old/img/l_false.png" class="img"/>');--%>
                <%--}else {--%>
                    <%--$("#idimg").html('<img src="<%=request.getContextPath()%>/asset_font_old/img/l_right.png" class="img"/>');--%>
                <%--}--%>
            <%--})--%>
            <%--$("#studentPwd").blur(function(){--%>
                <%--var password = $("#studentPwd").val();--%>
                <%--if( password==""||password==""){--%>
                    <%--$("#pwimg").html('<img src="<%=request.getContextPath()%>/asset_font_old/img/l_false.png" class="img"/>');--%>
                <%--}else{--%>
                    <%--$("#pwimg").html('<img src="<%=request.getContextPath()%>/asset_font_old/img/l_right.png" class="img"/>');--%>
                <%--}--%>
            <%--})--%>
            //点击登录
            $("#Login").click(function(){
                var username = $.trim($("#studentID").val());
                var password = $.md5($("#studentPwd").val());
                var logintype="7";
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
                    var str=data.split("|");
                    if(str[0]=="1"){//登录成功
                        $("#idimg").html('<img src="<%=request.getContextPath()%>/asset_font_old/img/l_right.png" class="img"/>');
                        $("#pwimg").html('<img src="<%=request.getContextPath()%>/asset_font_old/img/l_right.png" class="img"/>');
                        window.location = "index.form";
                    }else {//登录失败
                        if(data=='学号错误'){
                            $("#idimg").html('<img src="<%=request.getContextPath()%>/asset_font_old/img/l_false.png" class="img"/>');
                            $("#pwimg").html('<img src="<%=request.getContextPath()%>/asset_font_old/img/l_false.png" class="img"/>');
                        }
                        if(data=='密码错误'){
                            $("#idimg").html('<img src="<%=request.getContextPath()%>/asset_font_old/img/l_right.png" class="img"/>');
                            $("#pwimg").html('<img src="<%=request.getContextPath()%>/asset_font_old/img/l_false.png" class="img"/>');
                        }
                        layer.close(loginLoad);
                        layer.msg(data);
                        return;
                    }
                });
            });
            //绑定Enter键
            $("#studentPwd").keyup(function(e){
                if(e.keyCode==13){
                    $("#Login").click();
                }
            });


        });
        //获取url中的参数
        function getUrlParam(name) {
            var reg = new RegExp("(^|&)" + name + "=([^&]*)(&|$)"); //构造一个含有目标参数的正则表达式对象
            var r = window.location.search.substr(1).match(reg);  //匹配目标参数
            if (r != null) return unescape(r[2]); return null; //返回参数值
        }

        var studentId_exist=false;
        var resetPwdId="";
        $(function(){
            //忘记密码按钮
            $("#forget_pwd").click(function(){
                $("#username").val("");
                $(".login_box").hide();
                $(".findpwd_box").hide();
                $(".forget_pwd_box").show();
                $(".login_window").fadeIn(300);
                $("#checkcode").attr("src","/jsons/checkcode.form?a="+Math.random());
            });
            //修改密码
            $("#change_pwd").click(function(){
                $("#old_pwd").val("");
                $("#pwd").val("");
                $("#repwd").val("");
                $(".login_box").show();
                $(".forget_pwd_box").hide();
                $(".findpwd_box").hide();
                $(".login_window").fadeIn(300);
            });
            //取消按钮
            $(".cancel_btn").click(function(){
                $(".login_window").fadeOut(300);
            });
            //修改密码输入检测
            $(".resetpwd_input").blur(function(){
                var str= $.trim($(this).val());
                if(!str){
                    layer.msg("该项为必填项");
                    return;
                }
                if(str.length<6 || str.length>18){
                    layer.msg("密码长度为6-18个字符！");
                    return;
                }
            });
            //找回密码输入检测
            $("#username").blur(function(){
                var str=$.trim($(this).val());
                if(!str){
                    layer.msg("该项为必填项");
                    return;
                }
                $.ajax({
                    url:"/jsons/loadstudentId.form",
                    type:"post",
                    data:{student_id:str},
                    success:function(data){
                        if(!(data && data.rows && data.rows.length>0)){
                            studentId_exist=false;
                            layer.msg("该学号不存在！请查证后再试，或者联系辅导员");
                        }else{
                            studentId_exist=true;
                        }
                    }
                });
            });
            //找回密码的验证码
            $("#checkcode").click(function(){
                $("#checkcode").attr("src","/jsons/checkcode.form?a="+Math.random());
            });
            // 找回密码功能重置密码链接检测
            var findpwd=GetQueryString("findpwd");
            if(findpwd && findpwd=="true"){
                $(".login_window").show();
                $(".findpwd_box").show();
                var id=GetQueryString("id");
                if(!id){
                    layer.msg("该链接无效！正在跳转...");
                    setTimeout(function(){window.location="/views/font/index.form"},1500);
                    return;
                }
                resetPwdId=id;
                var index = layer.load(1, {shade: [0.1,'#000']});
                $.ajax({
                    url:"/jsons/loadFindPwdCode.form",
                    type:"post",
                    dataType:"json",
                    data:{id:id},
                    success:function(data){
                        layer.close(index);
                        if(data==null || data.rows==null || data.rows.length==0){
                            layer.msg("链接已失效，请重新找回。页面正在跳转中...");
                            setTimeout(function(){window.location="/views/font/login.form"},2000);
                        }else{
                            $.ajax({
                                url:"/jsons/edit_findpwdcodestatus.form",
                                data:{id:id},
                                type:"post"
                            });
                        }
                    },
                    error:function(){
                        layer.close(index);
                        layer.msg("服务器连接失败，请稍后再试");
                    }
                });
            }
        });

        /**
         * 修改密码
         */
        function resetpwd(){
            var oldpwd= $.trim($("#old_pwd").val());
            var pwd= $.trim($("#pwd").val());
            var repwd= $.trim($("#repwd").val());
            if(!(oldpwd && pwd && repwd)){
                layer.msg("请检查输入是否完整！");
                return;
            }
            if(pwd!=repwd){
                layer.msg("两次密码输入不一致");
                return;
            }
            var index = layer.load(1, {shade: [0.1,'#000']});
            $.ajax({
                url:"/Login/EditPassword.form",
                data:{oldpassword: $.md5(oldpwd),newpassword: $.md5(pwd)},
                type:"post",
                success:function(data){
//                console.log(data);
                    layer.close(index);
                    if(data=="-1"){
                        layer.msg("原密码或新密码有误，请稍后重试");
                        return;
                    }
                    //这里是学生登入 所以返回的type改为5
                    if(data=="5"){
                        layer.msg("修改成功！请重新登陆");
                        $(".login_window").fadeOut(300);
                        checkLogin();
                        return;
                    }
                    layer.msg(data);
                },
                error:function(){
                    layer.close(index);
                    layer.msg("服务器连接失败，请稍后再试")}
            });
        }
        /**
         * 找回密码
         */
        function findPwd(){
            var username= $.trim($("#username").val());
            var code= $.trim($("#code").val());
          //  alert(username)
            if(!username || !studentId_exist){
                layer.msg("请输入学号！");
                return;
            }
            if(!code){
                layer.msg("请输入验证码！");
                return;
            }
            var index = layer.load(1, {shade: [0.1,'#000']});

            $.ajax({
                url:"/Login/findPwd.form",
                type:"post",
                data:{studentid:username,usercheckcode:code},
                success:function(data){
                    layer.close(index);
                    if(data=="1"){
                        layer.msg("重置密码的链接已发送至邮箱！请注意查收");
                        $(".login_window").fadeOut(300);
                    }else if(data=="0"){
                        layer.msg("邮件发送失败！");
                    }else{
                        layer.msg(data);
                    }
                },
                error:function(){
                    layer.close(index);
                    layer.msg("服务器连接失败，请稍后再试")}
            });
        }
        /**
         * 找回密码的重置密码
         */
        function findpwd_reset(){
            var pwd= $.trim($("#newpwd").val());
            var repwd= $.trim($("#renewpwd").val());
            if(!( pwd && repwd)){
                layer.msg("请检查输入是否完整！");
                return;
            }
            if(pwd!=repwd){
                layer.msg("两次密码输入不一致");
                return;
            }
            var index = layer.load(1, {shade: [0.1,'#000']});
            $.ajax({
                url:"/jsons/update_findPwd_Reset.form",
                data:{id:resetPwdId,newpassword: $.md5(pwd)},
                type:"post",
                success:function(data){
                    layer.close(index);
                    if(data!=null && data.result){
                        layer.msg("修改成功！请重新登陆。页面跳转中...");
                        setTimeout(function(){window.location="/views/font/index.form"},1500);
                        return;
                    }else{
                        layer.msg(data.errormessage);
                    }

                },
                error:function(){
                    layer.close(index);
                    layer.msg("服务器连接失败，请稍后再试")}
            });
        }
   </script>
</head>
<body>
<div class="box">
    <div class="head_img"><img src="<%=request.getContextPath()%>/asset_font_old/img/l_logo.png"/></div>
    <div class="a_btn"><div class="button">第二课堂宣传引导</div></div>
    <div class="input_box">
        <div class="input_div">
            <span style="color: #1990fe;">学号</span>
            <input type="text" class="input_user" id="studentID" name="" placeholder="请输入学号" value="" />
            <div class="img_box" id="idimg" ></div>
        </div>
        <div class="input_div">
            <span style="color: #1990fe;">密码</span>
            <input type="password" class="input_pasw" id="studentPwd" name="" placeholder="请输入密码" value=""/>
            <div class="img_box" id="pwimg"></div>
        </div>
        <a href="javascript:void(0);"  id="forget_pwd" title="找回密码"class="forget">忘记密码?</a>
        <div class="login" id="Login">登&nbsp;&nbsp;&nbsp;&nbsp;录</div>
    </div>
</div>
</div>
<div class="login_window"  style="display: none">
    <div class="login_box" style="display: none">
        <div class="ele">
            <span class="ele_text">原密码：</span><input type="password" id="old_pwd" class="input_ele resetpwd_input">
        </div>
        <div class="ele">
            <span class="ele_text">新密码：</span><input type="password" id="pwd" class="input_ele resetpwd_input">
        </div>
        <div class="ele">
            <span class="ele_text">重复密码：</span><input type="password" id="repwd" class="input_ele resetpwd_input">
        </div>
        <div class="ele">
            <input type="button" class="btn ok_btn" onclick="resetpwd();" value="确定">
            <input type="button" class="btn cancel_btn"  value="取消">
        </div>
    </div>

    <div class="forget_pwd_box" style="display: none">
        <div class="ele">
            <span style="color: #1990fe;">学号：</span><input type="text" id="username" class="input_ele">
        </div>
        <div class="ele" id="code_div">
            <span style="color: #1990fe;">验证码：</span><input type="text" id="code" class="input_ele code">
            <img id="checkcode">
        </div>
        <div class="tips">
            若未提供邮箱，请联系辅导员。
        </div>
        <div class="ele" id="send_div">
            <input type="button" class="btn ok_btn" onclick="findPwd();" value="发送验证邮件" style="background-color: #197ffe;color: #fff;border-radius: 10px;font-size: 14px">
            <input type="button" class="btn cancel_btn"  value="取  消" style="background-color: #197ffe;color: #fff;border-radius: 10px;font-size: 14px">
        </div>
    </div>
    <div class="findpwd_box" style="display: none">
        <div class="ele">
            <span class="ele_text">新密码：</span><input type="password" id="newpwd" class="input_ele resetpwd_input">
        </div>
        <div class="ele">
            <span class="ele_text">重复密码：</span><input type="password" id="renewpwd" class="input_ele resetpwd_input">
        </div>
        <div class="ele">
        </div>
        <div class="ele">
            <input type="button" class="btn ok_btn" onclick="findpwd_reset();" value="确定">
            <input type="button" class="btn cancel_btn"  value="取消">
        </div>
    </div>
</div>
</body>
</html>

