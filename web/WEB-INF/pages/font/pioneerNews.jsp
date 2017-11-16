<%--
  Created by IntelliJ IDEA.
  User: gq
  Date: 2016/11/11
  Time: 10:02
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java"  pageEncoding="UTF-8" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01//EN"
"http://www.w3.org/TR/html4/strict.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" lang="en">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=9; IE=8; IE=7; IE=EDGE">
    <title>先锋新闻</title>
    <link rel="Shortcut Icon" href="<%=request.getContextPath()%>/asset/image/neu.jpg" type="image/x-icon">

    <%--注意引入的时候不能有空格 否则会报错--%>
    <link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/asset_font_new/css/common.css"/>
    <link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/asset_font_new/css/commonhead.css"/>
    <link href="<%=request.getContextPath()%>/asset_font/css/Newslist.css" rel="stylesheet" type="text/css" />
    <link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/asset_font_new/css/index.css"/>
    <link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/asset_font_new/css/all.css"/>
    <link rel="stylesheet" href="<%=request.getContextPath()%>/asset_font/css/Radio2.css" type="text/css" />
    <script type="text/javascript" src="<%=request.getContextPath()%>/asset_font/js/jquery-1.11.1.min.js"></script>
    <script type="text/javascript" src="<%=request.getContextPath()%>/asset_font/js/Newslist.js"></script>
    <script type="text/javascript" src="<%=request.getContextPath()%>/asset/layer/layer.js"></script>
    <script src="<%=request.getContextPath()%>/asset_font_new/js/jquery.dotdotdot.js" type="text/javascript" charset="utf-8"></script>
    <script src="<%=request.getContextPath()%>/asset_font_new/js/common.js" type="text/javascript" charset="utf-8"></script>
    <script src="<%=request.getContextPath()%>/asset_font_new/js/respond.js" type="text/javascript" charset="utf-8"></script>
    <script src="<%=request.getContextPath()%>/asset_font_new/js/index.js" type="text/javascript" charset="utf-8"></script>

    <!--分页-->
    <%--先不用原来的样式--%>
    <link type="text/css" rel="stylesheet" href="<%=request.getContextPath()%>/asset/js/paging/paging.css" />
    <script type="text/javascript" src="<%=request. getContextPath()%>/asset/js/paging/paging.js"></script>
    <script type="text/javascript">
        //定义路径
        var key=1;
        newsUrl="/news/loadSchoolNewsBypage.form";

        //加载所有新闻列表
        $(function() {

            //初始时默认为加载学校新闻的信息
            loadData();
        })
    </script>
</head>
<body>
<%@include file="header_new.jsp"%>
<%--判断是否是登录状态--%>
<%@include file="../common/CheckLogin.jsp"%>
<div class="section">
    <div class="newsBox">
        <div class="center_head_box">
            <span>先锋新闻</span>
            <a  class="center_head_a" id="return"  href="javascript:history.go(-1);">返回>
                <span class="center_head_span">先锋新闻</span>
            </a>
            <%--<script type="text/javascript" src=" <%=request.getContextPath()%>/asset_font/js/jquery-1.11.1.min.js"></script>--%>
            <%--<script type="text/javascript" src=" <%=request.getContextPath()%>/asset_font/js/respond.js"></script>--%>
        </div>
        <div class="center_contant_box">
            <%--<div class="center_contant_new_box">--%>
                <%--<div class="center_school">学校新闻</div>--%>
                <%--<div class="center_accda">学院新闻</div>--%>
            <%--</div>--%>
            <ul class="center_ul list" id="news_all">
                <%--删掉其他的 留下一个--%>
                <%--<li class="center_li">--%>
                <%--<div class="hidden">--%>
                <%--<a class="center_li_span">东北大学是教育部直属的国家重点大学东北东北大学是</a>--%>
                <%--<span class="center_li_point">--%>
                <%--········································································································································································································--%>
                <%--</span>--%>
                <%--</div>--%>
                <%--<span class="center_li_time">2016/12/22</span>--%>
                <%--</li>--%>
            </ul>

            <div class="page_count_box">
                <%--<div class="center_button_box">--%>
                <%--<img src=" <%=request.getContextPath()%>/asset_font/img/left.png" class="center_btn_left"/>--%>
                <%--<button type="button" class="center_btn">1</button>--%>
                <%--<button type="button" class="center_btn">2</button>--%>
                <%--<button type="button" class="center_btn">3</button>--%>
                <%--<button type="button" class="center_btn">4</button>--%>
                <%--<button type="button" class="center_btn">5</button>--%>
                <%--<button type="button" class="center_btn">6</button>--%>
                <%--<button type="button" class="center_btn">7</button>--%>
                <%--<span class="center_btn_span">...</span>--%>
                <%--<button type="button" class="center_btn">140</button>--%>
                <%--<img src=" <%=request.getContextPath()%>/asset_font/img/right.png" class="center_btn_right"/>--%>
                <%--</div>--%>
                <%--这是原来的--%>
                    <ul id="paging_btn_box">
                        <img src="<%=request.getContextPath()%>/asset_font_new/img/pageleft_06.png" alt="" title="上一页"  class="btn_left">
                        <li>
                            <a href="javascript:void(0);" class="page_count btn_start currentpage">1</a>
                        </li>
                        <span class="prev_group">. . .</span>
                        <li>
                            <a href="javascript:void(0);" class="page_count btn_1" >2</a>
                        </li>
                        <li>
                            <a href="javascript:void(0);" class="page_count btn_2">3</a>
                        </li>
                        <li>
                            <a href="javascript:void(0);" class="page_count btn_3">4</a>
                        </li>
                        <span class="next_group">. . .</span>
                        <li>
                            <a href="javascript:void(0);" class="page_count btn_end">10</a>
                        </li>
                        <img src="<%=request.getContextPath()%>/asset_font_new/img/pageright_06.png" alt="" title="下一页" class="btn_right">
                    </ul>
            </div>
        </div>
    </div>
    <!--我的信息-->
    <%@include file="myInfo.jsp"%>
</div>
<%@include file="footer_new.jsp"%>
</body>
</html>
