<%--
  Created by IntelliJ IDEA.
  User: liulei
  Date: 2016/4/27
  Time: 9:27
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java"  pageEncoding="UTF-8" %>
<html>
<head>
    <title>系统角色管理</title>
    <link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/asset/easyui/themes/default/easyui.css">
    <link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/asset/easyui/themes/icon.css">
    <script type="text/javascript" src="<%=request.getContextPath()%>/asset/js/jquery-1.8.3.min.js"></script>
    <script type="text/javascript" src="<%=request.getContextPath()%>/asset/js/common.js"></script>
    <script type="text/javascript" src="<%=request.getContextPath()%>/asset/easyui/jquery.easyui.min.js"></script>
    <script type="text/javascript" src="<%=request.getContextPath()%>/asset/easyui/locale/easyui-lang-zh_CN.js"></script>
    <script type="text/javascript" src="<%=request.getContextPath()%>/asset/js/manage/massage-helper.js"></script>
    <script type="text/javascript" src="<%=request.getContextPath()%>/asset/js/manage/managecommon.js"></script>
    <script>
        var moduleType = GetQueryString("");//新闻所属模块的ID
        var editorName = "";//用于KindEditor的textarea的Name和Id
        var imageUpload = "";//用于存入上传图片的Input的ID和Name，如果没有图片上传，则删除或赋值为""
        //新建
        function Add(){
            postURL = "/jsons/addRole.form";
            $("#Form").form("clear");
            $("#dlg").dialog({title: "新建"});
            $('#dlg').dialog('open');
        }
        //修改
        function Edit(){
            postURL = "/jsons/editRole.form";
            var row = $('#dg').datagrid('getSelected');
            if (row){
                $("#Form").form("clear");
                $('#Form').form('load', row);
                $("#dlg").dialog({title: "修改"});
                $('#dlg').dialog('open');
            }else {
                ShowMsg("请选中一条数据");
            }
        }
        //删除
        function Delete(){
            postURL = "/jsons/deleteRole.form";
            var row = $('#dg').datagrid('getSelected');
            if (row){
                $.messager.confirm('提示', '删除角色同时将删除该角色下的所有用户，确认删除？', function(result){
                    if (result){
                        $.post(postURL,{
                            sysroleid:row.sysroleid
                        },function(data){
                            if(data.result){
                                ShowMsg("删除成功");
                                $("#dg").datagrid("reload");//重新加载数据
                            }else {
                                ShowMsg("删除失败，请重新登录或联系管理员:"+data.errormessage);
                            }
                        });
                    }
                });
            }else {
                ShowMsg("请选中一条数据");
            }
        }

        function edit_before(){
            var row = $('#dg').datagrid('getSelected');
            if(row!=null && row.issysrole=="否"){
                Edit();
            }else{
                ShowMsg("系统角色禁止修改！");
            }
        }

        function delte_before(){
            var row = $('#dg').datagrid('getSelected');
            if(row!=null && row.issysrole=="否"){
                Delete();
            }else{
                ShowMsg("系统角色禁止删除！");
            }
        }
    </script>
    <%--判断是否是登录状态--%>
    <%@include file="../common/CheckLogin.jsp"%>
</head>
<body>
    <%--数据表格--%>
    <table id="dg" class="easyui-datagrid" style="width:100%;min-height:556px;max-height: 100%;"
           data-options="
               pagination:true,
               rownumbers:true,
               singleSelect:true,
               method:'post',
               autoRowHeight:false,
               toolbar:'#tb',
               url:'/jsons/loadSysRole.form',fitColumns:true">
        <thead>
        <tr>
            <th field="sysroleid" hidden >ID</th>
            <th field="sysrolename" width="100px">角色名称</th>
            <th field="createdate" width="100px">创建日期</th>
            <th field="createman" width="100px">创建者</th>
            <th field="updatedate" width="100px">更新日期</th>
            <th field="updateman" width="100px">更新者</th>
            <th field="remark" width="100px">备注</th>
        </tr>
        </thead>
    </table>
    <%--表格头部按钮--%>
    <div id="tb" style="height:auto">
        <a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-add',plain:true" onclick="Add()">新建</a>
        <a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-edit',plain:true" onclick="edit_before()">修改</a>
        <a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-remove',plain:true" onclick="delte_before()">删除</a>
        <input id="SearchText" class="easyui-searchbox" data-options="prompt:'请输入角色名',searcher:doSearch" style="width:200px"/>
    </div>

    <%--对话框--%>
    <div id="dlg" class="easyui-dialog hide" title=""
         style="width:400px;height:320px;padding:10px;"
         data-options="iconCls: 'icon-save',buttons: '#dlg-buttons',modal:true" closed="true">
        <form id="Form">
            <div style="margin-bottom:10px;margin-top: 10px;display: none;">
                <div class="word">ID:</div>
                <input class="easyui-textbox" name="sysroleid" id="sysroleid">
            </div>
            <div style="margin-bottom:10px;margin-top: 10px;">
                <div class="word">角色名:</div>
                <input class="easyui-textbox" data-options="required:true,validType:'length[1,25]'"
                       name="sysrolename" id="sysrolename" style="width:100%;height:32px">
            </div>
            <div style="margin-bottom:10px;margin-top: 10px;">
                <div class="word">备注:</div>
                <input class="easyui-textbox" data-options="multiline:true,validType:'length[0,50]'"
                       style="height:100px;width:100%;" name="remark" id="remark">
            </div>
        </form>
    </div>
    <%--对话框保存、取消按钮--%>
    <div id="dlg-buttons">
        <a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls: 'icon-ok'" onclick="Save()">保存</a>
        <a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls: 'icon-cancel'" onclick="javascript:$('#dlg').dialog('close')">取消</a>
    </div>
</body>
</html>