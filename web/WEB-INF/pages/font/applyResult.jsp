<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
    <title>非活动类申请</title>
    <link rel="Shortcut Icon" href="<%=request.getContextPath()%>/asset/image/neu.jpg" type="image/x-icon">
    <link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/asset_font_new/css/common.css"/>
    <link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/asset_font_new/css/commonhead.css"/>
    <link href="<%=request.getContextPath()%>/asset_font/css/activeApply.css" rel="stylesheet" type="text/css" />
    <link rel="stylesheet" href="<%=request.getContextPath()%>/asset_font/css/headfoot.css" type="text/css" />
    <script src="<%=request.getContextPath()%>/asset_font/js/jquery-1.11.1.min.js" type="text/javascript" charset="utf-8"></script>
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
        .window_selectMsg{
            min-height: 700px !important;
        }
        .window_selectMsg>div{
            height: 500px !important;
        }
        .table_box{
            width: 87.61%;
            height: 560px;
            margin-top: 40px;
            margin-left: 68px;
            overflow: auto;
        }
        .secondClassMsgContent .person_analyze{
            height: 410px;
        }
    </style>
    <script>
        $(function(){
            School();
            OutSchool();
            NotActivity();
            InformApply();
        });
        function  School(){
            $.ajax({
                url:"${pageContext.request.contextPath}/jsons/loadshoolActivtityResult.form",
                type:"post",
                dataType:"json",
                async:true,
                success:function(data){
                    $("#infolist").html("");
                    if(data!=null && data.rows!=null && data.rows.length>0){
                        for(var i=0;i<data.rows.length;i++){
                            data.rows[i].activityTitle= data.rows[i].activityTitle==null?'': data.rows[i].activityTitle.substring(0,13);
                            data.rows[i].applyAuditStatus= data.rows[i].applyAuditStatus==null?'': data.rows[i].applyAuditStatus;
                            data.rows[i].applyAuditStatusDate= data.rows[i].applyAuditStatusDate==null?'': data.rows[i].applyAuditStatusDate;
                            var item=data.rows[i];
                            var str= '<div>'+
                                    '<span class="info_value">'+item.activityTitle+'</span>'+
                                    '<span class="info_value">'+item.applyAuditStatus+'</span>'+
                                    '<span class="info_value">'+item.applyAuditStatusDate+'</span>'+
                                    '</div>';
                            $("#infolist").append(str);
                        }
                    }else {
                        var str="<span class='info_value'>没有校内活动类申请记录</span>";
                        $("#infolist").append(str);
                    }
                },
                error:function(){
                    layer.msg("网络错误");
                }
            });
        }
        function OutSchool(){
            $.ajax({
                url:"${pageContext.request.contextPath}/jsons/loadOutshoolActivtityResult.form",
                type:"post",
                dataType:"json",
                async:true,
                success:function(data){
                    $("#infolist2").html("");
                    if(data!=null && data.rows!=null && data.rows.length>0){
                        for(var i=0;i<data.rows.length;i++){
                            var item=data.rows[i];
                            var str= '<div>'+
                                    '<span class="info_value">'+item.outTitle+'</span>'+
                                    '<span class="info_value">'+item.outAuditStatus+'</span>'+
                                    '<span class="info_value">'+item.outAuditDate+'</span>'+
                                    '</div>';
                            $("#infolist2").append(str);
                        }
                    }else {
                        var str="<span class='info_value'>没有校外活动申请记录</span>";
                        $("#infolist2").append(str);
                    }
                },
                error:function(){
                    layer.msg("网络错误");
                }
            });
        }
        function NotActivity(){
            $.ajax({
                url:"${pageContext.request.contextPath}/jsons/loadNotactivity.form",
                type:"post",
                dataType:"json",
                async:true,
                success:function(data){
                    $("#infolist3").html("");
                    if(data!=null && data.rows!=null && data.rows.length>0){
                        for(var i=0;i<data.rows.length;i++){
                            var item=data.rows[i];
                            var str= '<div>'+
                                    '<span class="info_value">'+item.notClass+'</span>'+
                                    '<span class="info_value">'+item.auditStatus+'</span>'+
                                    '<span class="info_value">'+item.auditStatusDate+'</span>'+
                                    '</div>';
                            $("#infolist3").append(str);
                        }
                    }else {
                        var str="<span class='info_value'>没有非活动类申请记录</span>";
                        $("#infolist3").append(str);
                    }
                },
                error:function(){
                    layer.msg("网络错误");
                }
            });
        }
        function InformApply(){
            $.ajax({
                url:"${pageContext.request.contextPath}/jsons/loadInform.form",
                type:"post",
                dataType:"json",
                async:true,
                success:function(data){
                    $("#infolist4").html("");
                    if(data!=null && data.rows!=null && data.rows.length>0){
                        for(var i=0;i<data.rows.length;i++){
                            var item=data.rows[i];
                            for(var key in item){
                                if(item[key]==null||item[key]=='null'||item[key]=='NULL')
                                    item[key]='';
                            }
                            var str= '<div>'+
                                    '<span class="info_value">'+item.activityTitle+'</span>'+
                                    '<span class="info_value">'+item.informAuditStatus+'</span>'+
                                    '<span class="info_value">'+item.informAuditDate+'</span>'+
                                    '</div>';
                            $("#infolist4").append(str);
                        }
                    }else {
                        var str="<span class='info_value'>没有举报质疑申请记录</span>";
                        $("#infolist4").append(str);
                    }
                },
                error:function(){
                    layer.msg("网络错误");
                }
            });
        }
    </script>
</head>
<body>
<%@include file="header_new.jsp"%>
<%--判断是否是登录状态--%>
<%@include file="../common/CheckLogin.jsp"%>
<div class="center_head_box">
    <a  href="javascript:history.go(-1);" class="center_head_a">返回></a>
    <span class="center_head_span">申请结果查看</span>
    <div class="center_head_ri">

    </div>
    <!--分割线-->
    <div class="yellowBar">
        <div class="blueBar">
        </div>
    </div>
    <div class="reviewing">
        <div class="review_title">
            <span class="listdot"></span>校内活动申请结果</div>
        <div class="infolist">
            <ul  id="infolist">
                <div>
                    <span class="info_value">活动1</span>
                    <span class="info_value">申请结果</span>
                    <span class="info_value">申请结果</span>
                    <span class="info_value2">申请结果</span>
                </div>
                <div>
                    <span class="info_value">活动2</span>
                    <span class="info_value">申请结果</span>
                    <span class="info_value">申请结果</span>
                    <span class="info_value2">申请结果</span>
                </div>
            </ul>
        </div>
        <div class="review_title">
            <span class="listdot"></span>校外活动申请结果</div>
        <div class="infolist">
            <ul  id="infolist2">
                <div>
                    <span class="info_value">活动1</span>
                    <span class="info_value">申请结果</span>
                    <span class="info_value">申请结果</span>
                    <span class="info_value2">申请结果</span>
                </div>
                <div>
                    <span class="info_value">活动2</span>
                    <span class="info_value">申请结果</span>
                    <span class="info_value">申请结果</span>
                    <span class="info_value2">申请结果</span>
                </div>
            </ul>
        </div>
        <div class="review_title">
            <span class="listdot"></span>非活动类申请结果</div>
        <div  class="infolist">
            <ul id="infolist3">
                <div>
                    <span class="info_value">非活动类1</span>
                    <span class="info_value">申请结果</span>
                    <span class="info_value">申请结果</span>
                    <span class="info_value2">申请结果</span>
                </div>
                <div>
                    <span class="info_value">非活动类2</span>
                    <span class="info_value">申请结果</span>
                    <span class="info_value">申请结果</span>
                    <span class="info_value2">申请结果</span>
                </div>
            </ul>
        </div>
        <div class="review_title">
            <span class="listdot"></span>举报质疑申请结果</div>
        <div  class="infolist">
            <ul id="infolist4">
                <div>
                    <span class="info_value">举报类1</span>
                    <span class="info_value">申请结果</span>
                    <span class="info_value">申请结果</span>
                    <span class="info_value2">申请结果</span>
                </div>
                <div>
                    <span class="info_value">质疑类1</span>
                    <span class="info_value">申请结果</span>
                    <span class="info_value">申请结果</span>
                    <span class="info_value2">申请结果</span>
                </div>
            </ul>
        </div>
    </div>
</div>
<!--中间内容部分-->
<div class="center_content_box">

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

