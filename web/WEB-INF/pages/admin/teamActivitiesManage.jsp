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
    <%--引入活动管理JS--%>
    <script type="text/javascript" src="<%=request.getContextPath()%>/asset/js/activitiesManager.js"></script>
    <%--引入图片上传--%>
    <script type="text/javascript" src="<%=request.getContextPath()%>/asset/js/ajaxfileupload.js"></script>
    <script type="text/javascript" src="<%=request.getContextPath()%>/asset/js/studentManager.js"></script>

    <%--本页引用的CSS--%>
    <style>#dlg .textbox .textbox-text{font-size:15.5555px;}</style>
    <style>.test{width: 16px;height: 16px; /* line-height: 8px; */ /* margin-top: 4px; */ position: relative; top: 3px; }</style>
    <style>#dlg{font-size:16px;}</style>

    <script>
        var moduleType = GetQueryString("moduleType");//所属模块的ID，不可以删除
        //1、第一处修改，修改增删改的请求地址
        var addUrl = "/jsons/addTeaminfor.form";
        var editUrl = "/jsons/editTeaminfor.form";
        var deleteUrl = "/jsons/deleteTeaminfor.form";
        var editorName = "null";//KindEditor的Textarea的ID，如果没用到，赋值为null
        var imageUpload = "";//图片上传的标识，如果没有图片上传，赋值为空，如果有，赋值为数据库存放图片名称的字段名称，不带_
        var deleteId = "teamId";//用于删除功能的ID参数，赋值为当前数据库表的ID
        $(function() {
            $("#Board").fadeOut("slow");
            $("input", $("#applyStudentId").next("span")).blur(function () {
                var id = $("#applyStudentId").textbox("getValue");
                if (!id) {
                    ShowMsg("请输入学号！");
                    return;
                }
                setStudentname(id);
            });
        });
        function setStudentname_befor(){
            var id=$("#applyStudentId").textbox("getValue");
            setStudentname(id);
        }
        function setStudentname(id){
            $.ajax({
                url:"/jsons/getStudentname.form",
                type:"post",
                data:{studentID:id},
                success:function(data){
                    if(data!=null){
                        $("#studentName").val(data);
                    }else {
                        $("#studentName").val("加载学生姓名失败");
                    }
                }
            });
        };
        /*
         * 重写save
         *
         * */
        function Saves(){

            if($("#Form").form('validate')){
                var jsonObject = $("#Form").serializeObject();
                jsonObject["moduleType"] = moduleType;
                jsonObject["teamActivityId"] = $("#teamActivityId").textbox("getValue");
                load();
                UploadToDatabases(jsonObject);
            }else {
                ShowMsg("请按照要求填写");
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
                    if (data.result) {
                        $('#dlg').dialog('close');
                        ShowMsg("保存成功");
                        $("#dg").datagrid("reload");
                    } else {
                        ShowMsg("保存中出现错误");
                    }
                    if (data.msg) {
                        ShowMsg(data.msg);
                    }
                },
                error: function () {
                    disLoad();
                    ShowMsg("服务器连接失败");
                }
            })
        }
        //修改
        function Edits(){
            clickStatus = "edit";
            postURL = editUrl;
            var row = $('#dg').datagrid('getSelected');
            if (row){
                $("#Form").form("clear");
                $('#Form').form('load', row);
                $("#dlg").dialog({title: "修改"});
                $("#dlg").dialog('open');
                $("#dlg").get(0).scrollTop=0;
                $('#studentName').html("")
                $("#teamActivityId").combobox("disable");
                var teamId=row.teamId;
                if (teamId){
                    $.ajax({
                        url: "/jsons/getStudentId.form",
                        type: "post",
                        data: {teamId: teamId},
                        success: function (data) {
                            var str="";
                            if (data.total > 0) {
                                var row=data.rows;
//                                console.log(row[0].studentID);
                                for(var i=0;i<row.length;i++){
                                    str=str+row[i].studentID+" ";
                                }
                          $('#applyStudentId').textbox('setValue',str);
                            } else {
                                disLoad();
                                ShowMsg("加载学号失败");
                            }
                        }
                    });
                }
            }else {
                ShowMsg("请选中一条数据");
            }
        }
        //新建
        function Adds(){
            postURL = addUrl;
            clickStatus = "add";
            if(editorName!="null"){//清除KindEditor内容
                KindEditor.instances[0].html('');
            }
            $("#Form").form("clear");
            $("#dlg").dialog({title: "新建"});
            $("#dlg").dialog('open');
            $("#dlg").get(0).scrollTop=0;
            $("#teamActivityId").combobox("enable");
        }
        //删除
        function Deletes(){
            clickStatus = "delete";
            postURL = deleteUrl;
            var row = $('#dg').datagrid('getSelected');
            if (row){
                $.messager.confirm('提示', '确认删除此条数据吗?', function(result){
                    if (result){
                        //删除数据库记录
                        var selectId = row[deleteId];
                        var deleteJsonObject = eval("("+"{'"+deleteId+"':'"+selectId+"'}"+")");
                        $.post(postURL,deleteJsonObject,function(data){
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
        function reloadThis(){
            $("#dg").datagrid("reload");
        }
    </script>
    <%--判断是否是登录状态--%>
    <%@include file="../common/CheckLogin.jsp"%>
</head>
<div>
<div id="Board" style="width: calc(100% - 10px);height: 100%;position: fixed;top: 0;left:0;z-index: 99999;background: #fff;"></div>
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
               url:'/jsons/loadTeaminfor.form'">
        <thead>
            <tr>
                <%--3、第三处修改，修改此处的列名称，与数据库一致，显示有必要的--%>
                <th field="teamId" hidden >ID</th>
                <th field="teamName" >团体名字</th>
                <th field="teamCreateDate">团体创建日期</th>
                <th field="activityTitle">活动标题</th>
                <th field="countPerson">参与人数</th>
            </tr>
        </thead>
    </table>
    <%--表格头部按钮--%>
    <div id="tb" style="height:auto">
        <%--4、第四处修改，修改菜单按钮，选择哪些按钮需要--%>
        <a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-add',plain:true" onclick="Adds()">新建</a>
        <a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-edit',plain:true" onclick="Edits()">修改</a>
        <a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-remove',plain:true" onclick="Deletes()">删除</a>
        <a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-reload',plain:true" onclick="reloadThis()">刷新当前页</a>
        <input class="easyui-searchbox" data-options="prompt:'请输入团队名字',searcher:doSearch" style="width:200px"/>
    </div>
    <%--对话框--%>
    <div id="dlg" class="easyui-dialog hide font1" title=""
         style="width:550px;height:700px;padding:10px;top: 0px;"
         data-options="iconCls: 'icon-save',buttons: '#dlg-buttons',modal:true" closed="true">
        <%--5、第五处修改，修改表单信息，与上面的列名称一致--%>
        <form id="Form">
            <div style="margin-bottom:10px;margin-top: 10px;display: none;">
                <div class="word">ID:</div>
                <input class="easyui-textbox" name="teamId" id="teamId">
            </div>
            <div style="margin-bottom:10px;margin-top: 10px;">
                <span class="word">团体名字:</span>
                <input class="easyui-textbox" data-options="required:true,validType:'length[1,50]'"
                       name="teamName" id="teamName" style="width:200px;height:32px">
            </div>
            <div style="margin-bottom:10px;margin-top: 10px;">
                <span class="word">报名活动:</span>
                <select class="easyui-combobox" name="teamActivityId" id="teamActivityId"
                        data-options="required:true,editable:false,panelHeight:'auto'" style="width:200px;height:32px">
                    <c:forEach items="${activities}" var="activity">
                        <option value="${activity.activityId}">${activity.activityTitle}</option>
                    </c:forEach>
                </select>
            </div>
            <div style="margin-bottom:10px;margin-top: 10px;">
                <span class="word">学生学号:</span>
                <input class="easyui-textbox" data-options="required:true,validType:'length[1,100]'"
                       name="applyStudentId" id="applyStudentId" style="width:200px;height:32px"/>
                <a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-help',plain:true" onclick="setStudentname_befor()">查看姓名</a>
            </div>
            <div style="margin-bottom:10px;margin-top: 10px;">
                    <div class="word" style="letter-spacing: 3px;">学生姓名:</div>
                    <textarea id="studentName" style="width:100%;height:200px;" readonly></textarea>
            </div>
      </form>
            <div style="margin-bottom:10px;">
                <span style="color:#E41D1D;font-size:15px;">注：如果多个学生,需要用 ， 或     分开   例：000001，000002 或 000001 000002</span>
            </div>
    </div>
</div>

    <%--对话框保存、取消按钮--%>
    <div id="dlg-buttons">
        <a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls: 'icon-ok'" onclick="Saves()">保存</a>
        <a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls: 'icon-cancel'" onclick="javascript:$('#dlg').dialog('close')">取消</a>
    </div>
</body>
</html>