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
<style>
    .new>ul>li>input{
        margin-left: 0 !important;
    }
</style>
<html xmlns="http://www.w3.org/1999/xhtml" lang="en">
<head>
    <link rel="Shortcut Icon" href="<%=request.getContextPath()%>/asset/image/neu.jpg" type="image/x-icon">
    <!-- 导入页面控制js jq必须放最上面 -->
    <script type="text/javascript" src="<%=request.getContextPath()%>/asset_admin_new/js/jquery-1.11.1.min.js"></script>
    <%--<script type="text/javascript" src="<%=request.getContextPath()%>/asset_admin_new/js/common_stuMsgManage.js"></script>--%>
    <!-- 导入layer -->
    <script type="text/javascript" src="<%=request.getContextPath()%>/asset/layer/layer.js"></script>
    <!-- 导入样式css -->
    <link rel="stylesheet" href="<%=request.getContextPath()%>/asset_admin_new/css/StuMsgManage.css" />
    <%--引入kindereditor--%>
    <link rel="stylesheet" href="<%=request.getContextPath()%>/asset/kindeditor-4.1.10/themes/default/default.css" />
    <link rel="stylesheet" href="<%=request.getContextPath()%>/asset/kindeditor-4.1.10/plugins/code/prettify.css" />
    <script charset="utf-8" src="<%=request.getContextPath()%>/asset/kindeditor-4.1.10/kindeditor.js"></script>
    <script charset="utf-8" src="<%=request.getContextPath()%>/asset/kindeditor-4.1.10/lang/zh_CN.js"></script>
    <script charset="utf-8" src="<%=request.getContextPath()%>/asset/kindeditor-4.1.10/plugins/code/prettify.js"></script>
    <%--引入公共JS--%>
    <script type="text/javascript" src="<%=request.getContextPath()%>/asset/js/common.js"></script>
    <script type="text/javascript" src="<%=request.getContextPath()%>/asset_admin_new/js/managecommon.js"></script>
    <script type="text/javascript" src="<%=request.getContextPath()%>/asset_admin_new/js/common_stuMsgManage.js"></script>
    <script type="text/javascript" src="<%=request.getContextPath()%>/asset/kindeditor-4.1.10/KindeditorConfig.js"></script>
    <%--引入图片上传--%>
    <script type="text/javascript" src="<%=request.getContextPath()%>/asset/js/ajaxfileupload.js"></script>
    <%--引入表单验证--%>
    <script type="text/javascript" src="<%=request.getContextPath()%>/asset_admin_new/js/Validform_v5.3.2.js"></script>
    <link rel="stylesheet" href="<%=request.getContextPath()%>/asset_admin_new/css/style.css" />
    <link rel="stylesheet" href="<%=request.getContextPath()%>/asset_admin_new/css/demo.css" />
    <%--引入本页自己的js--%>
    <script type="text/javascript" src="<%=request.getContextPath()%>/asset_admin_new/js/newsManage.js"></script>
    <link rel="stylesheet" href="<%=request.getContextPath()%>/asset_admin_new/css/editor.css" />
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />

    <!--兼容360浏览器，防止布局乱，设置IE的文档模式为最高版本，并且如果存在chrome插件，自动使用Webkit引擎-->
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <title>第二课堂教师管理界面</title>

    <script>
        var moduleType = GetQueryString("moduleType");//所属模块的ID
        //1、第一处修改，修改增删改的请求地址以及deleteId
        var addUrl = "/jsons/addNews.form";
        var editUrl = "/jsons/editNews.form";
        var deleteUrl = "/jsons/deleteNews.form";
        var editorName = "newsContent";//KindEditor的Textarea的ID，如果没用到，赋值为null
        var imageUpload = "newsImg";//图片上传的标识，如果没有图片上传，赋值为空，如果有，赋值为数据库存放图片名称的字段名称，不带_
        var deleteId = "newsId";//用于删除功能的ID参数，赋值为当前数据库表的ID
        var editId = "newsId";//用于修改功能的ID参数，赋值为当前数据库表的ID
        var loadUrl = "/jsons/loadNews.form";//注：此处为新增
        var sqlStr = "";//注：模糊查询
        var jsonPara;//参数
        $(function(){
            //过滤下拉
            $(".filter").change(function(){
                var newsType=$("#filter_type").val();
                var newsClass=$("#filter_class").val();
                sqlStr = $("#searchVal").val();
                page = 1;$(".currentPageNum").val(1);
                jsonPara={rows:rows,page:page,sqlStr:sqlStr,newsType:newsType,newsClass:newsClass};
                reload();
            });
            //绑定跳页Enter键
            $(".currentPageNum").keyup(function(e){
                var pagNum = $(".currentPageNum").val();
                if(e.keyCode==13){
                    select_box(pagNum);
                }
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
                jsonPara={rows:rows,page:page};
            }else{
                jsonPara={rows:rows,page:page,sqlStr:sqlStr};
            }
//            console.log(jsonPara);
            reload();
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
                                    '<td class="fontStyle newsTitle " title="'+row.newsTitle+'">'+row.newsTitle+'</td>'+
                                        //因为有editor，需要限定大小，在外层套个div
//                                    '<td class="newsContent" title="'+row.newsContent+'"><div>'+row.newsContent+'</div></td>'+
                                    '<td class="newsType ">'+row.newsType+'</td>'+
                                    '<td class="newsCreator ">'+row.newsClass+'</td>'+
                                    '<td class="newsId " style="display:none">'+row.newsId+'</td>'+
                                    '<td class="newsImg " style="display:none">'+row.newsImg+'</td>'+
                                    '<td class="newsClass" >'+row.newsCreator+'</td>'+
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

        $(document).ready(function(){
            $('#searchVal').bind('keyup',function(event){
                if(event.keyCode=="13"){
                    Search();
                }
            });
        });

    </script>
    <style type="text/css">
        .input_news{
            width: 196px;
            height: 17px;
            border: 1px solid #1990fe;
        }
        .select{
            width: 238px;
            height: 36px;
            border: 1px solid #1990fe;
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
            <li >
                <select id="filter_type" name="filter" class="filter"  style="width: 145px;height: 27px;border: 1px solid #1990fe;">
                    <option value="" selected>院校新闻</option>
                    <option value="学校新闻">学校新闻</option>
                    <option value="学院新闻">学院新闻</option>
                </select>
            </li>
            <li >
                <select id="filter_class" name="filter" class="filter" style="width: 145px;height: 27px;border: 1px solid #1990fe;">
                    <option value="" selected>先锋领航</option>
                    <option value="先锋青年">先锋青年</option>
                    <option value="先锋新闻">先锋新闻</option>
                </select>
            </li>
            <li class="function_new" onclick="Add()"><span>新建</span></li>
            <li class="function_edit" onclick="Edit()"><span>修改</span></li>
            <li class="function_remove" onclick="Delete()"><span>删除</span></li>
            <li class="function_inputSearch">
                <input type="text" placeholder="请输入新闻标题" id="searchVal" />
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
                <td>新闻标题</td>
                <%--<td>新闻内容</td>--%>
                <td>新闻类型</td>
                <td>新闻种类</td>
                <td>新闻创建者</td>
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
        <input type="hidden" id="photo_textbox" name="newsImg">
<%--        <div id="userphoto_box" style="height: 20px; width: 230px; float: right;">
            <img id="newsImgs" src="<%=request.getContextPath()%>/asset/image/default.jpg" onerror="error=null;src='<%=request.getContextPath()%>/asset/image/default.jpg'" style="width: 200px;height: 130px;margin-right: 5px;">
        </div><!--上面img的id为图片数据库名+s-->--%>
        <ul>
            <li>
                <span>新闻标题&nbsp;&nbsp;:&nbsp;&nbsp;&nbsp;&nbsp;</span>
                <!--表单验证例子如下 -->
                <input type="text" id="newsTitle" name="newsTitle" type="text"  class="input_news notNull" />
            </li>

            <li>
                <span>新闻类型&nbsp;&nbsp;:&nbsp;&nbsp;&nbsp;&nbsp;</span>
                <select id="newsType" name="newsType" class="select">
                    <option value="学校新闻">学校新闻</option>
                    <option value="学院新闻">学院新闻</option>
                </select>
            </li>
            <li>
                <span>新闻种类&nbsp;&nbsp;:&nbsp;&nbsp;&nbsp;&nbsp;</span>
                <select id="newsClass" name="newsClass"  class="select">
                    <option value="先锋新闻">先锋新闻</option>
                    <option value="先锋青年">先锋青年</option>
                </select>
            </li>
<%--            <li>
                <span>新闻封面图片&nbsp;&nbsp;:&nbsp;&nbsp;&nbsp;&nbsp;</span>
                <input id="newsImg" name="newsImgs" type="file" style="border:0" onchange="preview(this)" />
            </li>--%>
            <li>
                <span>新闻内容&nbsp;&nbsp;:&nbsp;&nbsp;&nbsp;&nbsp;</span>
                <textarea id="newsContent" name="newsContent" style="width:100%;height:330px;"></textarea>
            </li>
        </ul>

        <!--按钮窗口-->
        <div id="dlg-buttons" class="new_buttons">
            <input type="button" id="btn_sub" value="保存" onclick="Save()" />
            <input type="reset"  value="取消" onclick="close()" />
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