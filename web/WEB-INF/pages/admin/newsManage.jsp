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
        var addUrl = "/jsons/addNews.form";
        var editUrl = "/jsons/editNews.form";
        var deleteUrl = "/jsons/deleteNews.form";
        var editorName = "newsContent";//KindEditor的Textarea的ID，如果没用到，赋值为null
        var imageUpload = "newsImg";//图片上传的标识，如果没有图片上传，赋值为空，如果有，赋值为数据库存放图片名称的字段名称，不带_
        var deleteId = "newsId";//用于删除功能的ID参数，赋值为当前数据库表的ID

        /**
         * 预览图片功能
         * @param file
         */
        function preview(file) {
            var prevDiv = $("#user_photo");
            if (file.files && file.files[0])
            {
                var reader = new FileReader();
                reader.onload = function(evt){
                    prevDiv.attr("src",evt.target.result);
                }
                reader.readAsDataURL(file.files[0]);
            }
        }
        function Add_before(){
            $("#user_photo").attr("src","/asset/image/news.jpg");
            Add();
        }
        function editMore(){
            var row = $('#dg').datagrid('getSelected');
            $("#user_photo").attr("src","/Files/Images/"+row.newsImg);
            Edit();
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
               fitColumns:false,
               <%--2、第二处修改，修改此处的Json服务，用于加载数据--%>
              url:'/jsons/loadNews.form'">
    <thead>
    <tr>
        <%--3、第三处修改，修改此处的列名称，与数据库一致，显示有必要的--%>
            <th field="newsId" hidden >ID</th>
            <th field="newsTitle" >新闻标题</th>
            <th field="newsContent" width="100px" >新闻内容</th>
            <th field="newsType">新闻类型</th>
            <th field="newsDate"  hidden>新闻创建时间</th>
            <th field="newsCreator" >新闻创建者</th>
    </tr>
    </thead>
</table>
<%--表格头部按钮--%>
<div id="tb" style="height:auto">
    <%--4、第四处修改，修改菜单按钮，选择哪些按钮需要--%>
    <a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-add',plain:true" onclick="Add_before()">新建</a>
    <a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-edit',plain:true" onclick="editMore()">修改</a>
    <a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-remove',plain:true" onclick="Delete()">删除</a>
    <input class="easyui-searchbox" data-options="prompt:'请输入新闻标题',searcher:doSearch" style="width:200px"/>
</div>
<%--对话框--%>
<div id="dlg" class="easyui-dialog hide" title=""
     style="width:600px;height:620px;padding:10px; top: 0px"
     data-options="iconCls: 'icon-save',buttons: '#dlg-buttons',modal:true" closed="true" >
    <%--5、第五处修改，修改表单信息，与上面的列名称一致--%>
        <form id="Form">
            <input type="hidden" id="photo_textbox" name="newsImg">
            <div id="userphoto_box" style="height: 20px; width: 230px; float: right;">
                <img id="user_photo" src="<%=request.getContextPath()%>/asset/image/default.jpg" onerror="error=null;src='<%=request.getContextPath()%>/asset/image/default.jpg'" style="width: 200px;height: 130px;margin-right: 5px;">
            </div>
            <div style="margin-bottom:10px;margin-top: 10px;display: none;">
                <div class="word">ID:</div>
                <input class="easyui-textbox" name="newsId" id="newsId">
            </div>
            <div style="margin-bottom:10px;margin-top: 10px;">
                <span class="word">新闻标题:</span>
                <input class="easyui-textbox" data-options="required:true,validType:'length[1,50]'"
                       name="newsTitle" id="newsTitle" style="width:200px;height:32px">
            </div>

            <div style="margin-bottom:10px;margin-top: 10px;">
                <span class="word">新闻类型:</span>
                <select class="easyui-combobox" name="newsType" id="newsType"
                        data-options="required:true,editable:false,panelHeight:'auto'" style="width:200px;height:32px">
                        <option>学校新闻</option>
                        <option>学院新闻</option>
                </select>
            </div>
            <div id="studentPhoto_box" class="fitem">
                <span class="word">新闻封面图片</span>
                <input type="file" id="newsImg" name="newsIm" onchange='preview(this)'/>
            </div>
        </form>
    <%--KindEditor文本框放在Form外面，如果不需要KindEditor，注释掉--%>
    <div style="margin-bottom:10px;margin-top: 10px;">
        <div class="word" style="letter-spacing: 3px;">新闻内容:</div>
        <textarea id="newsContent" name="newsContent" style="width:100%;height:330px;"></textarea>
    </div>
</div>
<%--对话框保存、取消按钮--%>
<div id="dlg-buttons">
    <a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls: 'icon-ok'" onclick="Save()">保存</a>
    <a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls: 'icon-cancel'" onclick="javascript:$('#dlg').dialog('close')">取消</a>
</div>
</body>
</html>