<%--
  Created by IntelliJ IDEA.
  User: DSKJ005
  Date: 2016/10/31
  Time: 10:24
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<html>
<head>
    <!-- 导入页面控制js jq必须放最上面 -->
    <link rel="Shortcut Icon" href="<%=request.getContextPath()%>/asset/image/neu.jpg" type="image/x-icon">
    <script type="text/javascript" src="<%=request.getContextPath()%>/asset/js/jquery-1.8.3.min.js"></script>
    <script type="text/javascript" src="<%=request.getContextPath()%>/asset_admin_new/js/common_stuMsgManage.js"></script>
    <!-- 导入layer -->
    <script type="text/javascript" src="<%=request.getContextPath()%>/asset/layer/layer.js"></script>
    <!-- 导入样式css -->
    <link rel="stylesheet" href="<%=request.getContextPath()%>/asset_admin_new/css/StuMsgManage.css" />
    <link rel="stylesheet" href="<%=request.getContextPath()%>/asset_admin_new/css/printManage.css" />
    <%--引入公共JS--%>
    <script type="text/javascript" src="<%=request.getContextPath()%>/asset/js/common.js"></script>
    <script type="text/javascript" src="<%=request.getContextPath()%>/asset_admin_new/js/managecommon.js"></script>
    <%--引入表单验证--%>
    <script type="text/javascript" src="<%=request.getContextPath()%>/asset_admin_new/js/Validform_v5.3.2.js"></script>
    <link rel="stylesheet" href="<%=request.getContextPath()%>/asset_admin_new/css/style.css" />
    <link rel="stylesheet" href="<%=request.getContextPath()%>/asset_admin_new/css/demo.css" />
    <%--引入本页自己的js--%>
    <script type="text/javascript" src="<%=request.getContextPath()%>/asset_admin_new/js/printManage.js"></script>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
    <!--兼容360浏览器，防止布局乱，设置IE的文档模式为最高版本，并且如果存在chrome插件，自动使用Webkit引擎-->
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <title>活动结果审核管理</title>
    <script type="text/javascript">
        var moduleType = GetQueryString("moduleType");//所属模块的ID，不可以删除
        //1、第一处修改，修改增删改的请求地址
        var addUrl = "";
        var editUrl = "";
        var deleteUrl = "";
        var editorName = "null";//KindEditor的Textarea的ID，如果没用到，赋值为null
        var imageUpload = "";//图片上传的标识，如果没有图片上传，赋值为空，如果有，赋值为数据库存放图片名称的字段名称，不带_
        var deleteId = "";//用于删除功能的ID参数，赋值为当前数据库表的ID
        var editId = "";//用于修改功能的ID参数，赋值为当前数据库表的ID
        var loadUrl = "/check/loadCheckStudentNum.form";//注：此处为新增
        var sqlStr = "";//注：模糊查询
        var jsonPara;//参数
        var className=decodeURI(decodeURI(GetQueryString("stuClassName")));
        var classId='<%=session.getAttribute("classId")%>';
        var collegeId='<%=session.getAttribute("collegeId")%>';
        var status='';
        var loadstatus=decodeURI(decodeURI(GetQueryString("loadstatus")));
        loadstatus=loadstatus==='null' ? '待审核' : loadstatus;
        $(function(){
            before_reload();
            $("#submitAll").change(function(){
                if($(this).is(":checked")){
                    $(".checkes").attr("checked",true);
                }else {
                    $(".checkes").attr("checked",false);
                }
            })
            //绑定跳页Enter键
            $(".currentPageNum").keyup(function(e){
                var pagNum = $(".currentPageNum").val();
                if(e.keyCode==13){
                    select_box(pagNum);
                }
            });
        });
        //before_reload :加载前rows和page参数处理
        function before_reload(){

            page= $(".currentPageNum").val();
            rows = $("#rows").val();
            if(page>(totalNum%rows==0?totalNum/rows:totalNum/rows+1)){//进行判断，避免选择rows时出现错误
                page = 1;$(".currentPageNum").val(1);
            }
            if(collegeId=='null'&&classId=='null'){
                status='sc';
            }else if(classId=='null'){
                status='co';
            }else{
                status='cl';
                className=classId;
            }
            jsonPara={rows:rows,page:page,className:className,status:status,loadstatus:loadstatus};
//            console.log(status);
//            console.log(jsonPara);
            reload();
        }
        //综合查询
        function select_box(page) {
            var jsonObject = $("#Form1").serializeObject();
            jsonObject["rows"] = $("#rows").val() ;

            if(Math.ceil(totalNum/$("#rows").val())<page){
                page=Math.ceil(totalNum/$("#rows").val());
            }
            if(page<=0){
                page=1;
            }
            jsonObject["page"] = page;
            $(".currentPageNum").val(page);
            if(collegeId=='null'&&classId=='null'){
                jsonObject["status"]='sc';
            }else if(classId=='null'){
                jsonObject["status"]='co';
            }else{
                jsonObject["status"]='cl';
                className=classId;
            }
            jsonObject["className"]=className;
            jsonPara=jsonObject;
            $('.searchContent').slideUp();
            reload();
        }
        function  reload() {//此处加载数据方法名不能修改，必须用reload
            load();
            jsonPara["loadstatus"] = loadstatus;
            $.ajax({
                url: loadUrl,
                type: "post",
                data:jsonPara,
                dataType: "json",
                success: function (data) {
//                    console.log(data);
                    $("tbody").html("");
                    if (data != null && data.rows != null && data.rows.length > 0) {
                        for (var i = 0; i < data.rows.length; i++) {
                            var row = data.rows[i];
                            for(var key in row){
                                if(!row[key] || row[key]=="null"){
                                    row[key]="";
                                }
                            }
                            var tr = '<tr id="tr'+(i+1)+'">'+
                                    '<td>'+ '<input name="test" class="checkes" type="checkbox" id="submint'+i+'" style="width:18px;height: 20px;" />'+'</td>'+
                                        //第二处修改：按照数据库列名进行拼穿
                                    '<td title="'+row.activityTitle+'">'+row.activityTitle+'</td>'+
                                    '<td style="display:none">'+row.applyStudentId+'</td>'+
                                    '<td class="studentName" title="'+row.studentName+'">'+row.studentName+'</td>'+
                                    '<td class="applyTeamId" style="display:none">'+row.applyTeamId+'</td>'+
//                                    '<td class="teamName" title="'+row.teamName+'">'+row.teamName+'</td>'+
//                                    '<td class="activitypoint">'+row.activitypoint+'</td>'+
                                    '<td class="activityAward" title="'+row.activityAward+'">'+row.activityAward+'</td>'+
                                    '<td class="regimentAuditStatus">'+row.regimentAuditStatus+'</td>'+
                                    '<td class="regimentAuditStatusDate">'+row.regimentAuditStatusDates+'</td>'+
                                    '<td class="collegeAuditStatus"  >'+row.collegeAuditStatus+'</td>'+
                                    '<td class="collegeAuditStatusDate"  >'+row.collegeAuditStatusDates+'</td>'+
                                    '<td class="schoolAuditStaus"  >'+row.schoolAuditStaus+'</td>'+
                                    '<td class="schoolAuditStausDate"  >'+row.schoolAuditStausDates+'</td>'+
                                    '<td >' +
                                    '<li class="function_new function_auditPass" style="width: 65px;float:left;cursor: pointer" onclick="auditOne(this,\'已通过\')"><span>通过</span></li>' +
                                    '<li class="function_edit function_auditNotPass" style="width: 65px;float: right;cursor: pointer" onclick="auditOne(this,\'未通过\')"><span>不通过</span></li>' +
                                    '</td>'+
                                '</tr>';
                            tr=tr.replace(/undefined/g,"");
                            $("tbody").append(tr);
                            $("#tr"+(i+1)).data(row);//存入data为后台修改时取数据
                        }
                        //                       rowClick();//绑定行点击事件
                        totalNum=data.total;

                    }else{
                        totalNum=0;
                    }
                    paging();
                    disLoad();
                }, error: function () {
                    layer.msg("网络错误");
                    disLoad();
                }
            });

        }
        function auditsAction(type){
            /**
             * 取出选中的数据
             */
            var applyStudentId="";
            var applyId='';
            var totalNum=0;
            $('tbody input:checkbox:checked').each(function() {
                var row=$(this).parent().parent().data();
                applyStudentId+=row.applyStudentId+"|";
                totalNum+=1;
                applyId+=row.applyId+"|";
            });
            if(applyStudentId==""){
                layer.msg("请选择一行数据");
                return;
            }
            layer.confirm("确认此操作吗？！！！",function(result){
                if (result){
                    $.ajax({
                        url: "/check/ClassAuditApply.form",
                        type: "post",
                        data: {
                            applyId: applyId.substring(0, applyId.length - 1),
                            type: type, status:status},
                        dataType: "json",
                        success: function (data) {
                            if (data) {
                                if(parseInt(data.msg)===0){
                                    layer.msg("您选择的数据不能审核");
                                }else if(parseInt(data.msg)===totalNum){
                                    layer.msg("操作成功");
                                } else{
                                    layer.msg("选择了"+totalNum+"条数据,审核了"+data.msg+"条,其余"+(totalNum-parseInt(data.msg))+"条不能审核");
                                }
                                $("#submitAll").attr("checked", false);
                                before_reload();
                            }
                        }, error: function () {
                            layer.msg("网络错误");
                        }
                    })
                }
            })
        }
        function auditOne(val,type){

            var applyStudentId="";
            var applyId='';
            var totalNum=0;

            var row=$(val).parent().parent().data();
            applyStudentId=row.applyStudentId;
            totalNum=1;
            applyId=row.applyId;

            if(applyStudentId==""){
                layer.msg("请选择一行数据");
                return;
            }
            layer.confirm("确认此操作吗？！！！",function(result){
                if (result){
                    $.ajax({
                        url: "/check/ClassAuditApply.form",
                        type: "post",
                        data: {
                            applyId: applyId,
                            type: type, status:status},
                        dataType: "json",
                        success: function (data) {
                            if (data) {
                                if(parseInt(data.msg)==0){
                                    layer.msg("该条数据不能审核");
                                }else{
                                    layer.msg("操作成功");
                                }
                                $("#submitAll").attr("checked", false);
                                before_reload();
                            }
                        }, error: function () {
                            layer.msg("网络错误");
                        }
                    })
                }
            })
        }
        function  go(val){
            val=encodeURI(encodeURI(val));
            window.open('<%=request.getContextPath()%>/views/admin_new/activityendManage_detail.form?stuClassName='+val+'','_parent');
            <%--return '<a href="<%=request.getContextPath()%>/views/admin/ClassStudentInfo.form?stuClassName='+val+'" target="_blank">'+val+'</a>  ';--%>
        }
        function reloadsearch(val){
            loadstatus=val;
            jsonPara={rows:rows,page:'1',className:className,status:status,loadstatus:loadstatus};
            reload();
        }
    </script>
    <%--判断是否是登录状态--%>
    <%--<%@include file="../common/CheckLogin.jsp"%>--%>
</head>
<body>
<div class="stuMsgManage">
    <%--4、第三处修改，修改菜单按钮，选择哪些按钮需要--%>
    <!--功能栏-->
    <div class="function">
        <ul>
            <%--<li class="function_inputSearch">--%>
            <%--<input type="text" placeholder="请输入活动名字" id="searchVal" />--%>
            <%--<span id="search" onclick="Search()"></span>--%>
            <%--</li>--%>
            <li class="function_edit" onclick="auditsAction('已通过')"><span>批量通过</span></li>
            <li class="function_edit" onclick="auditsAction('未通过')"><span>批量驳回</span></li>
            <li class="function_refresh2 " onclick="reloadsearch('待审核')"><span>待审核</span></li>
            <li class="function_refresh " onclick="reloadsearch('已通过')"><span>已通过</span></li>
            <li class="function_refresh3 " onclick="reloadsearch('未通过')"><span>未通过</span></li>
        </ul>
    </div>

    <!--结果集表格-->
    <div id="dg" class="table">
        <table border="0" cellspacing="0" cellpadding="0">
            <thead>
            <tr>
                <td><input name="test" type="checkbox" id="submitAll" style="width: 18px; height: 20px;" /></td>
                <td>活动标题</td>
                <td>学生姓名</td>
                <%--<td>团队名字</td>--%>
                <%--<td>活动评分</td>--%>
                <td>所获奖项</td>
                <td>团支书审核状态</td>
                <td>团支书审核时间</td>
                <td>学院审核状态</td>
                <td>学院审核时间</td>
                <td>校团委审核状态</td>
                <td>校团委审核时间</td>
                <td width="140px">操作</td>
            </tr>
            </thead>
            <tbody>

            </tbody>
        </table>
    </div>
    <!--分页-->
    <%@include file="paging.jsp"%>
</div>
<!--弹出框的层-->

<%--5、第四处修改，修改表单信息，与上面的列名称一致--%>
<div id="tb" class="popup"></div>

<!--此js放在要提交表单的下面，放在上面偶尔失效-->
<script>
    //第五处修改，一般不用改，设置表单验证参数，tiptype4种, btnSubmit 提交按钮，ajax是结合我们公司提交方式
    demo = $(".demoform").Validform({
        tiptype:4,
        btnSubmit:"#btn_sub",
        ajaxPost:true
    });
</script>
</body>
</html>
