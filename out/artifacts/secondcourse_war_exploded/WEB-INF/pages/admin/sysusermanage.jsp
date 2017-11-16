<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: liulei
  Date: 2016/4/22
  Time: 15:12
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="UTF-8">
    <title>用户管理</title>
    <link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/asset/easyui/themes/default/easyui.css">
    <link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/asset/easyui/themes/icon.css">
    <script type="text/javascript" src="<%=request.getContextPath()%>/asset/js/jquery-1.8.3.min.js"></script>
    <script type="text/javascript" src="<%=request.getContextPath()%>/asset/easyui/jquery.easyui.min.js"></script>
    <script type="text/javascript" src="<%=request.getContextPath()%>/asset/easyui/locale/easyui-lang-zh_CN.js"></script>
    <script type="text/javascript" src="<%=request.getContextPath()%>/asset/js/manage/massage-helper.js"></script>
    <script type="text/javascript" src="<%=request.getContextPath()%>/asset/js/common.js"></script>
    <script type="text/javascript" src="<%=request.getContextPath()%>/asset/js/manage/managecommon.js"></script>
    <script>
        var moduleType = GetQueryString("");//新闻所属模块的ID
        var editorName = "";//用于KindEditor的textarea的Name和Id
        var imageUpload = "";//用于存入上传图片的Input的ID和Name，如果没有图片上传，则删除或赋值为""
        var collegemanagerUrl="";
        $(function(){
            $("#college_box").hide();
            $("#sysroleid").combobox({onChange:function(value){
                console.log(value);
                if(value=="collegemanager"){
                    $("#college_box").addClass("showed");
                    $("#college_box").slideDown(300);
                }else{
                    $("#college_box").removeClass("showed");
                    $("#college_box").slideUp(300);
                }
            }});
        });
        //新建
        function Add(){
            $("#college_box").removeClass("showed");
            $("#college_box").hide();
            $("#username").textbox({
                "readonly":false
            });
            postURL = "/Login/AddSysUser.form";
            collegemanagerUrl="/jsons/addCollegeManager.form";
            $("#Form").form("clear");
            $("#dlg").dialog({title: "新建"});
            $('#dlg').dialog('open');
        }
        //修改
        function Edit(){
            $("#username").textbox({
                "readonly":true
            });
            postURL = "/jsons/editSysUser.form";
            collegemanagerUrl="/jsons/editCollegeManager.form";
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
            postURL = "/jsons/deleteSysUser.form";
            var row = $('#dg').datagrid('getSelected');
            if (row){
                if(row.college){
                    postURL="/jsons/deleteCollegeManager.form";
                }
                $.messager.confirm('提示', '确认删除此条数据吗?', function(result){
                    if (result){
                        $.post(postURL,{
                            sysuserid:row.sysuserid
                        },function(data){
                            if(data.result){
                                ShowMsg("删除成功");
                                $("#dg").datagrid("reload");//重新加载数据
                            }else {
                                ShowMsg("删除失败，请重新登录或联系管理员");
                            }
                        });
                    }
                });
            }else {
                ShowMsg("请选中一条数据");
            }
        }
        function savedata(){
            if(!$("#college_box").hasClass("showed")){
                $("#college").combobox("setValue","全部");
                Save();
                return;
            }
            if($("#Form").form('validate')){
                var jsonObject = $("#Form").serializeObject();
                var college=$("#college").combobox("getValue");
                if(!college){
                    ShowMsg("请选择学院！");
                    return;
                }
                load();
                $.post(collegemanagerUrl,jsonObject,function(data){
                    disLoad();
                    if(data.result){
                        $('#dlg').dialog('close');
                        ShowMsg("保存成功");
                        $("#dg").datagrid("reload");
                    }else {
                        ShowMsg("保存中出现错误");
                    }
                });
            }else {
                ShowMsg("请按照要求填写");
            }
        }
    </script>
    <%--判断是否是登录状态--%>
    <%@include file="../common/CheckLogin.jsp"%>
</head>
<body>
    <%--数据表格--%>
    <table id="dg" class="easyui-datagrid" title="" style="width:100%;min-height:590px;max-height: 100%;"
           data-options="
               pagination:true,
               rownumbers:true,
               singleSelect:true,
               method:'post',
               autoRowHeight:false,
               toolbar:'#tb',
               fitColumns:true,
               url:'/jsons/loadSysUser.form'">
        <thead>
            <tr>
                <th field="sysuserid" hidden >ID</th>
                <th field="username" width="100px">用户名</th>
                <th field="sysroleid" width="100px" hidden>角色</th>
                <th field="sysrolename" width="100px">角色</th>
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
        <a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-edit',plain:true" onclick="Edit()">修改</a>
        <a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-remove',plain:true" onclick="Delete()">删除</a>
        <input id="SearchText" class="easyui-searchbox" data-options="prompt:'请输入用户名',searcher:doSearch" style="width:200px"/>
    </div>

    <%--对话框--%>
    <div id="dlg" class="easyui-dialog hide" title=""
         style="width:400px;height:420px;padding:10px;"
         data-options="iconCls: 'icon-save',buttons: '#dlg-buttons',modal:true" closed="true">
        <form id="Form">
            <div style="margin-bottom:10px;margin-top: 10px;display: none;">
                <div class="word">ID:</div>
                <input class="easyui-textbox" name="sysuserid" id="sysuserid">
            </div>
            <div style="margin-bottom:10px;margin-top: 10px;">
                <div class="word">用户名:</div>
                <input class="easyui-textbox" data-options="required:true,validType:'length[1,25]'"
                       name="username" id="username" style="width:100%;height:32px">
            </div>
            <div style="margin-bottom:10px;margin-top: 10px;">
                <div class="word">角色:</div>
                <select class="easyui-combobox" name="sysroleid" id="sysroleid"
                        data-options="required:true,editable:false,panelHeight:'auto'" style="width:100%;height:32px">
                <c:forEach items="${data}" var="sysrole">
                    <option value="${sysrole.sysroleid}">${sysrole.sysrolename}</option>
                </c:forEach>
                </select>
            </div>
            <div id="college_box" style="margin-bottom:10px;margin-top: 10px; ">
                <div class="word">学院:</div>
                <select class="easyui-combobox" name="college" id="college"
                        data-options="required:true,editable:false,panelHeight:'auto'" style="width:100%;height:32px">
                    <c:forEach items="${collegedata}" var="college">
                        <option value="${college.collegeId}">${college.collegeName}</option>
                    </c:forEach>
                </select>
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
        <a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls: 'icon-ok'" onclick="savedata()">保存</a>
        <a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls: 'icon-cancel'" onclick="javascript:$('#dlg').dialog('close')">取消</a>
    </div>
</body>
</html>