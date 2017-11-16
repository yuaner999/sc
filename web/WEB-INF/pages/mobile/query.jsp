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
    <title>举报质疑</title>
    <meta name="viewport" content="width=device-width,initial-scale=1,minimum-scale=1,maximum-scale=1,user-scalable=no" />
    <!--通用css-->
    <link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/asset_mobile/css/common.css"/>
    <link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/asset_mobile/css/layout.css"/>
    <!--单独css-->
    <link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/asset_mobile/css/showDetail.css"/>
    <!--js-->
    <script>
        var studentName = "<%=session.getAttribute("studentName")%>";
        var phone = "<%=session.getAttribute("studentPhone")%>";
    </script>
    <script src="<%=request.getContextPath()%>/asset_mobile/js/commonJs.js" type="text/javascript" charset="UTF-8"></script>
    <script src="<%=request.getContextPath()%>/asset_mobile/js/angular1.6.min.js" type="text/javascript" charset="utf-8"></script>
    <script src="<%=request.getContextPath()%>/asset_mobile/js/zepto.1.2.0.min.js" type="text/javascript" charset="utf-8"></script>
    <!--layer-->
    <script src="<%=request.getContextPath()%>/asset_mobile/js/layer_mobile/layer.js" type="text/javascript" charset="utf-8"></script>
    <!--封装好的好理解layer-->
    <script src="<%=request.getContextPath()%>/asset_mobile/js/layer-packaged.js" type="text/javascript" charset="utf-8"></script>
    <!--单独引入js-->
    <script src="<%=request.getContextPath()%>/asset_mobile/js/controller/query.js" type="text/javascript" charset="utf-8"></script>
</head>
<%@include file="../mobile/CheckLogin.jsp"%>
<%--<%@include file="../mobile/CheckWeixin.jsp"%>--%>
<body ng-app='app' ng-controller='ctrl'>
<!--通用导航-->
<%@include file="footer.jsp"%>
<!--主容器-->
<div class="container">
    <div class="query padding">
        <div class="queryrow">
            <a>*</a>
            <span>举报人姓名</span>
            <input type="text" readonly="readonly" ng-model="user.name" maxlength="10"/>
        </div>
        <div class="queryrow">
            <a>*</a>
            <span>举报人电话</span>
            <input type="text" readonly="readonly" ng-model="user.phone" />
        </div>
        <div class="queryrow">
            <a>*</a>
            <span>举报原因</span>
            <textarea ng-model="cause" name=""></textarea>
        </div>
    </div>
    <div class="padding">
        <button ng-click="confirm()" type="button" class="blue-btn block col-100 ">提交</button>
    </div>
</div>
</body>
</html>
