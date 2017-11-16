<%--
  Created by IntelliJ IDEA.
  User: lirf
  Date: 2017/6/6
  Time: 8:39
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>公示详情</title>
    <meta name="viewport" content="width=device-width,initial-scale=1,minimum-scale=1,maximum-scale=1,user-scalable=no" />
    <!--通用css-->
    <link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/asset_mobile/css/common.css"/>
    <link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/asset_mobile/css/layout.css"/>
    <!--单独css-->
    <link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/asset_mobile/css/showDetail.css"/>
    <!--js-->
    <script src="<%=request.getContextPath()%>/asset_mobile/js/commonJs.js" type="text/javascript" charset="UTF-8"></script>
    <script src="<%=request.getContextPath()%>/asset_mobile/js/angular1.6.min.js" type="text/javascript" charset="utf-8"></script>
    <script src="<%=request.getContextPath()%>/asset_mobile/js/zepto.1.2.0.min.js" type="text/javascript" charset="utf-8"></script>
    <!--layer-->
    <script src="<%=request.getContextPath()%>/asset_mobile/js/layer_mobile/layer.js" type="text/javascript" charset="utf-8"></script>
    <!--封装好的好理解layer-->
    <script src="<%=request.getContextPath()%>/asset_mobile/js/layer-packaged.js" type="text/javascript" charset="utf-8"></script>
    <!--单独引入js-->
    <script src="<%=request.getContextPath()%>/asset_mobile/js/controller/showDetail.js" type="text/javascript" charset="utf-8"></script>
</head>
<%@include file="../mobile/CheckLogin.jsp"%>
<%--<%@include file="../mobile/CheckWeixin.jsp"%>--%>
<body ng-app='app' ng-controller='ctrl'>
<!--通用导航-->
<%@include file="footer.jsp"%>
<!--主容器-->
<div class="container">
    <div class="publicPeople">
        <div class="title text-center rel">
            <b>能力素质</b>
        </div>
        <div class="info">
            <div>
                <b>姓&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;名:</b>
                <span ng-bind="publicPeople.name"></span>
            </div>
            <div>
                <b>学&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;院:</b>
                <span ng-bind="publicPeople.college"></span>
            </div>
            <div>
                <b>专&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;业:</b>
                <span ng-bind="publicPeople.major"></span>
            </div>
            <div>
                <b>班&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;级:</b>
                <span ng-bind="publicPeople.class"></span>
            </div>
            <div>
                <b>学&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;号:</b>
                <span ng-bind="publicPeople.stuNum"></span>
            </div>
        </div>
    </div>
    <div class="activityInfo">
        <div>
            <div>
                <a>*</a>
                <b>活动标题</b>
            </div>
            <span ng-bind="activity.title"></span>
        </div>
        <div>
            <div>
                <a>*</a>
                <b>活动时间</b>
            </div>
            <span ng-bind="activity.time"></span>
        </div>
        <div>
            <div>
                <a>*</a>
                <b>活动级别</b>
            </div>
            <span ng-bind="levelReplace(activity.level)"></span>
        </div>
        <div>
            <div>
                <a>*</a>
                <b>增加能力</b>
            </div>
            <span ng-bind="skillsReplace(activity.skills)"></span>
        </div>
        <div>
            <div>
                <a>*</a>
                <b>获得奖项</b>
            </div>
            <span ng-bind="activity.awards"></span>
        </div>
    </div>
    <%--<div class="padding">--%>
        <%--<button ng-click="confirm()" type="button" class="blue-btn block col-100 ">确定</button>--%>
    <%--</div>--%>
</div>
</body>
</html>
