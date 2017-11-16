var app = angular.module('app', []);
app.controller('ctrl', function ($scope, $timeout) {
    $scope.navSele = 0; //导航下标
    $scope.activityLength = 5; //初始化显示的活动条数
    $scope.activities = {
        school: [],
        college: []
    };
    var schoolPage = 1;
    var collegePage = 1;
    $scope.loadMore = true; // 加载更多显示
    $scope.loading = true;

    // 类别初始化
    if (window.sessionStorage) {
        var sta = sessionStorage.getItem('indexStatus');
        if (sta == null || sta == '') {
            $scope.status = true;
        } else {
            $scope.status = (sta == 'true') ? true : false;
        }
    }

    // 学校活动列表初始化
    $scope.refresh = function () {
        // 加载时下滑不在加载
        if (!$scope.loadMore || !$scope.loading) {
            return;
        }
        if ($scope.status) {
            // 活动信息获取
            // 学校活动
            $.ajax({
                url: "/jsons/loadshoolActivtitys.form",
                data: {
                    page: schoolPage,
                    rows: $scope.activityLength
                },
                type: "post",
                dataType: "json",
                async: false,
                success: function (data) {
//                    var shoolTimes = Math.floor(data.total / $scope.activityLength);
                    if (data.rows.length == 0) {
                        $scope.loadMore = false; // 加载更多隐藏
                        // $scope.$apply();
                        return;
                    }
                    $scope.loading = false;
//                        console.log(data);
                    var temp = $scope.activities.school;
                    $scope.activities.school = temp.concat(data.rows);
                    // $scope.$apply();
                },
                error: function () {
                    console.log('学校活动获取失败');
                }
            });
        } else {
            // 学院活动
            $.ajax({
                url: "/jsons/loadcollegeActivtitys.form",
                data: {
                    page: collegePage,
                    rows: $scope.activityLength,
                    studentId: studentId
                },
                type: "post",
                dataType: "json",
                async: false,
                success: function (data) {
                    if (data.rows.length == 0) {
                        $scope.loadMore = false; // 加载更多隐藏
                        // $scope.$apply();
                        return;
                    }
                    $scope.loading = false;

                    var temp = $scope.activities.college;
                    $scope.activities.college = temp.concat(data.rows);
                    // $scope.$apply();
                },
                error: function () {
                    console.log('学院活动获取失败');
                }
            });
        }
    };

    // 切换学校、学院活动列表
    $scope.changeStatus = function (str) {
        $scope.loadMore = true; // 加载更多显示
        $scope.loading = true;

        if (str == '0') {
            $scope.status = true;
            schoolPage = 1;
            $scope.activities.school = [];
        } else {
            $scope.status = false;
            collegePage = 1;
            $scope.activities.college = [];
        }
        // 存储当前浏览类别
        var sta = $scope.status ? 'true' : 'false';
        if (window.sessionStorage) {
            sessionStorage.setItem('indexStatus', sta);
        }

        $scope.refresh();
    };
    $scope.refresh();

    // 加载更多功能
    //这个封装函数传入元素选择器，选择的元素当发生下拉时执行callback回调
    dropDownLoad('.container', function () {
        //下拉加载更多的逻辑
        $scope.loading = true;
        $scope.$apply();

        $timeout(function () {
            if ($scope.status) {
                schoolPage += 1;
            } else if (!$scope.status) {
                collegePage += 1;
            }
            $scope.refresh();

            // $scope.loading = false;
        }, 1000);

    });

    // 点击进入活动详情页
    $scope.actDetail = function (act) {
        window.location = "/views/mobile/activityDetail.form?activityId=" + act.activityId;
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
                break;
        }
    };
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
                return '其他';
                break;
        }
    };
    // 活动内容信息处理
    $scope.activityContent = function (content) {
        return content.replace(/<\/?[a-zA-Z]+[^><]*>/g, '').replace(/&nbsp;/ig, "");
        ;
    };
    //导航悬浮
    $(function () {
        $('.container').on('scroll', function () {
            if (this.scrollTop > $('.banner').height() + 20) {
                $scope.fly = true;
                $scope.$apply();
            }
            else {
                $scope.fly = false;
                $scope.$apply();
            }
        });
    })
});