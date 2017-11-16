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
    <%--引入kindereditor--%>
    <link rel="stylesheet" href="<%=request.getContextPath()%>/asset/kindeditor-4.1.10/themes/default/default.css" />
    <link rel="stylesheet" href="<%=request.getContextPath()%>/asset/kindeditor-4.1.10/plugins/code/prettify.css" />
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
        var imageUpload = "";//图片上传的标识，如果没有图片上传，赋值为空，如果有，赋值为数据库存放图片名称的字段名称，不带_
        var deleteId = "";//用于删除功能的ID参数，赋值为当前数据库表的ID

        function Details(){
            clickStatus = "details";
            var row = $('#dg').datagrid('getSelected');
            if (row){
                var studentId = row.studentId;
                $("#Form").form("clear");
                $('#Form').form('load', row);
                $("#dlg").dialog({title: "参与活动详情"});
                $('#dlg').dialog('open');
                $("#dlg").get(0).scrollTop=0;
                $("#dg_child").datagrid('reload',{
                    studentid :studentId
                });
            }else {
                ShowMsg("请选中一条数据");
            }
        }
        //双击一行数据显示该条数据的详细信息
        $(function(){
            $("#dg").datagrid({
                onDblClickRow : function(rowIndex, rowData){
                    Details()
                }
            });
        });

    </script>
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
              url:'/sixpoint/sixpoint.form'">
    <thead>
    <tr>
        <%--3、第三处修改，修改此处的列名称，与数据库一致，显示有必要的--%>

            <th field="studentName" >学生姓名</th>
            <th field="pointYear" >年份</th>
            <th field="sibian">思辨能力得分</th>
            <th field="zhixing">执行能力得分</th>
            <th field="biaoda">表达能力得分</th>
            <th field="lingdao">领导能力得分</th>
            <th field="chuangxin">创新能力得分</th>
            <th field="chuangye">创业能力得分</th>

    </tr>
    </thead>
</table>
<%--表格头部按钮--%>
<div id="tb" style="height:auto">
    <%--4、第四处修改，修改菜单按钮，选择哪些按钮需要--%>
    <input class="easyui-searchbox" data-options="prompt:'请输入学生姓名',searcher:doSearch" style="width:200px"/>
    <a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-search',plain:true" onclick="Details()">查看详情</a>
</div>
<div id="dlg" class="easyui-dialog hide" title=""
     style="width:1000px;height:500px;padding:10px;position: relative;"
     data-options="iconCls: 'icon-save',buttons: '#close_button',modal:true" closed="true" >
    <table id="dg_child" class="easyui-datagrid" style="width:99%;height: 99%;"
           data-options="pagination:true,
               rownumbers:true,
               singleSelect:true,
               method:'post',
               autoRowHeight:false,
               toolbar:'',
               fitColumns:true,
               <%--2、第二处修改，修改此处的Json服务，用于加载数据--%>
              url:'/jsons/loadActivityPointCount.form'">
        <thead>
        <tr>
            <%--3、第三处修改，修改此处的列名称，与数据库一致，显示有必要的（跨行的字符串不要显示）--%>
            <th field="studentId" hidden >学生ID</th>
            <th field="activityTitle">活动标题</th>
            <th field="activityLevleMean">活动级别</th>
            <th field="activityNatureMean" >活动类型</th>
            <th field="activityParticipation">参与形式</th>
            <th field="activityAwardMean" >获奖情况</th>
            <th field="activityPowers" >能力标签</th>
            <th field="otherActivityPoint" >其他类活动得分</th>
        </tr>
        </thead>
    </table>
</div>
<%--关闭按钮--%>
<div id="close_button" style="display: none;">
    <a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls: 'icon-cancel'" onclick="javascript:$('#dlg').dialog('close')">关闭</a>
</div>
</body>
</html>