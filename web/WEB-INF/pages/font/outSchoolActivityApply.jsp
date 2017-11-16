<%--
  Created by IntelliJ IDEA.
  User: admin
  Date: 2016/9/10
  Time: 16:39
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java"  pageEncoding="UTF-8" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01//EN"
"http://www.w3.org/TR/html4/strict.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" lang="en">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=9; IE=8; IE=7; IE=EDGE">
    <title>校外活动申请</title>
    <link rel="Shortcut Icon" href="<%=request.getContextPath()%>/asset/image/neu.jpg" type="image/x-icon">
    <link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/asset_font_new/css/common.css"/>
    <link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/asset_font_new/css/commonhead.css"/>
    <link href="<%=request.getContextPath()%>/asset_font/css/activeApply.css" rel="stylesheet" type="text/css" />
    <script src="<%=request.getContextPath()%>/asset_font/js/jquery-1.11.1.min.js" type="text/javascript" charset="utf-8"></script>
    <script src="<%=request.getContextPath()%>/asset_font/js/outSchoolActivityApply.js"></script>
    <script src="<%=request.getContextPath()%>/asset_font_new/js/jquery.dotdotdot.js" type="text/javascript" charset="utf-8"></script>
    <script src="<%=request.getContextPath()%>/asset_font_new/js/common.js" type="text/javascript" charset="utf-8"></script>
    <script src="<%=request.getContextPath()%>/asset_font_new/js/respond.js" type="text/javascript" charset="utf-8"></script>
    <script src="<%=request.getContextPath()%>/asset_font_new/js/index.js" type="text/javascript" charset="utf-8"></script>
    <!-- 引入 echarts.js -->
    <script type="text/javascript" src="<%=request.getContextPath()%>/asset_mobile/js/echarts.min.js"></script>
    <script src="<%=request.getContextPath()%>/asset/js/jquery.form.js" type="text/javascript" charset="utf-8"></script>
    <script type="text/javascript" src="<%=request.getContextPath()%>/asset/layer/layer.js" ></script>
    <!-- 引入 echarts.css -->
    <link rel="stylesheet" href="<%=request.getContextPath()%>/asset_font/css/Radio.css" type="text/css" />
    <style type="text/css">
        .show{
            margin-left: 4.2rem;
            margin-top: 0.4rem;
        }
        .img_box{
            display: inline-block;
            background: #ffffff;
            width: 4rem;
            margin: 0.15rem;
            height: 4rem;
            padding: 1px;
            border: 1px solid #1990FE;
            text-align: center;
            line-height: 4rem;
        }
        .up_img{
            width:auto!important;
            height:auto;
            max-width:99%;
            max-height:99%;
            margin: auto auto;
            vertical-align: middle;
        }
    </style>
</head>
<body>
<%@include file="header_new.jsp"%>
<%--判断是否是登录状态--%>
<%@include file="../common/CheckLogin.jsp"%>
<div class="center_head_box">
    <a  href="javascript:history.go(-1);" class="center_head_a">返回></a>
    <span class="center_head_span">校外活动申请</span>
    <div class="center_head_ri"></div>

</div>
<!--中间内容部分-->
<div class="center_content_box">
    <div class="center_cen_content_box">
        <form class="table" id="form1" method="post" enctype="multipart/form-data" action="/outschool/apply.form">
            <div class="center_cen_content_put">
                <span class="center_cen_content_span">活动名称</span>
                <input type="text" class="center_cen_content_input" name="outTitle" id="outTitle" value="" />
            </div>
            <div class="center_cen_content_put">
                <span class="center_cen_content_span">获得奖项</span>
                <input type="text" class="center_cen_content_input" name="outAward" id="outAward"/>
            </div>
            <div class="center_cen_content_textArea">
                <span class="center_cen_content_span_t">活动内容</span>
                <textarea type="text" class="center_cen_content_text" name  ="outContent" rows="" cols="" id="outContent"></textarea>
            </div>
            <div class='show' id="show">
            </div>
            <div class="center_cen_content_button">上传图片<input type="file"  name="outPhoto" id="upimg_btn"  multiple class="center_cen_content_file" /></div>
            <button type="submit" name="" id="submit" class="center_cen_content_button_sub">确定提交</button>
        </form>
    </div>
    <!--我的信息-->
    <div class="per_info">
        <div class="per_bg">
            <p>我的信息</p>
            <a href="<%=request.getContextPath()%>/views/font/oneself.form">more>></a>
        </div>
        <div class="per_content">
            <div class="per_content_one">
                <div id="sphoto">
                    <%--<img src=" <%=request.getContextPath()%>/asset_font/img/lixiaoming.png"/>--%>
                </div>
            </div>
            <div class="per_content_two">
                <p>姓名：<span id="sname"></span></p>
                <p>学院：<span id="scoll"></span></p>
                <p>专业：<span id="smaj"></span></p>
                <p>班级：<span id="scla"></span></p>
                <p>学号：<span id="sid"></span></p>
                <p>联系方式：<span id="spho"></span></p>
            </div>
        </div>
        <!--能力模型图-->
        <div id="posi" style="margin-top: 240px;">
            <ul>
                <li><img src="<%=request.getContextPath()%>/asset_font/img/biaoda.png"/></li>
                <li><img src="<%=request.getContextPath()%>/asset_font/img/chuangxin.png"/></li>
                <li><img src="<%=request.getContextPath()%>/asset_font/img/chuangye.png"/></li>
                <li><img src="<%=request.getContextPath()%>/asset_font/img/lingdao.png"/></li>
                <li><img src="<%=request.getContextPath()%>/asset_font/img/sibian.png"/></li>
                <li><img src="<%=request.getContextPath()%>/asset_font/img/zhixing.png"/></li>
            </ul>
            <div id="charts"  style="width: 18.75rem;height:400px;">
            </div>
        </div>

    </div>
</div>
</div>
<!-- 此js必须放在div后面，不能独立放到其他页，放到其他位置都有可能失效 -->
<script src="<%=request.getContextPath()%>/asset/js/Radio.js"></script>
<%@include file="footer_new.jsp"%>
<!--黑幕-->
<div class="black">
</div>
</body>
</html>

