<%--
  Created by IntelliJ IDEA.
  User: lirf
  Date: 2017/6/6
  Time: 8:41
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>活动签到</title>
    <meta name="viewport" content="width=device-width,initial-scale=1,minimum-scale=1,maximum-scale=1,user-scalable=no" />
    <!--通用css-->
    <link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/asset_mobile/css/common.css"/>
    <link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/asset_mobile/css/layout.css"/>
    <!--单独css-->
    <link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/asset_mobile/css/activitySignin.css"/>
    <!--js-->
    <script>var studentID='<%=session.getAttribute("studentid")%>';</script>
    <script src="<%=request.getContextPath()%>/asset_mobile/js/angular1.6.min.js" type="text/javascript" charset="utf-8"></script>
    <script src="<%=request.getContextPath()%>/asset_mobile/js/zepto.1.2.0.min.js" type="text/javascript" charset="utf-8"></script>
    <!--layer-->
    <script src="<%=request.getContextPath()%>/asset_mobile/js/layer_mobile/layer.js" type="text/javascript" charset="utf-8"></script>
    <!--封装好的好理解layer-->
    <script src="<%=request.getContextPath()%>/asset_mobile/js/layer-packaged.js" type="text/javascript" charset="utf-8"></script>
    <%--引入生成二维码--%>
    <script type="text/javascript" src="<%=request.getContextPath()%>/asset/js/jquery-1.11.1.min.js"></script>

    <script type="text/javascript" src="<%=request.getContextPath()%>/asset/js/jquery.qrcode.min.js"></script>
    <!--带下滑列表并且带导航的页面需要引入-->
    <script src="<%=request.getContextPath()%>/asset_mobile/js/l-toucher.js" type="text/javascript" charset="utf-8"></script>
    <!--单独引入js-->
    <script src="<%=request.getContextPath()%>/asset_mobile/js/controller/activitySignin.js" type="text/javascript" charset="utf-8"></script>
</head>
<%@include file="../mobile/CheckLogin.jsp"%>
<%--<%@include file="../mobile/CheckWeixin.jsp"%>--%>
<body ng-app='app' ng-controller='ctrl'>
<!--通用导航-->
<%@include file="footer.jsp"%>

<div class="container">
    <div class="list">
        <div class="activity trsn" ng-repeat="activity in activities">
            <div class="bottom">
                <div class="dot b">
                    <a href="" ng-bind="activity.activityTitle"></a>
                </div>
                <p class="txt" ng-bind="activityContent(activity.activityContent)"></p>
                <div class="btnbox">
                    <button ng-click="signin(activity)" class="blue-btn block col-100" type="button">点击签到</button>
                </div>
            </div>
            <!--右滑删除-->
            <button ng-click="deleteA(activities,$index,$event)" class="delete red-btn" type="button">
                删除
            </button>
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
