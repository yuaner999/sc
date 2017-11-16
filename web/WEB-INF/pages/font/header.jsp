<%--
  Created by IntelliJ IDEA.
  User: admin
  Date: 2016/9/10
  Time: 17:24
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java"  pageEncoding="UTF-8" %>
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
        var str="";
        if(h>=0 && h<10 ) str="早上好";
        if(h>=10 && h<12) str="上午好";
        if(h>=12 && h<18 ) str="下午好";
        if(h>=18 && h<24 ) str="晚上好";
        $("#logintime").text(str);
    })
</script>
<div class="head">
    <div class="schooltitle">
        <img class="neuback" src="<%=request.getContextPath()%>/asset_font/img/backimg.jpg" alt="" />
        <div class="logo">
            <div class="neulogoback"></div>
            <img src="<%=request.getContextPath()%>/asset_font/img/neulogo.png" alt="" />
        </div>
        <img class="neutitle" src="<%=request.getContextPath()%>/asset_font/img/neutitle.png" alt="" />
        <div class="pagetitle">
            共青团"第二课堂成绩单"信息认证平台
        </div>
    </div>
    <div class="menu">
        <div class="menuwrap">
            <ul class="nav">
                <li class="navli">
                    <a href="<%=request.getContextPath()%>/views/font/index_new.form">首页</a>
                    <ul class="secondul"></ul>
                </li>
                <li class="navli">
                    <a href="<%=request.getContextPath()%>/views/font/news_list.form">宣传引导</a>
                    <ul class="secondul">
                        <li><a href="<%=request.getContextPath()%>/views/font/news_list.form">新&nbsp;&nbsp;&nbsp;&nbsp;闻</a></li>
                    </ul>
                </li>
                <li class="navli">
                    <a href="<%=request.getContextPath()%>/views/font/activityList.form">活动</a>
                    <ul class="secondul">
                        <li><a href="<%=request.getContextPath()%>/views/font/activityList.form">活动公告</a></li>
                        <li><a href="<%=request.getContextPath()%>/views/font/activityCheck.form">审核公示</a></li>
                        <li><a href="<%=request.getContextPath()%>/views/font/outSchoolActivityApply.form">校外活动申请</a></li>
                        <li><a href="<%=request.getContextPath()%>/views/font/NotactivityApply.form">非活动类申请</a></li>
                    </ul>
                </li>
                <li class="navli">
                    <a  href="<%=request.getContextPath()%>/views/font/oneself.form">个人信息</a>
                    <ul class="secondul">
                        <li><a href="<%=request.getContextPath()%>/views/font/oneself.form">个人中心</a></li>
                        <li><a href="<%=request.getContextPath()%>/views/font/applyResult.form">申请结果</a></li>
                        <li><a href="<%=request.getContextPath()%>/views/font/printPriviewV2.form">打印预览</a></li>
                    </ul>
                </li>
            </ul>

            <div class="loginmess">
                <div class="exit_login" id="logout"><span>退出</span></div>
                <span>同学</span>
                <span class="loginname">${loginName}</span>
                <span>,</span>
                <span class="logintime" id="logintime"></span>
                <img src="<%=request.getContextPath()%>/asset_font_old/img/loginimg.png" alt="" />
            </div>
        </div>
        </div>
    </div>

</div>
