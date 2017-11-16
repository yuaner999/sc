<%--
  Created by IntelliJ IDEA.
  User: gq
  Date: 2017/2/28
  Time: 17:44
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java"  pageEncoding="UTF-8" %>
<html>
<head>
    <link rel="Shortcut Icon" href="<%=request.getContextPath()%>/asset/image/neu.jpg" type="image/x-icon">
    <!-- 导入页面控制js jq必须放最上面 -->
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
    <title>活动结束审核管理</title>
    <script type="text/javascript">
        var moduleType = GetQueryString("moduleType");//所属模块的ID，不可以删除
        var supClass = GetQueryString("category");   //六大类参数
        //1、第一处修改，修改增删改的请求地址
        var addUrl = "";
        var editUrl = "/jsons/UpdateSupplement.form";
        var deleteUrl = "";
        var editorName = "null";//KindEditor的Textarea的ID，如果没用到，赋值为null
        var imageUpload = "";//图片上传的标识，如果没有图片上传，赋值为空，如果有，赋值为数据库存放图片名称的字段名称，不带_
        var deleteId = "";//用于删除功能的ID参数，赋值为当前数据库表的ID
        var editId = "";//用于修改功能的ID参数，赋值为当前数据库表的ID
        var loadUrl = "/supplementInfo/loadSupplementCollege.form";//注：此处为新增
        var sqlStr = "";//注：模糊查询
        var jsonPara;//参数
        var applyId="";
        var orderByName='1';//按照该字段排序
        var sequence=0; // 0正序 1倒序
        $(function(){
            $(".table").hide();
            $(".pagingTurn").hide();
            $(".searchContent").show();
            $("#submitAll").change(function(){
                if($(this).is(":checked")){
                    $(".checkes").attr("checked",true);
                }else {
                    $(".checkes").attr("checked",false);
                }
            });
            //排序
            $("#forOrder>td").click(function () {
                var str=$(this).html();
                if(str.indexOf("checkbox")>=0)
                    return;
                if($(this).hasClass("beSelect")){
                    sequence++;
                    if(sequence==2) sequence=0;
                }else{
                    sequence=0;
                    $(this).siblings().removeClass('beSelect');
                    $(this).addClass("beSelect");
                }
                orderByName=($(this).text());
                select_box(1);
            })
            //绑定跳页Enter键
            $(".currentPageNum").keyup(function(e){
                var pagNum = $(".currentPageNum").val();
                if(e.keyCode==13){
                    select_box(pagNum);
                }
            });
            $(".sure").hover(function(){
                $(this).css("background-color","#1990fe").css("color","white")},function(){
                $(this).css("background-color","white").css("color","#1990fe");
            })
            //点击关闭
            $(".iconConcel").click(function(){
                $('.new').slideUp(300);
                $('.popup').slideUp(400);
                $("#getScore").show();
                rowdata=null;
                $(".qx_check").attr("checked",false);
            });
            //至少选择一个
            $(".qx_check").click(function(){
                var qxs=$(".qx_check:checked");
                if(qxs.length>3){
                    layer.alert("最多只能选3项增加能力",{offset:['30%'] });
                    $(this).attr("checked",false);
                }
                if(qxs.length<1){
                    layer.alert("必须选一项增加能力",{offset:['30%'] });
                    $(this).attr("checked",false);
                    return false;
                }
            });
            <%--//综合查询条件：学院--%>
            <%--$.ajax({--%>
                <%--url: "<%=request.getContextPath()%>/jsons/loadstuCollageName.form",--%>
                <%--dataType: "json",--%>
                <%--data:{stuCollageName:''},--%>
                <%--success: function (data) {--%>
                    <%--var friends = $("#_stuCollageName");--%>
                    <%--friends.empty();--%>
                    <%--friends.append("<option value=''>请选择</option>");--%>
                    <%--friends.append("<option value=''>全部</option>");--%>
                    <%--if(data.rows !=null && data.rows.length > 0){--%>
                        <%--for(var i=0;i<data.rows.length;i++) {--%>
                            <%--var option = $("<option>").text(data.rows[i].stuCollageName).val(data.rows[i].stuCollageName);--%>
                            <%--friends.append(option);--%>
                        <%--}--%>
                    <%--}else{--%>
                        <%--var option = $("<option>").text("无");--%>
                        <%--friends.append(option);--%>
                    <%--}--%>
                <%--}--%>
            <%--});--%>
            <%--$("#_stuCollageName").change(function(){--%>
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
//            })
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
        });
        //阻止checkbox 冒泡
        function stopBubble(e) {
            if (e && e.stopPropagation) {
                e.stopPropagation();
            }
            else {
                window.event.cancelBubble = true;
            }
        }
        function  reload() {//此处加载数据方法名不能修改，必须用reload
            $(".table").show();
            $(".pagingTurn").show();
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
                                if(!row[key] || row[key]=="null"){
                                    row[key]="";
                                }
                            }
                            var tr = '<tr id="tr'+(i+1)+'" onclick=" SearchDetail(this)">'+
                                    '<td onclick="stopBubble(this)">'+ '<input name="test" class="checkes" type="checkbox" id="submint'+i+'" style="width:18px;height: 20px;" />'+'</td>'+
                                        //第二处修改：按照数据库列名进行拼穿
                                    '<td class="X" title="'+row.stuClassName +'">'+row.stuClassName+'</td>'+
                                    '<td class="X" title="'+row.studentName +'">'+row.studentName+'</td>'+
                                    '<td class="X" title="'+row.supStudentId +'">'+row.supStudentId+'</td>'+
                                    '<td class="X" title="'+row.supActivityTitle +'">'+row.supActivityTitle+'</td>'+

                                    '<td class="X" title="'+row.regimentAuditStatus +'">'+row.regimentAuditStatus+'</td>'+
                                    '<td class="X" title="'+row.collegeAuditStatus +'">'+row.collegeAuditStatus+'</td>'+
                                    '<td class="X" title="'+row.schoolAuditStaus +'">'+row.schoolAuditStaus+'</td>'+
                                        // '<td><a  href="javascript:void(0);" onclick="SearchDetail(this)">查看详情</a></td>'+
                                    '</tr>';
                            $("tbody").append(tr);
                            $("tbody").find("tr:last").data(row);
                        }
                        totalNum=data.total;
                    }else {
                        page=0;
                        totalNum=0;
                    }
                    paging();
                    disLoad();
                    $("tbody .X").bind("click",function()
                    {
                        SearchDetail(this);
                    });
                    $("tbody tr").bind("click",function()
                    {
                        SearchDetail(this);
                    });

                }, error: function () {
                    layer.msg("网络错误");
                    disLoad();
                }
            })
        }
        //查看赋值
        function SearchDetail(btn){
            $("#tb").show();
            $("#dlg").show();
            var row=$(btn).parent().data();

            var row=$(btn).parent().parent().data();

            var row=$(btn).data();

            $("#supPhotos").attr("src","/Files/Images/default.jpg");
            if(row){
                if(row.supType=="主题团日") $("#getScore").hide();
                for(var key in row){
                    if(row[key]!=null&&row[key]!=""){
                        $('#'+key).show();
                        $('#Form [name='+key+']').val(row[key]);
                        if(key!="supActivityTitle"&&key!="supLevle"&&key!="id"&&key!="supCredit"){
                            $('#Form [name='+key+']').attr("disabled","disabled");
                        }
                        $('#Form [name='+key+']').attr("title",row[key]);
                    }else {
                        $('#'+key).hide();
                    }
                    if(row.supAward!="一等奖"&&row.supAward!="二等奖"&&row.supAward!="三等奖"&&row.supAward!=""&&row.supAward!=null){
                        $("#Award").show();
                        $('[name="Award"]').val(row.supAward);
                        $('[name="supAward"]').val("其他");
                    }else {
                        $("#Award").hide();
                        $("#supAward").val(row.supAward);
                    }
                    var supPowers=row.supPowers;
                    if(supPowers!=null&&supPowers!=""){
                        var activityPowers=supPowers.split("|");
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
                }
                if(row.supPhoto){
                    var databasephoto=row.supPhoto;
                    var photoes=databasephoto.split("|");
                    $("#supPhotos").attr("src","/Files/Images/"+photoes[0]);
                    $("#index").text("当前第"+1+"张,");
                    $("#ids").text(photoes.length);
                    var i=0;
                    $("#userphoto_box").click(function(){

                        i++;
                        if(i==photoes.length){
                            i=0;
                        }
                        $("#supPhotos").attr("src","/Files/Images/"+photoes[i]);
                        $("#index").text("当前第"+(i+1)+"张,");
                    });
                }else{
                    $("#supPhotos").attr("src","<%=request.getContextPath()%>/asset/image/default.jpg");
                    $("#index").text("当前第0张,");
                    $("#ids").text(0);
                    $('#userphoto_box').unbind("click");
                }
            }
        }
        //保存
        function Saves() {
            var jsonObject = $("#Form").serializeObject();
            jsonObject["moduleType"] = moduleType;
            var supPowers = "";
            var qxs = $(".qx_check:checked");
            if ($("#supType").val() != "非活动类" && $("#supClass").val() != "6") {
                if (qxs.length < 1) {
                    layer.msg("必须选一项增加能力", {offset: ['30%']});
                    $(this).attr("checked", false);
                    return false;
                }
                var str = "";
                if (qxs != null && qxs != "") {
                    for (var i = 0; i < qxs.length; i++) {
                        var val = $(qxs[i]).val();
//                        console.log(val)
                        str = str + val + "|";
                    }
                }
                supPowers = str.substring(0,str.length-1);
            }
            jsonObject["supPowers"] =supPowers
            postURL=editUrl;
            UploadToDatabase(jsonObject);
        }
        //审核通过
        function auditsAction(type){

            //增加能力复选框验证
            var qxs=$(".checkes:checked");
            if(qxs.length<1){
                layer.msg("请选择",{offset:['30%'] });
                return false;
            }else if(qxs.length>1){
                $("#score").val("").css("background","#eee").attr("readonly","readonly");
            }else{
                var rowdata=$(qxs[0]).parents("tr").data();
                if(rowdata){
                    var point=rowdata.supCredit;
                    $("#score").val(point ? point : "0.25").css("background","#fff").removeAttr("readonly");
                }else
                $("#score").val("0.25").css("background","#fff").removeAttr("readonly");
            }
            /**
             * 取出选中的数据
             */
            applyId ="";
            var isNewAdd="";
            var regimentAuditStatuses="";
            var collegeAuditStatuses="";
            var schoolAuditStauses="";

            var role = "${sessionScope.sysrole}";

            $('input:checkbox:checked').each(function() {
                var row=$(this).parent().parent().data();
                applyId+=row.id+"|";
                isNewAdd+=row.isNewAdd+"|";
                regimentAuditStatuses+=row.regimentAuditStatus+"|";
                collegeAuditStatuses+=row.collegeAuditStatus+"|";
                schoolAuditStauses+=row.schoolAuditStaus+"|";
            });
            if(regimentAuditStatuses.indexOf("未通过")>=0||regimentAuditStatuses.indexOf("修改")>=0){
                layer.msg("操作失败,包含有班级审核结果为'未通过'或'修改'的数据");
                return;
            }
            if(regimentAuditStatuses.indexOf("待审核")>=0){
                layer.msg("操作失败,包含有班级未审核数据");
                return;
            }
           /* if(collegeAuditStatuses.indexOf("未通过")>=0||collegeAuditStatuses.indexOf("修改")>=0){
                layer.msg("操作失败,包含有学院审核结果为'未通过'或'修改'的数据");
                return;
            }*/
            if(role != "学院团委") {
                if (collegeAuditStatuses.indexOf("待审核") >= 0) {
                    layer.msg("操作失败,包含有学院未审核数据");
                    return;
                }
            }
            if (schoolAuditStauses.indexOf("已通过")>=0||schoolAuditStauses.indexOf("未通过")>=0||schoolAuditStauses.indexOf("修改")>=0) {
                layer.msg("您选中的项目中有审核过的，不能重复审核");
            }
            if(applyId==""){
                layer.msg("请选择一行数据");
                return;
            }
            $("#sc_score").show();
            $("#sc_reason").hide();
            layer.confirm('确认此操作吗?!', function(result) {
                layer.closeAll('dialog');
                if (result){

                    $("#tb2").show();
                    $("#dlg2").show();
                    $("#btn_sub").click(function(){
                        var score=  $("#score").val();
                        if(1){
                            $.ajax({
                                url:"/apply/CollegeAuditSupplementScore.form",
                                type: "post",
                                data:{applyId:applyId.substring(0,applyId.length-1),Type:type,score:score},
                                dataType: "json",
                                success: function (data) {
                                    if(data){
                                        layer.msg(data.msg);
                                        $("#submitAll").attr("checked",false);
                                        $('#dlg2').hide();
                                        $('.popup').slideUp(400);
                                        $('.new').slideUp(300);
                                        select_box(1);
                                        applyId='';
                                    }
                                }, error: function () {
                                    layer.msg("网络错误");
                                    select_box(1);
                                    applyId='';
                                }
                            })
                        }else{
                            layer.msg('请输入分数');
                        }
                    });
                }
            })
        }
        function showpicture(supPhoto){
            $("#tb").show();
            $("#dlg").show();
//            console.log(supPhoto);
            $("#user_photo").attr("src","/Files/Images/default.jpg");
            if(supPhoto!=null&&supPhoto!=""){
                var databasephoto=supPhoto;
                var photoes=databasephoto.split("|");
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
                    $("#index").text("当前第"+(i+1)+"张,");
                });
            }else{
                $("#index").text("当前第0张,");
                $("#ids").text(0);
                $('#userphoto_box').unbind("click");
            }
        }
        //审核不通过
        function auditsAction_no(type){
            var qxs=$(".checkes:checked");
            applyId = "";
            var regimentAuditStatuses="";
            var collegeAuditStatuses="";
            var schoolAuditStauses="";
            if(qxs.length<1){
                layer.msg("请选择",{offset:['30%'] });
                return false;
            }else if(qxs.length==1){

                $('input:checkbox:checked').each(function () {
                    var row = $(this).parent().parent().data();
                    applyId = row.id ;
                    regimentAuditStatuses=row.regimentAuditStatus;
                    collegeAuditStatuses=row.collegeAuditStatus;
                    schoolAuditStauses=row.schoolAuditStaus;
                });
                if(regimentAuditStatuses.indexOf("未通过")>=0||regimentAuditStatuses.indexOf("修改")>=0){
                    layer.msg("操作失败,该条数据班级审核结果为'未通过'或'修改'");
                    return;
                }
                if(regimentAuditStatuses.indexOf("待审核")>=0){
                    layer.msg("操作失败,该条数据班级未审核");
                    return;
                }
                if(collegeAuditStatuses.indexOf("未通过")>=0||collegeAuditStatuses.indexOf("修改")>=0){
                    layer.msg("操作失败,该条数据学院审核结果为'未通过'或'修改'");
                    return;
                }
                /*if(collegeAuditStatuses.indexOf("待审核")>=0){
                    layer.msg("操作失败,该条数据学院未审核");
                    return;
                }*/
                if (schoolAuditStauses.indexOf('未通过') >= 0 || schoolAuditStauses.indexOf('已通过') >= 0||schoolAuditStauses.indexOf('修改') >= 0) {
                    layer.msg("操作失败,该条数据已经审核过了，不能重复审核");
                }
                if(applyId==""){
                    layer.msg("请选择一行数据");
                    return;
                }
                $("#dlg2").show();
                $("#sc_score").hide();
                $("#sc_reason").show();
                $("#reason").val("");
                $("#btn_sub").click(function () {
                    var reason=$("#reason").val();
                    if (!reason || reason == '') {
                        layer.msg("审核意见不能为空");
                        return;
                    }
                    layer.confirm('确认此操作吗?!', function (result) {
                        if (result) {

                            //验证重复审核
                            $.ajax({
                                url: "/jsons/SchoolAuditOneSupplement.form",
                                type: "post",
                                data: {applyId: applyId,reason:reason, Type: type},
                                dataType: "json",
                                success: function (data) {
                                    if (data.result) {
                                        layer.msg("保存成功");
                                        $("#submitAll").attr("checked", false);
                                        $("#dlg2").hide();
                                        $('.popup').slideUp(400);
                                        $('.new').slideUp(300);
                                        select_box(1);
                                        applyId = '';
                                    }
                                }, error: function () {
                                    layer.msg("网络错误");
                                    $("#submitAll").attr("checked", false);
                                    $("#dlg2").hide();
                                    $('.popup').slideUp(400);
                                    $('.new').slideUp(300);
                                    select_box(1);
                                    applyId = '';
                                }
                            })
                        }
                    })
                })
            }else {

                $('input:checkbox:checked').each(function () {
                    var row = $(this).parent().parent().data();
                    applyId += row.id + "|";
                    regimentAuditStatuses+=row.regimentAuditStatus+"|";
                    collegeAuditStatuses+=row.collegeAuditStatus+"|";
                    schoolAuditStauses+=row.schoolAuditStaus+"|";
                });
                if(regimentAuditStatuses.indexOf("未通过")>=0||regimentAuditStatuses.indexOf("修改")>=0){
                    layer.msg("操作失败,包含有班级审核结果为'未通过'或'修改'的数据");
                    return;
                }
                if(regimentAuditStatuses.indexOf("待审核")>=0){
                    layer.msg("操作失败,包含有班级未审核数据");
                    return;
                }
                if(collegeAuditStatuses.indexOf("未通过")>=0||collegeAuditStatuses.indexOf("修改")>=0){
                    layer.msg("操作失败,包含有学院审核结果为'未通过'或'修改'的数据");
                    return;
                }
                if(collegeAuditStatuses.indexOf("待审核")>=0){
                    layer.msg("操作失败,包含有学院未审核数据");
                    return;
                }
                if (schoolAuditStauses.indexOf("已通过")>=0||schoolAuditStauses.indexOf("未通过")>=0||schoolAuditStauses.indexOf("修改")>=0) {
                    layer.msg("您选中的项目中有审核过的，不能重复审核");
                }
                if (applyId == "") {
                    layer.msg("请选择一行数据");
                    return;
                }

                layer.confirm('确认此操作吗?!', function (result) {
                    if (result) {
                        //验证重复审核


                        $.ajax({
                            url: "/apply/SchoolAuditSupplement.form",
                            type: "post",
                            data: {applyId: applyId.substring(0, applyId.length - 1), Type: type},
                            dataType: "json",
                            success: function (data) {
                                if (data) {
                                    layer.msg(data.msg);
                                    $("#submitAll").attr("checked", false);
                                    select_box(1);
                                    applyId = '';
                                }
                            }, error: function () {
                                layer.msg("网络错误");
                                select_box(1);
                                applyId = '';
                            }
                        })
                    }
                })
            }
        }
        //关闭按钮
        function close_new(){
            $('#dlg2').hide();
            $('.popup').slideUp(400);
            $('.new').slideUp(300);
        }
        //综合查询
        function select_box(page) {
            var jsonObject = $("#Form1").serializeObject();
            jsonObject["rows"] = $("#rows").val() ;
            if(orderByName!=null) jsonObject["orderByName"]=orderByName;
            if(sequence!=null) jsonObject["sequence"]=sequence;
            if(Math.ceil(totalNum/$("#rows").val())<page){
                page=Math.ceil(totalNum/$("#rows").val());
            }
            if(page<=0){
                page=1;
            }
            jsonObject["page"] = page;
            $(".currentPageNum").val(page);
            jsonObject["supClass"]=supClass;
            jsonPara=jsonObject;
            $('.searchContent').slideUp();
            reload();
        }
        //清空
        function clear_search(){
            //清空表单
            document.getElementById("Form1").reset();
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

            select_box(newpage1);
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

            select_box(newpage2);
        }
    </script>
    <%--判断是否是登录状态--%>
    <%@include file="../common/CheckLogin.jsp"%>
</head>
<style>
    /*.table{*/
    /*padding-bottom: 39px;*/
    /*}*/
    /*.pagingTurn{*/
    /*top:-56px;*/
    /*}*/
    #dlg{
        left: 50% !important;
        margin-left: -320px;
        min-width: 600px !important;
        width:600px;
    }
    .new>ul{
        padding: 20px !important;
    }
    .new {
        position: absolute;
        top: 33px;
        left: 50% !important;
        margin-left: -376px;
        height:auto !important;
        z-index: 100;
        max-width: 1024px;
        min-width: 457px;
        width: 750px;
        border: 1px solid #197FFE;
        /* margin: 250px auto; */
        background-color: #FFFFFF;
        display: none;
        min-height: 423px;
        margin-bottom: 40px;
    }
    .btnbox{
        overflow: hidden;
        padding-bottom: 30px;
    }
    .btnbox li{
        float: left;
        margin-left: 150px;
        cursor: pointer;
    }
    #supPhotos{
        margin-top: 22px;
    }
    .sure{
        border: 1px solid;
        width: 70px;
        height: 20px;
        text-align: center;
        line-height: 20px;
        border-radius: 6px;
    }
    .input{
        width: 238px;
        height: 29px;
        border: 1px solid #1990fe;
        margin-left: 20px;
    }
    .select {
        width: 162px;
        height: 28px;
        border: 1px solid #1990fe;
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
    .inputbox{
        display: inline-block;
        width:50%;
        vertical-align: top;
        padding-left: 8px;
        line-height: 20px;
    }
</style>
<body>
<div class="stuMsgManage">
    <%--4、第三处修改，修改菜单按钮，选择哪些按钮需要--%>
    <!--功能栏-->
    <div class="function">
        <ul>
            <li class="function_search"><span>综合条件查询</span></li>
            <li class="function_new function_auditPass" onclick="auditsAction('已通过')"><span>通过</span></li>
            <%--<li class="function_new function_auditNotPass" onclick="auditsAction_no('修改')"><span>修改</span></li>--%>
            <li class="function_edit function_auditNotPass" onclick="auditsAction_no('未通过')"><span>未通过</span></li>
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
                        <span>审核状态:</span>
                        <div>
                            <select id="_regimentAuditStatus" name="regimentAuditStatus" class="select">
                                <option value="" >请选择</option>
                                <option value="" >全部</option>
                                <option value="待审核">待审核</option>
                                <option value="未通过">未通过</option>
                                <option value="已通过">已通过</option>
                                <option value="修改">修改</option>
                            </select>
                        </div>
                    </li>
                </ul>
                <ul>
                    <%--<li>--%>
                        <%--<span>所在学院:</span>--%>
                        <%--<div>--%>
                            <%--<select id="_stuCollageName" name="stuCollageName" class="select">--%>
                                <%--<option value="" >请选择</option>--%>
                                <%--<option value="" >全部</option>--%>
                            <%--</select>--%>
                        <%--</div>--%>
                    <%--</li>--%>
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
            <tr id="forOrder">
                <td><input name="test" type="checkbox" id="submitAll" style="width: 18px; height: 20px;" /></td>
                <td>班级</td>
                <td>姓名</td>
                <td>学号</td>
                <td>活动名称</td>
                <td>团支部</td>
                <td>学院团委</td>
                <td>校团委</td>
            </tr>
            </thead>
            <tbody>

            </tbody>
        </table>
    </div>
    <%@include file="paging_supplement.jsp"%>
    <!--弹出框的层-->
</div>
<!--分页-->

<%--5、第四处修改，修改表单信息，与上面的列名称一致--%>
<div id="tb" class="popup">

</div>
<form id="Form" class="demoform" action=""><!--存在为了提交-->
    <div id="dlg" class="new">

        <div class="header">
            <span id="tpy">查看详情</span>
            <span type="reset" class="iconConcel"></span>
        </div>
        <input type="hidden" id="id" name="id">

        <input type="hidden" id="supPhoto" name="supPhoto" style="margin-left: 21px;" />
        <%--<div id="userphoto_box" style="position:relative;z-index:9999999;height: 20px; width: 230px; float: right;">--%>
            <%--<img id="supPhotos" src="<%=request.getContextPath()%>/asset/image/default.jpg" onerror="error=null;src='<%=request.getContextPath()%>/asset/image/default.jpg'"--%>
                 <%--style="width: 200px;height: 130px;margin-right: 5px;">--%>
            <%--<span style="color:#E41D1D;">注：点击可以切换下一张,<span id="index"></span>共<span id="ids"></span>张</span>--%>
        <%--</div>--%>
        <ul>
            <li>
                <span>学生姓名&nbsp;&nbsp;:&nbsp;&nbsp;&nbsp;&nbsp;</span>
                <input type="text" id="studentName" name="studentName"  style="margin-left: 21px;"  class="input_news" />
            </li>
            <li>
                <span>活动大类&nbsp;&nbsp;:&nbsp;&nbsp;&nbsp;&nbsp;</span>
                <select class="input" name="supClass" id="supClass"  onchange="firstChoose(this.value)">
                    <option value="1">思想政治教育类</option>
                    <option value="2">能力素质拓展类</option>
                    <option value="3">学术科技与创新创业类</option>
                    <option value="4">社会实践与志愿服务类</option>
                    <option value="5">社会工作与技能培训类</option>
                    <option value="6">其他类</option>
                </select>
            </li>
            <li id="scienceClass"style="display: none">
                <span>学术科技类别:</span>
                <select class="input" name="scienceClass">
                    <option value="">请选择</option>
                    <option value="论文">论文</option>
                    <option value="专利">专利</option>
                    <option value="著作">著作</option>
                    <option value="参与创业项目">参与创业项目</option>
                    <option value="组建/参与创业公司">组建/参与创业公司</option>
                </select>
            </li>
            <li id="scienceName"style="display: none">
                <span>学术科技名字:</span>
                <input type="text" class="" name="scienceName"   style="margin-left: 21px;"  class="select"/>
            </li>
            <li id="workClass"style="display: none">
                <span>组织类型&nbsp;&nbsp;:&nbsp;&nbsp;&nbsp;&nbsp;</span>
                <select class="input" name="workClass"  >
                    <option value="">请选择</option>
                    <option value="学校组织">学校组织</option>
                    <option value="学院组织">学院组织</option>
                    <option value="班级任职">班级任职</option>
                    <option value="社团">社团</option>
                </select>
            </li>
            <li id="orgcollege" style="display: none">
                <span>学院名字&nbsp;&nbsp;:&nbsp;&nbsp;&nbsp;&nbsp;</span>
                <select class="input" name="orgcollege" >
                    <option value="">请选择</option>

                </select>
            </li>
            <li id="orgname"  style="display: none">
                <span>组织名称&nbsp;&nbsp;:&nbsp;&nbsp;&nbsp;&nbsp;</span>
                <select class="input" name="orgname">
                    <option value="">请选择</option>

                </select>
            </li>
            <li id="worklevel"  style="display: none">
                <span>职务级别&nbsp;&nbsp;:&nbsp;&nbsp;&nbsp;&nbsp;</span>
                <select class="input" name="worklevel" >
                    <option value="">请选择</option>
                    <option value="负责人">负责人</option>
                    <option value="部长">部长</option>
                    <option value="成员">成员</option>
                </select>
            </li>
            <li id="workName"  style="display: none">
                <span>职务名称&nbsp;&nbsp;:&nbsp;&nbsp;&nbsp;&nbsp;</span>
                <input type="text" class="" name="workName"   value=""  style="margin-left: 21px;"  class="select" placeholder="请填写职务全称"/>
            </li>
            <li id="shipType"  style="display: none">
                <span>奖项类型&nbsp;&nbsp;:&nbsp;&nbsp;&nbsp;&nbsp;</span>
                <select class="input" name="shipType" >
                    <option value="">请选择</option>
                    <option value="奖学金类">奖学金类</option>
                    <option value="荣誉称号类">荣誉称号类</option>
                </select>
            </li>
            <li  id="shipName"  style="display: none">
                <span>奖项名称&nbsp;&nbsp;:&nbsp;&nbsp;&nbsp;&nbsp;</span>
                <input type="text"  name="shipName"  style="margin-left: 21px;"  class="select">
            </li>
            <li  id="supActivityTitle"  style="display: none">
                <span>活动标题&nbsp;&nbsp;:&nbsp;&nbsp;&nbsp;&nbsp;</span>
                <input type="text"  name="supActivityTitle"  style="margin-left: 21px;"  class="select" />
            </li>
            <li id="supLevle"  style="display: none">
                <span>活动级别&nbsp;&nbsp;:&nbsp;&nbsp;&nbsp;&nbsp;</span>
                <select class="input" name="supLevle" >
                    <option value="">请选择</option>
                    <option value="0">国际级</option>
                    <option value="1">国家级</option>
                    <option value="2">省级</option>
                    <option value="3">市级</option>
                    <option value="4">校级</option>
                    <option value="5">院级</option>
                    <option value="6">团支部级</option>
                </select>
            </li>
            <li id="supNature"  style="display: none">
                <span>活动性质&nbsp;&nbsp;:&nbsp;&nbsp;&nbsp;&nbsp;</span>
                <select class="input" name="supNature">
                    <option value="">请选择</option>
                    <option value="1">活动参与</option>
                    <option value="2">讲座报告</option>
                    <option value="3">比赛</option>
                    <option value="4">培训</option>
                </select>
            </li>
            <li id="supPowers"  style="display: none">
                <span>能力标签&nbsp;&nbsp;:&nbsp;&nbsp;&nbsp;&nbsp;</span>
                <div class="inputbox">
                    <input type="checkbox" class="qx_check" id="qx1" name="qx" value="思辨能力" style="width: 16px!important;height: 16px;position: relative;top: -1px;margin: 0px
0px 0px 12px;"/>思辨能力
                    <input type="checkbox" class="qx_check" id="qx2" name="qx" value="执行能力" style="width: 16px!important;height: 16px;position: relative;top: -1px;margin: 0px
0px 0px 12px;"/>执行能力
                    <input type="checkbox" class="qx_check" id="qx3" name="qx" value="表达能力" style="width: 16px!important;height: 16px;position: relative;top: -1px;margin: 0px
0px 0px 12px;"/>表达能力
                    <br/>
                    <input type="checkbox" class="qx_check" id="qx4" name="qx" value="领导能力" style="width: 16px!important;height: 16px;position: relative;top: -1px;margin: 0px
0px 0px 12px;"/>领导能力
                    <input type="checkbox" class="qx_check" id="qx5" name="qx" value="创新能力" style="width: 16px!important;height: 16px;position: relative;top: -1px;margin: 0px
0px 0px 12px;"/>创新能力
                    <input type="checkbox" class="qx_check" id="qx6" name="qx" value="创业能力" style="width: 16px!important;height: 16px;position: relative;top: -1px;margin: 0px
0px 0px 12px;"/>创业能力
                </div>
            </li>
            <li id="supAward"  style="display: none">
                <span>获得奖项&nbsp;&nbsp;:&nbsp;&nbsp;&nbsp;&nbsp;</span>
                <select class="input" name="supAward">
                    <option value="">请选择</option>
                    <option value="第一名">第一名</option>
                    <option value="第二名">第二名</option>
                    <option value="一等奖">一等奖</option>
                    <option value="二等奖">二等奖</option>
                    <option value="金奖">金奖</option>
                    <option value="银奖">银奖</option>
                    <option value="冠军">冠军</option>
                    <option value="亚军">亚军</option>
                    <option value="四强">四强</option>
                    <option value="八强">八强</option>
                    <option value="其他">其他</option>
                </select>
            </li>
            <li id="Award"  style="display: none">
                <span>奖项名称&nbsp;&nbsp;:&nbsp;&nbsp;&nbsp;&nbsp;</span>
                <input type="text" class="" name="Award" style="margin-left: 21px;"  class="select"/>
            </li>
            <li id="supWorktime"  style="display: none">
                <span>工作时长&nbsp;&nbsp;:&nbsp;&nbsp;&nbsp;&nbsp;</span>
                <input type="text" class="" name="supWorktime"  style="margin-left: 21px;"  class="select" placeholder="几天或几小时"/>
            </li>
            <li>
                <span>学校审核状态&nbsp;&nbsp;:&nbsp;&nbsp;&nbsp;&nbsp;</span>
                <input id="schoolAuditStaus" name="schoolAuditStaus" class="select"  readonly="true"/>
            </li>
            <li>
                <span>学校审核时间&nbsp;&nbsp;:&nbsp;&nbsp;&nbsp;&nbsp;</span>
                <input id="schoolAuditStausDate" name="schoolAuditStausDate" class="select"  readonly="true"/>
            </li>
            <li>
                <span>参与时间&nbsp;&nbsp;:&nbsp;&nbsp;&nbsp;&nbsp;</span>
                <input id="takeDate" name="takeDate" class="select"  style="margin-left: 21px;" readonly="true"/>
            </li>
            <li>
                <span>填写时间&nbsp;&nbsp;:&nbsp;&nbsp;&nbsp;&nbsp;</span>
                <input id="supDate" name="supDate" class="select"  style="margin-left: 21px;" readonly="true"/>
            </li>
            <li id="getScore">
                <span>可得学分&nbsp;&nbsp;:&nbsp;&nbsp;&nbsp;&nbsp;</span>
                <!--表单验证例子如下 -->
                <input type="text"  name="supCredit"  class="select" style="margin-left: 21px;"/>
            </li>
        </ul>
        <%--<ul class="btnbox">--%>
        <%--<li  onclick=""><span class="sure" onclick="Saves()">确定</span></li>--%>
        <%--<li  onclick=""><span class="sure iconConcel">取消</span></li>--%>
        <%--</ul>--%>
    </div>
</form>
<div id="tb2" class="popup" ></div>
<div id="dlg2" class="new" style="min-width: 400px;height: 200px;left: 450px">
    <div class="header">
        <span>审核</span>
        <span type="reset" class="iconConcel"></span>
    </div>
    <input type="hidden" id="photo_textbox" name="newsImg">
    <ul>
        <li id="sc_score">
            <span style="font-size: 14px">分数</span>
            <!--表单验证例子如下 -->
            <input type="text" id="score" name="score"  class="input_news" style="margin-left: 17px"/>
        </li>
        <li id="sc_reason" style="display: none">
            <span style="font-size: 14px">审核意见</span>
            <input type="text" id="reason"  class="input_news" style="margin-left: 17px"/>
        </li>
    </ul>


    <!--按钮窗口-->
    <div id="dlg-buttons2" class="new_buttons">
        <input type="reset" id="btn_sub" value="保存" />
        <input type="reset"  value="取消" onclick="close_new()" />
    </div>
</div>
</body>
</html>
