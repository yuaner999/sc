var app = angular.module('app', []);
app.controller('ctrl', function ($scope) {
    $scope.navSele = 1; //导航下标
    var id = getUrlParam("id");
    var title = decodeURI(getUrlParam("actitle").toString());
    var award = decodeURI(getUrlParam("award"));
    award = award == "null" ? "" : award;
    var studentId = getUrlParam("student");
    $scope.user = {
        name: studentName,
        phone: phone
    };
    $scope.cause = null;

    $scope.confirm = function () {
        if ($scope.cause == null || $scope.cause == "") {
            l_msg("举报内容不能为空");
            return;
        }
        l_loading();
        //验证重复举报
        $.ajax({
            url: "/AppCheck/checkReportAgain.form",
            type: "post",
            data: {
                informStudentId: studentId,
                informApplyId: id,
                informTel: $scope.user.phone
            },
            dataType: "json",
            timeout: 30000,
            success: function (data) {
                if (data.rows.length > 0) {
                    l_closeAll();
                    l_msg("同学，你已经举报过了！");
                } else {
                    //保存举报信息
                    $.ajax({
                        url: "/AppCheck/insertReportInfo.form",
                        type: "post",
                        data: {
                            informContent: $scope.cause,
                            informStudentId: studentId,
                            informApplyId: id,
                            informTel: $scope.user.phone,
                            acttitle: title,
                            actaward: award
                        },
                        dataType: "json",
                        timeout: 30000,
                        success: function (data) {
                            l_closeAll();
                            if (data.resultSet) {
                                l_msg("举报成功");
                                window.location.href="/views/mobile/review.form";
                            } else {
                                l_msg(data.errormessage, 2, function () {
                                    window.location.href="/views/mobile/review.form";
                                });
                            }
                        }
                    });
                    l_closeAll();
                }
            }
        });
    }
});