<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: admin
  Date: 2016/8/27
  Time: 15:22
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java"  pageEncoding="UTF-8" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01//EN"
"http://www.w3.org/TR/html4/strict.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" lang="en">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
    <!--兼容360浏览器，防止布局乱，设置IE的文档模式为最高版本，并且如果存在chrome插件，自动使用Webkit引擎-->
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <title>第二课堂</title>
    <link rel="Shortcut Icon" href="<%=request.getContextPath()%>/asset/image/neu.jpg" type="image/x-icon">
    <script type="text/javascript" src="<%=request.getContextPath()%>/asset_font_old/js/jquery-1.11.1.min.js"></script>
    <link rel="stylesheet" href="<%=request.getContextPath()%>/asset_font_old/css/SecondClass_homepage.css" type="text/css" />
    <script type="text/javascript" src="<%=request.getContextPath()%>/asset_font_old/js/respond.js"></script>
    <script type="text/javascript" src="<%=request.getContextPath()%>/asset_font_old/js/SecondClass_homepage.js"></script>

</head>
<body>
<%@include file="header_old.jsp"%>

<!--活动预告和学校新闻-->
<div class="NoticeAndNews">
    <!--活动预告-->
    <div class="NoticeAndNews_content">
        <div class="NoticeAndNews_content_title public_title_style">
            <h3 title_content>学校活动</h3>
            <div class="title_underline">
                <div></div>
            </div>
            <div class="title_more"><a >More>></a></div>
        </div>
        <ul class="NoticeAndNews_content_list">
            <c:forEach items="${school_activities}" var="school_activity" begin="0" end="2">
                <li class="list_item">
                    <img src="<%=request.getContextPath()%>/Files/Images/${school_activity.activityImg}" />
                    <div class="list_item_content">
                        <h6><a href="javascript:void(0);">${school_activity.activityTitle}</a></h6>
                        <p>
                            ${school_activity.activityContent}
                        </p>
                        <span class="list_item_content_time">${school_activity.activityCreatedate}</span>
                    </div>
                </li>
            </c:forEach>
        </ul>
    </div>
    <!--学校新闻-->
    <div class="school_news NoticeAndNews_content">
        <div class="public_title_style">
            <h3 title_content>学院活动</h3>
            <div class="title_underline">
                <div></div>
            </div>
            <div class="title_more"><a >More>></a></div>
        </div>
        <div class="News_content">
            <c:forEach items="${college_activities}" var="college_activity" begin="0" end="0">
                <img src="<%=request.getContextPath()%>/Files/Images/${college_activity.activityImg}" />
                <div class="News_content_details">
                    <h6><a href="javascript:void(0);">${college_activity.activityTitle}</a></h6>
                    <p class="News_content_details_content">
                        ${college_activity.activityContent}
                    </p>
                    <span class="list_item_content_time">${college_activity.activityCreatedate}</span>
                </div>
            </c:forEach>
        </div>
        <ul class="News_titles_list titles_list_style">
            <c:forEach items="${college_activities}" var="college_activity" begin="1" end="7">
                <li class="News_titles_list_item">
                    <div class="News_titles_list_item_pointer"></div>
                    <a href="javascript:void(0);">${college_activity.activityTitle}</a>
                    <span class="News_titles_list_item_time">${college_activity.activityCreatedate}</span>
                </li>
            </c:forEach>
        </ul>
    </div>
</div>
<!--活动列表和联系方式-->
<div class="activeListAndLink">
    <div class="activeListAndLink_head">
        <!--活动列表-->
        <div class="activeList public_title_style">
            <h3 class="title_content">新闻列表</h3>
            <div class="title_underline">
                <div></div>
            </div>
            <div class="title_more"><a >More>></a></div>
        </div>
        <div class="link public_title_style">
            <h3 class="title_content">联系方式</h3>
            <div class="title_underline">
                <div></div>
            </div>
        </div>
    </div>
    <div class="activeListAndLink_body">
        <!--活动列表-->
        <div class="activeList public_NoticeAndNews_style">
            <ul class="titles_list_style">
                <c:forEach items="${newses}" var="news" begin="0" end="3">
                    <li class="News_titles_list_item">
                        <div class="News_titles_list_item_pointer"></div>
                        <a href="javascript:void(0);">${news.newsTitle}</a>
                        <span class="News_titles_list_item_time">${news.newsDate}</span>
                    </li>
                </c:forEach>
            </ul>
        </div>
        <!--联系方式-->
        <div class="link public_NoticeAndNews_style">
            <ul class="link_list">
                <li class="link_list_item">
                    <span class="link_list_item_name">联系电话</span>
                    <span class="link_list_item_content">024-83685073</span>
                </li>
                <li class="link_list_item">
                    <span class="link_list_item_name">电子邮箱</span>
                    <span class="link_list_item_content">neunavy@139.com</span>
                </li>
                <li class="link_list_item">
                    <span class="link_list_item_name">学校地址</span>
							<span class="link_list_item_content">
								辽宁省沈阳市和平区文化路3号巷11号易购大厦203室
							</span>
                </li>
            </ul>
            <img src="<%=request.getContextPath()%>/asset_font_old/img/SecondClass_homepage_link.png" />
        </div>
    </div>
</div>


<%@include file="footer_old.jsp"%>
</body>
</html>

