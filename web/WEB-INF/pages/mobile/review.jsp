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
    <title>审核公示</title>
    <meta name="viewport" content="width=device-width,initial-scale=1,minimum-scale=1,maximum-scale=1,user-scalable=no" />
    <!--通用css-->
    <link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/asset_mobile/css/common.css"/>
    <link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/asset_mobile/css/layout.css"/>
    <!--单独css-->
    <link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/asset_mobile/css/activityDisplay.css"/>
    <!--js-->
    <script>var studentid = <%=session.getAttribute("studentid")%>;</script>
    <script src="<%=request.getContextPath()%>/asset_mobile/js/angular1.6.min.js" type="text/javascript" charset="utf-8"></script>
    <script src="<%=request.getContextPath()%>/asset_mobile/js/zepto.1.2.0.min.js" type="text/javascript" charset="utf-8"></script>
    <!--layer-->
    <script src="<%=request.getContextPath()%>/asset_mobile/js/layer_mobile/layer.js" type="text/javascript" charset="utf-8"></script>
    <!--封装好的好理解layer-->
    <script src="<%=request.getContextPath()%>/asset_mobile/js/layer-packaged.js" type="text/javascript" charset="utf-8"></script>
    <!--单独引入js-->
    <script src="<%=request.getContextPath()%>/asset_mobile/js/controller/review.js" type="text/javascript" charset="utf-8"></script>

    <!--带下滑列表并且带导航的页面需要引入-->
    <script src="<%=request.getContextPath()%>/asset_mobile/js/l-toucher.js" type="text/javascript" charset="utf-8"></script>
</head>
<%@include file="../mobile/CheckLogin.jsp"%>
<%--<%@include file="../mobile/CheckWeixin.jsp"%>--%>
<body ng-app='app' ng-controller='ctrl'>
<!--通用导航-->
<%@include file="footer.jsp"%>
<!--主容器-->
<div class="container">
    <!--搜索框-->
    <div class="search padding">
        <div class="searchinput rel">
            <i class="icon left"></i>
            <input class="col-100" type="text" ng-model="searchResult" placeholder="搜索活动关键字" />
            <button class="abs blue-btn right" ng-click="search(searchResult)" type="button">搜索</button>
        </div>
    </div>
    <!--筛选条件-->
    <div class="conditions padding">
        <div class="select" ng-cloak ng-repeat="c in conditions">
            <div class="surface clearfix">
                <b class="left">选择{{c.name}}</b>
                <span class="right">{{c.seleItem.name || "未选择"}}</span>
            </div>
            <select class="col-100 block" ng-change="changing(c.seleItem, c.name)" ng-model="c.seleItem" ng-options="item.name for item in c.list">
            </select>
        </div>
    </div>
    <div class="list">
        <!--审核-->
        <div class="review activity" ng-cloak ng-repeat="item in reviews">
            <div class="top">
                <span class="label" ng-bind="timeReplace(item.activitySdate1,item.activityEdate1,item.signUpTime1)"></span>
                <span class="right" ng-bind="item.studentName"></span>
            </div>
            <div class="bottom">
                <div class="reviewtitle dot">
                    {{item.activityTitle}}
                </div>
            </div>
            <div class="clearfix">
                <button type="button" class="left blue-btn col-50" ng-click="detail(item)">查看详情</button>
                <button ng-if="item.studentID==studentId" type="button" class="right red-btn col-50" ng-click="report(item)">质疑</button>
                <button ng-if="item.studentID!=studentId" type="button" class="right red-btn col-50" ng-click="report(item)">举报</button>
            </div>
        </div>
    </div>
    <!--加载中-->
    <div ng-if="loadMore" class="loading {{loading?'begin':''}}">
        <span ng-show="!loading">加载更多</span>
    </div>
    <div ng-if="!loadMore" class="loading no_line">
        <span>已经到底了！</span>
    </div>
</div>
</body>
</html>
