<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: dskj012
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
    <script type="text/javascript" src="<%=request.getContextPath()%>/asset/js/jquery-1.8.3.min.js"></script>
    <script type="text/javascript" src="<%=request.getContextPath()%>/asset/js/laydate/laydate.js"></script>
    <%--<script type="text/javascript" src="<%=request.getContextPath()%>/asset/easyui/src/jquery.form.js"></script>--%>
    <!-- 导入页面控制js -->
    <%--<script type="text/javascript" src="<%=request.getContextPath()%>/asset_admin_new/js/common_stuMsgManage.js"></script>--%>
    <script type="text/javascript" src="<%=request.getContextPath()%>/asset_admin_new/js/common_tabs.js"></script>
    <script type="text/javascript" src="<%=request.getContextPath()%>/asset_admin_new/js/StuMsgManage.js"></script>
    <!-- 导入layer -->
    <script type="text/javascript" src="<%=request.getContextPath()%>/asset/layer/layer.js"></script>
    <!-- 导入样式css -->
    <link rel="stylesheet" href="<%=request.getContextPath()%>/asset_admin_new/css/menu.css" />
    <link rel="stylesheet" href="<%=request.getContextPath()%>/asset_admin_new/css/activity.css" />
    <%--引入kindereditor--%>
    <link rel="stylesheet" href="<%=request.getContextPath()%>/asset/kindeditor-4.1.10/themes/default/default.css" />
    <link rel="stylesheet" href="<%=request.getContextPath()%>/asset/kindeditor-4.1.10/plugins/code/prettify.css" />
    <script charset="utf-8" src="<%=request.getContextPath()%>/asset/kindeditor-4.1.10/kindeditor.js"></script>
    <script charset="utf-8" src="<%=request.getContextPath()%>/asset/kindeditor-4.1.10/lang/zh_CN.js"></script>
    <script charset="utf-8" src="<%=request.getContextPath()%>/asset/kindeditor-4.1.10/plugins/code/prettify.js"></script>
    <%--引入公共JS--%>
    <script type="text/javascript" src="<%=request.getContextPath()%>/asset/js/common.js"></script>
    <script type="text/javascript" src="<%=request.getContextPath()%>/asset_admin_new/js/managecommon.js"></script>
    <script type="text/javascript" src="<%=request.getContextPath()%>/asset/kindeditor-4.1.10/KindeditorConfig.js"></script>
    <%--引入图片上传--%>
    <script type="text/javascript" src="<%=request.getContextPath()%>/asset/js/ajaxfileupload.js"></script>
    <%--引入表单验证--%>
    <script type="text/javascript" src="<%=request.getContextPath()%>/asset_admin_new/js/Validform_v5.3.2.js"></script>
    <link rel="stylesheet" href="<%=request.getContextPath()%>/asset_admin_new/css/style.css" />
    <link rel="stylesheet" href="<%=request.getContextPath()%>/asset_admin_new/css/demo.css" />
    <%--引入本页自己的js--%>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
    <!--兼容360浏览器，防止布局乱，设置IE的文档模式为最高版本，并且如果存在chrome插件，自动使用Webkit引擎-->
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <title>第二课堂教师管理界面</title>
    <style type="text/css">
        .new_buttons input{
            margin-top: 50px;
            width: 134px;
            height: 34px;
            font-size: 16px;
            letter-spacing: 8px;
            color: #1990FE;
            margin-left: 20px;
            border: 1px solid #1990FE;
            background-color: #e9f6ff;
            cursor: pointer;
        }
    </style>
    <script type="text/javascript">
        var moduleType = GetQueryString("moduleType");//所属模块的ID
        //1、第一处修改，修改增删改的请求地址以及deleteId
        var addUrl = "/jsons/addActivities.form";
        var editUrl = "/jsons/editActivities.form";
        var deleteUrl = "/jsons/deleteActivities.form";
        var editorName = "activityContent";//KindEditor的Textarea的ID，如果没用到，赋值为null
        var imageUpload = "activityImg";//图片上传的标识，如果没有图片上传，赋值为空，如果有，赋值为数据库存放图片名称的字段名称，不带_
        var deleteId = "activityId";//用于删除功能的ID参数，赋值为当前数据库表的ID
        var loadUrl = "/jsons/loadActivities1.form";//注：此处为新增
        var sqlStr = "";//注：模糊查询
        var jsonPara;
        var editId="activityId";
        var totalNum1;
        var rowdata1=null;
        var activityid='';
        var importsta='';
        $(function(){
            //before_reload();
            //点击关闭
            $(".worktime").hide();
            $("#dg").hide();
            $(".refresh").hide();
            $(".pagingTurn").hide();
            $(".searchContent").show();
            $(".iconConcel").click(function(){
                $('.new').slideUp(300);
                $('.popup').slideUp(400);
                $(".filter_ckeck").attr("checked",false);
                $(".qx_check").attr("checked",false);
                $("#online1").attr("checked",false);
                $("#online2").attr("checked",false);
                $("table tr").css('background-color','white');
            });
            $("#activityClass").change(function(){
                if($(this).val()=='4'){
                    $(".worktime").show();
                }else {
                    $(".worktime").hide();
                }
            });
            $("#activityAward").change(function(){
               if($(this).val()=="其他"){
                   $(".AwardName").show();
               } else {
                   $(".AwardName").hide();
               }
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
                    /*data:{activityCreator:$(this).val()},*/
                    success: function (data) {
                        var friends = $("#_principal");
                        friends.empty();
                        friends.append("<option value=''>请选择</option>");
                        friends.append("<option value=''>全部</option>");
                        if (data.rows != null && data.rows.length > 0) {
                            for (var i = 0; i < data.rows.length; i++) {
                                var option = $("<option>").text(data.rows[i].principal).val(data.rows[i].principal);
                                friends.append(option);
                            }
                        } else {
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
            //班级加载
            $.ajax({
                url: "<%=request.getContextPath()%>/jsons/loadclassnames1.form",
                dataType: "json",
                success: function (data) {
                    var friends = $("#stuClassName");
                    friends.empty();
                    friends.append("<option value=''>请选择</option>");
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
        //分页加载，此部分有錯誤，paging自動調用managecommon.js
        /*function paging(){
            page= $(".currentPageNum").val();
            rows = $("#rows").val();
            $(".pageNum").eq(0).html(Math.ceil( totalNum/rows));
            $(".pageNum").eq(3).html(totalNum);

            if(totalNum<=0){
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
        }*/
        //综合查询
        function select_box(page) {
            isCondition='true';
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
//            console.log(jsonObject);
            jsonPara=jsonObject;
            $('.searchContent').slideUp();
            reload();
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
        function  reload() {//此处加载数据方法名不能修改，必须用reload
            load();
            $("#dg").show();
            $(".pagingTurn").show();
            $.ajax({
                url: loadUrl,
                type: "post",
                data:jsonPara,
                dataType: "json",
                success: function (data) {
//                    console.log(data);
                    $("#data_demo").html("");
                    if (data != null && data.rows != null && data.rows.length > 0) {
                        for (var i = 0; i < data.rows.length; i++) {
                            var row = data.rows[i];
                            for(var key in row){
                                if(row[key]==null||row[key]=="null"||row[key]=="NULL"){
                                    row[key]="";
                                }
                            }
                            var online=row.online==0?'可以':'不可以';
                            var ispublish=row.ispublish==1?'已发布':'未发布';
                            var tr = '<tr id="tr'+(i+1)+'">'+
                                    '<td>'+(i+1)+'</td>'+
                                        //第二处修改：按照数据库列名进行拼穿
                                    '<td style="display:none">'+row.activityId+'</td>'+
                                    '<td title="'+row.activityTitle+'">'+row.activityTitle+'</td>'+
//                                    '<td title="'+row.activityArea+'">'+row.activityArea+'</td>'+
                                    '<td title="'+row.activityClassMean+'">'+row.activityClassMean+'</td>'+
                                    '<td title="'+row.activityLevleMean+'">'+row.activityLevleMean+'</td>'+
                                    '<td title="'+row.activityNatureMean+'">'+row.activityNatureMean+'</td>'+
//                                    '<td title="'+row.activityLocation+'">'+row.activityLocation+'</td>'+
//                                    '<td title="'+row.activityCredit+'">'+row.activityCredit+'</td>'+
                                    '<td title="'+row.activityParticipation+'">'+row.activityParticipation+'</td>'+
                                    '<td>'+row.activitySdate+'</td>'+
                                    '<td>'+row.activityEdate+'</td>'+
                                    '<td>'+row.activityApplyedate+'</td>'+
                                    '<td>'+row.activityCreator+'</td>'+
                                    '<td>'+row.activityCreatedate+'</td>'+
                                    '<td>'+online+'</td>'+
                                    '<td>'+ispublish+'</td>'+
//                                    '<td>'+row.principal+'</td>'+
//                                    '<td>'+row.principalphone+'</td>'
                            '</tr>';
                            $("#data_demo").append(tr);
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
        //保存
        function Saves(){
            //活动限制与过滤信息验证
            var fxs=$(".filter_ckeck:checked");
            var classYear=$("#classYear").val();
            var classCollege=$("#classCollege").val();
            if(fxs.length<1){
                layer.msg("请按照要求填写活动限制和过滤信息");
                $(this).attr("checked",false);
                return false;
            }
            if($("#ax2").is(":checked")){
                if(classYear==null||classYear==""){
                    layer.msg("请按照要求填写活动限制和过滤信息");
                    return false;
                }
            }
            if($("#ax3").is(":checked")){
                if(classCollege==null||classCollege==""){
                    layer.msg("请按照要求填写活动限制和过滤信息");
                    return false;
                }
            }
            //增加能力复选框验证
            var qxs=$(".qx_check:checked");
            if(qxs.length<1){
                layer.msg("必须选一项增加能力");
                $(this).attr("checked",false);
                return false;
            }
            var activityTitle=$("#activityTitle").val();
            if(!activityTitle){
                layer.msg("标题不可为空");
                return false;
            }
            //活动时间进行验证
            var Sdate=$("#activitySdate").val();
            var Edate=$("#activityEdate").val();
            var Adate=$("#activityApplyedate").val();
            if(!Sdate||!Edate||!Adate){
                layer.msg("请按要求填写活动开始时间，结束时间, 报名截止时间");
                return false;
            }
            if(Sdate>Edate){
                layer.msg("活动开始时间不能晚于结束时间");
                return false;
            }
            if(Sdate<Adate){
                layer.msg("报名截止时间不能晚于活动开始时间 ");
                return false;
            }
                var jsonObject = $("#Form").serializeObject();
                jsonObject["moduleType"] = moduleType;
                if (editorName && editorName != "null") {
                    editor.sync();
                    jsonObject[editorName] = $("#" + editorName).val();
                }
                if(clickStatus=='edit'){
                    jsonObject[editId]=rowdata[editId];
                }
                if($("#activityClass").val()=="4"){
                    if(($("#worktime").val()).indexOf("天")<0&&($("#worktime").val()).indexOf("小时")<0){
                        layer.msg("服务时长格式错误x天 或 x小时")
                        return false;
                    }
                    jsonObject[worktime]==$("#worktime").val();
                }
                //手动拼接 增加能力 到数据库
                var qxs=$(".qx_check:checked");
                var str="";
                if(qxs!=null&&qxs!=""){
                    for(var i=0;i<qxs.length;i++){
                        var val=$(qxs[i]).val();
                        str=str+val+"|";
                    }
//                    console.log(str.substring(0,str.length-1))
                    jsonObject["activityPowers"]=str.substring(0,str.length-1);
                }
                //手动拼接 活动限制 到数据库
                var axs=$(".filter_ckeck:checked");
                var str1="";
                if(axs!=null&&axs!=""){
                    for(var i=0;i<axs.length;i++){
                        var val=$(axs[i]).val();
                        str1=str1+val+"|";
                    }
                    jsonObject["activityFilterType"]=str1.substring(0,str1.length-1);
                }
                //过滤条件 到数据库
                if($("#ax2").is(":checked")){
                    classYear= $('#classYear').val();
                }else {
                    classYear= '';
                }
                if($("#ax3").is(":checked")){
                    classCollege= $('#classCollege').val();
                }else {
                    classCollege= '';
                }
                jsonObject["activityFilter"] =classYear+"|"+classCollege;
                load();
                //有图片上传
                if ($("#" + imageUpload).val() != null && $("#" + imageUpload).val() != "") {
                    ajaxFileUpload("/ImageUpload/No_Intercept_Upload.form", imageUpload, jsonObject, 1);
                } else {
                    UploadToDatabase(jsonObject);
                }
        }
        /**
         * 预览图片功能
         * @param file
         */
        function preview(file) {
            var prevDiv = $("#activityImgs");
            if (file.files && file.files[0])
            {
                var reader = new FileReader();
                reader.onload = function(evt){
                    prevDiv.attr("src",evt.target.result);
                }
                reader.readAsDataURL(file.files[0]);
            }
        }
        $(function(){
            $("#ax1").change(function(){
                $("#ax2").attr("checked",false);
                $("#ax3").attr("checked",false);
                $("#classCollege").attr("disabled","disabled");
                $("#classYear").attr("disabled","disabled");
            })
            $("#ax2").change(function(){
                $("#ax1").attr("checked",false);
                if($(this).is(":checked")){
                    $("#classYear").removeAttr("disabled");
                }
                if(!$(this).is(":checked")){
                    $("#classYear").attr("disabled","disabled");
                }
            });
            $("#ax3").change(function(){
                $("#ax1").attr("checked",false);
                if($(this).is(":checked")){
                    $("#classCollege").removeAttr("disabled");
                }
                if(!$(this).is(":checked")){
                    $("#classCollege").attr("disabled","disabled");
                }
            })
            //至少选择一个
            $(".qx_check").click(function(){
                var qxs=$(".qx_check:checked");
                if(qxs.length>3){
                    layer.alert("最多只能选3项增加能力");
                    $(this).attr("checked",false);
                }
                if(qxs.length<1){
                    layer.alert("必须选一项增加能力");
                    $(this).attr("checked",false);
                    return false;
                }
            });
            //至少选择一个
            $(".filter_ckeck").click(function(){
                var qxs=$(".filter_ckeck:checked");
                if(qxs.length<1){
                    layer.alert("必须选一项过滤条件");
                    $(this).attr("checked",false);
                    return false;
                }
            });
        })
        //刷新按钮
        function refresh(){
            jsonPara={rows:10,page:1};
            reload();
        }
        //修改
        function Edits(){
            if(clickStatus=='true') {
                clickStatus='edit';
                postURL=editUrl;
                if(!rowdata){
                    layer.alert("请先选择一条数据");
                    return
                }else{
                    $("#tpy").text("修改");
                    $('.popup').height($(document).height());
                    $('.popup').css('background-color', '#a1a1a1').slideDown(300);
                    $('.new').slideDown(400);
                    $("#edit").show();
                    $("#see").hide();
                    $("#btn_sub").show();
                    if(rowdata["activityClass"]=='4'){
                        $(".worktime").show();
                    }else {
                        $(".worktime").hide();
                    }
                    var str=rowdata["activityFilterType"];
                    if(str!=null&&str!=""){
                        var activityFilterType=str.split("|");
                        for(var i=0;i<activityFilterType.length;i++){
                            if(activityFilterType[i]=='不限'){
                                $("#ax1").attr("checked",true);
                                $("#classCollege").attr("disabled","disabled");
                                $("#classYear").attr("disabled","disabled");
                            }
                            if(activityFilterType[i]=='年级'){
                                $("#ax2").attr("checked",true);
                            }
                            if(activityFilterType[i]=='学院'){
                                $("#ax3").attr("checked",true);
                            }
                        }
                    }
                    var str1=rowdata["activityFilter"];
                    if(str1!=null&&str1!=""){
                        var activityFilter=str1.split("|");
                        if(activityFilter[0]!=null&&activityFilter[0]!=''){
                            $('#classYear').val(activityFilter[0]);
                            $("#classYear").removeAttr("disabled");
                        }
                        if(activityFilter[1]!=null&&activityFilter[1]!=''){
                            $('#classCollege').val(activityFilter[1]);
                            $("#classCollege").removeAttr("disabled");
                        }
                    }

                    var str2=rowdata["activityPowers"];
                    if(str2!=null&&str2!=""){
                        var activityPowers=str2.split("|");
                        for(var i=0;i<activityPowers.length;i++){
                            if(activityPowers[i]=="思辨能力"){
                                $("#qx1").attr("checked",true);
                            }
                            if(activityPowers[i]=="执行能力"){
                                $("#qx2").attr("checked",true);
                            }
                            if(activityPowers[i]=="表达能力"){
                                $("#qx3").attr("checked",true);
                            }
                            if(activityPowers[i]=="领导能力"){
                                $("#qx4").attr("checked",true);
                            }
                            if(activityPowers[i]=="创新能力"){
                                $("#qx5").attr("checked",true);
                            }
                            if(activityPowers[i]=="创业能力"){
                                $("#qx6").attr("checked",true);
                            }
                        }
                    }
                    var str3=rowdata["online"];
                    if (str3){
                        switch (str3){
                            case "0" :   $("#online1").attr("checked",true); break;
                            case "1" :     $("#online2").attr("checked",true);break;
                        }
                    }
                }
            }else{
                layer.alert("请先选择一条数据");
            }
        }
        //新建
        function Adds(){
            postURL = addUrl;
            clickStatus = "add";
            if(editorName!="null"&&editorName!=""){//清除KindEditor内容
                KindEditor.instances[0].html('');
            }
            //清空表单
            document.getElementById("Form").reset();
            rowdata=null;
            $("table tr").css('background-color','white');//先将颜色改为以前面的颜色
            $("#user_photo").attr("src","<%=request.getContextPath()%>/asset/image/default.jpg");
            $("#activityImgs").attr("src","<%=request.getContextPath()%>/asset/image/default.jpg");
            $("#dlg").get(0).scrollTop=0;
            $("#tpy").text("新建");
            $('.popup').height($(document).height());
            $('.popup').css('background-color', '#a1a1a1').slideDown(200);
            $('.new').slideDown(400);
            $("#edit").show();
            $("#see").hide();
            $("#btn_sub").show();
            if($("#activityClass").val()=='4'){
                $(".worktime").show();
            }else {
                $(".worktime").hide();
            }
        }
        function see(){
            if(clickStatus=='true') {
                if(!rowdata){
                    layer.alert("请先选择一条数据");
                    return
                }else{
                    activityid= rowdata.activityId;
                    $("#tpy").text("查看");
                    $('.popup').height($(document).height());
                    $('.popup').css('background-color', '#a1a1a1').slideDown(300);
                    $('.new').slideDown(400);
                    $("#see").show();
                    $("#edit").hide();
                    $("#btn_sub").hide();
                    laodStudentinfor(1);
                //    jsonPara={rows:rows,page:page,sqlActivityId:rowdata.activityId};
                }
            }else{
                layer.alert("请先选择一条数据");
            }
        }
        //上一页
        function turn_left1(){
            var page= parseInt($("#page1").val());
            if(page<=1){
                page=1;
            }else{
                page=page-1;
            }
            $("#page1").val(page);
            var pagNum = $("#page1").val();
            laodStudentinfor(pagNum);
        }
        //下一页
        function turn_right1(){
            var page= parseInt($("#page1").val());
            if(page>=Math.ceil(totalNum1/rows)){
                page=Math.ceil(totalNum1/rows);
            }else{
                page=page+1;
            }
            $("#page1").val(page);
            var page = $("#page1").val();
            laodStudentinfor(page);
        }
        function  laodStudentinfor(page){
            load();
            var loadUrl ='/jsons/loadSchoolActivityapply.form'
            $('#nameOrTeam').html('学生姓名');
            if('团体' == rowdata.activityParticipation){
                loadUrl ='/jsons/loadSchoolTeamActivityapply.form'
                $('#nameOrTeam').html('团体名称');
            }
            $.ajax({
                url: loadUrl,
                type: "post",
                data:{sqlActivityId:rowdata.activityId,rows:rows,page:page},
                dataType: "json",
                success: function (data) {
                    $("#tbody1").html("");
                    if (data != null && data.rows != null && data.rows.length > 0) {
                        for (var i = 0; i < data.rows.length; i++) {
                            var row = data.rows[i];
                            for(var key in row){
                                if(row[key]==null||row[key]=="null"){
                                    row[key]='';
                                }
                            }
                            var tr = '<tr id="tr1'+(i+1)+'">'+
                                    '<td>'+(i+1)+'</td>'+
                                        //第二处修改：按照数据库列名进行拼穿
                                    '<td class="fontStyle activityTitle " title="'+row.activityTitle+'">'+row.activityTitle+'</td>'+
//                                    '<td class="applyStudentId ">'+row.applyStudentId+'</td>'+
                                    '<td class="studentName " title="'+row.studentName+'">'+row.studentName+'</td>'+
                                    '<td class="applyDates ">'+row.applyDate+'</td>'+
                                    '<td class="activityAwardMean ">'+row.activityAwardMean+'</td>'+
                                    '<td class="signUpStatus ">'+row.signUpStatus+'</td>'+
//                                    '<td class="signUpTime ">'+row.signUpTime+'</td>'+
//                                    '<td class="activityParticipation ">'+row.activityParticipation+'</td>'+
//                                    '<td class="teamName " title="'+row.teamName+'">'+row.teamName+'</td>'+
                                    '</tr>';
                            tr=tr.replace(/undefined/g,"");
                            $("#tbody1").append(tr);
                            $("#tr1"+(i+1)).data(row);//存入data为后台修改时取数据
                        }
                        rowClick1();//绑定行点击事件
                        totalNum1=data.total;
                        $("#page1").val(page);
                        rows = 10;
                        $("#p0").html(Math.ceil( totalNum1/rows));
                        $("#p3").html(totalNum1);
                        if(totalNum1<=0){
                            $("#p2").html(0);
                            $("#p1").html(0);
                        }else if(totalNum1<page*rows){
                            $("#p2").html(totalNum1);
                            $("#p1").html(rows*(page-1)+1);
                        }else{
                            $("#p2").html(page*rows);
                            $("#p1").html(rows*(page-1)+1);
                        }
                       // console.log(totalNum);
                    }else {
                        totalNum1=0;
                        $("#p2").html(0);
                        $("#p1").html(0);
                        $("#p3").html(0);
                        $("#p0").html(1);
                    }
                }, error: function () {
                    layer.msg("网络错误");
                }
            })
            disLoad();
        }
        //行点击事件
        function rowClick1(){
            $("#tbody1").find("tr").click(function() {
                clickStatus='true';
                $("table tr").css('background-color','white');//先将颜色改为以前面的颜色
                $(this).css('background-color','yellow');//再将单击的那行改成需要的颜色
                rowdata1 = $(this).data();
//                console.log(rowdata1);
            });
        }
        function apply_close(){
            $("#student_dlg").hide();
            $(".popup").css({"z-index":"0"});
        }
        //新建
        function Add1(){
            if(rowdata.activityParticipation=='团体'){
                layer.msg("操作提示:参与形式为团体申请不允许添加，若想添加团体活动申请在团体管理里添加");
                return
            }
            $("#applyactivityTitle").val(rowdata.activityTitle);
            $("#applyStudentId").removeAttr("readonly");
            $("#applyStudentId").val("");
            $("#activityAward").val("");
            $(".AwardName").hide();
            $("table tr").css('background-color','white');//先将颜色改为以前面的颜色
            $(".popup").css({"z-index":"9000"});
            document.getElementById("b").style.display="none";
            document.getElementById("a").style.display="";
            $('#student_dlg').slideDown(400);
        }
        function applyStudent(){
            var applyStudentId=$("#applyStudentId").val();
            var activityAward=$("#activityAward").val();
            var applyActivityId=rowdata.activityId;
            var applyId=$("#applyId").val();
            if(activityAward=="其他"){
                activityAward=$("#AwardName").val();
            }
            $.ajax({
                url:"/jsons/loadstudentId.form",
                type:"post",
                dataType: "json",
                data:{student_id:applyStudentId},
                success: function (data) {
                    if(data==null||data.rows.length<=0){
                        layer.msg("学生不存在,请确认学号后添加！");
                        return false;
                    } else {
                        $.ajax({
                            url: "/jsons/loadT.form",
                            type: "post",
                            dataType: "json",
                            data: {student_id:applyStudentId,applyActivityId:applyActivityId},
                            success: function (data) {
                                if (data.rows.length > 0) {
                                    layer.msg("学生该项活动已经添加过！");
                                    return false;
                                }else{
//                                    if (applyId) {
//                                        URL = "/jsons/editSchoolActivityapplyStatus.form";
//                                    } else {
                                        URL = "/jsons/addSchoolActivityapplyStatus.form";
//                                    }
                                    $.ajax({
                                        url: URL,
                                        type: "post",
                                        dataType: "json",
                                        data: {
                                            applyActivityId: applyActivityId,
                                            applyStudentId: applyStudentId,
                                            activityAward: activityAward,
                                            applyId: applyId
                                        },
                                        success: function (data) {
                                            if (data.result) {
                                                layer.msg("操作成功！");
                                                laodStudentinfor(1);
                                            } else {
                                                layer.msg("操作失败！");
                                            }
                                        }
                                    });
                                }
                            }
                        });
                        $("#student_dlg").hide();
                        $(".popup").css({"z-index": "0"});
                    }
                }
            });
        }
        function award() {
            var applyStudentId = $("#applyStudentId").val();
            var activityAward = $("#activityAward").val();
            var applyActivityId =rowdata.activityId;
            console.log(rowdata);
            console.log(rowdata1);

            if(rowdata1.signUpStatus!='已签到'){
                layer.msg("未签到，不能颁奖！");
                return;
            }
            var applyId = $("#applyId").val();
            if (activityAward == "其他") {
                activityAward = $("#AwardName").val();
            }
            if (applyId) {
                URL = "/jsons/editSchoolActivityapplyStatus.form";
            } else {
                URL = "/jsons/addSchoolActivityapplyStatus.form";
            }
            if('团体' == rowdata.activityParticipation){
                URL = '/jsons/editSchoolActivityapplyTeamStatus.form'
            }
            $.ajax({
                url: URL,
                type: "post",
                dataType: "json",
                data: {
                    applyActivityId: applyActivityId,
                    applyStudentId: applyStudentId,
                    applyTeamId: rowdata1.applyTeamId,
                    activityAward: activityAward,
                    applyId: applyId
                },
                success: function (data) {
                    if (data.result) {
                        layer.msg("操作成功！");
                        laodStudentinfor(1);
                    } else {
                        layer.msg("操作失败！");
                    }
                }
            });
            $("#student_dlg").hide();
            $(".popup").css({"z-index": "0"});

        }
        function banjiang(){
            if(clickStatus=='true') {
                clickStatus='edit';
                postURL=editUrl;
                if(!rowdata){
                    layer.alert("请先选择一条数据");
                    return
                }else{
                    $("#student_dlg").show();
                    $("#applyactivityTitle").val(rowdata1.activityTitle);
                    $("#applyStudentId").val(rowdata1.applyStudentId);
                    $("#activityAward").val(rowdata1.activityAward);
                    $("#teamNameInput").val(rowdata1.teamName);
                    if(rowdata.activityParticipation=='团体'){
                        $("#applyStudentIdView").hide();
                        $("#teamNameView").show();
                    }else{
                        $("#applyStudentIdView").show();
                        $("#teamNameView").hide();
                    }

                    $(".AwardName").hide();
                    $("#applyStudentId").attr("readonly","readonly");
                    $("#applyId").val(rowdata1.applyId);
                    $("table tr").css('background-color','white');//先将颜色改为以前面的颜色
                    $(".popup").css({"z-index":"9000"});
                    document.getElementById("a").style.display="none";
                    document.getElementById("b").style.display="";
                    $('#student_dlg').slideDown(400);
                }
            }else{
                layer.alert("请先选择一条数据");
            }
        }
        function Delete1(){
            if(rowdata1==null){
                layer.alert("请先选择一条数据");
                return;
            }
            if(rowdata1.activityParticipation=="团体"){
                layer.msg("团体活动申请请到团体报名管理删除。");
                return;
            }
            layer.confirm('确认删除此条数据吗?', function(result) {
                    if (result) {
                        //删除数据库记录
                        load();
                        var applyId =rowdata1.applyId;
                        $.post("/jsons/deleteSchoolActivityapplyStatus.form",{applyId:applyId}, function (data) {
                            if (data.result) {
                                disLoad();
                                //console.log(data);
                                layer.msg("删除成功");
                                laodStudentinfor(1);//重新加载数据
                            } else {
                                layer.msg("删除失败，请重新登录或联系管理员");
                            }
                        });
                    }
                });
        }
        function class_Insert (){
            $(".popup").css({"z-index":"9000"});
            $("#class_dlg").show();
        }
        function class_close(){
            $(".popup").css({"z-index":"0"});
            $("#class_dlg").hide();
        }
        function applyClass(){
            var stuClassName=$("#stuClassName").val();
            if(rowdata.activityParticipation=="团体"){
                layer.msg("团体活动申请请到团体报名管理申请。")
                return;
            }
            if(!rowdata.activityId){
                layer.msg("请先选择活动。")
                return;
            }


            $.ajax({
                url: "/jsons/classApply.form",
                type: "post",
                data:{stuClassName:stuClassName,activityId:rowdata.activityId},
                dataType: "json",
                success: function (data) {
                    if (data.result) {
                        class_close()
                        layer.alert("保存成功");
                        laodStudentinfor(1);
                    }
                    if (data.msg) {
                        class_close()
                        layer.alert(data.msg);
                    }
                }, error: function () {
                    class_close()
                    layer.msg("网络错误");
                }
            })
        }
        //下载模板
        function getModels(){
            if(rowdata.activityParticipation=='团体'){
                layer.msg("操作提示:参与形式为团体的活动不允许批量添加申请，若想添加申请在团体管理里添加");
                return
            }
            if(rowdata.activityId){
                window.open("/Files/ExcelModels/stu_activityapply.xls");
            }else{
                layer.msg("请选择一个活动")
            }
        }
        function before_batchInsert(val){
            importsta=val;
            if(rowdata.activityParticipation=='团体'){
                layer.msg("操作提示:参与形式为团体的活动不允许批量添加申请，若想添加申请在团体管理里添加");
                return
            }
            batchInsert();
        }
        /**
         * 批量导入按键
         */
        function batchInsert(){
            $(".popup").css({"z-index":"9000"});
            $("#batch_dlg").show();//显示
        }
        function batchInsertClose(){
            $(".popup").css({"z-index":"0"});
            $("#batch_dlg").hide();//不显示
        }
        function uploadActivityFile(){
            if(!$("#upfile").val()){
                layer.msg("请选择文件！");
                return;
            }
            if(!rowdata.activityId){
                layer.msg("请先选中一个活动，再进行批量上传");
            }
            load();
            $.ajaxFileUpload({
                url: "/dataupload/studentinfo.form?activityid="+rowdata.activityId+"&sta="+importsta, //用于文件上传的服务器端请求地址,b 补充导入 f 覆盖导入
                secureuri: false, //一般设置为false
                fileElementId: "upfile", //文件上传空间的id属性
                dataType: 'String', //返回值类型 一般设置为String
                success: function (data,status,e)  //服务器成功响应处理函数
                {
                    showResult(data);
                    disLoad();
                    laodStudentinfor(1);
                },
                error: function (data, status, e)//服务器响应失败处理函数
                {
                    layer.msg("学号输入有误，请确认后重新上传");
                    disLoad();
                }
            });
        }
        //发布活动，用以进入活动结果审核
        function publish(){
            layer.confirm('确认发布后，此活动将进入活动结果审核！', function(result) {
                if (result) {
                    $.ajax({
                        url: "/jsons/publishactivity.form",
                        type: "post",
                        data:{activityId:activityid},
                        dataType: "json",
                        success: function (data) {
                            if (data.result) {
                                class_close()
                                layer.alert("保存成功");
                                laodStudentinfor(1);
                            }
                            if (data.msg) {
                                class_close()
                                layer.alert(data.msg);
                            }
                        }, error: function () {
                            class_close()
                            layer.msg("网络错误");
                        }
                    })
                }
            });
        }
    </script>
    <style type="text/css">
        *{
            padding:0;
            border:0;
            font-family:"微软雅黑";
        }
        #search{
            position: absolute;
            right: 0px;
            top: 4px;
            width: 22px;
            background: url(/asset_admin_new/img/icon_synsearch.png) no-repeat;
            background-position: 0px 2px;
        }
        .dateinput{
            width: 95px;
            height: 9px;
            border: 1px solid #1990fe;
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
        .new>div>ul>li>span:first-child {
            display: inline-block;
            color: #1990fe;
            font-weight: bold;
        }
        .new>div>ul {
            display: block;
            position: relative;
            padding: 22px 0 12px 28px;
        }
        .new>div>ul>li {
            position: relative;
            display: block;
            margin-bottom: 10px;
            padding-right: 14px;
        }
    </style>
    <%--判断是否是登录状态--%>
    <%@include file="../common/CheckLogin.jsp"%>
</head>
<body>
<div class="stuMsgManage">
    <%--4、第三处修改，修改菜单按钮，选择哪些按钮需要--%>
        <!--功能栏-->
        <div class="function">
            <ul>
                <li class="function_search"><span>综合条件查询</span></li>
                <li class="function_new" onclick="Adds()"><span>新建</span></li>
                <li class="function_edit" onclick="Edits()"><span>修改</span></li>
                <li class="function_edit" onclick="see()"><span>报名颁奖</span></li>
                <li class="function_remove" onclick="Delete()"><span>删除</span></li>
                <li class="function_refresh" onclick="reload_this()"><span>刷新当前页</span></li>
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
                                    <%--<option value="6">其他类</option>--%>
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
                            <span>活动限制学院:</span>
                            <div>
                                <select id="_stuCollageName" name="stuCollageName" class="searchselect">
                                    <option value="" >请选择</option>
                                    <option value="" >全部</option>

                                </select>
                            </div>
                        </li>
                        <li>
                            <span>活动限制年级:</span>
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
                            <input type="text" id="_activityCredit"  name="activityCredit" />
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
                <td>活动标题</td>
                <%--<td>活动范围</td>--%>
                <td>活动类型</td>
                <td>活动级别</td>
                <td>活动性质</td>
                <%--<td>活动地点</td>--%>
                <%--<td>活动学分</td>--%>
                <td>参与形式</td>
                <td>开始日期</td>
                <td>结束日期</td>
                <td>报名截止日期</td>
                <td>创建者</td>
                <td>创建日期</td>
                <td>是否可线上报名</td>
                <td>是否已发布</td>
                <%--<td>负责人</td>--%>
                <%--<td>负责人电话</td>--%>
            </tr>
            </thead>
            <tbody id="data_demo">

            </tbody>
        </table>
    </div>
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
            <span  type="reset" class="iconConcel"></span>
        </div>
        <input type="hidden" id="photo_textbox" name="activityImg"><!--此处图片名字为数据库名-->
      <div id="edit"  style="display: none">
        <div id="userphoto_box" style="height: 60px; width: 400px; float: right;margin-top:15px;">
            <img id="activityImgs" src="<%=request.getContextPath()%>/asset/image/default.jpg" onerror="error=null;src='<%=request.getContextPath()%>/asset/image/default.jpg'" style="width: 240px;height: 150px;margin-right: 10px;">
        </div>

        <ul>
            <li>
                <span>活动标题&nbsp;&nbsp;:&nbsp;&nbsp;&nbsp;&nbsp;</span>
                <input type="text" id="activityTitle" name="activityTitle"  class="combobox notNull"  />
            </li>

            <li>
                <span>活动范围&nbsp;&nbsp;:&nbsp;&nbsp;&nbsp;&nbsp;</span>
                <select id="activityArea" name="activityArea"   class="select">
                    <option value="学校">学校</option>
                    <option value="学院">学院</option>
                    <option value="职能部门">职能部门</option>
                </select>
            </li>
            <li>
                <span>活动类别&nbsp;&nbsp;:&nbsp;&nbsp;&nbsp;&nbsp;</span>
                <select id="activityClass" name="activityClass" class="select">
                    <c:forEach items="${activityClasses}" var="activityClass">
                        <option value="${activityClass.dictvalue}">${activityClass.dictmean}</option>
                    </c:forEach>
                </select>
            </li>
            <li  class="worktime">
                <span>服务时长&nbsp;&nbsp;:&nbsp;&nbsp;&nbsp;&nbsp;</span>
                <input type="text" id="worktime" name="worktime" class="combobox"   placeholder="几天或几小时"/>
            </li>
            <li>
                <span>活动级别&nbsp;&nbsp;:&nbsp;&nbsp;&nbsp;&nbsp;</span>
                <select id="activityLevle" name="activityLevle" class="select">
                    <c:forEach items="${activityLevels}" var="activityLevle">
                        <option value="${activityLevle.dictvalue}">${activityLevle.dictmean}</option>
                    </c:forEach>
                </select>
            </li>
            <li>
                <span>活动性质&nbsp;&nbsp;:&nbsp;&nbsp;&nbsp;&nbsp;</span>
                <select id="activityNature" name="activityNature" class="select">
                    <c:forEach items="${activNatures}" var="activityNature">
                        <option value="${activityNature.dictvalue}">${activityNature.dictmean}</option>
                    </c:forEach>
                </select>
            </li>
            <li>
                <span>活动学分&nbsp;&nbsp;:&nbsp;&nbsp;&nbsp;&nbsp;</span>
                <input type="text" id="activityCredit" name="activityCredit" class="combobox"  />
                <span style="color: red;vertical-align: middle">*</span>
                <span style="font-size: 10px">参与该活动可获得活动学分</span>
            </li>
            <li>
                <span>参与形式&nbsp;&nbsp;:&nbsp;&nbsp;&nbsp;&nbsp;</span>
                <select id="activityParticipation" name="activityParticipation" class="select">
                    <option value="不限">不限</option>
                    <option value="个人">个人</option>
                    <option value="团体">团体</option>
                </select>
            </li>
            <li>
                <span>活动地点&nbsp;&nbsp;:&nbsp;&nbsp;&nbsp;&nbsp;</span>
                <input type="text" id="activityLocation" name="activityLocation" class="combobox" />
                <%--<span class="Validform_checktip">请填写新闻标题</span>--%>
                <span style="color: red;vertical-align: middle">*</span>
                <span style="font-size: 10px">具体地点(礼堂、操场等)</span>
            </li>
           <li>
                <span>活动封面&nbsp;&nbsp;:&nbsp;&nbsp;&nbsp;&nbsp;</span><!--此处图片名字为数据库名+s-->
                <input id="activityImg" name="activityImgs" type="file" style="border:0" onchange="preview(this)" />
            </li>
            <li>
                <span>活动限制条件的类型&nbsp;&nbsp;:&nbsp;&nbsp;&nbsp;&nbsp;</span><!--此处图片名字为数据库名+s-->
                <input class="filter_ckeck none  test" type="checkbox" id="ax1" name="ax" value="不限">不限
                <input class="filter_ckeck coll  test" type="checkbox" id="ax2" name="ax" value="年级">年级
                <input class="filter_ckeck coll  test" type="checkbox" id="ax3" name="ax" value="学院">学院
            </li>
            <li>
                <span>年级过滤&nbsp;&nbsp;:&nbsp;&nbsp;&nbsp;&nbsp;</span>
                <select id="classYear" name="classYear"   disabled class="select">
                    <c:forEach items="${grades}" var="grade">
                        <option value="${grade.stuGradeName}">${grade.stuGradeName}</option>
                    </c:forEach>
                </select>
                <span style="color: #1990fe;">学院过滤&nbsp;&nbsp;:&nbsp;&nbsp;&nbsp;&nbsp;</span>
                <select id="classCollege" name="classCollege" disabled class="select">
                    <c:forEach items="${colleges}" var="college">
                        <option value="${college.stuCollageName}">${college.stuCollageName}</option>
                    </c:forEach>
                </select>
            </li>
            <li>
                <span>是否可线上报名&nbsp;&nbsp;:&nbsp;&nbsp;&nbsp;&nbsp;</span>
                <input type="radio" id="online1" name="online"  value="0" >可以
                <input type="radio" id="online2" name="online"  value="1">不可以
            </li>
            <li>
                <span>开始时间&nbsp;&nbsp;:&nbsp;&nbsp;&nbsp;&nbsp;</span>
                <input type="text"  id="activitySdate" name="activitySdate"  class="combobox"  onclick="laydate()"/>
                <span style="color: #1990fe;">结束时间&nbsp;&nbsp;:&nbsp;&nbsp;&nbsp;&nbsp;</span>
                <input type="text" id="activityEdate" name="activityEdate"  class="combobox" onclick="laydate({format: 'YYYY-MM-DD 23:59:59'})" />
                <%--<span class="input_memo_text">*开始时间不得晚于结束时间</span>--%>
            </li>
            <li>
                <span>报名截止时间</span>
                <input type="text"  id="activityApplyedate" name="activityApplyEdate"  class="combobox"  onclick="laydate()"/>
                <%--<span class="input_memo_text">*报名截止时间不得晚于活动开始时间</span>--%>
            </li>
            <li>
                <span>能力标签&nbsp;&nbsp;:&nbsp;&nbsp;&nbsp;&nbsp;</span>
                <input type="checkbox" class="qx_check test" id="qx1" name="qx" value="思辨能力" />思辨能力
                <input type="checkbox" class="qx_check test" id="qx2" name="qx" value="执行能力" />执行能力
                <input type="checkbox" class="qx_check test" id="qx3" name="qx" value="表达能力" />表达能力
                <input type="checkbox" class="qx_check test" id="qx4" name="qx" value="领导能力" />领导能力
                <input type="checkbox" class="qx_check test" id="qx5" name="qx" value="创新能力" />创新能力
                <input type="checkbox" class="qx_check test" id="qx6" name="qx" value="创业能力" />创业能力
            </li>
            <li>
                <span>负责人&nbsp;&nbsp;:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span>
                <input id="principal" name="principal"  type="text" class="combobox"/>
            </li>
            <li>
                <span>负责人电话&nbsp;&nbsp;:</span>
                <input id="principalphone" name="principalphone" type="text" class="combobox" />
            </li>
            <%--&lt;%&ndash;KindEditor文本框放在Form外面，如果不需要KindEditor，注释掉&ndash;%&gt;--%>
            <li>
                <span>活动内容&nbsp;&nbsp;:&nbsp;&nbsp;&nbsp;&nbsp;</span>
                <textarea id="activityContent" name="activityContent" style="width:100%;height:330px;" ></textarea>
            </li>
        </ul>
   </div>
     <div id="see" style="display: none">
         <!--功能栏-->
         <div class="function">
             <ul>
                 <li class="function_new" onclick="Add1()"><span>新建</span></li>
                 <li class="function_edit" onclick="banjiang()"><span>颁奖</span></li>
                 <li class="function_remove" onclick="Delete1()"><span>删除</span></li>
                 <li class="function_import" onclick="class_Insert()"><span>班级批量报名</span></li>
                 <%--<li class="function_import" onclick="before_batchInsert()"><span>导入信息</span></li>--%>
                 <li class="function_downModel" onclick="getModels()"><span>下载模版</span></li>
                 <li class="function_import" onclick="publish()"><span>发布</span></li>
                 <li class="function_import" onclick="before_batchInsert('b')"><span>补充导入</span></li>
                 <li class="function_import" onclick="before_batchInsert('f')"><span>覆盖导入</span></li>
                 <li class="function_refresh" onclick="laodStudentinfor(1)"><span>刷新</span></li>
             </ul>
         </div>
        <div class="table">
            <table border="0" cellspacing="0" cellpadding="0">
                <thead>
                <tr>
                    <td></td>
                    <td>活动标题</td>
                    <%--<td>学生学号</td>--%>
                    <td id="nameOrTeam">学生姓名</td>
                    <td>申请日期</td>
                    <td>获奖情况</td>
                    <td>签到状态</td>
                    <%--<td>签到时间</td>--%>
                    <%--<td>参与形式</td>--%>
                    <%--<td>团体名字</td>--%>
                    <%--<td>是否已发布</td>--%>
                </tr>

                </thead>
                <tbody id="tbody1">

                </tbody>

            </table>
            <div class="pagingTurn">
                <div>
                    <span class="turn_left" onclick="turn_left1()"></span> 第
                    <input id="page1" class="currentPageNum" value="1"/> 页，共
                    <span id="p0" class="pageNum1" > </span> 页
                    <span class="turn_right" onclick="turn_right1()"></span>
                </div>
                <div>
                    显示<span id="p1" class="pageNum1"> </span>到<span id="p2" class="pageNum1"> </span>，共<span id="p3" class="pageNum1"> </span>条记录
                </div>
            </div>
        </div>
    </div>
        <!--按钮窗口-->
        <div id="dlg-buttons" class="new_buttons">
            <input type="button" id="btn_sub" value="保存" onclick="Saves()" />
            <input type="reset" value="取消" class="iconConcel" />
        </div>
  </div>
</form>
<%--选择班级批量导入报名--%>
<div id="class_dlg"  title="批量导入"  style="display:none;width:400px;height:380px;padding:10px;position:absolute;
       border: 1px solid #197FFE; left:35%;top:25%;background-color: #FFFFFF;z-index: 10000;">
    <div id="class_box" style="margin-bottom: 10px;margin-top: 10px;">
        <span style="color: #1990fe;">选择班级&nbsp;&nbsp;:&nbsp;&nbsp;&nbsp;&nbsp;</span>
        <img style="float: right;position: absolute;top: 15px;right: 15px;" src="../../../asset_font_new/img/windowclose_03.png" onclick="class_close()">
        <select id="stuClassName" name="stuClassName"  style="width: 160px;height: 33px; border: 1px solid #1990fe;">
            <option value="">请选择</option>
        </select>
    </div>
    <!--按钮窗口-->
    <div id="class_buttons" class="new_buttons">
        <input type="button" id="class_sub" value="确认"  style="margin-left: 72px;margin-top: 50px;width: 50px;" onclick="applyClass()" />
        <input type="button" value="关闭"  style="margin-left: 48px;margin-top: 50px;width: 50px;" onclick="class_close()" />
    </div>
</div>
<%--批量导入对话框--%>
<div id="batch_dlg"  title="批量导入"  style="display:none;width:400px;height:380px;padding:10px;position:absolute;
    border:3px #c1dadb solid; left:35%;top:25%;background-color:#ffffff;z-index: 10000;">
    <div id="file_box" style="margin-bottom: 10px;margin-top: 10px;">
        <label>选择文件:</label>
        <input id="upfile" style="display: inline-block;width: 200px;" name="fileup" type="file"/>
        <img style="float: right;position: absolute;top: 15px;right: 15px;" src="../../../asset_font_new/img/windowclose_03.png" onclick="batchInsertClose()">
    </div>
    <div id="_box" style="margin-bottom: 10px;margin-top: 10px;">
        <label></label>
    </div>
    <div id="btn_box" style="margin-bottom: 10px;margin-top: 10px;">
        <label></label>
        <a href="javascript:void(0)"  onclick="validFile()">验证文件</a>&nbsp;&nbsp;&nbsp;&nbsp;
        <a href="javascript:void(0)"  onclick="uploadActivityFile()">上传并导入</a>
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
<%--批量导入对话框--%>

<div id="student_dlg"  title="学生活动申请"  style="display:none;width:400px;height:380px;padding:10px;position:absolute;
       border: 1px solid #197FFE; left:35%;top:25%;background-color: #FFFFFF;z-index: 10000;">
    <div  style="margin-bottom: 10px;margin-top: 10px;">
        <ul>
            <li style="position: relative;display: block;margin-bottom: 10px;padding-right: 14px;">
                <span style="color: #1990fe;">活动标题&nbsp;&nbsp;:&nbsp;&nbsp;&nbsp;&nbsp;</span>
                <img style="float: right" src="../../../asset_font_new/img/windowclose_03.png" onclick="apply_close()">
                <input  id="applyactivityTitle"  type="text" style="width: 142px;height: 22px; border: 1px solid #1990fe;" readonly/>
            </li>
            <li style="position: relative;display: block;margin-bottom: 10px;padding-right: 14px;" id="applyStudentIdView">
                <span style="color: #1990fe;">学生学号&nbsp;&nbsp;:&nbsp;&nbsp;&nbsp;&nbsp;</span>
                <input  id="applyStudentId" name="applyStudentId"  type="text" style="width: 142px;height: 22px; border: 1px solid #1990fe;"/>
            </li>
            <li style="position: relative;display: block;margin-bottom: 10px;padding-right: 14px;" id="teamNameView">
                <span style="color: #1990fe;">团队名称&nbsp;&nbsp;:&nbsp;&nbsp;&nbsp;&nbsp;</span>
                <input  id="teamNameInput" name="teamName"  type="text" style="width: 142px;height: 22px; border: 1px solid #1990fe;" readonly/>
            </li>
            <li style="position: relative;display: block;margin-bottom: 10px;padding-right: 14px;">
                <span style="color: #1990fe;">所获奖项&nbsp;&nbsp;:&nbsp;&nbsp;&nbsp;&nbsp;</span>
                <select id="activityAward" name="activityAward"  style="width: 148px;height: 33px; border: 1px solid #1990fe;">
                    <option value="">请选择</option>
                    <option value="一等奖">一等奖</option>
                    <option value="二等奖">二等奖</option>
                    <option value="三等奖">三等奖</option>
                    <option value="无">无</option>
                    <option value="其他">其他</option>
                </select>
            </li>
            <li style="display: none;position: relative;display: block;margin-bottom: 10px;padding-right: 14px;" class="AwardName">
                <span style="color: #1990fe;">奖项名称&nbsp;&nbsp;:&nbsp;&nbsp;&nbsp;&nbsp;</span>
                <input  id="AwardName" name="AwardName"  type="text" style="width: 142px;height: 22px; border: 1px solid #1990fe;"/>
            </li>
        </ul>
        <input type="hidden" id="applyId"/>
    </div>
    <!--按钮窗口  style="display:none"-->
    <%--<div id="a" class="new_buttons">--%>
        <%--<input type="button" value="确认"  onclick="applyStudent()" />--%>
        <%--<input type="button" value="关闭"  onclick="apply_close()" />--%>
    <%--</div>--%>
    <div id="b" class="new_buttons" >
        <input type="button" value="确认"  onclick="award()" />
        <input type="button" value="关闭"  onclick="apply_close()" />
    </div>

</div>
</body>
</html>