var app = angular.module('app', []);
app.controller('ctrl', function ($scope, $timeout) {
    $scope.navSele = 1; //导航下标
    var page = 1;
    var rows= 5;
    $scope.loading = true;
    $scope.loadMore = true;
    $scope.activities = [];
    var aclass = ''; // 项目类别
    var alevel = ''; // 项目级别
    var anature = ''; // 项目性质
    var apower = ''; // 能力方向
    var apartic = ''; // 参与形式
    var asearch = ''; // 搜索内容

    // 初始化活动数据
    $scope.refresh = function () {
        // 加载时下滑和加载到最后不在加载
        if (!$scope.loadMore || !$scope.loading) {
            return;
        }
        $.ajax({
            url: "/jsons/loadMobileAct.form",
            type: "post",
            async: false,
            data: {
                page: page,
                rows: rows,
                stuCollageName:stuCollageName,
                activityClass: aclass,
                activityLevle: alevel,
                activityNature: anature,
                activityPowers: apower,
                activityParticipation: apartic,
                activityTitle: asearch
            },
            dataType: "json",
            success: function (data) {
                if (data.rows.length == 0) {
                    $scope.loadMore = false; // 加载更多隐藏
                    $scope.$apply();
                    return;
                }
                $scope.loading = false;
                $scope.total = data.total; // 活动总条数
                $scope.activities = $scope.activities.concat(data.rows);
                // console.log($scope.activities);
                // $scope.$apply();
            },
            error: function () {
                layer.msg("服务器连接失败，请稍后再试");
                layer.closeAll('loading');
            }
        });
    };
    $scope.refresh();

    //筛选条件
    $scope.conditions = [
        {
            id: 'aclass',
            name: '项目类别',
            list: ['全部', '思想政治教育类', '能力素质拓展类', '学术科技与创新创业类', '社会实践与志愿服务类', '社会工作与技能培训类']
        }, {
            id: 'alevel',
            name: '项目级别',
            list: ['全部', '国际级', '国家级', '省级', '市级', '校级', '院级', '团支部级']
        }, {
            id: 'anature',
            name: '项目性质',
            list: ['全部', '活动参与', '讲座报告', '比赛', '培训', '其它']
        }, {
            id: 'apower',
            name: '能力方向',
            list: ['全部', '思辨能力', '执行能力', '表达能力', '领导能力', '创新能力', '创业能力']
        }, {
            id: 'apartic',
            name: '参与形式',
            list: ['全部', '个人', '团体']
        }
    ];

    //改变筛选条件事件
    $scope.changing = function (val, text) {

        switch (val) {
            case '项目类别':
                aclass = text; // 项目类别
                switch (aclass) {
                    case ("思想政治教育类"):
                        aclass = "1";
                        break;
                    case ("能力素质拓展类"):
                        aclass = "2";
                        break;
                    case ("学术科技与创新创业类"):
                        aclass = "3";
                        break;
                    case ("社会实践与志愿服务类"):
                        aclass = "4";
                        break;
                    case ("社会工作与技能培训类"):
                        aclass = "5";
                        break;
                    case ("全部"):
                        aclass = null;
                        break;
                    case ("未选择"):
                        aclass = null;
                        break;
                    default:
                        aclass = null;
                        break;
                }
                break;
            case '项目级别':
                alevel = text; // 项目级别
                switch (alevel) {
                    case ("国际级"):
                        alevel = "0";
                        break;
                    case ("国家级"):
                        alevel = "1";
                        break;
                    case ("省级"):
                        alevel = "2";
                        break;
                    case ("市级"):
                        alevel = "3";
                        break;
                    case ("校级"):
                        alevel = "4";
                        break;
                    case ("院级"):
                        alevel = "5";
                        break;
                    case ("团支部级"):
                        alevel = "6";
                        break;
                    case ("全部"):
                        alevel = null;
                        break;
                    case ("未选择"):
                        alevel = null;
                        break;
                    default:
                        alevel = null;
                        break;
                }
                break;
            case '项目性质':
                anature = text; // 项目性质
                switch (anature) {
                    case ("活动参与"):
                        anature = "1";
                        break;
                    case ("讲座报告"):
                        anature = "2";
                        break;
                    case ("比赛"):
                        anature = "3";
                        break;
                    case ("培训"):
                        anature = "4";
                        break;
                    case ("其它"):
                        anature = "5";
                        break;
                    case ("全部"):
                        anature = null;
                        break;
                    case ("未选择"):
                        anature = null;
                        break;
                    default:
                        anature = null;
                        break;
                }
                break;
            case '能力方向':
                apower = text; // 能力方向
                if (apower == "全部" || apower == "未选择") {
                    apower = null;
                }
                break;
            case '参与形式':
                apartic = text; // 参与形式
                if (apartic == "全部" || apartic == "未选择") {
                    apartic = null;
                }
                break;
            case '搜索':
                asearch = $scope.searchResult; // 搜索内容
                break;
            default:
                break;
        }
        page = 1;
        $scope.activities = [];
        $scope.loading = true;
        $scope.loadMore = true;
        $scope.refresh();
        // l_msg('好的');
    };

    //这个封装函数传入元素选择器，选择的元素当发生下拉时执行callback回调
    dropDownLoad('.container', function () {
        //下拉加载更多的逻辑
        $scope.loading = true;
        $scope.$apply();
        $timeout(function () {
            // if ($scope.activities.length < $scope.total) {
                page += 1;
                $scope.refresh();
            // }
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
});