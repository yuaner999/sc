<%--
  Created by IntelliJ IDEA.
  User: admin
  Date: 2016/8/27
  Time: 15:30
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java"  pageEncoding="UTF-8" %>
<!DOCTYPE html>
<link rel="stylesheet" href="<%=request.getContextPath()%>/asset_font_old/css/head.css" />
<script type="text/javascript" src="<%=request.getContextPath()%>/asset_font_old/js/head.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/asset_font_old/js/jquery-1.11.1.min.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/asset_font_old/js/jquery.dotdotdot.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/asset/layer/layer.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/asset/easyui/jquery.min.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/asset/easyui/jquery.easyui.min.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/asset/easyui/locale/easyui-lang-zh_CN.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/asset/js/manage/massage-helper.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/asset/js/jquery.md5.js" ></script>
<script type="text/javascript">
    $(function(){
        $("#logout").click(function(){
                    $.post("/Login/ExitLogin.form",{},function(data){
                        if(data=="7"){//退出成功
                            window.location = "login.form";
                        }else {//退出失败
                            if(data==null||data==""){
                                layer.msg("请先登录");
                            }
                            window.location = "login.form";
                        }
                    });
        })
        var date=new Date();
        var h=date.getHours();
        var str=""
        if(h>=0 && h<10 ) str="早上好";
        if(h>=10 && h<12) str="上午好";
        if(h>=12 && h<18 ) str="下午好";
        if(h>=18 && h<24 ) str="晚上好";
        $("#logintime").text(str);
    })
</script>

<div class="head">
    <div class="schoollogo">
        <img class="logo" src="<%=request.getContextPath()%>/asset_font_old/img/logo.png" alt="" />
        <div class="title">
            <span>第二课堂宣传引导</span>
        </div>
        <img class="logoback" src="<%=request.getContextPath()%>/asset_font_old/img/logoback.png" alt="" />
    </div>
    <div class="backimg">
        <img src="<%=request.getContextPath()%>/asset_font_old/img/backimg.png" alt="" />
    </div>
    <div class="menu">
        <div class="menuwrap">
            <ul class="nav">
                <li class="navli">
                    <a href="#">首页</a>
                    <ul class="secondul">

                    </ul>
                </li>
                <li class="navli">
                    <a href="#">新闻</a>
                    <ul class="secondul">
                        <li><a href="#">活动列表</a></li>
                        <li><a href="#">活动公告</a></li>
                    </ul>
                </li>
                <li class="navli">
                    <a href="#">活动</a>
                    <ul class="secondul">
                        <li><a href="#">活动列表</a></li>
                        <li><a href="#">活动公告</a></li>
                    </ul>
                </li>
                <li class="navli">
                    <a href="#">个人信息</a>
                    <ul class="secondul">

                    </ul>
                </li>
            </ul>
            <div class="loginmess">
                <div class="exit_login" id="logout"><span>退出</span></div>
                <span>同学</span>
                <span class="loginname">${loginName}</span>
                <span>，</span>
                <span class="logintime" id="logintime"></span>
                <img src="<%=request.getContextPath()%>/asset_font_old/img/loginimg.png" alt="" />
            </div>
        </div>
    </div>
</div>
