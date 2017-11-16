<%--
  Created by IntelliJ IDEA.
  User: admin
  Date: 2016/8/25
  Time: 11:11
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java"  pageEncoding="UTF-8" %>
<html>
<head>
    <title>友情链接的创建与修改</title>
    <link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/asset/easyui/themes/default/easyui.css">
    <link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/asset/easyui/themes/icon.css">
    <script type="text/javascript" src="<%=request.getContextPath()%>/asset/js/jquery-1.8.3.min.js"></script>
    <script type="text/javascript" src="<%=request.getContextPath()%>/asset/easyui/jquery.easyui.min.js"></script>
    <script type="text/javascript" src="<%=request.getContextPath()%>/asset/easyui/locale/easyui-lang-zh_CN.js"></script>
    <script type="text/javascript" src="<%=request.getContextPath()%>/asset/js/manage/massage-helper.js"></script>

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
    <script>
        var moduleType = GetQueryString("moduleType");//所属模块的ID，不可以删除
        //1、第一处修改，修改增删改的请求地址
        var addUrl = "/jsons/addblogrollInfo.form";
        var editUrl = "/jsons/updateblogrollInfo.form";
        var deleteUrl = "/jsons/delblogrollInfo.form";
        var editorName = "null";//KindEditor的Textarea的ID，如果没用到，赋值为null
        var imageUpload = "";//图片上传的标识，如果没有图片上传，赋值为空，如果有，赋值为数据库存放图片名称的字段名称，不带_
        var deleteId = "blogrollId";//用于删除功能的ID参数，赋值为当前数据库表的ID
        var flag=false;
        function AddCheck(){
            $.ajax({
                url:"/jsons/loadblogrollInfo.form",
                dataType:"json",
                success:function(data){
                    if(data.rows.length>5){
                        ShowMsg("最多只能创建六个友情链接");
                        return;
                    }
                    Add();
                }
            });
        }

        function DelCheck(){
            $.ajax({
                url:"/jsons/loadblogrollInfo.form",
                dataType:"json",
                success:function(data){
                    if(data.rows.length <= 1){
                        ShowMsg("至少存在一个友情链接");
                        return;
                    }
                    Delete();
                }
            });

        }

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
               fitColumns:true,
               <%--2、第二处修改，修改此处的Json服务，用于加载数据--%>
               url:'/jsons/loadblogrollInfo.form'">
    <thead>
    <tr>
        <%--3、第三处修改，修改此处的列名称，与数据库一致，显示有必要的--%>
        <th field="linkAddress" style="width: 40%" >链接的地址</th>
        <th field="linkName" style="width: 30%" >链接的名称</th>
        <th field="updatetime" style="width: 30%" >更新的时间</th>
    </tr>
    </thead>
</table>
<%--表格头部按钮--%>
<div id="tb" style="height:auto">
    <%--4、第四处修改，修改菜单按钮，选择哪些按钮需要--%>
    <a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-add',plain:true" onclick="AddCheck();">新建</a>
    <a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-edit',plain:true" onclick="Edit();">修改</a>
    <a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-remove',plain:true" onclick="DelCheck()">删除</a>
</div>
<%--对话框--%>
<div id="dlg" class="easyui-dialog hide" title=""
     style="width:500px;height:300px;padding:10px;"
     data-options="iconCls: 'icon-save',buttons: '#dlg-buttons',modal:true" closed="true" >
    <%--5、第五处修改，修改表单信息，与上面的列名称一致--%>
        <form id="Form">
            <div style="margin-bottom:10px;margin-top: 10px;" id="parent_div" hidden>
                <input  class="easyui-textbox" name="blogrollId" id="blogrollId">
            </div>
            <div style="margin-bottom:10px;margin-top: 10px;text-align:right;margin-right: 100px">
                <span class="word">链接的地址</span>
                <input class="easyui-textbox"  name="linkAddress" id="linkAddress"data-options="required:true,validType:'length[1,500]'"
                style="width:200px;height:32px">
            </div>
            <div style="margin-bottom:10px;margin-top: 10px;text-align:right;margin-right: 100px">
                <span class="word">链接的名称</span>
                <input class="easyui-textbox"  name="linkName" id="linkName" data-options="required:true,validType:'length[1,20]'"
                style="width:200px;height:32px">
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
