<%--
  Created by IntelliJ IDEA.
  User: admin
  Date: 2016/9/10
  Time: 16:56
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java"  pageEncoding="UTF-8" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01//EN"
"http://www.w3.org/TR/html4/strict.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" lang="en">

<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
    <title>共青团”第二课堂成绩单”信息认证系统</title>
    <link rel="Shortcut Icon" href="<%=request.getContextPath()%>/asset/image/neu.jpg" type="image/x-icon">
    <link rel="stylesheet" href="<%=request.getContextPath()%>/asset_font/css/headfoot.css" />
    <link rel="stylesheet" href="<%=request.getContextPath()%>/asset_font/css/headtwo.css" />
    <script type="text/javascript" src="<%=request.getContextPath()%>/asset_font/js/jquery-1.11.1.min.js"></script>
    <link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/asset_font_new/css/common.css"/>
    <link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/asset_font_new/css/commonhead.css"/>
    <link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/asset_font_new/css/index.css"/>
    <link rel="stylesheet" href="<%=request.getContextPath()%>/asset_font/css/content.css" />
    <link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/asset_font/css/new_file.css" />
    <script type="text/javascript" src="<%=request.getContextPath()%>/asset_font/js/respond.js"></script>
    <script type="text/javascript" src="<%=request.getContextPath()%>/asset_font/js/headfoot.js"></script>
    <script type="text/javascript" src="<%=request.getContextPath()%>/asset_font/js/content.js"></script>
    <script type="text/javascript" src="<%=request.getContextPath()%>/asset/layer/layer.js"></script>
    <script src="<%=request.getContextPath()%>/asset_font_new/js/jquery.dotdotdot.js" type="text/javascript" charset="utf-8"></script>
    <script src="<%=request.getContextPath()%>/asset_font_new/js/common.js" type="text/javascript" charset="utf-8"></script>
    <script src="<%=request.getContextPath()%>/asset_font_new/js/respond.js" type="text/javascript" charset="utf-8"></script>
    <script src="<%=request.getContextPath()%>/asset_font_new/js/index.js" type="text/javascript" charset="utf-8"></script>
    <!-- 引入 echarts.js -->
    <script type="text/javascript" src="<%=request.getContextPath()%>/asset_mobile/js/echarts.min.js"></script>
    <!-- 引入 echarts.css -->
    <link rel="stylesheet" href="<%=request.getContextPath()%>/asset_font/css/Radio2.css" type="text/css" />

    <script type="text/javascript">
        var echartsWidth = $("#per_info").css('width')
        var reg = new RegExp("<[^<]*>", "gi");
        $("img").bind("error",function(){
            this.src="/asset/image/404_img.gif";
        });
        $(function(){
            $(".neuback").attr("src","/asset_font/img/neuGate.jpg");
        });

        $(function() {
            shoolActivtity();
            collegeActivtity();
        //    infor();
        });
        //绑定学校活动
        function shoolActivtity(){
            var loading=layer.load(1, {shade: [0.1,'#000']});
            $.ajax({
                url:"${pageContext.request.contextPath}/jsons/loadshoolActivtityList.form?page=1&rows=4",
                type:"post",
                dataType:"json",
                async:true,
                success:function(data){
//                   var a= eval("("+data+")");
                    $("#schoolActivity_list_box").html("");
                    if(data!=null && data.rows!=null && data.rows.length>0){
                        var header='<div>'+
                                '<div class="sch_ac_head">'+
                                '<h4>学校活动</h4>'+
                                '</div>'+
                                '<div class="sch_ac_more">'+
                                '<a href="<%=request.getContextPath()%>/views/font/activityList.form?activityArea=1"><img src="<%=request.getContextPath()%>/asset_font/img/more.png" alt="" /></a>'+
                                '</div>'+
                                '<div class="sch_ac_hang">'+
                                '<img src="<%=request.getContextPath()%>/asset_font_new/img/border_08.png" />'+
                                '</div>'+
                                '</div>';
                        $("#schoolActivity_list_box").append(header);
                        for(var i=0;i<data.rows.length;i++){
                            var item=data.rows[i];
                            var str=' <ul class="sch_content">'+
                                    '<li class="content_one">'+
                                    '<a href="<%=request.getContextPath()%>/views/font/activitydetail.form?id='+item.activityId+ '"><img src="<%=request.getContextPath()%>/Files/Images/' +item.activityImg+ '" onerror="onerror=null;src=\'/Files/Images/newsimg_03.png\'" alt="" /></a>'+
                                    '</li>'+
                                    '<li class="content_two">'+
                                    '<ul class="content_two_first">'+
                                    '<a href="<%=request.getContextPath()%>/views/font/activitydetail.form?id='+item.activityId+ '"><img src="<%=request.getContextPath()%>/asset_font/img/SignUp.png" alt="" value="点击报名"/></a>'+
                                    '<a href="<%=request.getContextPath()%>/views/font/activitydetail.form?id='+item.activityId+ '">'+ item.activityTitle+'</a>'+
                                    '</ul>'+
                                    '<ul class="dot_one">'+
                                     item.activityContent.replace(reg, "")
                                    +'</ul>'+
                                    '<ul class="content_three">'+
//                                    '<h4>'+item.activityCreatedate.substring(0,10)+'</h4>'+
                                    '<h4>'+item.activityCreatedate+'</h4>'+
                                    '<img src=" <%=request.getContextPath()%>/asset_font/img/yellow.png" />'+
                                    '</ul>'+
                                    '</li>'+
                                    '</ul>';
                            $("#schoolActivity_list_box").append(str);
                            var w=$(".content>li li>span img").width();
                            $(".content>li li>span img").height(w*0.5);
                            //里诶啊哦高度
                            var imgh=$(".content>li li>span").height();
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
           var loading= layer.load(1, {shade: [0.1,'#000']});
            $.ajax({
                url:"${pageContext.request.contextPath}/jsons/loadcollegeActivtityList.form?page=1&rows=4",
                type:"post",
                dataType:"json",
                async:true,
                success:function(data){
//                   var a= eval("("+data+")");
                    $("#collegeActivtity_list_box").html("");
                    if(data!=null && data.rows!=null && data.rows.length>0){
                        var header='<div>'+
                                '<div class="sch_ac_head">'+
                                '<h4>学院活动</h4>'+
                                '</div>'+
                                '<div class="sch_ac_more">'+
                                '<a href="<%=request.getContextPath()%>/views/font/activityList.form?activityArea=2"><img src=" <%=request.getContextPath()%>/asset_font/img/more.png" alt="" /></a>'+
                                '</div>'+
                                '<div class="sch_ac_hang">'+
                                '<img src=" <%=request.getContextPath()%>/asset_font_new/img/border_08.png" />'+
                                '</div>'+
                                '<div>';
                        $("#collegeActivtity_list_box").append(header);
                        for(var i=0;i<data.rows.length;i++){
                            var item=data.rows[i];
                            var str=' <ul class="sch_content">'+
                                    '<li class="content_one">'+
                                    '<a href="<%=request.getContextPath()%>/views/font/activitydetail.form?id='+item.activityId+'"><img src=" <%=request.getContextPath()%>/Files/Images/' +item.activityImg+ '" onerror="onerror=null;src=\'/Files/Images/newsimg_03.png\'"  alt="" /></a>'+
                                    '</li>'+
                                    '<li class="content_two">'+
                                    '<ul class="content_two_first">'+
                                    '<a href="<%=request.getContextPath()%>/views/font/activitydetail.form?id='+item.activityId+ '"><img src="<%=request.getContextPath()%>/asset_font/img/SignUp.png" alt="" value="点击报名"/></a>'+
                                    '<a href="<%=request.getContextPath()%>/views/font/activitydetail.form?id='+item.activityId+ '">'+ item.activityTitle+'</a>'+
                                    '</ul>'+
                                    '<ul class="dot_one">'+
                                    item.activityContent.replace(reg, "")
                                    +'</ul>'+
                            '<ul class="content_three">'+
                            '<h4>'+item.activityCreatedate.substring(0,10)+'</h4>'+
                            '<img src=" <%=request.getContextPath()%>/asset_font/img/yellow.png" />'+
                            '</ul>'+
                            '</li>'+
                            '</ul>';
                            $("#collegeActivtity_list_box").append(str);
                            var w=$(".content>li li>span img").width();
                            $(".content>li li>span img").height(w*0.5);
                            //里诶啊哦高度
                            var imgh=$(".content>li li>span").height();
//                            $(function(){
//                                var imgs = document.images; // images 集合可返回对文档中所有 Image 对象的引用。
//                                for(var i = 0;i < imgs.length;i++){
//                                imgs[i].onerror = function(){
//                                this.src = "/Files/Images/default.jpg";
//                                    }
//                                 }
//                            })
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
        //获取个人信息
        function infor(){
            $.ajax({
                url:"${pageContext.request.contextPath}/jsons/loadInfor.form",
                type:"post",
                dataType:"json",
                async:true,
                success:function(data){
                    var photo = data.rows[0].studentPhoto;
//                    console.log(photo);
                    if(photo==null||photo==""){
                        photo="phpto_26.png";
                    }
                    if(data!=null && data.rows!=null && data.rows.length>0){
                        $("#per_content").html("");
                        var str='<div class="per_content_one">'+
                                '<div><img src="<%=request.getContextPath()%>/Files/Images/' +photo+'" onerror="onerror=null;src=\'/Files/Images/default.jpg\'" /></div>'+
                                '</div>'+
                                '<div class="per_content_two">'+
                                '<p>姓名：<span>'+data.rows[0].studentName+'</span></p>'+
                                '<p>学院：<span>'+data.rows[0].collegeName+'</span></p>'+
                                '<p>专业：<span>'+data.rows[0].majorName+'</span></p>'+
                                '<p>班级：<span>'+data.rows[0].className+'</span></p>'+
                                '<p>学号：<span>'+data.rows[0].studentID+'</span></p>'+
                                '<p>联系方式：<span>'+data.rows[0].studentPhone+'</span></p>'+
                                '</div>';
                        $("#per_content").append(str);
                    }
                },
                error:function(){
                    layer.msg("网络错误");
                }
            });
        }
//        $(function(){
//            setTimeout(function(){
//                var imgs = document.images; // images 集合可返回对文档中所有 Image 对象的引用。
//                for(var i = 0;i < imgs.length;i++){
//                    imgs[i].onerror = function(){
//                        this.src = "/Files/Images/default.jpg";
//                    }
//                }
//            },200)
//        })

    </script>
</head>

<body>
<script>
    $().ready(function(){
        setTimeout(function(){
            $(".dot_one").css("font-size","12px");
        },100)
    })
</script>
<%@include file="header_new.jsp"%>
<%--判断是否是登录状态--%>
<%@include file="../common/CheckLogin.jsp"%>
<div class="content">
    <!--学校活动-->
    <div class="sch_ac" id="schoolActivity_list_box">

    </div>
    <!--学院活动-->
    <div class="sch_ac" id="collegeActivtity_list_box">

    </div>
    <!--我的信息-->
    <div class="per_info">
        <div class="per_bg">
            <p>我的信息</p>
            <a href="<%=request.getContextPath()%>/views/font/oneself.form" style="cursor:pointer;">more>></a>
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
        <div id="posi">
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
<!-- 此js必须放在div后面，不能独立放到其他页，放到其他位置都有可能失效 -->
<script src="<%=request.getContextPath()%>/asset/js/Radio.js"></script>
<%@include file="footer_new.jsp"%>

</body>

</html>