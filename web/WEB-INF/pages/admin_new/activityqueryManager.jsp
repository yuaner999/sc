<%--
  Created by IntelliJ IDEA.
  User: gq
  Date: 2016/10/25
  Time: 8:45
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java"  pageEncoding="UTF-8" %>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
    <!--兼容360浏览器，防止布局乱，设置IE的文档模式为最高版本，并且如果存在chrome插件，自动使用Webkit引擎-->
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <link rel="stylesheet" href="<%=request.getContextPath()%>/asset_admin_new/css/StuMsgManage.css" />
    <link rel="Shortcut Icon" href="<%=request.getContextPath()%>/asset/image/neu.jpg" type="image/x-icon">
    <script type="text/javascript" src="<%=request.getContextPath()%>/asset_admin_new/js/jquery-1.11.1.min.js"></script>
    <script type="text/javascript" src="<%=request.getContextPath()%>/asset/js/laydate/laydate.js"></script>
    <script type="text/javascript" src="<%=request.getContextPath()%>/asset/js/common.js"></script>
    <script type="text/javascript" src="<%=request.getContextPath()%>/asset_admin_new/js/queryManage.js"></script>
    <!-- 导入layer -->
    <script type="text/javascript" src="<%=request.getContextPath()%>/asset/layer/layer.js"></script>
    <%--引入kindereditor--%>
    <link rel="stylesheet" href="<%=request.getContextPath()%>/asset/kindeditor-4.1.10/themes/default/default.css" />
    <script charset="utf-8" src="<%=request.getContextPath()%>/asset/kindeditor-4.1.10/kindeditor.js"></script>
    <script charset="utf-8" src="<%=request.getContextPath()%>/asset/kindeditor-4.1.10/lang/zh_CN.js"></script>
    <script charset="utf-8" src="<%=request.getContextPath()%>/asset/kindeditor-4.1.10/plugins/code/prettify.js"></script>
    <%--引入表单验证--%>
    <script type="text/javascript" src="<%=request.getContextPath()%>/asset_admin_new/js/Validform_v5.3.2.js"></script>
    <link rel="stylesheet" href="<%=request.getContextPath()%>/asset_admin_new/css/style.css" />
    <link rel="stylesheet" href="<%=request.getContextPath()%>/asset_admin_new/css/demo.css" />
    <%--引入图片上传--%>
    <script type="text/javascript" src="<%=request.getContextPath()%>/asset/js/ajaxfileupload.js"></script>

    <script type="text/javascript" src="<%=request.getContextPath()%>/asset_admin_new/js/managecommon.js"></script>
    <title>第二课堂教师管理界面</title>
    <script>
        //1、第一处修改，修改增删改的请求地址以及deleteId
        var moduleType = GetQueryString("moduleType");//所属模块的ID
        var addUrl = "";
        var editUrl = "";
        var deleteUrl = "";
        var editorName = "null";//KindEditor的Textarea的ID，如果没用到，赋值为null
        var imageUpload = "";//图片上传的标识，如果没有图片上传，赋值为空，如果有，赋值为数据库存放图片名称的字段名称，不带_
        var deleteId = "";//用于删除功能的ID参数，赋值为当前数据库表的ID
        var fileUpload='';
       // var loadUrl = "/jsons/loadactivities.form";
        /**
         * 加载数据
         */
        $(function() {
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
            $(".searchContent").show();
            //综合查询条件：创建者
            $.ajax({
                url: "<%=request.getContextPath()%>/jsons/loadactivityCreator1.form",
                dataType: "json",
                success: function (data) {
                    var friends = $("#_activityCreator");
                    friends.empty();
                    friends.append("<option value=''>请选择</option>");
                    friends.append("<option value=''>全部</option>");
                    if(data.rows !=null && data.rows.length > 0){
                        for(var i=0;i<data.rows.length;i++) {
                            var option = $("<option>").text(data.rows[i].activityCreator).val(data.rows[i].activityCreator);
                            friends.append(option);
                        }
                    }else{
                        var option = $("<option>").text("无");
                        friends.append(option);
                    }
                }
            });
            //综合查询条件：所在校区
            $.ajax({
                url: "<%=request.getContextPath()%>/jsons/loadactivityLocation.form",
                dataType: "json",
                success: function (data) {
                    var friends = $("#_activityLocation");
                    friends.empty();
                    friends.append("<option value=''>请选择</option>");
                    friends.append("<option value=''>全部</option>");
                    if(data.rows !=null && data.rows.length > 0){
                        for(var i=0;i<data.rows.length;i++) {
                            var option = $("<option>").text(data.rows[i].activityLocation).val(data.rows[i].activityLocation);
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
                data:{stuCollageName:''},
                success: function (data) {
                    var friends = $("#_stuCollageName");
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
            $("#_stuCollageName").change(function(){
                //综合查询条件：专业
                $.ajax({
                    url:"<%=request.getContextPath()%>/jsons/loadstuMajorName.form",
                    dataType:"json",
                    data:{stuCollageName:$(this).val()},
                    success:function(data){
                        var friends = $("#_stuMajorName");
                        friends.empty();
                        friends.append("<option value=''>请选择</option>");
                        friends.append("<option value=''>全部</option>");
                        if(data.rows !=null && data.rows.length > 0){
                            for(var i=0;i<data.rows.length;i++) {
                                var option = $("<option>").text(data.rows[i].stuMajorName).val(data.rows[i].stuMajorName);
                                friends.append(option);
                            }
                        }else{
                            var option = $("<option>").text("无");
                            friends.append(option);
                        }
                    }
                });
            })
            $("#_stuMajorName").change(function(){
                //综合查询条件：年级
                $.ajax({
                    url: "<%=request.getContextPath()%>/jsons/loadstuGradeName.form",
                    dataType: "json",
                    data:{stuMajorName:$(this).val()},
                    success: function (data) {
                        var friends = $("#_stuGradeName");
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
            $("#_stuGradeName").change(function(){
                //z综合查询条件：班级
                $.ajax({
                    url: '<%=request.getContextPath()%>/jsons/loadclassnames1.form',
                    dataType: "json",
                    data:{stuGradeName:$(this).val(),collegename:$("#_stuCollageName").val(),stuMajorName:$("#_stuMajorName").val()},
                    success: function (data) {
                        var friends = $("#_stuClassName");
                        friends.empty();
                        friends.append("<option value=''>请选择</option>");
                        friends.append("<option value=''>全部</option>");
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
        });
        /*function refresh_reload(){
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
        function before_reload() {
            page= $(".currentPageNum").val();
            rows = $("#rows").val();
            jsonPara={rows:rows,page:page};
            reload();
        }*/
        function reload(){
            $(".table").show();
            $(".pagingTurn").show();
            load();
            $.ajax({
                url: "<%=request.getContextPath()%>/jsons/loadactivities.form",
                type: "post",
                data: jsonPara,
                dataType: "json",
                success: function (data) {
                    $("#data_domo").html("");
                    if (data != null && data.rows != null && data.rows.length > 0) {
                        for (var i = 0; i < data.rows.length; i++) {
                            var row = data.rows[i];
                            for(var key in row){
                                if(row[key]==null||row[key]=="null"||row[key]=="NULL"){
                                    row[key]="";
                                }
                            }
                            var tr = '<tr id="tr' + (i + 1) + '">' +
                                    '<td>' + (i + 1) + '</td>' +
                                    '<td class="" style="display: none">' + row.activityId + '</td>' +
                                    '<td class="" title="'+ row.activityTitle+'">' + row.activityTitle + '</td>' +
                                    '<td class="" title="'+ row.activityArea+'" style="display: none">' + row.activityArea + '</td>' +
                                    '<td class="" title="'+ row.activityClassMean+'">' + row.activityClassMean + '</td>' +
                                    '<td class="" title="'+ row.activityLevleMean+'">' + row.activityLevleMean + '</td>' +
                                    '<td class="" title="'+ row.activityNatureMean+'" style="display: none">' + row.activityNatureMean + '</td>' +
                                    '<td class="" style="display: none">' + row.activityAwardMean + '</td>' +
                                    '<td class="" title="'+ row.activityLocation+'" style="display: none">' + row.activityLocation + '</td>' +
                                    '<td class="" title="'+ row.activityParticipation+'" style="display: none">' + row.activityParticipation + '</td>' +
                                    '<td class="" title="'+ row.activitySdate+'" style="display: none">' + row.activitySdate + '</td>' +
                                    '<td class="" title="'+ row.activityEdate+'" style="display: none">' + row.activityEdate + '</td>' +
                                    '<td class="" title="'+ row.activityCreator+'" style="display: none">' + row.activityCreator + '</td>' +
                                    '<td class="" >' + row.activityAwardMean + '</td>' +
                                    '<td class="" style="display: none">' + row.activitypoint + '</td>' +
                                    '<td class="" title="'+ row.activityCreatedate+'" style="display: none">' + row.activityCreatedate + '</td>' +
                                    '<td class="" title="'+ row.signUpTime+'" style="display: none">' + row.signUpTime + '</td>' +
                                    '<td class="" title="'+ row.signUpStatus+'" style="display: none">' + row.signUpStatus + '</td>' +
                                    '<td class="" title="'+ row.applyDate+'" style="display: none">' + row.applyDate + '</td>' +
                                    '<td class="" title="'+ row.activityPowers+'">' + row.activityPowers + '</td>' +
                                    '<td class="" title="'+ row.applyStudentId+'" style="display: none">' + row.applyStudentId + '</td>' +
                                    '<td class="" title="'+ row.studentName+'">' + row.studentName + '</td>' +
                                    '<td class="" title="'+ row.stuCollageName+'">' + row.stuCollageName + '</td>' +
                                    '<td class="" title="'+ row.stuClassName+'">' + row.stuClassName + '</td>' +
                                    '<td class="" title="'+ row.stuGradeName+'">' + row.stuGradeName + '</td>' +
                                    '</tr>';
                            $("#data_domo").append(tr);
                            $("#tr" + (i + 1)).data(row);
                        }
                        rowClick();//绑定行点击事件
                        $("tbody tr").bind("click",function() {
                            $("#Form").show();
                            $("#dlg").show();
                        });
                        totalNum = data.total;

                    }else{
                        totalNum=0;
                        $(".currentPageNum").val('1');
                    }
                    paging();
                    disLoad();
                }, error: function () {
                    layer.msg("网络错误");
                    disLoad();
                }
            });


        }
        function btnExcel(){
            document.getElementById("Form1").submit();
        }
    </script>
    <script type="text/javascript" src="<%=request.getContextPath()%>/asset_admin_new/js/common_stuMsgManage.js"></script>
    <style>
        .select {
            width: 162px;
            height: 28px;
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
        .new>ul>li{
            float: left;
        }
        .span_width{
            width:98px;
            margin-left: 35px;
        }
    </style>
</head>
<%--判断是否是登录状态--%>
<%@include file="../common/CheckLogin.jsp"%>
<body>
<div class="stuMsgManage">
    <!--功能栏-->
    <div class="function">
        <ul>
            <li class="function_search"><span>综合条件查询</span></li>
            <li class="function_import" onclick="btnExcel()"><span>导出excel</span></li>
        </ul>
    </div>
    <!--综合查询部分-->
    <form id="Form1"   method="post" action="/export/conditions.form">
    <div class="searchContent">
        <div>
            <ul>
                <li>
                    <span>活动标题:</span>
                    <input type="text" id="_activityTitle"  name="activityTitle"/>
                </li>
                <li>
                    <span>学号:</span>
                    <input type="text" id="_studentID" name="studentID" />
                </li>
                <li>
                    <span>学生姓名:</span>
                    <input type="text" id="_studentName" name="studentName" />
                </li>
                <li>
                    <span>活动类别:</span>
                    <div>
                        <select id="_activityClass" name="activityClass" class="select">
                            <option value="" >请选择</option>
                            <option value="" >全部</option>
                            <option value="思想政治教育类">思想政治教育类</option>
                            <option value="能力素质拓展类">能力素质拓展类</option>
                            <option value="学术科技与创新创业类">学术科技与创新创业类</option>
                            <option value="社会工作与技能培训类">社会工作与技能培训类</option>
                            <option value="社会实践与志愿服务类">社会实践与志愿服务类</option>
                            <option value="其他类">其他类</option>
                        </select>
                    </div>
                </li>
                <li>
                    <span>活动性质:</span>
                    <div>
                        <select id="_activityNature" name="activityNature" class="select">
                            <option value="" >请选择</option>
                            <option value="" >全部</option>
                            <option value="活动参与">活动参与</option>
                            <option value="讲座报告">讲座报告</option>
                            <option value="比赛">比赛</option>
                            <option value="培训">培训</option>
                        </select>
                    </div>
                </li>
            </ul>
            <ul>
                <li>
                    <span>活动级别:</span>
                    <div>
                        <select id="_activityLevle" name="activityLevle" class="select">
                            <option value="" >请选择</option>
                            <option value="" >全部</option>
                            <option value="国际级">国际级</option>
                            <option value="国家级">国家级</option>
                            <option value="省级">省级</option>
                            <option value="市级">市级</option>
                            <option value="校级">校级</option>
                            <option value="院级">院级</option>
                            <option value="团支部级">团支部级</option>
                        </select>
                    </div>
                </li>
                <li>
                    <span>参与形式:</span>
                    <div>
                        <select id="_activityParticipation" name="activityParticipation" class="select">
                            <option value="" >请选择</option>
                            <option value="" >全部</option>
                            <option value="不限">不限</option>
                            <option value="个人">个人</option>
                            <option value="团体">团体</option>
                        </select>
                    </div>
                </li>
                <li>
                    <span>活动开始时间:</span>
                    <input type="" id="_activitySdate" name="activitySdate"   onclick="laydate()"/>
                </li>
                <li>
                    <span>活动结束时间:</span>
                    <input type="" id="_activityEdate" name="activityEdate"   onclick="laydate()"/>
                </li>
                <li>
                    <span>创建人:</span>
                    <div>
                        <select id="_activityCreator" name="activityCreator" class="select">
                            <option value="" >请选择</option>
                            <option value="" >全部</option>
                        </select>
                    </div>
                </li>
            </ul>
            <ul>
                <li>
                    <span>能力标签:</span>
                    <div>
                        <select id="_activityPowers" name="activityPowers" class="select">
                            <option value="" >请选择</option>
                            <option value="" >全部</option>
                            <option value="思辨能力">思辨能力</option>
                            <option value="执行能力">执行能力</option>
                            <option value="表达能力">表达能力</option>
                            <option value="领导能力">领导能力</option>
                            <option value="创新能力">创新能力</option>
                            <option value="创业能力">创业能力</option>
                        </select>
                    </div>
                </li>
                <li>
                    <span>所在学院:</span>
                    <div>
                        <select id="_stuCollageName" name="stuCollageName" class="select">
                            <option value="" >请选择</option>
                            <option value="" >全部</option>
                        </select>
                    </div>
                </li>
                <li>
                    <span>所在专业:</span>
                    <div>
                        <select id="_stuMajorName" name="stuMajorName" class="select">
                            <option value="" >请选择</option>
                            <option value="" >全部</option>
                        </select>
                    </div>
                </li>
                <li>
                    <span>所在年级:</span>
                    <div>
                        <select id="_stuGradeName" name="stuGradeName" class="select">
                            <option value="" >请选择</option>
                            <option value="" >全部</option>
                        </select>
                    </div>
                </li>
                <li>
                    <span>所在班级:</span>
                    <div>
                        <select id="_stuClassName" name="stuClassName" class="select">
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
    </form>
    <!--结果集表格-->
    <div class="table">
        <table id="dataTable" border="0" cellspacing="0" cellpadding="0">
            <thead>
            <tr>
                <td></td>
                <td>活动标题</td>
                <td style="display: none">活动范围</td>
                <td>活动类型</td>
                <td>活动级别</td>
                <td style="display: none">活动性质</td>
                <td style="display: none">获奖情况</td>
                <td style="display: none">活动地点</td>
                <td style="display: none">参与形式</td>
                <td style="display: none">开始日期</td>
                <td style="display: none">结束日期</td>
                <td style="display: none">创建方</td>
                <td style="display: none">申请状态</td>
                <td >获奖情况</td>
                <td style="display: none">活动评分</td>
                <td style="display: none">创建日期</td>
                <td style="display: none">签到日期</td>
                <td style="display: none">签到状态</td>
                <td style="display: none">申请日期</td>
                <td>能力标签</td>
                <td style="display: none">学生学号</td>
                <td>学生姓名</td>
                <td>学院</td>
                <td>班级</td>
                <td>年级</td>
            </tr>
            </thead>
            <tbody id="data_domo">

            </tbody>
        </table>
    </div>
    <form id="Form" class="demoform" action=""><!--存在为了提交-->
        <div id="dlg" class="new">
            <div class="header">
                <span id="tpy">查看详情</span>
                <span type="reset" class="iconConcel"></span>
            </div>
            <ul>
                <%--<li><input style="display:none" name="id"/></li>--%>
                <li>
                    <span class="span_width">学生姓名&nbsp;&nbsp;:&nbsp;&nbsp;&nbsp;&nbsp;</span>
                    <input type="text"  id="studentName" name="studentName"  style="margin-left: 21px;"  class="input_news" />
                </li>
                <li>
                    <span class="span_width">学院&nbsp;&nbsp;:&nbsp;&nbsp;&nbsp;&nbsp;</span>
                    <input type="text" id="stuCollageName" name="stuCollageName"  style="margin-left: 21px;"  class="input_news" />
                </li>
                <li>
                    <span class="span_width">年级&nbsp;&nbsp;:&nbsp;&nbsp;&nbsp;&nbsp;</span>
                    <input type="text" id="stuGradeName" name="stuGradeName"  style="margin-left: 21px;"  class="input_news" />
                </li>
                <li>
                    <span class="span_width">专业&nbsp;&nbsp;:&nbsp;&nbsp;&nbsp;&nbsp;</span>
                    <input type="text" id="stuMajorName" name="stuMajorName"  style="margin-left: 21px;"  class="input_news" />
                </li>
                <li>
                    <span class="span_width">班级&nbsp;&nbsp;:&nbsp;&nbsp;&nbsp;&nbsp;</span>
                    <input type="text" id="stuClassName" name="stuClassName"  style="margin-left: 21px;"  class="input_news" />
                </li>
                <li>
                    <span class="span_width">活动标题&nbsp;&nbsp;:&nbsp;&nbsp;&nbsp;&nbsp;</span>
                    <input type="text" id="activityTitle" name="activityTitle"  style="margin-left: 21px;"  class="input_news" />
                </li>
                <li>
                    <span class="span_width">活动类型&nbsp;&nbsp;:&nbsp;&nbsp;&nbsp;&nbsp;</span>
                    <input type="text" id="activityClassMean" name="activityClassMean"  style="margin-left: 21px;"  class="input_news" />
                </li>
                <li>
                    <span class="span_width">活动级别&nbsp;&nbsp;:&nbsp;&nbsp;&nbsp;&nbsp;</span>
                    <input type="text" id="activityLevleMean" name="activityLevleMean"  style="margin-left: 21px;"  class="input_news" />
                </li>
                <li>
                    <span class="span_width">获奖情况&nbsp;&nbsp;:&nbsp;&nbsp;&nbsp;&nbsp;</span>
                    <input type="text" id="activityAwardMean" name="activityAwardMean"  style="margin-left: 21px;"  class="input_news" />
                </li>
                <li>
                    <span class="span_width">能力标签&nbsp;&nbsp;:&nbsp;&nbsp;&nbsp;&nbsp;</span>
                    <input type="text" id="activityPowers" name="activityPowers"  style="margin-left: 21px;"  class="input_news" />
                </li>
                <li>
                    <span class="span_width">班级审核状态&nbsp;&nbsp;:&nbsp;&nbsp;&nbsp;&nbsp;</span>
                    <input id="regimentAuditStatus" name="regimentAuditStatus" class="select"  readonly="true"/>
                </li>
                <li>
                    <span class="span_width">班级审核时间&nbsp;&nbsp;:&nbsp;&nbsp;&nbsp;&nbsp;</span>
                    <input id="regimentAuditStatusDates" name="regimentAuditStatusDates" class="select"  readonly="true"/>
                </li>
                <li>
                    <span class="span_width">学院审核状态&nbsp;&nbsp;:&nbsp;&nbsp;&nbsp;&nbsp;</span>
                    <input id="collegeAuditStatus" name="collegeAuditStatus" class="select"  readonly="true"/>
                </li>
                <li>
                    <span class="span_width">学院审核时间&nbsp;&nbsp;:&nbsp;&nbsp;&nbsp;&nbsp;</span>
                    <input id="collegeAuditStatusDates" name="collegeAuditStatusDates" class="select"  readonly="true"/>
                </li>
                <li>
                    <span class="span_width">学校审核状态&nbsp;&nbsp;:&nbsp;&nbsp;&nbsp;&nbsp;</span>
                    <input id="schoolAuditStaus" name="schoolAuditStaus" class="select"  readonly="true"/>
                </li>
                <li>
                    <span class="span_width">学校审核时间&nbsp;&nbsp;:&nbsp;&nbsp;&nbsp;&nbsp;</span>
                    <input id="schoolAuditStausDates" name="schoolAuditStausDates" class="select"  readonly="true"/>
                </li>
                <li>
                    <span class="span_width">参与时间&nbsp;&nbsp;:&nbsp;&nbsp;&nbsp;&nbsp;</span>
                    <input id="applyDate" name="applyDate" class="select"  style="margin-left: 21px;" readonly="true"/>
                </li>
                <li id="getScore">
                    <span class="span_width">可得学分&nbsp;&nbsp;:&nbsp;&nbsp;&nbsp;&nbsp;</span>
                    <!--表单验证例子如下 -->
                    <input type="text" id="activityCredit" name="activityCredit"  class="select" style="margin-left: 21px;"/>
                </li>
            </ul>
        </div>
    </form>
    <!--分页-->
    <%@include file="paging.jsp"%>
</div>
<!--弹出框的层-->
<style>
    .inputxt{
        margin-left: 25px;
    }
    #Form li select{
        margin-left: 25px;
        width: 238px;
        height: 26px;
        border: 1px solid #1990fe;
    }
    #Form li span{
       /*width:60px;*/
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
        width:600px;
        height:500px;
        border: 1px solid #197FFE;
        /*margin: 250px auto;*/
        background-color: #FFFFFF;
        display: none;
    }
    .new>ul>li>input{
        margin-left: 0!important;
    }
</style>
<div class="popup"></div>
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