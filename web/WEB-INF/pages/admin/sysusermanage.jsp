<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: liulei
  Date: 2016/4/22
  Time: 15:12
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java"  pageEncoding="UTF-8" %>
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
    <script type="text/javascript" src="<%=request.getContextPath()%>/asset/layer/layer.js"></script>
    <script>
        var moduleType = GetQueryString("");//新闻所属模块的ID
        var editorName = "";//用于KindEditor的textarea的Name和Id
        var imageUpload = "";//用于存入上传图片的Input的ID和Name，如果没有图片上传，则删除或赋值为""
        var resetUrl = "/jsons/resetInstructor.form";
        var deleteId = "sysuserid";//用于删除功能的ID参数，赋值为当前数据库表的ID
        var collegemanagerUrl="";
        var deptmanagerUrl="";
        var postUrl = "";
        $(function(){
            $("#college_box").hide();
            $("#dept_box").hide();
            $("#grade_box").hide();
            $("#class_box").hide();
            $("#sysroleid").combobox({onChange:function(value){
//                console.log(value);
                if(value=="collegemanager"){
                    $("#college_box").addClass("showed");
                    $("#college_box").slideDown(300);
                    $("#dept_box").removeClass("showed");
                    $("#dept_box").slideUp(300);
                    $("#grade_box").removeClass("showed");
                    $("#grade_box").slideUp(300);
                    $("#class_box").removeClass("showed");
                    $("#class_box").slideUp(300);
                }else if(value=="dept"){
                    $("#dept_box").addClass("showed");
                    $("#dept_box").slideDown(300);
                    $("#college_box").removeClass("showed");
                    $("#college_box").slideUp(300);
                    $("#grade_box").removeClass("showed");
                    $("#grade_box").slideUp(300);
                    $("#class_box").removeClass("showed");
                    $("#class_box").slideUp(300);
                }else if(value=="grade"){
                    $("#grade_box").addClass("showed");
                    $("#grade_box").slideDown(300);
                    $("#college_box").removeClass("showed");
                    $("#college_box").slideUp(300);
                    $("#dept_box").removeClass("showed");
                    $("#dept_box").slideUp(300);
                    $("#class_box").removeClass("showed");
                    $("#class_box").slideUp(300);
                }else if(value == "class"){
                    $("#class_box").addClass("showed");
                    $("#class_box").slideDown(300);
                    $("#college_box").removeClass("showed");
                    $("#college_box").slideUp(300);
                    $("#dept_box").removeClass("showed");
                    $("#dept_box").slideUp(300);
                    $("#grade_box").removeClass("showed");
                    $("#grade_box").slideUp(300);
                }else{
                    $("#college_box").removeClass("showed");
                    $("#college_box").slideUp(300);
                    $("#dept_box").removeClass("showed");
                    $("#dept_box").slideUp(300);
                    $("#grade_box").removeClass("showed");
                    $("#grade_box").slideUp(300);
                    $("#class_box").removeClass("showed");
                    $("#class_box").slideUp(300);
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
            postUrl = "/jsons/addUser.form";
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
            postUrl = "/jsons/editUser.form";
            collegemanagerUrl="/jsons/editCollegeManager.form";
            deptmanagerUrl="/jsons/editDeptManager.form";
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
                if(row.sysroleid=="collegemanager" || row.sysroleid=="dept" || row.sysroleid=="grade" || row.sysroleid=="class"){
                    postURL="/jsons/deleteUser.form";
                }
                $.messager.confirm('提示', '确认删除此条数据吗?', function(result){
                    if (result){
                        $.post(postURL,{
                            sysuserid:row.sysuserid,
                            role:row.sysroleid
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
        //自动添加班级管理
        function addClassManager(){
            $.messager.confirm('提示', '该功能会自动添加班级管理账号，已存在的账号不会改变，要继续吗?', function(result){
                if (result){
                    layer.load(1,{shade:[0.1,'#000']});
                    $.ajax({
                        url:"/classmanager/add.form",
                        type:"post",
                        dataTeyp:"json",
                        success:function(data){
                            layer.closeAll();
                            if(data.status==0){
                                ShowMsg(data.msg);
                                $("#dg").datagrid("reload");//重新加载数据
                            }else {
                                ShowMsg(data.msg);
                            }
                        },
                        error:function(){
                            layer.closeAll();
                            ShowMsg("操作失败，请重新登录或联系管理员");
                        }
                    })
                }
            });
        }
        function savedata(){
            //如果学院的选择框没有激活
            if(!$("#college_box").hasClass("showed")){
                $("#college").combobox("setValue","全部");
                //如果部门的选择框没有激活
                if(!$("#dept_box").hasClass("showed")){
                    $("#dept").combobox("setValue","全部");
                    if(!$("#grade_box").hasClass("showed")){
                        $("#grade").combobox("setValue","全部");
                        if(!$("#class_box").hasClass("showed")){
                            $("#class").combobox("setValue","全部");
                            Save();
                            return;
                        }else{
                            //如果班级的选择框已经激活
                            if($("#Form").form('validate')){
                                var jsonObject = $("#Form").serializeObject();
                                var classdata = $("#class").combobox("getValue");
                                if(!classdata){
                                    ShowMsg("请选择班级！");
                                    return;
                                }
                                load();
                                jsonObject["type"] = "class";
                                UploadToDatabase(jsonObject);
                            }else {
                                ShowMsg("请按照要求填写");
                            }
                        }
                    }else{
                        //如果年级的选择框已经激活
                        if($("#Form").form('validate')){
                            var jsonObject = $("#Form").serializeObject();
                            var grade = $("#grade").combobox("getValue");
                            if(!grade){
                                ShowMsg("请选择年级！");
                                return;
                            }
                            load();
                            jsonObject["type"] = "grade";
                            UploadToDatabase(jsonObject);
                        }else {
                            ShowMsg("请按照要求填写");
                        }
                    }
                }else{
                    //如果部门的选择框已经激活
                    if($("#Form").form('validate')){
                        var jsonObject = $("#Form").serializeObject();
                        var dept = $("#dept").combobox("getValue");
                        if(!dept){
                            ShowMsg("请选择部门！");
                            return;
                        }
                        load();
                        jsonObject["type"] = "dept";
                        UploadToDatabase(jsonObject);
                    }else {
                        ShowMsg("请按照要求填写");
                    }
                }
            }else{
                $("#dept").combobox("setValue","全部");
                if($("#Form").form('validate')){
                    var jsonObject = $("#Form").serializeObject();
                    var college=$("#college").combobox("getValue");
                    if(!college){
                        ShowMsg("请选择学院！");
                        return;
                    }
                    load();
                    jsonObject["type"] = "college";
                    UploadToDatabase(jsonObject);
                }else {
                    ShowMsg("请按照要求填写");
                }
            }

        }
        //上传数据到数据库
        function UploadToDatabase(jsonObject){
            $.ajax({
                url:postUrl,
                type:"post",
                dataType:"json",
                data:jsonObject,
                success:function(data){
                    disLoad();
                    if(data.result){
                        $('#dlg').dialog('close');
                        ShowMsg("保存成功");
                        $("#dg").datagrid("reload");
                    }else {
                        ShowMsg("保存中出现错误");
                    }
                },
                error:function(){
                    disLoad();
                    ShowMsg("服务器连接失败");
                }
            });
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
                <th field="sysroleid" width="100px" hidden>角色ID</th>
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
        <a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-add',plain:true" onclick="addClassManager()">自动添加班级管理</a>
        <input id="SearchText" class="easyui-searchbox" data-options="prompt:'请输入用户名',searcher:doSearch" style="width:200px"/>
        <a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-remove',plain:true" onclick="reset()">重置密码</a>


    </div>

    <%--对话框--%>
    <div id="dlg" class="easyui-dialog hide" title=""
         style="width:450px;height:500px;padding:10px;"
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
                        data-options="editable:false,panelHeight:'auto'" style="width:100%;height:32px">
                    <c:forEach items="${collegedata}" var="college">
                        <option value="${college.stuCollageName}">${college.stuCollageName}</option>
                    </c:forEach>
                </select>
            </div>
            <div id="dept_box" style="margin-bottom:10px;margin-top: 10px; ">
                <div class="word">部门:</div>
                <select class="easyui-combobox" name="dept" id="dept"
                        data-options="editable:false,panelHeight:'auto'" style="width:100%;height:32px">
                    <c:forEach items="${depts}" var="deps">
                        <option value="${deps.deptId}">${deps.deptName}</option>
                    </c:forEach>
                </select>
            </div>
            <div id="grade_box" style="margin-bottom:10px;margin-top: 10px; ">
                <div class="word">年级:</div>
                <select class="easyui-combobox" name="grade" id="grade"
                        data-options="editable:false,panelHeight:'auto'" style="width:100%;height:32px">
                    <c:forEach items="${grades}" var="grade">
                        <option value="${grade.stuGradeName}">${grade.stuGradeName}</option>
                    </c:forEach>
                </select>
            </div>
            <div id="class_box" style="margin-bottom:10px;margin-top: 10px; ">
                <div class="word">班级:</div>
                <select class="easyui-combobox" name="class" id="class"
                        data-options="editable:false,panelHeight:'auto'" style="width:100%;height:32px">
                    <c:forEach items="${classdata}" var="classitem">
                        <option value="${classitem.stuClassName}">${classitem.stuClassName}</option>
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