var app = angular.module('app', []);
app.controller('ctrl', function ($scope) {
    $scope.user = {
        studentName: '',
        collegeName: '',
        majorName: '',
        className: '',
        studentID: '',
        studentPhone: '',
        studentPhoto: "/Files/Images/default.jpg"
    };
    $.ajax({
        url: "/StudentInfo/loadStudentInfo.form",
        type: "post",
        dataType: "json",
        success: function (data) {
            //将信息写入
            if (data.rows && data.rows.length > 0) {
                $scope.user = data.rows[0];
                if (data.rows[0].studentPhoto != null && data.rows[0].studentPhoto != "") {
                    $scope.user.studentPhoto = "/Files/Images/" + data.rows[0].studentPhoto;
                }
                $scope.$apply();
            }
        },
        error: function () {
            layer.alert("服务器连接失败");
        }
    });

    //导航下标
    $scope.navSele = 3;
//	修改头像
//     $scope.changePhoto = function () {
//         wx.chooseImage({
//             count: 1, // 默认9
//             sizeType: ['original', 'compressed'], // 可以指定是原图还是压缩图，默认二者都有
//             sourceType: ['album', 'camera'], // 可以指定来源是相册还是相机，默认二者都有
//             success: function (res) {
//                 var localIds = res.localIds; // 返回选定照片的本地ID列表，localId可以作为img标签的src属性显示图片
//
//                 // l_msg(localIds[0]);
//                 wx.uploadImage({
//                     localId: localIds[0], // 需要上传的图片的本地ID，由chooseImage接口获得
//                     isShowProgressTips: 1, // 默认为1，显示进度提示
//                     success: function (res) {
//                         l_loading();
//                         var serverId = res.serverId; // 返回图片的服务器端ID
//                         $.post('/No_Intercept/WeChat/downImage.form', {mediaId:serverId}, function (data) {
//                             l_closeAll();
//                             if (data == "0") {
//                                 l_msg("修改照片出错");
//                             } else {
//                                 $scope.user.studentPhoto = "/Files/Images/" + data;
//                                 $scope.$apply();
//                             }
//                         });
//                     }
//                 });
//             }
//         });
//
//     };
    //退出登录
    $scope.exit = function () {
        l_confirm('是否退出登录', function () {
            $.ajax({
                url:"/AppLogin/ExitLogin.form",
                type:"post",
                dataType:"json",
                success:function (data) {
                    $.cookie("studentId", "", { path: '/' });
                    $.cookie("passwd", "", { path: '/' });
                    window.location.href = "/views/mobile/login.form"
                }
            });
        }, function () {
        }, ['退出', '取消'])
    }
});
