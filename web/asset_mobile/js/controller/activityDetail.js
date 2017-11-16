// 接收活动id
var actId = getUrlParam('activityId');

var app = angular.module('app', []);
app.controller('ctrl', function ($scope, $timeout) {
    $scope.navSele = 1; //导航下标
    $scope.signup = false; // 是否报名
    $scope.invalidAct = false; // 是否是团体活动/活动已经结束/报名已经截止
    $scope.remark = false; // 活动未结束为隐藏状态

    // 活动详情初始化
    $scope.refresh = function () {
        //数据
        //活动列表
        $.ajax({
            type: "post",
            url: "/jsons/mobileLoadActDetail.form",
            data: {
                actId: actId
            },
            dataType: "json",
            async: false,
            success: function (data) {
                $scope.activity = data.rows[0];
                $('.txt').html($scope.activity.activityContent); // 设置活动内容

                // 团体活动/报名已经截止（隐藏报名按钮）
                if ($scope.activity.activityParticipation == "团体"
                    || $scope.activity.activityApplyedate <= new Date() || $scope.activity.online != '0') {
                    $scope.invalidAct = true;
                }
                // 活动已经结束（隐藏‘报名’，显示‘评分’）
                if ($scope.activity.activityEdate < new Date()) {
                    $scope.invalidAct = true;
                    $scope.remark = true;

                    //计算星星评分
                    var num = $scope.activity.grade;
                    if (num <= 5) {
                        var arr = [{}, {}, {}, {}, {}];//五个空星星
                        for (i = 0; i < num; i++) {
                            arr[i].all = "all";
                        }
                        if (num > parseInt(num)) {
                            arr[parseInt(num)].all = null;
                            arr[parseInt(num)].helf = 'helf';//半星
                        }
                    }
                    $scope.grade = arr;
                }
            },
            error: function () {
                console.log("活动详情获取失败");
            }
        });
        // 是否报过名
        $.ajax({
            url: "/jsons/validatePCApply.form",
            type: "post",
            data: {actid: actId},
            datatype: "json",
            async: false,
            success: function (data) {
                if (data.total !== 0) {
                    $scope.signup = true;
//                        console.log("已经报过名");
                }
            }
        });
    };

    //点击报名
    $scope.go = function () {
        l_loading();

        $.ajax({
            url: "/jsons/applyPCAct.form",
            type: "post",
            data: {actid: actId},
            datatype: "text",
            success: function (data) {
                l_closeAll();
                if (data == "申请成功") {
                    l_msg('申请成功', 2);
                    $scope.signup = true;
                    $scope.$apply();
                }
            }
        });
        l_closeAll();

    };

    // 活动内容信息处理
    $scope.activityContent = function (content) {
        return content.replace(/<\/?[a-zA-Z]+[^><]*>/g, '');
    };
    //格式化日期把毫秒值转成字符串
    $scope.dateformat = function (time, formateStr) { //author: meizz
        var date;
        if (!formateStr) formateStr = "yyyy-MM-dd";
        if (time) date = new Date(time);
        else date = new Date();
        var year = date.getFullYear();
        var month = date.getMonth() + 1;
        var day = date.getDate();
        var h = date.getHours();
        var min = date.getMinutes();
        var sec = date.getSeconds();
        formateStr = formateStr.replace("yyyy", "" + year);
        formateStr = formateStr.replace("MM", "" + month > 9 ? month : "0" + month);
        formateStr = formateStr.replace("dd", "" + day > 9 ? day : "0" + day);
        formateStr = formateStr.replace("HH", "" + h > 9 ? h : "0" + h);
        formateStr = formateStr.replace("mm", "" + min > 9 ? min : "0" + min);
        formateStr = formateStr.replace("ss", "" + sec > 9 ? sec : "0" + sec);
        return formateStr;
    };

    $scope.refresh();
});