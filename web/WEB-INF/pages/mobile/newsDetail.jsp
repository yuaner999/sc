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
    <title>新闻详情</title>
    <meta name="viewport" content="width=device-width,initial-scale=1,minimum-scale=1,maximum-scale=1,user-scalable=no" />
    <!--通用css-->
    <link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/asset_mobile/css/common.css"/>
    <link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/asset_mobile/css/layout.css"/>
    <link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/asset_mobile/css/newsDetail.css"/>
    <!--单独css-->
    <!--js-->
    <script src="<%=request.getContextPath()%>/asset_mobile/js/commonJs.js" type="text/javascript" charset="UTF-8"></script>
    <script src="<%=request.getContextPath()%>/asset_mobile/js/angular1.6.min.js" type="text/javascript" charset="utf-8"></script>
    <script src="<%=request.getContextPath()%>/asset_mobile/js/zepto.1.2.0.min.js" type="text/javascript" charset="utf-8"></script>

    <script src="<%=request.getContextPath()%>/asset_mobile/js/controller/newsDetail.js" type="text/javascript" charset="utf-8"></script>
</head>
<%@include file="../mobile/CheckLogin.jsp"%>
<%--<%@include file="../mobile/CheckWeixin.jsp"%>--%>
<body ng-app='app' ng-controller='ctrl'>
<!--通用导航-->
<%@include file="footer.jsp"%>

<div class="container">
    <div class="padding">

        <h3 class="text-center" ng-cloak ng-bind="nowNews.newsTitle"></h3>
        <div class="detail" id="content"></div>
        <div class="clearfix">
            <div class="right" ng-bind="nowNews.nDate"></div>
        </div>
    </div>
</div>
</body>
</html>
