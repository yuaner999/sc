<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: admin
  Date: 2016/5/9
  Time: 11:37
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
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
        var moduleType = GetQueryString("moduleType");//所属模块的ID，不可以删除
        //1、第一处修改，修改增删改的请求地址
        var addUrl = "/jsons/addClass.form";
        var editUrl = "/jsons/editClass.form";
        var deleteUrl = "/jsons/deleteClass.form";
        var editorName = "null";//KindEditor的Textarea的ID，如果没用到，赋值为null
        var imageUpload = "";//图片上传的标识，如果没有图片上传，赋值为空，如果有，赋值为数据库存放图片名称的字段名称，不带_
        var deleteId = "classId";//用于删除功能的ID参数，赋值为当前数据库表的ID

        $(function(){
            //绑定所选学院的专业类
            $("#classCollegeId").combobox({
                onChange: function (selectVal, lastVal) {
                    $.post("/jsons/loadMajorType.form",{
                        majorCollegeId:selectVal
                    },function(data){
                        if(data.result){
                            $('#classMajorKindId').combobox('clear');
                            $('#classMajorKindId').combobox('loadData',data.resultSet);
                            var row = $('#dg').datagrid('getSelected');
                            var setStatus = false;//完善修改时赋值出现ID的Bug
                            for(var i=0;i<data.resultSet.length;i++){
                                if(clickStatus=="edit"&&data.resultSet[i].majorId==row.classMajorKindId){
                                    setStatus = true;
                                }
                            }
                            if(data.resultSet.length>0&&clickStatus=="add"){
                                $('#classMajorKindId').combobox('setValue',data.resultSet[0].majorId);
                            }
                            //如果是修改，赋值
                            if (row&&clickStatus=="edit"&&setStatus){
                                $('#classMajorKindId').combobox('setValue', row.classMajorKindId);
                            }
                        }else {
                            ShowMsg("加载专业类出错");
                        }
                    });
                }
            });
            //绑定所选专业类的专业
            $("#classMajorKindId").combobox({
                onChange: function (selectVal, lastVal) {
                    $.post("/jsons/loadSeletMajor.form",{
                        parentMajorId:selectVal
                    },function(data){
                        if(data.result){
                            var row = $('#dg').datagrid('getSelected');
                            var setStatus = false;
                            $("#classMajorId").empty();
                            var option = "<option value='none'>无</option>";
                            for(var i=0;i<data.resultSet.length;i++){
                                if(clickStatus=="edit"&&data.resultSet[i].majorId==row.classMajorId){
                                    setStatus = true;
                                }
                                option += "<option value='"+data.resultSet[i].majorId+"'>"+data.resultSet[i].majorName+"</option>";
                            }
                            $("#classMajorId").append(option);
                            $("#classMajorId").combobox({});

                            //如果是修改，赋值
                            if (row&&clickStatus=="edit"&&setStatus){
                                $('#classMajorId').combobox('setValue', row.classMajorId);
                            }
                        }else {
                            ShowMsg("加载专业出错");
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
               url:'/jsons/loadClass.form'">
        <thead>
            <tr>
                <%--3、第三处修改，修改此处的列名称，与数据库一致，显示有必要的--%>
                <th field="classId" hidden >ID</th>
                <th field="className" width="100px">班级名称</th>
                <th field="classCollegeId" width="100px" hidden>所属学院</th>
                <th field="classCollegeName" width="100px">所属学院</th>
                <th field="classMajorKindId" width="100px" hidden>专业分类</th>
                <th field="classMajorKindName" width="100px">专业分类</th>
                <th field="classMajorId" width="100px" hidden>所属专业</th>
                <th field="classMajorName" width="100px">所属专业</th>
                <th field="classGradeId" width="100px" hidden>所属年级</th>
                <th field="classGradeName" width="100px">所属年级</th>
                <th field="classRemark" width="100px" hidden>备注</th>
                <th field="createMan" width="100px">创建者</th>
                <th field="createDate" width="100px">创建日期</th>
                <th field="updateMan" width="100px">更新者</th>
                <th field="updateDate" width="100px">更新日期</th>
            </tr>
        </thead>
    </table>
    <%--表格头部按钮--%>
    <div id="tb" style="height:auto">
        <%--4、第四处修改，修改菜单按钮，选择哪些按钮需要--%>
        <a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-add',plain:true" onclick="Add()">新建</a>
        <a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-edit',plain:true" onclick="Edit()">修改</a>
        <a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-remove',plain:true" onclick="Delete()">删除</a>
        <input class="easyui-searchbox" data-options="prompt:'请输入班级名称',searcher:doSearch" style="width:200px"/>
    </div>
    <%--对话框--%>
    <div id="dlg" class="easyui-dialog hide" title=""
         style="width:400px;height:520px;padding:10px;"
         data-options="iconCls: 'icon-save',buttons: '#dlg-buttons',modal:true" closed="true" >
        <%--5、第五处修改，修改表单信息，与上面的列名称一致--%>
        <form id="Form">
            <div style="margin-bottom:10px;margin-top: 10px;display: none;">
                <div class="word">ID:</div>
                <input class="easyui-textbox" name="classId" id="classId">
            </div>
            <div style="margin-bottom:10px;margin-top: 10px;">
                <span class="word">班级名称:</span>
                <input class="easyui-textbox" data-options="required:true,validType:'length[1,50]'"
                       name="className" id="className" style="width:200px;height:32px">
            </div>
            <div style="margin-bottom:10px;margin-top: 10px;">
                <span class="word">所属年级:</span>
                <select class="easyui-combobox" name="classGradeId" id="classGradeId"
                        data-options="required:true,editable:false,panelHeight:'auto'" style="width:200px;height:32px">
                    <c:forEach items="${grades}" var="grade">
                        <option value="${grade.gradeId}">${grade.gradeName}</option>
                    </c:forEach>
                </select>
            </div>
            <div style="margin-bottom:10px;margin-top: 10px;">
                <span class="word">所属学院:</span>
                <select class="easyui-combobox" name="classCollegeId" id="classCollegeId"
                        data-options="required:true,editable:false,panelHeight:'auto'" style="width:200px;height:32px">
                    <c:forEach items="${colleges}" var="college">
                        <option value="${college.collegeId}">${college.collegeName}</option>
                    </c:forEach>
                </select>
            </div>
            <div style="margin-bottom:10px;margin-top: 10px;">
                <span class="word">专业分类:</span>
                <select class="easyui-combobox" name="classMajorKindId" id="classMajorKindId"
                        data-options="required:true,editable:false,panelHeight:'auto',valueField:'majorId',textField:'majorName'"
                        style="width:200px;height:32px">
                </select>
            </div>
            <div style="margin-bottom:10px;margin-top: 10px;">
                <span class="word">所属专业:</span>
                <select class="easyui-combobox" name="classMajorId" id="classMajorId"
                        data-options="editable:false,panelHeight:'auto'" style="width:200px;height:32px">
                    <option value="none">无</option>
                </select>
            </div>
            <div style="margin-bottom:10px;margin-top: 10px;">
                <div class="word">备注:</div>
                <input class="easyui-textbox" data-options="multiline:true,validType:'length[0,100]'"
                       name="classRemark" id="classRemark" style="height:100px;width:350px;">
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