<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: admin
  Date: 2016/5/9
  Time: 11:37
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java"  pageEncoding="UTF-8" %>
<html>
<head>
    <title></title>
    <%--引入EasyUi--%>
    <link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/asset/easyui/themes/default/easyui.css">
    <link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/asset/easyui/themes/icon.css">
    <script type="text/javascript" src="<%=request.getContextPath()%>/asset/js/jquery-1.8.3.min.js"></script>
    <script type="text/javascript" src="<%=request.getContextPath()%>/asset/easyui/jquery.easyui.min.js"></script>
    <script type="text/javascript" src="<%=request.getContextPath()%>/asset/easyui/locale/easyui-lang-zh_CN.js"></script>
    <script type="text/javascript" src="<%=request.getContextPath()%>/asset/js/manage/massage-helper.js"></script>
    <%--引入kindereditor--%>
    <link rel="stylesheet" href="<%=request.getContextPath()%>/asset/kindeditor-4.1.10/themes/default/default.css" />
    <link rel="stylesheet" href="<%=request.getContextPath()%>/asset/kindeditor-4.1.10/plugins/code/prettify.css" />
    <script charset="utf-8" src="<%=request.getContextPath()%>/asset/kindeditor-4.1.10/kindeditor.js"></script>
    <script charset="utf-8" src="<%=request.getContextPath()%>/asset/kindeditor-4.1.10/lang/zh_CN.js"></script>
    <script charset="utf-8" src="<%=request.getContextPath()%>/asset/kindeditor-4.1.10/plugins/code/prettify.js"></script>

    <%--引入公共JS--%>
    <script type="text/javascript" src="<%=request.getContextPath()%>/asset/js/common.js"></script>
    <script type="text/javascript" src="<%=request.getContextPath()%>/asset/js/manage/managecommon.js"></script>
    <script type="text/javascript" src="<%=request.getContextPath()%>/asset/kindeditor-4.1.10/KindeditorConfig.js"></script>
    <%--引入活动管理JS--%>
    <script type="text/javascript" src="<%=request.getContextPath()%>/asset/js/activitiesManager.js"></script>
    <%--引入图片上传--%>
    <script type="text/javascript" src="<%=request.getContextPath()%>/asset/js/ajaxfileupload.js"></script>
    <script type="text/javascript" src="<%=request.getContextPath()%>/asset/js/studentManager.js"></script>
    <style>.test{width: 16px;height: 16px; /* line-height: 8px; */ /* margin-top: 4px; */ position: relative; top: 3px; }</style>
    <%--本页引用的CSS--%>
    <style>#dlg .textbox .textbox-text{font-size:15.5555px;}</style>
    <style>#dlg{font-size:16px;}</style>

    <script>
        var moduleType = GetQueryString("moduleType");//所属模块的ID，不可以删除
        //1、第一处修改，修改增删改的请求地址
        var addUrl = "/jsons/addActivities.form";
        var editUrl = "/jsons/editActivities.form";
        var deleteUrl = "/jsons/deleteActivities.form";
        var editorName = "activityContent";//KindEditor的Textarea的ID，如果没用到，赋值为null
        var imageUpload = "activityImg";//图片上传的标识，如果没有图片上传，赋值为空，如果有，赋值为数据库存放图片名称的字段名称，不带_
        var deleteId = "activityId";//用于删除功能的ID参数，赋值为当前数据库表的ID

    </script>
    <%--判断是否是登录状态--%>
    <%@include file="../common/CheckLogin.jsp"%>
</head>
<body>
<%--数据表格--%>
<table id="dg" class="easyui-datagrid" style="width:100%;min-height:556px;max-height: 100%;"
       data-options="pagination:true,
               rownumbers:true,
               singleSelect:true,
               method:'post',
               autoRowHeight:false,
               toolbar:'#tb',
               fitColumns:true,
               <%--2、第二处修改，修改此处的Json服务，用于加载数据--%>
               url:'/jsons/Activitiesdept.form'">
    <thead>
    <tr>
        <%--3、第三处修改，修改此处的列名称，与数据库一致，显示有必要的--%>
        <th field="activityId" hidden >ID</th>
        <th field="activityTitle" width="100px">活动标题</th>
        <th field="activityArea" width="100px">活动范围</th>
        <th field="activityClassMean" width="100px">活动类型</th>
        <th field="activityLevleMean" width="100px">活动级别</th>
        <th field="activityNatureMean" width="100px" >活动性质</th>
        <%--<th field="activityIsInschool" width="100px" >校内校外</th>--%>
        <th field="activityLocation" width="100px">活动地点</th>
        <th field="activityParticipation" width="100px" >参与形式</th>
        <th field="activitySdate" width="100px">开始日期</th>
        <th field="activityEdate" width="100px">结束日期</th>
        <th field="activityCreator" width="100px">创建者</th>
        <th field="activityCreatedate" width="100px">创建日期</th>

        <%-- <th field="activityFilter" width="100px" hidden>条件过滤</th>--%>
        <%-- <th field="activityFilterType" width="100px" hidden>活动限制条件的类型</th>--%>
        <%-- <th field="activityIsDelete" width="100px">是否被删除</th>--%>
        <%--<th field="activityFilterType" width="100px">活动限制</th>--%>
        <%-- <th field="activityPowers" width="100px">增加能力</th>--%>



    </tr>
    </thead>
</table>
<%--表格头部按钮--%>
<div id="tb" style="height:auto">
    <%--4、第四处修改，修改菜单按钮，选择哪些按钮需要--%>
    <a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-add',plain:true" onclick="Add_befores()">新建</a>
    <a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-edit',plain:true" onclick="Edits()">修改</a>
    <a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-remove',plain:true" onclick="Delete()">删除</a>
    <%--<a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-reload',plain:true" onclick="reloadData()">刷新</a>--%>
    <a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-reload',plain:true" onclick="reloadThis()">刷新当前页</a>

    <input class="easyui-searchbox" data-options="prompt:'请输入活动标题',searcher:doSearch" style="width:200px"/>
</div>
<%--对话框--%>
<div id="dlg" class="easyui-dialog hide font1" title=""
     style="width:1000px;height:800px;padding:10px;top: 0px;"
     data-options="iconCls: 'icon-save',buttons: '#dlg-buttons',modal:true" closed="true">
    <%--5、第五处修改，修改表单信息，与上面的列名称一致--%>
    <form id="Form">
        <input type="hidden" id="photo_textbox" name="activityImg">
        <div id="userphoto_box" style="height: 20px; width: 500px; float: right;background-size:100% 100%;">
            <img id="user_photo" src="<%=request.getContextPath()%>/asset/image/default.jpg" onerror="onerror=null;src='/Files/Images/default.jpg'" style="width: 450px;height: 250px;margin-right: 5px;">
        </div>
        <div style="margin-bottom:10px;margin-top: 10px;display: none;">
            <div class="word">ID:</div>
            <input class="easyui-textbox" name="activityId" id="activityId">
        </div>
        <div style="margin-bottom:10px;margin-top: 10px;">
            <span class="word">活动标题:</span>
            <input class="easyui-textbox" data-options="required:true,validType:'length[1,50]'"
                   name="activityTitle" id="activityTitle" style="width:200px;height:32px">
        </div>
        <div style="margin-bottom:10px;margin-top: 10px;">
            <span class="word">活动范围:</span>
            <select class="easyui-combobox" name="activityArea" id="activityArea"
                    data-options="required:true,editable:false,panelHeight:'auto'" style="width:200px;height:32px">
                <option>职能部门</option>
            </select>
        </div>
        <div style="margin-bottom:10px;margin-top: 10px;">
            <span class="word">活动类别:</span>
            <select class="easyui-combobox" name="activityClass" id="activityClass"
                    data-options="required:true,editable:false,panelHeight:'auto'" style="width:200px;height:32px">
                <c:forEach items="${activityClasses}" var="activityClass">
                    <option value="${activityClass.dictvalue}">${activityClass.dictmean}</option>
                </c:forEach>
            </select>
        </div>
        <div style="margin-bottom:10px;margin-top: 10px;">
            <span class="word">活动级别:</span>
            <select class="easyui-combobox" name="activityLevle" id="activityLevle"
                    data-options="required:true,editable:false,panelHeight:'auto'" style="width:200px;height:32px">
                <c:forEach items="${activityLevels}" var="activityLevle">
                    <option value="${activityLevle.dictvalue}">${activityLevle.dictmean}</option>
                </c:forEach>
            </select>
        </div>
        <div style="margin-bottom:10px;margin-top: 10px;">
            <span class="word">活动性质:</span>
            <select class="easyui-combobox" name="activityNature" id="activityNature"
                    data-options="required:true,editable:false,panelHeight:'auto'" style="width:200px;height:32px">
                <c:forEach items="${activNatures}" var="activityNature">
                    <option value="${activityNature.dictvalue}">${activityNature.dictmean}</option>
                </c:forEach>
            </select>
        </div>
        <%--<div style="margin-bottom:10px;margin-top: 10px;">--%>
        <%--<span class="word">校内校外:</span>--%>
        <%--<select class="easyui-combobox" name="activityIsInschool" id="activityIsInschool"--%>
        <%--data-options="required:true,editable:false,panelHeight:'auto'" style="width:200px;height:32px">--%>
        <%--<option>校内活动</option>--%>
        <%--<option>校外活动</option>--%>
        <%--</select>--%>
        <%--</div>--%>
        <div style="margin-bottom:10px;margin-top: 10px;">
            <span class="word">参与形式:</span>
            <select class="easyui-combobox" name="activityParticipation" id="activityParticipation"
                    data-options="required:true,editable:false,panelHeight:'auto'" style="width:200px;height:32px">
                <option>不限</option>
                <option>个人</option>
                <option>团体</option>
            </select>
        </div>
        <div style="margin-bottom:10px;margin-top: 10px;">
            <span class="word">活动地点:</span>
            <input class="easyui-textbox" data-options="required:true,validType:'length[1,50]'"
                   name="activityLocation" id="activityLocation" style="width:200px;height:32px">
        </div>
        <div style="margin-bottom:10px;margin-top: 10px;">
            <span class="word">活动封面:</span>
            <input type="file" id="activityImg" name="activityIm" onchange='preview(this)'/>
        </div>
        <div style="margin-bottom:10px;margin-top: 10px;">
            <span class="word">活动限制条件的类型:</span>
            <input class="filter_ckeck none  test" type="checkbox" id="ax1" name="ax" value="不限" checked="checked">不限
            <input class="filter_ckeck coll  test" type="checkbox" id="ax2" name="ax" value="年级">年级
            <input class="filter_ckeck coll  test" type="checkbox" id="ax3" name="ax" value="学院">学院
        </div>
        <div style="margin-bottom:10px;margin-top: 10px;" >
            <span class="word">年级过滤:</span>
            <select class="easyui-combobox" name="classYear" id="classYear"
                    data-options="required:false,editable:false,panelHeight:'auto'" style="width:200px;height:32px">
                <c:forEach items="${grades}" var="grade">
                    <option value="${grade.stuGradeName}">${grade.stuGradeName}</option>
                </c:forEach>
            </select>
            <span class="word">学院过滤:</span>
            <select class="easyui-combobox" name="classCollege" id="classCollege"
                    data-options="required:false,editable:false,panelHeight:'auto'" style="width:200px;height:32px">
                <c:forEach items="${colleges}" var="college">
                    <option value="${college.stuCollageName}">${college.stuCollageName}</option>
                </c:forEach>
            </select>
        </div>
        <div style="margin-bottom:10px;margin-top: 10px;">
            <span class="word" style="letter-spacing: 3px;">开始时间:</span>
            <input class="easyui-datebox" name="activitySdate" id="activitySdate"
                   data-options="required:true,editable:false"
                   style="width:200px;height:32px">
            <span class="word" style="letter-spacing: 3px;">结束时间:</span>
            <input class="easyui-datebox" name="activityEdate" id="activityEdate"
                   data-options="required:true,editable:false"
                   style="width:200px;height:32px">
        </div>
        <div style="margin-bottom:10px;margin-top: 10px;">
            <span class="word" style="letter-spacing: 3px;">能力标签:</span>
            <input type="checkbox" class="qx_check test" id="qx1" name="qx" value="思辨能力" />思辨能力
            <input type="checkbox" class="qx_check test" id="qx2" name="qx" value="执行能力" />执行能力
            <input type="checkbox" class="qx_check test" id="qx3" name="qx" value="表达能力" />表达能力
            <input type="checkbox" class="qx_check test" id="qx4" name="qx" value="领导能力" />领导能力
            <input type="checkbox" class="qx_check test" id="qx5" name="qx" value="创新能力" />创新能力
            <input type="checkbox" class="qx_check test" id="qx6" name="qx" value="创业能力" />创业能力
        </div>
        <form/>
        <%--KindEditor文本框放在Form外面，如果不需要KindEditor，注释掉--%>
        <div style="margin-bottom:10px;margin-top: 10px;">
            <div class="word" style="letter-spacing: 3px;">活动内容:</div>
            <textarea id="activityContent" name="activityContent" style="width:100%;height:300px;"></textarea>
        </div>
</div>
<%--对话框保存、取消按钮--%>
<div id="dlg-buttons">
    <a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls: 'icon-ok'" onclick="Saves()">保存</a>
    <a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls: 'icon-cancel'" onclick="javascript:$('#dlg').dialog('close')">取消</a>
</div>
</body>
</html>