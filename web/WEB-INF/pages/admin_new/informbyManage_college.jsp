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
    <%--引入EasyUi--%>
    <script type="text/javascript" src="<%=request.getContextPath()%>/asset/js/jquery-1.8.3.min.js"></script>
    <!-- 导入layer -->
    <script type="text/javascript" src="<%=request.getContextPath()%>/asset/layer/layer.js"></script>
    <!-- 导入样式css -->
    <link rel="stylesheet" href="<%=request.getContextPath()%>/asset_admin_new/css/menu.css" />
    <link rel="stylesheet" href="<%=request.getContextPath()%>/asset_admin_new/css/activity.css" />
    <%--引入公共JS--%>
    <script type="text/javascript" src="<%=request.getContextPath()%>/asset/js/common.js"></script>
    <script type="text/javascript" src="<%=request.getContextPath()%>/asset_admin_new/js/managecommon.js"></script>
    <%--引入表单验证--%>
    <script type="text/javascript" src="<%=request.getContextPath()%>/asset_admin_new/js/Validform_v5.3.2.js"></script>
    <link rel="stylesheet" href="<%=request.getContextPath()%>/asset_admin_new/css/style.css" />
    <link rel="stylesheet" href="<%=request.getContextPath()%>/asset_admin_new/css/demo.css" />
    <%--引入本页自己的js--%>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
    <!--兼容360浏览器，防止布局乱，设置IE的文档模式为最高版本，并且如果存在chrome插件，自动使用Webkit引擎-->
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <title>第二课堂教师管理界面</title>

    <script>
        var moduleType = GetQueryString("moduleType");//所属模块的ID
        //1、第一处修改，修改增删改的请求地址以及deleteId
        var addUrl = "";
        var editUrl = "/jsons/editInformStatus.form";
        var deleteUrl = "/jsons/deleteInformStatus.form";
        var editorName = "null";//KindEditor的Textarea的ID，如果没用到，赋值为null
        var imageUpload = "";//图片上传的标识，如果没有图片上传，赋值为空，如果有，赋值为数据库存放图片名称的字段名称，不带_
        var deleteId = "informId";//用于删除功能的ID参数，赋值为当前数据库表的ID
        var loadUrl = "/jsons/loadInform.form";//注：此处为新增
        var sqlStr = "";//注：模糊查询
        var jsonPara;
        var filter;
        var editId="informId";
        $(function(){
            $(".table").hide();
            $(".pagingTurn").hide();
            $(".searchContent").show();
            //绑定跳页Enter键
            $(".currentPageNum").keyup(function(e){
                var pagNum = $(".currentPageNum").val();
                if(e.keyCode==13){
                    select_box(pagNum);
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
            //  点击'综合条件查询'关闭查询条件
            $('.function>ul>.function_search').click(function(){
                $('.searchContent').slideToggle();
            });
//            $("#_stuCollageName").change(function(){
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
                                if(row[key]==null||row[key]=="null"||row[key]=="NULL"){
                                    row[key]="";
                                }
                            }
                            var tr = '<tr id="tr'+(i+1)+'">'+
                                    '<td>'+(i+1)+'</td>'+
                                        //第二处修改：按照数据库列名进行拼穿
                                    '<td style="display:none">'+row.informId+'</td>'+
//                                    '<td class=" " title="'+row.activityTitle+'">'+row.activityTitle+'</td>'+
                                    '<td class="" style="display:none">'+row.informStudentId+'</td>'+
                                    '<td class=" " title="'+row.informStudent+'">'+row.informStudent+'</td>'+
                                    '<td class=" " style="display:none">'+row.informByStudentId+'</td>'+
                                    '<td class=" " title="'+row.informByStudent+'">'+row.informByStudent+'</td>'+
                                    '<td class=" " >'+row.informTel+'</td>'+
                                    '<td class=" " >'+row.informDate+'</td>'+
                                    '<td class=" " title="'+row.informContent+'">'+row.informContent+'</td>'+
                                    '<td class=" " >'+row.informAuditDate+'</td>'+
                                    '<td class=" " >'+row.informAuditStatus+'</td>'+
                                    '<td class=" " >'+row.informType+'</td>'+
                                    '</tr>';
                            tr=tr.replace("undefined","");
                            $("tbody").append(tr);
                            $("#tr"+(i+1)).data(row);//存入data为后台修改时取数据
                        }
                        rowClick();//绑定行点击事件
                        totalNum=data.total;

                    }else{
                        totalNum=data.total;
                        $(".currentPageNum").val('1');
                    }
                    paging();
                    disLoad();
                }, error: function () {
                    layer.msg("网络错误");
                    disLoad();
                }
            })

        }
        //刷新按钮
        function refresh(){
            jsonPara={rows:10,page:1};
            reload();
        }
        //审核
        function Edits(){
            if(clickStatus=='true'){
                clickStatus='edit';
                postURL=editUrl;
                if(!rowdata){
                    layer.alert("请先选择一条数据");
                    return
                }else{
                    $("#tpy").text("审核");
                    $('.popup').height($(document).height());
                    $('.popup').css('background-color', '#a1a1a1').slideDown(300);
                    $('.new').slideDown(400);
                }
                var str=rowdata["informContent"];
                //  console.log(str)
                $("#inform").val(str);
            }else{
                layer.alert("请先选择一条数据");
            }
        }
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
            if(isCondition=='true'){
                select_box(pagNum);
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
            }else{
                before_reload();
            }
        }
    </script>
    <style type="text/css">
        .new{
            position: absolute;
            /* top: 152px; */
            left: 200px;
            z-index: 100;
            width: 800px;
            height: 754px;
            border: 1px solid #197FFE;
            /* margin: 250px auto; */
            background-color: #FFFFFF;
            display: none;
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
        .searchContent>div>ul>li>input {
            border: 1px solid #1990fe;
            width: 156px;
            height: 14px;
            margin-left: 85px;
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
            <li class="function_edit" onclick="Edits()"><span>审核</span></li>
            <li class="function_remove" onclick="Delete()"><span>删除</span></li>
            <li class="function_refresh" onclick="reload_this()"><span>刷新当前页</span></li>
        </ul>
    </div>
        <!--综合查询部分-->
        <form id="Form1" >
            <div class="searchContent">
                <div>
                    <ul>
                        <li>
                            <span>活动标题:</span>
                            <input type="text" id="_activityTitle"  name="activityTitle"/>
                        </li>
                        <li>
                            <span>学号:</span>
                            <input type="text" id="_studentID" name="applyStudentId" />
                        </li>
                        <li>
                            <span>学生姓名:</span>
                            <input type="text" id="_studentName" name="studentName" />
                        </li>
                        <li>
                            <span>审核状态:</span>
                            <div>
                                <select id="_regimentAuditStatus" name="informAuditStatus" class="select">
                                    <option value="" >请选择</option>
                                    <option value="" >全部</option>
                                    <option value="待审核">待审核</option>
                                    <option value="未通过">未通过</option>
                                    <option value="已通过">已通过</option>
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
            <tr>
                <td></td>
                <%--<td>活动标题</td>--%>
                <%--<td>被举报学生学号</td>--%>
                <td>举报学生姓名</td>
                <%--<td>举报学生学号</td>--%>
                <td>被举报学生姓名</td>
                <td>举报人电话</td>
                <td>举报日期</td>
                <td>举报内容</td>
                <td>处理日期</td>
                <td>审核状态</td>
                <td>举报/质疑</td>
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
                <span>被举报学生&nbsp;&nbsp;:&nbsp;&nbsp;&nbsp;&nbsp;</span>
                <input type="text" id="informStudent" name="informStudent" class="combobox" disabled/>
            </li>
            <li>
                <span>举报学生名&nbsp;&nbsp;:&nbsp;&nbsp;&nbsp;&nbsp;</span>
                <input type="text" id="informByStudent" name="informByStudent" class="combobox" disabled />
            </li>
            <li>
                <span>举报的日期&nbsp;&nbsp;:&nbsp;&nbsp;&nbsp;&nbsp;</span>
                <input type="date" id="informDate" name="informDate"  class="combobox" disabled/>
            </li>
            <li>
                <span>该学院名称&nbsp;&nbsp;:&nbsp;&nbsp;&nbsp;&nbsp;</span>
                <input id="stuCollageName" name="stuCollageName" type="text" class="combobox" disabled/>
            </li>
            <li>
                <span>举报/质疑&nbsp;&nbsp;:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span>
                <input id="informType" name="informType" type="text" class="combobox" disabled />
            </li>
            <li>
                <span>活动名称&nbsp;&nbsp;:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span>
                <input id="acttitle" name="acttitle" type="text" class="combobox" disabled />
            </li>
            <li>
                <span>活动奖励&nbsp;&nbsp;:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span>
                <input id="actaward" name="actaward" type="text" class="combobox" disabled />
            </li>
            <%--&lt;%&ndash;KindEditor文本框放在Form外面，如果不需要KindEditor，注释掉&ndash;%&gt;--%>
            <li>
                <span>举报内容&nbsp;&nbsp;:&nbsp;&nbsp;&nbsp;&nbsp;</span>
                <textarea id="inform" style="width:95%;height:200px;display:block;border: 1px solid #1990fe;" readonly></textarea>
            </li>
            <li >
                <select id="informAuditStatus" name="informAuditStatus"   class="select">
                    <option value="已通过">已通过</option>
                    <option value="未通过">未通过</option>
                    <option value="待审核">待审核</option>
                </select>
            </li>
        </ul>


        <!--按钮窗口-->
        <div id="dlg-buttons" class="new_buttons">
            <input type="button" id="btn_sub" value="保存" onclick="Save()" />
            <input type="reset" value="取消" class="iconConcel" />
        </div>

    </div>
</form>
<!--此js放在要提交表单的下面，放在上面偶尔失效-->
<%--<script>--%>
    <%--//第五处修改，一般不用改，设置表单验证参数，tiptype4种, btnSubmit 提交按钮，ajax是结合我们公司提交方式--%>
    <%--demo = $(".demoform").Validform({--%>
        <%--tiptype:4,--%>
        <%--btnSubmit:"#btn_sub",--%>
        <%--ajaxPost:true--%>

    <%--});--%>
<%--</script>--%>
</body>
</html>