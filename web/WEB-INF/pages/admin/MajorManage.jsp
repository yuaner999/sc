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
        //1、第一处修改，修改增删改的请求地址
        var addUrl = "/jsons/addMajor.form";
        var editUrl = "/jsons/editMajor.form";
        var deleteUrl = "/jsons/deleteMajor.form";
        var editorName = "null";//KindEditor的Textarea的ID，如果没用到，赋值为null
        var imageUpload = "";//图片上传的标识，如果没有图片上传，赋值为空，如果有，赋值为数据库存放图片名称的字段名称，不带_
        var deleteId = "majorId";//用于删除功能的ID参数，赋值为当前数据库表的ID

        $(function(){
            //绑定所选学院的专业类
            $("#majorCollegeId").combobox({
                onChange: function (selectVal, lastVal) {
                    $.post("/jsons/loadMajorType.form",{
                        majorCollegeId:selectVal
                    },function(data){
                        if(data.result){
                            $("#parentMajorId").empty();
                            var option = "<option value='none'>无</option>";
                            var setStatus = false;
                            var row = $('#dg').datagrid('getSelected');
                            for(var i=0;i<data.resultSet.length;i++){
                                if(clickStatus=="edit"&&data.resultSet[i].majorId==row.parentMajorId){
                                    setStatus = true;
                                }
                                option += "<option value='"+data.resultSet[i].majorId+"'>"+data.resultSet[i].majorName+"</option>";
                            }
                            $("#parentMajorId").append(option);
                            $("#parentMajorId").combobox({});

                            //如果是修改，赋值
                            if (row&&clickStatus=="edit"&&setStatus){
                                $('#parentMajorId').combobox('setValue', row.parentMajorId);
                            }
                        }else {
                            ShowMsg("加载专业类出错");
                        }
                    });
                }
            });
            //选择不同学院，加载不同专业
            $("#LoadByCollege").combobox({
                onChange: function (selectVal, lastVal) {
                    $("#dg").datagrid("load",{
                        collegeId:selectVal
                    });
                }
            });
        });
        function Save_before(){
            if(clickStatus=="edit") {
                var row = $('#dg').datagrid('getSelected');
                var parentMajorId = row.parentMajorId;
                var parentMajorId1 = $('#parentMajorId').combobox('getValue');
                if (parentMajorId == 'none' && parentMajorId1 != 'none') {
                    $.messager.alert('警告', "不能修改该专业分类");
                } else {
                    Save();
                }
            }
            if(clickStatus=="add") {
              Save();
            }
        }
        function delete_before(){
            var row = $('#dg').datagrid('getSelected');
            var parentMajorId=row.parentMajorId;
            if(parentMajorId=='none'){
                $.messager.confirm('警告', '删除该专业类前，请保证该专业类内没有其它专业 ',function(r){
                    if(r) {
                        Delete();
                    }else{
                    }
                });
            }else{
                Delete();
            }
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
               url:'/jsons/loadMajor.form'">
        <thead>
            <tr>
                <%--3、第三处修改，修改此处的列名称，与数据库一致，显示有必要的--%>
                <th field="majorId" hidden >ID</th>
                <th field="majorName" width="100px">专业名称</th>
                <th field="majorCollegeId" width="100px" hidden>所属学院</th>
                <th field="majorCollegeName" width="100px">所属学院</th>
                <th field="parentMajorId" width="100px" hidden>专业分类</th>
                <th field="parentMajorName" width="100px">专业分类</th>
                <th field="createMan" width="100px">创建者</th>
                <th field="createDate" width="100px">创建日期</th>
                <th field="updateMan" width="100px">更新者</th>
                <th field="updateDate" width="100px">更新日期</th>
            </tr>
        </thead>
    </table>
    <%--表格头部按钮--%>
    <div id="tb" style="height:auto">
        <%--4、第四处修改，修改菜单按钮，选择哪些按钮需要，其中的增删改查对应的方法名称不要修改--%>
        <select class="easyui-combobox" id="LoadByCollege"
                data-options="editable:false,panelHeight:'auto'" style="min-width:100px;">
            <option value="all" selected>全部学院</option>
            <c:forEach items="${colleges}" var="college">
                <option value="${college.collegeId}">${college.collegeName}</option>
            </c:forEach>
        </select>
        <a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-add',plain:true" onclick="Add()">新建</a>
        <a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-edit',plain:true" onclick="Edit()">修改</a>
        <a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-remove',plain:true" onclick="delete_before()">删除</a>
        <input class="easyui-searchbox" data-options="prompt:'请输入专业名称',searcher:doSearch" style="width:200px"/>
    </div>
    <%--对话框--%>
    <div id="dlg" class="easyui-dialog hide" title=""
         style="width:700px;height:520px;padding:10px;"
         data-options="iconCls: 'icon-save',buttons: '#dlg-buttons',modal:true" closed="true" >
        <%--5、第五处修改，修改表单信息，与上面的列名称一致--%>
        <form id="Form">
            <div style="margin-bottom:10px;margin-top: 10px;display: none;">
                <div class="word">ID:</div>
                <input class="easyui-textbox" name="majorId" id="majorId">
            </div>
            <div style="margin-bottom:10px;margin-top: 10px;">
                <span class="word">专业名称:</span>
                <input class="easyui-textbox" data-options="required:true,validType:'length[1,50]'"
                name="majorName" id="majorName" style="width:400px;height:32px">
            </div>
            <div style="margin-bottom:10px;margin-top: 10px;">
                <span class="word">所属学院:</span>
                <select class="easyui-combobox" name="majorCollegeId" id="majorCollegeId"
                        data-options="required:true,editable:false,panelHeight:'auto'" style="width:200px;height:32px">
                <c:forEach items="${colleges}" var="college">
                    <option value="${college.collegeId}">${college.collegeName}</option>
                </c:forEach>
                </select>
            </div>
            <div style="margin-bottom:10px;margin-top: 10px;">
                <span class="word">专业分类:</span>
                <select class="easyui-combobox" name="parentMajorId" id="parentMajorId"
                        data-options="required:true,editable:false,panelHeight:'auto'" style="width:200px;height:32px">
                    <option value="none">无</option>
                </select>
            </div>
            <div style="margin-bottom:10px;margin-top: 10px;">
                <div class="word">备注:</div>
                <input class="easyui-textbox" data-options="multiline:true,validType:'length[0,100]'"
                       name="majorRemark" id="majorRemark" style="height:100px;width:100%;">
            </div>
        </form>
    </div>
    <%--对话框保存、取消按钮--%>
    <div id="dlg-buttons">
        <a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls: 'icon-ok'" onclick="Save_before()">保存</a>
        <a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls: 'icon-cancel'" onclick="javascript:$('#dlg').dialog('close')">取消</a>
    </div>
</body>
</html>