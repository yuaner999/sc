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
    <%--引入jquery--%>
    <script type="text/javascript" src="<%=request.getContextPath()%>/asset_admin_new/js/jquery-1.11.1.min.js"></script>
    <script type="text/javascript" src="<%=request.getContextPath()%>/asset/js/ajaxfileupload.js"></script>
    <script type="text/javascript" src="<%=request.getContextPath()%>/asset/js/laydate/laydate.js"></script>
    <%--引入layer--%>
    <script type="text/javascript" src="<%=request.getContextPath()%>/asset/layer/layer.js"></script>
    <%--引入公共JS--%>
    <script type="text/javascript" src="<%=request.getContextPath()%>/asset_admin_new/js/managecommon.js"></script>
    <%--<script type="text/javascript" src="<%=request.getContextPath()%>/asset/kindeditor-4.1.10/KindeditorConfig.js"></script>--%>
    <script type="text/javascript" src="<%=request.getContextPath()%>/asset/js/common.js"></script>
    <%--引入表单验证--%>
    <script type="text/javascript" src="<%=request.getContextPath()%>/asset_admin_new/js/Validform_v5.3.2.js"></script>
    <link rel="stylesheet" href="<%=request.getContextPath()%>/asset_admin_new/css/activity.css" />
    <link rel="stylesheet" href="<%=request.getContextPath()%>/asset_admin_new/css/style.css" />
    <link rel="stylesheet" href="<%=request.getContextPath()%>/asset_admin_new/css/demo.css" />
    <!--兼容360浏览器，防止布局乱，设置IE的文档模式为最高版本，并且如果存在chrome插件，自动使用Webkit引擎-->
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
    <title>第二课堂教师管理界面</title>
        <style>
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
            .new>ul>li>span{
                min-width:78px;
            }
            #dlg{
                height:auto !important;
            }
        </style>
    <script>
        var collagename="${sessionScope.creatorName}";
    </script>
    <script>
        var moduleType = GetQueryString("moduleType");//所属模块的ID
        //1、第一处修改，修改增删改的请求地址以及deleteId
        var addUrl = "/jsons/addScholarship.form";
        var editUrl = "";
        var deleteUrl = "/jsons/deleteScholarship.form";
        var editorName = "null";//KindEditor的Textarea的ID，如果没用到，赋值为null
        var imageUpload = "";//图片上传的标识，如果没有图片上传，赋值为空，如果有，赋值为数据库存放图片名称的字段名称，不带_
        var deleteId = "id";//用于删除功能的ID参数，赋值为当前数据库表的ID
        var loadUrl = "/jsons/loadScholarshipInfo.form";//注：此处为新增
        var sqlStr = "";//注：模糊查询
        var editorName='';
        var jsonPara;
        var editId="id";

        $(function(){
            //绑定跳页Enter键
            $(".currentPageNum").keyup(function(e){
                var pagNum = $(".currentPageNum").val();
                if(e.keyCode==13){
                    select_box(pagNum);
                }
                before_reload();
            });
            before_reload();
        });
        //before_reload :加载前rows和page参数处理
        function before_reload(){
            page= $(".currentPageNum").val();
            rows = $("#rows").val();
            if(page>(totalNum%rows==0?totalNum/rows:totalNum/rows+1)){//进行判断，避免选择rows时出现错误
                page = 1;$(".currentPageNum").val(1);
            }

            if(sqlStr==""||sqlStr==null){
                jsonPara={rows:rows,page:page,collagename:collagename};
            }else{
                jsonPara={rows:rows,page:page,sqlStr:sqlStr,collagename:collagename};
            }
            //   console.log(jsonPara);
            reload();
        }
        function reload_this(){
            window.location.reload();
        }
        function  reload() {//此处加载数据方法名不能修改，必须用reload
            load();
            jsonPara.collagename=collagename;
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
                                    '<td style="display:none">'+row.id+'</td>'+
                                    '<td class="">'+row.supStudentId+'</td>'+
                                    '<td class="">'+row.studentName+'</td>'+
                                    '<td class="">'+row.shipName+'</td>'+
                                    '<td class="" >'+row.takeDates+'</td>'+
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
        //删除s
        function  Deletes(){
            if(!rowdata) {
                layer.alert("请先选择一条数据");
                return
            }
            if(clickStatus!=""&&clickStatus!=null){
                postURL=deleteUrl;
                layer.confirm('确认删除此条数据吗?', function(result) {
                    if (result) {
                        //删除数据库记录
                        load();
                        var selectId =rowdata[deleteId];
                        var deleteJsonObject = eval("("+"{'"+deleteId+"':'"+selectId+"'}"+")");
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
            }else{
                layer.msg("请选择一条数据");
            }
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
                load();
                UploadToDatabases(jsonObject);
            }else {
                layer.msg("请按照要求填写");
                return;
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
        //下载模版文件
        function getModel(){
            window.open("/Files/ExcelModels/winscholarship.xls");
        }

        $(document).ready(function(){
            $('#searchVal').bind('keyup',function(event){
                if(event.keyCode=="13"){
                    Search();
                }
            });
        });
    </script>
        <style type="text/css">
            .new{
                position: absolute;
                /* top: 152px; */
                left: 200px;
                z-index: 100;
                width: 700px;
                height: 750px;
                border: 1px solid #197FFE;
                /* margin: 250px auto; */
                background-color: #FFFFFF;
                display: none;
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
            </li>
            <li class="function_import" onclick="batchInsert()"><span>导入获得奖学金信息</span></li>
            <li class="function_downModel" onclick="getModel()"><span>下载模版</span></li>
            <li class="function_new" onclick="Add()"><span>新建</span></li>
            <li class="function_remove" onclick="Deletes()"><span>删除</span></li>
            <li class="function_refresh" onclick="reload_this()"><span>刷新当前页</span></li>
            <li class="function_inputSearch">
                <input type="text" placeholder="请输入学生姓名" id="searchVal" />
                <span id="search" onclick="Search()"></span>
            </li>
        </ul>
    </div>

    <!--结果集表格-->
    <div id="dg" class="table">
        <table border="0" cellspacing="0" cellpadding="0">
            <thead>
            <tr>
                <td></td>
                <td>学生学号</td>
                <td>学生姓名</td>
                <td>获得奖学金名称</td>
                <td>得奖日期</td>
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
            <span  type="reset" class="iconConcel"></span>
        </div>
        <ul>

            <li>
                <span>学生学号&nbsp;&nbsp;:&nbsp;&nbsp;&nbsp;&nbsp;</span>
                <input type="text" id="supStudentId" name="supStudentId"  class="combobox"  />
            </li>
            <li>
                <span>奖学金名称&nbsp;&nbsp;:&nbsp;&nbsp;</span>
                <input type="text" id="shipName" name="shipName"  class="combobox"  />
            </li>
            <li >
                <span>得奖日期&nbsp;&nbsp;:&nbsp;&nbsp;&nbsp;&nbsp;</span>
                <input type="text" id="takeDate" name="takeDate"  class="combobox notNull" onclick="laydate()"   />
            </li>
        </ul>
        <!--按钮窗口-->
        <div id="dlg-buttons" class="new_buttons">
            <input type="button" id="btn_sub" value="保存" onclick="Saves()" />
            <input class="iconConcel" type="reset" value="取消"   />
        </div>

    </div>
</form>
<%--批量导入对话框--%>
<div id="batch_dlg"  title="批量导入"  style="display:none;width:400px;height:380px;padding:10px;position:absolute;
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
        <a href="javascript:void(0)"  onclick="validFile()">验证文件</a>&nbsp;&nbsp;&nbsp;&nbsp;
        <a href="javascript:void(0)"  onclick="uploadFile()">上传并导入</a>
        <%--<a href="javascript:void(0)"  onclick="uploadFile()">上传并导入</a>--%>
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