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
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
    <!--兼容360浏览器，防止布局乱，设置IE的文档模式为最高版本，并且如果存在chrome插件，自动使用Webkit引擎-->
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <title>活动结束审核管理</title>
    <link rel="Shortcut Icon" href="<%=request.getContextPath()%>/asset/image/neu.jpg" type="image/x-icon">
    <!-- 导入页面控制js jq必须放最上面 -->
    <script type="text/javascript" src="<%=request.getContextPath()%>/asset/js/jquery-1.8.3.min.js"></script>
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
    <%--页面本身CSS--%>
    <link rel="stylesheet" href="<%=request.getContextPath()%>/asset_admin_new/pageCss/supplementManage_class.css" />
    <%--引入本页自己的js--%>
    <script type="text/javascript" src="<%=request.getContextPath()%>/asset_admin_new/js/printManage.js"></script>
    <script type="text/javascript" src="<%=request.getContextPath()%>/asset_admin_new/pageJs/supplementManage_class.js"></script>
    <%--判断是否是登录状态--%>
    <%@include file="../common/CheckLogin.jsp"%>
</head>
<body>
<div class="stuMsgManage">
    <%--4、第三处修改，修改菜单按钮，选择哪些按钮需要--%>
    <!--功能栏-->
    <div class="function">
        <ul>
            <li class="function_remove" onclick="delete_zy()"><span>删除</span></li>
            <%--<li class="function_edit" onclick="batchpass()"><span>批量通过</span></li>--%>
            <%--<li class="function_edit" onclick="batchrefuse()"><span>批量驳回</span></li>--%>
            <li class="function_search"><span>综合条件查询</span></li>
            <li class="function_refresh2 " onclick="reloadsearch('待审核')"><span>待审核</span></li>
            <li class="function_refresh " onclick="reloadsearch('已通过')"><span>已通过</span></li>
            <li class="function_refresh3 " onclick="reloadsearch('未通过')"><span>未通过</span></li>
        </ul>
    </div>
    <form id="Form1" >
        <div class="searchContent">
            <div>
                <ul>
                    <li>
                        <span>活动标题:</span>
                        <input type="text" id="_activityTitle"  name="supActivityTitle"/>
                    </li>
                    <li>
                        <span>学号:</span>
                        <input type="text" id="_studentID" name="supStudentId" />
                    </li>
                    <li>
                        <span>活动类别:</span>
                        <div>
                            <select id="_supClass" name="supClass" class="select">
                                <option value="" >请选择</option>
                                <option value="" >全部</option>
                                <option value="1">思想政治教育类</option>
                                <option value="2">能力素质拓展类</option>
                                <option value="3">学术科技与创新创业类</option>
                                <option value="4">社会实践与志愿服务类</option>
                                <option value="5">社会工作与技能培训类</option>
                                <option value="6">综合奖励及其他类</option>
                            </select>
                        </div>
                    </li>
                </ul>
                <ul>
                    <li>
                        <span>学生姓名:</span>
                        <input type="text" id="_studentName" name="studentName" />
                    </li>
                    <li>
                        <span>审核状态:</span>
                        <div>
                            <select id="_regimentAuditStatus" name="regimentAuditStatus" class="select">
                                <option value="" >请选择</option>
                                <option value="" >全部</option>
                                <option value="待审核" selected>待审核</option>
                                <option value="未通过">未通过</option>
                                <option value="已通过">已通过</option>
                            </select>
                        </div>
                    </li>
                </ul>
            </div>
            <p></p>
            <div class="buttons">
                <span class="clearAll" onclick="clear_search()">清空</span>
                <span id="search" class="search" onclick="select_box(1)">搜索</span>
            </div>
        </div>
    </form>
    <!--结果集表格-->
    <div id="dg" class="table">
        <table border="0" cellspacing="0" cellpadding="0">
            <thead>
                <tr id="forOrder">
                    <td><input name="test" type="checkbox" id="submitAll" style="width: 18px; height: 20px;" /></td>
                    <td>班级</td>
                    <td>姓名</td>
                    <td>学号</td>
                    <td>活动名称</td>
                    <td>活动类别</td>
                    <td style="width: 80px;">审核状态</td>
                    <td style="display: none;">学院团委</td>
                    <td style="display: none;">校团委</td>
                    <td style="width: 190px;">操作</td>
                </tr>
            </thead>
            <tbody></tbody>
        </table>
    </div>
    <%@include file="paging_supplement.jsp"%>
    <!--弹出框的层-->
</div>
<!--分页-->
<%--5、第四处修改，修改表单信息，与上面的列名称一致--%>
<div id="tb" class="popup"></div>
<form id="Form" class="demoform" style="position: absolute;"><!--存在为了提交-->
    <div id="dlg" class="new">
        <div class="header">
            <span id="tpy">查看/修改</span>
            <span type="reset" class="iconConcel"></span>
        </div>
        <ul>
            <li><input style="display:none" name="id"/></li>
            <li>
                <span>学生姓名&nbsp;&nbsp;:&nbsp;&nbsp;&nbsp;&nbsp;</span>
                <input type="text" id="studentName" name="studentName"  style="margin-left: 21px;"  class="input_news" />
            </li>
            <li>
                <span>活动大类&nbsp;&nbsp;:&nbsp;&nbsp;&nbsp;&nbsp;</span>
                <select class="input" name="supClass" id="supClass"  onchange="firstChoose(this.value)">
                    <option value="1">思想政治教育类</option>
                    <option value="2">能力素质拓展类</option>
                    <option value="3">学术科技与创新创业类</option>
                    <option value="4">社会实践与志愿服务类</option>
                    <option value="5">社会工作与技能培训类</option>
                    <option value="6">其他类</option>
                </select>
            </li>
            <li id="scienceClass" style="display: none">
                <span>学术科技类别:</span>
                <select class="input" name="scienceClass">
                    <option value="">请选择</option>
                    <option value="论文">论文</option>
                    <option value="专利">专利</option>
                    <option value="著作">著作</option>
                    <option value="参与创业项目">参与创业项目</option>
                    <option value="组建/参与创业公司">组建/参与创业公司</option>
                </select>
            </li>
            <li id="scienceName" style="display: none">
                <span>学术科技名字:</span>
                <input type="text" class="" name="scienceName"   style="margin-left: 21px;"  class="select"/>
            </li>
            <li id="workClass" style="display: none">
                <span>组织类型&nbsp;&nbsp;:&nbsp;&nbsp;&nbsp;&nbsp;</span>
                <select class="input" name="workClass"  >
                    <option value="">请选择</option>
                    <option value="学校组织">学校组织</option>
                    <option value="学院组织">学院组织</option>
                    <option value="班级任职">班级任职</option>
                    <option value="社团">社团</option>
                </select>
            </li>
            <li id="orgcollege" style="display: none">
                <span>学院名字&nbsp;&nbsp;:&nbsp;&nbsp;&nbsp;&nbsp;</span>
                <select class="input" name="orgcollege" >
                    <option value="">请选择</option>
                </select>
            </li>
            <li id="orgname"  style="display: none">
                <span>组织名称&nbsp;&nbsp;:&nbsp;&nbsp;&nbsp;&nbsp;</span>
                <select class="input" name="orgname">
                    <option value="">请选择</option>
                </select>
            </li>
            <li id="worklevel"  style="display: none">
                <span>职务级别&nbsp;&nbsp;:&nbsp;&nbsp;&nbsp;&nbsp;</span>
                <select class="input" name="worklevel" >
                    <option value="">请选择</option>
                    <option value="负责人">负责人</option>
                    <option value="部长">部长</option>
                    <option value="成员">成员</option>
                </select>
            </li>
            <li id="workName"  style="display: none">
                <span>职务名称&nbsp;&nbsp;:&nbsp;&nbsp;&nbsp;&nbsp;</span>
                <input type="text" class="" name="workName"   value=""  style="margin-left: 21px;"  class="select" placeholder="请填写职务全称"/>
            </li>
            <li id="shipType"  style="display: none">
                <span>奖项类型&nbsp;&nbsp;:&nbsp;&nbsp;&nbsp;&nbsp;</span>
                <select class="input" name="shipType" >
                    <option value="">请选择</option>
                    <option value="奖学金类">奖学金类</option>
                    <option value="荣誉称号类">荣誉称号类</option>
                </select>
            </li>
            <li  id="shipName"  style="display: none">
                <span>奖项名称&nbsp;&nbsp;:&nbsp;&nbsp;&nbsp;&nbsp;</span>
                <input type="text"  name="shipName"  style="margin-left: 21px;"  class="select">
            </li>
            <li  id="supActivityTitle"  style="display: none">
                <span>活动标题&nbsp;&nbsp;:&nbsp;&nbsp;&nbsp;&nbsp;</span>
                <input type="text"  name="supActivityTitle"  style="margin-left: 21px;"  class="select" />
            </li>
            <li id="supLevle"  style="display: none">
                <span>活动级别&nbsp;&nbsp;:&nbsp;&nbsp;&nbsp;&nbsp;</span>
                <select class="input" name="supLevle" >
                    <option value="">请选择</option>
                    <option value="0">国际级</option>
                    <option value="1">国家级</option>
                    <option value="2">省级</option>
                    <option value="3">市级</option>
                    <option value="4">校级</option>
                    <option value="5">院级</option>
                    <option value="6">团支部级</option>
                </select>
            </li>
            <li id="supNature"  style="display: none">
                <span>活动性质&nbsp;&nbsp;:&nbsp;&nbsp;&nbsp;&nbsp;</span>
                <select class="input" name="supNature">
                    <option value="">请选择</option>
                    <option value="1">活动参与</option>
                    <option value="2">讲座报告</option>
                    <option value="3">比赛</option>
                    <option value="4">培训</option>
                </select>
            </li>
            <li id="supPowers"  style="display: none">
                <span>能力标签&nbsp;&nbsp;:&nbsp;&nbsp;&nbsp;&nbsp;</span>
                <div class="inputbox">
                    <input type="checkbox" class="qx_check" id="qx1" name="qx" value="思辨能力" style="width: 16px!important;height: 16px;position: relative;top: -1px;margin: 0px
    0px 0px 12px;"/>思辨能力
                    <input type="checkbox" class="qx_check" id="qx2" name="qx" value="执行能力" style="width: 16px!important;height: 16px;position: relative;top: -1px;margin: 0px
    0px 0px 12px;"/>执行能力
                    <input type="checkbox" class="qx_check" id="qx3" name="qx" value="表达能力" style="width: 16px!important;height: 16px;position: relative;top: -1px;margin: 0px
    0px 0px 12px;"/>表达能力
                    <br>
                    <input type="checkbox" class="qx_check" id="qx4" name="qx" value="领导能力" style="width: 16px!important;height: 16px;position: relative;top: -1px;margin: 0px
    0px 0px 12px;"/>领导能力
                    <input type="checkbox" class="qx_check" id="qx5" name="qx" value="创新能力" style="width: 16px!important;height: 16px;position: relative;top: -1px;margin: 0px
    0px 0px 12px;"/>创新能力
                    <input type="checkbox" class="qx_check" id="qx6" name="qx" value="创业能力" style="width: 16px!important;height: 16px;position: relative;top: -1px;margin: 0px
    0px 0px 12px;"/>创业能力
                </div>
            </li>
            <li id="supAward"  style="display: none">
                <span>获得奖项&nbsp;&nbsp;:&nbsp;&nbsp;&nbsp;&nbsp;</span>
                <select class="input" name="supAward">
                    <option value="">请选择</option>
                    <option value="第一名">第一名</option>
                    <option value="第二名">第二名</option>
                    <option value="一等奖">一等奖</option>
                    <option value="二等奖">二等奖</option>
                    <option value="金奖">金奖</option>
                    <option value="银奖">银奖</option>
                    <option value="冠军">冠军</option>
                    <option value="亚军">亚军</option>
                    <option value="四强">四强</option>
                    <option value="八强">八强</option>
                    <option value="其他">其他</option>
                </select>
            </li>
            <li id="Award"  style="display: none">
                <span>奖项名称&nbsp;&nbsp;:&nbsp;&nbsp;&nbsp;&nbsp;</span>
                <input type="text" class="" name="Award" style="margin-left: 21px;"  class="select"/>
            </li>
            <li id="supWorktime"  style="display: none">
                <span>工作时长&nbsp;&nbsp;:&nbsp;&nbsp;&nbsp;&nbsp;</span>
                <input type="text" class="" name="supWorktime"  style="margin-left: 21px;"  class="select" placeholder="几天或几小时"/>
            </li>
            <li>
                <span>班级审核状态&nbsp;&nbsp;:&nbsp;&nbsp;&nbsp;&nbsp;</span>
                <input id="regimentAuditStatus" name="regimentAuditStatus" class="select"  readonly="true"/>
            </li>
            <li>
                <span>班级审核时间&nbsp;&nbsp;:&nbsp;&nbsp;&nbsp;&nbsp;</span>
                <input id="regimentAuditStatusDate" name="regimentAuditStatusDate" class="select"  readonly="true"/>
            </li>
            <li>
                <span>参与时间&nbsp;&nbsp;:&nbsp;&nbsp;&nbsp;&nbsp;</span>
                <input id="takeDate" name="takeDate" class="select"  style="margin-left: 21px;" readonly="true"/>
            </li>
            <li>
                <span>填写时间&nbsp;&nbsp;:&nbsp;&nbsp;&nbsp;&nbsp;</span>
                <input id="supDate" name="supDate" class="select"  style="margin-left: 21px;" readonly="true"/>
            </li>
            <li id="getScore">
                <span>可得学分&nbsp;&nbsp;:&nbsp;&nbsp;&nbsp;&nbsp;</span>
                <!--表单验证例子如下 -->
                <input   name="supCredit"  class="select" style="margin-left: 21px;" readonly="true"/>
            </li>
        </ul>
        <ul class="btnbox"></ul>
    </div>
</form>
<div id="tb2" class="popup" ></div>
<div id="dlg2" class="new" style="min-width: 400px;height: 200px;left: 450px">
    <div class="header">
        <span>审核</span>
        <span type="reset" class="iconConcel"></span>
    </div>
    <input type="hidden" id="photo_textbox" name="newsImg">
    <ul>
        <li id="sc_score">
            <span style="font-size: 14px">分数</span>
            <!--表单验证例子如下 -->
            <input type="text" id="score" class="score1" name="score" class="input_news" style="margin-left: 17px"/>
        </li>
        <li id="sc_reason" style="display: none">
            <span style="font-size: 14px">审核意见</span>
            <input type="text" id="reason"  class="input_news" style="margin-left: 17px"/>
        </li>
    </ul>
    <!--按钮窗口-->
    <div id="dlg-buttons2" class="new_buttons">
        <input type="reset" id="btn_sub" value="保存" />
        <input type="reset"  value="取消" onclick="close_new()" />
    </div>
</div>
</body>
</html>
