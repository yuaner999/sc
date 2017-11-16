<%--
  Created by IntelliJ IDEA.
  User: admin
  Date: 2016/9/10
  Time: 17:08
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java"  pageEncoding="UTF-8" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01//EN"
"http://www.w3.org/TR/html4/strict.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" lang="en">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
    <!--兼容360浏览器，防止布局乱，设置IE的文档模式为最高版本，并且如果存在chrome插件，自动使用Webkit引擎-->
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <title>东北大学共青团“第二课堂成绩单”B面</title>
    <link rel="Shortcut Icon" href="<%=request.getContextPath()%>/asset/image/neu.jpg" type="image/x-icon">
    <script type="text/javascript" src=" <%=request.getContextPath()%>/asset_font/js/jquery-1.11.1.min.js"></script>
    <link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/asset_font_new/css/common.css"/>
    <link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/asset_font_new/css/commonhead.css"/>
    <link rel="stylesheet" href="<%=request.getContextPath()%>/asset_font/css/reportCard_B.css" type="text/css" />
    <%--<script type="text/javascript" src="/asset_font/js/reportCard_B.js"></script>--%>
    <!-- 引入 echarts.js -->
    <script type="text/javascript" src="<%=request.getContextPath()%>/asset_mobile/js/echarts.min.js"></script>
    <script src="<%=request.getContextPath()%>/asset_font_new/js/jquery.dotdotdot.js" type="text/javascript" charset="utf-8"></script>
    <script src="<%=request.getContextPath()%>/asset_font_new/js/common.js" type="text/javascript" charset="utf-8"></script>
    <script src="<%=request.getContextPath()%>/asset_font_new/js/respond.js" type="text/javascript" charset="utf-8"></script>
    <script src="<%=request.getContextPath()%>/asset_font_new/js/index.js" type="text/javascript" charset="utf-8"></script>
    <script type="text/javascript">
        $(function(){
            //加载个人信息
            $.ajax({
                url:"/jsons/loadInfor.form",
                type:"post",
                datatype:"json",
                success:function(data){
                    var row = data.rows[0];
//                    console.log(row);
                    $("#sname").html(row.studentName);
                    $("#scoll").html(row.collegeName);
                    $("#smaj").html(row.majorName);
                    $("#scla").html(row.className);
                    $("#sid").html(row.studentID);
                    $("#spho").html(row.studentPhone);
                    var str = '<img class="person_picture" src=/Files/Images/'+row.studentPhoto+'>';
                    $("#sphoto1").prepend(str);
                }

            });
        });
    </script>
</head>
<body>
<h3>东北大学共青团 "第二课堂成绩单"</h3>
<div class="secondClassMsgContent">
    <!--个人能力分析-->
    <div class="person_analyze">
        <!--个人信息板块-->
        <div id="sphoto1" class="person_MsgContent">
            <%--<img  class="person_picture" src=" <%=request.getContextPath()%>/asset_font/img/person_picture.png" />--%>
            <%--<input class="change_filepicture" type="file" />--%>
            <ul class="person_msg">
                <li class="person_msg_item">
                    <label class="person_msg_style person_msg_type">姓名&nbsp;:&nbsp;</label>
                    <span class="person_msg_style" id="sname"></span>
                </li>
                <li class="person_msg_item">
                    <label class="person_msg_style person_msg_type">学院&nbsp;:&nbsp;</label>
                    <span class="person_msg_style" id="scoll"></span>
                </li>
                <li class="person_msg_item">
                    <label class="person_msg_style person_msg_type">专业&nbsp;:&nbsp;</label>
                    <span class="person_msg_style" id="smaj"></span>
                </li>
                <li class="person_msg_item">
                    <label class="person_msg_style person_msg_type">班级&nbsp;:&nbsp;</label>
                    <span class="person_msg_style" id="scla"></span>
                </li>
                <li class="person_msg_item">
                    <label class="person_msg_style person_msg_type">学号&nbsp;:&nbsp;</label>
                    <span class="person_msg_style" id="sid"></span>
                </li>
                <li class="person_msg_item">
                    <label class="person_msg_style person_msg_type">联系方式&nbsp;:&nbsp;</label>
                    <span class="person_msg_style" id="spho"></span>
                </li>
            </ul>
        </div>
        <!--能力模型图-->
        <div id="charts" class="statistical_graph" style="width: 18.75rem;height:400px;"></div>

        <div  class="statistical_graph" >
            <%--<img src="<%=request.getContextPath()%>/asset_font/img/statistical_graph_03.png" />--%>
            <div class="bottomLine"></div>
            <input class="abilityModel" type="button" value="能力模型"/>
        </div>
    </div>

    <!--成绩单-->
    <ul class="grade_list">
        <li class="grade_list_item">
            <div class="titleYellowBlock"></div>
            <span class="itemName">项目类别&nbsp;:&nbsp;思想教育政治</span>
            <table class="grade_list_item_table" border="1">
                <tr class="table_items">
                    <td>时间</td>
                    <td>项目名称</td>
                    <td>项目级别</td>
                    <td>所获奖项</td>
                </tr>
                <tr>
                    <td>2016-08-25</td>
                    <td>第二课堂</td>
                    <td>国家级</td>
                    <td>一等奖</td>
                </tr>
                <tr>
                    <td>2016-08-25</td>
                    <td>第二课堂</td>
                    <td>国家级</td>
                    <td>一等奖</td>
                </tr>
                <tr>
                    <td>2016-08-25</td>
                    <td>第二课堂</td>
                    <td>国家级</td>
                    <td>一等奖</td>
                </tr>
                <tr>
                    <td>2016-08-25</td>
                    <td>第二课堂</td>
                    <td>国家级</td>
                    <td>一等奖</td>
                </tr><tr>
                <td>2016-08-25</td>
                <td>第二课堂</td>
                <td>国家级</td>
                <td>一等奖</td>
            </tr>
                <tr>
                    <td>2016-08-25</td>
                    <td>第二课堂</td>
                    <td>国家级</td>
                    <td>一等奖</td>
                </tr>
                <tr>
                    <td>2016-08-25</td>
                    <td>第二课堂</td>
                    <td>国家级</td>
                    <td>一等奖</td>
                </tr>
            </table>
        </li>
        <li class="grade_list_item">
            <div class="titleYellowBlock"></div>
            <span class="itemName">项目类别&nbsp;:&nbsp;思想教育政治</span>
            <table class="grade_list_item_table" border="1">
                <tr class="table_items">
                    <td>时间</td>
                    <td>项目名称</td>
                    <td>项目级别</td>
                    <td>所获奖项</td>
                </tr>
                <tr>
                    <td>2016-08-25</td>
                    <td>第二课堂</td>
                    <td>国家级</td>
                    <td>一等奖</td>
                </tr>
                <tr>
                    <td>2016-08-25</td>
                    <td>第二课堂</td>
                    <td>国家级</td>
                    <td>一等奖</td>
                </tr>
                <tr>
                    <td>2016-08-25</td>
                    <td>第二课堂</td>
                    <td>国家级</td>
                    <td>一等奖</td>
                </tr>
                <tr>
                    <td>2016-08-25</td>
                    <td>第二课堂</td>
                    <td>国家级</td>
                    <td>一等奖</td>
                </tr>
            </table>
        </li>
        <li class="grade_list_item">
            <div class="titleYellowBlock"></div>
            <span class="itemName">项目类别&nbsp;:&nbsp;思想教育政治</span>
            <table class="grade_list_item_table" border="1">
                <tr class="table_items">
                    <td>时间</td>
                    <td>项目名称</td>
                    <td>项目级别</td>
                    <td>所获奖项</td>
                </tr>
                <tr>
                    <td>2016-08-25</td>
                    <td>第二课堂</td>
                    <td>国家级</td>
                    <td>一等奖</td>
                </tr>
                <tr>
                    <td>2016-08-25</td>
                    <td>第二课堂</td>
                    <td>国家级</td>
                    <td>一等奖</td>
                </tr>
                <tr>
                    <td>2016-08-25</td>
                    <td>第二课堂</td>
                    <td>国家级</td>
                    <td>一等奖</td>
                </tr>
                <tr>
                    <td>2016-08-25</td>
                    <td>第二课堂</td>
                    <td>国家级</td>
                    <td>一等奖</td>
                </tr>
            </table>
        </li>
        <li class="grade_list_item">
            <div class="titleYellowBlock"></div>
            <span class="itemName">项目类别&nbsp;:&nbsp;思想教育政治</span>
            <table class="grade_list_item_table" border="1">
                <tr class="table_items">
                    <td>时间</td>
                    <td>项目名称</td>
                    <td>项目级别</td>
                    <td>所获奖项</td>
                </tr>
                <tr>
                    <td>2016-08-25</td>
                    <td>第二课堂</td>
                    <td>国家级</td>
                    <td>一等奖</td>
                </tr>
                <tr>
                    <td>2016-08-25</td>
                    <td>第二课堂</td>
                    <td>国家级</td>
                    <td>一等奖</td>
                </tr>
                <tr>
                    <td>2016-08-25</td>
                    <td>第二课堂</td>
                    <td>国家级</td>
                    <td>一等奖</td>
                </tr>
                <tr>
                    <td>2016-08-25</td>
                    <td>第二课堂</td>
                    <td>国家级</td>
                    <td>一等奖</td>
                </tr>
            </table>
        </li>
    </ul>
</div>
<!-- 此js必须放在div后面，不能独立放到其他页，放到其他位置都有可能失效 -->
<script src=" <%=request.getContextPath()%>/asset/js/Radio.js"></script>
</body>
</html>

