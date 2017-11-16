<%--
  Created by IntelliJ IDEA.
  User: lirf
  Date: 2017/6/6
  Time: 8:38
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>先锋领航</title>
    <meta name="viewport" content="width=device-width,initial-scale=1,minimum-scale=1,maximum-scale=1,user-scalable=no" />
    <!--通用css-->
    <link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/asset_mobile/css/common.css"/>
    <link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/asset_mobile/css/layout.css"/>
    <!--单独css-->
    <link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/asset_mobile/css/index.css"/>
    <!--js-->
    <script src="<%=request.getContextPath()%>/asset_mobile/js/angular1.6.min.js" type="text/javascript" charset="utf-8"></script>
    <script src="<%=request.getContextPath()%>/asset_mobile/js/zepto.1.2.0.min.js" type="text/javascript" charset="utf-8"></script>
    <!--layer-->
    <script src="<%=request.getContextPath()%>/asset_mobile/js/layer_mobile/layer.js" type="text/javascript" charset="utf-8"></script>
    <!--封装好的好理解layer-->
    <script src="<%=request.getContextPath()%>/asset_mobile/js/layer-packaged.js" type="text/javascript" charset="utf-8"></script>
    <!--单独引入js-->
    <script src="<%=request.getContextPath()%>/asset_mobile/js/controller/news.js" type="text/javascript" charset="utf-8"></script>

    <!--带下滑列表并且带导航的页面需要引入-->
    <script src="<%=request.getContextPath()%>/asset_mobile/js/l-toucher.js" type="text/javascript" charset="utf-8"></script>
</head>
<%@include file="../mobile/CheckLogin.jsp"%>
<%--<%@include file="../mobile/CheckWeixin.jsp"%>--%>
<body ng-app='app' ng-controller='ctrl'>
<!--通用导航-->
<%@include file="footer.jsp"%>
<!--头部悬浮-->
<div class="layout_top">
    <div class="tab clearfix text-center">
        <div class="col-50 left {{newsloadtype==0? 'sele':''}}"
             ng-click='render(0)'>
            <h3>先锋新闻</h3>

        </div>
        <div class="col-50 right {{newsloadtype==1? 'sele':''}}"
             ng-click='render(1)'>
            <h3>先锋青年</h3>
        </div>
    </div>
</div>
<!--主容器-->
<div class="container">
    <!--新闻列表-->
    <div class="list">
        <div class="activity" ng-cloak ng-repeat="item in nowList">
            <div class="bottom" ng-click="gotodetail(item.newsId)">
                <div class="dot b">
                    <a href="" ng-bind="item.newsTitle"></a>
                </div>
                <p class="txt" ng-bind="contentReplace(item.newsContent)"></p>
                <span class="newstime" ng-bind="item.nDate"></span>
            </div>
        </div>
    </div>
    <!--加载中-->
    <div ng-if="loadMore" class="loading {{loading?'begin':''}}" >
        <span ng-show="!loading">加载更多</span>
    </div>
    <div ng-if="!loadMore" class="loading no_line">
        <span>已经到底了！</span>
    </div>
</div>
</body>
</html>
