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
    <script type="text/javascript" src="<%=request.getContextPath()%>/asset/js/studentManager.js"></script>
    <style>.test{width: 16px;height: 16px; /* line-height: 8px; */ /* margin-top: 4px; */ position: relative; top: 3px; }</style>
    <style>#dlg .textbox .textbox-text{font-size:15.5555px;}</style>
    <style>#dlg{font-size:16px;}</style>

    <script>
        var moduleType = GetQueryString("moduleType");//所属模块的ID，不可以删除
        //1、第一处修改，修改增删改的请求地址
        var addUrl = "";
        var editUrl = "";
        var deleteUrl = "";
        var editorName = "";//KindEditor的Textarea的ID，如果没用到，赋值为null
        var imageUpload = "";//图片上传的标识，如果没有图片上传，赋值为空，如果有，赋值为数据库存放图片名称的字段名称，不带_
        var deleteId = "";//用于删除功能的ID参数，赋值为当前数据库表的ID

        /**
         * 刷新当前页
         */
        function reloadThis(){
            $("#dg").datagrid("reload");
        }
        /*
        * 下载模板
        * */
        function getModels(){
            window.open("<%=request.getContextPath()%>/Files/ExcelModels/apply_activities.xls");
        }
        function uploadFiles(){
            if(!$("#upfile").val()){
                ShowMsg("请选择文件！");
                return;
            }
            load();
            $.ajaxFileUpload({
                url: "/dataupload/studentinfo.form", //用于文件上传的服务器端请求地址
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
    </script>
    <%--判断是否是登录状态--%>
    <%--<%@include file="../common/CheckLogin.jsp"%>--%>
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
               url:'/jsons/loadActivities_upload.form'">
        <thead>
            <tr>
                <%--3、第三处修改，修改此处的列名称，与数据库一致，显示有必要的--%>
                        <th field="activityId" hidden >ID</th>
                        <th field="activityTitle"width="100px" >活动标题</th>
                        <th field="applyStudentId" width="100px">学生学号</th>
                        <th field="studentName" width="100px">学生姓名</th>
                        <%--<th field="activityCreator" width="100px">创建者</th>--%>
                        <%--<th field="activityCreatedate">创建日期</th>--%>
                        <%--<th field="otherActivityPoint" >获得分数</th>--%>
                        <th field="activityClassMean" width="100px">活动类型</th>
                        <th field="activityLevleMean" width="100px">活动级别</th>
                        <th field="activityNatureMean" width="100px" >活动性质</th>
                        <th field="activityAwardMean" width="100px">获奖情况</th>
                        <%--<th field="activityIsInschool" width="100px" >校内校外</th>--%>
                        <th field="activityLocation" width="100px">活动地点</th>
                        <th field="activityParticipation" width="100px" >参与形式</th>
                        <%--<th field="activitySdate" width="100px">开始日期</th>--%>
                        <%--<th field="activityEdate" width="100px">结束日期</th>--%>
                        <%--<th field="activityCreator" width="100px">创建者</th>--%>
                        <%--<th field="activityCreatedate" width="100px">创建日期</th>--%>
                        <%--<th field="signUpTime" width="100px">签到日期</th>--%>
                        <%--<th field="signUpStatus" width="100px" >签到状态</th>--%>
                        <th field="applyDate" width="100px">申请日期</th>
                        <%--<th field="applyAuditStatus" width="100px" >审核状态</th>--%>
                    <%-- <th field="activityFilter" width="100px" hidden>条件过滤</th>--%>
                    <%-- <th field="activityFilterType" width="100px" hidden>活动限制条件的类型</th>--%>
                    <%-- <th field="activityIsDelete" width="100px">是否被删除</th>--%>
                    <%--<th field="activityFilterType" width="100px">活动限制</th>--%>
                    <%-- <th field="activityPowers" width="100px">增加能力</th>--%>



            </tr>
        </thead>
    </table>
    <%--表格头部按钮--%>
    <div id="tb" style="height:auto">
        <%--4、第四处修改，修改菜单按钮，选择哪些按钮需要--%>
            <a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-reload',plain:true" onclick="reloadThis()">刷新当前页</a>
            <a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-add',plain:true" onclick="batchInsert()">导入活动信息</a>
            <a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-add',plain:true" onclick="getModels()">下载模版</a>
        <input class="easyui-searchbox" data-options="prompt:'请输入活动标题',searcher:doSearch" style="width:200px"/>
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
            <a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls: 'icon-save'" onclick="uploadFiles()">上传并导入</a>
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