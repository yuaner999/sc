var app = angular.module('app', []);
app.controller('ctrl', function ($scope, $timeout) {
    $scope.navSele = 1;//导航下标
    var page = 1; //当前页码数
    var rows = 10; //每页行数
    $scope.loadMore = true; // 加载更多显示
    $scope.loading = true;
    $scope.activities = [];

    $scope.refresh = function () {
        //加载时下滑不在加载
        if (!$scope.loadMore || !$scope.loading) {
            return;
        }
        $.ajax({
            url: "/jsons/loadUnsigninActivity.form",
            type: "post",
            dataType: "json",
            data: {
                studentID: studentID,
                page: page,
                rows: rows
            },
            success: function (data) {
                if (data.rows.length == 0) {
                    $scope.loadMore = false; // 加载更多显示
                    if (page == 1) {
                        $scope.activities = data.rows;
                    }
                    $scope.$apply();
                    return;
                }
                $scope.loading = false;
                var temp = $scope.activities;
                $scope.activities = temp.concat(data.rows);

                $scope.$apply();
                //删除滑动
                dropFlag($scope);
            }
        });
    };
    $scope.refresh();

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

    //点击签到
    $scope.signin = function (obj) {
        l_loading();
        var applyId = obj.applyId;
        var activityId = obj.activityId;
        $.ajax({
            url: "/StudentInfo/signIn.form",
            type: "post",
            dataType: "json",
            data: {
                applyId: applyId,
                activityId: activityId
            },
            success: function (data) {
                l_closeAll();
                if (data.status == '1') {
                    var content = data.data;
                    layer.open({
                        content: '<div id="qrcode"></div><span style="color:#757575;">扫一扫上面的二维码图案完成签到</span>'
                        , anim: 'up'
                        , style: 'border-radius:0;'
                    });
                    $("#qrcode").qrcode({
                        width: 250, //宽度
                        height: 250, //高度
                        text: content //任意内容
                    });
                } else {
                    l_msg(data.msg);
                }
            }
        });
        l_closeAll();
    };
    //删除
    $scope.deleteA = function (obj, idx, $event) {
        l_confirm('确定删除么？', function () {
            l_loading();
            $.ajax({
                url: "/jsons/deleteSigninActivity.form",
                type: "post",
                dataType: "json",
                data: {
                    applyId: obj[idx].applyId
                },
                success: function (data) {
                    if (data.result) {
                        l_closeAll();
                        l_msg("删除成功", 1, function () {
                            page = 1;
                            $scope.loading = true;
                            $scope.loadMore = true;
                            $scope.activities = [];
                            $scope.refresh();
                            // $scope.$apply();
                        });
                    } else {
                        l_closeAll();
                        l_msg(data.errormessage);
                        $($event).removeClass('dropLeft');
                        $scope.$apply();
                    }
                }
            });

        }, function () {
            l_closeAll();
            $($event).removeClass('dropLeft');
            $scope.$apply();
        });
    };
    // 活动内容信息处理
    $scope.activityContent = function (content) {
        return content.replace(/<\/?[a-zA-Z]+[^><]*>/g, '').replace(/&nbsp;/ig, "");
    };
});
//左划删除判断
function dropFlag(scope) {
    dropLeftLoad('.activity', function (obj,i) {
        $(obj).addClass('dropLeft');
        scope.deleteA(scope.activities,i,$(obj));
    });
}
