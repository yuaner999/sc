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
    <%--引入公共JS--%>
    <script type="text/javascript" src="<%=request.getContextPath()%>/asset_admin_new/js/jquery-1.11.1.min.js"></script>
    <script type="text/javascript" src="<%=request.getContextPath()%>/asset/js/common.js"></script>
    <script type="text/javascript" src="<%=request.getContextPath()%>/asset_admin_new/js/managecommon.js"></script>
    <script type="text/javascript" src="<%=request.getContextPath()%>/asset_admin_new/js/common_stuMsgManage.js"></script>
    <!-- 导入layer -->
    <script type="text/javascript" src="<%=request.getContextPath()%>/asset/layer/layer.js"></script>
    <%--引入本页自己的js--%>
    <script type="text/javascript" src="<%=request.getContextPath()%>/asset_admin_new/js/sixelementpoint.js"></script>
    <link rel="stylesheet" href="<%=request.getContextPath()%>/asset_admin_new/css/sixelementpoint.css" />
    <!-- 导入样式css -->
    <link rel="stylesheet" href="<%=request.getContextPath()%>/asset_admin_new/css/StuMsgManage.css" />
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
        var loadUrl = "";//注：此处为新增
        var sqlStr = "";//注：模糊查询
        var jsonPara;//参数
        var studentId ;
        $(function(){
            //绑定跳页Enter键
            $(".currentPageNum").keyup(function(e){
                var pagNum = $(".currentPageNum").val();
                if(e.keyCode==13){
                    select_box(pagNum);
                }
            });
           // before_reload();
            $(".table").hide();
            $(".pagingTurn").hide();
            $(".refresh").hide();
            $(".searchContent").show();
            //综合查询条件：年级
            $.ajax({
                url: "<%=request.getContextPath()%>/jsons/loadschoolstuGradeName.form",
                dataType: "json",
                success: function (data) {
                    var friends = $("#_stuGradeName");
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
            //综合查询条件：学院
            $.ajax({
                url: "<%=request.getContextPath()%>/jsons/loadschoolstuCollageName.form",
                dataType: "json",
                success: function (data) {
                    var friends = $("#_stuCollageName");
                    friends.empty();
                    friends.append("<option value=''>请选择</option>");
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

            <%--//z综合查询条件：班级--%>
            <%--$.ajax({--%>
                <%--url: '<%=request.getContextPath()%>/jsons/loadclassnames1.form',--%>
                <%--dataType: "json",--%>
                <%--success: function (data) {--%>
                    <%--var friends = $("#_stuClassName");--%>
                    <%--friends.empty();--%>
                    <%--friends.append("<option value=''>请选择</option>");--%>
                    <%--if(data.rows !=null && data.rows.length > 0){--%>
                        <%--for(var i=0;i<data.rows.length;i++) {--%>
                            <%--var option = $("<option>").text(data.rows[i].stuClassName).val(data.rows[i].stuClassName);--%>
                            <%--friends.append(option);--%>
                        <%--}--%>
                    <%--}else{--%>
                        <%--var option = $("<option>").text("无");--%>
                        <%--friends.append(option);--%>
                    <%--}--%>
                <%--}--%>
            <%--});--%>

//            //表格的行 活动标题   被鼠标移入的时候的事件
//            $("#tbody1").on("mouseover",".activityTitle span",function(e){
////                $(".mouse_following_msg").css("top", e.pageY+5);
////                $(".mouse_following_msg").css("left", e.pageX+5);
////                $(".mouse_following_msg").fadeIn(700);
////                console.log(1);
//            });
//            //表格的行  活动标题  被鼠标移出的时候的事件
//            $("#tbody1").on("mouseout",".activityTitle span",function(e){
////                 $(".mouse_following_msg").fadeOut(700);
////                console.log(33);
//            });
        });
        //根据学院加载下拉选
        function changeColl(){
            var strvalue=$("#_stuCollageName").val();
            $.ajax({
                url:"/jsons/loadclassnames1.form",
                type:"post",
                data:{collegename:strvalue},
                dataType:"json",
                success:function(data){
                    var friends = $("#_stuClassName");
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
        }
        function  reload() {//此处加载数据方法名不能修改，必须用reload
            load();
//            console.log(jsonPara)
            $.ajax({
                url: "/sixpoint/sixpoint.form",
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
                                    '<td class="studentName " title="'+row.studentName+'">'+row.studentName+'</td>'+
                                    '<td class="pointYear ">'+row.pointYear+'</td>'+
                                    '<td class="sibian ">'+row.sibian+'</td>'+
                                    '<td class="zhixing ">'+row.zhixing+'</td>'+
                                    '<td class="biaoda " >'+row.biaoda+'</td>'+
                                    '<td class="lingdao " >'+row.lingdao+'</td>'+
                                    '<td class="chuangxin ">'+row.chuangxin+'</td>'+
                                    '<td class="chuangye " >'+row.chuangye+'</td>'+
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
        function Details(){
            if(clickStatus!=""){
                studentId = rowdata.studentID;
                page = 1;rows = 10;
                page1=1;
                $("#page1").text(1);
//                console.log(studentId);
                document.getElementById("Form").reset();
                $('.popup').height($(document).height());
                $('.popup').css('background-color', '#a1a1a1').slideDown(200);
                $('.dialog').slideDown(400);
                loadActivityPointCount(studentId);
            }else{
                layer.msg("请选择一条数据");
            }
        }
        function loadActivityPointCount(stu_Id){
            $.ajax({
                url:"/jsons/loadActivityPointCount.form",//走的controller
                type:"post",
                data:{rows:rows1,page:page1,stuid:stu_Id},
                dataType: "json",
                success: function (data) {
//                    console.log(data);
                    $("#tbody1").html("");
                    if (data != null && data.rows != null && data.rows.length > 0) {
                        for (var i = 0; i < data.rows.length; i++) {
                            var row = data.rows[i];
                            var otherActivityPoint=row.otherActivityPoint;
                            if(row.otherActivityPoint==null){
                                otherActivityPoint="";
                            }
                            var activityAwardMean=row.activityAwardMean;
                            if(row.activityAwardMean==null){
                                activityAwardMean="";
                            }
                            var tr = '<tr id="tr'+(i+1)+'">'+
                                    '<td>'+(i+1)+'</td>'+
                                        //第二处修改：按照数据库列名进行拼穿
                                    '<td class="activityTitle "><span title="'+title_msg(row)+'">'+activityTitleFormat(row)+'</span></td>'+
                                    '<td class="total point_ele">'+row.totalPoint+'</td>'+
                                    '<td class="biaoda point_ele">'+row.biaoda+'</td>'+
                                    '<td class="zhixing point_ele">'+row.zhixing+'</td>'+
                                    '<td class="sibian point_ele" >'+row.sibian+'</td>'+
                                    '<td class="lingdao point_ele" >'+row.lingdao+'</td>'+
                                    '<td class="chuangxin point_ele" >'+row.chuangxin+'</td>'+
                                    '<td class="chuangye point_ele" >'+row.chuangye+'</td>'+
                                    '</tr>';
                            tr=tr.replace(/null/g,"");
                            $("#tbody1").append(tr);
                            $("#tbody1 tr:last").data(row);
                        }
//                        rowClick();//绑定行点击事件
                        totalNum1=data.total;


                    }else{
                        var tr= '<tr">'+
                                '<td ></td>'+
                                '<td colspan="7">未查询到数据</td>'+
                                '</tr>';
                        $("#tbody1").append(tr);
                        totalNum1=0;
                        page1=0;
                        $("#page1").text(0);
                    }
                    paging1();

                },
                error: function () {
                    layer.msg("网络错误");
                }
            })
        }
        /**
         * 六项能力得分详情的标题取值
         * @param row
         * @returns {Document.activityTitle|*}
         */
        function activityTitleFormat(row){
            var title=row.activityTitle;
            if(!title){
                title=row.supActivityTitle;
                if(!title){
                    title=row.workName;
                    if(!title){
                        title=row.scienceName;
                        if(!title){
                            title=row.shipName;
                        }
                    }
                }
            }
            return title;
        }

        /**
         * 拼接活动标题的title 信息
         */
        function title_msg(row){
            var title=row.activityTitle;
            var act_class=row.activityClassMean;
            var act_nature=row.activityNatureMean;
            var act_lvl=row.activityLevleMean;
            var act_award=row.activityAward;
            if(!title){
                title=row.supActivityTitle;
                var act_class=row.supClassMean;
                var act_nature=row.supNatureMean;
                var act_lvl=row.supLevleMean;
                var act_award=row.supAward;
                if(!title){
                    title=row.workName;
                    act_class="学生干部任职";
                    act_lvl=row.orgname;
                    if(!title){
                        title=row.scienceName;
                        act_class=row.scienceClass;
                        if(!title){
                            title=row.shipName;
                            act_class=row.shipType;
                        }
                    }
                }
            }
            if(!act_class) act_class="";
            var time=row.applyDate;
            if(!time){
                time=row.takeDate;
            }
            var date=new Date(time);
            var datestr=date.getFullYear()+"-"+(date.getMonth()+1)+"-"+date.getDate();
            return  act_class+"  "+act_lvl+"   "+act_nature+"   "+title+"   "+act_award+"   "+datestr;
        }
        //综合查询
        function select1() {
            isCondition='true';
            var jsonObject = $("#Form1").serializeObject();
            page =1 ;
            $(".currentPageNum").val(1) ;
            $(".table").show();
            $(".pagingTurn").show();
            $('.searchContent').slideUp();
//            console.log(jsonObject);
            before_reload(jsonObject);
        }
        //before_reload :加载前rows和page参数处理
        function before_reload(jsonObject){
            page= $(".currentPageNum").val();
            rows = $("#rows").val();
            if(page>(totalNum%rows==0?totalNum/rows:totalNum/rows+1)){//进行判断，避免选择rows时出现错误
                page = 1;$(".currentPageNum").val(1);
            }
            jsonObject['rows']=rows;
            jsonObject['page']=page;
            jsonPara=jsonObject;
            reload();
        }
    </script>
    <style type="text/css">
        table{
            border-collapse: collapse;
        }
        .select {
            width: 178px;
            height: 26px;
            border: 1px solid #1990fe;
        }
        .searchContent>div>ul>li>div>span {
            display: inline-block;
            position: absolute;
            z-index: 10;
            right: 0;
            top: 0;
            width: 30px;
            height: 25px;
        }
        thead>tr>td{
            min-width: 136px;
        }
        .dialog{
            top:10px !important;
            height: 600px !important;
        }
        .six_detail td{
            width: 50px;
        }
        .six_detail td:nth-child(2){
            width: 220px;
        }
        .activityTitle span{
            display: inline-block;
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
            <li class="function_search"><span>综合条件查询</span></li>
            <li class="function_edit" onclick="Details()"><span>查看详情</span></li>
        </ul>
    </div>
        <!--综合查询部分-->
        <form id="Form1">
            <div class="searchContent" >
                <div>

                    <ul>
                        <li>
                            <span>学号:</span>
                            <input type="text" id="_studentID" name="studentID"  style="border: 1px solid #1990fe;width:178px;height:22px;margin-left: 84px;"/>
                        </li>
                        <li>
                            <span>学生姓名:</span>
                            <input type="text" id="_studentName" name="studentName" style="border: 1px solid #1990fe;width:178px;height:22px;margin-left: 84px;"/>
                        </li>
                        <li>
                            <span>所在学院:</span>
                            <div>
                                <select id="_stuCollageName" name="stuCollageName" class="select" onchange="changeColl()">

                                </select>
                            </div>
                        </li>
                    </ul>
                    <ul>

                        <li>
                            <span>所在班级:</span>
                            <div>
                                <select id="_stuClassName" name="stuClassName" class="select">
                                    <option value=''>请选择</option>
                                </select>
                            </div>
                        </li>
                        <li>
                            <span>所在年级:</span>
                            <div>
                                <select id="_stuGradeName" name="stuGradeName" class="select">

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

                </div>
                <p></p>
                <div class="buttons">
                    <span class="clearAll" onclick="clear_search()">清空</span>
                    <span class="search" onclick="select1()">搜索</span>
                </div>
            </div>
        </form>
    <!--结果集表格-->
    <div id="dg" class="table">
        <table border="0" cellspacing="0" cellpadding="0">
            <thead>
        <tr>
            <td></td>
            <td>学生姓名</td>
            <td>年份</td>
            <td>思辨能力得分</td>
            <td>执行能力得分</td>
            <td>表达能力得分</td>
            <td>领导能力得分</td>
            <td>创新能力得分</td>
            <td>创业能力得分</td>

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
        <span id="tpy">查看详情</span>
        <span type="reset" class="iconConcel"></span>
    </div>

        <ul>
            <li>
                <span>活动标题&nbsp;&nbsp;:&nbsp;&nbsp;&nbsp;&nbsp;</span>
                <input type="text" id="activityTitle" name="activityTitle"  />
            </li>
            <li>
                <span>活动级别&nbsp;&nbsp;:&nbsp;&nbsp;&nbsp;&nbsp;</span>
                <input type="text" id="activityLevleMean" name="activityLevleMean"  />
            </li>
            <li>
                <span>活动类型&nbsp;&nbsp;:&nbsp;&nbsp;&nbsp;&nbsp;</span>
                <input type="text" id="activityNatureMean" name="activityNatureMean"  />
            </li>
            <li>
                <span>参与形式&nbsp;&nbsp;:&nbsp;&nbsp;&nbsp;&nbsp;</span>
                <input type="text" id="activityParticipation" name="activityParticipation"  />
            </li>
            <li>
                <span>获奖情况&nbsp;&nbsp;:&nbsp;&nbsp;&nbsp;&nbsp;</span>
                <input type="text" id="activityAwardMean" name="activityAwardMean"  />
            </li>
            <li>
                <span>能力标签&nbsp;&nbsp;:&nbsp;&nbsp;&nbsp;&nbsp;</span>
                <input type="text" id="activityPowers" name="activityPowers"  />
            </li>
            <li>
                <span>其他类活动得分&nbsp;&nbsp;:&nbsp;&nbsp;&nbsp;&nbsp;</span>
                <input type="text" id="otherActivityPoint" name="otherActivityPoint"  />
            </li>

        </ul>

<!--按钮窗口-->
    <div id="dlg-buttons" class="new_buttons">
        <input type="button" value="取消" onclick="close()" />
    </div>

</div>
<!--重新加载活动方法-->
<div id="dialog" class="dialog">
        <div class="header">
            <span>&nbsp;&nbsp;活动加分详情</span>
            <img style="float: right;position:relative;top:15px;right:15px" src="../../../asset_font_new/img/windowclose_03.png" onclick="close2()">

        </div>
        <div class="messagePage table" >
            <table class="six_detail">
                <thead>
                <tr>
                    <td></td>
                    <td>活动标题</td>
                    <td>总分</td>
                    <td>表达</td>
                    <td>执行</td>
                    <td>思辨</td>
                    <td>领导</td>
                    <td>创新</td>
                    <td>创业</td>
                </tr>

                </thead>
                <tbody id="tbody1">

                </tbody>

            </table>
            <%--<div class="pagingTurn">--%>
                <%--<div>--%>
                    <%--<span class="turn_left" onclick="turn_left1()"></span> 第--%>
                    <%--<span class="currentPageNum">1</span> 页，共--%>
                    <%--<span class="pageNum1"></span> 页--%>
                    <%--<span class="turn_right" onclick="turn_right1()"></span>--%>
                <%--</div>--%>
                <%--<div>--%>
                    <%--<select id="rows1" name="rows" onchange="loadActivity()">--%>
                        <%--<option value="10" selected>10</option>--%>
                        <%--<option value="20">20</option>--%>
                        <%--<option value="50">50</option>--%>
                        <%--<option value="100">100</option>--%>
                    <%--</select>--%>
                <%--</div>--%>

                <%--<div>--%>
                    <%--显示<span class="pageNum1"></span>到<span class="pageNum1"></span>，共<span class="pageNum1"></span>条记录--%>
                <%--</div>--%>
            <%--</div>--%>
            <div class="pagingTurn">
                <div>
                    <span class="turn_left" onclick="turn_left1()"></span> 第
                    <span id="page1" class="currentPageNum" value="1">1</span> 页，共
                    <span id="p0" class="pageNum1" ></span> 页
                    <span class="turn_right" onclick="turn_right1()"></span>
                </div>
                <div>
                    显示<span id="p1" class="pageNum1"></span>到<span id="p2" class="pageNum1"></span>，共<span id="p3" class="pageNum1"></span>条记录
                </div>
            </div>
        </div>

        <!--按钮窗口-->
        <div class="new_buttons">
            <%--<input type="button"  value="提交" onclick="commit()"  />--%>
            <input type="reset" value="取消" onclick="close2()" />
        </div>
</div>
</form>
</body>
</html>