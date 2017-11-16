<%--
  Created by IntelliJ IDEA.
  User: gq
  Date: 2016/11/19
  Time: 14:09
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java"  pageEncoding="UTF-8" %>
<html>
<head>  <!-- 导入页面控制js jq必须放最上面 -->
    <link rel="Shortcut Icon" href="<%=request.getContextPath()%>/asset/image/neu.jpg" type="image/x-icon">
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
    <title>活动必须学分管理</title>
    <script type="text/javascript">
        var moduleType = GetQueryString("moduleType");//所属模块的ID
        //1、第一处修改，修改增删改的请求地址以及deleteId
        var editUrl = "/jsons/editActivityClassScore.form";
        var editId = "";//用于修改功能的ID参数，赋值为当前数据库表的ID
        var editorName = "null";//KindEditor的Textarea的ID，如果没用到，赋值为null
        var loadUrl = "/jsons/loadActivityClassScore.form";//注：此处为新增
        var imageUpload =null;
        var sqlStr = "";//注：模糊查询
        var jsonPara;//参数


        $(function(){
            before_reload();
        }) ;
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
                            if(row.dictmean!='综合奖励及其他类') {
                                var tr = '<tr id="tr' + (i + 1) + '">' +
                                        '<td>' + (i + 1) + '</td>' +
                                            //第二处修改：按照数据库列名进行拼穿
                                        '<td class="fontStyle " title="' + row.dictmean + '">' + row.dictmean + '</td>' +
                                            //因为有editor，需要限定大小，在外层套个div
//                                    '<td class="newsContent" title="'+row.newsContent+'"><div>'+row.newsContent+'</div></td>'+
                                        '<td>' + row.dictscore + '</td>' +
                                        '<td style="display:none">' + row.dictid + '</td>' +
                                        '</tr>';
                                $("tbody").append(tr);
                                $("#tr" + (i + 1)).data(row);//存入data为后台修改时取数据
                            }
                        }

                        rowClick();//绑定行点击事件
                        totalNum=data.total;

                    }else{
                        totalNum=0;
                    }
                    paging();
                    disLoad()
                }, error: function () {
                    layer.msg("网络错误");
                    disLoad();
                }
            })

        }
    </script>

<style type="text/css">
    .new{
        min-width: 430px !important;
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
            <li class="function_edit" onclick="Edit()"><span>修改</span></li>
        </ul>
    </div>

    <!--结果集表格-->
    <div id="dg" class="table">
        <table border="0" cellspacing="0" cellpadding="0">
            <thead>
            <tr>
                <td></td>
                <td>活动类别</td>
                <td>必须完成分数</td>
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
    <div id="dlg" class="new" style="width: 430px">

        <div class="header">
            <span id="tpy">修改</span>
            <span type="reset" class="iconConcel"></span>
        </div>
        <input type="hidden" id="dictid" name="dictid">
        <ul>
            <li>
                <span>活动类别:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span>
                <!--表单验证例子如下 -->
                <input type="text" id="dictmean" name="dictmean"  readonly="readonly" class="input_news" style="margin-left: 6px;" />
            </li>
            <li>
                <span>必须完成分数:</span>
                <input type="text" id="dictscore" name="dictscore"   class="input_news" style="margin-left: 7px;"/>
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
<script>
    //第五处修改，一般不用改，设置表单验证参数，tiptype4种, btnSubmit 提交按钮，ajax是结合我们公司提交方式
    demo = $(".demoform").Validform({
        tiptype:4,
        btnSubmit:"#btn_sub",
        ajaxPost:true
    });

</script>
</body>
</html>
