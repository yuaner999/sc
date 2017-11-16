<%--
  Created by IntelliJ IDEA.
  User: yuanshenghan
  Date: 2016/11/1
  Time: 13:08
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="utf-8" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title></title>
    <link rel="Shortcut Icon" href="<%=request.getContextPath()%>/asset/image/neu.jpg" type="image/x-icon">
    <link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/asset_font_new/css/common.css"/>
    <link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/asset_font_new/css/commonhead.css"/>
    <link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/asset_font_new/css/all.css"/>
    <link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/asset_font_new/css/index.css"/>
    <%--<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/asset_font_new/css/indexspacel.css"/>--%>
    <link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/asset_font_new/css/guide.css"/>
    <link type="text/css" rel="stylesheet" href="<%=request.getContextPath()%>/asset/js/paging/paging.css" />
    <link rel="stylesheet" href="<%=request.getContextPath()%>/asset_font/css/Radio2.css" type="text/css" />
    <script src="<%=request.getContextPath()%>/asset_font/js/jquery-1.11.1.min.js" type="text/javascript" charset="utf-8"></script>
    <script type="text/javascript" src="<%=request.getContextPath()%>/asset_font_new/js/jquery.cookie.js" ></script>
    <script type="text/javascript" src="<%=request.getContextPath()%>/asset/layer/layer.js"></script>
    <script src="<%=request.getContextPath()%>/asset_font_new/js/jquery.dotdotdot.js" type="text/javascript" charset="utf-8"></script>
    <script src="<%=request.getContextPath()%>/asset_font_new/js/common.js" type="text/javascript" charset="utf-8"></script>
    <script src="<%=request.getContextPath()%>/asset_font_new/js/respond.js" type="text/javascript" charset="utf-8"></script>
    <script src="<%=request.getContextPath()%>/asset_font_new/js/index.js" type="text/javascript" charset="utf-8"></script>
    <style>
        .bottomDiv{
            height: 0;
            border-color: #2A448D;
            border-bottom: 1px solid #5c85ee;
        }
    </style>
</head>
<body>
<script type="text/javascript">
    var key=0;
    var echartsWidth = $("#per_info").css('width');
    var reg = new RegExp("<[^<]*>", "gi");
    $("img").bind("error",function(){
        this.src="/asset/image/404_img.gif";
    });
    $(function  () {
        $(".neuback").attr("src","/asset_font/img/neuGate.jpg");
        shoolActivtity();
        collegeActivtity();
        //infor();//不知道谁注释的，不知道啥用
    });
    //绑定学校活动
    function shoolActivtity(){
        var loading=layer.load(1, {shade: [0.1,'#000']});
        $.ajax({
            url:"${pageContext.request.contextPath}/jsons/loadshoolActivtityList.form?page=1&rows=7",
            type:"post",
            dataType:"json",
            async:false,
            success:function(data){
                $("#schoolActivity_list_box").html("");
                if(data!=null && data.rows!=null && data.rows.length>0){
                    for(var i=0;i<data.rows.length;i++){
                        var item=data.rows[i];
                        var resultcontext=item.applyState;
                        $.ajax({
                            url: "/jsons/validatePCApply.form",
                            type: "post",
                            data: {actid: item.activityId},
                            datatype: "json",
                            async:false,
                            success: function (data) {
                                if (data.total !== 0) {
                                    resultcontext='已报名'
                                }
                            }
                        });
                        var str='<li>'+
                            '<div>'+
                                '<p><b class=\"news_type'+item.activityClass+'\" title=\"'+item.activityClassMean+'\"></b>'+
                                    '<a href="<%=request.getContextPath()%>/views/font/activitydetail.form?id='+item.activityId+ '" title="'+item.activityTitle+'">'+ item.activityTitle+'</a>'+
                                '</p>'+
                                '</div>'+
                                '<span>'+
                                '<a href="<%=request.getContextPath()%>/views/font/activitydetail.form?id='+item.activityId+ '">'+resultcontext+'</a>'+
                                '</span>'+
                                '<b>'+ item.activityCreatedate +
//                                '<b>'+ item.activityCreatedate.substring(0,10) +
                                '</b></li><div class="bottomDiv"></div>';
                        $("#schoolActivity_list_box").append(str);
                    }
                }
                layer.close(loading);
            },
            error:function(){
                layer.msg("网络错误");
                layer.close(loading);
            }
        });
    }
    //绑定学院活动
    function collegeActivtity(){
        var loading=layer.load(1, {shade: [0.1,'#000']});
        $.ajax({
            url:"${pageContext.request.contextPath}/jsons/loadcollegeActivtityList.form?page=1&rows=7",
            type:"post",
            dataType:"json",
            async:false,
            success:function(data){
                $("#collegeActivtity_list_box").html("");
                if(data!=null && data.rows!=null && data.rows.length>0){
                    for(var i=0;i<data.rows.length;i++){
                        var item=data.rows[i];
                        var resultcontext=item.applyState;
                        $.ajax({
                            url: "/jsons/validatePCApply.form",
                            type: "post",
                            data: {actid: item.activityId},
                            datatype: "json",
                            async:false,
                            success: function (data) {
                                if (data.total !== 0) {
                                    resultcontext='已报名'
                                }
                            }
                        });
                        var str='<li>'+
                                '<div>'+
                                '<p>'+
                                '<b class="news_type'+item.activityClass+'" title=\"'+item.activityClassMean+'\"></b>'+
                                '<a href="<%=request.getContextPath()%>/views/font/activitydetail.form?id='+item.activityId+ '" title="'+item.activityTitle+'">'+ item.activityTitle+'</a>'+
                                '</p></div>'+
                                '<span>'+
                                '<a href="<%=request.getContextPath()%>/views/font/activitydetail.form?id='+item.activityId+ '">'+resultcontext+'</a>'+
                                '</span>'+
                                '<b>'+ item.activityCreatedate +
//                                '<b>'+ item.activityCreatedate.substring(0,10) +
                                '</b></li><div class="bottomDiv"></div>';
                        $("#collegeActivtity_list_box").append(str);
                    }
                }
                layer.close(loading);
            },
            error:function(){
                layer.msg("网络错误");
                layer.close(loading);
            }
        });
    }
</script>

<!--上面
-->
<%@include file="../common/CheckLogin.jsp"%>
<%@include file="header_new.jsp"%>
<!--主题内容
-->
<div class="section">
    <!--列表
    -->
    <ul class="content">
        <li>
            <div>
                <p>学校活动</p><br />
                <b></b>
            </div>
            <ol id="schoolActivity_list_box">
            </ol>
            <a class="mao" href="<%=request.getContextPath()%>/views/font/activityList.form?activityArea=1">
                more >
            </a>
        </li>
        <li>
            <div>
                <p>学院活动</p><br />
                <b></b>
            </div>
            <ol id="collegeActivtity_list_box">

            </ol>
            <a class="mao" href="<%=request.getContextPath()%>/views/font/activityList.form?activityArea=2">
                more >
            </a>
        </li>
    </ul>
    <!--我的信息-->
    <%@include file="myInfo.jsp"%>
</div>
<!--底部
 -->
<%@include file="footer_new.jsp"%>
<div class="guide">
    <div class="black"></div>
    <div class="image">
        <ul class="guide1">
            <img src="<%=request.getContextPath()%>/asset_font_new/img/guide/guide1.png"/>
            <li class="next"></li>
            <li class="open"></li>
        </ul>
        <ul class="guide2">
            <img src="<%=request.getContextPath()%>/asset_font_new/img/guide/guide2.png"/>
            <li class="next"></li>
            <li class="open"></li>
        </ul>
        <ul class="guide3">
            <img src="<%=request.getContextPath()%>/asset_font_new/img/guide/guide3.png"/>
            <li class="next"></li>
            <li class="open"></li>
        </ul>
        <ul class="guide4">
            <img src="<%=request.getContextPath()%>/asset_font_new/img/guide/guide4.png"/>
            <li class="next"></li>
            <li class="open"></li>
        </ul>
        <ul class="guide5">
            <img src="<%=request.getContextPath()%>/asset_font_new/img/guide/guide5.png"/>
            <li class="next"></li>
            <li class="open"></li>
        </ul>
    </div>
</div>
<input type="hidden" value="${studentid}" id="username">
</body>
</html>
