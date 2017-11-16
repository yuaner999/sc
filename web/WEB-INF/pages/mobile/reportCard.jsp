<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>成绩单预览</title>
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
    <script src="<%=request.getContextPath()%>/asset_mobile/js/jsdate.js" type="text/javascript"
            charset="utf-8"></script>
    <!--封装好的好理解layer-->
    <script src="<%=request.getContextPath()%>/asset_mobile/js/layer-packaged.js" type="text/javascript"
            charset="utf-8"></script>
    <!--js-->
    <script src="<%=request.getContextPath()%>/asset_mobile/js/angular1.6.min.js" type="text/javascript"
            charset="utf-8"></script>
    <script type="text/javascript" src="<%=request.getContextPath()%>/asset_font/js/jquery-1.11.1.min.js"></script>
    <style>
        .button {
            width: 20px;
            height: 22px;
            background: url(<%=request.getContextPath()%>/asset_font_new/img/studentInfo_03.png) no-repeat center;
            vertical-align: middle;
            margin-left: 2px;
        }

        .error:after {
            content: '';
            position: absolute;
            bottom: 35px;
            background: url(<%=request.getContextPath()%>/asset_font_new/img/langxian_03.png) repeat;
            height: 3px;
            width: 90%;
            left: 30px;
        }
    </style>
</head>
<%@include file="../mobile/CheckLogin.jsp" %>
<body ng-app='app' ng-controller='ctrl'>
<div class="container">
    <div class="func">
        <b>编辑菜单</b>

        <div>
            <a class="icon eye" ng-click="gotoPage()"></a>
            <a href="newReportCard.form" class="icon add"></a>
            <a class="icon delete" ng-click="delete()"></a>
        </div>
    </div>
    <!--列表-->
    <div class="list">
        <div class="category {{item.active==true?'active':''}}" ng-repeat="item in categories">
            <h1 ng-click="item.active=!item.active" style="float: inherit;">
                <span ng-bind="item.property"></span>
                <span class="blue" ng-if="item.judgescore">(2/<span class="red"
                                                                    ng-bind="item.activityscore"></span>)</span>
                <span class="blue" ng-if="!(item.judgescore)"></span>
                <span ng-bind="'已选择'+item.selectNumbers" style="float: right; margin-right: 10px;"></span>

                <div class="r"></div>
            </h1>
            <div class="box">
                <div class="activity {{changing==true?'active':''}}" ng-repeat="acti in item.activities">
                    <div class="top">
                        <!--日期-->
                        <span class="label" ng-bind="acti.applyDate"></span>
                        <!--学分-->
                        <b class="right" ng-if="(acti.activityCredit)&&item.judgescore"
                        ng-bind="acti.activityCredit+'学分'"></b>
                    </div>
                    <%--时长--%>
                    <div class="right" ng-if="acti.worktime" ng-bind="acti.worktime+'小时'" style="font-size: 15px"></div>
                    <p>
                        <label>
                            <input type="checkbox" ng-click="choose($event,acti,item)"/>
                            <i></i>
                        </label>
                        <span class="text">
                            <font ng-bind="acti.activityTitle" ng-if="acti.isPassed"></font>
                            <font ng-bind="acti.activityTitle" ng-click="showReason(acti)" ng-if="!acti.isPassed"
                                  class="error"></font>
                            <a href="javascript:self.location='themedayPage.form'" class="icon button"
                               ng-if="acti.judge"></a>
                        </span>
                        <span class="handle" ng-show="changing">
									<b ng-bind="acti.level"></b>
									<b ng-bind="acti.activityAward"></b>
									<a class="icon change" ng-if="acti.judgepass" ng-click="edit(acti.applyId)"
                                       href=""></a>
								</span>
                    </p>
                </div>
            </div>
        </div>
    </div>

</div>
</body>
<script type="text/javascript">
    var countIsAuditing = 0;//正在被审核的并且被勾选的数量

    var app = angular.module("app", []).controller("ctrl", function ($scope) {
        scope = $scope;
        $scope.changing = true;
        $scope.init = function () {
            //初始化,默认未通过judgepass:false，未通过时就可以修改
            $scope.categories = [
                {
                    property: "思想政治教育类",
                    activityscore: 0,
                    judgescore: true,
                    activities: [],
                    selectNumbers: 0
                },
                {
                    property: "能力素质拓展类",
                    activityscore: 0,
                    judgescore: true,
                    activities: [],
                    selectNumbers: 0
                },
                {
                    property: "学术科技与创新创业类",
                    activityscore: 0,
                    judgescore: true,
                    activities: [],
                    selectNumbers: 0
                },
                {
                    property: "社会实践与志愿服务类",
                    activityscore: 0,
                    judgescore: true,
                    activities: [],
                    selectNumbers: 0
                },
                {
                    property: "社会工作与技能培训类",
                    activityscore: 0,
                    activities: [],
                    selectNumbers: 0
                },
                {
                    property: "综合奖励及其他类",
                    activityscore: 0,
                    activities: [],
                    selectNumbers: 0
                }
            ];
            //请求数据，显示在页面中
            $.ajax({
                url: "/jsons/laodStudentActivity.form",
                type: "post",
                dataType: "json",
                success: function (data) {
                    if (data != null && data.rows != null && data.rows.length > 0) {
                        var zhutituanData = [];//存放主题团数据的数组
                        for (var i = 0; i < data.rows.length; i++) {
                            //定义一个row数据接收数据
                            var row = data.rows[i];
                            if (row.supType == '主题团日') {        //如果该条记录是主题团日活动，则添加到主题团日活动的数组里，并结束此轮循环
                                row.theme = "true";//添加theme字段
                                zhutituanData.push(row);
                                continue;
                            }
                            //根据活动的分类，来分别在表格中显示不同的内容
                            var act_class = row.activityClass;
                            if (act_class == 3) {
                                if (row.supType == "非活动类") {
                                    row.activityAward = row.scienceClass;
                                    row.activityLevle = "--";
                                }
                            } else if (act_class == 5) {
                                if (row.supType == "非活动类" || row.supType == "学生干部任职") {
                                    var lvl = '';
                                    if (row.workClass == "学校组织")
                                        lvl = "校级";
                                    else if (row.workClass == "学院组织" || row.workClass == "社团")
                                        lvl = "院级";
                                    else
                                        lvl = "班级";
                                    row.activityLevle = (lvl ? lvl : "--");
                                    row.activityAward = (row.orgname ? row.orgname : "学生干部任职");
                                }
                            } else if (act_class == "6") {
                                row.activityAward = row.activityLevle;
                                row.activityLevle = "";
                            }
                            row.isPassed = true;
                            if (!(row.regimentAuditStatus == "已通过" || row.regimentAuditStatus == "待审核" )) {       //班级的审核状态验证
                                row.isPassed = false;
                                row.reasonText = row.regimentAuditReason;
                            }
                            if (!(row.collegeAuditStatus == "已通过" || row.collegeAuditStatus == "待审核" )) {         //学院的审核状态验证
                                row.isPassed = false;
                                row.reasonText = row.collegeAuditReason;
                            }
                            if (!(row.schoolAuditStaus == "已通过" || row.schoolAuditStaus == "待审核" )) {             //学校的审核状态验证
                                row.isPassed = false;
                                row.reasonText = row.schoolAuditReason;
                            }
                            row.level = lvl;
                            var activityLevle = '';
                            switch (row.activityLevle) {
                                case ("0"):
                                    activityLevle = "国际级";
                                    break;
                                case ("1"):
                                    activityLevle = "国家级";
                                    break;
                                case ("2"):
                                    activityLevle = "省级";
                                    break;
                                case ("3"):
                                    activityLevle = "市级";
                                    break;
                                case ("4"):
                                    activityLevle = "校级";
                                    break;
                                case ("5"):
                                    activityLevle = "院级";
                                    break;
                                case ("6"):
                                    activityLevle = "团支部级";
                                    break;
                                default:
                                    activityLevle = row.activityLevle;
                                    break;
                            }
                            //显示级别字段
                            row.level = activityLevle;
                            //判断是否已通过，如果未通过的可以编辑，
                            row.judgepass = false;
                            var obj = {};
                            switch (row.activityClass) {
                                case "1":
                                    row.judgepass = passJudge(row.schoolAuditStaus, row.collegeAuditStatus);
                                    passJudge(row.schoolAuditStaus, row.collegeAuditStatus);
                                    if (!row.activityCredit) {
                                        row.activityCredit = 0;
                                    }
                                    $scope.categories[0].activityscore += parseFloat(row.activityCredit);
                                    $scope.categories[0].activities.push(row);
                                    $scope.$apply();
                                    break;
                                case "2":
                                    row.judgepass = passJudge(row.schoolAuditStaus, row.collegeAuditStatus);
                                    if (!row.activityCredit) {
                                        row.activityCredit = 0;
                                    }
                                    $scope.categories[1].activityscore += parseFloat(row.activityCredit);
                                    $scope.categories[1].activities.push(row);
                                    $scope.$apply();
                                    break;
                                case "3":
                                    row.judgepass = passJudge(row.schoolAuditStaus, row.collegeAuditStatus);
                                    if (!row.activityCredit) {
                                        row.activityCredit = 0;
                                    }
                                    $scope.categories[2].activityscore += parseFloat(row.activityCredit);
                                    $scope.categories[2].activities.push(row);
                                    $scope.$apply();
                                    break;
                                case "4":
                                    //具有时长的活动计算活动分方式不同
                                    if (row.worktime) {
                                        row.activityCredit = Math.floor(((row.worktime) / 12) * 100) / 100
                                    }
                                    row.judgepass = passJudge(row.schoolAuditStaus, row.collegeAuditStatus);
                                    if (!row.activityCredit) {
                                        row.activityCredit = 0;
                                    }
                                    $scope.categories[3].activityscore = (parseFloat($scope.categories[3].activityscore) + parseFloat(row.activityCredit)).toFixed(2);
                                    $scope.categories[3].activities.push(row);
                                    $scope.$apply();
                                    break;
                                case "5":
                                    row.judgepass = passJudge(row.schoolAuditStaus, row.collegeAuditStatus);
                                    $scope.categories[4].activityscore += parseFloat(row.activityCredit);
                                    $scope.categories[4].activities.push(row);
                                    $scope.$apply();
                                    break;
                                case "6":
                                    row.judgepass = passJudge(row.schoolAuditStaus, row.collegeAuditStatus);
                                    $scope.categories[4].activityscore += parseFloat(row.activityCredit);
                                    $scope.categories[5].activities.push(row);
                                    $scope.$apply();
                                    break;
                            }
                        }
                        if (zhutituanData.length > 0) {
                            //添加主题团日活动的数据
                            var count = zhutituanData.length;
                            //学分的处理
                            var point = count >= 12 ? 1 : count >= 6 ? 0.6 : count >= 3 ? 0.3 : 0;
                            //判断是否undefined
                            if (!$scope.categories[0].activities.activityCredit) {
                                $scope.categories[0].activities.activityCredit = 0;
                            }
                            //如果是主题团活动就固定格式写法
                            var activity = {
                                activityTitle: "主题团日活动",
                                applyDate: "大学期间",
                                level: "校级",
                                activityCredit: $scope.categories[0].activities.activityCredit += point,
                                activityAward: "共计" + count + "次",
                                judge: true,
                                allactivity: zhutituanData,
                                isPassed: true
                            };
                            $scope.categories[0].activities.push(activity);
                            $scope.categories[0].activityscore += point;
                            $scope.$apply();
                            genner_ZhuTiTuanRi_detail(zhutituanData);       //生成主题团日详情的对话框
                        }
                    }
                },
                error: function () {
                    layer.msg("网络错误", {offset: ['30%']});
                }
            });
        };
        $scope.init();

        //跳转到修改页面传入数据
        $scope.edit = function (value) {
            window.location = "newReportCard.form?id=" + value;
        };

        $scope.showReason = function (activity) {
            if (activity.reasonText == null || activity.reasonText == "") {
                activity.reasonText = "暂无原因";
            }
            l_msg(activity.reasonText, 2);
        };

        $scope.gotoPage = function () {
            var index = 0;//记录遍历到第几大类
            var checkBoxSum = new Array();//记录每一大类各自有几个活动（选中的和没选中的）
            var checkedSum = new Array();//记录每一大类选中的活动有几个
            var flag = true;//每一大类至少选中了一项
            var newThemeActivity = [];//记录主题活动
            applyID = "";//记录非主题活动的applyid
            $scope.categories.forEach(function (item) {
                var countcheckBoxSum = 0;//记录当前类别有几个活动
                var countcheckedSum = 0;//记录当前类别有几个被选中的
                for (var i = 0; i < item.activities.length; i++) {
                    countcheckBoxSum++;
                    if (item.activities[i].checked === true) {
                        countcheckedSum++;
                    }
                }
                checkBoxSum.push(countcheckBoxSum);
                checkedSum.push(countcheckedSum);
            });
            //判断前三大类选中的总和不能超过12个
            if ((checkedSum[0] + checkedSum[1] + checkedSum[2]) > 12) {
                l_msg("前三大类选中的总和不能超过12个");
                return false;
            }
            //判断后三大类选中的总和不能超过12个
            if ((checkedSum[3] + checkedSum[4] + checkedSum[5]) > 12) {
                layer.msg("后三大类选中的总和不能超过12个");
                return false;
            }
            //xuanzhong

            //在当前类别有数据的情况下要至少选中其中一项
            for (var i = 0; i < 6; i++) {
                if (checkBoxSum[i] > 0 && checkedSum[i] < 1) {
                    flag = false;
                    break;
                }
            }

            if (countIsAuditing > 0) {
                l_msg("当前有正在被审核的活动被选中，不可被预览");
                return;
            }

            if (!flag) {
                l_msg("每一大类至少要选中一项");
                return;
            } else {//打印过程
                var newThemeActivity = [];
                var applyID = "";
                $scope.categories.forEach(function (item) {
                    for (var i = 0; i < item.activities.length; i++) {
                        if (item.activities[i].checked === true) {
                            if (typeof (item.activities[i].applyId) == "undefined") {
                                for (var j = 0; j < item.activities[i].allactivity.length; j++) {
                                    newThemeActivity.push(item.activities[i].allactivity[j]);
                                }
                            } else {
                                applyID += item.activities[i].applyId + "|";
                            }
                        }
                    }
                });
                var themeapplyID = "";
                for (var i = 0; i < newThemeActivity.length; i++) {
                    themeapplyID += newThemeActivity[i].applyId + "|";
                }
                themeapplyID = themeapplyID.substring(0, themeapplyID.length - 1);
                var newapplyID = applyID.substring(0, applyID.length - 1);
                if (newapplyID != null && newapplyID != "") {
                    $.ajax({
                        type: "post",
                        async: false,
                        url: "/printTranscript/setPrint.form",
                        data: {applyid: newapplyID, themeapplyID: themeapplyID},
                        dataType: "json",
                        success: function (data) {
                            if (data.result) {
                                l_msg("发送打印预览成功!", {offset: ['30%']});
                                countPoint(newapplyID);
                            } else {
                                l_msg("发送打印请求失败!", {offset: ['30%']});
                            }
                        },
                        error: function () {
                            l_msg("发送打印请求失败!", {offset: ['30%']});
                        }
                    });
                } else {
                    l_msg("请选择活动", {offset: ['30%']});
                    return false;
                }
            }
        };
        //选中
        $scope.choose = function (e, activity, category) {
            activity.checked = e.target.checked;
            if (activity.checked) {
                category.selectNumbers++;
            } else {
                category.selectNumbers--;
            }
            if (activity.schoolAuditStaus != '已通过' && activity.activityTitle !== "主题团日活动") {
                if (e.target.checked) {
                    l_msg("该活动正在被审核，可以被删除但不可被预览");
                    countIsAuditing++;
                } else {
                    countIsAuditing--;
                }
            }
        };
        //刪除

        $scope.delete = function () {
            var flag;
            $scope.categories.forEach(function (item) {
                for (var i = 0; i < item.activities.length; i++) {
                    if (item.activities[i].checked === true) {
                        flag = true;
                    }
                }
            });
            if (!flag) {
                l_msg("沒有选中");
                return;
            } else {
                var deleteItems = "";//记录有哪些选项被选中
                var delFlag = false;
                l_confirm("真的要删除它们么？", function () {
                    $scope.categories.forEach(function (item) {
                        for (var i = 0; i < item.activities.length; i++) {
                            if (item.activities[i].checked === true) {
                                if (item.activities[i].activityTitle === "主题团日活动") {
                                    l_msg("主题团日活动不可被删除");
                                    delFlag = true;
                                    return;
                                }
                                deleteItems += item.activities[i].applyId + " ";
                                item.activities.splice(i, 1);
                                i--;
                            }
                        }
                    });
                    if (delFlag) {
                        return;
                    }
                    deleteSelected(deleteItems.substring(0, deleteItems.length - 1));//减1是为了去掉最后一个多余的空格
                    $scope.$apply();
                    l_closeAll();
                }, function () {
                    l_closeAll();
                });
            }
        };
    });

    //审核是否通过的判断，通过的不可以修改编辑
    function passJudge(school, college) {
        if (school != "已通过" || college != "已通过") {
            return true;//true是可修改
        } else {
            return false;
        }
    }

    /*
     * 生成主题团日对话框
     * */
    function genner_ZhuTiTuanRi_detail() {
    }

    //删除选中项目
    function deleteSelected(deleteItems) {
        $.ajax({
            url: "/apply/deleteByIds.form",
            type: "post",
            data: {deleteItems: deleteItems},
            dataType: "json",
            success: function (data) {
                if (data.result == 1) {
                    l_msg("删除成功", {offset: ['30%']});
                    l_closeAll();
                } else if (data.result == 0) {
                    delsupplement(deleteItems);
                } else {
                    l_msg("删除失败，请重新登录或联系管理员", {offset: ['30%']});
                }
            }
        })
    }

    function delsupplement(id) {
        $.ajax({
            url: "/jsons/deletesupplement.form",
            type: "post",
            data: {id: id},
            async: false,
            success: function (data) {
                if (data.result) {
                    if (data.result) {
                        l_msg("删除成功", 2);
                        selectInfor();//重新加载数据
                    } else {
                        l_msg("删除失败，请重新登录或联系管理员", 2);
                    }
                }
            }
        })
    }

    function countPoint(newapplyID) {
//            var myChart = echarts.init(document.getElementById('charts'));
        $.ajax({
            url: "/printTranscript/countPoint.form",
            data: {applyid: newapplyID},
            type: "post",
            dataType: "json",
            async: false,
            success: function (data) {
                if (data != null && data != "") {
                    // 同步加载数据
                    $.ajax({
                        type: "post",
                        async: false,
                        url: "/char/loadSixElementPoint.form",
                        dataType: "json",
                        success: function (data) {
                            //因为applyID是全局变量为了不影响上面赋值 这里清空
                            applyID = "";
                            // 获得拼穿值
                            var years = generYears(data);
                            var servies = gennerData(data);
                            // 给option对应地方赋值
                            //option.legend.data = eval(years);
                            //  option.series = eval(servies);
                            //先清空之前的数据
//                                myChart.clear();
                            // 使用刚指定的配置项和数据显示图表。
//                                myChart.setOption(option);
                            l_msg("图表更新成功!", {offset: ['30%']});
                            insetToSort(newapplyID);
                        },
                        error: function () {
                            layer.msg("图表更新失败!", {offset: ['30%']});
                        }
                    });
                }
            },
            error: function () {
                layer.msg("发送打印预览失败!", {offset: ['30%']});
            }
        })
    }
    function insetToSort(newapplyID) {
        $.ajax({
            url: "/printTranscript/insetToSort.form",
            type: "post",
            data: {applyID: newapplyID},
            success: function (data) {
                if (data.result) {
                    $("input:checkbox").attr("checked", false);
                    setTimeout(function () {
                        window.open("/views/mobile/A4.form?&Enigmatic=", "_parent");
                    }, 1000);
                }
            }, error: function () {
                $("input:checkbox").attr("checked", false);
            }
        })
    }
    function generYears(data) {
        var list = [];
        for (var i = 0; i < data.total; i++) {
            list.push(data.rows[i].pointYear);
        }
        return list;
    }

    function gennerData(data) {
        var series = [];
        for (var i = 0; i < data.total; i++) {
            series.push({
                name: '能力成绩表',
                type: 'radar',
                data: [
                    {
                        value: [
                            data.rows[i].biaoda != null ? data.rows[i].biaoda : 50,
                            data.rows[i].zhixing != null ? data.rows[i].zhixing : 50,
                            data.rows[i].sibian != null ? data.rows[i].sibian : 50,
                            data.rows[i].lingdao != null ? data.rows[i].lingdao : 50,
                            data.rows[i].chuangxin != null ? data.rows[i].chuangxin : 50,
                            data.rows[i].chuangye != null ? data.rows[i].chuangye : 50
                        ],
                        name: data.rows[i].pointYear
                    }
                ]
            })
        }
        return series;
    }
</script>
</html>
