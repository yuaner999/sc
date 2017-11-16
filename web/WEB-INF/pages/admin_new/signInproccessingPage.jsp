<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: pjj
  Date: 2016/10/21
  Time: 9:15
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java"  pageEncoding="UTF-8" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01//EN"
"http://www.w3.org/TR/html4/strict.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" lang="en">
<head>
    <link rel="Shortcut Icon" href="<%=request.getContextPath()%>/asset/image/neu.jpg" type="image/x-icon">
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
    <!--兼容360浏览器，防止布局乱，设置IE的文档模式为最高版本，并且如果存在chrome插件，自动使用Webkit引擎-->
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <!-- 导入页面控制js jq必须放最上面 -->
    <script type="text/javascript" src="<%=request.getContextPath()%>/asset_admin_new/js/jquery-1.11.1.min.js"></script>
    <script type="text/javascript" src="<%=request.getContextPath()%>/asset/js/laydate/laydate.js"></script>
    <script type="text/javascript" src="<%=request.getContextPath()%>/asset_admin_new/js/common_stuMsgManage.js"></script>
    <!-- 导入layer -->
    <script type="text/javascript" src="<%=request.getContextPath()%>/asset/layer/layer.js"></script>
    <!-- 导入样式css -->
    <link rel="stylesheet" href="<%=request.getContextPath()%>/asset_admin_new/css/StuMsgManage.css" />

    <%--引入公共JS--%>
    <script type="text/javascript" src="<%=request.getContextPath()%>/asset/js/common.js"></script>
    <script type="text/javascript" src="<%=request.getContextPath()%>/asset_admin_new/js/managecommon.js"></script>
    <%--引入图片上传--%>
    <script type="text/javascript" src="<%=request.getContextPath()%>/asset/js/ajaxfileupload.js"></script>
    <%--引入表单验证--%>
    <script type="text/javascript" src="<%=request.getContextPath()%>/asset_admin_new/js/Validform_v5.3.2.js"></script>
    <link rel="stylesheet" href="<%=request.getContextPath()%>/asset_admin_new/css/style.css" />
    <link rel="stylesheet" href="<%=request.getContextPath()%>/asset_admin_new/css/demo.css" />
    <%--引入本页自己的js--%>
    <script type="text/javascript" src="<%=request.getContextPath()%>/asset_admin_new/js/schoolactivityapplyManage.js"></script>
    <link rel="stylesheet" href="<%=request.getContextPath()%>/asset_admin_new/css/schoolactivityapplyManage.css" />
    <title>第二课堂教师管理界面</title>

    <script>
        var moduleType = GetQueryString("moduleType");//所属模块的ID
        //1、第一处修改，修改增删改的请求地址以及deleteId
        var addUrl = "";
        var editUrl = "";
        var deleteUrl = "";
        var editorName = "null";//KindEditor的Textarea的ID，如果没用到，赋值为null
        var imageUpload = "null";//图片上传的标识，如果没有图片上传，赋值为空，如果有，赋值为数据库存放图片名称的字段名称，不带_
        var deleteId = "";//用于删除功能的ID参数，赋值为当前数据库表的ID
        var loadUrl = "";//注：此处为新增
        var sqlStr = "";//注：模糊查询
        var jsonPara;
        var activityId ;//选中活动的id
        var activityParticipation;//活动类型参数
        var rowdata1 ; //活动页参数；
        var upUrl;
        $(function(){
            $(".pagingTurn").eq(0).hide();
            $(".selectRows").hide();
            $(".refresh").hide();
            before_reload();
            //  点击'综合条件查询'关闭查询条件
            $('#button1').click(function(){
                $(".searchContent").slideToggle(function(){
                    if ($(this).is(':hidden')) {
                        $(".messagePage").show();
                    }else {
                        $(".messagePage").hide();
                    }
                });
            });
            //绑定跳页Enter键
            $(".currentPageNum").keyup(function(e){
                var pagNum = $(".currentPageNum").val();
                if(e.keyCode==13){
                    select_box(pagNum);
                }
            });
            //综合查询条件：创建者
            $.ajax({
                url: "<%=request.getContextPath()%>/jsons/loadactivityCreator1.form",
                dataType: "json",
                success: function (data) {
                    var friends = $("#_activityCreator");
                    friends.empty();
                    friends.append("<option value=''>请选择</option>");
                    friends.append("<option value=''>全部</option>");
                    if(data.rows !=null && data.rows.length > 0){
                        for(var i=0;i<data.rows.length;i++) {
                            var option = $("<option>").text(data.rows[i].activityCreator).val(data.rows[i].activityCreator);
                            friends.append(option);
                        }
                    }else{
                        var option = $("<option>").text("无");
                        friends.append(option);
                    }
                }
            });
            //综合查询条件：负责人
            $.ajax({
                url: "<%=request.getContextPath()%>/jsons/loadactivityPrincipal.form",
                dataType: "json",
                success: function (data) {
                    var friends = $("#_principal");
                    friends.empty();
                    friends.append("<option value=''>请选择</option>");
                    friends.append("<option value=''>全部</option>");
                    if(data.rows !=null && data.rows.length > 0){
                        for(var i=0;i<data.rows.length;i++) {
                            var option = $("<option>").text(data.rows[i].principal).val(data.rows[i].principal);
                            friends.append(option);
                        }
                    }else{
                        var option = $("<option>").text("无");
                        friends.append(option);
                    }
                }
            });
            //综合查询条件：学院
            $.ajax({
                url: "<%=request.getContextPath()%>/jsons/loadstuCollageName.form",
                dataType: "json",
                data:{stuCollageName:''},
                success: function (data) {
                    var friends = $("#_stuCollageName");
                    friends.empty();
                    friends.append("<option value=''>请选择</option>");
                    friends.append("<option value=''>全部</option>");
                    if(data.rows !=null && data.rows.length > 0){
                        for(var i=0;i<data.rows.length;i++) {
                            var option = $("<option>").text(data.rows[i].stuCollageName).val(data.rows[i].stuCollageName);
                            friends.append(option);
                        }
                    }else{
                        var option = $("<option>").text("无");
                        friends.append(option);
                    }
                }
            });
            $("#_stuCollageName").change(function(){
                //综合查询条件：年级
                $.ajax({
                    url: "<%=request.getContextPath()%>/jsons/loadstuGradeName.form",
                    dataType: "json",
                    data:{stuCollageName:$(this).val()},
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
            //点击关闭
            $(".iconConcel").click(function(){
                $('.new').slideUp(300);
                $('.popup').slideUp(400);
            });
            //保持光标在输入框
            var flag=setInterval(function(){
                $("#applyid").focus();
            },2000);
            //自动提交
            $("#applyid").keyup(function(e){
                if(e.keyCode==13){
                    var applyid=$("#applyid").val();
                    signIn(applyid,activityId);
                    $("#applyid").val("");
                    $("#applyid").focus();
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

            if(sqlStr==""||sqlStr==null){
                jsonPara={rows:rows,page:page};
            }else{
                jsonPara={rows:rows,page:page,sqlStr:sqlStr};
            }
            //   console.log(jsonPara);
            reload();
        }
        function signIn(applyid,activityid){
            if(!applyid || !activityid) return ;
            $.ajax({
                url:"/signin/byid.form",
                type:"post",
                data:{applyId:applyid,activityId:activityid},
                dataType:"json",
                success:function(data){
                    if(data.status==1){
                        $("#wrong_msg").append(applyid+"##提交失败<br>");
                    }
                },
                error:function(){
                    $("#wrong_msg").append(applyid+"##提交失败<br>");
                    layer.alert("服务器连接失败，请稍后再试");
                }
            });
        }
        //	点击功能键'重新选择活动',弹出窗口,背景变暗
        function reSelect(){
            $('.popup').height($(document).height());
            page= 1;
            rows= 10;
            before_reload();
            $('.popup').css('background-color', '#a1a1a1').slideDown(300);
            $('.dialog').slideDown(400);
        }
        function clear_search(){
            document.getElementById("Form1").reset();
        }
        function refresh_reload(){
            isSelect='';
            clickStatus='';
            $(".currentPageNum").val(1);
            page=1;
            rows = $("#rows").val();
            if(isCondition=='true'){
                select_box(1);
            }else{
                jsonPara={rows:rows,page:page};
                reload();
            }
        }
        //分页加载
        function paging(){
            if($(".currentPageNum").val()==0){
                $(".currentPageNum").val("1");
            }
            page= $(".currentPageNum").val();
            rows = $("#rows").val();
            $(".pageNum").eq(0).html(Math.ceil( totalNum/rows));
            $(".pageNum").eq(3).html(totalNum);
            if(totalNum<=0){
                $(".currentPageNum").val("0");
                page=$(".currentPageNum").val("0");
                $(".pageNum").eq(2).html(0);
                $(".pageNum").eq(1).html(0);
            }else if(totalNum<page*rows){
                $(".pageNum").eq(2).html(totalNum);
                $(".pageNum").eq(1).html(rows*(page-1)+1);
            }else{
                $(".pageNum").eq(2).html(page*rows);
                $(".pageNum").eq(1).html(rows*(page-1)+1);
            }
        }
        //上一页
        function turn_left(){
            var newpage1= parseInt($(".currentPageNum").val());
            if(newpage1<=1){
                newpage1=1;
            }else{
                newpage1=newpage1-1;
            }
            $(".currentPageNum").val(newpage1);
            var pagNum = $(".currentPageNum").val();
            if(isCondition=='true'){
                select_box(pagNum);
            }else if(isCondition=='searchM'){
                Search(pagNum);
            }else if(isCondition=='searchC'){
                searchIn(pagNum);
            }else{
                before_reload();
            }
        }
        //下一页
        function turn_right(){
            var newpage2= parseInt($(".currentPageNum").val());

            if(newpage2>=Math.ceil(totalNum/rows)){
                newpage2=Math.ceil(totalNum/rows);
            }else{
                newpage2=newpage2+1;
            }
            $(".currentPageNum").val(newpage2);
            var pagNum = $(".currentPageNum").val();
            if(isCondition=='true'){
                select_box(pagNum);
            }else if(isCondition=='searchM'){
                Search(pagNum);
            }else if(isCondition=='searchC'){
                searchIn(pagNum);
            }else{
                before_reload();
            }
        }
        //前端加载活动
        function  reload() {//此处加载数据方法名不能修改，必须用reload
            load();
            $(".messagePage").show();
            $(".pagingTurn").eq(0).show();
            $.ajax({
                url: "/jsons/loadSchoolSignActivity.form",
                type: "post",
                data:jsonPara,
                dataType: "json",
                success: function (data) {
//                    console.log(data);
                    $("#tbody").html("");
                    if (data != null && data.rows != null && data.rows.length > 0) {
                        for (var i = 0; i < data.rows.length; i++) {
                            var row = data.rows[i];
                            var tr = '<tr id="tr'+(i+1)+'">'+
                                    '<td>'+(i+1)+'</td>'+
                                        //第二处修改：按照数据库列名进行拼穿
                                    '<td class="activityTitle " title="'+row.activityTitle+'">'+row.activityTitle+'</td>'+
                                    '<td class="activityLocation ">'+row.activityLocation+'</td>'+
                                    '<td class="activityParticipation ">'+row.activityParticipation+'</td>'+
                                    '<td class="activitySdate ">'+row.activitySdate+'</td>'+
                                    '<td class="activityEdate ">'+row.activityEdate+'</td>'+
                                    '<td class=" activityCreatedate ">'+row.activityCreatedate+'</td>'+
                                    '</tr>';
                            $("#tbody").append(tr);
                            $("#tr"+(i+1)).data(row);//存入data为后台修改时取数据
                        }
                        rowClick();//绑定行点击事件
                        totalNum=data.total;

                    }else {
                        page=0;
                        totalNum=0;
                        $(".currentPageNum").val(0);
                    }
                    paging();
                    disLoad();
                }, error: function () {
                    layer.msg("网络错误");
                    disLoad();
                }
            })

        }
        function batchInsertClose(){
            document.getElementById("batch_dlg").style.display="none";//不显示
        }
        function batchInsertClose1(){
            document.getElementById("sign_now").style.display="none";//不显示
        }
        /**
         * 选择活动
         */
        function submit_btn(){
            var row=rowdata;
            if(!row) layer.alert("请选择一行数据!");
            activityId=row.activityId;
            $("#activity_title").text(row.activityTitle);
            $("#dialog").hide();
            $('.popup').slideUp(400);
            $('.dialog').slideUp(300);
        }
        /**
         * 现场签到按键
         */
        function signInNow(){
            document.getElementById("sign_now").style.display="";//显示
        }
        /**
         * 批量导入对话框
         */
        function signInByFile(){
            document.getElementById("batch_dlg").style.display="";//显示
            upUrl="/signin/byfile.form";
        }

        function uploadExcel() {
            document.getElementById("batch_dlg").style.display="";//显示
            upUrl="/dataupload/studentinfo.form";
        }
        /**
         * 上传文件
         */
        function uploadFile(){
            if(!$("#upfile").val()){
                layer.alert("请选择文件！");
                return;
            }
            load();
            $.ajaxFileUpload({
                url: upUrl+"?activityid="+activityId+"&sta=b", //用于文件上传的服务器端请求地址
                secureuri: false, //一般设置为false
                fileElementId: "upfile", //文件上传空间的id属性
                dataType: 'String', //返回值类型 一般设置为String
                success: function (data)  //服务器成功响应处理函数
                {
//                    console.log(data);
                    showResult(data);
                    disLoad();
                },
                error: function ()//服务器响应失败处理函数
                {
                    layer.alert("上传文件失败，请重新上传");
                    disLoad();
                }
            });
        }
        /**
         * 上传文件后显示服务器返回的信息
         * @param data
         */
        function showResult(data){
            $("#valid_result").html("");
            //去除返回字符串的  <pre style="word-wrap: break-word; white-space: pre-wrap;"> 标签
            var str=data.substring(data.indexOf('>')+1,data.lastIndexOf('<'));
            var s= eval("("+str+")");
            var str=s.msg+"<br>";
            if(s.data){
                $.each(s.data,function(){
                    if(this.data){
                        str+="&nbsp;&nbsp;"+this.msg+"<br>";
                        $.each(this.data,function(){
                            str+="&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;"+this+"<br>";
                        })
                    }else{
                        str+="&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;"+this+"<br>";
                    }

                });
            }
            $("#valid_result").html(str);
        }
        //弹出加载层
        function load() {
            layer.load(1, {
                shade: [0.1,'#fff']//0.1透明度的白色背景
            });
            //$("<div class=\"datagrid-mask\" style='z-index: 9999999999999999999;'></div>").css({ display: "block", width: "100%", height: $(window).height() }).appendTo("body");
            //$("<div class=\"datagrid-mask-msg\" style='z-index: 9999999999999999999;'></div>").html("正在加载，请稍候...").appendTo("body").css({ display: "block", left: ($(document.body).outerWidth(true) - 190) / 2, top: ($(window).height() - 45) / 2 });
        }

        //取消加载层
        function disLoad() {
            //$(".datagrid-mask").remove();
            //$(".datagrid-mask-msg").remove();
            layer.closeAll('loading');
        }
        //下载模版文件
        function getModel(){
            window.open("/Files/ExcelModels/student_signUp_applyInfo.xls");
        }

    </script>
    <%--判断是否是登录状态--%>
    <%--<%@include file="../common/CheckLogin.jsp"%>--%>
    <style type="text/css">
        .devide {
            margin-top: 20px;
            width: 100%;
            overflow: hidden;
            height: 10px;
        }
        .devideleft {
            width: 200px;
            height: 10px;
            background: #1990FE;
            float: left;
        }
        .devideright {
            width: 100%;
            height: 10px;
            background: #FFF799;
            /* float: left; */
        }
        .buttons{
            width: 134px;
            height: 34px;
            font-size: 16px;
            color: #e9f6ff;
            margin-left: 20px;
            border: 1px solid #1990FE;
            cursor: pointer;
            border-radius: 4px;
        }
        .devideleft1 {
            width: 16px;
            height: 36px;
            background: #1990FE;
            float: left;
            margin-top: 50px;
        }
        .dialog {
            position: absolute;
            top: 54px;
            left: 168px;
            z-index: 100;
            width: 1026px;
            border: 1px solid #197FFE;
            /* margin: 182px auto; */
            background-color: #FFFFFF;
        }
        .title{
            color:#197ffe;
            font-size: 30px;
            margin-left: 23px;
            position: relative;
            top: 10px;
        }
        #activity_title{
            color: #197ffe;
            font-size: 22px;
            margin-top: 50px;
            margin-left: 5px;
        }
        #class_dlg,#batch_dlg,#sign_now{
            border-color: #1990fe !important;
            background: #fff !important;
            border-width: 2px !important;
        }
        #stuClassName{
            width:auto !important;
        }
        #class_buttons input{
            color: #fff;
            background: #1990fe;
            border:none;
            outline: none;
        }
        #class_buttons input:active,#batch_dlg_buttons a:active{
            background: #4daaff;
        }
        #batch_dlg_buttons{
            text-align: right;
            margin-top: 10px;
        }
        #btn_box a{
            color: #1990fe;
        }
        #batch_dlg_buttons a{
            display: inline-block;
            padding: 0 10px;
            background: #1990fe;
            color: #fff;
            height: 21px;
            width:24px;
            text-align: center;
            line-height: 21px;
            margin-left: 0 !important;
            margin-right: 8px;
        }
        #sign_now label{
            color: #1990fe;
            line-height: 21px;
        }
        .searchselect {
            width: 162px;
            height: 28px;
            border: 1px solid #1990fe;
        }
        .searchContent>div>ul>li>input {
            border: 1px solid #1990fe;
            width: 155px;
            height: 19px;
            margin-left: 85px;
        }
        .select {
            width: 246px;
            height: 36px;
            border: 1px solid #1990fe;
            margin-left: -3px;
        }
        .new {
            position: absolute;
            top: 63px;
            left: 200px;
            z-index: 100;
            width: 550px;
            height: 500px;
            border: 1px solid #197FFE;
            /* margin: 250px auto; */
            background-color: #FFFFFF;
            display: none;
        }
        table{
            border-collapse: collapse;
        }
        thead>td:first-of-type, tr>td:first-of-type {
            width: 60px;
        }
        .pagingTurn{
            padding-top: 7px !important;
        }
        #class_dlg,#batch_dlg{
            border-color: #1990fe !important;
            background: #fff !important;
            border-width: 2px !important;
        }
        #stuClassName{
            width:auto !important;
        }
        #class_buttons input{
            color: #fff;
            background: #1990fe;
            border:none;
            outline: none;
        }
        #class_buttons input:active,#batch_dlg_buttons a:active{
            background: #4daaff;
        }
        #batch_dlg_buttons{
            text-align: right;
        }
        #btn_box a{
            color: #1990fe;
        }
        #batch_dlg_buttons a{
            display: inline-block;
            padding: 0 10px;
            background: #1990fe;
            color: #fff;
            height: 21px;
            width:24px;
            text-align: center;
            line-height: 21px;
            margin-left: 0 !important;
        }
        .messagePage{
            height:auto!important;
            min-height: 0 !important;
            overflow: auto;
        }
        .searchselect {
            width: 162px;
            height: 28px;
            border: 1px solid #1990fe;
        }
        .searchContent>div>ul>li>input {
            border: 1px solid #1990fe;
            width: 155px;
            height: 19px;
            margin-left: 85px;
        }
    </style>
</head>
<body>
<span class="title" >活动签到</span>
<div class="devide">
    <div class="devideleft">

    </div>
    <div class="devideright">

    </div>
</div>
<div class="stuMsgManage">
    <%--4、第三处修改，修改菜单按钮，选择哪些按钮需要--%>
    <!--功能栏-->
    <div class="function">
        <ul>
            <input type="button" value="重新选择活动" onclick="reSelect()"  class="buttons" style="background-color: #1990fe;"/>
            <input type="button" value="活动现场签到" onclick="signInNow()" class="buttons" style="background-color: #1990fe;"/>
            <input type="button" value="上传二维码" onclick="signInByFile()" class="buttons" style="background-color: #1990fe;"/>
            <input type="button" value="表格模板下载" onclick="getModel()" class="buttons" style="background-color: #1990fe;"/>
            <input type="button" value="上传签到表格" onclick="uploadExcel()" class="buttons" style="background-color: #1990fe;"/>
        </ul>
    </div>
        <div class="devideleft1"></div>
        <p id="activity_title"></p>
</div>
<!--弹出框的层-->

<%--5、第四处修改，修改表单信息，与上面的列名称一致--%>
<div id="tb" class="popup"></div>
<!--此js放在要提交表单的下面，放在上面偶尔失效-->
<%--<script>--%>
    <%--//第五处修改，一般不用改，设置表单验证参数，tiptype4种, btnSubmit 提交按钮，ajax是结合我们公司提交方式--%>
    <%--demo = $(".demoform").Validform({--%>
        <%--tiptype:4,--%>
        <%--btnSubmit:"#btn_sub",--%>
        <%--ajaxPost:true--%>

    <%--});--%>
<%--</script>--%>
<!--重新加载活动方法-->
<div id="dialog" class="dialog">
    <div class="header">
        <span class="title_1" >&nbsp;&nbsp;<p>活动选择界面</p><img src="../../../asset_font_new/img/windowclose_03.png"></span>

    </div>
    <!--功能栏-->
    <div class="function">
        <ul>
            <li style="background: url(/asset_admin_new/img/icon_synsearch.png) no-repeat;background-position: 0px 2px;" id="button1">
                <span >综合条件查询</span>
            </li>
        </ul>
    </div>
    <!--综合查询部分-->
    <form id="Form1"   method="post">
        <div class="searchContent">
            <div>
                <ul>
                    <li>
                        <span>活动标题:</span>
                        <input type="text" id="_activityTitle"  name="activityTitle" />
                    </li>
                    <li>
                        <span>活动类别:</span>
                        <div>
                            <select id="_activityClass" name="activityClass" class="searchselect">
                                <option value="" >请选择</option>
                                <option value="" >全部</option>
                                <option value="1">思想政治教育类</option>
                                <option value="2">能力素质拓展类</option>
                                <option value="3">学术科技与创新创业类</option>
                                <option value="4">社会实践与志愿服务类</option>
                                <option value="5">社会工作与技能培训类</option>
                                <option value="6">其他类</option>
                            </select>
                        </div>
                    </li>
                    <li>
                        <span>活动性质:</span>
                        <div>
                            <select id="_activityNature" name="activityNature" class="searchselect">
                                <option value="" >请选择</option>
                                <option value="" >全部</option>
                                <option value="1">活动参与</option>
                                <option value="2">讲座报告</option>
                                <option value="3">比赛</option>
                                <option value="4">培训</option>
                            </select>
                        </div>
                    </li>
                    <li>
                        <span>活动级别:</span>
                        <div>
                            <select id="_activityLevle" name="activityLevle" class="searchselect">
                                <option value="" >请选择</option>
                                <option value="" >全部</option>
                                <option value="0">国际级</option>
                                <option value="1">国家级</option>
                                <option value="2">省级</option>
                                <option value="3">市级</option>
                                <option value="4">校级</option>
                                <option value="5">院级</option>
                                <option value="6">团支部级</option>
                            </select>
                        </div>
                    </li>
                    <li>
                        <span>参与形式:</span>
                        <div>
                            <select id="_activityParticipation" name="activityParticipation" class="searchselect">
                                <option value="" >请选择</option>
                                <option value="" >全部</option>
                                <option value="不限">不限</option>
                                <option value="个人">个人</option>
                                <option value="团体">团体</option>
                            </select>
                        </div>
                    </li>
                </ul>
                <ul>
                    <li>
                        <span>活动开始时间:</span>
                        <input onclick="laydate()" id="_activitySdate" name="activitySdate"  type="text"/>
                    </li>
                    <li>
                        <span>活动结束时间:</span>
                        <input  onclick="laydate()" id="_activityEdate" name="activityEdate" type="text"/>
                    </li>
                    <li>
                        <span>创建人:</span>
                        <div>
                            <select id="_activityCreator" name="activityCreator" class="searchselect">
                                <option value="" >请选择</option>
                                <option value="" >全部</option>

                            </select>
                        </div>
                    </li>
                    <li>
                        <span>负责人;</span>
                        <div>
                            <select id="_principal" name="principal" class="searchselect">
                                <option value="" >请选择</option>
                                <option value="" >全部</option>

                            </select>
                        </div>
                    </li>
                    <li>
                        <span>能力标签:</span>
                        <div>
                            <select id="_activityPowers" name="activityPowers" class="searchselect">
                                <option value="" >请选择</option>
                                <option value="" >全部</option>
                                <option value="思辨能力">思辨能力</option>
                                <option value="执行能力">执行能力</option>
                                <option value="表达能力">表达能力</option>
                                <option value="领导能力">领导能力</option>
                                <option value="创新能力">创新能力</option>
                                <option value="创业能力">创业能力</option>
                            </select>
                        </div>
                    </li>
                </ul>
                <ul>
                    <li>
                        <span>创建时间:</span>
                        <input  onclick="laydate()" id="_activityCreatedate" name="activityCreatedate" type="text"/>
                    </li>
                    <li>
                        <span>所在学院:</span>
                        <div>
                            <select id="_stuCollageName" name="stuCollageName" class="searchselect">
                                <option value="" >请选择</option>
                                <option value="" >全部</option>

                            </select>
                        </div>
                    </li>
                    <li>
                        <span>所在年级:</span>
                        <div>
                            <select id="_stuGradeName" name="stuGradeName" class="searchselect">
                                <option value="" >请选择</option>
                                <option value="" >全部</option>

                            </select>
                        </div>
                    </li>
                    <li>
                        <span>能否线上报名:</span>
                        <div>
                            <select id="_online" name="online" class="searchselect">
                                <option value="" >请选择</option>
                                <option value="" >全部</option>
                                <option value="0">可以</option>
                                <option value="1">不可以</option>
                            </select>
                        </div>
                    </li>
                    <li>
                        <span>活动学分:</span>
                        <input type="text" id="_activityCredit"  name="activityCredit"/>
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
    <div class="messagePage table" >
        <table>
            <thead>
            <tr>
                <td></td>
                <td>活动标题</td>
                <td>活动地点</td>
                <td>参与形式</td>
                <td>活动起始时间</td>
                <td>活动截止时间</td>
                <td>活动创建时间</td>
            </tr>

            </thead>
            <tbody id="tbody">

            </tbody>

        </table>
    </div>
    <!--分页-->
    <div class="pagingTurn">
        <div>
            <span class="turn_left" onclick="turn_left()"></span> 第
            <input class="currentPageNum" type="text" value="1">页，共
            <span class="pageNum"></span> 页
            <span class="turn_right" onclick="turn_right()"></span>
        </div>
        <div>
            <select id="rows" name="rows" onchange="refresh_reload()">
                <option value="10" selected>10</option>
                <option value="20">20</option>
                <option value="50">50</option>
                <option value="100">100</option>
            </select>
        </div>

        <div>
            显示<span class="pageNum"></span>到<span class="pageNum"></span>，共<span class="pageNum"></span>条记录
        </div>
    </div>
    <!--按钮窗口-->
    <div class="new_buttons">
        <input type="reset"  value="提交" onclick="submit_btn()"  />
        <input type="reset" value="取消" onclick="close2()" />
    </div>
</div>
<%--批量导入对话框--%>
<div id="batch_dlg"  title="批量导入签到信息"  style="display:none;width:400px;height:380px;padding:10px;position:absolute;
    border:3px #c1dadb solid; left:35%;top:25%;background-color:#ffffff">
    <div id="file_box" style="margin-bottom: 10px;margin-top: 10px;">
        <label>选择文件:</label>
        <input id="upfile" style="display: inline-block;width: 200px;" name="fileup" type="file"/>
        <img style="float: right;position:absolute;top:15px;right:15px" src="../../../asset_font_new/img/windowclose_03.png" onclick="batchInsertClose()">
    </div>
    <div id="_box" style="margin-bottom: 10px;margin-top: 10px;">
        <label></label>
    </div>
    <div id="btn_box" style="margin-bottom: 10px;margin-top: 10px;">
        <label></label>
        <%--<a href="javascript:void(0)"  onclick="validFile()">验证文件</a>&nbsp;&nbsp;&nbsp;&nbsp;--%>
        <a href="javascript:void(0)"  onclick="uploadFile()">上传并导入</a>
    </div>
    <div id="result_box" style="margin-bottom: 10px;margin-top: 10px;">
        <label>操作结果:</label>
        <br>
        <label></label>
        <div id="valid_result"  style="display: inline-block;width: 400px;height: 250px;border: 2px solid #95B8E7;overflow: auto"></div>
    </div>
    <%--批量导入对话框的按钮--%>
    <div id="batch_dlg_buttons" >
        <a href="javascript:void(0)" style="margin-left: 370px" onclick="batchInsertClose()">关闭</a>
    </div>
</div>
<%--现场签到对话框--%>
<div id="sign_now"  title="现场签到" style="display:none;width:400px;height:380px;padding:10px;position:absolute;
    border:3px #c1dadb solid; left:35%;top:25%;background-color:#ffffff">
    <div  class="fitem">
        <br>
        <label>二维码内容：</label>
        <img style="float: right;position:absolute;right:15px;top:15px" src="../../../asset_font_new/img/windowclose_03.png" onclick="batchInsertClose1()">
        <input id="applyid" class=" input_ele"  style="width: 350px;border: 1px solid #95B8E7;border-radius:4px"  type="text"/>
    </div>
    <div  class="fitem">
        <label>错误信息:</label>
        <br>
        <label></label>
        <div id="wrong_msg" class=" input_ele" style="width: 390px;height: 200px;border: 1px solid #95B8E7;border-radius:4px;overflow: auto"></div>
    </div>
    <%--批量导入对话框的按钮--%>
    <div id="batch_dlg_buttons" >
        <a href="javascript:void(0)" style="margin-left: 370px" onclick="batchInsertClose1()">关闭</a>
    </div>
</div>
<script>
    $(".title_1 img").click(function () {
        $(this).parent().parent().parent().hide(200);
        $('.popup').slideUp(200);
        $(document.body).css({
            "overflow-x":"auto",
            "overflow-y":"auto"
        });
    });
</script>
</body>
</html>