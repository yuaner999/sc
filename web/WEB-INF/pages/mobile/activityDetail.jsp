<%--
  Created by IntelliJ IDEA.
  User: lirf
  Date: 2017/6/6
  Time: 8:37
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>活动详情</title>
    <meta name="viewport"
          content="width=device-width,initial-scale=1,minimum-scale=1,maximum-scale=1,user-scalable=no"/>
    <!--通用css-->
    <link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/asset_mobile/css/common.css"/>
    <link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/asset_mobile/css/layout.css"/>
    <link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/asset_mobile/css/activityDetail.css"/>
    <!--单独css-->
    <!--js-->
    <script src="<%=request.getContextPath()%>/asset_mobile/js/commonJs.js" type="text/javascript" charset="UTF-8"></script>
    <script src="<%=request.getContextPath()%>/asset_mobile/js/angular1.6.min.js" type="text/javascript"
            charset="utf-8"></script>
    <script src="<%=request.getContextPath()%>/asset_mobile/js/zepto.1.2.0.min.js" type="text/javascript"
            charset="utf-8"></script>
    <!--layer-->
    <script src="<%=request.getContextPath()%>/asset_mobile/js/layer_mobile/layer.js" type="text/javascript"
            charset="utf-8"></script>
    <!--封装好的好理解layer-->
    <script src="<%=request.getContextPath()%>/asset_mobile/js/layer-packaged.js" type="text/javascript"
            charset="utf-8"></script>
    <!--单独引入js-->
    <script src="<%=request.getContextPath()%>/asset_mobile/js/controller/activityDetail.js" type="text/javascript" charset="utf-8"></script>
</head>
<%@include file="../mobile/CheckLogin.jsp" %>
<%--<%@include file="../mobile/CheckWeixin.jsp" %>--%>
<body ng-app='app' ng-controller='ctrl'>
<!--通用导航-->
<%@include file="footer.jsp" %>
<!--主容器-->
<div class="container">
    <div class="padding">
        <div ng-if="remark" class="grade">
            <b>活动评分</b>
            <span class="star">
                <i class="icon {{star.all}} {{star.helf}}" ng-repeat="star in grade"></i>
            </span>
        </div>
        <div class="info">
            <h3 class="text-center" ng-bind="activity.activityTitle"></h3>
            <p class="text-center"
               ng-bind="'开始'+dateformat(activity.activitySdate, 'yyyy-MM-dd')+'~结束'+dateformat(activity.activityEdate, 'yyyy-MM-dd')"></p>
            <%--<p class="txt" ng-bind="activityContent(activity.activityContent)"></p>--%>
            <div class="txt"></div>
        </div>
        <div ng-if="!invalidAct">
            <button ng-if="!signup" ng-click="go()" type="button" class="blue-btn block col-100">点击报名</button>
            <button ng-if="signup" type="button" class="blue-btn block col-100">已报名</button>
        </div>

    </div>
</div>

</body>
</html>
