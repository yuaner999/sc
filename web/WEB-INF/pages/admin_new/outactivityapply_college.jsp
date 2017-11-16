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

    <script type="text/javascript" src="<%=request.getContextPath()%>/asset/js/common.js"></script>
    <script type="text/javascript" src="<%=request.getContextPath()%>/asset_admin_new/js/managecommon.js"></script>
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

    <script>
        var moduleType = GetQueryString("moduleType");//所属模块的ID
        //1、第一处修改，修改增删改的请求地址以及deleteId
        var addUrl = "";
        var editUrl = "/jsons/editActivityapply.form";
        var deleteUrl = "/jsons/deleteActivityapply.form";
        var editorName = "";//KindEditor的Textarea的ID，如果没用到，赋值为null
        var imageUpload = "";//图片上传的标识，如果没有图片上传，赋值为空，如果有，赋值为数据库存放图片名称的字段名称，不带_
        var deleteId = "outID";//用于删除功能的ID参数，赋值为当前数据库表的ID
        var loadUrl = "/jsons/loadActivityapply.form";//注：此处为新增
        var sqlStr = "";//注：模糊查询
        var jsonPara;
        var editId="outID";
        $(function(){
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
                                    '<td style="display:none">'+row.outID+'</td>'+
                                    '<td class="">'+row.outTitle+'</td>'+
                                    '<td class=" ">'+row.outStudentId+'</td>'+
                                    '<td class=" ">'+row.studentName+'</td>'+
                                    '<td class=" " >'+row.stuCollageName+'</td>'+
                                    '<td class=" " >'+row.outDate+'</td>'+
                                    '<td class=" " >'+row.outAward+'</td>'+
                                    '<td class=" " >'+row.outAuditStatus+'</td>'+
                                    '<td class=" " >'+row.outAuditDate+'</td>'+
                                    '<td class=" " >'+row.outContent+'</td>'+
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
                }, error: function () {
                    layer.msg("网络错误");
                }
            })
            disLoad();
        }
        //刷新按钮
        function refresh(){
            jsonPara={rows:10,page:1};
            reload();
        }
        //修改
        function Edits(){
            if(clickStatus=='true'){
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
                }
                var databasephoto=rowdata.outPhoto;
                var photoes=databasephoto.split("|");
                //  alert(photoes.length);
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
                    //          alert(photoes[i]);
                    $("#index").text("当前第"+(i+1)+"张,");
                });
                var outContent=rowdata.outContent;
                $("#outContent").val(outContent);
            }else{
                layer.alert("请先选择一条数据");
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
                <select id="filter" name="filter"  style="width: 145px;height: 27px;border: 1px solid #1990fe;">
                    <option value="" selected>全部信息</option>
                    <option value="已通过">已通过</option>
                    <option value="未通过">未通过</option>
                    <option value="待处理">待处理</option>
                </select>
            </li>
            <li class="function_edit" onclick="Edits()"><span>审核</span></li>
            <li class="function_remove" onclick="Delete()"><span>删除</span></li>
            <li class="function_refresh" onclick="reload_this()"><span>刷新当前页</span></li>
            <li class="function_inputSearch">
                <input type="text" placeholder="请输入活动标题" id="searchVal" />
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
                <td>活动标题</td>
                <td>学生学号</td>
                <td>学生姓名</td>
                <td>学院名称</td>
                <td>参加日期</td>
                <td>获奖情况</td>
                <td>审核状态</td>
                <td>审核日期</td>
                <td>活动内容</td>
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
            <span id="tpy">新建</span>
            <span type="reset" class="iconConcel"></span>
        </div>
        <ul>
            <div id="userphoto_box" style="height: 60px; width: 400px; float: right;margin-top:15px;">
                <img id="user_photo" src="<%=request.getContextPath()%>/asset/image/default.jpg" onerror="error=null;src='<%=request.getContextPath()%>/asset/image/default.jpg'" style="width: 240px;height: 150px;margin-right: 10px;">
                <span style="color:#E41D1D;">注：点击可以切换下一张,<span id="index"></span>共<span id="ids"></span>张</span>
            </div>
            <li>
                <span>活动标题&nbsp;&nbsp;:&nbsp;&nbsp;&nbsp;&nbsp;</span>
                <input type="text" id="outTitle" name="outTitle"   class="combobox" disabled/>
            </li>

            <li>
                <span>学生姓名&nbsp;&nbsp;:&nbsp;&nbsp;&nbsp;&nbsp;</span>
                <input type="text" id="studentName" name="studentName" class="combobox"   disabled/>
            </li>
            <li>
                <span>学院名称&nbsp;&nbsp;:&nbsp;&nbsp;&nbsp;&nbsp;</span>
                <input type="text" id="stuCollageName" name="stuCollageName" class="combobox"   disabled/>
            </li>
            <li>
                <span>参加日期&nbsp;&nbsp;:&nbsp;&nbsp;&nbsp;&nbsp;</span>
                <input type="date" id="outDate" name="outDate"  class="combobox" disabled/>
            </li>
            <li>
                <span>获奖情况&nbsp;&nbsp;:&nbsp;&nbsp;&nbsp;&nbsp;</span>
                <input type="text" id="outAward" name="outAward" class="combobox" disabled/>
            </li>
            <li>
                <span>活动内容&nbsp;&nbsp;:&nbsp;&nbsp;&nbsp;&nbsp;</span>
                <textarea id="outContent" style="width:95%;height:330px;display:block;border: 1px solid #1990fe;"  readonly></textarea>
            </li>
            <li >
                <select id="outAuditStatus" name="outAuditStatus"   class="select">
                    <option value="已通过">已通过</option>
                    <option value="未通过">未通过</option>
                    <option value="待处理">待处理</option>
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