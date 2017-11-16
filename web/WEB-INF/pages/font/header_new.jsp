<%--
  Created by IntelliJ IDEA.
  User: yuanshenghan
  Date: 2016/11/1
  Time: 13:23
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java"  pageEncoding="UTF-8" %>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/asset_font_new/css/common.css"/>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/asset_font_new/css/commonhead.css"/>
<script src="<%=request.getContextPath()%>/asset_font_new/js/common.js" type="text/javascript" charset="utf-8"></script>
<script type="text/javascript">
    $(function(){
        var idx=key;
        if(idx==null){idx=0}
        $('.nav ul').children("li").eq(idx).addClass("sele");
        $('.nav ul').children("li").eq(idx).siblings().removeClass("sele");
        function getQueryString(name) {
            var reg = new RegExp("(^|&)" + name + "=([^&]*)(&|$)", "i");
            var r = window.location.search.substr(1).match(reg);
            if (r != null) return unescape(r[2]);
            return null;
        }
        //退出登录
        $("#logout").click(function(){
            layer.confirm("确认退出登录吗？",{offset:['30%'] },function(result){
               if(result){
                   $.post("/Login/ExitLogin.form",{},function(data){
                       if(data=="7"){//退出成功
                           window.location = "/views/font/login.form";
                       }else {//退出失败
                           if(data==null||data==""){
                               layer.msg("请先登录");
                           }
                           window.location = "/views/font/login.form";
                       }
                   });
               }
            });
        });
        var date=new Date();
        var h=date.getHours();
        var str="";
        if(h>=0 && h<10 ) str="早上好";
        if(h>=10 && h<12) str="上午好";
        if(h>=12 && h<18 ) str="下午好";
        if(h>=18 && h<24 ) str="晚上好";
        $("#logintime").text(str);
    });
</script>
<!--上面-->
<div class="header">
    <div class="banner">
        <img src="<%=request.getContextPath()%>/asset_font_new/img/banner_01.png" class="load"/>
    </div>
    <!--导航
    -->
    <div class="nav">
        <div>
            <ul>
                <li>
                    <a href="<%=request.getContextPath()%>/views/font/index_new.form" style="cursor:pointer;">
                        首页
                    </a>
                </li>
                <li>
                    <a href="<%=request.getContextPath()%>/views/font/news_list.form" style="cursor:pointer;">
                        先锋领航
                    </a>
                    <ol>
                        <li><a href="<%=request.getContextPath()%>/views/font/pioneerNews.form" style="cursor:pointer;">先锋新闻</a></li>
                        <li><a href="<%=request.getContextPath()%>/views/font/pioneerYouth.form"style="cursor:pointer;">先锋青年</a></li>
                    </ol>
                </li>
                <li>
                    <a href="<%=request.getContextPath()%>/views/font/activityList.form">
                        信息公告
                    </a>
                    <ol>
                        <li><a href="<%=request.getContextPath()%>/views/font/activityList.form" style="cursor:pointer;">活动公告</a></li>
                        <li><a href="<%=request.getContextPath()%>/views/font/activityCheck.form" style="cursor:pointer;">审核公示</a></li>
                        <%--<li><a href="<%=request.getContextPath()%>/views/font/outSchoolActivityApply.form">校外活动申请</a></li>--%>
                        <%--<li><a href="<%=request.getContextPath()%>/views/font/NotactivityApply.form">非活动类申请</a></li>--%>
                    </ol>
                </li>
                <li id="hehe">
                    <a href="<%=request.getContextPath()%>/views/font/oneself.form" style="cursor:pointer;">
                        个人中心
                    </a>
                    <ol>
                        <li><a href="<%=request.getContextPath()%>/views/font/activityState_student.form">个人参与活动</a></li>
                        <%--<li><a href="<%=request.getContextPath()%>/views/font/applyResult.form">申请结果</a></li>--%>
                        <%--<li><a href="<%=request.getContextPath()%>/views/font/printPriviewV2.form">打印预览</a></li>--%>
                    </ol>
                </li>
            </ul>
            <div>
                <b></b>
                <p>
                   <span id="logintime"></span>，<span>${loginName}</span>同学
                </p>
                <input id="logout" type="button" value="退出" style="cursor: pointer;" class="navbutton"/>
            </div>
        </div>
    </div>
</div>