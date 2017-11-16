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
    <script type="text/javascript" src="<%=request.getContextPath()%>/asset/js/queryManager.js"></script>
    <%--引入公共JS--%>
    <%--<script type="text/javascript" src="<%=request.getContextPath()%>/asset/js/common.js"></script>--%>
    <%--<script type="text/javascript" src="<%=request.getContextPath()%>/asset/js/manage/managecommon.js"></script>--%>
    <%--<link rel="stylesheet" href="<%=request.getContextPath()%>/asset/css/common.css" />--%>
<script>
    var rows=25;
    var page=1;
//    $("select").addClass("easyui-combo");
    $(function(){


    //1.活动类别
    pretreatment("#_activityClass","#activityC");
        var activityClass =["思想政治教育类","能力素质拓展类","学术科技与科技创新类","社会实践与志愿服务类","社会工作与技能培训类","其他类"];
        assignSelectInfo(activityClass,"activityClass","activityC");
//
    //2.活动级别
    pretreatment("#_activityLevle","#activityL");
        var activityLevle = ["国际级","国家级","省级","市级","校级","院级","团支部级"];
        assignSelectInfo(activityLevle,"activityLevle","activityL");
    //3.活动性质
    pretreatment("#_activityNature","#activityN");
        var activityNature = ["活动参与","讲座报告","比赛","培训","其它"];
        assignSelectInfo(activityNature,"activityNature","activityN");

    //4.增加能力
    pretreatment("#_activityPowers","#activityP");
        var activityPowers =["思辨能力","执行能力","表达能力","领导能力","创新能力","创业能力"];
        assignSelectInfo(activityPowers,"activityPowers","activityP");

    //5.参与形式
    pretreatment("#_activityParticipation","#activityParticip");
        var activityParticipation = ["不限","团体","个人"];
        assignSelectInfo(activityParticipation,"activityParticipation","activityParticip");

//    6.创建人
        pretreatment("#_activityCreator","#activityCreat");
         $.ajax({
            url:'<%=request.getContextPath()%>/jsons/loadactivityCreator.form',
            dataType:"json",
            success:function(data){
                loadSelectInfo(data,"activityCreator","activityCreat");
            }
        });
//    getInfoByAjax("activityCreator","activityCreat");

        //7.学院
        pretreatment("#_stuCollageName","#stuCollageN");
        $.ajax({
            url:"<%=request.getContextPath()%>/jsons/loadschoolstuCollageName.form",
            dataType:"json",
            success:function(data){
                loadSelectInfo2(data,"stuCollageName","stuCollageN");

            }
        });
        //8.年级
        pretreatment('#_stuGradeName','#stuGradeN');
        $.ajax({
            url:"<%=request.getContextPath()%>/jsons/loadschoolstuGradeName.form",
            dataType:"json",
            success:function(data){
                loadSelectInfo2(data,"stuGradeName","stuGradeN");
            }
        });
        //9.班级
//        pretreatment('#_stuClassName','#stuClassN');
        //让班级可以编辑
        $("#_stuClassName").combo({
            multiple : true
        });
        $("#stuClassN").appendTo($("#_stuClassName").combo('panel'));
        $.ajax({
            url:'<%=request.getContextPath()%>/jsons/loadclassnames1.form',
            dataType:"json",
            success:function(data){
                loadSelectInfo2(data,"stuClassName","stuClassN");
            }
        });
    })


</script>
    <style>
        .text_ {
            display: inline-block;
            width: 250px;
            text-align: left;
            white-space: nowrap;
            margin: 3px 0 3px 0;
            margin-top: 20px;
        }

         .textbox.combo{
             width: 150px !important;
         }
        .item ._left{
            display: inline-block;
            width: 80px;
            text-align: left;
        }
        .textbox{
            width:150px!important;
        }
        .combo-p .panel-body{
            height:auto !important;
            max-height: 198px !important;
        }
        .text_ input.text{
            width:114.1818px!important;
        }
        .datagrid-view{
            display: none;
        }
        .datagrid .datagrid-pager{
            display: none ;
        }
        .item{
            padding: 0px;
        }
        .fitem label {
            text-align: left;
            width: 80px;
            margin-left: 80px;
        }
        .item ._left{
            float: left;
            margin-left: 22px;
        }
        #area{
            width: 435px    ;
        }
    </style>
</head>
<body>
    <%--数据表格--%>
    <table id="dg" class="easyui-datagrid" style="width:100%;min-height:556px;max-height: 100%"
           data-options="pagination:true,
               rownumbers:true,
               singleSelect:true,
               method:'post',
               autoRowHeight:false,
               toolbar:'#tb',
               fitColumns:true,
               <%--2、第二处修改，修改此处的Json服务，用于加载数据--%>
               url:''
               ">
        <thead>
        <tr>
            <%--3、第三处修改，修改此处的列名称，与数据库一致，显示有必要的--%>
            <th field="activityId" hidden >ID</th>
            <th field="activityTitle" width="100px">活动标题</th>
            <th field="activityArea" width="100px">活动范围</th>
            <th field="activityClassMean" width="100px">活动类型</th>
            <th field="activityLevleMean" width="100px">活动级别</th>
            <th field="activityNatureMean" width="100px" >活动性质</th>
            <th field="activityAwardMean" width="100px" hidden>获奖情况</th>
            <th field="activityIsInschool" width="100px" hidden>校内校外</th>
            <th field="activityLocation" width="100px">活动地点</th>
            <th field="activityParticipation" width="100px" >参与形式</th>
            <th field="activitySdate1" width="100px">开始日期</th>
            <th field="activityEdate1" width="100px">结束日期</th>
            <th field="activityCreator" width="100px">创建方</th>
            <th field="applyAuditStatus" width="100px" hidden>申请状态</th>
            <th field="activityAwardMean" width="100px" hidden>获得奖励</th>
            <th field="activitypoint" width="100px" hidden>活动评分</th>
            <th field="activityCreatedate1" width="100px">创建日期</th>
            <th field="signUpTime1" width="100px">签到日期</th>
            <th field="signUpStatus" width="100px" >签到状态</th>
            <th field="applyDate1" width="100px">申请日期</th>
            <th field="activityPowers" width="100px">能力标签</th>
            <th field="studentID" width="100px" >学生学号</th>
            <th field="studentName" width="100px" >学生姓名</th>
            <th field="stuCollageName" width="100px" >学院</th>
            <th field="stuClassName" width="100px" >班级</th>
            <th field="stuGradeName" width="100px" >年级</th>
        </tr>
        </thead>
    </table>
    <%--表格头部按钮--%>
    <div id="tb" style="height:auto">
    <a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-search',plain:true" onclick="searchBy()">综合条件查询</a>
    <a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-save', plain:'true', title:'导出excel文件'" onclick="btnExcel()">导出excel</a>
        <div id="search_condition" style="border-top: 1px solid #eeeeee;margin: 5px 5px 0 5px;padding-top: 10px; float: left;background: #F4F4F4;" >
            <div style="display: inline-block;height: 180px;width: 84%;float: left;border: 1px solid #c0c0c0;padding-bottom: 5px;border-radius: 4px;">
                <form id="search_fm"  method="post" action="/export/conditions.form">
                    <div class="item">
                    <span class="text_"><span class="_flag"></span><span class="_left">活动标题</span>
                    <input class="easyui-textbox input_item" id="_activityTitle"  name="activityTitle"></span>

                        <%--<span class="text_"><span class="_flag"></span><span class="_left">活动范围</span>--%>
                        <%--<select class="easyui-combo" id="_activityArea" name="activityArea" data-options="multiple:true"  ></select>--%>
                        <%--<div id="activityA"></div></span>--%>

                    <span class="text_"><span class="_flag"></span><span class="_left">活动类别</span>
                        <select id="_activityClass" class="easyui-combo"  name="activityClass" data-options="multiple:true"  ></select>
                    <div id="activityC"></div></span>

                    <span class="text_"><span class="_flag"></span><span class="_left">活动级别</span>
                        <select id="_activityLevle" class="easyui-combo"  name="activityLevle" data-options="multiple:true"  ></select>
                    <div id="activityL"></div></span>

                    <span class="text_"><span class="_flag"></span><span class="_left">活动性质</span>
                        <select id="_activityNature" class="easyui-combo"  name="activityNature" data-options="multiple:true"  ></select>
                    <div id="activityN"></div></span>

                    <span class="text_"><span class="_flag"></span><span class="_left">能力标签</span>
                        <select id="_activityPowers" name="activityPowers" class="easyui-combo"  data-options="multiple:true" ></select>
                    <div id="activityP"></div></span>



                    <span class="text_"><span class="_flag"></span><span class="_left">参与形式</span>
                        <select id="_activityParticipation" class="easyui-combo"  name="activityParticipation" data-options="multiple:true"  ></select>
                    <div id="activityParticip"></div></span>

                    <span class="text_"><span class="_flag"></span><span class="_left">创建人</span>
                            <select id="_activityCreator" class="easyui-combo"  name="activityCreator" data-options="multiple:true"  ></select>
                    <div id="activityCreat"></div></span>

                    <span class="text_" id="area"><span class="_left">活动时间范围</span>
                        <input class="easyui-datebox input_item" id="_activitySdate" name="activitySdate">
                         <div style="height: 0px;border:1px solid #000;width: 20px;    margin-bottom: 2px;display: inline-block;"></div>
                        <input class="easyui-datebox input_item" id="_activityEdate" name="activityEdate"></span>

                    <span class="text_"><span class="_flag"></span><span class="_left">学号</span>
                        <input class="easyui-textbox input_item" id="_studentID"  name="studentID"></span>

                    <span class="text_"><span class="_flag"></span><span class="_left">班级</span>
                            <select id="_stuClassName" class="easyui-combo"  name="stuClassName" data-options="multiple:true"  ></select>
                    <div id="stuClassN"></div></span>

                    <span class="text_"><span class="_flag"></span><span class="_left">年级</span>
                            <select id="_stuGradeName" class="easyui-combo"  name="stuGradeName" data-options="multiple:true"  ></select>
                    <div id="stuGradeN"></div></span>

                    <span class="text_"><span class="_flag"></span><span class="_left">学院</span>
                            <select id="_stuCollageName" class="easyui-combo"  name="stuCollageName" data-options="multiple:true"  ></select>
                    <div id="stuCollageN"></div></span>
                        <div style="width: 230px; margin-top: 10px;margin-right: -85px;display: inline-block;float: right;padding-right: 100px;">
                            <a href="javascript:void(0)" class="easyui-linkbutton" style="width:100px;height: 30px;" data-options="iconCls:'icon-no',plain:false" onclick="formreset1()">清空</a>
                            <a href="javascript:void(0)" class="easyui-linkbutton" style="width:100px;height: 30px;margin-left: 10px;" data-options="iconCls:'icon-ok',plain:false" onclick="searchAction1(),showDiv()">搜索</a>
                        </div>
                    </div>
                </form>

            </div>
            <br>
        </div>
    </div>
</body>
</html>