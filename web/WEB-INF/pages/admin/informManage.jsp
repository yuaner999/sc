<%--
  Created by IntelliJ IDEA.
  User: admin
  Date: 2016/8/8
  Time: 9:52
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
    <script type="text/javascript"
            src="<%=request.getContextPath()%>/asset/easyui/locale/easyui-lang-zh_CN.js"></script>
    <script type="text/javascript" src="<%=request.getContextPath()%>/asset/js/manage/massage-helper.js"></script>
    <%--引入kindereditor--%>
    <link rel="stylesheet" href="<%=request.getContextPath()%>/asset/kindeditor-4.1.10/themes/default/default.css"/>
    <link rel="stylesheet" href="<%=request.getContextPath()%>/asset/kindeditor-4.1.10/plugins/code/prettify.css"/>
    <script charset="utf-8" src="<%=request.getContextPath()%>/asset/kindeditor-4.1.10/kindeditor.js"></script>
    <script charset="utf-8" src="<%=request.getContextPath()%>/asset/kindeditor-4.1.10/lang/zh_CN.js"></script>
    <script charset="utf-8"
            src="<%=request.getContextPath()%>/asset/kindeditor-4.1.10/plugins/code/prettify.js"></script>

    <%--引入公共JS--%>
    <script type="text/javascript" src="<%=request.getContextPath()%>/asset/js/common.js"></script>
    <script type="text/javascript" src="<%=request.getContextPath()%>/asset/js/manage/managecommon.js"></script>
    <script type="text/javascript"
            src="<%=request.getContextPath()%>/asset/kindeditor-4.1.10/KindeditorConfig.js"></script>
    <%--引入图片上传--%>
    <script type="text/javascript" src="<%=request.getContextPath()%>/asset/js/ajaxfileupload.js"></script>
    <style>.test{padding-right:10px;width:8em;display:block;float:left;line-height:26px;}</style>
    <script>
        var moduleType = GetQueryString("moduleType");//所属模块的ID，不可以删除
        //1、第一处修改，修改增删改的请求地址
        var addUrl = "null";
        var editUrl = "/jsons/editInformStatus.form";
        var deleteUrl = "null";
        var editorName = "null";//KindEditor的Textarea的ID，如果没用到，赋值为null
        var imageUpload = "null";//图片上传的标识，如果没有图片上传，赋值为空，如果有，赋值为数据库存放图片名称的字段名称，不带_
        //      var deleteId = "classId";//用于删除功能的ID参数，赋值为当前数据库表的ID
        $(function(){
            $("#status_filter").combobox({onChange:function(value){
                $.ajax({
                    url:"/jsons/loadInform.form",
                    type:"post",
                    data:{filter:value},
                    dataType:"json",
                    success:function(data){
                        $("#dg").datagrid("loadData",data);
                    }
                });
            }}) ;
        });
    </script>
    <%--判断是否是登录状态--%>
    <%@include file="../common/CheckLogin.jsp"%>
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
               fitColumns:true,
               <%--2、第二处修改，修改此处的Json服务，用于加载数据--%>
               url:'/jsons/loadInform.form'">
    <thead>
    <tr>
        <%--3、第三处修改，修改此处的列名称，与数据库一致，显示有必要的--%>
        <th field="informId" hidden>ID</th>
        <%--<th field="informApplyId" >被举报学生参加的活动</th>--%>
        <th field="informStudentId" >被举报学生学号</th>
        <th field="informStudent">被举报学生姓名</th>
        <th field="informByStudentId">举报学生学号</th>
        <th field="informByStudent">举报学生姓名</th>
        <th field="informDate" >举报日期</th>
        <th field="stuCollageName" >学院名称</th>
        <th field="informContent" style="width:10%">举报内容</th>
        <th field="informAuditDate" >处理日期</th>
        <th field="informAuditStatus" >审核状态</th>
        <th field="informType" >举报/质疑</th>
    </tr>
    </thead>
</table>
<%--表格头部按钮--%>
<div id="tb" style="height:auto">
    <%--4、第四处修改，修改菜单按钮，选择哪些按钮需要--%>
    <select class="easyui-combobox" name="filter" id="status_filter"
            data-options="required:true,editable:false,panelHeight:'auto'" style="width:100px">
        <option value="" selected>全部信息</option>
        <option value="已通过">已通过</option>
        <option value="未通过">未通过</option>
        <option value="待处理">待处理</option>
    </select>
    <a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-edit',plain:true" onclick="Edit()">处理</a>
    <%--<a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-reload',plain:true" onclick="reloadData()">刷新</a>--%>
    <input class="easyui-searchbox" data-options="prompt:'请输入学生姓名',searcher:doSearch" style="width:200px"/>
</div>
<%--对话框--%>
<div id="dlg" class="easyui-dialog hide" title=""
     style="width:700px;height:750px;padding:10px;top: 0px;"
     data-options="iconCls: 'icon-save',buttons: '#dlg-buttons',modal:true" closed="true">
    <form id="Form">
        <div style="margin-bottom:10px;margin-top: 10px;display: none">
            <span class="word">ID:</span>
            <input class="easyui-textbox"  name="informId" id="informId"
                   style="width:200px;height:32px">
        </div>
        <div style="margin-bottom:10px;margin-top: 10px;">
            <span class="word test">被举报学生学号:</span>
            <input class="easyui-textbox"  name="informByStudentId" id="informByStudentId"
                   data-options="disabled:true"
                   style="width:200px;height:32px">
        </div>
        <div style="margin-bottom:10px;margin-top: 10px;">
        <span class="word test">被举报学生姓名:</span>
        <input class="easyui-textbox"  name="informByStudent" id="informByStudent"
               data-options="disabled:true"
               style="width:200px;height:32px">
        </div>
      <%--<div style="margin-bottom:10px;margin-top: 10px;">--%>
            <%--<span class="word">申请ID:</span>--%>
            <%--<input class="easyui-textbox" name="informApplyId" id="informApplyId"--%>
                   <%--data-options="disabled:true"--%>
                   <%--style="width:200px;height:32px">--%>
        <%--</div>--%>
        <div style="margin-bottom:10px;margin-top: 10px;">
            <span class="word test">举报学生学号:</span>
            <input class="easyui-textbox" name="informStudentId" id="informStudentId"
                   data-options="disabled:true"
                   style="width:200px;height:32px">

        </div>
        <div style="margin-bottom:10px;margin-top: 10px;">
            <span class="word test">举报学生姓名:</span>
            <input class="easyui-textbox"  name="informStudent" id="informStudent"
                   data-options="disabled:true"
                   style="width:200px;height:32px">
            </input>
        </div>
        <div style="margin-bottom:10px;margin-top: 10px;">
            <span class="word test" style="letter-spacing: 3px;">举报日期:</span>
            <input class="easyui-datebox" name="informDate" id="informDate"
                   data-options="disabled:true"
                   style="width:200px;height:32px">
        </div>
        <div style="margin-bottom:10px;margin-top: 10px;">
            <span class="word test">举报/质疑:</span>
            <input class="easyui-textbox"  name="informType" id="informType"
                   data-options="disabled:true"
                   style="width:200px;height:32px">
            </input>
        </div>
        <div style="margin-bottom:10px;margin-top: 10px;">
            <div class="word" style="letter-spacing: 3px;">备注:</div>
            <textarea id="informContent" name="informContent" style="width:100%;height:200px;" readonly></textarea>
        </div>
        <div style="margin-bottom:10px;margin-top: 10px;">
            <span class="word">处理状态:</span>
            <select class="easyui-combobox" name="informAuditStatus" id="informAuditStatus"
                    data-options="required:true,editable:false,panelHeight:'auto'" style="width:200px;height:32px">
                <option value="已通过">已通过</option>
                <option value="未通过">未通过</option>
                <option value="待处理">待处理</option>
            </select>
        </div>
        <div id="dlg-buttons">
            <a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls: 'icon-ok'" onclick="Save()">保存</a>
            <a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls: 'icon-cancel'" onclick="javascript:$('#dlg').dialog('close')">取消</a>
        </div>
    </form>

</div>
</body>
</html>