<%--
  Created by IntelliJ IDEA.
  User: gq
  Date: 2017/2/23
  Time: 11:00
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<html>
<head>
    <!-- 导入页面控制js jq必须放最上面 -->
    <link rel="Shortcut Icon" href="<%=request.getContextPath()%>/asset/image/neu.jpg" type="image/x-icon">
    <script type="text/javascript" src="<%=request.getContextPath()%>/asset/js/jquery-1.8.3.min.js"></script>
    <script type="text/javascript" src="<%=request.getContextPath()%>/asset_admin_new/js/common_stuMsgManage.js"></script>
    <!-- 导入layer -->
    <script type="text/javascript" src="<%=request.getContextPath()%>/asset/layer/layer.js"></script>
    <!-- 导入样式css -->
    <link rel="stylesheet" href="<%=request.getContextPath()%>/asset_admin_new/css/StuMsgManage.css" />
    <link rel="stylesheet" href="<%=request.getContextPath()%>/asset_admin_new/css/printManage.css" />
    <%--引入公共JS--%>
    <script type="text/javascript" src="<%=request.getContextPath()%>/asset/js/common.js"></script>
    <script type="text/javascript" src="<%=request.getContextPath()%>/asset_admin_new/js/managecommon.js"></script>
    <%--引入表单验证--%>
    <script type="text/javascript" src="<%=request.getContextPath()%>/asset_admin_new/js/Validform_v5.3.2.js"></script>
    <link rel="stylesheet" href="<%=request.getContextPath()%>/asset_admin_new/css/style.css" />
    <link rel="stylesheet" href="<%=request.getContextPath()%>/asset_admin_new/css/demo.css" />
    <%--引入本页自己的js--%>
    <script type="text/javascript" src="<%=request.getContextPath()%>/asset_admin_new/js/printManage.js"></script>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
    <!--兼容360浏览器，防止布局乱，设置IE的文档模式为最高版本，并且如果存在chrome插件，自动使用Webkit引擎-->
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <title>活动结果审核管理</title>
    <script type="text/javascript">
        var moduleType = GetQueryString("moduleType");//所属模块的ID，不可以删除
        //1、第一处修改，修改增删改的请求地址
        var addUrl = "";
        var editUrl = "";
        var deleteUrl = "";
        var editorName = "null";//KindEditor的Textarea的ID，如果没用到，赋值为null
        var imageUpload = "";//图片上传的标识，如果没有图片上传，赋值为空，如果有，赋值为数据库存放图片名称的字段名称，不带_
        var deleteId = "";//用于删除功能的ID参数，赋值为当前数据库表的ID
        var editId = "";//用于修改功能的ID参数，赋值为当前数据库表的ID
        var loadUrl = "/jsons/loadCheckStudentNum.form";//注：此处为新增
        var sqlStr = "";//注：模糊查询
        var jsonPara;//参数
        var statusLevel="";
        $(function(){
            before_reload();
            $("#submitAll").change(function(){
                if($(this).is(":checked")){
                    $(".checkes").attr("checked",true);
                }else {
                    $(".checkes").attr("checked",false);
                }
            })
            //绑定跳页Enter键
            $(".currentPageNum").keyup(function(e){
                var pagNum = $(".currentPageNum").val();
                if(e.keyCode==13){
                    select_box(pagNum);
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
                //综合查询条件：专业
                $.ajax({
                    url:"<%=request.getContextPath()%>/jsons/loadstuMajorName.form",
                    dataType:"json",
                    data:{stuCollageName:$(this).val()},
                    success:function(data){
                        var friends = $("#_stuMajorName");
                        friends.empty();
                        friends.append("<option value=''>请选择</option>");
                        friends.append("<option value=''>全部</option>");
                        if(data.rows !=null && data.rows.length > 0){
                            for(var i=0;i<data.rows.length;i++) {
                                var option = $("<option>").text(data.rows[i].stuMajorName).val(data.rows[i].stuMajorName);
                                friends.append(option);
                            }
                        }else{
                            var option = $("<option>").text("无");
                            friends.append(option);
                        }
                    }
                });
            })
            $("#_stuMajorName").change(function(){
                //综合查询条件：年级
                $.ajax({
                    url: "<%=request.getContextPath()%>/jsons/loadstuGradeName.form",
                    dataType: "json",
                    data:{stuMajorName:$(this).val()},
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
            $("#_stuGradeName").change(function(){
                //z综合查询条件：班级
                $.ajax({
                    url: '<%=request.getContextPath()%>/jsons/loadclassnames1.form',
                    dataType: "json",
                    data:{stuGradeName:$(this).val(),collegename:$("#_stuCollageName").val(),stuMajorName:$("#_stuMajorName").val()},
                    success: function (data) {
                        var friends = $("#_stuClassName");
                        friends.empty();
                        friends.append("<option value=''>请选择</option>");
                        friends.append("<option value=''>全部</option>");
                        if(data.rows !=null && data.rows.length > 0){
                            for(var i=0;i<data.rows.length;i++) {
                                var option = $("<option>").text(data.rows[i].stuClassName).val(data.rows[i].stuClassName);
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

            page= $(".currentPageNum").val();
            rows = $("#rows").val();
            jsonPara={rows:rows,page:page};
            reload();
        }
        //综合查询
        function select_box(page) {
            var jsonObject = $("#Form1").serializeObject();
            jsonObject["rows"] = $("#rows").val() ;

            if(Math.ceil(totalNum/$("#rows").val())<page){
                page=Math.ceil(totalNum/$("#rows").val());
            }
            if(page<=0){
                page=1;
            }
            jsonObject["page"] = page;
            $(".currentPageNum").val(page);
            jsonPara=jsonObject;
            $('.searchContent').slideUp();
            reload();
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
                                if(!row[key] || row[key]=="null"){
                                    row[key]="";
                                }
                            }
                            var tr = '<tr id="tr'+(i+1)+'">'+
                                    '<td>'+ '<input name="test" class="checkes" type="checkbox" id="submint'+i+'" style="width:18px;height: 20px;" />'+'</td>'+
                                        //第二处修改：按照数据库列名进行拼穿
                                    '<td title="'+row.activityTitle+'">'+row.activityTitle+'</td>'+
                                    '<td style="display:none">'+row.applyStudentId+'</td>'+
                                    '<td class="studentName" title="'+row.studentName+'">'+row.studentName+'</td>'+
                                    '<td class="applyTeamId" style="display:none">'+row.applyTeamId+'</td>'+
//                                    '<td class="teamName" title="'+row.teamName+'">'+row.teamName+'</td>'+
//                                    '<td class="activitypoint">'+row.activitypoint+'</td>'+
                                    '<td class="activityAward" title="'+row.activityAward+'">'+row.activityAward+'</td>'+
                                    '<td class="regimentAuditStatus">'+row.regimentAuditStatus+'</td>'+
//                                    '<td class="regimentAuditStatusDate">'+DateFormat(row.regimentAuditStatusDate)+'</td>'+
                                    '<td class="collegeAuditStatus"  >'+row.collegeAuditStatus+'</td>'+
                                    '<td class="collegeAuditStatusDate"  style="display:none">'+row.collegeAuditStatusDate+'</td>'+
                                    '<td class="schoolAuditStaus"  >'+row.schoolAuditStaus+'</td>'+
                                    '<td class="schoolAuditStausDate" style="display:none" >'+row.schoolAuditStausDate+'</td>'+
                                    '</tr>';
                            tr=tr.replace(/undefined/g,"");
                            $("tbody").append(tr);
                            $("#tr"+(i+1)).data(row);//存入data为后台修改时取数据
                        }
                        //                       rowClick();//绑定行点击事件
                        totalNum=data.total;

                    }else{
                        totalNum=0;
                    }
                    paging();
                    disLoad();
                }, error: function () {
                    layer.msg("网络错误");
                    disLoad();
                }
            });

        }
        function auditsAction(statusLevel,type){
            /**
             * 取出选中的数据
             */
            var applyId="";
            var regimentAuditStatuses="";
            var collegeAuditStatuses="";
            var schoolAuditStauses="";
            var applyStudentId="";
            var totalNum=0;
            $('tbody input:checkbox:checked').each(function() {
                var row=$(this).parent().parent().data();
                applyStudentId+=row.applyStudentId+"|";
                applyId+=row.applyId+"|";
                regimentAuditStatuses+=row.regimentAuditStatus+"|";
                collegeAuditStatuses+=row.collegeAuditStatus+"|";
                schoolAuditStauses+=row.schoolAuditStaus+"|";
                totalNum+=1;
            });
            if(applyStudentId==""){
                layer.msg("请选择一行数据");
                return;
            }
            //验证重复审核
            if (regimentAuditStatuses.indexOf("未通过") >= 0 ) {
                layer.msg("操作失败,包含有班级审核结果为'未通过的数据");
                return;
            }
            if(statusLevel=='class'){
                if(regimentAuditStatuses.indexOf("已通过")>=0){
                    layer.msg("操作失败,包含有班级审核结果为'已通过'的数据");
                    return;
                }
            }
            if(statusLevel=="college") {
                if(regimentAuditStatuses.indexOf("待审核")>=0){
                    layer.msg("操作失败,包含有班级未审核数据");
                    return;
                }
                if (collegeAuditStatuses.indexOf("未通过") >= 0 ) {
                    layer.msg("操作失败,包含有学院审核结果为'未通过'的数据，不能重复审核");
                    return;
                }
                if (collegeAuditStatuses.indexOf("已通过") >= 0  ) {
                    layer.msg("操作失败,包含有学院审核结果为'已通过'的数据，不能重复审核");
                    return;
                }
            }
            if(statusLevel=="school"){
                if(regimentAuditStatuses.indexOf("待审核")>=0){
                    layer.msg("操作失败,包含有班级未审核数据");
                    return;
                }
                if (collegeAuditStatuses.indexOf("未通过") >= 0 ) {
                    layer.msg("操作失败,包含有学院审核结果为'未通过'的数据");
                    return;
                }
                if (collegeAuditStatuses.indexOf("待审核") >= 0) {
                    layer.msg("操作失败,包含有学院未审核数据");
                    return;
                }
                if (schoolAuditStauses.indexOf("已通过")>=0) {
                    layer.msg("操作失败,包含有学校审核结果为'已通过'的数据，不能重复审核");
                    return;
                }
                if (schoolAuditStauses.indexOf("未通过")>=0) {
                    layer.msg("操作失败,包含有学校审核结果为'未通过'的数据，不能重复审核");
                    return;
                }
            }
            layer.confirm("确认此操作吗？！！！",function(result){
                if (result){
                    $.ajax({
                        url: "/check/superAuditApply.form",
                        type: "post",
                        data: {
                            applyId: applyId.substring(0, applyId.length - 1),
                            type: type,status:statusLevel},
                        dataType: "json",
                        success: function (data) {
                            if (data) {
                                layer.msg(data.msg);
                                $("#submitAll").attr("checked", false);
                                select_box(1);
                            }
                        }, error: function () {
                            layer.msg("网络错误");
                        }
                    })
                }
            });
        }

        //清空
        function clear_search(){
            //清空表单
            document.getElementById("Form1").reset();
        }
        //审核
        function superAuditsAction(val){
            $("#clas").hide();
            $("#coll").hide();
            $("#scho").hide();
            $("#back").show();
            $("#yes").show();
            $("#no").show();
            statusLevel=val;
        }
        //返回
        function backtoload(){
            $("#clas").show();
            $("#coll").show();
            $("#scho").show();
            $("#back").hide();
            $("#yes").hide();
            $("#no").hide();
            statusLevel='';
            select_box(1);
        }
        //审核
        function audit(value){
            auditsAction(statusLevel,value);
        }
    </script>
    <style>
        #dlg{
            left: 50% !important;
            margin-left: -320px;
            min-width: 600px !important;
            width:600px;
        }
        .new>ul{
            padding: 20px !important;
        }
        .new {
            position: absolute;
            top: 33px;
            left: 50% !important;
            margin-left: -376px;
            height:auto !important;
            z-index: 100;
            max-width: 1024px;
            min-width: 457px;
            width: 750px;
            border: 1px solid #197FFE;
            /* margin: 250px auto; */
            background-color: #FFFFFF;
            display: none;
            min-height: 423px;
            margin-bottom: 40px;
        }
        .btnbox{
            overflow: hidden;
            padding-bottom: 30px;
        }
        .btnbox li{
            float: left;
            margin-left: 150px;
            cursor: pointer;
        }
        #supPhotos{
            margin-top: 22px;
        }
        .sure{
            border: 1px solid;
            width: 70px;
            height: 20px;
            text-align: center;
            line-height: 20px;
            border-radius: 6px;
        }
        .input{
            width: 238px;
            height: 29px;
            border: 1px solid #1990fe;
            margin-left: 20px;
        }
        .select {
            width: 162px;
            height: 28px;
            border: 1px solid #1990fe;
        }
        .searchContent>div>ul>li>div>span {
            display: inline-block;
            position: absolute;
            z-index: 10;
            right: 0;
            top: 0;
            width: 30px;
            height: 25px;
        }
        .searchContent>div{
            position: relative;
            margin: 0px 25px;
            min-width: 600px;
            padding: 35px 10px 13px 10px;
            border-bottom: 2px solid #fff799;
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
            <li class="function_search"><span>综合条件查询</span></li>
            <li id="clas" class="function_new function_auditPass" onclick="superAuditsAction('class')" style="background-color: #1990fe !important"><span>班级审核</span></li>
            <li id="coll" class="function_new function_auditPass" onclick="superAuditsAction('college')" style="background-color: #1990fe !important"><span>学院审核</span></li>
            <li id="scho" class="function_new function_auditPass" onclick="superAuditsAction('school')" style="background-color: #1990fe !important"><span>学校审核</span></li>
            <li id="back" class="function_new function_auditPass" onclick="backtoload()" style="display: none;background-color: #1990fe !important"><span>返回</span></li>
            <li id="yes" class="function_new function_auditPass" onclick="audit('已通过')"  style="display: none"><span>审核通过</span></li>
            <li id="no" class="function_edit function_auditNotPass" onclick="audit('未通过')"  style="display: none"><span>审核不通过</span></li>
        </ul>
    </div>
        <form id="Form1" >
            <div class="searchContent">
                <div>
                    <ul>
                        <li>
                            <span>活动标题:</span>
                            <input type="text" id="_activityTitle"  name="activityTitle"/>
                        </li>
                        <li>
                            <span>学号:</span>
                            <input type="text" id="_studentID" name="studentId" />
                        </li>
                        <li>
                            <span>学生姓名:</span>
                            <input type="text" id="_studentName" name="studentName" />
                        </li>
                        <li>
                            <span>学校审核状态:</span>
                            <div>
                                <select id="_regimentAuditStatus" name="schoolAuditStatus" class="select">
                                    <option value="" >请选择</option>
                                    <option value="" >全部</option>
                                    <option value="待审核">待审核</option>
                                    <option value="未通过">未通过</option>
                                    <option value="已通过">已通过</option>
                                    <option value="修改">修改</option>
                                </select>
                            </div>
                        </li>
                    </ul>
                    <ul>
                        <li>
                            <span>所在学院:</span>
                            <div>
                                <select id="_stuCollageName" name="stuCollageName" class="select">
                                    <option value="" >请选择</option>
                                    <option value="" >全部</option>
                                </select>
                            </div>
                        </li>
                        <li>
                            <span>所在专业:</span>
                            <div>
                                <select id="_stuMajorName" name="stuMajorName" class="select">
                                    <option value="" >请选择</option>
                                    <option value="" >全部</option>
                                </select>
                            </div>
                        </li>
                        <li>
                            <span>所在年级:</span>
                            <div>
                                <select id="_stuGradeName" name="stuGradeName" class="select">
                                    <option value="" >请选择</option>
                                    <option value="" >全部</option>
                                </select>
                            </div>
                        </li>
                        <li>
                            <span>所在班级:</span>
                            <div>
                                <select id="_stuClassName" name="stuClassName" class="select">
                                    <option value="" >请选择</option>
                                    <option value="" >全部</option>
                                </select>
                            </div>
                        </li>
                    </ul>
                </div>
                <p></p>
                <div class="buttons">
                    <span class="clearAll" onclick="clear_search()">清空</span>
                    <span class="search" onclick="select_box(1)">搜索</span>
                </div>
            </div>
        </form>
    <!--结果集表格-->
    <div id="dg" class="table">
        <table border="0" cellspacing="0" cellpadding="0">
            <thead>
            <tr>
                <td><input name="test" type="checkbox" id="submitAll" style="width: 18px; height: 20px;" /></td>
                <td>活动标题</td>
                <td>学生姓名</td>
                <td>所获奖项</td>
                <td>团支部</td>
                <td>学院团委</td>
                <td>校团委</td>
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

</body>
</html>
