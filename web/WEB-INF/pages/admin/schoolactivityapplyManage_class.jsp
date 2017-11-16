<%@ page import="java.util.Date" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.Calendar" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: pjj
  Date: 2016/8/20
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
    <script type="text/javascript" src="<%=request.getContextPath()%>/asset/js/studentManager.js"></script>
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
        var addUrl = "/jsons/addSchoolActivityapplyStatus.form";
        var editUrl = "/jsons/editSchoolActivityapplyStatus.form";
        var deleteUrl = "/jsons/deleteSchoolActivityapplyStatus.form";
        var editorName = "null";//KindEditor的Textarea的ID，如果没用到，赋值为null
        var imageUpload = "null";//图片上传的标识，如果没有图片上传，赋值为空，如果有，赋值为数据库存放图片名称的字段名称，不带_
        var deleteId = "applyId";//用于删除功能的ID参数，赋值为当前数据库表的ID
    </script>
    <script>
        // 加载活动选择界面
        $(function(){
            $("#dialog-confirm").dialog({
                resizable: true,
                closable:false
            });
        });
        // 重新加载活动选择界面
        function Back(){
            $("#dialog-confirm").dialog({
                resizable: true,
                closable:false
            });
        }
        // 重写保存方法
        function Save_id(){
            if($("#Form").form('validate')){
                var jsonObject = $("#Form").serializeObject();
                jsonObject["moduleType"] = moduleType;
                if(editorName &&editorName!="null"){
                    editor.sync();
                    jsonObject[editorName] = $("#"+editorName).val();
                }
                if(!jsonObject["applyActivityId"]){
                    jsonObject["applyActivityId"]=$("#sqlActivityId").val();
                }
                load();
                UploadToDatabase(jsonObject);
            }else {
                ShowMsg("请按照要求填写");
            }
        }
        // 重写添加方法
        function Add_id(){
            postURL = addUrl;
            clickStatus = "add";
            var activityParticipation=$("#activityParticipation").val();
            if(activityParticipation=='团体'){
                $.messager.alert('"操作提示"','参与形式为团体申请不允许添加，若想添加团体活动申请在团体管理里添加');
                return
            }
            $("#Form").form("clear");
            $("#dlg").dialog({title: "新建"});
            $("#dlg").dialog('open');
            $("#dlg").get(0).scrollTop=0;
            var activityTitle=$("#activityTitle2").val();
            $("#activityTitle").textbox("setValue",activityTitle);
            $("#applyStudentId").combobox("enable");
        }
        // 重写提交方法
        function submit(){
            var row = $('#qbdlg').datagrid('getSelected');
            if (row){
                var  value1 = row.activityId;
                var  value2 = row.activityTitle;
                var  value3 = row.activityParticipation;
                $("#dg").datagrid("load",{sqlActivityId:value1});
                $('#dialog-confirm').dialog('close');
                $("#sqlActivityId").val(value1);
                $("#activityTitle2").val(value2);
                $("#activityParticipation").val(value3);
            }else {
                ShowMsg("请选中一条数据");
            }
        }
        function uploadActivityFile(){
            if(!$("#upfile").val()){
                ShowMsg("请选择文件！");
                return;
            }
            var activityID=$("#sqlActivityId").val();
            load();
            $.ajaxFileUpload({
                url: "/dataupload/studentinfo.form?activityid="+activityID, //用于文件上传的服务器端请求地址
                secureuri: false, //一般设置为false
                fileElementId: "upfile", //文件上传空间的id属性
                dataType: 'String', //返回值类型 一般设置为String
                success: function (data)  //服务器成功响应处理函数
                {
//                    console.log(data);
                    showResult(data);
                    disLoad();
                    $("#dg").datagrid("reload");
                },
                error: function (data, status, e)//服务器响应失败处理函数
                {
                    ShowMsg("上传文件失败，请重新上传");
                    disLoad();
                }
            });
        }
        function getModels(){
            var activityParticipation=$("#activityParticipation").val();
//            console.log(activityParticipation);
            if(activityParticipation=='团体'){
                $.messager.alert('"操作提示"','参与形式为团体的活动不允许批量添加申请，若想添加申请在团体管理里添加');
                return
            }
            var activityID=$("#sqlActivityId").val();
            if(activityID!=null&&activityID!=""){
                window.open("<%=request.getContextPath()%>/Files/ExcelModels/stu_activityapply.xls");
            }else{
                ShowMsg("请选择一个活动活动")
            }
        }
        //修改
        function Edits(){
            clickStatus = "edit";
            postURL = editUrl;
            var row = $('#dg').datagrid('getSelected');
            if (row){
                if(row.teamName!=null&&row.teamName!=''){
                    $("#applyStudentId").combobox("disable");
                }
                $("#Form").form("clear");
                $('#Form').form('load', row);
                if(editorName!="null"){//为KindEditor赋值
                    KindEditor.instances[0].html(row[editorName]);
                }
                $("#dlg").dialog({title: "修改"});
                $("#dlg").dialog('open');
                $("#dlg").get(0).scrollTop=0;
            }else {
                ShowMsg("请选中一条数据");
            }
        }
        //删除
        function Deletes(){
            clickStatus = "delete";
            postURL = deleteUrl;
            var row = $('#dg').datagrid('getSelected');
            if (row){
                if(row.teamName){
                    $.messager.alert('"操作提示"','参与形式为团体申请不允许删除，若想取消申请请在团体管理里删除');
                    return
                }
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
        function reloadThisPage(){
            $("#dg").datagrid("reload");
        }
        <%--判断是否是登录状态--%>
        <%--<%@include file="../common/CheckLogin.jsp"%>--%>
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
              url:'/jsons/loadSchoolActivityapply.form'">
    <thead>
    <tr>
        <%--3、第三处修改，修改此处的列名称，与数据库一致，显示有必要的--%>
        <th field="applyId" hidden>ID</th>
        <th field="activityTitle"  >活动标题</th>
        <th field="applyStudentId"  >学生学号</th>
        <th field="studentName" >学生姓名</th>
        <th field="applyDate" >申请日期</th>
         <th field="applyAuditStatus" >审核状态</th>
        <th field="activityAwardMean" >获奖情况</th>
        <th field="signUpStatus"  >签到状态</th>
        <th field="signUpTime"  >签到时间</th>
        <th field="activityParticipation">参与形式</th>
        <th field="teamName"  >团体名字</th>
    </tr>
    </thead>
</table>
<%--表格头部按钮--%>
<div id="tb" style="height:auto">
    <%--4、第四处修改，修改菜单按钮，选择哪些按钮需要--%>
    <a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-add',plain:true" onclick="Add_id()">新建</a>
        <a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-edit',plain:true" onclick="Edits()">评奖</a>
    <a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-remove',plain:true" onclick="Deletes()">删除</a>
    <a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-remove',plain:true" onclick="Back()">重新选择活动</a>
    <a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-reload',plain:true" onclick="reloadThisPage()">刷新当前页</a>
    <a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-add',plain:true" onclick="batchInsert()">导入学生信息</a>
    <a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-add',plain:true" onclick="getModels()">下载模版</a>
    <input class="easyui-searchbox" data-options="prompt:'请输入活动标题',searcher:doSearch" style="width:200px"/>
</div>
<%--对话框--%>
<div id="dlg" class="easyui-dialog hide" title=""
     style="width:750px;height:620px;padding:10px;"
     data-options="iconCls: 'icon-save',buttons: '#dlg-buttons',modal:true,top:'10%'" closed="true" >
    <%--5、第五处修改，修改表单信息，与上面的列名称一致--%>
    <form id="Form">
        <div style="margin-bottom:10px;margin-top: 10px;display: none">
            <span class="word">ID</span>
            <input class="easyui-textbox"  name="applyId" id="applyId"
                   style="width:200px;height:32px">
        </div>
        <div  style="margin-bottom:10px;margin-top: 10px;">
            <span class="word">活动标题</span>
            <input class="easyui-textbox" data-options="required:true,validType:'length[1,50]',disabled:true"
                   name="activityTitle" id="activityTitle" style="width:200px;height:32px">
        </div>
        <div  style="margin-bottom:10px;margin-top: 10px;">
            <span class="word">学生学号</span>
            <input class="easyui-textbox" data-options="required:true,validType:'length[1,50]',disabled:true"
                   name="applyStudentId" id="applyStudentId" style="width:200px;height:32px">
        </div>
        <%--<div style="margin-bottom:10px;margin-top: 10px;">--%>
            <%--<span class="word">审核状态:</span>--%>
            <%--<select class="easyui-combobox" name="applyAuditStatus" id="applyAuditStatus"--%>
                    <%--data-options="required:true,editable:false,panelHeight:'auto'" style="width:200px;height:32px">--%>
                <%--<option>已通过</option>--%>
                <%--<option>未通过</option>--%>
                <%--<option>待处理</option>--%>
            <%--</select>--%>
        <%--</div>--%>
        <div style="margin-bottom:10px;margin-top: 10px;">
            <span class="word">获奖情况:</span>
            <select class="easyui-combobox" name="activityAward" id="activityAward"
                    data-options="required:true,editable:false,panelHeight:'auto'" style="width:200px;height:32px">
                <c:forEach items="${activityAwards}" var="activityAward">
                    <option value="${activityAward.dictvalue}">${activityAward.dictmean}</option>
                </c:forEach>
            </select>
        </div>
        <div  style="margin-bottom:10px;margin-top: 10px;">
            <span class="word">申请日期</span>
            <input class="easyui-datebox" data-options="required:true,validType:'length[1,50]',disabled:true"
                   name="applyDate" id="applyDate" style="width:200px;height:32px">
        </div>
        <div style="margin-bottom:10px;margin-top: 10px;">
            <span class="word">签到状态</span>
            <input class="easyui-datebox" name="signUpStatus" id="signUpStatus"
                   data-options="disabled:true"
                   style="width:200px;height:32px">
        </div>
        <div style="margin-bottom:10px;margin-top: 10px;">
            <span class="word">签到时间</span>
            <input class="easyui-datebox" name="signUpTime" id="signUpTime"
                   data-options="disabled:true"
                   style="width:200px;height:32px">
        </div>
        <div style="margin-bottom:10px;margin-top: 10px;">
            <span class="word">团体名字</span>
            <input class="easyui-textbox" name="teamName" id="teamName"
                   data-options="disabled:true"
                   style="width:200px;height:32px">
        </div>
    </form>
</div>
<%--对话框保存、取消按钮--%>
<div id="dlg-buttons">
    <a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls: 'icon-ok'" onclick="Save_id()">保存</a>
    <a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls: 'icon-cancel'" onclick="javascript:$('#dlg').dialog('close')">取消</a>
</div>
<%-- 弹出页面 --%>
<div id="dialog-confirm" title="活动选择页面"
     data-options="iconCls: 'icon-save',buttons: '#qbdlg-buttons',modal:true,top:'10%'">
    <table id="qbdlg" class="easyui-datagrid" style="width:550px;height:300px"
           data-options="pagination:true,
               rownumbers:true,
               singleSelect:true,
               method:'post',
               autoRowHeight:false,
               fitColumns:false,
               <%--2、第二处修改，修改此处的Json服务，用于加载数据--%>
              url:'/jsons/loadSchoolActivity.form'">
        <thead>
        <tr>
            <%--3、第三处修改，修改此处的列名称，与数据库一致，显示有必要的--%>
            <th field="activityId" hidden >活动ID</th>
            <th field="activityCreatedate" >活动创建时间</th>
            <th field="activityTitle" >活动标题</th>
            <th field="activityLocation" >活动地点</th>
            <th field="activityParticipation" >参与形式</th>
            <th field="activitySdate" >活动起始时间</th>
            <th field="activityEdate" >活动截止时间</th>

        </tr>
        </thead>
    </table>
</div>
<%--弹出页面的对话框提交、取消按钮--%>
<div id="qbdlg-buttons">
    <a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls: 'icon-ok'" onclick="submit()">提交</a>
    <a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls: 'icon-cancel'" onclick="javascript:$('#dialog-confirm').dialog('close')">取消</a>

</div>
<%--3个隐藏域，用来提交数据，赋值--%>
<input type="easyui-textbox" style="display: none" id="sqlActivityId" name="sqlActivityId" >
<input type="easyui-textbox" style="display: none" id="activityTitle2" name="activityTitle2" >
<input type="easyui-textbox" style="display: none" id="activityParticipation" name="activityParticipation" >
<%--批量导入对话框--%>
<div id="batch_dlg" class="easyui-dialog hide" title="批量导入" style="width:600px;height:420px;padding:10px;"
     data-options="iconCls: 'icon-save',buttons: '#batch_dlg_buttons',modal:true,top:'10%'" closed="true" >
    <div id="file_box" class="fitem">
        <label>选择文件:</label>
        <input id="upfile" class=" input_ele" name="fileup" type="file"/>
    </div>
    <div id="_box" class="fitem">
        <label></label>
    </div>
    <div id="btn_box" class="fitem">
        <label></label>
        <a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls: 'icon-ok'" onclick="validFile()">验证文件</a>&nbsp;&nbsp;&nbsp;&nbsp;
        <a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls: 'icon-save'" onclick="uploadActivityFile()">上传并导入</a>
    </div>
    <div id="result_box" class="fitem">
        <label>操作结果:</label>
        <br>
        <label></label>
        <div id="valid_result" class=" input_ele" style="width: 390px;height: 200px;border: 1px solid #95B8E7;overflow: auto"></div>
    </div>
</div>
</body>
</html>