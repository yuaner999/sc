<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: gq
  Date: 2017/3/4
  Time: 17:35
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java"  pageEncoding="UTF-8" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01//EN"
"http://www.w3.org/TR/html4/strict.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" lang="en">
<head>
    <link rel="Shortcut Icon" href="<%=request.getContextPath()%>/asset/image/neu.jpg" type="image/x-icon">
    <%--引入jquery--%>
    <script type="text/javascript" src="<%=request.getContextPath()%>/asset/js/jquery-1.8.3.min.js"></script>
    <%--引入layer--%>
    <script type="text/javascript" src="<%=request.getContextPath()%>/asset/layer/layer.js"></script>
    <%--引入kindereditor--%>
    <link rel="stylesheet" href="<%=request.getContextPath()%>/asset/kindeditor-4.1.10/themes/default/default.css" />
    <link rel="stylesheet" href="<%=request.getContextPath()%>/asset/kindeditor-4.1.10/plugins/code/prettify.css" />
    <script charset="utf-8" src="<%=request.getContextPath()%>/asset/kindeditor-4.1.10/kindeditor.js"></script>
    <script charset="utf-8" src="<%=request.getContextPath()%>/asset/kindeditor-4.1.10/lang/zh_CN.js"></script>
    <script charset="utf-8" src="<%=request.getContextPath()%>/asset/kindeditor-4.1.10/plugins/code/prettify.js"></script>
    <%--引入公共JS--%>
    <script type="text/javascript" src="<%=request.getContextPath()%>/asset_admin_new/js/managecommon.js"></script>
    <script type="text/javascript" src="<%=request.getContextPath()%>/asset/kindeditor-4.1.10/KindeditorConfig.js"></script>
    <script type="text/javascript" src="<%=request.getContextPath()%>/asset/js/common.js"></script>
    <%--引入表单验证--%>
    <!-- 导入样式css -->
    <link rel="stylesheet" href="<%=request.getContextPath()%>/asset_admin_new/css/StuMsgManage.css" />
    <link rel="stylesheet" href="<%=request.getContextPath()%>/asset_admin_new/css/printManage.css" />
    <script type="text/javascript" src="<%=request.getContextPath()%>/asset_admin_new/js/Validform_v5.3.2.js"></script>
    <link rel="stylesheet" href="<%=request.getContextPath()%>/asset_admin_new/css/activity.css" />
    <link rel="stylesheet" href="<%=request.getContextPath()%>/asset_admin_new/css/style.css" />
    <link rel="stylesheet" href="<%=request.getContextPath()%>/asset_admin_new/css/demo.css" />
    <!--兼容360浏览器，防止布局乱，设置IE的文档模式为最高版本，并且如果存在chrome插件，自动使用Webkit引擎-->
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
    <title>第二课堂教师管理界面</title>
    <script>
        var moduleType = GetQueryString("moduleType");//所属模块的ID
        //1、第一处修改，修改增删改的请求地址以及deleteId
        var addUrl = "";
        var editUrl = "/jsons/editTeaminfor.form";
        var deleteUrl = "";
        var editorName = "null";//KindEditor的Textarea的ID，如果没用到，赋值为null
        var imageUpload = "";//图片上传的标识，如果没有图片上传，赋值为空，如果有，赋值为数据库存放图片名称的字段名称，不带_
        var deleteId = "";//用于删除功能的ID参数，赋值为当前数据库表的ID
        var loadUrl = "/jsons/loadActivitTeamAudit.form";//注：此处为新增
        var sqlStr = "";//注：模糊查询
        var jsonPara;
        var editId="teamId";
        $(function(){
            //绑定跳页Enter键
            $(".currentPageNum").keyup(function(e){
                var pagNum = $(".currentPageNum").val();
                if(e.keyCode==13){
                    select_box(pagNum);
                }
            });
            //  点击'综合条件查询'关闭查询条件
            $('.function>ul>.function_search').click(function(){
                $('.searchContent').slideToggle();
            });
            //综合查询条件：专业
            $.ajax({
                url:"<%=request.getContextPath()%>/jsons/loadstuMajorName.form",
                dataType:"json",
                data:{stuCollageName:$(this).val()},
                success:function(data){
                    var friends = $("#_stuMajorName");
                    friends.empty();
                    friends.append("<option value=''>请选择</option>");
                    friends.append("<option value=''>全部</option>");
                    if(data.rows !=null && data.rows.length > 0){
                        for(var i=0;i<data.rows.length;i++) {
                            var option = $("<option>").text(data.rows[i].stuMajorName).val(data.rows[i].stuMajorName);
                            friends.append(option);
                        }
                    }else{
                        var option = $("<option>").text("无");
                        friends.append(option);
                    }
                }
            });
            $("#_stuMajorName").change(function(){
                //综合查询条件：年级
                $.ajax({
                    url: "<%=request.getContextPath()%>/jsons/loadstuGradeName.form",
                    dataType: "json",
                    data:{stuMajorName:$(this).val()},
                    success: function (data) {
                        var friends = $("#_stuGradeName");
                        friends.empty();
                        friends.append("<option value=''>请选择</option>");
                        friends.append("<option value=''>全部</option>");
                        if(data.rows !=null && data.rows.length > 0){
                            for(var i=0;i<data.rows.length;i++) {
                                var option = $("<option>").text(data.rows[i].stuGradeName).val(data.rows[i].stuGradeName);
                                friends.append(option);
                            }
                        }else{
                            var option = $("<option>").text("无");
                            friends.append(option);
                        }
                    }
                });
            });
            $("#_stuGradeName").change(function(){
                //z综合查询条件：班级
                $.ajax({
                    url: '<%=request.getContextPath()%>/jsons/loadclassnames1.form',
                    dataType: "json",
                    data:{stuGradeName:$(this).val(),collegename:$("#_stuCollageName").val(),stuMajorName:$("#_stuMajorName").val()},
                    success: function (data) {
                        var friends = $("#_stuClassName");
                        friends.empty();
                        friends.append("<option value=''>请选择</option>");
                        friends.append("<option value=''>全部</option>");
                        if(data.rows !=null && data.rows.length > 0){
                            for(var i=0;i<data.rows.length;i++) {
                                var option = $("<option>").text(data.rows[i].stuClassName).val(data.rows[i].stuClassName);
                                friends.append(option);
                            }
                        }else{
                            var option = $("<option>").text("无");
                            friends.append(option);
                        }
                    }
                });
            });
            //加载新建时候，活动列表
            $.ajax({
                url: '<%=request.getContextPath()%>/jsons/loadActivitList.form',
                dataType: "json",
                data:{},
                success: function (data) {
                    $("#applyActivityId").html('<option value="">请选择</option>');
                    if(data.total>0){
                        for(var i=0;i<data.rows.length;i++) {
                            var option = '<option value="'+data.rows[i].activityId+'">'+data.rows[i].activityTitle+'</option>';
                            $("#applyActivityId").append(option);
                        }
                    }
                }
            });
            before_reload();
        });
        //选择活动，更改对应活动属性
        function    changeOther(val){
            $.ajax({
                url: '<%=request.getContextPath()%>/jsons/loadActivitDetailById.form',
                dataType: "json",
                data:{activityId:val},
                success: function (data) {
                    $("#qx1").hide();
                    $("#qx2").hide();
                    $("#qx3").hide();
                    $("#qx4").hide();
                    $("#qx5").hide();
                    $("#qx6").hide();
                    if(data.total>0){
                        $("#activityClass").val(data.rows[0].activityClass);
                        $("#activityLevle").val(data.rows[0].activityLevle);
                        $("#activityNature").val(data.rows[0].activityNature);
                        var supPowers=data.rows[0].activityPowers;
                        if(supPowers!=null&&supPowers!=""){
                            var activityPowers=supPowers.split("|");
                            for(var i=0;i<activityPowers.length;i++){
                                if(activityPowers[i]=="思辨能力"){
                                    $("#qx1").show();
                                }
                                if(activityPowers[i]=="执行能力"){
                                    $("#qx2").show();
                                }
                                if(activityPowers[i]=="表达能力"){
                                    $("#qx3").show();
                                }
                                if(activityPowers[i]=="领导能力"){
                                    $("#qx4").show();
                                }
                                if(activityPowers[i]=="创新能力"){
                                    $("#qx5").show();
                                }
                                if(activityPowers[i]=="创业能力"){
                                    $("#qx6").show();
                                }
                            }
                        }
                    }
                }
            });
        }
        //before_reload :加载前rows和page参数处理
        function before_reload(){
            page= $(".currentPageNum").val();
            rows = $("#rows").val();
            if(page>(totalNum%rows==0?totalNum/rows:totalNum/rows+1)){//进行判断，避免选择rows时出现错误
                page = 1;$(".currentPageNum").val(1);
            }

            if(sqlStr==""||sqlStr==null){
                jsonPara={rows:rows,page:page};
            }else{
                jsonPara={rows:rows,page:page,sqlStr:sqlStr};
            }
            //   console.log(jsonPara);
            reload();
        }
        function reload_this(){
            window.location.reload();
        }
        function  reload() {//此处加载数据方法名不能修改，必须用reload
            load();
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
                                if(row[key]==null||row[key]=="null"||row[key]=="NULL"){
                                    row[key]="";
                                }
                            }
                            var tr = '<tr id="tr'+(i+1)+'">'+
                                    '<td>'+(i+1)+'</td>'+
                                    //第二处修改：按照数据库列名进行拼穿
                                    '<td style="display:none">'+row.teamId+'</td>'+
                                    '<td class="" title="'+row.teamName+'">'+row.teamName+'</td>'+
                                    '<td class="">'+row.teamCreateDate+'</td>'+
                                    '<td class="" title="'+row.activityTitle+'">'+row.activityTitle+'</td>'+
//                                    '<td class="" >'+row.countPerson+'</td>'+
                                    '</tr>';
                            $("tbody").append(tr);
                            $("#tr"+(i+1)).data(row);//存入data为后台修改时取数据
                        }

                        rowClick();//绑定行点击事件
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
            })
        }
        function setStudentname_befor(){
            var id=$("#applyStudentId").val();
            setStudentname(id);
        }
        function setStudentname(id){
            $.ajax({
                url:"/jsons/getStudentname.form",
                type:"post",
                data:{studentID:id},
                success:function(data){
                    if(data!=null){
                        $("#studentName").val(data);
                    }else {
                        $("#studentName").val("加载学生姓名失败");
                    }
                }
            });
        };
        //刷新按钮
        function refresh(){
            jsonPara={rows:10,page:1};
            reload();
        }
        /*
         * 重写save
         *
         * */
        function Saves(){
            checkNull();
            if(notNull) {//表单验证
                var jsonObject = $("#Form").serializeObject();
                jsonObject["moduleType"] = moduleType;
                if(jsonObject["teamName"].length>20){
                    layer.alert("团体名字需在20字以内,请重新输入");
                    return false;
                }
                if(clickStatus=='edit'){
                    jsonObject[editId]=rowdata[editId];
                }
                if($("#teamActivityId").val()){
                    jsonObject["teamActivityId"] = $("#teamActivityId").val();
                }else {
                    layer.msg("请选择一个活动");
                    return;
                }
                load();
                UploadToDatabases(jsonObject);
            }else {
                layer.msg("请按照要求填写");
                return;
            }
        }
        //查看详情
        function selectDetail() {
            if (clickStatus == 'true') {
                clickStatus = 'edit';
                postURL = editUrl;
                if (!rowdata) {
                    layer.alert("请先选择一条数据");
                    return
                } else {
                    $("#tpy").text("查看详情");
                    $('.popup').height($(document).height());
                    $('.popup').css('background-color', '#a1a1a1').slideDown(300);
                    $('#dlg').slideDown(400);
                    $("#btn_sub").hide();
                    $("#btn_cancel").hide();
                    $('#studentName').html("")
                    $("#teamActivityId").attr("disable", "disable");
                    var teamId = rowdata.applyTeamId;
                    var supPowers=rowdata.activityPowers;
                    if(supPowers!=null&&supPowers!=""){
                        var activityPowers=supPowers.split("|");
                        for(var i=0;i<activityPowers.length;i++){
                            if(activityPowers[i]=="思辨能力"){
                                $("#qx1").show();
                            }
                            if(activityPowers[i]=="执行能力"){
                                $("#qx2").show();
                            }
                            if(activityPowers[i]=="表达能力"){
                                $("#qx3").show();
                            }
                            if(activityPowers[i]=="领导能力"){
                                $("#qx4").show();
                            }
                            if(activityPowers[i]=="创新能力"){
                                $("#qx5").show();
                            }
                            if(activityPowers[i]=="创业能力"){
                                $("#qx6").show();
                            }
                        }
                    }
                    if (teamId) {
                        $.ajax({
                            url: "/jsons/getStudentId.form",
                            type: "post",
                            data: {teamId: teamId},
                            success: function (data) {
                                var str = "";
                                if (data.total > 0) {
                                    var row = data.rows;
//                                    console.log(row[0].studentID);
                                    for (var i = 0; i < row.length; i++) {
                                        str = str + row[i].studentID + " ";
                                    }
                                    $('#applyStudentId').val(str);
                                } else {
                                    disLoad();
                                    layer.alert("加载学号失败");
                                }
                            }
                        });
                    }
                }
            } else {
                layer.alert("请先选择一条数据");
            }
        }
        //审核
        function auditTeam(val) {
            if (!rowdata) {
                layer.alert("请先选择一条数据");
                return
            } else {
                layer.confirm("确认此操作吗？", function (result) {
                    if (result) {
                        $.ajax({
                            url: "/jsons/auditTeamActivity.form",
                            type: "post",
                            data: {applyId: rowdata.applyId,status:"sc",type:val},
                            success: function (data) {
                                if(data.result){
                                    layer.msg("审核成功！");
                                    select_box(1);
                                }
                            }, error: function () {
                                layer.msg("网络错误");
                            }
                        });
                    }
                })
            }
        }
        //新建
        function Adds_before(){
            $("#btn_sub").show();
            $("#btn_cancel").show();
            $("#qx1").hide();
            $("#qx2").hide();
            $("#qx3").hide();
            $("#qx4").hide();
            $("#qx5").hide();
            $("#qx6").hide();
            Add();
        }
        //删除
        function Deletes() {
            if (!rowdata) {
                layer.alert("请先选择一条数据");
                return
            }
            if (clickStatus != "" && clickStatus != null) {
                postURL = deleteUrl;
                layer.confirm('确认删除此条数据吗?', function (result) {
                    if (result) {
                        //删除数据库记录
                        load();
                        var selectId = rowdata[deleteId];
                        var deleteJsonObject = eval("(" + "{'" + deleteId + "':'" + selectId + "'}" + ")");
                        $.post(postURL, deleteJsonObject, function (data) {
                            if (data.result) {
                                disLoad();
//                                console.log(data);
                                layer.msg("删除成功");
                                reload();//重新加载数据
                            } else {
                                layer.msg("删除失败，请重新登录或联系管理员");
                            }
                        });
                    }
                });
            } else {
                layer.msg("请选择一条数据");
            }
        }

        //        /上传数据到数据库
        function UploadToDatabases(jsonObject) {
            $.ajax({
                url: postURL,
                type: "post",
                dataType: "json",
                data: jsonObject,
                success: function (data) {
                    disLoad();
                    if (data.result) {
                        close();
                        layer.alert("保存成功");
                        reload();
                    }
                    if (data.msg) {
                        layer.alert(data.msg);
                    }
                },
                error: function () {
                    disLoad();
                    layer.alert("服务器连接失败");
                }
            })
        }

        //清空
        function clear_search() {
            //清空表单
            document.getElementById("Form1").reset();
        }
    </script>
    <style type="text/css">
        .searchContent>div>ul>li>div>select {
            width: 162px;
            height: 28px;
            border: 1px solid #1990fe;
        }
        .searchContent>div>ul>li>input {
            border: 1px solid #1990fe;
            width: 156px;
            height: 18px;
            margin-left: 85px;
        }
        .searchContent>div>ul>li>div>span {
            display: inline-block;
            position: absolute;
            z-index: 10;
            right: 0;
            top: 0;
            width: 30px;
            height: 25px;
        }
        .searchContent>div{
            position: relative;
            margin: 0px 25px;
            min-width: 600px;
            padding: 35px 10px 13px 10px;
            border-bottom: 2px solid #fff799;
        }
        .new{
            position: absolute;
            /* top: 152px; */
            left: 200px;
            z-index: 100;
            width: 700px;
            height: 600px;
            border: 1px solid #197FFE;
            /* margin: 250px auto; */
            background-color: #FFFFFF;
            display: none;
        }
        #dlg ul li input{
            width: 201px !important;
            height: 22px;
            border: 1px solid #1990fe;
            margin-left: 0 ;
        }
        #dlg ul li select{
            width: 205px;
            height: 32px;
            border: 1px solid #1990fe;
        }
        .inputbox{
            display: inline-block;
            vertical-align: top;
            position: relative;
            left: -12px;
        }
    </style>
    <%--判断是否是登录状态--%>
    <%--<%@include file="../common/CheckLogin.jsp"%>--%>
</head>
<body>
<div class="stuMsgManage">
    <%--4、第三处修改，修改菜单按钮，选择哪些按钮需要--%>
    <!--功能栏-->
    <div class="function">
        <ul>
            <li class="function_search"><span>综合条件查询</span></li>
            <li class="function_edit" onclick="selectDetail()"><span>查看详情</span></li>
            <li class="function_edit function_auditPass" onclick="auditTeam('已通过')"><span>审核通过</span></li>
            <li class="function_edit function_auditNotPass" onclick="auditTeam('未通过')"><span>审核未通过</span></li>
        </ul>
    </div>
    <form id="Form1" >
        <div class="searchContent">
            <div>
                <ul>
                    <li>
                        <span>活动标题:</span>
                        <input type="text" id="_activityTitle"  name="supActivityTitle"/>
                    </li>
                    <li>
                        <span>学号:</span>
                        <input type="text" id="_studentID" name="supStudentId" />
                    </li>
                    <li>
                        <span>学生姓名:</span>
                        <input type="text" id="_studentName" name="studentName" />
                    </li>
                    <li>
                        <span>团体名称:</span>
                        <input type="text" id="selectTeamName" name="selectTeamName" />
                    </li>
                </ul>
                <ul>
                    <li>
                        <span>所在专业:</span>
                        <div>
                            <select id="_stuMajorName" name="stuMajorName" class="select">
                                <option value="" >请选择</option>
                                <option value="" >全部</option>
                            </select>
                        </div>
                    </li>
                    <li>
                        <span>所在年级:</span>
                        <div>
                            <select id="_stuGradeName" name="stuGradeName" class="select">
                                <option value="" >请选择</option>
                                <option value="" >全部</option>
                            </select>
                        </div>
                    </li>
                    <li>
                        <span>所在班级:</span>
                        <div>
                            <select id="_stuClassName" name="stuClassName" class="select">
                                <option value="" >请选择</option>
                                <option value="" >全部</option>
                            </select>
                        </div>
                    </li>
                </ul>
            </div>
            <p></p>
            <div class="buttons">
                <span class="clearAll" onclick="clear_search()">清空</span>
                <span class="search" onclick="select_box(1)">搜索</span>
            </div>
        </div>
    </form>
    <!--结果集表格-->
    <div id="dg" class="table">
        <table border="0" cellspacing="0" cellpadding="0">
            <thead>
            <tr>
                <td></td>
                <td>团体名字</td>
                <td>团体创建日期</td>
                <td>活动标题</td>
                <%--<td>参与人数</td>--%>
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
<!--新建/弹出窗口-->
<form id="Form" class="demoform" action=""><!--存在为了提交-->
    <div id="dlg" class="new">

        <div class="header">
            <span id="tpy"></span>
            <span type="reset" class="iconConcel"></span>
        </div>
        <ul>

            <li>
                <span>团体名字&nbsp;&nbsp;:&nbsp;&nbsp;&nbsp;&nbsp;</span>
                <input type="text" id="teamName" name="teamName"   readonly="readonly" />
            </li>
            <li>
                <span>报名活动&nbsp;&nbsp;:&nbsp;&nbsp;&nbsp;&nbsp;</span>
                <input id="activityTitle" name="activityTitle"   readonly="readonly"/>
            </li>
            <li>
                <span>活动大类&nbsp;&nbsp;:&nbsp;&nbsp;&nbsp;&nbsp;</span>
                <input type="text" id="activityClass" name="activityClass"    readonly="readonly"/>
            </li>
            <li id="supLevle"  >
                <span>活动级别&nbsp;&nbsp;:&nbsp;&nbsp;&nbsp;&nbsp;</span>
                <input type="text" id="activityLevle" name="activityLevle"    readonly="readonly"/>
            </li>
            <li id="supNature"  >
                <span>活动性质&nbsp;&nbsp;:&nbsp;&nbsp;&nbsp;&nbsp;</span>
                <input type="text" id="activityNature" name="activityNature"    readonly="readonly"/>
            </li>

            <li id="supPowers"  >
                <span>能力标签&nbsp;&nbsp;:&nbsp;&nbsp;&nbsp;&nbsp;</span>
                <div class="inputbox" >
                    <input type="text" class="qx_check" id="qx1" name="qx" value="思辨能力" style="width: 50px!important;height: 16px;position: relative;top: -1px;margin: 0px
0px 0px 12px;display: none" readonly="readonly"/>
                    <input type="text" class="qx_check" id="qx2" name="qx" value="执行能力" style="width: 50px!important;height: 16px;position: relative;top: -1px;margin: 0px
0px 0px 12px;display: none" readonly="readonly"/>
                    <input type="text" class="qx_check" id="qx3" name="qx" value="表达能力" style="width: 50px!important;height: 16px;position: relative;top: -1px;margin: 0px
0px 0px 12px;display: none" readonly="readonly"/>
                    <input type="text" class="qx_check" id="qx4" name="qx" value="领导能力" style="width: 50px!important;height: 16px;position: relative;top: -1px;margin: 0px
0px 0px 12px;display: none" readonly="readonly"/>
                    <input type="text" class="qx_check" id="qx5" name="qx" value="创新能力" style="width: 50px!important;height: 16px;position: relative;top: -1px;margin: 0px
0px 0px 12px;display: none" readonly="readonly"/>
                    <input type="text" class="qx_check" id="qx6" name="qx" value="创业能力" style="width: 50px!important;height: 16px;position: relative;top: -1px;margin: 0px
0px 0px 12px;display: none" readonly="readonly"/>
                </div>
            </li>
            <li >
                <span>学生学号&nbsp;&nbsp;:&nbsp;&nbsp;&nbsp;&nbsp;</span>
                <input type="text" id="applyStudentId" name="applyStudentId"    readonly="readonly"/>
                <a href="javascript:void(0)" onclick="setStudentname_befor()">查看姓名</a>
            </li>
            <li >
                <span>学生姓名&nbsp;&nbsp;:&nbsp;&nbsp;&nbsp;&nbsp;</span>
                <textarea id="studentName" style="width:95%;height:200px;" readonly></textarea>
            </li>
            <li>
                <span style="color:#E41D1D;font-size:15px;">注：如果多个学生,需要用 ， 或     分开   例：000001，000002 或 000001 000002</span>
            </li>
        </ul>
        <!--按钮窗口-->
        <div id="dlg-buttons" class="new_buttons">
            <input type="button" id="btn_sub" value="保存" onclick="Saves()" />
            <input class="iconConcel" id="btn_cancel" type="reset" value="取消"   />
        </div>

    </div>
</form>
</body>
</html>