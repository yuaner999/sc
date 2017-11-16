<%--
  Created by IntelliJ IDEA.
  User: gq
  Date: 2016/10/28
  Time: 11:11
  To change this template use File | Settings | File Templates.
--%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java"  pageEncoding="UTF-8" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01//EN"
"http://www.w3.org/TR/html4/strict.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" lang="en">
<head>
    <link rel="Shortcut Icon" href="<%=request.getContextPath()%>/asset/image/neu.jpg" type="image/x-icon">
    <!-- 导入页面控制js -->
    <script type="text/javascript" src="<%=request.getContextPath()%>/asset_admin_new/js/jquery-1.11.1.min.js"></script>
    <script type="text/javascript" src="<%=request.getContextPath()%>/asset_admin_new/js/common_stuMsgManage.js"></script>
    <script type="text/javascript" src="<%=request.getContextPath()%>/asset_admin_new/js/common_tabs.js"></script>
    <script type="text/javascript" src="<%=request.getContextPath()%>/asset_admin_new/js/menu.js"></script>
    <script type="text/javascript" src="<%=request.getContextPath()%>/asset_admin_new/js/StuMsgManage.js"></script>
    <script type="text/javascript" src="<%=request.getContextPath()%>/asset_admin_new/js/managecommon.js"></script>
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
        .selectRows select{
            position: absolute;
            top: 9px !important;
            border: 1px solid #1990fe;
        }
    </style>
    <script>
        var moduleType = GetQueryString("moduleType");//所属模块的ID
        //1、第一处修改，修改增删改的请求地址以及deleteId
        var addUrl = "";
        var editUrl = "";
        var deleteUrl = "";
        var editorName = "";//KindEditor的Textarea的ID，如果没用到，赋值为null
        var imageUpload = "";//图片上传的标识，如果没有图片上传，赋值为空，如果有，赋值为数据库存放图片名称的字段名称，不带_
        var deleteId = "classId";//用于删除功能的ID参数，赋值为当前数据库表的ID
        var loadUrl = "/jsons/loadClassInfors.form";//注：此处为新增
        var sqlStr = "";//注：模糊查询
        var jsonPara;
        var editId="classId";
        $(function(){
            before_reload();
            //绑定跳页Enter键
            $(".currentPageNum").keyup(function(e){
                var pagNum = $(".currentPageNum").val();
                if(e.keyCode==13){
                    select_box(pagNum);
                }
            });
        });
        //综合查询
        function select_box(page) {
            var jsonObject = {};
            jsonObject["stuCollageName"]=$("#filter_college").val();
            jsonObject["stuMajorName"]=$("#filter_major").val();
            jsonObject["stuGradeName"]=$("#filter_grade").val();
            jsonObject["sqlStr"]=$("#searchVal").val();
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
        //before_reload :加载前rows和page参数处理
        function before_reload(){
            page= $(".currentPageNum").val();
            rows = $("#rows").val();
//            if(page>(totalNum%rows==0?totalNum/rows:totalNum/rows+1)){//进行判断，避免选择rows时出现错误
//                page = 1;$(".currentPageNum").val(1);
//            }
             jsonPara={rows:rows,page:page};

            //   console.log(jsonPara);
            reload();
            //加载学院下拉列表
            $.ajax({
                url:"/jsons/loadCollegeName.form",
                type:"post",
                dataType:"json",
                success:function(data) {
                    if (data != null && data.rows.length > 0) {
                        $("#filter_college").html('');
                        var str='<option value="">所有学院</option>';
                        for(var i=0;i<data.rows.length;i++){
                            str+= '<option value="'+data.rows[i].stuCollageName+'">'+data.rows[i].stuCollageName+'</option>';
                        }
                        $("#filter_college").html(str);
                    }
                }
            });
//            //加载专业下拉列表
//            $.ajax({
//                url:"/jsons/loadMajorNameIn.form",
//                type:"post",
//                data:{stuCollageName:''},
//                dataType:"json",
//                success:function(data){
//                    if(data.rows.length>0){
//                        $("#filter_major").html('');
//                        var str='<option value="">所有专业</option>';
//                        for(var i=0;i<data.rows.length;i++){
//                            str+= '<option value="'+data.rows[i].stuMajorName+'">'+data.rows[i].stuMajorName+'</option>';
//                        }
//                        $("#filter_major").html(str);
//                    }
//
//                }
//            });
            //加载年级信息
            $.ajax({
                url:"/jsons/loadGradeNameIn.form",
                type:"post",
                dataType:"json",
                success:function(data){
                    if(data.rows.length>0){
                        $("#filter_grade").html('');
                        var str='<option value="">所有年级</option>';
                        for(var i=0;i<data.rows.length;i++){
                            str+= '<option value="'+data.rows[i].stuGradeName+'">'+data.rows[i].stuGradeName+'</option>';
                        }
                        $("#filter_grade").html(str);
                    }
                }
            });
        }
        //根据学院加载下拉选
        function changeColl(){
            var strvalue=$("#filter_college").val();
                $.ajax({
                    url:"/jsons/loadMajorNameIn.form",
                    type:"post",
                    data:{stuCollageName:strvalue},
                    dataType:"json",
                    success:function(data){
                        if(data.rows.length>0){
                            $("#filter_major").html('');
                            var str='<option value="">所有专业</option>';
                            for(var i=0;i<data.rows.length;i++){
                                str+= '<option value="'+data.rows[i].stuMajorName+'">'+data.rows[i].stuMajorName+'</option>';
                            }
                            $("#filter_major").html(str);
                        }else{
                            $("#filter_major").html('');
                            var str='<option value="">无</option>';
                            $("#filter_major").html(str);
                        }

                    }
                });
        }
        //条件查询
        function  searchIn(pagenum){
            isCondition='searchC';
            var classname=$("#filter_college").val();
            var major=$("#filter_major").val();
            var grade=$("#filter_grade").val();
            page = pagenum;$(".currentPageNum").val(pagenum);
            rows= $("#rows").val() ;
            jsonPara={stuCollageName:classname, stuMajorName:major, stuGradeName:grade,rows:rows,page:page};
            reload();
        }
        //模糊查询
        function Search(pagenum){
            isCondition='searchM';
            sqlStr = $("#searchVal").val();
            rows = $("#rows").val();
            page = pagenum;$(".currentPageNum").val(pagenum);
            jsonPara={rows:rows,page:page,sqlStr:sqlStr};
            reload();
        }
        //刷新
        function refresh_reload(){
            $(".currentPageNum").val(1);
            page=1;$(".currentPageNum").val(1);
            rows = $("#rows").val();
            if(isCondition=='searchM'){
                Search(1);
            }else if(isCondition=='searchC'){
                searchIn(1);
            }else{
                jsonPara={rows:rows,page:page};
                reload();
            }
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
                                if(row[key]==null||row[key]=='null'||row[key]=='NULL')
                                    row[key]='';
                            }
                            var tr = '<tr id="tr'+(i+1)+'">'+
                                    '<td>'+(i+1)+'</td>'+
                                        //第二处修改：按照数据库列名进行拼穿
                                    '<td class="title_class" onclick="go(\''+row.stuClassName+'\')">'+row.stuClassName+'</td>'+
                                    '<td title="'+row.stuCollageName+'">'+row.stuCollageName+'</td>'+
                                    '<td title="'+row.stuMajorClass+'">'+row.stuMajorClass+'</td>'+
                                    '<td title="'+row.stuMajorName+'">'+row.stuMajorName+'</td>'+
                                    '<td title="'+row.stuGradeName+'">'+row.stuGradeName+'</td>'+
                                    '</tr>';
                            $("tbody").append(tr);
                            $("#tr"+(i+1)).data(row);//存入data为后台修改时取数据
                        }

                        rowClick();//绑定行点击事件
                        totalNum=data.total;

                    }else{
                        page=0;
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
        function  go(val){
            val=encodeURI(encodeURI(val));
            window.open('<%=request.getContextPath()%>/views/admin_new/classStudentInfo.form?stuClassName='+val+'','_parent');
            <%--return '<a href="<%=request.getContextPath()%>/views/admin/ClassStudentInfo.form?stuClassName='+val+'" target="_blank">'+val+'</a>  ';--%>
        }

        $(document).ready(function(){
            $('#searchVal').bind('keyup',function(event){
                if(event.keyCode=="13"){
                    select_box(1);
                }
            });
        });
    </script>
<style type="text/css">
    .title_class{
        color: #1990FE;
        cursor:pointer;
    }
    .pagingTurn{
        padding-top: 7px !important;
    }
    #searchVal{
        outline: none;
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
            <li >
                <span class="selete_memo_text">学院:</span>
                <select id="filter_college" name="filter"  style="width: 145px;height: 27px;border: 1px solid #1990fe;" onchange="changeColl()">
                    <option value="" selected>全部学院</option>
                </select>
            </li>
            <li >
                <span class="selete_memo_text">专业:</span>
                <select id="filter_major" name="filter"  style="width: 145px;height: 27px;border: 1px solid #1990fe;">
                    <option value="" selected>全部专业</option>
                </select>
            </li>
            <li >
                <span class="selete_memo_text">年级:</span>
                <select id="filter_grade" name="filter"  style="width: 145px;height: 27px;border: 1px solid #1990fe;">
                    <option value="" selected>全部年级</option>
                </select>
            </li>
            <li onclick="select_box(1)"><span style=" width: 22px; top: 7px;background: url(../../../asset_admin_new/img/icon_synsearch.png) no-repeat;"></span><span style="margin-left: auto">搜索</span></li>
            <li class="function_inputSearch" style="margin-left: 50px">
                <input type="text" placeholder="请输入班级名称" id="searchVal" />
                <span id="search" onclick="select_box(1)"></span>
            </li>
        </ul>
    </div>

    <!--结果集表格-->
    <div id="dg" class="table">
        <table border="0" cellspacing="0" cellpadding="0">
            <thead>
            <tr>
                <td></td>
                <td>班级名称</td>
                <td>所属学院</td>
                <td>专业分类</td>
                <td>所属专业</td>
                <td>所属年级</td>
            </tr>
            </thead>
            <tbody>

            </tbody>
        </table>
    </div>
        <!--分页-->
       <%-- <div class="pagingTurn">
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
        </div>--%>
        <%@include file="paging.jsp"%>
</div>
</body>
</html>