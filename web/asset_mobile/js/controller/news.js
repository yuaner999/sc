var app = angular.module('app', []);
app.controller('ctrl', function ($scope, $timeout) {
    var newstype = window.sessionStorage["newsloadtype"];
    $scope.newsloadtype = newstype == null || newstype == "" ? 0 : newstype;
    $scope.total = 0;  //这个类别的新闻一共有多少条
    $scope.navSele = 2; //导航下标
    // $scope.newsloadtype = 0;
    $scope.nowList = [];
    $scope.page = 1;
    $scope.rows = 10;
    $scope.loadMore = true; // 加载更多显示
    $scope.loading = true;

    $scope.refresh = function () {
        // 加载时下滑不在加载
        if (!$scope.loadMore || !$scope.loading) {
            return;
        }
        if ($scope.newsloadtype == 0) {
            $.ajax({
                url: "/jsons/loadPointNews.form",
                type: "post",
                async: false,
                dataType: "json",
                data: {page: $scope.page, rows: $scope.rows},
                success: function (data) {
                    if (data.rows.length == 0) {
                        $scope.loadMore = false; // 加载更多隐藏
                        $scope.$apply();
                        return;
                    }
                    $scope.loading = false;
                    $scope.total = data.total;
                    $scope.nowList = $scope.nowList.concat(data.rows);
                    // $scope.$apply()
                },
                error: function (data) {
                    l_msg("数据请求失败，请稍后重试……");
                }
            });
        } else {
            $.ajax({
                url: "/jsons/loadPioneerYouth.form",
                type: "post",
                async: false,
                dataType: "json",
                data: {page: $scope.page, rows: $scope.rows},
                success: function (data) {
                    if (data.rows.length == 0) {
                        $scope.loadMore = false; // 加载更多隐藏
                        $scope.$apply();
                        return;
                    }
                    $scope.loading = false;
                    $scope.total = data.total;
                    $scope.nowList = $scope.nowList.concat(data.rows);
                    // $scope.$apply();
                },
                error: function (data) {
                    l_msg("数据请求失败，请稍后重试……");
                }
            });
        }
    };

    $scope.refresh();

    $scope.render = function (type) {
        $scope.newsloadtype = type;
        $scope.page = 1;    //每次切换选项卡后将页数重新初始化
        $scope.nowList = [];
        $scope.loadMore = true; // 加载更多显示
        $scope.loading = true;
        $timeout(function () {
            $scope.refresh();
        }, 200);
    };

    //这个封装函数传入元素选择器，选择的元素当发生下拉时执行callback回调
    dropDownLoad('.container', function () {
        //下拉加载更多的逻辑
        $scope.loading = true;
        $scope.$apply();
        $timeout(function () {
            $scope.page = $scope.page + 1;
            $scope.refresh();
            $scope.loading = false;

        }, 1000);
    });

    $scope.contentReplace = function (content) {
        return content.replace(/<(.|\n)+?>/gi, "").replace(/&nbsp;/ig, "");
    };

    $scope.gotodetail = function (newsId) {
        window.sessionStorage["newsloadtype"] = $scope.newsloadtype;
        window.location = "newsDetail.form?newsId=" + newsId;
    }

});
