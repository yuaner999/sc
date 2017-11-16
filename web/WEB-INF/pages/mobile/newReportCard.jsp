<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>编辑成绩单</title>
    <meta name="viewport"
          content="width=device-width,initial-scale=1,minimum-scale=1,maximum-scale=1,user-scalable=no"/>
    <!--通用css-->
    <link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/asset_mobile/css/common.css"/>
    <link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/asset_mobile/css/layout.css"/>
    <link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/asset_mobile/css/reportCard.css"/>
    <!--单独css-->
    <link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/asset_mobile/css/change.css"/>
    <!--js-->
    <!--layer-->
    <script src="<%=request.getContextPath()%>/asset_mobile/js/layer_mobile/layer.js" type="text/javascript"
            charset="utf-8"></script>
    <!--封装好的好理解layer-->
    <script src="<%=request.getContextPath()%>/asset_mobile/js/layer-packaged.js" type="text/javascript"
            charset="utf-8"></script>
    <!--js-->
    <script src="<%=request.getContextPath()%>/asset_mobile/js/angular1.6.min.js" type="text/javascript"
            charset="utf-8"></script>
    <script src="<%=request.getContextPath()%>/asset/js/jquery-1.11.1.min.js"></script>
    <script src="<%=request.getContextPath()%>/asset_mobile/js/commonJs.js"></script>
    <script src="<%=request.getContextPath()%>/asset_mobile/js/jsdate.js" type="text/javascript"></script>
</head>
<%@include file="../mobile/CheckLogin.jsp"%>
<body ng-app='app' ng-controller='ctrl'>
<div class="container">
    <div class="formRow">
        <div class="row">
            <b>活动大类</b>
            <div class="alignCenter select">
                <span ng-bind="categorieFilter(nowcategorie)"></span>
                <i class="r"></i>
            </div>
            <select ng-model="nowcategorie" ng-change="changCat()">
                <option value="" selected="selected">请选择</option>
                <option value="1">思想政治教育类</option>
                <option value="2">能力素质拓展类</option>
                <option value="3">学术科技与创新创业类</option>
                <option value="4">社会实践与志愿服务类</option>
                <option value="5">社会工作与技能培训类</option>
                <option value="6">综合奖励及其它类</option>
            </select>
        </div>
    </div>

    <div class="box" ng-if="isShow">
        <%--思想政治教育类--%>
        <div ng-if="nowcategorie=='1'">
            <div class="formRow">
                <div class="row">
                    <span>主题团日</span>
                    <div class="radio">
                        <label>
                            <input type="radio" ng-checked="isTeamDay" ng-click="changeTeamDay('1')" value="true"/>
                            <i></i>
                            <span>是</span>
                        </label>
                        <label>
                            <input type="radio" ng-checked="!isTeamDay" ng-click="changeTeamDay('0')" value="false"/>
                            <i></i>
                            <span>否</span>
                        </label>
                    </div>
                </div>
            </div>
            <div ng-if="isTeamDay">
                <div class="formRow">
                    <div class="row">
                        <span>活动名称</span>
                        <input type="text" ng-model="model.activityName" placeholder="请填写活动全称"/>
                    </div>
                </div>
                <div class="formRow">
                    <div class="row">
                        <b>能力标签</b>
                    </div>
                    <div class="checkBox">
                        <label>
                            <input type="checkbox" ng-model="model.powers[0]" ng-click="selectPower('0')" name="skill"
                                   value="思辨"/>
                            <i></i>
                            <span>思辨能力</span>
                        </label>
                        <label>
                            <input type="checkbox" ng-model="model.powers[1]" ng-click="selectPower('1')" name="skill"
                                   value="执行"/>
                            <i></i>
                            <span>执行能力</span>
                        </label>
                        <label>
                            <input type="checkbox" ng-model="model.powers[2]" ng-click="selectPower('2')" name="skill"
                                   value="表达"/>
                            <i></i>
                            <span>表达能力</span>
                        </label>
                        <label>
                            <input type="checkbox" ng-model="model.powers[3]" ng-click="selectPower('3')" name="skill"
                                   value="领导"/>
                            <i></i>
                            <span>领导能力</span>
                        </label>
                        <label>
                            <input type="checkbox" ng-model="model.powers[4]" ng-click="selectPower('4')" name="skill"
                                   value="创新"/>
                            <i></i>
                            <span>创新能力</span>
                        </label>
                        <label>
                            <input type="checkbox" ng-model="model.powers[5]" ng-click="selectPower('5')" name="skill"
                                   value="创业"/>
                            <i></i>
                            <span>创业能力</span>
                        </label>
                    </div>
                </div>
            </div>
        </div>

        <%--学术科技与创新类--%>
        <div ng-if="nowcategorie=='3'">
            <div class="formRow">
                <div class="row">
                    <b>活动类别</b>
                    <div class="alignCenter select">
                        <span ng-bind="model.nowActivityType"></span>
                        <i class="r"></i>
                    </div>
                    <select ng-model="model.nowActivityType" ng-change="changeActivityType()">
                        <option value="">请选择</option>
                        <option value="活动类">活动类</option>
                        <option value="非活动类">非活动类</option>
                    </select>
                </div>
            </div>
            <div ng-if="model.nowActivityType=='非活动类'">
                <div class="formRow">
                    <div class="row">
                        <b>学术科技</b>
                        <div class="alignCenter select">
                            <span ng-bind="model.scienceClass"></span>
                            <i class="r"></i>
                        </div>
                        <select ng-model="model.scienceClass" ng-options='item for item in xskj'>
                        </select>
                    </div>
                </div>
                <div class="formRow">
                    <div class="row">
                        <span>标题名字</span>
                        <input type="text" ng-model="model.titleName" placeholder="请填写标题名字"/>
                    </div>
                </div>
            </div>
        </div>

        <%--社会实践与志愿服务--%>
        <div class="formRow" ng-if="nowcategorie=='4'">
            <div class="row">
                <span>活动子类</span>
                <div class="radio">
                    <label>
                        <input type="radio" name="hdzl" value="true" ng-click="changeSub()" ng-model="model.hdzl"/>
                        <i></i>
                        <span>社会实践</span>
                    </label>
                    <label>
                        <input type="radio" name="hdzl" value="false" ng-click="changeSub()" ng-model="model.hdzl"/>
                        <i></i>
                        <span>志愿服务</span>
                    </label>
                </div>
            </div>
            <div class="row" ng-if="model.hdzl=='true'">
                <span>理论实践</span>
                <div class="radio">
                    <label>
                        <input type="radio" checked value="false"/>
                        <i></i>
                        <span>其他社会实践活动</span>
                    </label>
                </div>
            </div>
        </div>

        <%--社会工作与技能培训类--%>
        <div ng-show="nowcategorie=='5'">
            <div class="formRow">
                <div class="row">
                    <b>活动类别</b>
                    <div class="alignCenter select">
                        <span ng-bind="typeFilter(model.nowActivityType2)"></span>
                        <i class="r"></i>
                    </div>
                    <select ng-model="model.nowActivityType2" ng-change="changeActivityType()">
                        <option value="">请选择</option>
                        <option value="活动类">活动类</option>
                        <option value="非活动类">学生干部任职</option>
                    </select>
                </div>
            </div>

            <div ng-if="model.nowActivityType2=='非活动类'">
                <div class="formRow">
                    <div class="row">
                        <b>组织类型</b>
                        <div class="alignCenter select">
                            <span ng-bind="model.organizationType"></span>
                            <i class="r"></i>
                        </div>
                        <select ng-model="model.organizationType" ng-change="changeOrgType()">
                            <option value="">请选择</option>
                            <option value="学校组织">学校组织</option>
                            <option value="学院组织">学院组织</option>
                            <option value="党支部任职">党支部任职</option>
                            <option value="班团任职">班团任职</option>
                            <option value="社团">社团</option>
                        </select>
                    </div>
                </div>
                <div class="formRow" ng-if="model.organizationType=='学院组织'">
                    <div class="row">
                        <b>学院名字</b>
                        <input type="text" ng-model="model.orgcollege"/>
                    </div>
                </div>
                <div class="formRow"
                     ng-if="model.organizationType=='学校组织' || model.organizationType=='学院组织' || model.organizationType=='社团'">
                    <div class="row">
                        <b>组织名称</b>
                        <div class="alignCenter select">
                            <span ng-bind="organizationName.orgname"></span>
                            <i class="r"></i>
                        </div>
                        <select ng-model="organizationName" ng-options="x.orgname for x in organizations">
                            <option value="">请选择</option>
                        </select>
                    </div>
                </div>
                <div class="formRow"
                     ng-if="model.organizationType=='学校组织' || model.organizationType=='学院组织' || model.organizationType=='社团'">
                    <div class="row">
                        <b>职务级别</b>
                        <div class="alignCenter select">
                            <span ng-bind="model.jobLevel"></span>
                            <i class="r"></i>
                        </div>
                        <select ng-model="model.jobLevel">
                            <option value="">请选择</option>
                            <option value="负责人">主席</option>
                            <option value="负责人">副主席</option>
                            <option value="负责人">主任</option>
                            <option value="负责人">副主任</option>
                            <option value="负责人">负责人</option>
                            <option value="部长">部长</option>
                            <option value="副部长">副部长</option>
                            <option value="成员">成员</option>
                        </select>
                    </div>
                </div>
                <div class="formRow"
                     ng-if="model.organizationType=='学校组织' || model.organizationType=='学院组织' || model.organizationType=='社团'">
                    <div class="row">
                        <span>职务名称</span>
                        <input type="text" ng-model="model.workName" placeholder="请填写职务全称"/>
                    </div>
                </div>
                <div class="formRow" ng-if="model.organizationType=='党支部任职' || model.organizationType=='班团任职'">
                    <div class="row">
                        <b>职务名称</b>
                        <div class="alignCenter select">
                            <span ng-bind="model.workName"></span>
                            <i class="r"></i>
                        </div>
                        <select ng-model="model.workName" ng-options="x for x in jobNames">
                            <option value="">请选择</option>
                        </select>
                    </div>
                </div>
            </div>

        </div>

        <%--综合奖励及其它类--%>
        <div ng-cloak class="box" ng-if="nowcategorie=='6'">
            <div class="formRow">
                <div class="row">
                    <b>奖项类型</b>
                    <div class="alignCenter select">
                        <span ng-bind="model.nowjxlb"></span>
                        <i class="r"></i>
                    </div>
                    <select ng-model="model.nowjxlb">
                        <option value="">请选择</option>
                        <option value="奖学金类">奖学金类</option>
                        <option value="荣誉称号类">荣誉称号类</option>
                    </select>
                </div>
            </div>
            <div class="formRow">
                <div class="row">
                    <span>奖项名称</span>
                    <input type="text" ng-model="model.awardName2" placeholder="请填写奖项名称"/>
                </div>
            </div>
        </div>

        <!--活动类-->
        <%--未建立的活动--%>
        <div ng-if="(nowcategorie=='1' && !isTeamDay)
            || nowcategorie=='2' || nowcategorie=='4'
            || (nowcategorie=='3' && model.nowActivityType=='活动类')
            || (nowcategorie=='5' && model.nowActivityType2=='活动类')">
            <div class="formRow">
                <div class="row">
                    <span>活动名称</span>
                    <input type="text" ng-model="model.activityName" placeholder="请填写活动全称"/>
                </div>
            </div>
            <div class="formRow">
                <div class="row">
                    <b>活动级别</b>
                    <div class="alignCenter select">
                        <span ng-bind="levelFilter(model.activityLevel)"></span>
                        <i class="r"></i>
                    </div>
                    <select ng-model="model.activityLevel" ng-change="setCreditVal()">
                        <option value="">请选择</option>
                        <option value="0">国际级</option>
                        <option value="1">国家级</option>
                        <option value="2">省级</option>
                        <option value="3">市级</option>
                        <option value="4">校级</option>
                        <option value="5">院级</option>
                    </select>
                </div>
            </div>
            <div class="formRow">
                <div class="row">
                    <b>活动性质</b>
                    <div class="alignCenter select">
                        <span ng-bind="propertyFilter(model.activityProperty)"></span>
                        <i class="r"></i>
                    </div>
                    <select ng-model="model.activityProperty" ng-change="setCreditVal()">
                        <option value="">请选择</option>
                        <option value="1">活动参与</option>
                        <option value="2">讲座报告</option>
                        <option value="3">比赛</option>
                        <option value="4">培训</option>
                    </select>
                </div>
            </div>
            <div class="formRow">
                <div class="row">
                    <b>能力标签</b>
                </div>
                <div class="checkBox">
                    <label>
                        <input type="checkbox" ng-model="model.powers[0]" ng-click="selectPower('0')" name="skill"
                               value="思辨"/>
                        <i></i>
                        <span>思辨能力</span>
                    </label>
                    <label>
                        <input type="checkbox" ng-model="model.powers[1]" ng-click="selectPower('1')" name="skill"
                               value="执行"/>
                        <i></i>
                        <span>执行能力</span>
                    </label>
                    <label>
                        <input type="checkbox" ng-model="model.powers[2]" ng-click="selectPower('2')" name="skill"
                               value="表达"/>
                        <i></i>
                        <span>表达能力</span>
                    </label>
                    <label>
                        <input type="checkbox" ng-model="model.powers[3]" ng-click="selectPower('3')" name="skill"
                               value="领导"/>
                        <i></i>
                        <span>领导能力</span>
                    </label>
                    <label>
                        <input type="checkbox" ng-model="model.powers[4]" ng-click="selectPower('4')" name="skill"
                               value="创新"/>
                        <i></i>
                        <span>创新能力</span>
                    </label>
                    <label>
                        <input type="checkbox" ng-model="model.powers[5]" ng-click="selectPower('5')" name="skill"
                               value="创业"/>
                        <i></i>
                        <span>创业能力</span>
                    </label>
                </div>
            </div>

            <div class="formRow">
                <div class="row">
                    <b>获得奖项</b>
                    <div class="alignCenter select">
                        <span ng-bind="model.nowAward"></span>
                        <i class="r"></i>
                    </div>
                    <select ng-model="model.nowAward" ng-options='item for item in award'>
                    </select>
                </div>
            </div>
            <div class="formRow" ng-if="model.nowAward=='其他'">
                <div class="row">
                    <span>奖项名称</span>
                    <input type="text" ng-model="model.awardName" placeholder="请填写奖项全称"/>
                </div>
            </div>
        </div>

            <%--工作时长--%>
        <div class="formRow" ng-if="nowcategorie=='4' && model.hdzl == 'false'">
            <div class="row">
                <span>工作时长</span>
                <input type="text" ng-model="model.supWorktime" ng-change="calCredit()" placeholder="时间单位：小时"/>
            </div>
        </div>

        <!--common  -->
        <div ng-if="isCommonShow">
            <div class="formRow">
                <div class="row">
                    <span ng-if="!(nowcategorie=='5' && (model.organizationType=='党支部任职' || model.organizationType=='班团任职'))">参与日期</span>
                    <span ng-if="nowcategorie=='5' && (model.organizationType=='党支部任职' || model.organizationType=='班团任职')">任职日期</span>
                    <input type="date" ng-model="model.partakeDate" placeholder="请填写参与的起始日期"/>
                </div>
            </div>
            <div class="formRow">
                <div class="row">
                    <span>可获学分</span>
                    <div class="score">
                        <span ng-bind="credit">0.25</span>
                        <a>*仅供参考，以审核结果为准</a>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <div class="btnBox">
        <button ng-click="submit()">确定提交</button>
    </div>

</div>
<script type="text/javascript">
    var college = "<%=session.getAttribute("college")%>";
    var id = getUrlParam("id");
    var collegeAuditReason = "";
    var collegeAuditStatus = "";
    var collegeAuditStatusDate = "";

    var app = angular.module('app', []);
    app.controller('ctrl', function ($scope) {
        scope = $scope;
        $scope.model = {};

        $scope.nowcategorie = "";
        $scope.isShow = false;
        $scope.activityShow = false;
        $scope.isTeamDay = false;
        $scope.isCommonShow = true;
        $scope.model.hdzl = "false";
        $scope.model.workName = "";

        var powers = ["思辨能力", "执行能力", "表达能力", "领导能力", "创新能力", "创业能力"];
        //获得奖项
        $scope.award = ["第一名", "第二名", "一等奖", "二等奖", "金奖", "银奖", "冠军", "亚军", "四强", "八强", "其他"];
        $scope.model.nowAward = "";
        //学术科技
        $scope.model.scienceClass = "";
        $scope.xskj = ["论文", "专利", "著作", "参与创业项目", "组建/参与创业公司"];
        //组织类型
        $scope.nowzzlx = "";
        $scope.zzlx = ['学校组织', '学院组织', '党支部任职', '班团任职', '社团'];
        //奖项类别
        $scope.jxlb = ['奖学金奖', "荣誉称号类"];
        $scope.nowjxlb = "";
        $scope.model.organizationType = "";
        $scope.jobName = "";

        $scope.activityInit = function (value) {
            $scope.model.activityName = "";
            $scope.model.activityLevel = "";
            $scope.model.activityProperty = "";
            $scope.model.nowActivityType = "";
            $scope.model.nowActivityType2 = "";
            $scope.model.powers = [];
            $scope.model.awardName = "";
            $scope.model.partakeDate = "";
            $scope.credit = 0.25;
            if (id !== "" && id != null && value) {
                $.ajax({
                    url: "/jsons/loadsupplement.form",
                    type: "post",
                    data: {id: id},
                    success: function (data) {
                        var supplement = data.rows[0];
                        collegeAuditReason = supplement.collegeAuditReason;
                        collegeAuditStatus = supplement.collegeAuditStatus;
                        collegeAuditStatusDate = supplement.collegeAuditStatusDate;
                        $scope.nowcategorie = supplement.supClass;
                        $scope.changCat();
                        if (supplement.supClass === "3") {
                            $scope.model.nowActivityType = supplement.supType;
                            $scope.changeActivityType();
                        }
                        if (supplement.supClass === "5") {
                            if (supplement.workClass != null || supplement.workClass !== "") {
                                $scope.model.nowActivityType2 = "非活动类";
                            }
                            $scope.changeActivityType();
                        }
                        var powers2 = supplement.supPowers.split("|");
                        for (var i = 0; i < powers.length; i++) {
                            for (var j = 0; j < powers2.length; j++) {
                                if (powers[i] === powers2[j]) {
                                    $scope.model.powers[i] = true;
                                }
                            }
                        }
                        $scope.model.scienceClass = supplement.scienceClass;
                        $scope.model.titleName = supplement.scienceName;
                        $scope.model.organizationType = supplement.workClass;
                        $scope.changeOrgType();
                        $scope.organizationName = {};
                        $scope.organizationName.orgname = supplement.orgname;
                        $scope.model.jobLevel = supplement.worklevel;
                        $scope.model.workName = supplement.workName;
                        $scope.model.nowjxlb = supplement.shipType;
                        $scope.model.awardName2 = supplement.shipName;
                        $scope.model.activityName = supplement.supActivityTitle;
                        $scope.model.activityLevel = supplement.supLevle;
                        $scope.model.activityProperty = supplement.supNature;
                        $scope.model.nowAward = supplement.supAward;
                        $scope.model.awardName = supplement.Award;
                        $scope.model.supWorktime = supplement.supWorktime;
                        var date= new Date(Date.parse(supplement.takeDate.replace(/-/g,  "/")));
                        $scope.model.partakeDate = date;
                        $scope.credit = supplement.supCredit;
                        $scope.$apply();
                    }
                });
            }
        };
        $scope.activityInit(true);

        $scope.levelFilter = function (val) {
            switch (val) {
                case "0" :
                    return "国际级";
                case "1" :
                    return "国家级";
                case "2" :
                    return "省级";
                case "3" :
                    return "市级";
                case "4" :
                    return "校级";
                case "5" :
                    return "院级";
                default :
                    return "请选择"
            }
        };
        $scope.propertyFilter = function (val) {
            switch (val) {
                case "1" :
                    return "活动参与";
                case "2" :
                    return "讲座报告";
                case "3" :
                    return "比赛";
                case "4" :
                    return "培训";
                default :
                    return "请选择"
            }
        };
        $scope.categorieFilter = function (val) {
            switch (val) {
                case "1" :
                    return "思想政治教育类";
                case "2" :
                    return "能力素质拓展类";
                case "3" :
                    return "学术科技与创新创业类";
                case "4" :
                    return "社会实践与志愿服务类";
                case "5" :
                    return "社会工作与技能培训类";
                case "6" :
                    return "综合奖励及其它类";
                default :
                    return "请选择"
            }
        };
        $scope.typeFilter = function (val) {
            if (val === "非活动类") {
                return "学生干部任职";
            }
        };
        $scope.jobLevelFilter = function (val) {

        };

        $scope.changCat = function () {
            $scope.isShow = true;
            $scope.model.orgcollege = "";
            if ($scope.nowcategorie === "3"
                || $scope.nowcategorie === "5" || $scope.nowcategorie === "") {
                $scope.isCommonShow = false;
            } else {
                $scope.isCommonShow = true;
            }
            $scope.activityInit(false);
            if ($scope.nowcategorie === "4") {
                $scope.credit = 0;
            } else if ($scope.nowcategorie === "6") {
                $scope.credit = "--";
            }
        };

        $scope.changeTeamDay = function (value) {
            $scope.isTeamDay = value !== "0";
        };

        $scope.changeSub = function () {
            if ($scope.model.hdzl === "true") {
                $scope.credit = 1;
            } else {
                $scope.credit = 0;
            }
        };

        $scope.changeActivityType = function () {
            $scope.isCommonShow = true;
            if ($scope.model.nowActivityType2 === "非活动类") {
                $scope.credit = "--";
            } else {
                $scope.credit = 0.25;
            }
        };

        $scope.calCredit = function () {
            var time = $scope.model.supWorktime;
            time = time.replace(/\D/g, '');
            $(this).val(time);
            if (!isNaN(parseInt(time)))
                time = parseInt(time);
            else
                time = 0;
            var credit = Math.floor((time / 12) * 100) / 100;
            $scope.credit = credit;
        };

        $scope.submit = function () {
            var actClass = $scope.nowcategorie;
            var power = "";
            if ("" === actClass) {
                l_msg("请先选择活动大类", 2);
                return;
            }

            var supType1 = $scope.model.nowActivityType;
            var supType2 = $scope.model.nowActivityType2;
            if ("3" === actClass) {

                if (supType1 === "") {
                    l_msg("请先选择活动类别", 2);
                    return;
                }
                if (supType1 === "非活动类") {
                    if ($scope.model.titleName == null || $scope.model.titleName === "") {
                        l_msg("请填写标题全名", 2);
                        return;
                    }
                    if ($scope.model.titleName.length > 100) {
                        l_msg("标题名称不能超过100个字", 2);
                        return false;
                    }
                }
            } else if (actClass === "5")
            {
                if (supType2 === "") {
                    l_msg("请先选择活动类别", 2);
                    return;
                }
                if (supType2 === "非活动类") {
                    var orzType = $scope.model.organizationType;
                    if (orzType === "学校组织" || orzType === "学院组织" || orzType === "社团") {
                        if ($scope.model.workName == null || $scope.model.workName === "") {
                            l_msg("请填写职务全称", 2);
                            return;
                        }
                    }
                }
            }
            if (actClass !== "6" && supType1 !== "非活动类" && supType2 !== "非活动类" && !$scope.isTeamDay) {
                if ($scope.model.activityName == null || $scope.model.activityName === "") {
                    l_msg("请填写活动全称", 2);
                    return;
                }
                if ($scope.model.activityName.length > 100) {
                    l_msg("活动名称不能超过100个字", 2);
                    return;
                }
                var count = 0;
                $scope.model.powers.forEach(function (item, index) {
                    if (item) {
                        count++;
                        power += powers[index] + "|";
                    }
                });
                if (count === 0) {
                    l_msg("至少选一项增加能力", 2);
                    return;
                }
                power = power.substring(0, power.length-1);
                if ($scope.model.nowAward === "") {
                    l_msg("请选择获得奖项，若无请选择其他");
                    return;
                }
                if ($scope.model.nowAward === "其他") {
                    if ($scope.model.awardName == null || $scope.model.awardName === "") {
                        l_msg("请填写奖项全称", 2);
                        return;
                    }
                    if ($scope.model.awardName.length > 100) {
                        l_msg("奖项名称不能超过100个字", 2);
                        return;
                    }

                }

            }

            if (actClass === "6" && $scope.model.awardName2 == null) {
                l_msg("请填写奖项全称", 2);
                return;
            }
            if (actClass === "6" && $scope.model.awardName2.length > 100) {
                l_msg("奖项名称不能超过100个字", 2);
                return;
            }
            if (actClass === "4" && $scope.model.hdzl === "false"
                && ($scope.model.supWorktime == null || $scope.model.supWorktime === "")) {
                l_msg("请填写工作时长", 2);
                return;
            }

            if ($scope.model.partakeDate == null || $scope.model.partakeDate === "") {
                l_msg("请选择参与起始时间", 2);
                return;
            }
            var supType = "";
            if (actClass === "1") {
                supType = $scope.isTeamDay ? "主题团日" : "";
            } else if (actClass === "3") {
                supType = $scope.model.nowActivityType;
            } else if (actClass === "5") {
                supType = $scope.model.nowActivityType;
            } else {
                supType = "";
            }

            var orgcollege = $scope.model.organizationType == "学院组织" ? college : "";
            var orgname = $scope.organizationName == null ? "" : $scope.organizationName.orgname;
            $.ajax({
                url:"/supplement/applyforweixin.form",
                type:"post",
                data: {
                    supClass: actClass,
                    supType: supType,
                    scienceClass: $scope.model.scienceClass,
                    scienceName: $scope.model.titleName,
                    workClass: $scope.model.organizationType,
                    orgcollege: orgcollege,
                    orgname: orgname,
                    worklevel: $scope.model.jobLevel,
                    workName: $scope.model.workName,
                    shipType:$scope.model.nowjxlb,
                    shipName: $scope.model.awardName2,
                    supActivityTitle: $scope.model.activityName,
                    supLevle: $scope.model.activityLevel,
                    supNature: $scope.model.activityProperty,
                    supAward: $scope.model.nowAward,
                    Award: $scope.model.awardName,
                    supWorktime: $scope.model.supWorktime,
                    takeDate: dateformat_yyyyMMdd($scope.model.partakeDate),
                    supCredit: $scope.credit,
                    supPowers: power,
                    id: id
                },
                dataType:"json",
                async:true,
                success:function(data){
                    l_msg("保存成功", 2, function () {
                        window.location = "reportCard.form";
                    });
                },
                error:function(){
                    l_msg("网络错误",2);
                }
            })
        };

        $scope.changeOrgType = function () {
            $scope.model.orgcollege = "";
            if ($scope.model.organizationType === "党支部任职") {
                $scope.jobNames = ["党支书", "党支部组织委员", "党支部宣传委员"];
            } else if ($scope.model.organizationType === "班团任职") {
                $scope.jobNames = ["团支书", "组织委员", "宣传委员", "班长", "副班长", "学习委员", "文艺委员", "生活委员", "体育委员", "心理委员"];
            } else {
                $scope.model.orgcollege = $scope.model.organizationType === "学院组织" ? college : "";
                var orgval = $scope.model.organizationType === "学院组织" ? college : $scope.model.organizationType;

                $.ajax({
                    url: "/jsons/loadorgname.form",
                    type: "post",
                    data: {orgval: orgval},
                    async: false,
                    success: function (data) {
                        $scope.organizations = data.rows;
                    }
                });
            }
        };

        $scope.selectPower = function (index) {
            var count = 0;
            $scope.model.powers.forEach(function (item) {
                if (item) {
                    count++;
                }
            });
            if (count > 3) {
                l_msg("最多只能选择三个能力标签", 2);
                $scope.model.powers[parseInt(index)] = false;
                return;
            }
            if (count <= 0) {
                l_msg("至少选择一个能力标签", 2);
                $scope.model.powers[parseInt(index)] = true;
                return;
            }
        };

        $scope.setCreditVal = function () {
            if ($scope.nowcategorie === "4") {
                return;
            }

            var activityLevel = $scope.model.activityLevel;
            var activityProperty = $scope.model.activityProperty;

            if ("3" === activityProperty) {
                if (("0" === activityLevel || "1" === activityLevel) && '' !== activityLevel) {
                    $scope.credit = 0.5;
                } else if ("2" === activityLevel) {
                    $scope.credit = 0.4;
                } else if ("3" === activityLevel) {
                    $scope.credit = 0.3;
                } else {
                    $scope.credit = 0.25;
                }
            } else {
                $scope.credit = 0.25;
            }
        };
    });
</script>
</body>
</html>
