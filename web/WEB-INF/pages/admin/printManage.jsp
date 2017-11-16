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
    <script type="text/javascript" src="<%=request.getContextPath()%>/asset/layer/layer.js"></script>
    <script type="text/javascript" src="<%=request.getContextPath()%>/asset/js/laydate/laydate.js"></script>
    <script type="text/javascript">
        var moduleType = GetQueryString("moduleType");//所属模块的ID，不可以删除
        //1、第一处修改，修改增删改的请求地址
        var addUrl = "";
        var editUrl = "";
        var deleteUrl = "";
        var editorName = "null";//KindEditor的Textarea的ID，如果没用到，赋值为null
        var imageUpload = "";//图片上传的标识，如果没有图片上传，赋值为空，如果有，赋值为数据库存放图片名称的字段名称，不带_
        var deleteId = "";//用于删除功能的ID参数，赋值为当前数据库表的ID

        /**
         * 日期格式化
         */
        function dateFormater(Value){
            if(!Value) return "";
            return laydate.now(Value,"YYYY-MM-DD hh:mm:ss");
        }

        /**
         * 审核
         * @param action
         */
        function auditAction(action){
            var row=$("#dg").datagrid("getSelected");
            if(!row) {
                ShowMsg("请先选择一行数据！")
                return;
            }
            var status=row.printAuditstatus;
            if(status){
                ShowMsg("已审核过的打印申请不可以再次审核！")
                return;
            }
            var printid=row.printId;
            layer.load(1,{shade:[0.4,'#000000']});
            $.ajax({
                url:"/printBack/changeAuditstatus.form",
                type:"post",
                dataType:"json",
                data:{printid:printid,status:action},
                success:function(data){
                    if(data.status==0){
                        $("#dg").datagrid("load");
                    }
                    layer.closeAll();
                    ShowMsg(data.msg);
                },
                error:function(){
                    layer.closeAll();
                    ShowMsg("服务器连接失败，请与管理员联系");
                }
            })
        }
        /**
         * 打印按键
         */
        function printAction(){
            var row=$("#dg").datagrid("getSelected");
            if(!row) {
                ShowMsg("请先选择一行数据！")
                return;
            }
            var status=row.printAuditstatus;
            if(status!="已通过"){
                ShowMsg("必须是通过审核的申请才能打印！")
                return;
            }
            var studentid=row.studentId;
            var printid=row.printId;
            window.open("/views/font/printPriviewV2.form?studentid="+studentid+"&printid="+printid);
            layer.load(1,{shade:[0.4,'#000000']});
            var printid=row.printId;
            $.ajax({
                url:"/printBack/changePrintstatus.form",
                type:"post",
                dataType:"json",
                data:{printid:printid},
                success:function(data){
                    if(data.status==0){
                        $("#dg").datagrid("load");
                    }
                    layer.closeAll();
                    ShowMsg(data.msg);
                },
                error:function(){
                    layer.closeAll();
                    ShowMsg("服务器连接失败，请与管理员联系");
                }
            })
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
               url:'/printBack/loadPrint.form'">
        <thead>
            <tr>
                <%--3、第三处修改，修改此处的列名称，与数据库一致，显示有必要的--%>
                <th field="printId" hidden >打印申请ID</th>
                <th field="studentId" >学号</th>
                <th field="studentName" >姓名</th>
                <th field="studentPhone" >电话</th>
                <th field="className" >班级</th>
                <th field="printAuditstatus" >打印申请审核状态</th>
                <th field="printAuditdate" formatter="dateFormater" >审核日期</th>
                <th field="printStatus" >打印状态</th>
                <th field="printDate"formatter="dateFormater" >打印日期</th>
                <th field="createDate" formatter="dateFormater">申请日期</th>
            </tr>
        </thead>
    </table>
    <%--表格头部按钮--%>
    <div id="tb" style="height:auto">
        <%--4、第四处修改，修改菜单按钮，选择哪些按钮需要--%>
        <input class="easyui-searchbox" data-options="prompt:'请输入学号',searcher:doSearch" style="width:200px"/>
            <a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-ok',plain:true" onclick="auditAction('已通过')">审核通过</a>
            <a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-cancel',plain:true" onclick="auditAction('未通过')">审核未通过</a>
            <a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-print',plain:true" onclick="printAction()">打印成绩单</a>
        <br/><span style="font-size: 10px;color:#D0494B;display: inline-block;margin:3px 0 3px 3px">打印成绩单：在新打开的窗口中点击鼠标右键--打印，或者是按ctrl+p 键，来打开打印对话框，然后选择打印机并打印。</span>
    </div>

</body>
</html>