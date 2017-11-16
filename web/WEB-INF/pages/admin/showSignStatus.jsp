<%@ page import="java.util.Date" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.Calendar" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: admin
  Date: 2016/5/9
  Time: 11:37
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java"  pageEncoding="UTF-8" %>
<html>
<head>
    <title></title>
    <%--引入EasyUi--%>
    <link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/asset/easyui/themes/default/easyui.css">
    <link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/asset/easyui/themes/icon.css">
    <script type="text/javascript" src="<%=request.getContextPath()%>/asset/js/jquery-1.8.3.min.js"></script>
    <script type="text/javascript" src="<%=request.getContextPath()%>/asset/easyui/jquery.easyui.min.js"></script>
    <script type="text/javascript" src="<%=request.getContextPath()%>/asset/easyui/locale/easyui-lang-zh_CN.js"></script>
    <script type="text/javascript" src="<%=request.getContextPath()%>/asset/js/manage/massage-helper.js"></script>
    <script type="text/javascript" src="<%=request.getContextPath()%>/asset/js/studentManager.js"></script>
    <%--引入kindereditor--%>
    <link rel="stylesheet" href="<%=request.getContextPath()%>/asset/kindeditor-4.1.10/themes/default/default.css" />
    <script charset="utf-8" src="<%=request.getContextPath()%>/asset/kindeditor-4.1.10/kindeditor.js"></script>
    <script charset="utf-8" src="<%=request.getContextPath()%>/asset/kindeditor-4.1.10/lang/zh_CN.js"></script>
    <script charset="utf-8" src="<%=request.getContextPath()%>/asset/kindeditor-4.1.10/plugins/code/prettify.js"></script>
    <%--引入公共JS--%>
    <script type="text/javascript" src="<%=request.getContextPath()%>/asset/js/common.js"></script>
    <script type="text/javascript" src="<%=request.getContextPath()%>/asset/js/manage/managecommon.js"></script>
    <script type="text/javascript" src="<%=request.getContextPath()%>/asset/kindeditor-4.1.10/KindeditorConfig.js"></script>
    <%--引入图片上传--%>
    <script type="text/javascript" src="<%=request.getContextPath()%>/asset/js/ajaxfileupload.js"></script>
    <script>
        var moduleType = GetQueryString("moduleType");//所属模块的ID
        //1、第一处修改，修改增删改的请求地址以及deleteId
        var addUrl = "";
        var editUrl = "";
        var deleteUrl = "";
        var editorName = "null";//KindEditor的Textarea的ID，如果没用到，赋值为null
        var imageUpload = "null";//图片上传的标识，如果没有图片上传，赋值为空，如果有，赋值为数据库存放图片名称的字段名称，不带_
        var deleteId = "";//用于删除功能的ID参数，赋值为当前数据库表的ID
    </script>
    <script>
        $(function(){
            $("#dialog-confirm").dialog({
                resizable: true,
                closable:false
            });
        });
        function Back(){
            $("#dialog-confirm").dialog({
                resizable: true,
                closable:false
            });
        }
        function submit(){
            var row = $('#qbdlg').datagrid('getSelected');
            if (row){
                var  value = row.activityId;
                $("#dg").datagrid("load",{sqlActivityId:value});
                $('#dialog-confirm').dialog('close');
                $("#sqlActivityId").val(value);
             }else {
                ShowMsg("请选中一条数据");
            }
        }
        function reloadThisPage(){
            $("#dg").datagrid("reload");
        }
        <%--判断是否是登录状态--%>
        <%--<%@include file="../common/CheckLogin.jsp"%>--%>
    </script>
    <style>
        .dialog {
            position: absolute;
            top: 152px;
            left: 200px;
            z-index: 100;
            width: 800px;
            height: 650px;
            border: 1px solid #197FFE;
            /* margin: 250px auto; */
            background-color: #FFFFFF;
        }
    </style>
</head>
<body>
<%--数据表格--%>
<table id="dg" class="easyui-datagrid" style="width:100%;min-height:556px;max-height: 100%;"
       data-options="pagination:true,
               rownumbers:true,
               singleSelect:true,
               method:'post',
               autoRowHeight:false,
               toolbar:'#tb',
               fitColumns:false,
               <%--2、第二处修改，修改此处的Json服务，用于加载数据--%>
              url:'/jsons/loadSchoolActivityapply.form'">
    <thead>
    <tr>
        <%--3、第三处修改，修改此处的列名称，与数据库一致，显示有必要的--%>
            <th field="applyId" hidden>ID</th>
            <th field="activityTitle"  >活动标题</th>
            <th field="applyStudentId"  >学生学号</th>
            <th field="studentName" >学生姓名</th>
            <%--<th field="applyDate" >申请日期</th>--%>
            <th field="signUpStatus"  >签到状态</th>
            <th field="signUpTime"  >签到时间</th>
    </tr>
    </thead>
</table>
<%--表格头部按钮--%>
<div id="tb" style="height:auto">
    <a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-remove',plain:true" onclick="Back()">重新选择活动</a>
    <a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-reload',plain:true" onclick="reloadThisPage()">刷新当前页</a>
</div>
<%-- 弹出页面 --%>
<div id="dialog-confirm" title="活动选择页面"
     data-options="iconCls: 'icon-save',buttons: '#qbdlg-buttons',modal:true,top:'10%'">
    <table id="qbdlg" class="easyui-datagrid" style="width:550px;height:300px"
           data-options="pagination:true,
               rownumbers:true,
               singleSelect:true,
               method:'post',
               autoRowHeight:false,
               fitColumns:false,
               <%--2、第二处修改，修改此处的Json服务，用于加载数据--%>
              url:'/jsons/loadSchoolAuditActivity.form'">
        <thead>
        <tr>
            <%--3、第三处修改，修改此处的列名称，与数据库一致，显示有必要的--%>
            <th field="activityId" hidden >活动ID</th>
            <th field="activityTitle" >活动标题</th>
            <th field="activityLocation" >活动地点</th>
            <th field="activityParticipation" >参与形式</th>
            <th field="activitySdate" >活动起始时间</th>
            <th field="activityEdate" >活动截止时间</th>

        </tr>
        </thead>
    </table>
</div>
<%--弹出页面的对话框提交、取消按钮--%>
<div id="qbdlg-buttons">
    <a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls: 'icon-ok'" onclick="submit()">提交</a>
    <a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls: 'icon-cancel'" onclick="javascript:$('#dialog-confirm').dialog('close')">取消</a>

</div>
<input type="easyui-textbox" style="display: none" id="sqlActivityId" name="sqlActivityId" >
</body>
</html>