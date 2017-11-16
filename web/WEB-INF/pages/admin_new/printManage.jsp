<%--
  Created by IntelliJ IDEA.
  User: DSKJ005
  Date: 2016/10/31
  Time: 10:24
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java"  pageEncoding="UTF-8" %>
<html>
<head>
    <link rel="Shortcut Icon" href="<%=request.getContextPath()%>/asset/image/neu.jpg" type="image/x-icon">
    <!-- 导入页面控制js jq必须放最上面 -->
    <script type="text/javascript" src="<%=request.getContextPath()%>/asset_admin_new/js/jquery-1.11.1.min.js"></script>
    <script type="text/javascript" src="<%=request.getContextPath()%>/asset_admin_new/js/common_stuMsgManage.js"></script>
    <!-- 导入layer -->
    <script type="text/javascript" src="<%=request.getContextPath()%>/asset/layer/layer.js"></script>
    <!-- 导入样式css -->
    <link rel="stylesheet" href="<%=request.getContextPath()%>/asset_admin_new/css/StuMsgManage.css" />
    <link rel="stylesheet" href="<%=request.getContextPath()%>/asset_admin_new/css/printManage.css" />
    <%--引入公共JS--%>
    <script type="text/javascript" src="<%=request.getContextPath()%>/asset/js/common.js"></script>
    <script type="text/javascript" src="<%=request.getContextPath()%>/asset_admin_new/js/managecommon.js"></script>
    <%--引入表单验证--%>
    <script type="text/javascript" src="<%=request.getContextPath()%>/asset_admin_new/js/Validform_v5.3.2.js"></script>
    <link rel="stylesheet" href="<%=request.getContextPath()%>/asset_admin_new/css/style.css" />
    <link rel="stylesheet" href="<%=request.getContextPath()%>/asset_admin_new/css/demo.css" />
    <%--引入本页自己的js--%>
    <%--<script type="text/javascript" src="<%=request.getContextPath()%>/asset_admin_new/js/printManage.js"></script>--%>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
    <!--兼容360浏览器，防止布局乱，设置IE的文档模式为最高版本，并且如果存在chrome插件，自动使用Webkit引擎-->
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <title>打印申请管理</title>
    <script type="text/javascript">
        var moduleType = GetQueryString("moduleType");//所属模块的ID，不可以删除
        //1、第一处修改，修改增删改的请求地址
        var addUrl = "";
        var editUrl = "";
        var deleteUrl = "";
        var editorName = "null";//KindEditor的Textarea的ID，如果没用到，赋值为null
        var imageUpload = "";//图片上传的标识，如果没有图片上传，赋值为空，如果有，赋值为数据库存放图片名称的字段名称，不带_
        var deleteId = "";//用于删除功能的ID参数，赋值为当前数据库表的ID
        var editId = "";//用于修改功能的ID参数，赋值为当前数据库表的ID
        var loadUrl = "/printBack/loadPrint.form";//注：此处为新增
        var sqlStr = "";//注：模糊查询
        var jsonPara;//参数

        $(function(){
            before_reload();
            //绑定跳页Enter键
            $(".currentPageNum").keyup(function(e){
                var pagNum = $(".currentPageNum").val();
                if(e.keyCode==13){
                    select_box(pagNum);
                }
            });
            $(".table").hide();
            $(".pagingTurn").hide();
            $(".searchContent").show();
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
                url:"<%=request.getContextPath()%>/jsons/loadstuCollageName.form",
                dataType:"json",
                data:{stuCollageName:''},
                success:function(data){
                    var friends = $("#CollageName");
                    friends.empty();
                    friends.append("<option value=''>请选择</option>");
                    friends.append("<option value=''>全部</option>");
                    if(data.rows !=null && data.rows.length > 0){
                        for(var i=0;i<data.rows.length;i++) {
                            var option = $("<option>").text(data.rows[i].stuCollageName).val(data.rows[i].stuCollageName);
                            friends.append(option);
                        }
                    }else{
                        var option = $("<option>").text("无");
                        friends.append(option);
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
                        if(data.rows !=null && data.rows.length > 0) {
                            var friends = $("#MajorName");
                            friends.empty();
                            friends.append("<option value=''>请选择</option>");
                            friends.append("<option value=''>全部</option>");
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
            //z综合查询条件：班级
            $("#GradeName").change(function() {
                $.ajax({
                    url: '<%=request.getContextPath()%>/jsons/loadclassnames1.form',
                    dataType: "json",
                    data: {stuGradeName: $(this).val()},
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
            $(".table").show();
            $(".pagingTurn").show();
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
                                if(!row[key] || row[key]=="null"){
                                    row[key]="";
                                }
                            }
                            var tr = '<tr id="tr'+(i+1)+'">'+
                                    '<td>'+(i+1)+'</td>'+
                                        //第二处修改：按照数据库列名进行拼穿
                                    '<td class="studentId">'+row.studentId+'</td>'+
                                    '<td class="studentName">'+row.studentName+'</td>'+
                                    '<td class="className">'+row.stuClassName+'</td>'+
                                    '<td class="studentPhone">'+row.studentPhone+'</td>'+
//                                    '<td class="printAuditstatus">'+row.printAuditstatus+'</td>'+
//                                    '<td class="printAuditdate">'+row.printAuditdate+'</td>'+
//                                    '<td class="printStatus">'+row.printStatus+'</td>'+
//                                    '<td class="printDate">'+row.printDate+'</td>'+
//                                    '<td class="createDate">'+row.createDate+'</td>'+
                                    '<td class="printId" >'+row.printId+'</td>'+
                                    '</tr>';
                            $("tbody").append(tr);
                            $("#tr"+(i+1)).data(row);//存入data为后台修改时取数据
                        }
                        rowClick();//绑定行点击事件
                        totalNum=data.total;

                    }else{
                        page=0;
                        totalNum=0;
                        $(".currentPageNum").val('0');
                    }
                    paging();
                }, error: function () {
                    layer.msg("网络错误");
                }
            })
            disLoad();
        }
        //分页加载
        function paging(){
            if($(".currentPageNum").val()==0){
                $(".currentPageNum").val("1");
            }
            page= $(".currentPageNum").val();
            rows = $("#rows").val();
            $(".pageNum").eq(0).html(Math.ceil( totalNum/rows));
            $(".pageNum").eq(3).html(totalNum);
            if(totalNum<=0){
                $(".currentPageNum").val("0");
                page=$(".currentPageNum").val("0");
                $(".pageNum").eq(2).html(0);
                $(".pageNum").eq(1).html(0);
            }else if(totalNum<page*rows){
                $(".pageNum").eq(2).html(totalNum);
                $(".pageNum").eq(1).html(rows*(page-1)+1);
            }else{
                $(".pageNum").eq(2).html(page*rows);
                $(".pageNum").eq(1).html(rows*(page-1)+1);
            }
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
            if(isCondition=='true'){
                select_box(pagNum);
            }else if(isCondition=='searchM'){
                Search(pagNum);
            }else if(isCondition=='searchC'){
                searchIn(pagNum);
            }else{
                before_reload();
            }
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
            if(isCondition=='true'){
                select_box(pagNum);
            }else if(isCondition=='searchM'){
                Search(pagNum);
            }else if(isCondition=='searchC'){
                searchIn(pagNum);
            }else{
                before_reload();
            }
        }
        //回车事件
        document.onkeydown=function(event){
            var e = event || window.event || arguments.callee.caller.arguments[0];
            if(e && e.keyCode==13){ // enter 键
                reload();
            }
        };
        //综合查询
        function select_box(page) {
            isCondition='true';
            var jsonObject = $(".searchContent").serializeObject();
            jsonObject["studentID"] = $("#StuID").val();
            jsonObject["studentIdCard"] = $("#IdCrad").val();
            jsonObject["studentName"] = $("#StuName").val();
            jsonObject["studentPhone"] = $("#StuPhone").val();
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
//            console.log(jsonObject);
            jsonPara=jsonObject;
            $('.searchContent').slideUp();
            reload();
        }
        //清空
        function clear_search(){
            $("#StuID").val("");
            $("#IdCrad").val("");
            $("#StuName").val("");
            $("#StuPhone").val("");
            $("#GradeName").val("");
            $("#Building").val("");
            $("#TrainMode").val("");
            $("#RoomNumber").val("");
            $("#EnroType").val("");
            $("#Gender").val("");
            $("#CollageName").val("");
            $("#schoolStatus").val("");
            $("#stuNation").val("");
            $("#MajorName").val("");
            $("#ClassName").val("");
            $("#educateLength").val("");
        }

        function printAction1(){
//            console.log(rowdata);
            if(!rowdata) {
                layer.msg("请先选择一行数据！")
                return;
            }
            var status=rowdata.printAuditstatus;
            //审核功能不要了

//            if(status!="已通过"){
//                layer.msg("必须是通过审核的申请才能打印！")
//                return;
//            }

                    var studentid=rowdata.studentId;
                    var printid=rowdata.printId;
                    window.open("/views/font/A4.form?studentID="+studentid+"&Enigmatic="+printid,"_blank");
//                    layer.load(1,{shade:[0.4,'#000000']});
//                    var printid=rowdata.printId;
//                    $.ajax({
//                        url:"/printBack/changePrintstatus.form",
//                        type:"post",
//                        dataType:"json",
//                        data:{printid:printid},
//                        success:function(data){
//                            if(data.status==0){
//                                reload();
//                            }
//                            layer.closeAll();
//                            layer.msg(data.msg);
//                        },
//                        error:function(){
//                            layer.closeAll();
//                            layer.msg("服务器连接失败，请与管理员联系");
//                        }
//                    })

        }
        //审核通过/未通过
        function auditAction1(action){
         var row=rowdata;
            if(!row) {
                layer.msg("请先选择一行数据！")
                return;
            }
            var status=row.printAuditstatus;
//            console.log(status)
            if(status!="待审核"){
                layer.msg("已审核过的打印申请不可以再次审核！")
                return;
            }

            layer.confirm('确认此操作吗?，此操作不可恢复!', function(result) {
                if (result) {
                    var printid=row.printId;
                    layer.load(1,{shade:[0.4,'#000000']});
                    $.ajax({
                        url:"/printBack/changeAuditstatus.form",
                        type:"post",
                        dataType:"json",
                        data:{printid:printid,status:action},
                        success:function(data){
                            if(data.status==0){
                                reload();
                            }
                            layer.closeAll();
                            layer.msg(data.msg);
                        },
                        error:function(){
                            layer.closeAll();
                            layer.msg("服务器连接失败，请与管理员联系");
                        }
                    })
                }
            });
        }
    </script>
    <style type="text/css">
        .select {
            width: 162px;
            height: 28px;
            border: 1px solid #1990fe;
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
            <li class="function_search"><span>综合条件查询</span></li>
            <%--<li class="function_new function_auditPass" onclick="auditAction1('已通过')"><span>审核通过</span></li>--%>
            <%--<li class="function_edit function_auditNotPass" onclick="auditAction1('未通过')"><span>审核未通过</span></li>--%>
            <li class="function_remove function_paintGrade" onclick="printAction1()"><span>查看成绩单</span></li>
        </ul>
        <p>打印成绩单：在新打开的窗口中点击鼠标右键--打印，或者是按ctrl+p 键，来打开打印对话框，然后选择打印机并打印。</p>
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
                        <span>培养方式:</span>
                        <div>
                            <select id="TrainMode" name="TrainMode" class="select">
                                <option value="" >请选择</option>
                                <option value="" >全部</option>
                            </select>
                        </div>
                    </li>
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
                    <%--<li>--%>
                        <%--<span>学院:</span>--%>
                        <%--<div>--%>
                            <%--<select id="CollageName" name="CollageName" class="select">--%>
                                <%--<option value="" >请选择</option>--%>
                                <%--<option value="" >全部</option>--%>

                            <%--</select>--%>
                        <%--</div>--%>
                    <%--</li>--%>
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
                        <span>学制:</span>
                        <div>
                            <select id="educateLength" name="educateLength" class="select">
                                <option value="" >请选择</option>
                                <option value="" >全部</option>

                            </select>
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
                </ul>
            </div>
            <p></p>
            <div class="buttons">
                <span class="clearAll" onclick="clear_search()">清空</span>
                <span class="search" onclick="select_box(1)">搜索</span>
            </div>
        </div>
    <!--结果集表格-->
    <div id="dg" class="table">
        <table border="0" cellspacing="0" cellpadding="0">
            <thead>
            <tr>
                <td></td>
                <td>学号</td>
                <td>姓名</td>
                <td>班级</td>
                <td>电话</td>
                <%--<td>打印申请审核状态</td>--%>
                <%--<td>审核日期</td>--%>
                <%--<td>打印状态</td>--%>
                <%--<td>打印日期</td>--%>
                <td>打印id</td>
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
