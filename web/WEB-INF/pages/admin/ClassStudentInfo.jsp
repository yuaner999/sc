<%--
  Created by IntelliJ IDEA.
  User: yuanshenghan
  Date: 2016/9/24
  Time: 16:48
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java"  pageEncoding="UTF-8" %>
<html>
<head>
    <title>班级学生信息</title>
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
    <script type="text/javascript" src="<%=request.getContextPath()%>/asset/kindeditor-4.1.10/KindeditorConfig.js"></script>
    <%--引入图片上传--%>
    <script type="text/javascript" src="<%=request.getContextPath()%>/asset/js/ajaxfileupload.js"></script>
    <script type="text/javascript" src="<%=request.getContextPath()%>/asset/js/studentManager.js"></script>
    <link rel="stylesheet" href="<%=request.getContextPath()%>/asset/css/common.css" />
    <%--引入批量上传--%>
    <link rel="stylesheet" href="<%=request.getContextPath()%>/asset/zyupload/skins/zyupload-1.0.0.css " type="text/css">
    <script type="text/javascript" src="<%=request.getContextPath()%>/asset/zyupload/zyupload-1.0.0.min.js"></script>
    <script>
        var moduleType = GetQueryString("moduleType");//所属模块的ID
        var addUrl = "/jsons/addStudent.form";
        var editUrl = "/jsons/editStudent.form";
        var deleteUrl = "/jsons/deleteStudent.form";
        var editorName = "null";//KindEditor的Textarea的ID，如果没用到，赋值为null
        var imageUpload = "studentPhoto";//图片上传的标识，如果没有图片上传，赋值为空，如果有，赋值为数据库存放图片名称的字段名称，不带_
        var deleteId = "studentID";//用于删除功能的ID参数，赋值为当前数据库表的ID
        var rows=25;
        var page=1;
        var className;
        function  go(val,row,index){
            return '<a href="javascript:void(0)" onclick="EditIn('+index+')" target="_blank">'+val+'</a>';
        }
        $(function(){
            $("#Board").fadeOut("slow");
            className=GetQueryString("stuClassName");

            $('#dg').datagrid('options').queryParams={stuClassName:className};
            $('#dg').datagrid('options').url='/jsons/loadStudentsByClass.form';
            $('#dg').datagrid('reload');

        });
        function EditIn(index){
            var row=$('#dg').datagrid('getRows')[index];
            if(row) {
                $("#user_photo").attr("src","/Files/Images/"+row.studentPhoto);
                $("#ceeOrigin").textbox("disable");
                $("#ceeNumber").textbox("disable");
                $("#ceeProvince").textbox("disable");
                $("#ceeCity").textbox("disable");
                $("#ceeHighSchool").textbox("disable");
                $("#studentID").textbox("readonly");
                $("#stuGradeName").textbox("disable");
                $("#stuMajorName").textbox("disable");
                $("#stuMajorClass").textbox("disable");
                $("#stuCollageName").textbox("disable");
                clickStatus = "edit";
                postURL = editUrl;
                $("#Form").form("clear");
                $('#Form').form('load', row);
                $("#dlg").dialog({title: "修改"});
                $("#dlg").dialog('open');
                $("#dlg").get(0).scrollTop=0;
            }
        }
    </script>
    <%--&lt;%&ndash;判断是否是登录状态&ndash;%&gt;--%>
    <%--<%@include file="../common/CheckLogin.jsp"%>--%>
    <style>
        .fitem label {
            display: inline-block;
            /*text-align: right;*/
            /*width: 120px;*/
            text-align: left;
            width: 80px;
            margin-left: 50px;
        }
        #userphoto_box {
            width:220px;
        }
    </style>
</head>
<body>
<div id="Board" style="width: calc(100% - 10px);height: 100%;position: fixed;top: 0;left:0;z-index: 99999;background: #fff;"></div>
    <%--数据表格--%>
    <table id="dg" class="easyui-datagrid" style="width:100%;min-height:556px;max-height: 800px;"
           data-options="pagination:true,
                   rownumbers:true,
                   singleSelect:false,
                   method:'post',
                   loadMsg:'正在拼命加载中...',
                   autoRowHeight:false,
                   pageSize:rows,
                   pageList:[25,50,100],
                   toolbar:'#tb',
                   fitColumns:true,
                   queryParams:{},
                   <%--2、第二处修改，修改此处的Json服务，用于加载数据--%>
                   url:''" >
        <thead>
        <%--data-options="frozen:true"--%>
        <tr>
            <th field="student_info" colspan="13" >学生基本信息</th>
            <th field="uc_info" colspan="7" >学生高校信息</th>
            <%--<th field="cee_info" colspan="5" >学生高考信息</th>--%>
        </tr>
        <tr>
            <%--3、第三处修改，修改此处的列名称，与数据库一致，显示有必要的--%>
            <th field="ck" checkbox="true"></th>
            <th field="studentID"  >学号</th>
            <th field="studentName" formatter="go" >姓名</th>
            <%--<th field="studentUsedName"  >曾用名</th>--%>
            <th field="studentGender"  >性别</th>
            <th field="studentNation"  >民族</th>
            <th field="studentBirthday"   >出生日期</th>
            <th field="studentNativePlace"  >籍贯</th>
            <th field="studentFamilyAddress"  >家庭住址</th>
            <th field="studentFamilyPostcode"  >邮编</th>
            <th field="studentIdCard"  >身份证号</th>
            <th field="studentPhone"  >手机号</th>
            <th field="studentQQ"  >QQ号</th>
            <th field="studentEmail"  >电子邮件</th>
            <%--<th field="foreignLanguage"  >外语语种</th>--%>
            <%--<th field="faith"  >宗教信仰</th>--%>
            <th field="politicsStatus"  >政治面貌</th>
            <%--<th field="politicsStatusDate"  >入团或入党时间</th>--%>
            <%--<th field="className"  >所在班级</th>--%>
            <%--<th field="usiBuilding"  >寝室楼</th>--%>
            <%--<th field="usiRoomNumber"  >房间号</th>--%>
            <th field="entranceDate"  >入学年份</th>
            <th field="educationLength"  >学制</th>
            <th field="trainingMode"  >培养方式</th>
            <th field="orientationUnit"  >定向单位</th>
            <th field="enrollType"  >招生类别</th>
            <%--<th field="schoolRollStatus"  >学籍状态</th>--%>
            <%--<th field="studentLeader"  >学生干部</th>--%>
            <%--<th field="ceeOrigin"  >生源地</th>--%>
            <%--<th field="ceeNumber"  >考号</th>--%>
            <%--<th field="ceeProvince"  >所在省</th>--%>
            <%--<th field="ceeCity"  >所在市</th>--%>
            <%--<th field="ceeHighSchool"  >所在高中</th>--%>
        </tr>
        </thead>
    </table>
    <%--表格头部按钮--%>
    <div id="tb" style="height:auto">
        <%--4、第四处修改，修改菜单按钮，选择哪些按钮需要--%>
        <a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-add',plain:true" onclick="Add_before()">新建</a>
        <a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-edit',plain:true" onclick="editMore()">修改</a>
        <a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-remove',plain:true" onclick="DeleteMore()">删除</a>
    </div>
    <%--对话框--%>
    <div id="dlg" class="easyui-dialog hide" title=""
         style="width:750px;height:620px;padding:10px;"
         data-options="iconCls: 'icon-save',buttons: '#dlg-buttons',modal:true,top:'10%'" closed="true" >
        <%--5、第五处修改，修改表单信息，与上面的列名称一致--%>
        <form id="Form">
            <input type="hidden" id="photo_textbox" name="studentPhoto">
            <div id="userphoto_box" >
                <img id="user_photo" src="<%=request.getContextPath()%>/asset/image/default.jpg" onerror="onerror=null;src='/Files/Images/default.jpg'" style="width: 142px;height: 200px;margin-right: 130px;">
            </div>
            <div id="studentID_box" class="fitem">
                <label>学号:</label>
                <input id="studentID" class="easyui-validatebox easyui-textbox input_ele" name="studentID"
                       data-options="required:true,validType:'length[0,20]'"/>
            </div>
            <div id="studentName_box" class="fitem">
                <label>姓名:</label>
                <input id="studentName" class="easyui-validatebox easyui-textbox input_ele" name="studentName" data-options="required:true,validType:'length[0,20]'"/>
            </div>
            <div id="studentUsedName_box" class="fitem">
                <label>曾用名:</label>
                <input id="studentUsedName" class="easyui-validatebox easyui-textbox input_ele" name="studentUsedName" data-options="validType:'length[0,20]'"/>
            </div>
            <div id="studentPhoto_box" class="fitem">
                <label>照片:</label>
                <input type="file" id="studentPhoto" name="studentPhot" onchange='preview(this)'/>
                <%--<input id="studentPhoto" class=" easyui-textbox input_ele" name="studentPhoto" onchange='preview(this)' />--%>
            </div>
            <div id="studentGender_box" class="fitem">
                <label>性别:</label>
                <input type="radio"  name="studentGender" value="男" checked/>男&nbsp;&nbsp;&nbsp;&nbsp;
                <input type="radio"  name="studentGender" value="女"/>女
            </div>
            <div id="studentNation_box" class="fitem">
                <label>民族:</label>
                <input id="studentNation" class="easyui-validatebox easyui-textbox input_ele" name="studentNation" data-options="validType:'length[0,10]'"/>
            </div>
            <div id="studentBirthday_box" class="fitem">
                <label>出生日期:</label>
                <input id="studentBirthday" class="easyui-datebox input_ele" editable="true" name="studentBirthday" data-options="required:true,editable:false" />
            </div>
            <div id="studentNativePlace_box" class="fitem">
                <label for="studentNativePlace">籍贯:</label>
                <input id="studentNativePlace" class="easyui-validatebox easyui-textbox input_ele" name="studentNativePlace" data-options="required:true,validType:'length[0,120]'"/>
                <%--</div>--%>
                <%--<div id="studentFamilyAddress_box" class="fitem">--%>
                <label>家庭住址:</label>
                <input id="studentFamilyAddress" class="easyui-validatebox easyui-textbox input_ele" name="studentFamilyAddress" data-options="required:true,validType:'length[0,120]'"/>
            </div>
            <div id="studentFamilyPostcode_box" class="fitem">
                <label>邮编:</label>
                <input id="studentFamilyPostcode" class="easyui-validatebox easyui-textbox input_ele" name="studentFamilyPostcode" data-options="validType:'length[0,10]'"/>
                <%--</div>--%>
                <%--<div id="studentIdCard_box" class="fitem">--%>
                <label>身份证号:</label>
                <input id="studentIdCard" class="easyui-validatebox easyui-textbox input_ele" name="studentIdCard" data-options="required:true,validType:'length[17,18]'"/>
            </div>
            <div id="studentPhone_box" class="fitem">
                <label>手机号:</label>
                <input id="studentPhone" class="easyui-validatebox easyui-textbox input_ele" name="studentPhone" data-options="required:true,validType:'length[0,20]'"/>
                <%--</div>--%>
                <%--<div id="studentQQ_box" class="fitem">--%>
                <label>QQ号:</label>
                <input id="studentQQ" class="easyui-validatebox easyui-textbox input_ele" name="studentQQ" data-options="validType:'length[0,20]'"/>
            </div>
            <div id="studentEmail_box" class="fitem">
                <label>电子邮件:</label>
                <input id="studentEmail" class="easyui-validatebox easyui-textbox input_ele" name="studentEmail" data-options="validType:'length[0,50]'"/>
                <%--</div>--%>
                <%--<div id="foreignLanguage_box" class="fitem">--%>
                <label>外语语种:</label>
                <input id="foreignLanguage" class="easyui-validatebox easyui-textbox input_ele" name="foreignLanguage" data-options="validType:'length[0,20]'"/>
            </div>
            <div id="faith_box" class="fitem">
                <label>宗教信仰:</label>
                <input id="faith" class="easyui-validatebox easyui-textbox input_ele" name="faith" data-options="validType:'length[0,20]'"/>
                <%--</div>--%>
                <%--<div id="politicsStatus_box" class="fitem">--%>
                <label>政治面貌:</label>
                <input id="politicsStatus" class="easyui-validatebox easyui-textbox input_ele" name="politicsStatus" data-options="validType:'length[0,20]'"/>
            </div>
            <div id="politicsStatusDate_box" class="fitem">
                <label>入党时间:</label>
                <input id="politicsStatusDate" class="easyui-datebox input_ele"  editable="true" name="politicsStatusDate" data-options="editable:false"/>
                <%--</div>--%>
                <%--<div id="usiCampus_box" class="fitem">--%>

            </div>
            <div id="stuClassName_box" class="fitem">
                <label>所在班级:</label>
                <input class="easyui-validatebox easyui-textbox input_ele" name="stuClassName"  id="stuClassName"
                        data-options="validType:'length[0,20]'">
                <label>年级:</label>
                <input id="stuGradeName" class="easyui-validatebox easyui-textbox input_ele" name="stuGradeName" data-options=""/>

            </div>
            <div id="stuMajorName-box" class="fitem">
                <label>专业:</label>
                <input id="stuMajorName" class="easyui-validatebox easyui-textbox input_ele" name="stuMajorName" data-options=""/>
                <label>学院:</label>
                <input id="stuCollageName" class="easyui-validatebox easyui-textbox input_ele " name="stuCollageName" data-options=""/>

            </div>
            <div id="usiBuilding_box" class="fitem">
                <label>寝室楼:</label>
                <input id="usiBuilding" class="easyui-validatebox easyui-textbox input_ele" name="usiBuilding" data-options="validType:'length[0,20]'"/>
                <label>入学年份:</label>
                <input id="entranceDate" class="easyui-validatebox easyui-textbox input_ele" name="entranceDate" data-options="validType:'length[0,20]'"/>
            </div>

            <div id="educationLength_box" class="fitem">
                <label>学制:</label>
                <input id="educationLength" class="easyui-validatebox easyui-textbox input_ele" name="educationLength" data-options="validType:'length[0,20]'"/>
                <%--</div>--%>
                <%--<div id="trainingMode_box" class="fitem">--%>
                <label>培养方式:</label>
                <input id="trainingMode" class="easyui-validatebox easyui-textbox input_ele" name="trainingMode" data-options="validType:'length[0,20]'"/>
            </div>
            <div id="orientationUnit_box" class="fitem">
                <label>定向单位:</label>
                <input id="orientationUnit" class="easyui-validatebox easyui-textbox input_ele" name="orientationUnit" data-options="validType:'length[0,50]'"/>
                <%--</div>--%>
                <%--<div id="enrollType_box" class="fitem">--%>
                <label>招生类别:</label>
                <input id="enrollType" class="easyui-validatebox easyui-textbox input_ele" name="enrollType" data-options="validType:'length[0,20]'"/>
            </div>
            <div id="schoolRollStatus_box" class="fitem">
                <label>学籍状态:</label>
                <input id="schoolRollStatus" class="easyui-validatebox easyui-textbox input_ele" name="schoolRollStatus" data-options="validType:'length[0,20]'"/>
                <%--</div>--%>
                <%--<div id="ceeOrigin_box" class="fitem">--%>

                <label>房间号:</label>
                <input id="usiRoomNumber" class="easyui-validatebox easyui-textbox input_ele" name="usiRoomNumber" data-options="validType:'length[0,20]'"/>
            </div>
            <div id="ceeNumber_box" class="fitem">
                <label>考号:</label>
                <input id="ceeNumber" class="easyui-validatebox easyui-textbox input_ele" name="ceeNumber" data-options="validType:'length[0,20]'"/>
                <%--</div>--%>
                <%--<div id="ceeProvince_box" class="fitem">--%>
                <label>所在省:</label>
                <input id="ceeProvince" class="easyui-validatebox easyui-textbox input_ele" name="ceeProvince" data-options="validType:'length[0,20]'"/>
            </div>
            <div id="ceeCity_box" class="fitem">
                <label>所在市:</label>
                <input id="ceeCity" class="easyui-validatebox easyui-textbox input_ele" name="ceeCity" data-options="validType:'length[0,20]'"/>
                <%--</div>--%>
                <%--<div id="ceeHighSchool_box" class="fitem">--%>
                <label>所在高中:</label>
                <input id="ceeHighSchool" class="easyui-validatebox easyui-textbox input_ele" name="ceeHighSchool" data-options="validType:'length[0,20]'"/>
            </div>
            <div id="ceeOrigin_box" class="fitem">
                <label>生源地:</label>
                <input id="ceeOrigin" class="easyui-validatebox easyui-textbox input_ele" name="ceeOrigin" data-options="validType:'length[0,20]'"/>
                <%--</div>--%>
                <%--<div id="entranceDate_box" class="fitem">--%>

            </div>
            <div id="studentLeader_box" class="fitem">
                <label style="vertical-align: top">学生干部:</label>
            <textarea id="studentLeader" class=" input_ele" name="studentLeader" >
            </textarea>
            </div>
        </form>
    </div>
    <%--对话框保存、取消按钮--%>
    <div id="dlg-buttons" >
        <a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls: 'icon-ok'" onclick="Save()">保存</a>
        <a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls: 'icon-cancel'" onclick="javascript:$('#dlg').dialog('close')">取消</a>
    </div>

</body>
</html>
