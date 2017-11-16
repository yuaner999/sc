var app = angular.module('app', []);
app.controller('ctrl', function ($scope, $timeout) {
    $scope.navSele = 1; //导航下标
    var page = 1;
    var rows = 5;
    var collageName = "";
    var majorName = "";
    var gradeName = "";
    var className = "";
    var searchName = "";
    $scope.studentId = studentid;
    //筛选条件
    $scope.conditions = [
        {
            name: '学院',
            list: []
        },
        {
            name: '专业',
            list: []
        },
        {
            name: '年级',
            list: []
        },
        {
            name: '班级',
            list: []
        }
    ];

    //初始化
    $scope.init = function () {
        $scope.reviews = [];
        page = 1;
        $scope.loadMore = true; // 加载更多显示
        $scope.loading = true;
        $scope.refresh();
        // $scope.$apply();
    };

    $scope.refresh = function () {
        //加载时下滑不在加载
        if (!$scope.loadMore || !$scope.loading) {
            return;
        }
        $.ajax({
            url: "/AppActivityInfo/loadCheckActivities.form",
            type: "post",
            data: {
                page: page,
                rows: rows,
                scollege: collageName,
                sname: searchName,
                smajor: majorName,
                sgrade: gradeName,
                sclass: className
            }, /*,sact:sact*/
            dataType: "json",
            success: function (data) {
                if (data.rows == null || data.rows.length == 0) {
                    $scope.loadMore = false; // 加载更多显示
                    $scope.$apply();
                    return;
                }
                $scope.loading = false;
                var temp = $scope.reviews;
                $scope.reviews = temp.concat(data.rows);
                $scope.$apply();
            }
        });
    };
    $scope.init();

    //初始化筛选条件
    var list = [{name: "全部"}];
    $scope.loadCollegeName = function () {
        l_loading("加载学院中...");
        $.ajax({
            url: "/jsons/loadCollageName.form",
            dataType: "json",
            success: function (data) {
                l_closeAll();
                $scope.conditions[0].list = list.concat(data.rows);
                $scope.$apply();
            },
            error:function (data) {
                l_closeAll();
                l_msg("加载学院失败");
            }
        });
    };
    $scope.loadMajorName = function (collageName) {
        l_loading("加载专业中...");
        $.ajax({
            url: "/jsons/loadMajorName.form",
            dataType: "json",
            data: {stuCollageName: collageName},
            success: function (data) {
                l_closeAll();
                $scope.conditions[1].list = list.concat(data.rows);
                $scope.$apply();
            },
            error:function (data) {
                l_closeAll();
                l_msg("加载专业失败");
            }
        });
    };
    $scope.loadGradeName = function (majorName) {
        l_loading("加载年级中...");
        $.ajax({
            url: "/jsons/loadGradeName.form",
            dataType: "json",
            data: {stuMajorName: majorName},
            success: function (data) {
                l_closeAll();
                $scope.conditions[2].list = list.concat(data.rows);
                $scope.$apply();
            },
            error:function (data) {
                l_closeAll();
                l_msg("加载年级失败");
            }
        });
    };
    $scope.loadClassName = function (collageName, majorName, gradeName) {
        l_loading("加载班级中...");
        $.ajax({
            url: '/jsons/loadClassName.form',
            dataType: "json",
            data: {stuGradeName: gradeName, stuCollageName: collageName, stuMajorName: majorName},
            success: function (data) {
                l_closeAll();
                $scope.conditions[3].list = list.concat(data.rows);
                $scope.$apply();
            },
            error:function (data) {
                l_closeAll();
                l_msg("加载班级失败");
            }
        });
    };

    $scope.loadCollegeName();

    //处理活动时间
    $scope.timeReplace = function (activitySdate1, activityEdate1, signUpTime1) {
        if (activitySdate1 || activityEdate1) {
            return activitySdate1.replace(/-/g, '/') + '--' + activityEdate1.replace(/-/g, '/');
        } else {
            return signUpTime1.replace(/-/g, '/');
        }
    };

    // 加载更多功能
    //这个封装函数传入元素选择器，选择的元素当发生下拉时执行callback回调
    dropDownLoad('.container', function () {
        //下拉加载更多的逻辑
        $scope.loading = true;
        $scope.$apply();
        $timeout(function () {
            page += 1;
            $scope.refresh();
        }, 1000);
    });

    //改变筛选条件事件
    $scope.changing = function (val, name) {
        if (val == null) {
            return;
        }
        if (name == "学院") {
            if (val.name == "全部") {
                collageName = "";
                majorName = "";
                gradeName = "";
                className = "";
                $scope.conditions[1].list = [];
            } else {
                collageName = val.name;
                $scope.loadMajorName(collageName);
            }
            $scope.conditions[2].list = [];
            $scope.conditions[3].list = [];
            $scope.init();
        } else if (name == "专业") {
            if (val.name == "全部") {
                majorName = "";
                gradeName = "";
                className = "";
                $scope.conditions[2].list = [];
            } else {
                majorName =  val.name;
                $scope.loadGradeName(majorName);
            }
            $scope.conditions[3].list = [];
            $scope.init();
        } else if (name == "年级") {
            if (val.name == "全部") {
                gradeName = "";
                className = "";
                $scope.conditions[3].list = [];
            } else {
                gradeName = val.name;
            }
            $scope.loadClassName(collageName, majorName, gradeName);
            $scope.init();
        } else if (name == "班级") {
            className = val.name == "全部" ? "" : val.name;
            $scope.init();
        } else {
            $scope.init();
        }
    };
    //搜索事件
    $scope.search = function (val) {
        searchName = val;
        $scope.init();
    };
    //查看详情
    $scope.detail = function (item) {
        if (item.applyId != null) {
            window.location.href = "/views/mobile/showDetail.form?applyId=" + item.applyId;
        } else if (item.id != null && item.applyId == null) {
            window.location.href = "/views/mobile/showDetail.form?id=" + item.id;
        } else {
            l_msg("错误");
        }

    };
    //举报
    $scope.report = function (item) {
        var id = item.applyId == null ? item.id : item.applyId;

        var url = encodeURI("/views/mobile/query.form?id=" + id + "&student=" + item.studentID + "&actitle=" + item.activityTitle + "&award" + item.activityAward);
        url = encodeURI(url);
        window.location.href = url;

    }
});