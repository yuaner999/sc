<%--
  Created by IntelliJ IDEA.
  User: admin
  Date: 2016/9/18
  Time: 8:49
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java"  pageEncoding="UTF-8" %>
<!DOCTYPE html>
<style>
    .center_cen_contant_box img{
        max-width: 100% !important;
    }
    .center_cen_contant_box{
        overflow: hidden;
    }
</style>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=9; IE=8; IE=7; IE=EDGE">
    <title>活动详情</title>
    <link rel="Shortcut Icon" href="<%=request.getContextPath()%>/asset/image/neu.jpg" type="image/x-icon">
    <script type="text/javascript" src="<%=request.getContextPath()%>/asset_font/js/jquery-1.11.1.min.js"></script>
    <link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/asset_font_new/css/common.css"/>
    <link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/asset_font_new/css/commonhead.css"/>
    <link href="<%=request.getContextPath()%>/asset_font/css/accNews.css" rel="stylesheet" type="text/css" />
    <link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/asset_font_new/css/index.css"/>
    <link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/asset_font_new/css/all.css"/>
    <link rel="stylesheet" href="<%=request.getContextPath()%>/asset_font/css/Radio2.css" type="text/css" />
    <script type="text/javascript" src="<%=request.getContextPath()%>/asset_font/js/respond.js"></script>
    <script src="<%=request.getContextPath()%>/asset/js/common.js" type="text/javascript" charset="utf-8"></script>
    <script type="text/javascript" src="<%=request.getContextPath()%>/asset/layer/layer.js"></script>
    <script type="text/javascript" src="<%=request.getContextPath()%>/asset_font/js/accNews.js"></script>
    <script type="text/javascript" src="<%=request.getContextPath()%>/asset_mobile/js/echarts.min.js"></script>
    <script src="<%=request.getContextPath()%>/asset_font_new/js/jquery.dotdotdot.js" type="text/javascript" charset="utf-8"></script>
    <script src="<%=request.getContextPath()%>/asset_font_new/js/common.js" type="text/javascript" charset="utf-8"></script>
    <script src="<%=request.getContextPath()%>/asset_font_new/js/respond.js" type="text/javascript" charset="utf-8"></script>
    <script src="<%=request.getContextPath()%>/asset_font_new/js/index.js" type="text/javascript" charset="utf-8"></script>
    <script type="text/javascript">
        //加载数据
        var key=2;
        var actid = '';
        var activityParticipation='';
        var sdate='';
        $(function() {
            actid = GetQueryString("id");
            $.ajax({
                url: "/jsons/loadActDetail.form",
                dataType: "json",
                data: {actid: actid},
                success: function (data) {
                    if (data.rows.length == 0) {
                        layer.msg("加载失败");
                    } else {
                        data.rows[0].activityApplyEdates=data.rows[0].activityApplyEdates==null? "未定义":data.rows[0].activityApplyEdates;
                        $(".center_contant_head").html(data.rows[0].activityTitle);
                        $(".center_contant_text_box").html(data.rows[0].activityContent);
                        $("#stime").html(data.rows[0].activityCreatedate);
                        $("#cname").html(data.rows[0].activityCreator);
                        $("#applyenddate").html("(报名截止时间:"+data.rows[0].activityApplyEdates+")");
                        sdate=data.rows[0].activitySdate;
                        var date=DateFormat(new Date());
                        if(Date.parse(data.rows[1].nowDate)>=Date.parse(data.rows[0].activityApplyEdates.replace(' ','')) ){
                            //按钮隐藏
                            $(".button a").html("报名已经截止");
                            $(".button a").removeAttr("onclick");
                        }
                        if(Date.parse(data.rows[1].nowDate)>=Date.parse(data.rows[0].activityEdate)){
                            //按钮隐藏
                            $(".button a").html("活动已经结束");
                            $(".button a").removeAttr("onclick");
                        }
                        var str = '<img src="/Files/Images/' + data.rows[0].activityImg + '" class="center_cen_contant_img" onerror="(this).src=\'/Files/Images/default.jpg\'"/>';
                        $(".center_cen_contant_img_box").html(str);
                    }
                    $('img').error(function(){
                        $(this).attr('src',"/Files/Images/default.jpg");
                    });
                },
                error: function () {
                    layer.msg("服务器连接失败");
                }
            });
            $.ajax({
                url: "/jsons/validatePCApply.form",
                type: "post",
                data: {actid: actid},
                datatype: "json",
                success: function (data) {
                    if (data.total !== 0) {
                        //按钮隐藏
                        $(".button a").html("已报名");
                        $(".button a").removeAttr("onclick");
                    }
                }
            });
            $.ajax({
                url: "/jsons/loadActivityByID.form",
                type: "post",
                data: {actid: actid},
                success: function (data) {
                    if (data && data.total>0){
                        if (data.rows[0].online == '1') {
                            //按钮隐藏
                            $(".button").hide();
                            activityParticipation=data.rows[0].activityParticipation;
                            var str = "该活动不能线上报名，报名请联系"+data.rows[0].principal+"老师 电话："+data.rows[0].principalphone;
                            $("#principal").text(str);
                            $("#principal").attr("display",true);
                        }
                    }
                }
            });

            $.ajax({
                url: "/jsons/loadActivityByID.form",
                type: "post",
                data: {actid: actid},
                success: function (data) {
                    if (data && data.total>0){
                        if (data.rows[0].activityParticipation == '团体') {
                            //按钮隐藏
                            $(".button").hide();
                            activityParticipation=data.rows[0].activityParticipation;
                            var str = "该活动为团体项目，个人不能报名，报名请联系"+data.rows[0].principal+"老师 电话："+data.rows[0].principalphone;
                            $("#principal").text(str);
                            $("#principal").attr("display",true);
                        }
                    }
                }
            });
            //判断浏览器是否为IE8，隐藏重复的雷达图
            if(navigator.appName == "Microsoft Internet Explorer" && navigator.appVersion.match(/8./i)=="8.")
            {
                $("#charts").find(">div").eq(0).hide();
            }
        });
        //申请活动
        function applyPCAct() {
            if(activityParticipation !="团体"){
                $.ajax({
                    url: "/jsons/applyPCAct.form",
                    type: "post",
                    data: {actid: actid},
                    datatype: "text",
                    success: function (data) {
                        if(data=="申请成功"){
                            layer.alert("申请成功,活动开始时间为"+sdate+"请关注该活动的进展",{offset:['40%','40%']});
                            window.setTimeout("reloadyemian();",3000);
                        }
                    }
                })
            }else {
                layer.alert("该活动为团体无法申请，即将返回上一页",{offset:['40%','40%']});
                window.setTimeout("reloadyemian();",3000);
            }
        }
        function reloadyemian() {
            window.location.reload();
        }
        //格式化日期把毫秒值转成字符串
        function DateFormat(time,formateStr){
            var date;
            if(!formateStr) formateStr="yyyy-MM-dd";
            if(time)  date=new Date(time);
            else date=new Date();
            var year=date.getFullYear();
            var month=date.getMonth()+1;
            var day=date.getDate();
            var h=date.getHours();
            var min=date.getMinutes();
            var sec=date.getSeconds();
            formateStr=formateStr.replace("yyyy",""+year);
            formateStr=formateStr.replace("MM",""+month>9?month:"0"+month);
            formateStr=formateStr.replace("dd",""+day>9?day:"0"+day);
            formateStr=formateStr.replace("HH",""+h>9?h:"0"+h);
            formateStr=formateStr.replace("mm",""+min>9?min:"0"+min);
            formateStr=formateStr.replace("ss",""+sec>9?sec:"0"+sec);
            return formateStr;
        }
    </script>
    <style type="text/css">
        .text_head{
            font-size: 14px;
            margin-left: 15px;
            height: 14px;
            line-height: 35px;
            color: #2a458c;
        }
        .apply_text{
            float: right;
            color: #2a458c;
        }
        .per_content_one img{
            height: 143px;
        }
        #posi img{

        }
    </style>
</head>
<body>
<%@include file="../common/CheckLogin.jsp"%>
<%@include file="header_new.jsp"%>
<div class="section">
    <div class="cconttent">
        <div class="center_head_box">
            <a href="javascript:history.go(-1);" class="center_head_a" style="cursor:pointer;">返回>

            </a>
            <span class="center_head_span">活动详情</span>
            <div class="center_head_ri"></div>

        </div>
        <div class="center_contant_box">
            <div class="center_cen_contant_box">
                <div class="center_contant_head">活动标题</div>
                <span id="stime" class="text_head">活动时间</span>
                <span id="cname" class="text_head">东北大学</span>
                <span id="applyenddate" class="text_head">报名截止时间</span>
                <div class="center_contant_text_box">活动内容</div>
                <span class="button"><a href='javascript:void(0);' onclick="applyPCAct()" class="apply_text">报名参加&gt;&gt;</a></span>
                <div style="text-align: center">
                    <span id="principal" display="false"></span>
                </div>
            </div>
        </div>
    </div>
    <!--我的信息-->
    <%@include file="myInfo.jsp"%>
</div>
<script type="text/javascript" src="<%=request.getContextPath()%>/asset/js/Radio.js"></script>
<%@include file="footer_new.jsp"%>
</body>
</html>
