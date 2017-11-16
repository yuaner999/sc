var app = angular.module('app', []);
app.controller('ctrl', function ($scope) {
    $scope.navSele = 1; //导航下标
    var applyId = getUrlParam("applyId");
    var id = getUrlParam("id");
    $scope.activity = {
        title: '',
        skills: '',//增长的能力
        level: '',//级别
        time: '',
        awards: ''
    };
    $scope.publicPeople = {
        name: '',
        college: '',
        major: '',
        class: '',
        stuNum: ''
    };

    // 加载详细信息
    if (applyId != null) {
        $.ajax({
            url: "/jsons/loadCheckDetailByApply.form",
            type: "post",
            dataType: "json",
            data: {applyId: applyId},
            success: function (data) {
                if (data.rows.length == 0) {
                    l_msg("该审核公示没有详细信息");
                    return;
                } else {
                    var activity = data.rows[0];
                    var time = activity.activitySdate.replace(/-/g, '/') + '--' + activity.activityEdate.replace(/-/g, '/');
                    $scope.activity = {
                        title: activity.activityTitle,
                        time: time,
                        level: activity.activityLevle,
                        skills: activity.activityPowers,
                        award: activity.activityAward
                    };
                    $scope.publicPeople = {
                        name: activity.studentName,
                        college: activity.stuCollageName,
                        major: activity.stuMajorName,
                        class: activity.stuClassName,
                        stuNum: activity.studentID
                    };
                    $scope.$apply();
                }
            }
        });
    } else if (id != null) {
        $.ajax({
            url: "/jsons/loadCheckDetailBySup.form",
            type: "post",
            dataType: "json",
            data: {id: id},
            success: function (data) {
                if (data.rows.length == 0) {
                    l_msg("该审核公示没有详细信息");
                    return;
                } else {
                    var supplement = data.rows[0];
                    $scope.activity = {
                        title: supplement.supActivityTitle,
                        time: supplement.takeDate,
                        level: supplement.supLevle,
                        skills: supplement.supPowers,
                        award: supplement.supAward
                    };
                    $scope.publicPeople = {
                        name: supplement.studentName,
                        college: supplement.stuCollageName,
                        major: supplement.stuMajorName,
                        class: supplement.stuClassName,
                        stuNum: supplement.studentID
                    };
                    $scope.$apply();
                }
            }
        });
    } else {
        l_msg("该审核公示没有详细信息");
    }

    //活动级别和能力格式转换
    $scope.levelReplace = function (level) {
        var alevel = "";
        switch (level) {
            case ("0"):
                alevel = "国际级";
                break;
            case ("1"):
                alevel = "国家级";
                break;
            case ("2"):
                alevel = "省级";
                break;
            case ("3"):
                alevel = "市级";
                break;
            case ("4"):
                alevel = "校级";
                break;
            case ("5"):
                alevel = "院级";
                break;
            case ("6"):
                alevel = "团支部级";
                break;
            default:
                alevel = "其他";
                break;
        }
        return alevel;
    };
    $scope.skillsReplace = function (skills) {
        return skills.replace(/能力/gi, "").replace(/\|/gi, "、");
    };


});
