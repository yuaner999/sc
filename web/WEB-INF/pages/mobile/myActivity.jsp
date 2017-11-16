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
    <title>我的活动</title>
    <meta name="viewport" content="width=device-width,initial-scale=1,minimum-scale=1,maximum-scale=1,user-scalable=no" />
    <!--通用css-->
    <link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/asset_mobile/css/common.css"/>
    <link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/asset_mobile/css/layout.css"/>
    <!--单独css-->
    <link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/asset_mobile/css/myActivity.css"/>
    <!--js-->
    <script>
        var loginId=<%=session.getAttribute("studentid")%>
    </script>
    <script src="<%=request.getContextPath()%>/asset_mobile/js/angular1.6.min.js" type="text/javascript" charset="utf-8"></script>
    <script src="<%=request.getContextPath()%>/asset_mobile/js/zepto.1.2.0.min.js" type="text/javascript" charset="utf-8"></script>
    <!--layer-->
    <script src="<%=request.getContextPath()%>/asset_mobile/js/layer_mobile/layer.js" type="text/javascript" charset="utf-8"></script>
    <!--封装好的好理解layer-->
    <script src="<%=request.getContextPath()%>/asset_mobile/js/layer-packaged.js" type="text/javascript" charset="utf-8"></script>
    <!--单独引入js-->
    <script src="<%=request.getContextPath()%>/asset_mobile/js/controller/myActivity.js" type="text/javascript" charset="utf-8"></script>
    <!--带下滑列表并且带导航的页面需要引入-->
    <script src="<%=request.getContextPath()%>/asset_mobile/js/l-toucher.js" type="text/javascript" charset="utf-8"></script>
</head>
<%@include file="../mobile/CheckLogin.jsp"%>
<%--<%@include file="../mobile/CheckWeixin.jsp"%>--%>
<body ng-app='app' ng-controller='ctrl'>
<!--通用导航-->
<%@include file="footer.jsp"%>
<!--tab-->
<div class="tab nav">
    <div class="{{myactivitiesloadtype=='all'? 'sele' : '' }}" ng-click="changeCondition('all')">全部</div>
    <div class="{{myactivitiesloadtype=='will'? 'sele' : '' }}" ng-click="changeCondition('will')">未开始</div>
    <div class="{{myactivitiesloadtype=='underway'? 'sele' : '' }}" ng-click="changeCondition('underway')">进行中</div>
    <div class="{{myactivitiesloadtype=='end'? 'sele' : '' }}" ng-click="changeCondition('end')">已结束</div>
</div>
<!--主容器-->
<div class="container">
    <!--活动列表-->
    <div class="list">
        <div class="activity" ng-cloak ng-repeat="item in myActivities">
            <div class="top">
                <!--活动范围-->
                <span class="label" ng-bind="item.activityParticipation"></span>
                <!--性质-->
                <span class="right" ng-bind="activityNature(item.activityNature)"></span>
            </div>
            <div class="bottom" ng-click="togodetail(item)">
                <!--标题-->
                <div class="dot b">
                    <a href="" ng-bind="item.activityTitle"></a>
                </div>
                <!--文字简介-->
                <p class="txt" ng-bind="filtercontenthtml(item.activityContent)">
                </p>
                <div class="box clearfix">
                    <div class="left">
                        <!--增加能力-->
                        <span ng-repeat="a in activityPowers(item.activityPowers)">
									<i class="icon" ></i>{{a}}
								</span>
                    </div>
                    <div class="right">
                        <!--级别和类型-->
                        <span class="inline-block level" ng-bind="activityLevle(item.activityLevle)"></span>
                        <span class="inline-block type" ng-bind="activityClassMean(item.activityClass)"></span>
                    </div>
                </div>
            </div>
            <!--评分-->
            <div class="starbox">
                <button type="button" ng-click="evaluation(item)" class="blue-btn col-100 block" ng-show="!item.evaluation &&(item.activitypoint==null||item.activitypoint=='')&&isActivityEnd(item)">点击评价</button>
                <div class="clearfix" ng-show="!(!item.evaluation && (item.activitypoint==null||item.activitypoint==''))">
                    <div class="left">
                        <span>评价</span>
                        <div class="star">
                            <i ng-click="star(index,item)" class="{{item.tmp>=index?'icon all':'icon'}}" ng-repeat="index in starsarry" ng-init="initrate(item)"></i>
                            <%--<i class="icon all" ></i>--%>
                            <%--<i class="icon all" ></i>--%>
                            <%--<i class="icon" ></i>--%>
                            <%--<i class="icon" ></i>--%>
                        </div>
                    </div>
                    <div class="right">
                        <button ng-show="item.activitypoint==null||item.activitypoint==''" ng-click="evaluated(item)" type="button" class="blue-btn">确定</button>
                        <span ng-show="item.activitypoint!=null&&item.activitypoint!=''">已评</span>
                    </div>
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
</div>
</body>

</html>
