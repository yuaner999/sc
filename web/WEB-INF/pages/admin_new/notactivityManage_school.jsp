<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: dskj012
  Date: 2016/10/21
  Time: 9:15
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java"  pageEncoding="UTF-8" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01//EN"
"http://www.w3.org/TR/html4/strict.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" lang="en">
<head>
    <link rel="Shortcut Icon" href="<%=request.getContextPath()%>/asset/image/neu.jpg" type="image/x-icon">
    <%--引入jquery--%>
    <script type="text/javascript" src="<%=request.getContextPath()%>/asset/js/jquery-1.8.3.min.js"></script>
    <%--引入layer--%>
    <script type="text/javascript" src="<%=request.getContextPath()%>/asset/layer/layer.js"></script>
    <%--引入kindereditor--%>
    <link rel="stylesheet" href="<%=request.getContextPath()%>/asset/kindeditor-4.1.10/themes/default/default.css" />
    <link rel="stylesheet" href="<%=request.getContextPath()%>/asset/kindeditor-4.1.10/plugins/code/prettify.css" />
    <script charset="utf-8" src="<%=request.getContextPath()%>/asset/kindeditor-4.1.10/kindeditor.js"></script>
    <script charset="utf-8" src="<%=request.getContextPath()%>/asset/kindeditor-4.1.10/lang/zh_CN.js"></script>
    <script charset="utf-8" src="<%=request.getContextPath()%>/asset/kindeditor-4.1.10/plugins/code/prettify.js"></script>
    <%--引入公共JS--%>
    <script type="text/javascript" src="<%=request.getContextPath()%>/asset_admin_new/js/managecommon.js"></script>
    <script type="text/javascript" src="<%=request.getContextPath()%>/asset/kindeditor-4.1.10/KindeditorConfig.js"></script>
    <script type="text/javascript" src="<%=request.getContextPath()%>/asset/js/common.js"></script>
    <%--引入表单验证--%>
    <script type="text/javascript" src="<%=request.getContextPath()%>/asset_admin_new/js/Validform_v5.3.2.js"></script>
    <link rel="stylesheet" href="<%=request.getContextPath()%>/asset_admin_new/css/activity.css" />
    <link rel="stylesheet" href="<%=request.getContextPath()%>/asset_admin_new/css/style.css" />
    <link rel="stylesheet" href="<%=request.getContextPath()%>/asset_admin_new/css/demo.css" />
    <script type="text/javascript" src="<%=request.getContextPath()%>/asset/js/ajaxfileupload.js"></script>
    <!--兼容360浏览器，防止布局乱，设置IE的文档模式为最高版本，并且如果存在chrome插件，自动使用Webkit引擎-->
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
    <title>第二课堂教师管理界面</title>
    <script>
        var moduleType = GetQueryString("moduleType");//所属模块的ID
        //1、第一处修改，修改增删改的请求地址以及deleteId
        var addUrl = "/jsons/saveNotactivity.form";
        var editUrl = "/jsons/editNotactivity.form";
        var deleteUrl = "/jsons/deleteNotactivity.form";
        var editorName = "null";//KindEditor的Textarea的ID，如果没用到，赋值为null
        var imageUpload = "";//图片上传的标识，如果没有图片上传，赋值为空，如果有，赋值为数据库存放图片名称的字段名称，不带_
        var deleteId = "notid";//用于删除功能的ID参数，赋值为当前数据库表的ID
        var loadUrl = "/jsons/loadNotactivity.form";//注：此处为新增
        var sqlStr = "";//注：模糊查询
        var jsonPara;
        var editId="notid";
        $(function(){
            before_reload();
            $(".workLevle").hide();
            $(".organizationName").hide();
            $(".schoolworkName").hide();
            $(".classworkName").hide();
            $(".scienceClass").hide();
            $(".scienceName").hide();
            $(".shiptypeName").hide();
            $(".typeName").hide();
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
                $(".typeName").hide();
            }
            changeSelect();
        });
        function changeSelect(){
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
                    $(".typeName").hide();
                }
                if($(this).val()=="学术与科技类"){
                    $(".scienceClass").addClass("showed");
                    $(".scienceClass").slideDown(300);
                    $(".scienceName").addClass("showed");
                    $(".scienceName").slideDown(300);
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
                    $(".typeName").hide();
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
        }
        //before_reload :加载前rows和page参数处理
        function before_reload(){
            page= $(".currentPageNum").val();
            rows = $("#rows").val();
            if(page>(totalNum%rows==0?totalNum/rows:totalNum/rows+1)){//进行判断，避免选择rows时出现错误
                page = 1;$(".currentPageNum").val(1);
            }

            if(sqlStr==""||sqlStr==null){
                jsonPara={rows:rows,page:page};
            }else{
                jsonPara={rows:rows,page:page,sqlStr:sqlStr};
            }
            //   console.log(jsonPara);
            reload();
        }
        function reload_this(){
            window.location.reload();
        }
        function  reload() {//此处加载数据方法名不能修改，必须用reload
            load();
            $.ajax({
                url: loadUrl,
                type: "post",
                data:jsonPara,
                dataType: "json",
                success: function (data) {
//                    console.log(data);
                    $("tbody").html("");
                    if (data != null && data.rows != null && data.rows.length > 0) {
                        for (var i = 0; i < data.rows.length; i++) {
                            var row = data.rows[i];
                            for(var key in row){
                                if(row[key]==null||row[key]=="null"||row[key]=="NULL"){
                                    row[key]="";
                                }
                            }
                            var tr = '<tr id="tr'+(i+1)+'">'+
                                    '<td>'+(i+1)+'</td>'+
                                        //第二处修改：按照数据库列名进行拼穿
                                    '<td style="display:none">'+row.notid+'</td>'+
                                    '<td class="">'+row.notStudentId+'</td>'+
                                    '<td class=" ">'+row.studentName+'</td>'+
                                    '<td class=" ">'+row.notClass+'</td>'+
                                    '<td class=" " >'+row.workLevle+'</td>'+
                                    '<td class=" " >'+row.organizationName+'</td>'+
                                    '<td class=" " >'+row.schoolworkName+'</td>'+
                                    '<td class=" " >'+row.classworkName+'</td>'+
                                    '<td class=" " >'+row.scienceClass+'</td>'+
                                    '<td class=" " >'+row.scienceName+'</td>'+
                                    '<td class=" " >'+row.shiptypeName+'</td>'+
                                    '<td class=" " >'+row.createDate+'</td>'+
                                    '<td class=" " >'+row.auditStatus+'</td>'+
                                    '<td class=" " >'+row.auditStatusDate+'</td>'+
                                    '<td class=" " >'+row.auditStatusName+'</td>'
                            '</tr>';
                            $("tbody").append(tr);
                            $("#tr"+(i+1)).data(row);//存入data为后台修改时取数据
                        }

                        rowClick();//绑定行点击事件
                        totalNum=data.total;

                    }
                    paging();
                }, error: function () {
                    layer.msg("网络错误");
                }
            })
            disLoad();
        }

        //刷新按钮
        function refresh(){
            jsonPara={rows:10,page:1};
            reload();
        }
        //修改
        function Edits(){
            if(clickStatus=='true'){
                clickStatus='edit';
                postURL=editUrl;
//                console.log(rowdata[editId]);
                if(rowdata[editId]==null||rowdata[editId]==''){
                    layer.alert("请先选择一条数据");
                }else{
                    $("#typ").html("修改");
                    $('.popup').height($(document).height());
                    $('.popup').css('background-color', '#a1a1a1').slideDown(300);
                    $('.new').slideDown(400);
                }
                var databasephoto=rowdata.sciencePhoto;
                if(databasephoto!=null&&databasephoto!=""){
                    var photoes=databasephoto.split("|");
                    $("#user_photo").attr("src","/Files/Images/"+photoes[0]);
                    $("#index").text("当前第"+1+"张,");
                    $("#ids").text(photoes.length);
                    var i=0;
                    $("#userphoto_box").click(function(){
                        i++;
                        if(i==photoes.length){
                            i=0;
                        }
                        $("#user_photo").attr("src","/Files/Images/"+photoes[i]);
                        //          alert(photoes[i]);
                        $("#index").text("当前第"+(i+1)+"张,");
                    });
                }
                //  alert(photoes.length);
                $("#notStudentId").attr("disabled","disabled");
                $("#notClass").attr("disabled","disabled");
                $("#workLevle").attr("disabled","disabled");
                $("#organizationName").attr("disabled","disabled");
                $("#schoolworkName").attr("disabled","disabled");
                $("#classworkName").attr("disabled","disabled");
                $("#scienceClass").attr("disabled","disabled");
                $("#scienceName").attr("disabled","disabled");
                $("#shiptypeName").attr("disabled","disabled");
                $("#userphoto_box").show();
                if($("#notClass").val()=="社会工作类") {
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
                    $(".typeName").hide();
                }
            }else{
                layer.alert("请先选择一条数据");
            }
        }
        //新建
        function Adds(){
            postURL = addUrl;
            clickStatus = "add";
            //清空表单
            document.getElementById("Form").reset();
            $("#user_photo").attr("src","<%=request.getContextPath()%>/asset/image/default.jpg");
            $("#dlg").get(0).scrollTop=0;
            $("#userphoto_box").hide();
            $(".workLevle").hide();
            $(".organizationName").hide();
            $(".schoolworkName").hide();
            $(".classworkName").hide();
            $(".scienceClass").hide();
            $(".scienceName").hide();
            $(".shiptypeName").hide();
            $("#notStudentId").removeAttr("disabled");
            $("#notClass").removeAttr("disabled");
            $("#workLevle").removeAttr("disabled");
            $("#organizationName").removeAttr("disabled");
            $("#schoolworkName").removeAttr("disabled");
            $("#classworkName").removeAttr("disabled");
            $("#scienceClass").removeAttr("disabled");
            $("#scienceName").removeAttr("disabled");
            $("#shiptypeName").removeAttr("disabled");
            Add();
        }
        //保存
        function Saves(){
            if(demo.check()) {//表单验证
                var jsonObject = $("#Form").serializeObject();
                jsonObject["moduleType"] = moduleType;
                if(jsonObject["shiptypeName"]=="命名奖学金"){
                    jsonObject["shiptypeName"]=$("#typeName").val();
                }
                if(clickStatus=='edit'){
                    jsonObject[editId]=rowdata[editId];
                }
                load();
                UploadToDatabases(jsonObject);
            }else {
                layer.alert("请按照要求填写");
            }
        }
        //上传数据到数据库
        function UploadToDatabases(jsonObject) {
            $.ajax({
                url: postURL,
                type: "post",
                dataType: "json",
                data: jsonObject,
                success: function (data) {
                    disLoad();
                    isSelect='';
                    $("table tr").css('background-color','white');
                    if (data.result) {
                        close();
                        layer.alert("保存成功");
                        reload();
                    }
                    if (data.msg) {
                        layer.alert(data.msg);
                    }
                },
                error: function () {
                    disLoad();
                    layer.alert("服务器连接失败");
                }
            })
        }
        //下载模版文件
        function getModel(){
            window.open("/Files/ExcelModels/Notactivity_stu.xls");
        }
    </script>
        <style type="text/css">
            .new{
                position: absolute;
                /* top: 152px; */
                left: 200px;
                z-index: 100;
                width: 700px;
                height: 600px;
                border: 1px solid #197FFE;
                /* margin: 250px auto; */
                background-color: #FFFFFF;
                display: none;
            }
            *{
                margin:-1px;
                padding:0;
                border:0;
                font-family:"微软雅黑";
            }
        </style>
    <%--判断是否是登录状态--%>
    <%--<%@include file="../common/CheckLogin.jsp"%>--%>
</head>
<body>
<div class="stuMsgManage">
    <%--4、第三处修改，修改菜单按钮，选择哪些按钮需要--%>
    <!--功能栏-->
    <div class="function">
        <ul>
            <li >
                <select id="filter" name="filter"  style="width: 145px;height: 27px;border: 1px solid #1990fe;">
                    <option value="" selected>全部信息</option>
                    <option value="已通过">已通过</option>
                    <option value="未通过">未通过</option>
                    <option value="待处理">待处理</option>
                </select>
            </li>
            <li class="function_new" onclick="Adds()"><span>新建</span></li>
            <li class="function_edit" onclick="Edits()"><span>审核</span></li>
            <li class="function_remove" onclick="Delete()"><span>删除</span></li>
            <li class="function_import" onclick="batchInsert()"><span>导入活动信息</span></li>
            <li class="function_downModel" onclick="getModel()"><span>下载模版</span></li>
            <li class="function_refresh" onclick="reload_this()"><span>刷新当前页</span></li>
            <li class="function_inputSearch">
                <input type="text" placeholder="请输入学生姓名" id="searchVal" />
                <span id="search" onclick="Search()"></span>
            </li>
        </ul>
    </div>

    <!--结果集表格-->
    <div id="dg" class="table">
        <table border="0" cellspacing="0" cellpadding="0">
            <thead>
            <tr>
                <td></td>
                <td>学生学号</td>
                <td>学生姓名</td>
                <td>非活动类别</td>
                <td>社会工作级别</td>
                <td>工作组织名称</td>
                <td>学生处职务名称</td>
                <td>班级职务名称</td>
                <td>学术科技类别</td>
                <td>学术科技名称</td>
                <td>奖学金类别名字</td>
                <td>申请日期</td>
                <td>审核状态</td>
                <td>审核时间</td>
                <td>审核人</td>
            </tr>
            </thead>
            <tbody>

            </tbody>
        </table>
    </div>
    <!--分页-->
    <%@include file="paging.jsp"%>
</div>
<!--弹出框的层-->

<%--5、第四处修改，修改表单信息，与上面的列名称一致--%>
<div id="tb" class="popup"></div>
<!--新建/弹出窗口-->
<form id="Form" class="demoform" action=""><!--存在为了提交-->
    <div id="dlg" class="new">

        <div class="header">
            <span id="tpy"></span>
            <span type="reset" class="iconConcel"></span>
        </div>
        <ul>
            <div id="userphoto_box" style="height: 60px; width: 300px; float: right;margin-top:15px;">
                <img id="user_photo" src="<%=request.getContextPath()%>/asset/image/default.jpg" onerror="error=null;src='<%=request.getContextPath()%>/asset/image/default.jpg'" style="width: 240px;height: 150px;margin-right: 10px;">
                <span style="color:#E41D1D;">注：点击可以切换下一张,<span id="index"></span>共<span id="ids"></span>张</span>
            </div>
            <li>
                <span>学生的学号&nbsp;&nbsp;:&nbsp;&nbsp;&nbsp;&nbsp;</span>
                <input type="text" id="notStudentId" name="notStudentId"  class="combobox"  />
            </li>
            <li>
                <span>非活动类别&nbsp;&nbsp;:&nbsp;&nbsp;&nbsp;&nbsp;</span>
                <select id="notClass" name="notClass"   class="select">
                    <option value="">请选择</option>
                    <option value="社会工作类">社会工作类</option>
                    <option value="学术与科技类">学术与科技类</option>
                    <option value="奖学金类">奖学金类</option>
                </select>
            </li>
            <li class="workLevle">
                <span>工作的级别&nbsp;&nbsp;:&nbsp;&nbsp;&nbsp;&nbsp;</span>
                <select id="workLevle" name="workLevle" class="select">
                    <option value="">请选择</option>
                    <c:forEach items="${workLevles}" var="workLevle">
                        <option value="${workLevle.workLevle}">${workLevle.workLevle}</option>
                    </c:forEach>
                </select>
            </li>
            <li class="organizationName">
                <span>工作组织名&nbsp;&nbsp;:&nbsp;&nbsp;&nbsp;&nbsp;</span>
                <select id="organizationName" name="organizationName"   class="select">
                    <option value="">请选择</option>
                </select>
            </li>
            <li class="schoolworkName">
                <span>学生处职务&nbsp;&nbsp;:&nbsp;&nbsp;&nbsp;&nbsp;</span>
                <select id="schoolworkName" name="schoolworkName"   class="select">
                    <option value="">请选择</option>
                </select>
            </li>
            <li class="classworkName">
                <span>班级职务名&nbsp;&nbsp;:&nbsp;&nbsp;&nbsp;&nbsp;</span>
                <select id="classworkName" name="classworkName" class="select">
                    <option value="">请选择</option>
                    <c:forEach items="${classworkNames}" var="classworkName">
                        <option value="${classworkName.classworkName}">${classworkName.classworkName}</option>
                    </c:forEach>
                </select>
            </li>
            <li class="scienceClass">
                <span>学术科技类&nbsp;&nbsp;:&nbsp;&nbsp;&nbsp;&nbsp;</span>
                <select id="scienceClass" name="scienceClass" class="select">
                    <option value="">请选择</option>
                    <c:forEach items="${sciencetechnologys}" var="sciencetechnology">
                        <option value="${sciencetechnology.scienceClass}">${sciencetechnology.scienceClass}</option>
                    </c:forEach>
                </select>
            </li>
            <li class="scienceName">
                <span>学术科技名&nbsp;&nbsp;:&nbsp;&nbsp;&nbsp;&nbsp;</span>
                <input type="text" id="scienceName" name="scienceName"  class="combobox"   />
            </li>
            <li class="shiptypeName">
                <span>奖学金类别&nbsp;&nbsp;:&nbsp;&nbsp;&nbsp;&nbsp;</span>
                <select id="shiptypeName" name="shiptypeName" class="select">
                    <option value="">请选择</option>
                    <option value="学期奖学金">学期奖学金</option>
                    <option value="国家奖学金">国家奖学金</option>
                    <option value="命名奖学金">命名奖学金</option>
                </select>
            </li>
            <li class="typeName">
                <span>奖学金名称&nbsp;&nbsp;:&nbsp;&nbsp;&nbsp;&nbsp;</span>
                <input type="text" id="typeName" name="typeName"  class="combobox"   />
            </li>
            <li>
                <span>审核状态&nbsp;&nbsp;:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span>
                <select id="auditStatus" name="auditStatus" class="select">
                    <option value="已通过">已通过</option>
                    <option value="未通过">未通过</option>
                    <option value="待处理">待处理</option>
                </select>
            </li>
        </ul>
        <!--按钮窗口-->
        <div id="dlg-buttons" class="new_buttons">
            <input type="button" id="btn_sub" value="保存" onclick="Saves()" />
            <input class="iconConcel" type="reset" value="取消"   />
        </div>

    </div>
</form>
<%--批量导入对话框--%>
<div id="batch_dlg"  title="批量导入"  style="display:none;width:400px;height:380px;padding:10px;position:absolute;
    border:3px #c1dadb solid; left:35%;top:25%;background-color:#ffffff">
    <div id="file_box" style="margin-bottom: 10px;margin-top: 10px;">
        <label>选择文件:</label>
        <input id="upfile" style="display: inline-block;width: 200px;" name="fileup" type="file"/>
        <img style="float: right" src="../../../asset_font_new/img/windowclose_03.png" onclick="batchInsertClose()">
    </div>
    <div id="_box" style="margin-bottom: 10px;margin-top: 10px;">
        <label></label>
    </div>
    <div id="btn_box" style="margin-bottom: 10px;margin-top: 10px;">
        <label></label>
        <a href="javascript:void(0)"  onclick="validFile()">验证文件</a>&nbsp;&nbsp;&nbsp;&nbsp;
        <a href="javascript:void(0)"  onclick="uploadFile()">上传并导入</a>
    </div>
    <div id="result_box" style="margin-bottom: 10px;margin-top: 10px;">
        <label>操作结果:</label>
        <br>
        <label></label>
        <div id="valid_result"  style="display: inline-block;width: 400px;height: 250px;border: 2px solid #95B8E7;overflow: auto"></div>
    </div>
    <%--批量导入对话框的按钮--%>
    <div id="batch_dlg_buttons" >
        <a href="javascript:void(0)" style="margin-left: 370px" onclick="batchInsertClose()">关闭</a>
    </div>
</div>
<!--此js放在要提交表单的下面，放在上面偶尔失效-->
<script>
    //第五处修改，一般不用改，设置表单验证参数，tiptype4种, btnSubmit 提交按钮，ajax是结合我们公司提交方式
    demo = $(".demoform").Validform({
        tiptype:4,
        btnSubmit:"#btn_sub",
        ajaxPost:true

    });
</script>
</body>
</html>