<%--
  Created by IntelliJ IDEA.
  User: gq
  Date: 2016/10/25
  Time: 8:45
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java"  pageEncoding="UTF-8" %>

<head>
    <link rel="Shortcut Icon" href="<%=request.getContextPath()%>/asset/image/neu.jpg" type="image/x-icon">
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
    <!--兼容360浏览器，防止布局乱，设置IE的文档模式为最高版本，并且如果存在chrome插件，自动使用Webkit引擎-->
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <link rel="stylesheet" href="<%=request.getContextPath()%>/asset_admin_new/css/StuMsgManage.css" />
    <script type="text/javascript" src="<%=request.getContextPath()%>/asset_admin_new/js/jquery-1.11.1.min.js"></script>
    <script type="text/javascript" src="<%=request.getContextPath()%>/asset/js/laydate/laydate.js"></script>
    <script type="text/javascript" src="<%=request.getContextPath()%>/asset/js/common.js"></script>
    <script type="text/javascript" src="<%=request.getContextPath()%>/asset_admin_new/js/studentManage.js"></script>
    <!-- 导入layer -->
    <script type="text/javascript" src="<%=request.getContextPath()%>/asset/layer/layer.js"></script>

    <%--引入kindereditor--%>
    <link rel="stylesheet" href="<%=request.getContextPath()%>/asset/kindeditor-4.1.10/themes/default/default.css" />
    <link rel="stylesheet" href="<%=request.getContextPath()%>/asset/kindeditor-4.1.10/plugins/code/prettify.css" />
    <script charset="utf-8" src="<%=request.getContextPath()%>/asset/kindeditor-4.1.10/kindeditor.js"></script>
    <script charset="utf-8" src="<%=request.getContextPath()%>/asset/kindeditor-4.1.10/lang/zh_CN.js"></script>
    <script charset="utf-8" src="<%=request.getContextPath()%>/asset/kindeditor-4.1.10/plugins/code/prettify.js"></script>
    <%--引入表单验证--%>
    <script type="text/javascript" src="<%=request.getContextPath()%>/asset_admin_new/js/Validform_v5.3.2.js"></script>
    <link rel="stylesheet" href="<%=request.getContextPath()%>/asset_admin_new/css/style.css" />
    <link rel="stylesheet" href="<%=request.getContextPath()%>/asset_admin_new/css/demo.css" />
    <%--引入图片上传--%>
    <script type="text/javascript" src="<%=request.getContextPath()%>/asset/js/ajaxfileupload.js"></script>
    <title>第二课堂教师管理界面</title>
    <script>
        //1、第一处修改，修改增删改的请求地址以及deleteId
        var moduleType = GetQueryString("moduleType");//所属模块的ID
        var addUrl = "/jsons/addStudent.form";
        var editUrl = "/jsons/editStudent.form";
        var deleteUrl = "/jsons/deleteStudent.form";
        var editorName = "";//KindEditor的Textarea的ID，如果没用到，赋值为null
        var imageUpload = "studentPhoto";//图片上传的标识，如果没有图片上传，赋值为空，如果有，赋值为数据库存放图片名称的字段名称，不带_
        var deleteId = "studentID";//用于删除功能的ID参数，赋值为当前数据库表的ID
        var fileUpload='';
        var loadUrl = "/jsons/loadStudentsNew.form";
        /**
         * 加载数据
         */
        $(function(){
            //绑定跳页Enter键
            $(".currentPageNum").keyup(function(e){
                var pagNum = $(".currentPageNum").val();
                if(e.keyCode==13){
                    select_box(pagNum);
                }
            });
            before_reload();
            $(".table").hide();
            $(".pagingTurn").hide();
            $(".searchContent").show();
            $("#studentID").blur(function(){
                if(clickStatus=="add") {
                    setTimeout(function () {
                        var id = $("#studentID").val();
                        if (!id) {
                            layer.msg("请输入学号！");
                            return;
                        }
                        $.ajax({
                            url: "/jsons/loadstudentId.form",
                            data: {student_id: id},
                            success: function (data) {
                                if (data.rows != null && data.rows.length != 0) {
                                    layer.msg("该学号已存在！");
                                }
                            }
                        });
                    }, 500);
                }
            });
            //综合查询条件：学制
            $.ajax({
                url:"<%=request.getContextPath()%>/jsons/loadeducationLength.form",
                dataType:"json",
                success:function(data){
                    var friends = $("#educateLength");
                    friends.empty();
                    friends.append("<option value=''>请选择</option>");
                    friends.append("<option value=''>全部</option>");
                    if(data.rows !=null && data.rows.length > 0){
                        for(var i=0;i<data.rows.length;i++) {
                            var option = $("<option>").text(data.rows[i].educationLength).val(data.rows[i].educationLength);
                            friends.append(option);
                        }
                    }else{
                        var option = $("<option>").text("无");
                        friends.append(option);
                    }
                }
            });
            //综合查询条件：培养方式
            $.ajax({
                url:"<%=request.getContextPath()%>/jsons/loadtrainingMode.form",
                dataType:"json",
                success:function(data){
                    var friends = $("#TrainMode");
                    friends.empty();
                    friends.append("<option value=''>请选择</option>");
                    friends.append("<option value=''>全部</option>");
                    if(data.rows !=null && data.rows.length > 0){
                        for(var i=0;i<data.rows.length;i++) {
                            var option = $("<option>").text(data.rows[i].trainingMode).val(data.rows[i].trainingMode);
                            friends.append(option);
                        }
                    }else{
                        var option = $("<option>").text("无");
                        friends.append(option);
                    }
                }
            });
            //综合查询条件：招生类别
            $.ajax({
                url:"<%=request.getContextPath()%>/jsons/loadenrollType.form",
                dataType:"json",
                success:function(data){
                    var friends = $("#EnroType");
                    friends.empty();
                    friends.append("<option value=''>请选择</option>");
                    friends.append("<option value=''>全部</option>");
                    if(data.rows !=null && data.rows.length > 0){
                        for(var i=0;i<data.rows.length;i++) {
                            var option = $("<option>").text(data.rows[i].enrollType).val(data.rows[i].enrollType);
                            friends.append(option);
                        }
                    }else{
                        var option = $("<option>").text("无");
                        friends.append(option);
                    }
                }
            });
            //综合查询条件：学籍状态
            $.ajax({
                url:"<%=request.getContextPath()%>/jsons/loadschoolRollStatus.form",
                dataType:"json",
                success:function(data){
                    var friends = $("#schoolStatus");
                    friends.empty();
                    friends.append("<option value=''>请选择</option>");
                    friends.append("<option value=''>全部</option>");
                    if(data.rows !=null && data.rows.length > 0){
                        for(var i=0;i<data.rows.length;i++) {
                            var option = $("<option>").text(data.rows[i].schoolRollStatus).val(data.rows[i].schoolRollStatus);
                            friends.append(option);
                        }
                    }else{
                        var option = $("<option>").text("无");
                        friends.append(option);
                    }
                }
            });
            //综合查询条件：民族
            $.ajax({
                url:"<%=request.getContextPath()%>/jsons/loadschoolstudentNation.form",
                dataType:"json",
                success:function(data){
                    var friends = $("#stuNation");
                    friends.empty();
                    friends.append("<option value=''>请选择</option>");
                    friends.append("<option value=''>全部</option>");
                    if(data.rows !=null && data.rows.length > 0){
                        for(var i=0;i<data.rows.length;i++) {
                            var option = $("<option>").text(data.rows[i].studentNation).val(data.rows[i].studentNation);
                            friends.append(option);
                        }
                    }else{
                        var option = $("<option>").text("无");
                        friends.append(option);
                    }
                }
            });
            //综合查询条件：学院
            $.ajax({
                url: "<%=request.getContextPath()%>/jsons/loadstuCollageName.form",
                dataType: "json",
                success: function (data) {
                    var friends = $("#CollageName");
                    // var friends1 = $("#stuCollageName");
                    friends.empty();
                    // friends1.empty();
                    friends.append("<option value=''>请选择</option>");
                    friends.append("<option value=''>全部</option>");
                    //  friends1.append("<option value=''>请选择</option>");
                    if (data.rows != null && data.rows.length > 0) {
                        for (var i = 0; i < data.rows.length; i++) {
                            var option = $("<option>").text(data.rows[i].stuCollageName).val(data.rows[i].stuCollageName);
                            friends.append(option);
                            //     friends1.append(option);
                        }
                    } else {
                        var option = $("<option>").text("无");
                        friends.append(option);
                        //  friends1.append(option);
                    }
                }
            })
            //学生管理：学院
            $.ajax({
                url:"<%=request.getContextPath()%>/jsons/loadstuCollageName.form",
                dataType:"json",
                success:function(data){
//                    var friends = $("#CollageName");
                     var friends1 = $("#stuCollageName");
//                    friends.empty();
                     friends1.empty();
//                    friends.append("<option value=''>请选择</option>");
//                    friends.append("<option value=''>全部</option>");
                      friends1.append("<option value=''>请选择</option>");
                    if(data.rows !=null && data.rows.length > 0){
                        for(var i=0;i<data.rows.length;i++) {
                            var option = $("<option>").text(data.rows[i].stuCollageName).val(data.rows[i].stuCollageName);
//                            friends.append(option);
                                 friends1.append(option);
                        }
                    }else{
                        var option = $("<option>").text("无");
//                        friends.append(option);
                          friends1.append(option);
                    }
                }
            });
            //综合查询条件：专业
            $("#CollageName").change(function(){
                $.ajax({
                    url:"<%=request.getContextPath()%>/jsons/loadstuMajorName.form",
                    dataType:"json",
                    data:{stuCollageName:$(this).val()},
                    success:function(data){
                        var friends = $("#MajorName");
                        friends.empty();
                        friends.append("<option value=''>请选择</option>");
                        friends.append("<option value=''>全部</option>");
                        if(data.rows !=null && data.rows.length > 0) {
                            for(var i=0;i<data.rows.length;i++){
                                var option=$("<option>").text(data.rows[i].stuMajorName).val(data.rows[i].stuMajorName);
                                friends.append(option);
                            }
                        }else{
                            var option = $("<option>").text("无");
                            friends.append(option);
                        }
                    }
                });
            });
            //学生管理：专业
            $("#stuCollageName").change(function(){
                $.ajax({
                    url:"<%=request.getContextPath()%>/jsons/loadstuMajorName.form",
                    dataType:"json",
                    data:{stuCollageName:$(this).val()},
                    success:function(data){
                        var friends = $("#stuMajorName");
                        friends.empty();
                        friends.append("<option value=''>请选择</option>");
                        if(data.rows !=null && data.rows.length > 0) {
                            for(var i=0;i<data.rows.length;i++){
                              var option=$("<option>").text(data.rows[i].stuMajorName).val(data.rows[i].stuMajorName);
                                friends.append(option);
                            }
                        }else{
                            var option = $("<option>").text("无");
                            friends.append(option);
                        }
                    }
                });
            });
            //综合查询条件：年级
            $("#MajorName").change(function(){
                $.ajax({
                    url: "<%=request.getContextPath()%>/jsons/loadstuGradeName.form",
                    dataType: "json",
                    data:{stuMajorName:$(this).val()},
                    success: function (data) {
                        var friends = $("#GradeName");
                        friends.empty();
                        friends.append("<option value=''>请选择</option>");
                        friends.append("<option value=''>全部</option>");
                        if(data.rows !=null && data.rows.length > 0){
                            for(var i=0;i<data.rows.length;i++) {
                                var option = $("<option>").text(data.rows[i].stuGradeName).val(data.rows[i].stuGradeName);
                                friends.append(option);
                            }
                        }else{
                            var option = $("<option>").text("无");
                            friends.append(option);
                        }
                    }
                });
            });
            //学生管理条件：年级
            $("#stuMajorName").change(function(){
                $.ajax({
                    url: "<%=request.getContextPath()%>/jsons/loadstuGradeName.form",
                    dataType: "json",
                    data:{stuMajorName:$(this).val()},
                    success: function (data) {
                        var friends = $("#stuGradeName");
                        friends.empty();
                        friends.append("<option value=''>请选择</option>");
                        if(data.rows !=null && data.rows.length > 0){
                            for(var i=0;i<data.rows.length;i++) {
                                var option = $("<option>").text(data.rows[i].stuGradeName).val(data.rows[i].stuGradeName);
                                friends.append(option);
                            }
                        }else{
                            var option = $("<option>").text("无");
                            friends.append(option);
                        }
                    }
                });
            });
            //z综合查询条件：班级
            $("#GradeName").change(function() {
                $.ajax({
                    url: '<%=request.getContextPath()%>/jsons/loadclassnames1.form',
                    dataType: "json",
                    data: {stuGradeName: $(this).val(),stuMajorName:$("#MajorName").val()},
                    success: function (data) {
                        var friends = $("#ClassName");
                        friends.empty();
                        friends.append("<option value=''>请选择</option>");
                        friends.append("<option value=''>全部</option>");
                        if (data.rows != null && data.rows.length > 0) {
                            for (var i = 0; i < data.rows.length; i++) {
                                var option = $("<option>").text(data.rows[i].stuClassName).val(data.rows[i].stuClassName);
                                friends.append(option);
                            }
                        } else {
                            var option = $("<option>").text("无");
                            friends.append(option);
                        }
                    }
                });
            });
            //学生管理：班级
            $("#stuGradeName").change(function(){
                $.ajax({
                    url: '<%=request.getContextPath()%>/jsons/loadclassnames1.form',
                    dataType: "json",
                    data:{stuGradeName:$(this).val(),stuMajorName:$("#stuMajorName").val()},
                    success: function (data) {
                        var friends = $("#stuClassName");
                        friends.empty();
                        friends.append("<option value=''>请选择</option>");
                        if(data.rows !=null && data.rows.length > 0){
                            for(var i=0;i<data.rows.length;i++) {
                                var option = $("<option>").text(data.rows[i].stuClassName).val(data.rows[i].stuClassName);
                                friends.append(option);
                            }
                        }else{
                            var option = $("<option>").text("无");
                            friends.append(option);
                        }
                    }
                });
            });
            //综合查询条件：房间号
            $.ajax({
                url:"<%=request.getContextPath()%>/jsons/loadUsiRoomNumber.form",
                dataType:"json",
                success:function(data){
                    var friends = $("#RoomNumber");
                    friends.empty();
                    friends.append("<option value=''>请选择</option>");
                    friends.append("<option value=''>全部</option>");
                    if(data.rows !=null && data.rows.length > 0){
                        for(var i=0;i<data.rows.length;i++) {
                            var option = $("<option>").text(data.rows[i].usiRoomNumber).val(data.rows[i].usiRoomNumber);
                            friends.append(option);
                        }
                    }else{
                        var option = $("<option>").text("无");
                        friends.append(option);
                    }
                }
            });
            //综合查询条件：寝室楼
            $.ajax({
                url:"<%=request.getContextPath()%>/jsons/loadUsiBuilding.form",
                dataType:"json",
                success:function(data){
                    var friends = $("#Building");
                    friends.empty();
                    friends.append("<option value=''>请选择</option>");
                    friends.append("<option value=''>全部</option>");
                    if(data.rows !=null && data.rows.length > 0){
                        for(var i=0;i<data.rows.length;i++) {
                            var option = $("<option>").text(data.rows[i].usiBuilding).val(data.rows[i].usiBuilding);
                            friends.append(option);
                        }
                    }else{
                        var option = $("<option>").text("无");
                        friends.append(option);
                    }
                }
            });
        });
        function before_reload(){

            page= $(".currentPageNum").val();
            rows = $("#rows").val();
            jsonPara={rows:rows,page:page};
            reload();
        }
        function refresh_reload(){
            isSelect='';
            clickStatus='';
            $(".currentPageNum").val(1);
            page=1;
            rows = $("#rows").val();
            if(isCondition=='true'){
                select_box(1);
            }else{
                jsonPara={rows:rows,page:page};
                reload();
            }
        }
        function  reload(){
            load();
            $(".table").show();
            $(".pagingTurn").show();
            $.ajax({
                url:loadUrl,
                type:"post",
                data:jsonPara,
                dataType:"json",
                success:function(data){
                    $("#data_domo").html("");
                    if(data!=null && data.rows!=null &&data.rows.length>0){
                        for(var i = 0 ;i<data.rows.length;i++){
                            var row = data.rows[i];
                            for(var key in row){
                                if(row[key]==null||row[key]=='null'||row[key]=='NULL')
                                    row[key]='';
                            }
                            var tr = '<tr id="tr'+(i+1)+'">'+
                                    '<td>'+(i+1)+'</td>'+
                                    '<td class="studentID" title="'+row.studentID+'">'+row.studentID+'</td>'+
                                    '<td class="studentName" title="'+row.studentName+'">'+row.studentName+'</td>'+
                                    '<td class="studentGender" title="'+row.studentGender+'">'+row.studentGender+'</td>'+
                                    '<td class="studentNation" title="'+row.studentNation+'">'+row.studentNation+'</td>'+
                                    '<td class="studentBirthday" title="'+row.studentBirthday+'">'+row.studentBirthday+'</td>'+
                                    '<td class="studentNativePlace" title="'+row.studentNativePlace+'">'+row.studentNativePlace+'</td>'+
                                    '<td class="studentFamilyAddress" title="'+row.studentFamilyAddress+'">'+row.studentFamilyAddress+'</td>'+
                                    '<td class="studentFamilyPostcode" title="'+row.studentFamilyPostcode+'">'+row.studentFamilyPostcode+'</td>'+
                                    '<td class="studentIdCard" title="'+row.studentIdCard+'">'+row.studentIdCard+'</td>'+
                                    '<td class="studentPhone" title="'+row.studentPhone+'">'+row.studentPhone+'</td>'+
                                    '<td class="studentQQ" title="'+row.studentQQ+'">'+row.studentQQ+'</td>'+
                                    '<td class="studentEmail" title="'+row.studentEmail+'">'+row.studentEmail+'</td>'+
                                    '<td class="politicsStatus" title="'+row.politicsStatus+'">'+row.politicsStatus+'</td>'+
//                                    '<td class="usiCampus" title="'+row.usiCampus+'">'+row.usiCampus+'</td>'+
//                                    '<td class="entranceDate" title="'+row.entranceDate+'">'+row.entranceDate+'</td>'+
//                                    '<td class="educationLength" title="'+row.educationLength+'">'+row.educationLength+'</td>'+
//                                    '<td class="trainingMode" title="'+row.trainingMode+'">'+row.trainingMode+'</td>'+
//                                    '<td class="orientationUnit" title="'+row.orientationUnit+'">'+row.orientationUnit+'</td>'+
//                                    '<td class="enrollType" title="'+row.enrollType+'">'+row.enrollType+'</td>'+
                                    '</tr>';

                            $("#data_domo").append(tr);
                            $("#tr"+(i+1)).data(row);
                        }
                        rowClick();//绑定行点击事件
                        totalNum=data.total;
                        paging();
                        disLoad();
                    }else{
                        totalNum=0;
                        page=0;
                        $(".currentPageNum").val('0');
                        paging();
                        disLoad();
                    }

                },error:function(){
                    layer.msg("网络错误");
                }
            });


        }
        //综合查询
        function select_box(page) {
            var jsonObject = $(".searchContent").serializeObject();
            jsonObject["studentID"] = $("#StuID").val().trim();
            jsonObject["studentIdCard"] = $("#IdCrad").val();
            jsonObject["studentName"] = $("#StuName").val();
            jsonObject["studentPhone"] = $("#StuPhone").val();
            jsonObject["usiCampus"] = $("#StuCampus").val();
            jsonObject["stuGradeName"] = $("#GradeName").val();
            jsonObject["usiBuilding"] = $("#Building").val();
            jsonObject["trainingMode"] = $("#TrainMode").val();
            jsonObject["usiRoomNumber"] = $("#RoomNumber").val();
            jsonObject["enrollType"] = $("#EnroType").val();
            jsonObject["studentGender"] = $("#Gender").val();
            jsonObject["stuCollageName"] = $("#CollageName").val();
            jsonObject["schoolRollStatus"] =$("#schoolStatus").val();
            jsonObject["studentNation"] = $("#stuNation").val();
            jsonObject["stuMajorName"] = $("#MajorName").val();
            jsonObject["stuClassName"] = $("#ClassName").val();
            jsonObject["educationLength"] = $("#educateLength").val();
            jsonObject["rows"] = $("#rows").val() ;
            if(Math.ceil(totalNum/$("#rows").val())<page){
                page=Math.ceil(totalNum/$("#rows").val());
            }
            if(page<=0){
                page=1;
            }
            jsonObject["page"] = page;
            $(".currentPageNum").val(page);
            //console.log(jsonObject);
            jsonPara=jsonObject;
            $('.searchContent').slideUp();
            reload();

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
            var pagNum = $(".currentPageNum").val();
            select_box(newpage1);
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
            var pagNum = $(".currentPageNum").val();
            select_box(newpage2);
        }
        function selectbox_before(){
            $(".currentPageNum").val('1');
            select_box(1);
        }
    </script>
    <script type="text/javascript" src="<%=request.getContextPath()%>/asset_admin_new/js/common_stuMsgManage.js"></script>
    <style>
        /*翻页*/
        .pagingTurn .currentPageNum{
            height: 18px !important;
        }
        #class_dlg,#batch_dlg{
            border-color: #1990fe !important;
            background: #fff !important;
            z-index: 10000000000000000000000000000;
            border-width: 2px !important;
        }
        #stuClassName{
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
        body{
            height:100%;
        }
        #dlg{
            left: 50% !important;
            margin-left: -483px;
            padding-bottom: 70px;
            margin-bottom: 20px;
        }
        #userphoto_box{
        }
        #userphoto_box img{
            width:200px !important;
            height:auto !important;
            max-height: 200px !important;
            margin-top: 20px !important;
        }
        .select {
            width: 162px;
            height: 28px;
            border: 1px solid #1990fe;
        }
    </style>
</head>
<body>
<div class="stuMsgManage">
    <!--功能栏-->
    <div class="function">
        <ul>
            <li class="function_new" onclick="Add()"><span>新建</span></li>
            <li class="function_edit" onclick="Edit()"><span>修改</span></li>
            <li class="function_remove" onclick="Delete()"><span>删除</span></li>
            <li class="function_refresh" onclick="refresh_reload()"><span>刷新</span></li>
            <li class="function_search"><span>综合条件查询</span></li>
            <li class="function_import" onclick="batchInsert()"><span>导入学生信息</span></li>
            <%--<li class="function_stuPicture"><span>上传学生照片</span></li>--%>
            <li class="function_downModel" onclick="getModel()"><span>下载模版</span></li>
        </ul>
    </div>
    <!--综合查询部分-->
    <div class="searchContent">
        <div>
            <ul>
                <li>
                    <span>学号:</span>
                    <input type="text" id="StuID" name="StuID"/>
                </li>
                <li>
                    <span>身份证号:</span>
                    <input type="text" id="IdCrad" name="IdCrad"/>
                </li>
                <li>
                    <span>年级:</span>
                    <div>
                        <select id="GradeName" name="GradeName" class="select">
                            <option value="" >请选择</option>
                            <option value="" >全部</option>
                        </select>
                    </div>
                </li>
                <li>
                    <span>寝室楼:</span>
                    <div>
                        <select id="Building" name="Building" class="select">
                            <option value="" >请选择</option>
                            <option value="" >全部</option>
                        </select>
                    </div>
                </li>
                <li>
                    <span></span>
                    <div>
                        <ul>

                        </ul>
                        <span style="display: none"></span>
                    </div>
                </li>
            </ul>
            <ul >
                <li>
                    <span>姓名:</span>
                    <input type="text" id="StuName" name="StuName"/>
                </li>
                <li>
                    <span>手机号:</span>
                    <input type="text"  id="StuPhone" name="StuPhone"/>
                </li>
                <li>
                    <span>所在班级:</span>
                    <div>
                        <select id="ClassName" name="ClassName" class="select">
                            <option value="" >请选择</option>
                            <option value="" >全部</option>

                        </select>
                    </div>
                </li>
                <li>
                    <span>招生类别:</span>
                    <div>
                        <select id="EnroType" name="EnroType" class="select">
                            <option value="" >请选择</option>
                            <option value="" >全部</option>
                        </select>
                    </div>
                </li>
                <li>
                    <span></span>
                    <div>
                        <ul>

                        </ul>
                        <span style="display: none"></span>
                    </div>
                </li>
            </ul>
            <ul>
                <li>
                    <span>性别:</span>
                    <div>
                        <select id="Gender" name="Gender" class="select">
                            <option value="" >请选择</option>
                            <option value="" >全部</option>
                            <option value="男" >男</option>
                            <option value="女" >女</option>
                        </select>
                    </div>
                </li>
                <li>
                    <span>学院:</span>
                    <div>
                        <select id="CollageName" name="CollageName" class="select">
                            <option value="" >请选择</option>
                            <option value="" >全部</option>

                        </select>
                    </div>
                </li>
                <li>
                    <span>培养方式:</span>
                    <div>
                        <select id="TrainMode" name="TrainMode" class="select">
                            <option value="" >请选择</option>
                            <option value="" >全部</option>
                        </select>
                    </div>
                </li>
                <li>
                    <span>学籍状态:</span>
                    <div>
                        <select id="schoolStatus" name="schoolStatus" class="select">
                            <option value="" >请选择</option>
                            <option value="" >全部</option>

                        </select>
                    </div>
                </li>
                <li>
                    <span></span>
                    <div>
                        <ul>

                        </ul>
                        <span style="display: none"></span>
                    </div>
                </li>
            </ul>
            <ul class="lastUl">
                <li>
                    <span>民族:</span>
                    <div>
                        <select id="stuNation" name="stuNation" class="select">
                            <option value="" >请选择</option>
                            <option value="" >全部</option>

                        </select>
                    </div>
                </li>
                <li>
                    <span>专业:</span>
                    <div>
                        <select id="MajorName" name="MajorName" class="select">
                            <option value="" >请选择</option>
                            <option value="" >全部</option>

                        </select>
                    </div>
                </li>
                <li>
                    <span>房间号:</span>
                    <div>
                        <select id="RoomNumber" name="RoomNumber" class="select">
                            <option value="" >请选择</option>
                            <option value="" >全部</option>
                        </select>
                    </div>
                </li>
                <li>
                    <span>学制:</span>
                    <div>
                        <select id="educateLength" name="educateLength" class="select">
                            <option value="" >请选择</option>
                            <option value="" >全部</option>

                        </select>
                    </div>
                </li>
            </ul>
        </div>
        <p>注：因为数据经过加密的关系，所有列出条件均为精确匹配，输入的内容必须和数据库中的一致才可以匹配到结果</p>
        <div class="buttons">
            <span class="clearAll" onclick="clear_search()">清空</span>
            <span class="search" onclick="selectbox_before()">搜索</span>
        </div>
    </div>
    <!--结果集表格-->
    <div class="table">
        <table id="dataTable" border="0" cellspacing="0" cellpadding="0">
            <thead>
            <tr>
                <td></td>
                <td colspan="13" style="text-align: center">学生基本信息</td>
                <%--<td colspan="6" style="text-align: center">学生高校信息</td>--%>
            </tr>
            <tr>
                <td></td>
                <td>学号</td>
                <td>姓名</td>
                <td>性别</td>
                <td>民族</td>
                <td>出生日期</td>
                <td>籍贯</td>
                <td>家庭住址</td>
                <td>邮编</td>
                <td>身份证号</td>
                <td>手机号</td>
                <td>QQ号</td>
                <td>电子邮件</td>
                <td>政治面貌</td>
                <%--<td>所在校区</td>--%>
                <%--<td>入学年份</td>--%>
                <%--<td>学制</td>--%>
                <%--<td>培养方式</td>--%>
                <%--<td>定向单位</td>--%>
                <%--<td>招生类别</td>--%>
            </tr>
            </thead>
            <tbody id="data_domo">

            </tbody>
        </table>
    </div>
    <!--分页-->
    <div class="pagingTurn">
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
    </div>
</div>
<!--弹出框的层-->
<style>
    .inputxt{
        margin-left: 25px;
    }
    #Form li select{
        /*margin-left: -2px;*/
        width: 238px;
        height: 26px;
        border: 1px solid #1990fe;
    }
    #Form li span{
       width:60px;
       font-family: "微软雅黑";
       font-size: 12px;
       color: #1990fe;
    }
    /*新建的弹出窗口*/
    .new{
        position: absolute;
        top: 20px;
        left: 324px;
        z-index: 100;
        width:850px;
        height:900px;
        border: 1px solid #197FFE;
        /*margin: 250px auto;*/
        background-color: #FFFFFF;
        display: none;
    }
</style>
<div class="popup"></div>
<form id="Form" class="demoform" action=""><!--存在为了提交-->
    <div id="dlg" class="new" style="width: 964px" >

        <div class="header">
            <span id="typ">新建</span>
            <span type="reset" class="iconConcel"></span>
        </div>
        <input type="hidden" id="photo_textbox" name="studentPhoto">
        <div id="userphoto_box" style="height: 20px; width: 230px; float: right;">
            <img id="studentPhotos" src="<%=request.getContextPath()%>/Files/Images/default.jpg" onerror="error=null;src='<%=request.getContextPath()%>/Files/Images/default.jpg'" style="width: 180px;height: 200px;margin-right: 300px;">
        </div>
        <ul>
            <li>
                <span>学号:</span>
                <input type="text" id="studentID" name="studentID" datatype="n8-8" nullmsg="请填写学号" errormsg="学号为8位数字" class="inputxt" />
            </li>
            <li>
                <span>姓名:</span>
                <input type="text" id="studentName" name="studentName" datatype="s2-20" nullmsg="请填写姓名"  class="inputxt" />
            </li>
            <li>
                <span>曾用名:</span>
                <input type="text" id="studentUsedName" name="studentUsedName"  class="inputxt" />
            </li>
            <li>
                <span>照片:</span>
                <input id="studentPhoto" name="studentPhotos" type="file" style="border:0" onchange="preview(this)" />
                <%--<input type="hidden"  id="studentImgh" />--%>
            </li>
            <li>
                <span>性别:</span>
                <input type="text" id="studentGender" name="studentGender"  class="inputxt" />
            </li>
            <li>
                <span>民族:</span>
                <input type="text" id="studentNation" name="studentNation"   class="inputxt" />
            </li>
            <li>
                <span>邮编:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span>
                <input type="text" id="studentFamilyPostcode" name="studentFamilyPostcode"   class="inputxt" />
                <span style="margin-left: 100px;width:60px;">籍贯:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span>
                <input type="text" id="studentNativePlace" name="studentNativePlace" datatype="*" nullmsg="请填写籍贯" class="inputxt" />
            </li>
            <li>
                <span>邮件:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span>
                <input type="text" id="studentEmail" name="studentEmail"  class="inputxt" />
                <span style="width:60px;margin-left: 100px;">出生日期:</span>
                <input type="text" id="studentBirthday" name="studentBirthday" onclick="laydate()" datatype="*" nullmsg="请填写出生日期" class="inputxt" />
            </li>
            <li>
                <span>宗教信仰:</span>
                <input type="text" id="faith" name="faith"   class="inputxt" />
                <span style="width:60px;margin-left: 100px;">手机号码:</span>
                <input type="text" id="studentPhone" name="studentPhone" datatype="m" nullmsg="请填写手机号"  class="inputxt" />
            </li>
            <li>
                <span>qq号:</span>
                <input type="text" id="studentQQ" name="studentQQ" class="inputxt" />
                <span style="width:60px;margin-left: 100px;">家庭住址:</span>
                <input type="text" id="studentFamilyAddress" name="studentFamilyAddress" datatype="*" nullmsg="请填写家庭住址" class="inputxt" />
            </li>
            <li>
                <span>外语语种:</span>
                <input type="text" id="foreignLanguage" name="foreignLanguage"  class="inputxt" />
                <span style="width:60px;margin-left: 100px;">身份证号:</span>
                <input type="text" id="studentIdCard" name="studentIdCard" datatype="*17-19|*8-8" nullmsg="请填写身份证号" errormsg="长度为8或17-19" class="inputxt" />
            </li>
            <li>
                <span>政治面貌:</span>
                <input type="text" id="politicsStatus" name="politicsStatus"   class="inputxt" />
                <span style="width:60px;margin-left: 100px;">入党时间:</span>
                <input type="text" id="politicsStatusDate" name="politicsStatusDate" onclick="laydate()"   class="inputxt" />
            </li>
            <li>
                <span>寝室楼号:</span>
                <input type="text" id="usiBuilding" name="usiBuilding"   class="inputxt" />
                <span style="width:60px;margin-left: 100px;">所在专业:</span>
                <select id="stuMajorName" name="stuMajorName" class="inputxt" datatype="*" nullmsg="请选择专业">

                </select>
            </li>

            <li>
                <span>学制:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span>
                <input type="text" id="educationLength" name="educationLength"   class="inputxt" />
                <span style="width:60px;margin-left: 100px;">所在年级:</span>
                <select id="stuGradeName" name="stuGradeName" class="inputxt" datatype="*" nullmsg="请选择年级">

                </select>
            </li>

            <li>
                <span>入学年份:</span>
                <input type="text" id="entranceDate" name="entranceDate"  class="inputxt" />
                <span style="width:60px;margin-left: 100px;">所在班级:</span>
                <select id="stuClassName" name="stuClassName" class="inputxt" datatype="*" nullmsg="请选择班级">

                </select>
            </li>

            <li>
                <span>培养方式:</span>
                <input type="text" id="trainingMode" name="trainingMode"   class="inputxt" />
                <span style="width:60px;margin-left: 100px;">招生类别:</span>
                <input type="text" id="enrollType" name="enrollType"   class="inputxt" />
            </li>

            <li>
                <span>学籍状态</span>
                <input type="text" id="schoolRollStatus" name="schoolRollStatus"   class="inputxt" />
                <span style="width:60px;margin-left: 100px;">房间号码:</span>
                <input type="text" id="usiRoomNumber" name="usiRoomNumber"   class="inputxt" />
            </li>

            <li>
                <span>考号:</span>
                <input type="text" id="ceeNumber" name="ceeNumber"   class="inputxt" />
                <span style="width:60px;margin-left: 100px;">所在省份:</span>
                <input type="text" id="ceeProvince" name="ceeProvince"   class="inputxt" />
            </li>

            <li>
                <span>所在市:</span>
                <input type="text" id="ceeCity" name="ceeCity"   class="inputxt" />
                <span style="width:60px;margin-left: 100px;">所在高中:</span>
                <input type="text" id="ceeHighSchool" name="ceeHighSchool"   class="inputxt" />
            </li>

            <li>
                <span>生源地:</span>
                <input type="text" id="ceeOrigin" name="ceeOrigin"   class="inputxt" />
                <span style="width:60px;margin-left: 100px;">学生干部:</span>
                <input type="text" id="studentLeader" name="studentLeader"   class="inputxt" />
            </li>

        </ul>

        <!--按钮窗口-->
        <div id="dlg-buttons" class="new_buttons">
            <input type="button" value="保存" onclick="Save()"/>
            <input type="reset" value="取消" onclick="close()" />
        </div>
    </div>
</form>
    <%--批量导入对话框--%>
    <div id="batch_dlg"  title="批量导入"  style="display:none;width:400px;height:380px;padding:10px;position:absolute;
    border:3px #c1dadb solid; left:35%;top:25%;background-color:#ffffff">
        <div id="file_box" style="margin-bottom: 10px;margin-top: 10px;">
            <label>选择文件:</label>
            <input id="upfile" style="display: inline-block;width: 200px;" name="fileup" type="file"/>
            <img style="float: right" src="../../../asset_font_new/img/windowclose_03.png" onclick="batchInsertClose()">
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

<!--此js放在要提交表单的下面，放在上面偶尔失效-->
<script>
    //第五处修改，一般不用改，设置表单验证参数，tiptype4种, btnSubmit 提交按钮，ajax是结合我们公司提交方式
    demo = $(".demoform").Validform({
        tiptype:4,
        btnSubmit:"#btn_sub",
        ajaxPost:true

    });
////    内置基本的datatype类型有： * | *6-16 | n | n6-16 | s | s6-18 | p | m | e | url
//    *：检测是否有输入，可以输入任何字符，不留空即可通过验证；
//    *6-16：检测是否为6到16位任意字符；
//    n：数字类型；
//    n6-16：6到16位数字；
//    s：字符串类型；
//    s6-18：6到18位字符串；
//    p：验证是否为邮政编码；
//    m：手机号码格式；
//    e：email格式；
//    url：验证字符串是否为网址。

//    5.2版本之后，datatype支持规则累加或单选。用","分隔表示规则累加；用"|"分隔表示规则多选一，即只要符合其中一个规则就可以通过验证，绑定的规则会依次验证，
//    只要验证通过，后面的规则就会忽略不再比较。如绑定datatype="m|e"，表示既可以填写手机号码，

</script>
</body>
</html>