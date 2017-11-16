var app = angular.module('app', []);
app.controller('ctrl', function ($scope, $timeout) {
    $scope.starsarry = [1, 2, 3, 4, 5];
    $scope.myactivitiesloadtype = window.sessionStorage["myactivitiesloadtype"]==null||window.sessionStorage["myactivitiesloadtype"]=="undefined"?"all":window.sessionStorage["myactivitiesloadtype"];
    $scope.myActivities = [];
    $scope.page = 1;
    $scope.rows = 5;
    $scope.total = 0; //这个类别的新闻一共有多少条
    $scope.loadMore = true; // 加载更多显示
    $scope.loading = true;

    //加载活动
    $scope.refresh = function () {
        // 加载时下滑不在加载
        if (!$scope.loadMore || !$scope.loading) {
            return;
        }
        if ($scope.myactivitiesloadtype == "all") {
            $.ajax({
                url: "/jsons/loadMyActivityAll.form",
                type: "post",
                async: false,
                dataType: "json",
                data: {page: $scope.page, rows: $scope.rows, applyStudentId: loginId},
                success: function (data) {
                    if (data.rows.length == 0) {
                        $scope.loadMore = false; // 加载更多隐藏
                        $scope.$apply();
                        return;
                    }
                    $scope.loading = false;
                    $scope.total = data.total;
                    $scope.myActivities = $scope.myActivities.concat(data.rows);
                    // $scope.$apply()
                    l_closeAll();
                },
                error: function (data) {
                    l_closeAll();
                    l_msg("数据请求失败，请稍后重试……");
                }
            });
        } else if ($scope.myactivitiesloadtype == "will") {
            $.ajax({
                url: "/jsons/loadMyActivityWill.form",
                type: "post",
                async: false,
                dataType: "json",
                data: {page: $scope.page, rows: $scope.rows, applyStudentId: loginId},
                success: function (data) {
                    if (data.rows.length == 0) {
                        $scope.loadMore = false; // 加载更多隐藏
                        $scope.$apply();
                        return;
                    }
                    $scope.loading = false;

                    $scope.total = data.total;
                    $scope.myActivities = $scope.myActivities.concat(data.rows);
                    // $scope.$apply()
                    l_closeAll();
                },
                error: function (data) {
                    l_closeAll();
                    l_msg("数据请求失败，请稍后重试……");
                }
            });
        } else if ($scope.myactivitiesloadtype == "underway") {
            $.ajax({
                url: "/jsons/loadMyActivityUnderway.form",
                type: "post",
                async: false,
                dataType: "json",
                data: {page: $scope.page, rows: $scope.rows, applyStudentId: loginId},
                success: function (data) {
                    if (data.rows.length == 0) {
                        $scope.loadMore = false; // 加载更多隐藏
                        $scope.$apply();
                        return;
                    }
                    $scope.loading = false;
                    $scope.total = data.total;
                    $scope.myActivities = $scope.myActivities.concat(data.rows);
                    // $scope.$apply()
                    l_closeAll();
                },
                error: function (data) {
                    l_closeAll();
                    l_msg("数据请求失败，请稍后重试……");
                }
            });
        } else if ($scope.myactivitiesloadtype == "end") {
            $.ajax({
                url: "/jsons/loadMyActivityEnd.form",
                type: "post",
                async: false,
                dataType: "json",
                data: {page: $scope.page, rows: $scope.rows, applyStudentId: loginId},
                success: function (data) {
                    if (data.rows.length == 0) {
                        $scope.loadMore = false; // 加载更多隐藏
                        $scope.$apply();
                        return;
                    }
                    $scope.loading = false;
                    $scope.total = data.total;
                    $scope.myActivities = $scope.myActivities.concat(data.rows);
                    // $scope.$apply()
                    l_closeAll();
                },
                error: function (data) {
                    l_closeAll();
                    l_msg("数据请求失败，请稍后重试……");
                }
            });
        }
    };

    $scope.refresh();


//	逻辑
    //导航下标
    $scope.navSele = 3;
//	绑定活动
    $scope.changeCondition = function (txt) {
        if ($scope.myactivitiesloadtype != txt) {
            // l_loading();
            $scope.myactivitiesloadtype = txt;
            $scope.page = 1;
            $scope.myActivities = [];
            $scope.loadMore = true; // 加载更多显示
            $scope.loading = true;
            $timeout(function () {
                $scope.refresh();
            }, 200);
        }
    }


    dropDownLoad('.container', function () {
        //下拉加载更多的逻辑
        $scope.loading = true;
        $scope.$apply();
        $timeout(function () {
            // if($scope.myActivities.length<$scope.total){
            $scope.page = $scope.page + 1;
            $scope.refresh();
            // }
            $scope.loading = false;

        }, 1000);
    });
    //过滤文本中的HTML标签
    $scope.filtercontenthtml = function (content) {
        return content.replace(/<(.|\n)+?>/gi, "").replace(/&nbsp;/ig, "");
    };
    // 能力信息处理
    $scope.activityPowers = function (powers) {
        return powers.replace(/能力/g, '').split('|');
    };
    // 活动级别信息处理
    $scope.activityLevle = function (level) {
        switch (level) {
            case '0':
                return '国际级';
                break;
            case '1':
                return '国家级';
                break;
            case '2':
                return '省级';
                break;
            case '3':
                return '市级';
                break;
            case '4':
                return '校级';
                break;
            case '5':
                return '院级';
                break;
            case '6':
                return '团支部级';
                break;
            default:
        }
    };
    //活动类别
    $scope.activityClassMean = function (type) {
        switch (type) {
            case '1':
                return '思想政治教育类';
                break;
            case '2':
                return '能力素质拓展类';
                break;
            case '3':
                return '学术科技与创新创业类';
                break;
            case '4':
                return '社会实践与志愿服务类';
                break;
            case '5':
                return '社会工作与技能培训类';
                break;
            case '6':
                return '综合奖励及其他类';
                break;
            default:
        }
    }

    // 活动性质信息处理
    $scope.activityNature = function (nature) {
        switch (nature) {
            case '1':
                return '活动参与';
                break;
            case '2':
                return '讲座报告';
                break;
            case '3':
                return '比赛';
                break;
            case '4':
                return '培训';
                break;
            default:
        }
    };
    //评价
    $scope.evaluation = function (obj) {
        obj.evaluation = true;//开始评价
    }
    //点击五角星改变评分
    $scope.star = function (index, item) {
        if (item.activitypoint == null || item.activitypoint == "" || item.activitypoint == 0) {
            item.tmp = index;
        }

    }
    //打分初始化
    $scope.initrate = function (item) {
        if (item.activitypoint != null && item.activitypoint != "" && item.activitypoint != 0) {
            item.tmp = item.activitypoint;
        }
    }
    $scope.evaluated = function (obj) {
        if (obj.tmp == 0 || obj.tmp == null || obj.tmp == "") {
            l_msg("请打分！")
        } else {
            l_loading('保存中……');
            $.ajax({
                url: "/jsons/updateRate.form",
                type: "post",
                async: false,
                dataType: "json",
                data: {activitypoint: obj.tmp, applyStudentId: loginId, applyActivityId: obj.applyActivityId},
                success: function (data) {
                    l_closeAll();
                    if (data.result) {
                        l_msg('评价成功');
                        obj.activitypoint = obj.tmp;
                    } else {
                        l_msg(data.errormessage);
                    }
                },
                error: function (data) {
                    l_closeAll();
                    l_msg("数据保存错误，请稍后重试……");
                }

            });
        }

    };
    //进入活动详情页
    $scope.togodetail = function (item) {
        window.sessionStorage["myactivitiesloadtype"]=$scope.myactivitiesloadtype;
        window.location = "activityDetail.form?activityId=" + item.activityId;
    }
    //判断活动是否结束，结束的活动才能够评价
    $scope.isActivityEnd=function (item) {
        if(item.activityEdate<=new Date().getTime())
            return true;
        return false;
    }
});
