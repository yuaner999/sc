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
    <!-- 导入页面控制js jq必须放最上面 -->
    <script type="text/javascript" src="<%=request.getContextPath()%>/asset_admin_new/js/jquery-1.11.1.min.js"></script>
    <script type="text/javascript" src="<%=request.getContextPath()%>/asset_admin_new/js/common_stuMsgManage.js"></script>
    <!-- 导入layer -->
    <script type="text/javascript" src="<%=request.getContextPath()%>/asset/layer/layer.js"></script>
    <!-- 导入样式css -->
    <link rel="stylesheet" href="<%=request.getContextPath()%>/asset_admin_new/css/organization.css" />
    <link rel="stylesheet" href="<%=request.getContextPath()%>/asset_admin_new/css/StuMsgManage.css" />
    <%--引入公共JS--%>
    <script type="text/javascript" src="<%=request.getContextPath()%>/asset/js/common.js"></script>
    <script type="text/javascript" src="<%=request.getContextPath()%>/asset_admin_new/js/managecommon.js"></script>
    <%--引入表单验证--%>
    <script type="text/javascript" src="<%=request.getContextPath()%>/asset_admin_new/js/Validform_v5.3.2.js"></script>
    <link rel="stylesheet" href="<%=request.getContextPath()%>/asset_admin_new/css/style.css" />
    <link rel="stylesheet" href="<%=request.getContextPath()%>/asset_admin_new/css/demo.css" />
    <%--引入本页自己的js--%>
    <script type="text/javascript" src="<%=request.getContextPath()%>/asset_admin_new/js/organization.js"></script>
    <script type="text/javascript" src="<%=request.getContextPath()%>/asset_admin_new/js/newsManage.js"></script>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
    <!--兼容360浏览器，防止布局乱，设置IE的文档模式为最高版本，并且如果存在chrome插件，自动使用Webkit引擎-->
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <title>组织管理</title>

    <script>
        var moduleType = GetQueryString("moduleType");//所属模块的ID
        //1、第一处修改，修改增删改的请求地址以及deleteId
        var addUrl = "/jsons/addOrganization.form";
        var editUrl = "/jsons/editOrganization.form";
        var deleteUrl = "/jsons/deleteOrganization.form";
        var editorName = "null";//KindEditor的Textarea的ID，如果没用到，赋值为null
        var imageUpload = "null";//图片上传的标识，如果没有图片上传，赋值为空，如果有，赋值为数据库存放图片名称的字段名称，不带_
        var deleteId = "orgid";//用于删除功能的ID参数，赋值为当前数据库表的ID
        var editId = "id";//用于修改功能的ID参数，赋值为当前数据库表的ID
        var loadUrl = "/jsons/loadOrganization.form";//注：此处为新增
        var jsonPara;
        $(function(){
            before_reload();
            //绑定跳页Enter键
            $(".currentPageNum").keyup(function(e){
                var pagNum = $(".currentPageNum").val();
                if(e.keyCode==13){
                    before_reload();
                }
            });
            $(".iconConcel").click(function(){
                $('.new').slideUp(300);
                $('.popup').slideUp(400);
                rowdata=null;
                $("#college").hide();
            });
            //加载组织类别下拉列表
            $.ajax({
                url:"/jsons/loadOrganizationClass.form",
                type:"post",
                dataType:"json",
                success:function(data) {
                    $("#filter_kind").html('<option value="">组织类别</option>');
                    if (data != null && data.rows.length > 0) {
                        for(var i=0;i<data.rows.length;i++){
                            var str= '<option value="'+data.rows[i].orgclass+'">'+data.rows[i].orgclass+'</option>';
                            $("#filter_kind").append(str);
                        }
                    }
                }
            });
            //加载组织级别下拉列表
            $.ajax({
                url:"/jsons/loadOrganizationLevel.form",
                type:"post",
                dataType:"json",
                success:function(data) {
                    $("#filter_level").html('<option value="">组织级别</option>');
                    if (data != null && data.rows.length > 0) {
                        for(var i=0;i<data.rows.length;i++){
                            var str= '<option value="'+data.rows[i].orglevel+'">'+data.rows[i].orglevel+'</option>';
                            $("#filter_level").append(str);
                        }
                    }
                }
            });
        });

        //before_reload :加载前rows和page参数处理
        function before_reload(){

            page= $(".currentPageNum").val()==0 ? 1 : $(".currentPageNum").val();
            rows = $("#rows").val();
            if(page>(totalNum%rows==0?totalNum/rows:totalNum/rows+1)){//进行判断，避免选择rows时出现错误
                page = 1;$(".currentPageNum").val(1);
            }
            var kind=$("#filter_kind").val();
            var level=$("#filter_level").val();
            var sqlStr=$("#searchVal").val();
            jsonPara={rows:rows,page:page,sqlStr:sqlStr,orgclass:kind,orglevel:level};
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
                            var tr = '<tr id="tr'+(i+1)+'">'+
                                    '<td>'+(i+1)+'</td>'+
                                        //第二处修改：按照数据库列名进行拼穿
                                    '<td class="orgname">'+row.orgname+'</td>'+
                                    '<td class="orgclass">'+row.orgclass+'</td>'+
                                    '<td class="orglevel">'+row.orglevel+'</td>'+
                                    '<td class="orgcollege">'+row.orgcollege+'</td>'+
//                                    '<td class="workname">'+row.workname+'</td>'+
//                                    '<td class="worklevel">'+row.worklevel+'</td>'+
                                    '<td class="id" style="display: none">'+row.orgid+'</td>'+
                                    '</tr>';
                            tr=tr.replace(/null/g,"");
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
        //显示与隐藏学院
        function changeClass(val){
            if(val=="学院组织"){
                $("#college").show();
            }else{
                $("#college").hide();
            }
        }
        function close_before(){
            $("#college").hide();
            close();
        }
        function Edit_before(){
            if($("#orgcollege").val()!=""){
                $("#college").show();
            }
            Edit();
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
            /*before_reload();*/
            var pagNum = $(".currentPageNum").val();

            var kind=$("#filter_kind").val();
            var level=$("#filter_level").val();
            var sqlStr=$("#searchVal").val();
            jsonPara={rows:rows,page:pagNum,sqlStr:sqlStr,orgclass:kind,orglevel:level};
            reload();
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

            /*before_reload();*/
            var pagNum = $(".currentPageNum").val();

            var kind=$("#filter_kind").val();
            var level=$("#filter_level").val();
            var sqlStr=$("#searchVal").val();
            jsonPara={rows:rows,page:pagNum,sqlStr:sqlStr,orgclass:kind,orglevel:level};
            reload();
        }
    </script>
    <%--判断是否是登录状态--%>
    <%--<%@include file="../common/CheckLogin.jsp"%>--%>
    <style>
        #dlg{
            height: auto !important;
            padding-bottom: 70px;
            min-width:574px;
            left:50%;
            margin-left: -287px;
        }
        #dlg .inputMsgArea li>span{
            width: 98px !important;
        }
        #dlg .modelSelect{
            left:108px !important;
        }
        .new>ul{
            margin: 20px 20px;
        }
        .modelSelect{
            left:73px !important;
        }
        .inputMsgArea>li>span{
            width:auto !important;
        }
        .modelSelect{
            width:auto !important;
            height:auto !important;
            border:none!important;
        }
        .modelSelect select{
            border: 1px solid #1990fe;
            background: #fff;
            position: relative;
        }
    </style>
</head>
<body>
<div class="stuMsgManage">
    <%--4、第三处修改，修改菜单按钮，选择哪些按钮需要--%>
    <!--功能栏-->
    <div class="function">
        <ul>
            <li >
                <select id="filter_kind" name="filter"  style="width: 90px;height: 27px;border: 1px solid #1990fe;" onchange="before_reload()">
                    <option value="" selected>组织类别</option>
                </select>
            </li>
            <li >
                <select id="filter_level" name="filter"  style="width: 90px;height: 27px;border: 1px solid #1990fe;" onchange="before_reload()">
                    <option value="" selected>组织级别</option>
                </select>
            </li>
            <li class="function_new" onclick="Add()"><span>新建</span></li>
            <li class="function_edit" onclick="Edit_before()"><span>修改</span></li>
            <li class="function_remove" onclick="Delete()"><span>删除</span></li>
            <%--<li class="function_refresh" onclick="reload_this()"><span>刷新当前页面</span></li>--%>
            <li class="function_inputSearch" style="margin-left: 50px">
                <input type="text" placeholder="请输入组织名称" id="searchVal" />
                <span id="search" onclick="before_reload()"></span>
            </li>
        </ul>
    </div>

    <!--结果集表格-->
    <div id="dg" class="table">
        <table border="0" cellspacing="0" cellpadding="0">
            <thead>
            <tr>
                <td></td>
                <td>组织名称</td>
                <td>组织类别</td>
                <td>组织级别</td>
                <td>院级组织所对应学院</td>
                <%--<td>职务名称</td>--%>
                <%--<td>职务级别</td>--%>
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
        <ul class="inputMsgArea">
            <li style="display: none">
                <input type="text" id="orgid" name="orgid" type="text" />
            </li>
            <li>
                <span>组织名称:</span>
                <!--表单验证例子如下 -->
                <input type="text" id="orgname" name="orgname" type="text" datatype="*1-100" class="notNull" />
            </li>
            <li>
                <span>组织类别:</span>
                <div class="modelSelect">
                    <select id="orgclass" name="orgclass" onchange="changeClass(this.value)">
                        <option value="">=请选择=</option>'
                        <c:forEach items="${orgclasses}" var="orgclass">
                            <option value="${orgclass.orgclass}">${orgclass.orgclass}</option>
                        </c:forEach>
                    </select>
                    <span></span>
                </div>
            </li>
            <li>
                <span>组织级别:</span>
                <div class="modelSelect">
                    <select id="orglevel" name="orglevel" >
                        <option value="">=请选择=</option>'
                        <c:forEach items="${orglevels}" var="orglevel">
                            <option value="${orglevel.orglevel}">${orglevel.orglevel}</option>
                        </c:forEach>
                    </select>
                    <span></span>
                </div>
            </li>
            <li id="college" style="display: none">
                <span>院级所对应学院:</span>
                <div class="modelSelect">
                    <select id="orgcollege" name="orgcollege">
                        <option value="">=请选择=</option>'
                        <c:forEach items="${stuCollageNames}" var="stuCollageName">
                            <option value="${stuCollageName.stuCollageName}">${stuCollageName.stuCollageName}</option>
                        </c:forEach>
                    </select>
                    <span></span>
                </div>
            </li>
            <%--<li>--%>
                <%--<span>职务名称:</span>--%>
                <%--<!--表单验证例子如下 -->--%>
                <%--<input type="text" id="workname" name="workname" type="text"   datatype="*1-100" class="notNull" />--%>
            <%--</li>--%>
            <%--<li>--%>
                <%--<span>职务级别:</span>--%>
                <%--<div class="modelSelect">--%>
                    <%--<select id="worklevel" name="worklevel">--%>
                        <%--<option value="">=请选择=</option>'--%>
                        <%--<c:forEach items="${workleveles}" var="workLevle">--%>
                            <%--<option value="${workLevle.worklevel}">${workLevle.worklevel}</option>--%>
                        <%--</c:forEach>--%>
                    <%--</select>--%>
                    <%--<span></span>--%>
                <%--</div>--%>
            <%--</li>--%>
        </ul>
        <!--按钮窗口-->
        <div id="dlg-buttons" class="new_buttons">
            <input type="button" id="btn_sub" value="保存" onclick="Save()" />
            <input type="reset" value="取消" onclick="close_before()" />
        </div>

    </div>
</form>
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