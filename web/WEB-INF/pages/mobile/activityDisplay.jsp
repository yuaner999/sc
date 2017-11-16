<%--
  Created by IntelliJ IDEA.
  User: lirf
  Date: 2017/6/6
  Time: 8:40
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>活动展示</title>
    <meta name="viewport"
          content="width=device-width,initial-scale=1,minimum-scale=1,maximum-scale=1,user-scalable=no"/>
    <!--通用css-->
    <link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/asset_mobile/css/common.css"/>
    <link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/asset_mobile/css/layout.css"/>
    <!--单独css-->
    <link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/asset_mobile/css/activityDisplay.css"/>
    <!--js-->
    <script>var stuCollageName = <%=session.getAttribute("stuCollageName")%>;</script>
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
    <script src="<%=request.getContextPath()%>/asset_mobile/js/controller/activityDisplay.js" type="text/javascript"
            charset="utf-8"></script>

    <!--带下滑列表并且带导航的页面需要引入-->
    <script src="<%=request.getContextPath()%>/asset_mobile/js/l-toucher.js" type="text/javascript"
            charset="utf-8"></script>
</head>
<%@include file="../mobile/CheckLogin.jsp" %>
<%--<%@include file="../mobile/CheckWeixin.jsp"%>--%>
<body ng-app='app' ng-controller='ctrl'>
<!--通用导航-->
<%@include file="footer.jsp" %>
<!--主容器-->
<div class="container">
    <!--搜索框-->
    <div class="search padding">
        <div class="searchinput rel">
            <i class="icon left"></i>
            <input class="col-100" type="text" ng-model="searchResult" placeholder="搜索活动关键字"/>
            <button class="abs blue-btn right" ng-click="changing('搜索')" type="button">搜索</button>
        </div>
    </div>
    <!--筛选条件-->
    <div class="conditions padding">
        <div class="select" ng-cloak ng-repeat="c in conditions">
            <div class="surface clearfix">
                <b class="left">{{c.name}}</b>
                <span id="{{c.id}}" class="right">{{c.seleItem || "未选择"}}</span>
            </div>
            <select class="col-100 block" ng-change="changing(c.name, c.seleItem)" ng-model="c.seleItem"
                    ng-options="item for item in c.list">
            </select>
        </div>
    </div>
    <div class="list">
        <div class="activity" ng-cloak ng-repeat="item in activities">
            <div ng-click="actDetail(item)">
                <div class="top">
                    <!--活动范围-->
                    <span class="label" ng-bind="item.activityParticipation"></span>
                    <!--性质-->
                    <span class="right" ng-bind="item.activityNatureMean"></span>
                </div>
                <div class="bottom">
                    <!--标题-->
                    <div class="dot b">
                        <a href="">{{item.activityTitle}}</a>
                    </div>
                    <!--文字简介-->
                    <p class="txt">
                        {{activityContent(item.activityContent)}}
                    </p>
                    <div class="box clearfix">
                        <div class="left">
                            <!--增加能力-->
                            <span ng-repeat="a in activityPowers(item.activityPowers)">
                            <i class="icon"></i>
                            {{a}}
                        </span>
                        </div>
                        <div class="right">
                            <!--级别和类型-->
                            <span class="inline-block level">{{item.activityLevleMean}}</span>
                            <span class="inline-block type">{{item.activityClassMean}}</span>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <!--加载中-->
        <div ng-if="loadMore" class="loading {{loading?'begin':''}}">
            <span ng-show="!loading">加载更多</span>
            <%--<div ng-show="!loading" ng-if="activities.length>=total" style="color: #b2b2b2;">已经到底了</div>--%>
        </div>
        <div ng-if="!loadMore" class="loading no_line">
            <span>已经到底了！</span>
        </div>
    </div>
</div>


</body>
</html>

