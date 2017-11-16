<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
    <script type="text/javascript" src="<%=request.getContextPath()%>/asset/kindeditor-4.1.10/KindeditorConfig.js"></script>
    <%--引入图片上传--%>
    <script type="text/javascript" src="<%=request.getContextPath()%>/asset/js/ajaxfileupload.js"></script>
    <script>
        var moduleType = GetQueryString("moduleType");//所属模块的ID，不可以删除
        //1、第一处修改，修改增删改的请求地址
        var addUrl = "null";
        var editUrl = "/jsons/editActivityapply.form";
        var deleteUrl = "null";
        var editorName = "null";//KindEditor的Textarea的ID，如果没用到，赋值为null
        var imageUpload = "null";//图片上传的标识，如果没有图片上传，赋值为空，如果有，赋值为数据库存放图片名称的字段名称，不带_
        // var deleteId = "classId";//用于删除功能的ID参数，赋值为当前数据库表的ID
        $(function(){
            $("#status_filter").combobox({onChange:function(value){
                $.ajax({
                    url:"/jsons/loadActivityapply.form",
                    type:"post",
                    data:{filter:value},
                    dataType:"json",
                    success:function(data){
                        $("#dg").datagrid("loadData",data);
                    }
                });
            }}) ;
        });
        function editMore(){
            var rows=$("#dg").datagrid('getSelections');
            if(rows ==null || rows.length==0){
                ShowMsg("请至少选择一行数据！");
                return;
            }
            if(rows.length>1){
                ShowMsg("你选择了"+rows.length+"行数据，请取消选择多余的选择！");
                return;
            }
            var row = $('#dg').datagrid('getSelected');
            var databasephoto=row.outPhoto;
            var photoes=databasephoto.split("|");
            //  alert(photoes.length);
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
            Edit();
        }
        function reloadThis(){
            $("#dg").datagrid("reload");
        }
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
               url:'/jsons/loadActivityapply.form'">
    <thead>
    <tr>
        <%--3、第三处修改，修改此处的列名称，与数据库一致，显示有必要的--%>
        <th field="outID" hidden>ID</th>
        <th field="outTitle">活动标题</th>
        <th field="outStudentId" hidden>学生学号</th>
        <th field="studentName" >学生姓名</th>
        <th field="stuCollageName" >学院名称</th>
        <th field="outDate" >参加日期</th>
        <th field="outAward" >获奖情况</th>
        <th field="outAuditStatus" >审核状态</th>
        <th field="outAuditDate" >审核日期</th>
        <th field="outContent" width="30px">活动内容</th>
        <%--<th field="applyStudentPhoto" hidden>活动照片</th>--%>
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
    <a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-edit',plain:true" onclick="editMore()">处理</a>
    <a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-reload',plain:true" onclick="reloadThis()">刷新当前页</a>
    <input class="easyui-searchbox" data-options="prompt:'请输入学生姓名',searcher:doSearch" style="width:200px"/>
</div>

<%--对话框--%>
<div id="dlg" class="easyui-dialog hide" title=""
     style="width:500px;height:500px;padding:10px;"
     data-options="iconCls: 'icon-save',buttons: '#dlg-buttons',modal:true,top:'10%'" closed="true" >
    <%--5、第五处修改，修改表单信息，与上面的列名称一致--%>
    <form id="Form">
        <div id="userphoto_box" style="height: 20px; width: 230px;">
            <img id="user_photo" src="<%=request.getContextPath()%>/asset/image/default.jpg" onerror="onerror=null;src='/Files/Images/default.jpg'" style="width: 250px;height: 150px;margin-right: 13px;margin-left: 13px;margin-top: 2px;">
        </div>
        <div style="margin-bottom:10px;margin-top: 140px;">
             <span style="color:#E41D1D;">
                       注：点击可以切换下一张,<span id="index"></span>共<span id="ids"></span>张</span>
        </div>
        <div style="margin-bottom:10px;margin-top: 10px;display: none">
            <span class="word">ID:</span>
            <input class="easyui-textbox"  name="outID" id="outID"
                   style="width:200px;height:32px">
        </div>
        <div style="margin-bottom:10px;margin-top: 10px;">
            <span class="word">活动标题:</span>
            <input class="easyui-textbox"  name="outTitle" id="outTitle"
                   data-options="disabled:true"
                   style="width:200px;height:32px">
        </div>
        <div style="margin-bottom:10px;margin-top: 10px;">
            <span class="word">学生姓名:</span>
            <input class="easyui-textbox" name="studentName" id="studentName"
                   data-options="disabled:true"
                   style="width:200px;height:32px">
        </div>

        <%--<div style="margin-bottom:10px;margin-top: 10px;">--%>
        <%--<span class="word">签到日期:</span>--%>
        <%--<input class="easyui-datebox" name="signUpTime" id="signUpTime"--%>
        <%--data-options="disabled:true"--%>
        <%--style="width:200px;height:32px">--%>
        <%--</div>--%>
        <%--<div style="margin-bottom:10px;margin-top: 10px;">--%>
        <%--<span class="word">签到状态:</span>--%>
        <%--<select class="easyui-combobox" name="informAuditStatus" id="informAuditStatus"--%>
        <%--data-options="disabled:true" style="width:200px;height:32px">--%>
        <%--<option value="已签到">已签到</option>--%>
        <%--<option value="未签到">未签到</option>--%>
        <%--</select>--%>
        <%--</div>--%>
        <div style="margin-bottom:10px;margin-top: 10px;">
            <span class="word">参加日期:</span>
            <input class="easyui-datebox" name="outDate" id="outDate"
                   data-options="disabled:true"
                   style="width:200px;height:32px">
        </div>
        <div style="margin-bottom:10px;margin-top: 10px;">
            <span class="word">获奖情况:</span>
            <input class="easyui-textbox"  name="outAward" id="outAward"
                   data-options="disabled:true"
                   style="width:200px;height:32px">
        </div>
        <div style="margin-bottom:10px;margin-top: 10px;">
            <span class="word">审核状态:</span>
            <select class="easyui-combobox" name="outAuditStatus" id="outAuditStatus"
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