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
    <script charset="utf-8" src="<%=request.getContextPath()%>/asset/kindeditor-4.1.10/kindeditor.js"></script>
    <script charset="utf-8" src="<%=request.getContextPath()%>/asset/kindeditor-4.1.10/lang/zh_CN.js"></script>
    <script charset="utf-8" src="<%=request.getContextPath()%>/asset/kindeditor-4.1.10/plugins/code/prettify.js"></script>

    <%--引入公共JS--%>
    <script type="text/javascript" src="<%=request.getContextPath()%>/asset/js/common.js"></script>
    <script type="text/javascript" src="<%=request.getContextPath()%>/asset/js/manage/managecommon.js"></script>
    <script type="text/javascript" src="<%=request.getContextPath()%>/asset/kindeditor-4.1.10/KindeditorConfig.js"></script>
    <%--本页引用的CSS--%>
    <style>#dlg .textbox .textbox-text{font-size:15.5555px;}</style>
    <style>.test{width: 16px;height: 16px; /* line-height: 8px; */ /* margin-top: 4px; */ position: relative; top: 3px; }</style>
    <style>#dlg{font-size:16px;}</style>
    <script>
        var moduleType = GetQueryString("moduleType");//所属模块的ID，不可以删除
        //1、第一处修改，修改增删改的请求地址
        var addUrl = "/jsons/saveOtherActivities.form";
//        var editUrl = "/jsons/editActivities.form";
        var deleteUrl = "/jsons/deleteOtherActivities.form";
        var editorName = "activityContent";//KindEditor的Textarea的ID，如果没用到，赋值为null
        var imageUpload = "null";//图片上传的标识，如果没有图片上传，赋值为空，如果有，赋值为数据库存放图片名称的字段名称，不带_
        var deleteId = "activityId";//用于删除功能的ID参数，赋值为当前数据库表的ID

        /*
         * 重写save
         *
         * */
        function Saves(){
            var result=false;
            //增加能力复选框验证
            var qxs=$(".qx_check:checked");
            if(qxs.length<1){
                ShowMsg("必须选一项增加能力");
                $(this).attr("checked",false);
                return false;
            }
            if($("#Form").form('validate')){
                var jsonObject = $("#Form").serializeObject();
                jsonObject["moduleType"] = moduleType;
                if(editorName &&editorName!="null"){
                    editor.sync();
                    jsonObject[editorName] = $("#"+editorName).val();
                }
                //手动拼接 增加能力 到数据库
                var qxs=$(".qx_check:checked");
                var str="";
                if(qxs!=null&&qxs!=""){
                    for(var i=0;i<qxs.length;i++){
                        var val=$(qxs[i]).val();
                        str=str+val+"|";
                    }
                  jsonObject["activityPowers"]=str.substring(0,str.length-1);
                }
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
                        var studentId=row.applyStudentId;
                        var deleteJsonObject = eval("("+"{'"+deleteId+"':'"+selectId+"','studentId':'"+studentId+"'}"+")");
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
               url:'/jsons/loadOtherActivities.form'">
        <thead>
            <tr>
                <%--3、第三处修改，修改此处的列名称，与数据库一致，显示有必要的--%>
                    <th field="activityId" hidden >ID</th>
                    <th field="activityTitle" >活动标题</th>
                    <th field="applyStudentId"  >学生学号</th>
                    <th field="studentName">学生姓名</th>
                    <%--<th field="activityCreator" width="100px">创建者</th>--%>
                    <th field="activityCreatedate">创建日期</th>
                    <th field="otherActivityPoint" >获得分数</th>
            </tr>
        </thead>
    </table>
    <%--表格头部按钮--%>
    <div id="tb" style="height:auto">
        <%--4、第四处修改，修改菜单按钮，选择哪些按钮需要--%>
        <a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-add',plain:true" onclick="Add()">新建</a>
        <%--<a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-edit',plain:true" onclick="Edits()">修改</a>--%>
        <a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-remove',plain:true" onclick="Deletes()">删除</a>
        <%--<a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-reload',plain:true" onclick="reloadData()">刷新</a>--%>
        <a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-reload',plain:true" onclick="reloadThis()">刷新当前页</a>

        <input class="easyui-searchbox" data-options="prompt:'请输入活动标题',searcher:doSearch" style="width:200px"/>
    </div>
    <%--对话框--%>
    <div id="dlg" class="easyui-dialog hide font1" title=""
         style="width:1000px;height:800px;padding:10px;top: 0px;"
         data-options="iconCls: 'icon-save',buttons: '#dlg-buttons',modal:true" closed="true">
        <%--5、第五处修改，修改表单信息，与上面的列名称一致--%>
        <form id="Form">
            <div style="margin-bottom:10px;margin-top: 10px;display: none;">
                <div class="word">ID:</div>
                <input class="easyui-textbox" name="activityId" id="activityId">
            </div>
            <div style="margin-bottom:10px;margin-top: 10px;">
                <span class="word">活动标题:</span>
                <input class="easyui-textbox" data-options="required:true,validType:'length[1,50]'"
                       name="activityTitle" id="activityTitle" style="width:200px;height:32px">
            </div>
            <div style="margin-bottom:10px;margin-top: 10px;">
                <span class="word">学生学号:</span>
                <input class="easyui-textbox" data-options="required:true,validType:'length[1,100]'"
                       name="applyStudentId" id="applyStudentId" style="width:200px;height:32px">
            </div>
            <div style="margin-bottom:10px;margin-top: 10px;">
                <span class="word">获得分数:</span>
                <input class="easyui-textbox" data-options="required:true,validType:'length[1,50]'"
                       name="otherActivityPoint" id="otherActivityPoint" style="width:200px;height:32px">
            </div>
            <div style="margin-bottom:10px;margin-top: 10px;">
                <span class="word">得分日期:</span>
                <input class="easyui-datebox" name="activityCreatedate" id="activityCreatedate"
                       data-options="required:true,editable:false"
                       style="width:200px;height:32px">
            </div>
            <div style="margin-bottom:10px;margin-top: 10px;">
                <span class="word" style="letter-spacing: 3px;">能力标签:</span>
                <input type="checkbox" class="qx_check test" id="qx1" name="qx" value="思辨能力" />思辨能力
                <input type="checkbox" class="qx_check test" id="qx2" name="qx" value="执行能力" />执行能力
                <input type="checkbox" class="qx_check test" id="qx3" name="qx" value="表达能力" />表达能力
                <input type="checkbox" class="qx_check test" id="qx4" name="qx" value="领导能力" />领导能力
                <input type="checkbox" class="qx_check test" id="qx5" name="qx" value="创新能力" />创新能力
                <input type="checkbox" class="qx_check test" id="qx6" name="qx" value="创业能力" />创业能力
            </div>
<form/>
            <%--KindEditor文本框放在Form外面，如果不需要KindEditor，注释掉--%>
            <div style="margin-bottom:10px;margin-top: 10px;">
                <div class="word" style="letter-spacing: 3px;">活动内容:</div>
                <textarea id="activityContent" name="activityContent" style="width:100%;height:300px;"></textarea>
            </div>
            <div style="margin-bottom:10px;">
                <span style="color:#E41D1D;font-size:15px;">注：如果多个学生,需要用 ， 或     分开   例：000001，000002 或 000001 000002  获得分数是该活动的能力得分总和 如果是 思辨能力  获得分数 5 分
                此时获得分数就填入5 以此类推 俩项能力10 三项 15
                </span>
            </div>
    </div>
    <%--对话框保存、取消按钮--%>
    <div id="dlg-buttons">
        <a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls: 'icon-ok'" onclick="Saves()">保存</a>
        <a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls: 'icon-cancel'" onclick="javascript:$('#dlg').dialog('close')">取消</a>
    </div>
</body>
</html>