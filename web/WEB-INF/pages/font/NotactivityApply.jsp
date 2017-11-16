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
    <script>
        $(function(){
            //选择照片
            $("#upimg_btn").click(choose())
            function choose () {
                var upimg = document.getElementById('upimg_btn');
                var show  = document.getElementById('show');


                if(!(window.FileReader && window.File && window.FileList && window.Blob)){
                    alert ('您的浏览器不支持fileReader，建议使用ie10+浏览器或者谷歌浏览器');
                    upimg.setAttribute('disabled', 'disabled');
                    return false;
                }
                upimg.addEventListener('change', function(e){//addEventListener 为 <button> 元素添加点击事件
                    var files = this.files;
                    if(files.length>0 && files.length<=8){
                        // 对文件进行处理，下面会讲解checkFile()会做什么
                        checkFile(this.files);
                    }else if(files.length>8){
                        show.innerHTML="";
                        this.files=null;
                        layer.msg("请选择少于8张图片");
                    }else{
                        show.innerHTML="";
                    }
                });
            }
            function checkFile(files){
                var html='', i=0;
                var func = function(){
                    if(i>files.length-1){
                        // 若已经读取完毕，则把html添加页面中
                        show.innerHTML = html;
                        return;
                    }
                    var file = files[i];
                    var reader = new FileReader();

                    // show表示<div id='show'></div>，用来展示图片预览的
                    if(!/image\/\w+/.test(file.type)){
                        show.innerHTML = "请确保文件为图像类型";
                        return false;
                    }
                    reader.onload = function(e){
                        html += '<div class="img_box"><img  class="up_img" src="'+e.target.result+'" alt="img"></div>';
                        i++;
                        func(); //选取下一张图片
                    }
                    reader.readAsDataURL(file);
                }
                func();
            }

            /**
             * 提交表单
             */
            $("#form1").ajaxForm({
                beforeSerialize:function(){
                 //   layer.load(1, {shade: [0.4,'#000']});
                    var NotClass=$("#notClass").val();
                    var files=$("#upimg_btn").val();
                    if(!NotClass){
                        layer.msg("非活动类别不能留空");
                        return false;
                    }
                    if(NotClass=="学术与科技类"){
                        if(!files){
                            layer.msg("学术与科技类必须上传图片");
                            return false;
                        }
                        if(!$("#scienceClass").val()){
                            layer.msg("学术科技类别不能留空");
                            return false;
                        }
                        if(!$("#scienceName").val()){
                            layer.msg("学术科技名不能留空");
                            return false;
                        }
                    }
                    if(NotClass=="社会工作类"){
                        if(!$("#workLevle").val()&&!$("#classworkName").val()){
                            layer.msg("请按要求填写社会工作");
                            return false;
                        }
                    }
                    if(NotClass=="shiptypeName"){
                        if(!$("#shiptypeName").val()){
                            layer.msg("请按要求填写奖学金类别");
                            return false;
                        }
                        if($("#shiptypeName").val()=="命名奖学金"&&!$("#typeName").val()){
                            layer.msg("请填写命名奖学金的名字");
                        }
                    }
                },
                dataType:"json",
                success:function(data){
                    layer.closeAll();
                    $("#form1").clearForm();
                    $("#form1").resetForm();
                    $("#show").html("");
                    if(data.status==0){
                        layer.msg("提交成功");
                        if(data.data && data.data.length>0){
                            var resutl="";
                            for(var i=0;i<data.data.length;i++){
                                result=resutl+data.data[i]+",";
                            }
                            if(resutl.length>0)
                                layer.alert("未上传成功文件："+resutl.substring(0,resutl.length-1));
                        }
                    }
                },
                error:function(){
                    layer.closeAll();
                    layer.msg("服务器连接失败，请稍后再试");
                }
            });
            $(".workLevle").hide();
            $(".organizationName").hide();
            $(".schoolworkName").hide();
            $(".classworkName").hide();
            $(".scienceClass").hide();
            $(".scienceName").hide();
            $(".shiptypeName").hide();
            $(".sciencePhoto").hide();
            $(".typeName").hide();
            $(".show").hide();
            if($("#notClass").val()=="社会工作类"){
                $(".workLevle").addClass("showed");
                $(".workLevle").slideDown(300);
                $(".organizationName").addClass("showed");
                $(".organizationName").slideDown(300);
                $(".schoolworkName").addClass("showed");
                $(".schoolworkName").slideDown(300);
                $(".classworkName").addClass("showed");
                $(".classworkName").slideDown(300);
                $(".scienceClass").removeClass("showed");
                $(".scienceClass").slideUp(300);
                $(".scienceName").removeClass("showed");
                $(".scienceName").slideUp(300);
                $(".shiptypeName").removeClass("showed");
                $(".shiptypeName").slideUp(300);
                $(".sciencePhoto").removeClass("showed");
                $(".sciencePhoto").slideUp(300);
                $(".typeName").hide();
                $(".show").hide();
            }
            $("#notClass").change(function(){
                    if($(this).val()=="社会工作类"){
                        $(".workLevle").addClass("showed");
                        $(".workLevle").slideDown(300);
                        $(".organizationName").addClass("showed");
                        $(".organizationName").slideDown(300);
                        $(".schoolworkName").addClass("showed");
                        $(".schoolworkName").slideDown(300);
                        $(".classworkName").addClass("showed");
                        $(".classworkName").slideDown(300);
                        $(".scienceClass").removeClass("showed");
                        $(".scienceClass").slideUp(300);
                        $(".scienceName").removeClass("showed");
                        $(".scienceName").slideUp(300);
                        $(".shiptypeName").removeClass("showed");
                        $(".shiptypeName").slideUp(300);
                        $(".sciencePhoto").removeClass("showed");
                        $(".sciencePhoto").slideUp(300);
                        $(".typeName").hide();
                        $(".show").hide();
                    }
                    if($(this).val()=="学术与科技类"){
                        $(".scienceClass").addClass("showed");
                        $(".scienceClass").slideDown(300);
                        $(".scienceName").addClass("showed");
                        $(".scienceName").slideDown(300);
                        $(".sciencePhoto").addClass("showed");
                        $(".sciencePhoto").slideDown(300);
                        $(".workLevle").removeClass("showed");
                        $(".workLevle").slideUp(300);
                        $(".organizationName").removeClass("showed");
                        $(".organizationName").slideUp(300);
                        $(".schoolworkName").removeClass("showed");
                        $(".schoolworkName").slideUp(300);
                        $(".classworkName").removeClass("showed");
                        $(".classworkName").slideUp(300);
                        $(".shiptypeName").removeClass("showed");
                        $(".shiptypeName").slideUp(300);
                        $(".typeName").hide();
                        $(".show").show();
                    }
                    if($(this).val()=="奖学金类"){
                        $(".shiptypeName").addClass("showed");
                        $(".shiptypeName").slideDown(300);
                        $(".workLevle").removeClass("showed");
                        $(".workLevle").slideUp(300);
                        $(".organizationName").removeClass("showed");
                        $(".organizationName").slideUp(300);
                        $(".schoolworkName").removeClass("showed");
                        $(".schoolworkName").slideUp(300);
                        $(".classworkName").removeClass("showed");
                        $(".classworkName").slideUp(300);
                        $(".scienceClass").removeClass("showed");
                        $(".scienceClass").slideUp(300);
                        $(".scienceName").removeClass("showed");
                        $(".scienceName").slideUp(300);
                        $(".sciencePhoto").removeClass("showed");
                        $(".sciencePhoto").slideUp(300);
                        $(".typeName").hide();
                        $(".show").hide();
                   }
            });
            $("#shiptypeName").change(function(){
                if($(this).val()=="命名奖学金"){
                    $(".typeName").addClass("showed");
                    $(".typeName").slideDown(300);
                }else{
                    $(".typeName").removeClass("showed");
                    $(".typeName").slideUp(300);
                }
            });
            //加载不同的工作组织名称
            $("#workLevle").change(function() {
                $.ajax({
                    url: "/jsons/loadOrganizationName.form",
                    type:"post",
                    data: {workLevle: $(this).val()},
                    dataType: "json",
                    success: function (data) {
                        var friends = $("#organizationName");
                        friends.empty();
                        friends.append("<option value=''>请选择</option>");
                        if(data.rows !=null && data.rows.length > 0){
                            for(var i=0;i<data.rows.length;i++) {
                                var option = $("<option>").text(data.rows[i].organizationName).val(data.rows[i].organizationName);
                                friends.append(option);
                            }
                        }else{
                            var option = $("<option>").text("无");
                            friends.append(option);
                        }
                    }
                });
            });
            //加载不同的学生处职务名称
            $("#organizationName").change(function() {
                $.ajax({
                    url: "/jsons/loadSchoolworkName.form",
                    data: {organizationName: $(this).val()},
                    type:"post",
                    dataType: "json",
                    success: function (data) {
                        var friends = $("#schoolworkName");
                        friends.empty();
                        friends.append("<option value=''>请选择</option>");
                        if(data.rows !=null && data.rows.length > 0){
                            for(var i=0;i<data.rows.length;i++) {
//                                console.log(data.rows[i].schoolworkName)
                                var option = $("<option>").text(data.rows[i].schoolworkName).val(data.rows[i].schoolworkName);
                                friends.append(option);
                            }
                        }else{
                            var option = $("<option>").text("无");
                            friends.append(option);
                        }
                    }
                });
            });
        });
    </script>
</head>
<body>
<%@include file="header_new.jsp"%>
<%--判断是否是登录状态--%>
<%@include file="../common/CheckLogin.jsp"%>
<div class="center_head_box">
    <a  href="javascript:history.go(-1);" class="center_head_a">返回></a>
    <span class="center_head_span">非活动类申请</span>
    <div class="center_head_ri"></div>

</div>
<!--中间内容部分-->
<div class="center_content_box">
    <div class="center_cen_content_box">
        <form class="table" id="form1" method="post" enctype="multipart/form-data" action="/noactivity/apply.form">
            <div class="center_cen_content_put">
                <span class="center_cen_content_span">非活动类别</span>
                <select class="center_cen_content_input" name="notClass" id="notClass"
                        style="width:200px;height:32px">
                    <option value="">请选择</option>
                    <option value="社会工作类">社会工作类</option>
                    <option value="学术与科技类">学术与科技类</option>
                    <option value="奖学金类">奖学金类</option>
                </select>
            </div>
            <div class="center_cen_content_put workLevle">
                <span class="center_cen_content_span ">工作的级别</span>
                <select class="center_cen_content_input" name="workLevle" id="workLevle"
                        style="width:200px;height:32px">
                    <option value="">请选择</option>
                    <option value="">无</option>
                    <c:forEach items="${workLevles}" var="workLevle">
                        <option value="${workLevle.workLevle}">${workLevle.workLevle}</option>
                    </c:forEach>
                </select>
            </div>
            <div class="center_cen_content_put organizationName">
                <span class="center_cen_content_span_t ">工作组织名&nbsp;</span>
                <select class="center_cen_content_input" name="organizationName" id="organizationName"
                        style="width:200px;height:32px">
                </select>
            </div>
            <div class="center_cen_content_put schoolworkName">
                <span class="center_cen_content_span_t ">学生处职务&nbsp;</span>
                <select class="center_cen_content_input" name="schoolworkName" id="schoolworkName"
                        style="width:200px;height:32px">
                </select>
            </div>
            <div class="center_cen_content_put classworkName">
                <span class="center_cen_content_span_t ">班级职务名&nbsp;</span>
                <select class="center_cen_content_input" name="classworkName" id="classworkName"
                        style="width:200px;height:32px">
                    <option value="">请选择</option>
                    <c:forEach items="${classworkNames}" var="classworkName">
                        <option value="${classworkName.classworkName}">${classworkName.classworkName}</option>
                    </c:forEach>
                </select>
            </div>
            <div class="center_cen_content_put scienceClass">
                <span class="center_cen_content_span_t ">学术科技类&nbsp;</span>
                <select class="center_cen_content_input" name="scienceClass" id="scienceClass"
                        style="width:200px;height:32px">
                    <option value="">请选择</option>
                    <c:forEach items="${sciencetechnologys}" var="sciencetechnology">
                        <option value="${sciencetechnology.scienceClass}">${sciencetechnology.scienceClass}</option>
                    </c:forEach>
                </select>
            </div>
            <div class="center_cen_content_put scienceName">
                <span class="center_cen_content_span ">学术科技名</span>
                <input type="text" class="center_cen_content_input" name="scienceName" id="scienceName" value=""  style="width:198px;height:30px"/>
            </div>
            <div class="center_cen_content_put shiptypeName">
                <span class="center_cen_content_span ">奖学金类别</span>
                <select class="center_cen_content_input" name="shiptypeName" id="shiptypeName"
                        style="width:200px;height:32px">
                    <option value="">请选择</option>
                    <option value="学期奖学金">学期奖学金</option>
                    <option value="国家奖学金">国家奖学金</option>
                    <option value="命名奖学金">命名奖学金</option>
                </select>
            </div>
            <div class="center_cen_content_put typeName">
                <span class="center_cen_content_span">奖学金名称</span>
                <input type="text" class="center_cen_content_input" name="typeName" id="typeName" value=""  style="width:198px;height:30px">
            </div>
            <div class='show' id="show">
            </div>
            <div class="center_cen_content_button sciencePhoto">上传图片<input type="file"  name="sciencePhoto" id="upimg_btn"  multiple class="center_cen_content_file" /></div>

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

