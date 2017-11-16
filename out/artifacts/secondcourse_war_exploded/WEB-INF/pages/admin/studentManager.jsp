<%--
  Created by IntelliJ IDEA.
  User: admin
  Date: 2016/5/9
  Time: 11:37
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
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
        //1、第一处修改，修改增删改的请求地址
        var addUrl = "/jsons/addStudent.form";
        var editUrl = "/jsons/editStudent.form";
        var deleteUrl = "/jsons/deleteStudent.form";
        var editorName = "null";//KindEditor的Textarea的ID，如果没用到，赋值为null
        var imageUpload = "studentPhoto";//图片上传的标识，如果没有图片上传，赋值为空，如果有，赋值为数据库存放图片名称的字段名称，不带_
        var deleteId = "studentID";//用于删除功能的ID参数，赋值为当前数据库表的ID
        var rows=25;
        var page=1;
        $(function(){
                $("input",$("#studentID").next("span")).blur(function(){
                    if(clickStatus=="add") {
                        setTimeout(function () {
                            var id = $("#studentID").textbox("getValue");
                            if (!id) {
                                ShowMsg("请输入学号！");
                                return;
                            }
                            $.ajax({
                                url: "/jsons/loadstudentId.form",
                                data: {student_id: id},
                                success: function (data) {
                                    if (data.rows != null && data.rows.length != 0) {
                                        ShowMsg("该学号已存在！");
                                    }
                                }
                            });
                        }, 500);
                    }
                });


            //班级
            $.ajax({
                url:'<%=request.getContextPath()%>/jsons/loadclassnames.form',
                dataType:"json",
                success:function(data){
                    $("#_usiClassId").combobox({valueField:'classId',textField:'className',panelHeight:'auto'}).combobox("loadData",data.rows).combobox("setText","全部");
                    $("#usiClassId").combobox({valueField:'classId',textField:'className',panelHeight:'auto'}).combobox("loadData",data.rows).combobox({"editable":false});
                }
            });
            //学制
            $.ajax({
                url:"<%=request.getContextPath()%>/jsons/loadeducationLength.form",
                dataType:"json",
                success:function(data){
                    $("#_educationLength").combobox({valueField:'educationLength',textField:'educationLength',panelHeight:'auto'}).combobox("loadData",data.rows).combobox("setText","全部");
                }
            });
            //性别
            $("#_studentGender").combobox({valueField:'sex',textField:'sex',panelHeight:'auto'}).combobox("loadData",[{sex:"男"},{sex:"女"}]).combobox("setText","全部");
            //培养方式
            $.ajax({
                url:"<%=request.getContextPath()%>/jsons/loadtrainingMode.form",
                dataType:"json",
                success:function(data){
                    $("#_trainingMode").combobox({valueField:'trainingMode',textField:'trainingMode',panelHeight:'auto'}).combobox("loadData",data.rows).combobox("setText","全部");
                }
            });
            //招生类别
            $.ajax({
                url:"<%=request.getContextPath()%>/jsons/loadenrollType.form",
                dataType:"json",
                success:function(data){
                    $("#_enrollType").combobox({valueField:'enrollType',textField:'enrollType',panelHeight:'auto'}).combobox("loadData",data.rows).combobox("setText","全部");
                }
            });
            //学籍状态
            $.ajax({
                url:"<%=request.getContextPath()%>/jsons/loadschoolRollStatus.form",
                dataType:"json",
                success:function(data){
                    $("#_schoolRollStatus").combobox({valueField:'schoolRollStatus',textField:'schoolRollStatus',panelHeight:'auto'}).combobox("loadData",data.rows).combobox("setText","全部");
                }
            });
            // 初始化批量上传图片插件
            $("#up_imgs_box").zyUpload({
                width            :   "650px",                                   // 宽度
                height           :   "300px",                                   // 高度
                itemWidth        :   "110px",                                   // 文件项的宽度
                itemHeight       :   "100px",                                   // 文件项的高度
                url              :   "/ImageUpload/No_Intercept_multiple_Upload.form",   // 上传文件的路径
                fileType         :   ["jpg","png","jpeg","gif"],                // 上传文件的类型
                fileSize         :   2*1024*1024,                                   // 上传文件的大小
                multiple         :   true,                                      // 是否可以多个文件上传
                dragDrop         :   true,                                      // 是否可以拖动上传文件
                tailor           :   true,                                      // 是否可以裁剪图片
                del              :   true,                                      // 是否可以删除文件
                finishDel        :   true,  				                    // 是否在上传文件完成后删除预览
                /* 外部获得的回调接口 */
                onSelect: function(selectFiles, allFiles){    // 选择文件的回调方法  selectFile:当前选中的文件  allFiles:还没上传的全部文件
                    console.info("当前选择了以下文件：");
                    console.info(selectFiles);
                },
                onDelete: function(file, files){              // 删除一个文件的回调方法 file:当前删除的文件  files:删除之后的文件
                    console.info("当前删除了此文件：");
                    console.info(file.name);
                },
                onSuccess: function(file, response){          // 文件上传成功的回调方法
                    console.info("此文件上传成功：");
                    console.info(file.name);
                    console.info("此文件上传到服务器地址：");
                    console.info(response);
                    $("#uploadInf").append("<p>上传成功，文件地址是：" + response + "</p>");
                },
                onFailure: function(file, response){          // 文件上传失败的回调方法
                    console.info("此文件上传失败：");
                    console.info(file.name);
                },
                onComplete: function(response){           	  // 上传完成的回调方法
                    console.info("文件上传完成");
                    console.info(response);
                }
            });
        });
        //下载模版文件
        function getModel(){
            window.open("<%=request.getContextPath()%>/Files/ExcelModels/students_info.xls");
        }
        function upImages(){
            $("#batch_up_img").dialog("open");
        }
    </script>
    <style>
        /*上传学生照片内 消息框部分样式*/
        .upload_inf{
            height: 180px;
            overflow: auto;
            font-family:宋体;
            font-size: 10px;
        }
        /*上传学生照片内 图片预览部分样式*/
        .upload_preview{
            height: 250px;
            overflow: auto;
        }
    </style>
    <%--判断是否是登录状态--%>
    <%@include file="../common/CheckLogin.jsp"%>
    <%--<%@include file="../common/CheckLogin.jsp"%>--%>
</head>
<body>
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
               <%--2、第二处修改，修改此处的Json服务，用于加载数据--%>
               url:'/jsons/loadStudents.form'" >
    <thead>
    <%--data-options="frozen:true"--%>
    <tr>
        <th field="student_info" colspan="13" >学生基本信息</th>
        <th field="uc_info" colspan="7" >学生高校信息</th>
        <%--<th field="cee_info" colspan="5" >学生高考信息</th>--%>
    </tr>
    <tr>
        <%--3、第三处修改，修改此处的列名称，与数据库一致，显示有必要的--%>
            <th field="studentID"  >学号</th>
            <th field="studentName"  >姓名</th>
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
            <th field="usiCampus"  >所在校区</th>
            <%--<th field="className"  >所在班级</th>--%>
            <%--<th field="usiBuilding"  >寝室楼</th>--%>
            <%--<th field="usiRoomNumber"  >房间号</th>--%>
            <th field="entranceDate"  >入学年份</th>
            <th field="educationLength"  >学制</th>
            <th field="trainingMode"  >培养方式</th>
            <th field="orientationUnit"  >定向单位</th>
            <th field="enrollType"  >招生类别</th>
            <th field="schoolRollStatus"  >学籍状态</th>
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
        <a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-reload',plain:true" onclick="reloadData()">刷新</a>
        <a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-reload',plain:true" onclick="reloadThis()">刷新当前页</a>
        <a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-add',plain:true" onclick="Add_before()">新建</a>
        <a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-edit',plain:true" onclick="editMore()">修改</a>
        <a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-remove',plain:true" onclick="DeleteMore()">删除</a>
        <%--<a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-remove',plain:true" onclick="DeleteMore()">批量删除</a>--%>
        <a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-search',plain:true" onclick="searchBy()">综合条件查询</a>
        <a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-add',plain:true" onclick="batchInsert()">导入学生信息</a>
        <a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-add',plain:true" onclick="upImages()">上传学生照片</a>
        <a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-add',plain:true" onclick="getModel()">下载模版</a>
        <div id="search_condition" style="border-top: 1px solid #eeeeee;margin: 5px 5px 0 5px;padding-top: 10px; float: left;background: #F4F4F4;display: none" >
           <div style="width: 60%;display: inline-block;float: left;border: 1px solid #c0c0c0;padding-bottom: 5px;border-radius: 4px;">
               <form id="search_fm">
               <div class="item">
                   <span class="text_"><span class="_flag">*</span>学号：<input class="easyui-textbox input_item" id="_studentID"  name="studentID"></span>
                   <span class="text_"><span class="_flag">*</span>姓名：<input class="easyui-textbox input_item" id="_studentName"  name="studentName"></span>
                   <%--<span class="text_">曾用名：<input  class="easyui-textbox input_item" id="_studentUsedName" name="studentUsedName"/></span>--%>
                   <span class="text_"><span class="_flag">*</span>性别：<input class="easyui-textbox input_item" id="_studentGender" name="studentGender"></span>
                   <%--<span class="text_">民族：<input class="easyui-textbox input_item" id="_studentNation" name="studentNation"></span>--%>
                   <%--<span class="text_">籍贯：<input class="easyui-textbox input_item" id="_studentNativePlace" name="studentNativePlace"></span>--%>
                   <%--<span class="text_">家庭住址：<input class="easyui-textbox input_item" id="_studentFamilyAddress" name="studentFamilyAddress"></span>--%>
                   <span class="text_"><span class="_flag">*</span>身份证号：<input class="easyui-textbox input_item" id="_studentIdCard" name="studentIdCard"></span>
                   <span class="text_"><span class="_flag">*</span>手机号：<input class="easyui-textbox input_item" id="_studentPhone" name="studentPhone"></span>
                   <%--<span class="text_">外语语种：<input class="easyui-textbox input_item" id="_foreignLanguage" name="foreignLanguage"></span>--%>
                   <%--<span class="text_">宗教信仰：<input class="easyui-textbox input_item" id="_faith" name="faith"></span>--%>
                   <span class="text_">政治面貌：<input class="easyui-textbox input_item" id="_politicsStatus" name="politicsStatus"></span>
                   <%--<br>--%>
                   <span class="text_">入党(团)起始时间：<input class="easyui-datebox input_item" id="politics_STime" name="politics_STime"></span>
                   <span class="text_ ">结束时间：<input class="easyui-datebox input_item" id="politics_ETime" name="politics_ETime"></span>
               </div>
               <div class="item">
                   <span class="text_">所在校区：<input class="easyui-textbox input_item" id="_usiCampus" name="usiCampus"></span>
                   <span class="text_"><span class="_flag">*</span>所在班级：<input class="input_item" id="_usiClassId" name="usiClassId"></span>
                   <%--<span class="text_">寝室楼：<input class="easyui-textbox input_item" id="_usiBuilding" name="usiBuilding"></span>--%>
                   <span class="text_"><span class="_flag">*</span>房间号：<input class="easyui-textbox input_item" id="_usiRoomNumber" name="usiRoomNumber"></span>
                   <%--<span class="text_">入学年份：<input class="easyui-textbox input_item" id="_entranceDate" name="entranceDate"></span>--%>
                   <span class="text_"><span class="_flag">*</span>学制：<input class="easyui-textbox input_item" id="_educationLength" name="educationLength"></span>
                   <span class="text_"><span class="_flag">*</span>培养方式：<input class="easyui-textbox input_item" id="_trainingMode" name="trainingMode"></span>
                   <%--<span class="text_">定向单位：<input class="easyui-textbox input_item" id="_orientationUnit" name="orientationUnit"></span>--%>
                   <span class="text_"><span class="_flag">*</span>招生类别：<input class="easyui-textbox input_item" id="_enrollType" name="enrollType"></span>
                   <span class="text_"><span class="_flag">*</span>学籍状态：<input class="easyui-textbox input_item" id="_schoolRollStatus" name="schoolRollStatus"></span>
                   <%--<span class="text_">学生干部：<input class="easyui-textbox input_item" id="_studentLeader" name="studentLeader"></span>--%>
               </div>
               <div class="item">
                   <%--<span class="text_">生源地：<input class="easyui-textbox input_item" id="_ceeOrigin" name="ceeOrigin"></span>--%>
                   <span class="text_"><span class="_flag">*</span>考号：<input class="easyui-textbox input_item" id="_ceeNumber" name="ceeNumber"></span>
                   <%--<span class="text_">所在省：<input class="easyui-textbox input_item" id="_ceeProvince" name="ceeProvince"></span>--%>
                   <%--<span class="text_">所在市：<input class="easyui-textbox input_item" id="_ceeCity" name="ceeCity"></span>--%>
                   <%--<span class="text_">所在高中：<input class="easyui-textbox input_item" id="_ceeHighSchool" name="ceeHighSchool"></span>--%>
               </div>
                   &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                   <%--注：带<span class="_flag">*</span>的条件为精确匹配项，输入的内容必须和数据库中的一致才可以匹配到结果--%>
                   <span style="color:#E41D1D;">
                       注：因为数据经过加密的关系，所有列出条件均为精确匹配，输入的内容必须和数据库中的一致才可以匹配到结果</span>
           </form>
               <div style="width: 230px;display: inline-block;float: right;padding-right: 100px;">
                   <a href="javascript:void(0)" class="easyui-linkbutton" style="width:100px;height: 30px;" data-options="iconCls:'icon-no',plain:false" onclick="formreset()">清空</a>
                   <a href="javascript:void(0)" class="easyui-linkbutton" style="width:100px;height: 30px;margin-left: 10px;" data-options="iconCls:'icon-ok',plain:false" onclick="searchAction()">搜索</a>
               </div>
           </div>

        </div>
        <br>
        <div style="border-top: 1px solid #aaaaaa;margin-top: 5px;padding-top: 5px;">
            <a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-redo',plain:true" onclick="selectalldata()">全选</a>
            <a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-undo',plain:true" onclick="unselectdata()">取消已选</a>
        </div>
</div>
<%--对话框--%>
<div id="dlg" class="easyui-dialog hide" title=""
     style="width:750px;height:620px;padding:10px;"
     data-options="iconCls: 'icon-save',buttons: '#dlg-buttons',modal:true,top:'10%'" closed="true" >
    <%--5、第五处修改，修改表单信息，与上面的列名称一致--%>
    <form id="Form">
        <div id="userphoto_box" >
        <img id="user_photo" src="<%=request.getContextPath()%>/asset/image/default.jpg" style="width: 142px;height: 200px;margin-right: 130px;">
        </div>
        <div id="studentID_box" class="fitem">
        <label>学号:</label>
        <input id="studentID" class="easyui-validatebox easyui-textbox input_ele" name="studentID" data-options="required:true,validType:'length[0,20]'"/>
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
            <input id="studentIdCard" class="easyui-validatebox easyui-textbox input_ele" name="studentIdCard" data-options="required:true,validType:'length[0,20]'"/>
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
        <label>入团或入党时间:</label>
        <input id="politicsStatusDate" class="easyui-datebox input_ele"  editable="true" name="politicsStatusDate" data-options="editable:false"/>
        <%--</div>--%>
        <%--<div id="usiCampus_box" class="fitem">--%>
        <label>所在校区:</label>
        <input id="usiCampus" class="easyui-validatebox easyui-textbox input_ele" name="usiCampus" data-options="validType:'length[0,20]'"/>
        </div>
        <div id="usiClassId_box" class="fitem">
            <label>所在班级:</label>
            <input id="usiClassId" class="easyui-validatebox input_ele" name="usiClassId" data-options="validType:'length[0,20]'"/>
            <%--</div>--%>
            <%--<div id="usiBuilding_box" class="fitem">--%>
            <label>寝室楼:</label>
            <input id="usiBuilding" class="easyui-validatebox easyui-textbox input_ele" name="usiBuilding" data-options="validType:'length[0,20]'"/>
        </div>
        <div id="usiRoomNumber_box" class="fitem">
            <label>房间号:</label>
            <input id="usiRoomNumber" class="easyui-validatebox easyui-textbox input_ele" name="usiRoomNumber" data-options="validType:'length[0,20]'"/>
            <%--</div>--%>
            <%--<div id="entranceDate_box" class="fitem">--%>
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
            <label>生源地:</label>
            <input id="ceeOrigin" class="easyui-validatebox easyui-textbox input_ele" name="ceeOrigin" data-options="validType:'length[0,20]'"/>
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
        <div id="studentLeader_box" class="fitem">
                <label style="vertical-align: top">学生干部:</label>
            <textarea id="studentLeader" class=" input_ele" name="studentLeader" >
            </textarea>
        </div>
    </form>
</div>
<%--批量导入对话框--%>
<div id="batch_dlg" class="easyui-dialog hide" title="批量导入" style="width:600px;height:420px;padding:10px;"
     data-options="iconCls: 'icon-save',buttons: '#batch_dlg_buttons',modal:true,top:'10%'" closed="true" >
    <div id="file_box" class="fitem">
        <label>选择文件:</label>
        <input id="upfile" class=" input_ele" name="fileup" type="file"/>
    </div>
    <div id="_box" class="fitem">
        <label></label>
    </div>
    <div id="btn_box" class="fitem">
        <label></label>
        <a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls: 'icon-ok'" onclick="validFile()">验证文件</a>&nbsp;&nbsp;&nbsp;&nbsp;
        <a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls: 'icon-save'" onclick="uploadFile()">上传并导入</a>
    </div>
    <div id="result_box" class="fitem">
        <label>操作结果:</label>
        <br>
        <label></label>
        <div id="valid_result" class=" input_ele" style="width: 390px;height: 200px;border: 1px solid #95B8E7;overflow: auto"></div>
    </div>
</div>
<div id="batch_up_img" class="easyui-dialog hide" title="上传图片" style="width:680px;height:720px;padding:0;"
     data-options="iconCls: 'icon-save',buttons: '#batch_up_imgs',modal:true,top:'10%'" closed="true" >
    <div id="up_imgs_box" style="margin: 0 auto;padding: 0;"></div>
</div>
<%--对话框保存、取消按钮--%>
<div id="dlg-buttons" >
    <a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls: 'icon-ok'" onclick="Save()">保存</a>
    <a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls: 'icon-cancel'" onclick="javascript:$('#dlg').dialog('close')">取消</a>
</div>
<%--批量导入对话框的按钮--%>
<div id="batch_dlg_buttons" >
    <a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls: 'icon-cancel'" onclick="javascript:$('#batch_dlg').dialog('close')">关闭</a>
</div>

<%--批量上传图片对话框的按钮--%>
<div id="batch_up_imgs" >
    <a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls: 'icon-cancel'" onclick="javascript:$('#batch_up_img').dialog('close')">关闭</a>
</div>
</body>
</html>