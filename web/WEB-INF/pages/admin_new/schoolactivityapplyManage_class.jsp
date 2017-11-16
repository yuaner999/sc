<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: pjj
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
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
    <!--兼容360浏览器，防止布局乱，设置IE的文档模式为最高版本，并且如果存在chrome插件，自动使用Webkit引擎-->
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <!-- 导入页面控制js jq必须放最上面 -->
    <script type="text/javascript" src="<%=request.getContextPath()%>/asset_admin_new/js/jquery-1.11.1.min.js"></script>
    <script type="text/javascript" src="<%=request.getContextPath()%>/asset/js/laydate/laydate.js"></script>
    <script type="text/javascript" src="<%=request.getContextPath()%>/asset_admin_new/js/common_stuMsgManage.js"></script>
    <!-- 导入layer -->
    <script type="text/javascript" src="<%=request.getContextPath()%>/asset/layer/layer.js"></script>
    <!-- 导入样式css -->
    <link rel="stylesheet" href="<%=request.getContextPath()%>/asset_admin_new/css/StuMsgManage.css" />

    <%--引入公共JS--%>
    <script type="text/javascript" src="<%=request.getContextPath()%>/asset/js/common.js"></script>
    <script type="text/javascript" src="<%=request.getContextPath()%>/asset_admin_new/js/managecommon.js"></script>
    <%--引入图片上传--%>
    <script type="text/javascript" src="<%=request.getContextPath()%>/asset/js/ajaxfileupload.js"></script>
    <%--引入表单验证--%>
    <script type="text/javascript" src="<%=request.getContextPath()%>/asset_admin_new/js/Validform_v5.3.2.js"></script>
    <link rel="stylesheet" href="<%=request.getContextPath()%>/asset_admin_new/css/style.css" />
    <link rel="stylesheet" href="<%=request.getContextPath()%>/asset_admin_new/css/demo.css" />
    <%--引入本页自己的js--%>
    <script type="text/javascript" src="<%=request.getContextPath()%>/asset_admin_new/js/schoolactivityapplyManage.js"></script>
    <link rel="stylesheet" href="<%=request.getContextPath()%>/asset_admin_new/css/schoolactivityapplyManage.css" />
    <title>第二课堂教师管理界面</title>

    <script>
        var moduleType = GetQueryString("moduleType");//所属模块的ID
        //1、第一处修改，修改增删改的请求地址以及deleteId
        var addUrl = "/jsons/addSchoolActivityapplyStatus.form";
        var editUrl = "/jsons/editSchoolActivityapplyStatus.form";
        var deleteUrl = "/jsons/deleteSchoolActivityapplyStatus.form";
        var editorName = "null";//KindEditor的Textarea的ID，如果没用到，赋值为null
        var imageUpload = "null";//图片上传的标识，如果没有图片上传，赋值为空，如果有，赋值为数据库存放图片名称的字段名称，不带_
        var deleteId = "applyId";//用于删除功能的ID参数，赋值为当前数据库表的ID
        var editId ="applyId";
        var loadUrl = "/jsons/loadSchoolActivityapply.form";//注：此处为新增
        var sqlStr = "";//注：模糊查询
        var jsonPara;
        var jsonPara1={rows:rows,page:page};
        var activityId ;//选中活动的id
        var activityParticipation;//活动类型参数
        var rowdata1 ; //活动页参数；
        var jsonObject={};//综合查询参数 ,注意这里必须是个空{}不能是不定义的
        $(function(){
            $(".pagingTurn").eq(1).hide();
            loadActivity();
            $("#AwardName").hide();
            $("#activityAward").change(function(){
                if($("#activityAward").val()=="其它"){
                    $("#AwardName").show();
                }else {
                    $("#AwardName").hide();
                }
            });
            //  点击'综合条件查询'关闭查询条件
            $('#button1').click(function(){
                $(".searchContent").slideToggle(function(){
                    if ($(this).is(':hidden')) {
                        $(".messagePage").show();
                    }else {
                        $(".messagePage").hide();
                    }
                });
            });
            //综合查询条件：创建者
            $.ajax({
                url: "<%=request.getContextPath()%>/jsons/loadactivityCreator1.form",
                dataType: "json",
                success: function (data) {
                    var friends = $("#_activityCreator");
                    friends.empty();
                    friends.append("<option value=''>请选择</option>");
                    friends.append("<option value=''>全部</option>");
                    if(data.rows !=null && data.rows.length > 0){
                        for(var i=0;i<data.rows.length;i++) {
                            var option = $("<option>").text(data.rows[i].activityCreator).val(data.rows[i].activityCreator);
                            friends.append(option);
                        }
                    }else{
                        var option = $("<option>").text("无");
                        friends.append(option);
                    }
                }
            });
            //综合查询条件：负责人
            $.ajax({
                url: "<%=request.getContextPath()%>/jsons/loadactivityPrincipal.form",
                dataType: "json",
                success: function (data) {
                    var friends = $("#_principal");
                    friends.empty();
                    friends.append("<option value=''>请选择</option>");
                    friends.append("<option value=''>全部</option>");
                    if(data.rows !=null && data.rows.length > 0){
                        for(var i=0;i<data.rows.length;i++) {
                            var option = $("<option>").text(data.rows[i].principal).val(data.rows[i].principal);
                            friends.append(option);
                        }
                    }else{
                        var option = $("<option>").text("无");
                        friends.append(option);
                    }
                }
            });
            //综合查询条件：学院
            $.ajax({
                url: "<%=request.getContextPath()%>/jsons/loadstuCollageName.form",
                dataType: "json",
                data:{stuCollageName:''},
                success: function (data) {
                    var friends = $("#_stuCollageName");
                    friends.empty();
                    friends.append("<option value=''>请选择</option>");
                    friends.append("<option value=''>全部</option>");
                    if(data.rows !=null && data.rows.length > 0){
                        for(var i=0;i<data.rows.length;i++) {
                            var option = $("<option>").text(data.rows[i].stuCollageName).val(data.rows[i].stuCollageName);
                            friends.append(option);
                        }
                    }else{
                        var option = $("<option>").text("无");
                        friends.append(option);
                    }
                }
            });
            $("#_stuCollageName").change(function(){
                //综合查询条件：年级
                $.ajax({
                    url: "/jsons/loadstuGradeName.form",
                    dataType: "json",
                    data:{stuCollageName:$(this).val()},
                    success: function (data) {
                        var friends = $("#_stuGradeName");
                        friends.empty();
                        friends.append("<option value=''>请选择</option>");
                        friends.append("<option value=''>全部</option>");
                        if(data.rows !=null && data.rows.length > 0){
                            for(var i=0;i<data.rows.length;i++) {
                                var option = $("<option>").text(data.rows[i].stuGradeName).val(data.rows[i].stuGradeName);
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

        //before_reload :加载前rows和page参数处理
        function before_reload(){

            page= $("#pages").val();
            rows = $("#rows").val();

            if(page>(totalNum%rows==0?totalNum/rows:totalNum/rows+1)){//进行判断，避免选择rows时出现错误
                page = 1;$("#pages").val(1);
            }

            if(sqlStr==""||sqlStr==null){
                jsonPara={rows:rows,page:page,sqlActivityId:activityId};
            }else{
                jsonPara={rows:rows,page:page,sqlStr:sqlStr,sqlActivityId:activityId};
            }

            reload();
        }
        function before_loadActivity(){

//            console.log(jsonObject);
            page1= $("#page1").html();
            rows1 =10;
            jsonObject["rows"] = rows1 ;
            jsonObject["page"] = page1;
            jsonPara1=jsonObject;
//            console.log(jsonPara1);
//            if(page1>(totalNum1%rows1==0?totalNum/rows1:totalNum1/rows1+1)){//进行判断，避免选择rows时出现错误
//                page1 = 1;$("#page1").html(1);
//            }
//            console.log(page1 );
//            jsonPara1={rows:rows,page:page};
            loadActivity();
        }
        function  reload() {//此处加载数据方法名不能修改，必须用reload
            load();

            $.ajax({
                url: loadUrl,
                type: "post",
                data:jsonPara,
                dataType: "json",
                success: function (data) {
                    $("tbody").html("");
                    if (data != null && data.rows != null && data.rows.length > 0) {
                        for (var i = 0; i < data.rows.length; i++) {
                            var row = data.rows[i];
                            for(var key in row){
                                if(row[key]==null){
                                    row[key]='';
                                }
                            }
                            var tr = '<tr id="tr'+(i+1)+'">'+
                                    '<td>'+(i+1)+'</td>'+
                                        //第二处修改：按照数据库列名进行拼穿
                                    '<td class="fontStyle activityTitle " title="'+row.activityTitle+'">'+row.activityTitle+'</td>'+
                                    '<td class="applyStudentId ">'+row.applyStudentId+'</td>'+
                                    '<td class="studentName " title="'+row.studentName+'">'+row.studentName+'</td>'+
                                    '<td class="applyDate ">'+row.applyDate+'</td>'+
                                    '<td class="activityAwardMean ">'+row.activityAwardMean+'</td>'+
                                    '<td class="signUpStatus ">'+row.signUpStatus+'</td>'+
                                    '<td class="signUpTime ">'+row.signUpTime+'</td>'+
                                    '<td class="activityParticipation ">'+row.activityParticipation+'</td>'+
                                    '<td class="teamName " title="'+row.teamName+'">'+row.teamName+'</td>'+
                                    '</tr>';
                            $("tbody").append(tr);
                            $("#tr"+(i+1)).data(row);//存入data为后台修改时取数据
                        }
                        totalNum=data.total;
                        rowClick();//绑定行点击事件

                    }else{
                        page=0;
                        $(".currentPageNum").val('0');
                        totalNum=0;
                        $("#page1").val('1');
                    }

//                    console.log(totalNum);
                    paging0();
                    disLoad();
                }, error: function () {
                    layer.msg("网络错误");
                    disLoad();
                }
            })

        }
        //综合查询
        function select_box() {
            isCondition='true';
//            page1= $("#page1").html();
            jsonObject = $("#Form1").serializeObject();
//            jsonObject["rows"] = 10 ;
//            jsonObject["page"] = page1;
//            console.log(jsonObject);
//            jsonPara1=jsonObject;
            $('.searchContent').slideUp();
            before_loadActivity();
        }
        function clear_search(){
            document.getElementById("Form1").reset();
        }
        function refresh_reload(){
            isSelect='';
            clickStatus='';
            $(".currentPageNum").val(1);
            page=1;
            rows = $("#rows").val();
            if(isCondition=='true'){
                select_box(1);
            }else{
                jsonPara={rows:rows,page:page};
                reload();
            }
        }
        //前端加载活动
        function  loadActivity() {
            $(".messagePage").show();
            $(".pagingTurn").eq(1).show();
            load();
            $.ajax({
                url: "/jsons/loadSchoolActivity.form",
                type: "post",
                data:jsonPara1,
                dataType: "json",
                success: function (data) {
//                    console.log(data);
                    $("#tbody1").html("");
                    if (data != null && data.rows != null && data.rows.length > 0) {
                        for (var i = 0; i < data.rows.length; i++) {
                            var row = data.rows[i];
                            var tr = '<tr id="tr'+(i+1)+'">'+
                                    '<td>'+(i+1)+'</td>'+
                                        //第二处修改：按照数据库列名进行拼穿
                                    '<td class=" activityCreatedate ">'+row.activityCreatedate+'</td>'+
                                    '<td class="activityTitle " title="'+row.activityTitle+'">'+row.activityTitle+'</td>'+
                                    '<td class="activityLocation ">'+row.activityLocation+'</td>'+
                                    '<td class="activityParticipation ">'+row.activityParticipation+'</td>'+
                                    '<td class="activitySdate ">'+row.activitySdate+'</td>'+
                                    '<td class="activityEdate ">'+row.activityEdate+'</td>'+
                                    '<td class="activityId " style="display: none">'+row.activityId+'</td>'+
                                    '<td class="activityParticipation " style="display: none">'+row.activityParticipation+'</td>'+
                                    '</tr>';
                            $("#tbody1").append(tr);
                            $("#tr"+(i+1)).data(row);//存入data为后台修改时取数据
                        }

                        rowClick1();//绑定行点击事件
                        totalNum1=data.total;
                        paging1();
                    }else{
                        totalNum1=0;
                        $("#page1").html(0);
                        paging1();
                    }
                    disLoad();
                }, error: function () {
                    layer.msg("网络错误");
                    disLoad();
                }
            })

        }
        function class_Insert (){
            $.ajax({
                url:"/jsons/findActivityEnrollmentStatus.form",
                type:"post",
                data:{activityId:activityId},
                async:false,
                success:function(data){
                    if(data.rows[0].state == 'y'){
                        $("#class_dlg").show();
                    } else {
                        layer.msg("活动已截止报名",{offset:['30%'] });
                        return ;
                    }
                }
            })


        }
        function class_close(){
            $("#class_dlg").hide();
        }
        function applyClass(){
            var stuClassName=$("#stuClassName").val();
            if(activityParticipation=="团体"){
                layer.msg("团体活动申请请到团体报名管理申请。")
                return;
            }
            if(!activityId){
                layer.msg("请先选择活动。")
                return;
            }
            $.ajax({
                url: "/jsons/classApply.form",
                type: "post",
                data:{stuClassName:stuClassName,activityId:activityId},
                dataType: "json",
                success: function (data) {
                    if (data.result) {
                        class_close();
                        layer.alert("保存成功");
                        reload();
                    }
                    if (data.msg) {
                        class_close();
                        layer.alert(data.msg);
                    }
                }, error: function () {
                    class_close();
                    layer.msg("网络错误");
                }
            })
        }
        function selectbox_before(){
            $("#page1").html(1);
            select_box();
        }

        function Save1(){
            var applyStudentId=$("#applyStudentId").val();
            var activityAward=$("#activityAward").val();
            var applyActivityId=activityId;/*rowdata.activityId;*/
            var applyId=$("#applyId").val();
            if(activityAward=="其他"){
                activityAward=$("#AwardName").val();
            }
            $.ajax({
                url:"/jsons/loadstudentId.form",
                type:"post",
                dataType: "json",
                data:{student_id:applyStudentId},
                success: function (data) {
                    if (data == null || data.rows.length <= 0) {
                        layer.msg("学生不存在,请确认学号后添加！");
                        return false;
                    } else {
                        $.ajax({
                            url: "/jsons/loadT.form",
                            type: "post",
                            dataType: "json",
                            data: {student_id:applyStudentId,applyActivityId:applyActivityId},
                            success: function (data) {
                                if (data.rows.length > 0) {
                                    layer.msg("学生该项活动已经添加过！");
                                    return false;
                                }else{
                                    if (applyId) {
                                        URL = "/jsons/editSchoolActivityapplyStatus.form";
                                    } else {
                                        URL = "/jsons/addSchoolActivityapplyStatus.form";
                                    }
                                    $.ajax({
                                        url: URL,
                                        type: "post",
                                        dataType: "json",
                                        data: {
                                            applyActivityId: applyActivityId,
                                            applyStudentId: applyStudentId,
                                            activityAward: activityAward,
                                            applyId: applyId
                                        },
                                        success: function (data) {
                                            if (data.result) {
                                                close();
                                                layer.msg("操作成功！");
                                                reload();
                                            } else {
                                                layer.msg("操作失败！");
                                            }
                                        }
                                    });
                                }
                            }
                        });
                        $("#student_dlg").hide();
                        $(".popup").css({"z-index": "0"});
                    }
                }
            });
        }
    </script>
    <style type="text/css">
        .select {
            width: 246px;
            height: 36px;
            border: 1px solid #1990fe;
            margin-left: -3px;
        }
        .new {
            position: absolute;
            top: 63px;
            left: 200px;
            z-index: 100;
            width: 550px;
            height: 500px;
            border: 1px solid #197FFE;
            /* margin: 250px auto; */
            background-color: #FFFFFF;
            display: none;
        }
        table{
            border-collapse: collapse;
        }
        thead>td:first-of-type, tr>td:first-of-type {
            width: 60px;
        }
        .pagingTurn{
            padding-top: 7px !important;
        }
        #class_dlg,#batch_dlg{
            border-color: #1990fe !important;
            background: #fff !important;
            border-width: 2px !important;
        }
        #stuClassName{
            width:auto !important;
        }
        #class_buttons input{
            color: #fff;
            background: #1990fe;
            border:none;
            outline: none;
        }
        #class_buttons input:active,#batch_dlg_buttons a:active{
            background: #4daaff;
        }
        #batch_dlg_buttons{
            text-align: right;
        }
        #btn_box a{
            color: #1990fe;
        }
        #batch_dlg_buttons a{
            display: inline-block;
            padding: 0 10px;
            background: #1990fe;
            color: #fff;
            height: 21px;
            width:24px;
            text-align: center;
            line-height: 21px;
            margin-left: 0 !important;
        }
        .messagePage{
            height:auto!important;
            min-height: 0 !important;
            overflow: auto;
        }
        .searchselect {
            width: 162px;
            height: 28px;
            border: 1px solid #1990fe;
        }
        .searchContent>div>ul>li>input {
            border: 1px solid #1990fe;
            width: 155px;
            height: 19px;
            margin-left: 85px;
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
            <li class="function_new" onclick="Add1()"><span>新建</span></li>
            <%--<li class="function_edit" onclick="Edit1()"><span>颁奖</span></li>--%>
            <li class="function_remove" onclick="Delete1()"><span>删除</span></li>
            <li class="function_refresh" onclick="reSelect()"><span>重新加载活动</span></li>
            <li class="function_import" onclick="class_Insert()"><span>班级批量报名</span></li>
            <li class="function_import" onclick="before_batchInsert()"><span>导入信息</span></li>
            <li class="function_downModel" onclick="getModels()"><span>下载模版</span></li>
            <li class="function_refresh" onclick="reload_this()"><span>刷新当前页</span></li>
            <%--<li class="function_inputSearch">--%>
            <%--<input type="text" placeholder="请输入活动标题" id="searchVal" />--%>
            <%--<span id="search" onclick="Search1()"></span>--%>
            <%--</li>--%>
        </ul>
    </div>

    <!--结果集表格-->
    <div id="dg" class="table">
        <table border="0" cellspacing="0" cellpadding="0">
            <thead>
            <tr>
                <td></td>
                <td>活动标题</td>
                <td>学生学号</td>
                <td>学生姓名</td>
                <td>申请日期</td>
                <td>获奖情况</td>
                <td>签到状态</td>
                <td>签到时间</td>
                <td>参与形式</td>
                <td>团体名字</td>
            </tr>

            </thead>
            <tbody>

            </tbody>
        </table>
    </div>
    <!--分页-->
    <div class="pagingTurn">
        <div>
            <span class="turn_left" onclick="turn_left0()"></span> 第
            <input class="currentPageNum" id="pages" type="text" value="1">页，共
            <span class="pageNum"></span> 页
            <span class="turn_right" onclick="turn_right0()"></span>
        </div>
        <div>
            <select id="rows" name="rows" onchange="before_reload()">
                <option value="10" selected>10</option>
                <option value="20">20</option>
                <option value="50">50</option>
                <option value="100">100</option>
            </select>
        </div>

        <div>
            显示<span class="pageNum"></span>到<span class="pageNum"></span>，共<span class="pageNum"></span>条记录
        </div>
    </div>
</div>
<!--弹出框的层-->

<%--5、第四处修改，修改表单信息，与上面的列名称一致--%>
<div id="tb" class="popup"></div>
<!--新建/弹出窗口-->
<form id="Form" class="demoform" action=""><!--存在为了提交-->
    <div id="dlg" class="new">

        <div class="header">
            <span id="title">颁奖</span>
            <span type="reset" class="iconConcel"></span>
        </div>
        <ul>
            <%--<li>--%>
            <%--<span>活动ID&nbsp;&nbsp;:&nbsp;&nbsp;&nbsp;&nbsp;</span>--%>
            <%--<!--表单验证例子如下 -->--%>
            <%--<input type="text" id="applyActivityId" name="applyActivityId" style="display: none " />--%>
            <%--</li>--%>
            <li>
                <span>活动标题&nbsp;&nbsp;:&nbsp;&nbsp;&nbsp;&nbsp;</span>
                <!--表单验证例子如下 -->
                <input type="text" id="activityTitle" name="activityTitle" readonly="readonly"/>
            </li>

            <li>
                <span>学生学号&nbsp;&nbsp;:&nbsp;&nbsp;&nbsp;&nbsp;</span>
                <input type="text" id="applyStudentId" name="applyStudentId"/>
            </li>
            <%--<li>--%>
            <%--<span>审核状态&nbsp;&nbsp;:&nbsp;&nbsp;&nbsp;&nbsp;</span>--%>
            <%--<select id="applyAuditStatus" name="applyAuditStatus" class="select">--%>
            <%--<option selected="selected" value="">请选择</option>--%>
            <%--<option>已通过</option>--%>
            <%--<option>未通过</option>--%>
            <%--<option>待处理</option>--%>
            <%--</select>--%>
            <%--</li>--%>
            <%--<li>--%>
                <%--<span>获奖情况&nbsp;&nbsp;:&nbsp;&nbsp;&nbsp;&nbsp;</span>--%>
                <%--<select  name="activityAward" id="activityAward" class="select">--%>
                    <%--<option selected="selected" value="">请选择</option>--%>
                    <%--<option value="一等奖">一等奖</option>--%>
                    <%--<option value="二等奖">二等奖</option>--%>
                    <%--<option value="三等奖">三等奖</option>--%>
                    <%--<option value="其它">其它</option>--%>
                <%--</select>--%>
            <%--</li>--%>
            <%--<li id="AwardName">--%>
                <%--<span>其他奖项&nbsp;&nbsp;:&nbsp;&nbsp;&nbsp;&nbsp;</span>--%>
                <%--<input type="text" id="otherAward"   />--%>
            <%--</li>--%>
        </ul>
        <input type="hidden" id="applyId"/>
        <!--按钮窗口-->
        <div id="dlg-buttons" class="new_buttons">
            <input type="button" id="btn_sub" value="保存" onclick="Save1()" />
            <input type="reset" value="取消" onclick="close()" />
        </div>
        <div id="dlg-buttons1" class="new_buttons">
            <input type="button" id="btn_sub1" value="保存" onclick="Save11()" />
            <input type="reset" value="取消" onclick="close()" />
        </div>
    </div>
</form>
<!--此js放在要提交表单的下面，放在上面偶尔失效-->
<%--<script>--%>
<%--//第五处修改，一般不用改，设置表单验证参数，tiptype4种, btnSubmit 提交按钮，ajax是结合我们公司提交方式--%>
<%--demo = $(".demoform").Validform({--%>
<%--tiptype:4,--%>
<%--btnSubmit:"#btn_sub",--%>
<%--ajaxPost:true--%>

<%--});--%>
<%--</script>--%>
<!--重新加载活动方法-->
<div id="dialog" class="dialog">
    <div class="header">
        <span class="title_1" >&nbsp;&nbsp;<p>活动选择界面</p><img src="../../../asset_font_new/img/windowclose_03.png"></span>

    </div>
    <!--功能栏-->
    <div class="function">
        <ul>
            <li style="background: url(/asset_admin_new/img/icon_synsearch.png) no-repeat;background-position: 0px 2px;" id="button1">
                <span >综合条件查询</span>
            </li>
        </ul>
    </div>
    <!--综合查询部分-->
    <form id="Form1"   method="post">
        <div class="searchContent">
            <div>
                <ul>
                    <li>
                        <span>活动标题:</span>
                        <input type="text" id="_activityTitle"  name="activityTitle" />
                    </li>
                    <li>
                        <span>活动类别:</span>
                        <div>
                            <select id="_activityClass" name="activityClass" class="searchselect">
                                <option value="" >请选择</option>
                                <option value="" >全部</option>
                                <option value="1">思想政治教育类</option>
                                <option value="2">能力素质拓展类</option>
                                <option value="3">学术科技与创新创业类</option>
                                <option value="4">社会实践与志愿服务类</option>
                                <option value="5">社会工作与技能培训类</option>
                                <option value="6">其他类</option>
                            </select>
                        </div>
                    </li>
                    <li>
                        <span>活动性质:</span>
                        <div>
                            <select id="_activityNature" name="activityNature" class="searchselect">
                                <option value="" >请选择</option>
                                <option value="" >全部</option>
                                <option value="1">活动参与</option>
                                <option value="2">讲座报告</option>
                                <option value="3">比赛</option>
                                <option value="4">培训</option>
                            </select>
                        </div>
                    </li>
                    <li>
                        <span>活动级别:</span>
                        <div>
                            <select id="_activityLevle" name="activityLevle" class="searchselect">
                                <option value="" >请选择</option>
                                <option value="" >全部</option>
                                <option value="0">国际级</option>
                                <option value="1">国家级</option>
                                <option value="2">省级</option>
                                <option value="3">市级</option>
                                <option value="4">校级</option>
                                <option value="5">院级</option>
                                <option value="6">团支部级</option>
                            </select>
                        </div>
                    </li>
                    <li>
                        <span>参与形式:</span>
                        <div>
                            <select id="_activityParticipation" name="activityParticipation" class="searchselect">
                                <option value="" >请选择</option>
                                <option value="" >全部</option>
                                <option value="不限">不限</option>
                                <option value="个人">个人</option>
                                <option value="团体">团体</option>
                            </select>
                        </div>
                    </li>
                </ul>
                <ul>
                    <li>
                        <span>活动开始时间:</span>
                        <input onclick="laydate()" id="_activitySdate" name="activitySdate"  type="text"/>
                    </li>
                    <li>
                        <span>活动结束时间:</span>
                        <input  onclick="laydate()" id="_activityEdate" name="activityEdate" type="text"/>
                    </li>
                    <li>
                        <span>创建人:</span>
                        <div>
                            <select id="_activityCreator" name="activityCreator" class="searchselect">
                                <option value="" >请选择</option>
                                <option value="" >全部</option>

                            </select>
                        </div>
                    </li>
                    <li>
                        <span>负责人;</span>
                        <div>
                            <select id="_principal" name="principal" class="searchselect">
                                <option value="" >请选择</option>
                                <option value="" >全部</option>
                            </select>
                        </div>
                    </li>
                    <li>
                        <span>能力标签:</span>
                        <div>
                            <select id="_activityPowers" name="activityPowers" class="searchselect">
                                <option value="" >请选择</option>
                                <option value="" >全部</option>
                                <option value="思辨能力">思辨能力</option>
                                <option value="执行能力">执行能力</option>
                                <option value="表达能力">表达能力</option>
                                <option value="领导能力">领导能力</option>
                                <option value="创新能力">创新能力</option>
                                <option value="创业能力">创业能力</option>
                            </select>
                        </div>
                    </li>
                </ul>
                <ul>
                    <li>
                        <span>创建时间:</span>
                        <input  onclick="laydate()" id="_activityCreatedate" name="activityCreatedate" type="text"/>
                    </li>
                    <%--<li>--%>
                        <%--<span>所在学院:</span>--%>
                        <%--<div>--%>
                            <%--<select id="_stuCollageName" name="stuCollageName" class="searchselect">--%>
                                <%--<option value="" >请选择</option>--%>
                                <%--<option value="" >全部</option>--%>

                            <%--</select>--%>
                        <%--</div>--%>
                    <%--</li>--%>
                    <%--<li>--%>
                        <%--<span>所在年级:</span>--%>
                        <%--<div>--%>
                            <%--<select id="_stuGradeName" name="stuGradeName" class="searchselect">--%>
                                <%--<option value="" >请选择</option>--%>
                                <%--<option value="" >全部</option>--%>

                            <%--</select>--%>
                        <%--</div>--%>
                    <%--</li>--%>
                    <li>
                        <span>能否线上报名:</span>
                        <div>
                            <select id="_online" name="online" class="searchselect">
                                <option value="" >请选择</option>
                                <option value="" >全部</option>
                                <option value="0">可以</option>
                                <option value="1">不可以</option>
                            </select>
                        </div>
                    </li>
                    <li>
                        <span>活动学分:</span>
                        <input type="text" id="_activityCredit"  name="activityCredit"/>
                    </li>
                </ul>
            </div>
            <p></p>
            <div class="buttons">
                <span class="clearAll" onclick="clear_search()">清空</span>
                <span class="search" onclick="selectbox_before()">搜索</span>
            </div>
        </div>
    </form>
    <div class="messagePage table">
        <table>
            <thead>
            <tr>
                <td></td>
                <td>活动创建时间</td>
                <td>活动标题</td>
                <td>活动地点</td>
                <td>参与形式</td>
                <td>活动起始时间</td>
                <td>活动截止时间</td>

            </tr>

            </thead>
            <tbody id="tbody1">

            </tbody>

        </table>
        <div class="pagingTurn">
            <div>
                <span class="turn_left" onclick="turn_left1()"></span> 第
                <span id="page1" class="currentPageNum" value="1">1</span> 页，共
                <span id="p0" class="pageNum1" >1</span> 页
                <span class="turn_right" onclick="turn_right1()"></span>
            </div>
            <div>
                显示<span id="p1" class="pageNum1"></span>到<span id="p2" class="pageNum1"></span>，共<span id="p3" class="pageNum1"></span>条记录
            </div>
        </div>
    </div>

    <!--按钮窗口-->
    <div class="new_buttons">
        <input type="button"  value="确定" onclick="commit()"  />
        <input type="button" value="取消" onclick="close2()" />
    </div>
</div>
<%--批量导入对话框--%>
<div id="batch_dlg"  title="批量导入"  style="display:none;width:400px;height:380px;padding:10px;position:absolute;
    border:3px #c1dadb solid; left:35%;top:25%;background-color:#ffffff">
    <div id="file_box" style="margin-bottom: 10px;margin-top: 10px;">
        <label>选择文件:</label>
        <input id="upfile" style="display: inline-block;width: 200px;" name="fileup" type="file"/>
        <img style="float: right;position:absolute;top:15px;right:15px" src="../../../asset_font_new/img/windowclose_03.png" onclick="batchInsertClose()">
    </div>
    <div id="_box" style="margin-bottom: 10px;margin-top: 10px;">
        <label></label>
    </div>
    <div id="btn_box" style="margin-bottom: 10px;margin-top: 10px;">
        <label></label>
        <a href="javascript:void(0)"  onclick="validFile()">验证文件</a>&nbsp;&nbsp;&nbsp;&nbsp;
        <a href="javascript:void(0)"  onclick="uploadActivityFile()">上传并导入</a>
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
<%--选择班级批量导入报名--%>
<div id="class_dlg"  title="批量导入"  style="width: 338px; height: 134px;padding: 20px;position: absolute; border: 3px solid rgb(193, 218, 219); left: 35%;
top: 13%;background-color: rgb(255, 255, 255);display: none;">
    <div id="class_box" style="margin-bottom: 10px;margin-top: 10px;">
        <span style="color: #1990fe;">选择班级&nbsp;&nbsp;:&nbsp;&nbsp;&nbsp;&nbsp;</span>
        <img style="float: right;position:absolute;top:15px;right:15px" src="../../../asset_font_new/img/windowclose_03.png" onclick="class_close()">
        <input type="text" disabled="disabled" id="stuClassName" value="${classId}">
        <%--<select id="stuClassName" name="stuClassName"  style="width: 160px;height: 33px; border: 1px solid #1990fe;">--%>
            <%--<c:forEach items="${classdata}" var="classes">--%>
                <%--<option value="${classes.stuClassName}">${classes.stuClassName}</option>--%>
            <%--</c:forEach>--%>
        <%--</select>--%>
    </div>
    <!--按钮窗口-->
    <div id="class_buttons" class="new_buttons">
        <input type="button" id="class_sub" value="确认"  style="margin-left: 72px;margin-top: 50px;width: 50px;" onclick="applyClass()" />
        <input type="button" value="取消"  style="margin-left: 48px;margin-top: 50px;width: 50px;" onclick="class_close()" />
    </div>
</div>
<script>
    $(".title_1 img").click(function () {
        $(this).parent().parent().parent().hide(200);
        $('.popup').slideUp(200);
        $(document.body).css({
            "overflow-x":"auto",
            "overflow-y":"auto"
        });
    });
</script>
</body>
</html>