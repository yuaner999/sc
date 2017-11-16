<%--
  Created by IntelliJ IDEA.
  User: yuanshenghan
  Date: 2016/10/31
  Time: 14:31
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java"  pageEncoding="UTF-8" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01//EN"
"http://www.w3.org/TR/html4/strict.dtd">
<style>
    thead>td:first-of-type, tr>td:first-of-type {
        width: 60px;
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
</style>
<html xmlns="http://www.w3.org/1999/xhtml" lang="en">
<head>
    <link rel="Shortcut Icon" href="<%=request.getContextPath()%>/asset/image/neu.jpg" type="image/x-icon">
    <!-- 导入页面控制js jq必须放最上面 -->
    <script type="text/javascript" src="<%=request.getContextPath()%>/asset_admin_new/js/jquery-1.11.1.min.js"></script>
    <script type="text/javascript" src="<%=request.getContextPath()%>/asset_admin_new/js/common_stuMsgManage.js"></script>
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
    <script type="text/javascript" src="<%=request.getContextPath()%>/asset/kindeditor-4.1.10/KindeditorConfig.js"></script>
    <%--引入图片上传--%>
    <script type="text/javascript" src="<%=request.getContextPath()%>/asset/js/ajaxfileupload.js"></script>
    <%--引入表单验证--%>
    <script type="text/javascript" src="<%=request.getContextPath()%>/asset_admin_new/js/Validform_v5.3.2.js"></script>
    <link rel="stylesheet" href="<%=request.getContextPath()%>/asset_admin_new/css/style.css" />
    <link rel="stylesheet" href="<%=request.getContextPath()%>/asset_admin_new/css/demo.css" />
    <%--引入本页自己的js--%>
    <script type="text/javascript" src="<%=request.getContextPath()%>/asset_admin_new/js/newsManage.js"></script>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
    <!--兼容360浏览器，防止布局乱，设置IE的文档模式为最高版本，并且如果存在chrome插件，自动使用Webkit引擎-->
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <title>第二课堂教师管理界面</title>

    <script>
        var moduleType = GetQueryString("moduleType");//所属模块的ID
        //1、第一处修改，修改增删改的请求地址以及deleteId
        var addUrl = "";
        var editUrl = "";
        var deleteUrl = "";
        var editorName = "";//KindEditor的Textarea的ID，如果没用到，赋值为null
        var imageUpload = "";//图片上传的标识，如果没有图片上传，赋值为空，如果有，赋值为数据库存放图片名称的字段名称，不带_
        var deleteId = "";//用于删除功能的ID参数，赋值为当前数据库表的ID
        var editId = "";//用于修改功能的ID参数，赋值为当前数据库表的ID
        var loadUrl = "/jsons/loadActivities_upload.form";//注：此处为新增
        var sqlStr = "";//注：模糊查询
        var jsonPara;//参数
        $(function(){
            //绑定跳页Enter键
            $(".currentPageNum").keyup(function(e){
                var pagNum = $(".currentPageNum").val();
                if(e.keyCode==13){
                    select_box(pagNum);
                }
            });
            before_reload();
        });
        function before_reload(){

            page= $(".currentPageNum").val();
            rows = $("#rows").val();
            if(page>(totalNum%rows==0?totalNum/rows:totalNum/rows+1)){//进行判断，避免选择rows时出现错误
                page = 1;
                $(".currentPageNum").val(1);
            }

            if(sqlStr==""||sqlStr==null){
                jsonPara={rows:rows,page:page};
            }else{
                jsonPara={rows:rows,page:page,sqlStr:sqlStr};
            }
           // console.log(jsonPara);
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
                                if(row[key]==null||row[key]=='null'||row[key]=='NULL')
                                    row[key]='';
                            }
                            var tr = '<tr id="tr'+(i+1)+'">'+
                                    '<td>'+(i+1)+'</td>'+
                                        //第二处修改：按照数据库列名进行拼穿
                                    '<td title="'+row.activityTitle+'">'+row.activityTitle+'</td>'+
                                    '<td>'+row.applyStudentId+'</td>'+
                                    '<td title="'+row.studentName+'">'+row.studentName+'</td>'+
                                    '<td title="'+row.activityClassMean+'">'+row.activityClassMean+'</td>'+
                                    '<td title="'+row.activityLevleMean+'">'+row.activityLevleMean+'</td>'+
                                    '<td title="'+row.activityNatureName+'">'+row.activityNatureName+'</td>'+
                                    '<td title="'+row.activityAwardMean+'">'+row.activityAwardMean+'</td>'+
                                    '<td title="'+row.activityLocation+'">'+row.activityLocation+'</td>'+
                                    '<td title="'+row.activityParticipation+'">'+row.activityParticipation+'</td>'+
                                    '<td>'+row.applyDate+'</td>'+
                                    '</tr>';
                            $("tbody").append(tr);
                            tr.replace('undefined','');
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
        function getModel(){
            window.open("/Files/ExcelModels/apply_activities.xls");
        }

        //绑定回车事件
        $(document).ready(function(){
            $('#searchVal').bind('keyup',function(event){
                if(event.keyCode=="13"){
                    Search();
                }
            });
        });

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
            <li class="function_refresh" onclick="reload_this()"><span>刷新当前页</span></li>
            <li class="function_import" onclick="batchInsert()"><span>导入活动信息</span></li>
            <li class="function_downModel" onclick="getModel()"><span>下载模版</span></li>
            <li class="function_inputSearch">
                <input type="text" placeholder="请输入活动标题" id="searchVal" />
                <span id="search" onclick="Search()"></span>
            </li>
        </ul>
    </div>

    <!--结果集表格-->
    <div id="dg" class="table">
        <table border="0" cellspacing="0" cellpadding="0" class="easyui-datagrid">
            <thead>
            <tr>
                <td></td>
                <td>活动标题</td>
                <td>学生学号</td>
                <td>学生姓名</td>
                <td>活动类型</td>
                <td>活动级别</td>
                <td>活动性质</td>
                <td>获奖情况</td>
                <td>活动地点</td>
                <td>参与形式</td>
                <td>申请日期</td>
            </tr>
            </thead>
            <tbody>

            </tbody>
        </table>
    </div>
    <!--分页-->
    <%@include file="paging.jsp"%>
</div>
<%--批量导入对话框--%>
<div id="batch_dlg"  title="批量导入"  style="display:none;width:400px;height:380px;padding:10px;position:absolute;
    border:3px #c1dadb solid; left:35%;top:25%;background-color:#ffffff">
    <div id="file_box" style="margin-bottom: 10px;margin-top: 10px;">
        <label>选择文件:</label>
        <input id="upfile" style="display: inline-block;width: 200px;" name="fileup" type="file"/>
        <img style="float: right;position:absolute;top:15px;right:15px " src="../../../asset_font_new/img/windowclose_03.png" onclick="batchInsertClose()">
    </div>
    <div id="_box" style="margin-bottom: 10px;margin-top: 10px;">
        <label></label>
    </div>
    <div id="btn_box" style="margin-bottom: 10px;margin-top: 10px;">
        <label></label>
        <a href="javascript:void(0)"  onclick="validFile()">验证文件</a>&nbsp;&nbsp;&nbsp;&nbsp;
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
</body>
</html>