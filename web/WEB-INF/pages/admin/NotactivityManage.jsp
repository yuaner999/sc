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
    <script type="text/javascript" src="<%=request.getContextPath()%>/asset/js/ajaxfileupload.js"></script>
    <script type="text/javascript" src="<%=request.getContextPath()%>/asset/js/studentManager.js"></script>
    <%--本页引用的CSS--%>
    <style>#dlg .textbox .textbox-text{font-size:15.5555px;}</style>
    <style>.test{width: 16px;height: 16px; /* line-height: 8px; */ /* margin-top: 4px; */ position: relative; top: 3px; }</style>
    <style>#dlg{font-size:16px;}</style>
    <script>
        var moduleType = GetQueryString("moduleType");//所属模块的ID，不可以删除
        //1、第一处修改，修改增删改的请求地址
        var addUrl = "/jsons/saveNotactivity.form";
        var editUrl = "/jsons/editNotactivity.form";
        var deleteUrl = "/jsons/deleteNotactivity.form";
        var editorName = "null";//KindEditor的Textarea的ID，如果没用到，赋值为null
        var imageUpload = "null";//图片上传的标识，如果没有图片上传，赋值为空，如果有，赋值为数据库存放图片名称的字段名称，不带_
        var deleteId = "notid";//用于删除功能的ID参数，赋值为当前数据库表的ID
        $(function(){
            //加载不同的工作组织名称
            $("#workLevle").combobox({onChange:function(newvalue) {
                $.ajax({
                    url: "/jsons/loadOrganizationName.form",
                    type:"post",
                    data: {workLevle: newvalue},
                    dataType: "json",
                    success: function (data) {
                        $('#organizationName').combobox("loadData",{});
                        if(data.rows !=null && data.rows.length > 0) {
                            $("#organizationName").combobox({valueField: 'organizationName', textField: 'organizationName', panelHeight: 'auto'}).combobox("loadData", data.rows)
                                    .combobox('select', data.rows[0].organizationName,data.rows[0].organizationName);
                        }else{
                            $("#organizationName").combobox("setText","无");
                        }
                    }
                });
            }
            });
            //加载不同的学生处职务名称
            $("#organizationName").combobox({onChange:function(newvalue) {
                $.ajax({
                    url: "/jsons/loadSchoolworkName.form",
                    data: {organizationName: newvalue},
                    type:"post",
                    dataType: "json",
                    success: function (data) {
                        $('#schoolworkName').combobox("loadData",{});
                        if(data.rows !=null && data.rows.length > 0) {
                            $("#schoolworkName").combobox({valueField: 'schoolworkName', textField: 'schoolworkName', panelHeight: 'auto'}).combobox("loadData", data.rows)
                                    .combobox('select', data.rows[0].schoolworkName,data.rows[0].schoolworkName);
                        }else{
                            $("#schoolworkName").combobox("setText","无");
                        }
                    }
                });
            }
            });
            $("#status_filter").combobox({onChange:function(value){
                $.ajax({
                    url:"/jsons/loadNotactivity.form",
                    type:"post",
                    data:{filter:value},
                    dataType:"json",
                    success:function(data){
                        $("#dg").datagrid("loadData",data);
                    }
                });
            }}) ;
            $(".workLevle").hide();
            $(".organizationName").hide();
            $(".schoolworkName").hide();
            $(".classworkName").hide();
            $(".scienceClass").hide();
            $(".scienceName").hide();
            $(".shiptypeName").hide();
            $(".typeName").hide();
            $("#notClass").combobox({onChange:function(value){
                if($(this).combobox("getValue")=="社会工作类"){
                    $(".workLevle").addClass("showed");
                    $(".workLevle").slideDown(300);
                    $(".organizationName").addClass("showed");
                    $(".organizationName").slideDown(300);
                    $(".schoolworkName").addClass("showed");
                    $(".schoolworkName").slideDown(300);
                    $(".classworkName").addClass("showed");
                    $(".classworkName").slideDown(300);
                    $(".scienceClass").removeClass("showed");
                    $(".scienceClass").slideUp(300);
                    $(".scienceName").removeClass("showed");
                    $(".scienceName").slideUp(300);
                    $(".shiptypeName").removeClass("showed");
                    $(".shiptypeName").slideUp(300);
                }
                if($(this).combobox("getValue")=="学术与科技类"){
                    $(".scienceClass").addClass("showed");
                    $(".scienceClass").slideDown(300);
                    $(".scienceName").addClass("showed");
                    $(".scienceName").slideDown(300);
                    $(".workLevle").removeClass("showed");
                    $(".workLevle").slideUp(300);
                    $(".organizationName").removeClass("showed");
                    $(".organizationName").slideUp(300);
                    $(".schoolworkName").removeClass("showed");
                    $(".schoolworkName").slideUp(300);
                    $(".classworkName").removeClass("showed");
                    $(".classworkName").slideUp(300);
                    $(".shiptypeName").removeClass("showed");
                    $(".shiptypeName").slideUp(300);
                }
                if($(this).combobox("getValue")=="奖学金类"){
                    $(".shiptypeName").addClass("showed");
                    $(".shiptypeName").slideDown(300);
                    $(".workLevle").removeClass("showed");
                    $(".workLevle").slideUp(300);
                    $(".organizationName").removeClass("showed");
                    $(".organizationName").slideUp(300);
                    $(".schoolworkName").removeClass("showed");
                    $(".schoolworkName").slideUp(300);
                    $(".classworkName").removeClass("showed");
                    $(".classworkName").slideUp(300);
                    $(".scienceClass").removeClass("showed");
                    $(".scienceClass").slideUp(300);
                    $(".scienceName").removeClass("showed");
                    $(".scienceName").slideUp(300);
                }
            }});
            $(".typeName").hide();
            $("#shiptypeName").combobox({onChange:function(value){
//                console.log($(this).val());
                if($(this).combobox("getValue")=="命名奖学金"){
                    $(".typeName").addClass("showed");
                    $(".typeName").slideDown(300);
                }else{
                    $(".typeName").removeClass("showed");
                    $(".typeName").slideUp(300);
                }
            }
            });
        });
        function editMores(){
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
            $("#userphoto_span").show();
            $("#userphoto_box").show();
            var databasephoto=row.sciencePhoto;
            if(databasephoto){
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
            };
            $("#notStudentId").textbox({ disabled:true });
            $("#notClass").combobox({ disabled:true });
            $("#workLevle").combobox({ disabled:true });
            $("#organizationName").combobox({ disabled:true });
            $("#schoolworkName").combobox({ disabled:true });
            $("#classworkName").combobox({ disabled:true });
            $("#scienceClass").combobox({ disabled:true });
            $("#scienceName").textbox({ disabled:true });
            $("#shiptypeName").combobox({ disabled:true });
            Edit();
        }
        function reloadThis(){
            $("#dg").datagrid("reload");
        }
        //新建
        function Add_befor(){
            $("#userphoto_span").hide();
            $("#userphoto_box").hide();
            $(".workLevle").hide();
            $(".organizationName").hide();
            $(".schoolworkName").hide();
            $(".classworkName").hide();
            $(".scienceClass").hide();
            $(".scienceName").hide();
            $(".shiptypeName").hide();
            $("#notStudentId").textbox("enable");
            $("#notClass").combobox("enable");
            $("#workLevle").combobox("enable");
            $("#organizationName").combobox("enable");
            $("#schoolworkName").combobox("enable");
            $("#classworkName").combobox("enable");
            $("#scienceClass").combobox("enable");
            $("#scienceName").textbox("enable");
            $("#shiptypeName").combobox("enable");
            Add();
        }
        function getModels(){
            window.open("<%=request.getContextPath()%>/Files/ExcelModels/Notactivity_stu.xls");
        }
        //保存
        function Saves(){
            if($("#Form").form('validate')){
                var jsonObject = $("#Form").serializeObject();
                jsonObject["moduleType"] = moduleType;
                if(editorName &&editorName!="null"){
                    editor.sync();
                    jsonObject[editorName] = $("#"+editorName).val();
                }
                if(!jsonObject["politicsStatusDate"]){
                    jsonObject["politicsStatusDate"]=null;
                }
                if(!jsonObject["studentBirthday"]){
                    jsonObject["studentBirthday"]=null;
                }
                if(jsonObject["shiptypeName"]=="命名奖学金"){
                    jsonObject["shiptypeName"]=$("#typeName").textbox("getValue");
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
               url:'/jsons/loadNotactivity.form'">
        <thead>
            <tr>
                <%--3、第三处修改，修改此处的列名称，与数据库一致，显示有必要的--%>
                    <th field="notid" hidden >非活动类id</th>
                    <th field="notStudentId"  >学生学号</th>
                    <th field="studentName"  >学生姓名</th>
                    <th field="notClass">非活动类别</th>
                    <th field="workLevle" >社会工作级别</th>
                    <th field="organizationName" >工作组织名称</th>
                    <th field="schoolworkName" >学生处职务名称</th>
                    <th field="classworkName" >班级职务名称</th>
                    <th field="scienceClass" >学术科技类别</th>
                    <th field="scienceName" >学术科技名称</th>
                    <th field="shiptypeName" >奖学金类别名字</th>
                    <th field="createDate" >申请日期</th>
                    <th field="auditStatus" >审核状态</th>
                    <th field="auditStatusDate" >审核时间</th>
                    <th field="auditStatusName" >审核人</th>
            </tr>
        </thead>
    </table>
    <%--表格头部按钮--%>
    <div id="tb" style="height:auto">
        <select class="easyui-combobox" name="filter" id="status_filter"
                data-options="required:true,editable:false,panelHeight:'auto'" style="width:100px">
            <option value="" selected>全部信息</option>
            <option value="已通过">已通过</option>
            <option value="未通过">未通过</option>
            <option value="待处理">待处理</option>
        </select>
        <%--4、第四处修改，修改菜单按钮，选择哪些按钮需要--%>
        <a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-add',plain:true" onclick="Add_befor()">新建</a>
        <a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-edit',plain:true" onclick="editMores()">审核</a>
        <a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-remove',plain:true" onclick="Delete()">删除</a>
        <a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-add',plain:true" onclick="batchInsert()">导入非活动类</a>
        <a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-add',plain:true" onclick="getModels()">下载模版</a>
        <a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-reload',plain:true" onclick="reloadThis()">刷新当前页</a>

        <input class="easyui-searchbox" data-options="prompt:'请输入学生姓名',searcher:doSearch" style="width:200px"/>
    </div>
    <%--对话框--%>
    <div id="dlg" class="easyui-dialog hide font1" title=""
         style="width:600px;height:700px;padding:10px;top: 0px;"
         data-options="iconCls: 'icon-save',buttons: '#dlg-buttons',modal:true" closed="true">
        <%--5、第五处修改，修改表单信息，与上面的列名称一致--%>
        <form id="Form">
            <div id="userphoto_box" style="height: 20px; width: 230px;">
                <img id="user_photo" src="<%=request.getContextPath()%>/asset/image/default.jpg" onerror="onerror=null;src='/Files/Images/default.jpg'"  style="width: 250px;height: 150px;margin-right: 13px;margin-left: 13px;margin-top: 2px;">
            </div>
            <div style="margin-bottom:10px;margin-top: 140px;" id="userphoto_span">
             <span style="color:#E41D1D;" >
                       注：点击可以切换下一张,<span id="index"></span>共<span id="ids"></span>张</span>
            </div>
            <div style="margin-bottom:10px;margin-top: 10px;display: none;">
                <div class="word">ID:</div>
                <input class="easyui-textbox" name="notid" id="notid">
            </div>
            <div style="margin-bottom:10px;margin-top: 10px;" class="NotStudentId">
                <span class="word">学生的学号:</span>
                <input class="easyui-textbox" data-options="required:true,validType:'length[1,50]'"
                       name="notStudentId" id="notStudentId" style="width:200px;height:32px">
            </div>
            <div style="margin-bottom:10px;margin-top: 10px;" >
                <span class="word">非活动类别:</span>
                <select class="easyui-combobox" name="notClass" id="notClass"
                        data-options="required:true,editable:false,panelHeight:'auto'" style="width:200px;height:32px">
                    <option value="社会工作类">社会工作类</option>
                    <option value="学术与科技类">学术与科技类</option>
                    <option value="奖学金类">奖学金类</option>
                </select>
            </div>
            <div style="margin-bottom:10px;margin-top: 10px;" class="workLevle">
                <span class="word">工作的级别:</span>
                <select class="easyui-combobox" name="workLevle" id="workLevle"
                        data-options="editable:false,panelHeight:'auto'" style="width:200px;height:32px">
                    <c:forEach items="${workLevles}" var="workLevle">
                        <option value="${workLevle.workLevle}">${workLevle.workLevle}</option>
                    </c:forEach>
                </select>
            </div>
            <div style="margin-bottom:10px;margin-top: 10px;" class="organizationName">
                <span class="word">工作组织名:</span>
                <select class="easyui-combobox" name="organizationName" id="organizationName"
                        data-options="editable:false,panelHeight:'auto'" style="width:200px;height:32px">
                </select>
            </div>
            <div style="margin-bottom:10px;margin-top: 10px;" class="schoolworkName">
                <span class="word">学生处职务:</span>
                <select class="easyui-combobox" name="schoolworkName" id="schoolworkName"
                        data-options="editable:false,panelHeight:'auto'" style="width:200px;height:32px">
                </select>
            </div>
            <div style="margin-bottom:10px;margin-top: 10px;" class="classworkName">
                <span class="word">班级职务名:</span>
                <select class="easyui-combobox" name="classworkName" id="classworkName"
                        data-options="editable:false,panelHeight:'auto'" style="width:200px;height:32px">
                    <c:forEach items="${classworkNames}" var="classworkName">
                        <option value="${classworkName.classworkName}">${classworkName.classworkName}</option>
                    </c:forEach>
                </select>
            </div>
            <div style="margin-bottom:10px;margin-top: 10px;" class="scienceClass">
                <span class="word">学术科技类:</span>
                <select class="easyui-combobox" name="scienceClass" id="scienceClass"
                        data-options="editable:false,panelHeight:'auto'" style="width:200px;height:32px">
                    <c:forEach items="${sciencetechnologys}" var="sciencetechnology">
                        <option value="${sciencetechnology.scienceClass}">${sciencetechnology.scienceClass}</option>
                    </c:forEach>
                </select>
            </div>
            <div style="margin-bottom:10px;margin-top: 10px;" class="scienceName">
                <span class="word">学术科技名:</span>
                <input class="easyui-textbox" data-options="validType:'length[1,50]'"
                       name="scienceName" id="scienceName" style="width:200px;height:32px">
            </div>
            <div style="margin-bottom:10px;margin-top: 10px;" class="shiptypeName">
                <span class="word">奖学金类别:</span>
                <select class="easyui-combobox" name="shiptypeName" id="shiptypeName"
                        data-options="editable:false,panelHeight:'auto'" style="width:200px;height:32px">
                    <option value="学期奖学金">学期奖学金</option>
                    <option value="国家奖学金">国家奖学金</option>
                    <option value="命名奖学金">命名奖学金</option>
                </select>
            </div>
            <div style="margin-bottom:10px;margin-top: 10px;" class="typeName">
                <span class="word">奖学金名称:</span>
                <input class="easyui-textbox" data-options="validType:'length[1,50]'"
                       name="typeName" id="typeName" style="width:200px;height:32px">
            </div>
            <div style="margin-bottom:10px;margin-top: 10px;" class="auditStatus">
                <span class="word">审核状态:&nbsp;&nbsp;&nbsp;</span>
                <select class="easyui-combobox" name="auditStatus" id="auditStatus"
                        data-options="required:true,editable:false,panelHeight:'auto'" style="width:200px;height:32px">
                    <option value="已通过">已通过</option>
                    <option value="未通过">未通过</option>
                    <option value="待处理">待处理</option>
                </select>
            </div>
</form>
    </div>
    <%--对话框保存、取消按钮--%>
    <div id="dlg-buttons">
        <a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls: 'icon-ok'" onclick="Saves()">保存</a>
        <a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls: 'icon-cancel'" onclick="javascript:$('#dlg').dialog('close')">取消</a>
    </div>
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
            <a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls: 'icon-save'" onclick="uploadFile()">上传并导入</a>
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