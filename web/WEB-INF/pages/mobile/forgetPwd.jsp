<%--
  Created by IntelliJ IDEA.
  User: lirf
  Date: 2017/6/6
  Time: 8:39
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>忘记密码</title>
    <meta name="viewport"
          content="width=device-width,initial-scale=1,minimum-scale=1,maximum-scale=1,user-scalable=no"/>
    <!--通用css-->
    <link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/asset_mobile/css/common.css"/>
    <link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/asset_mobile/css/layout.css"/>
    <!--单独css-->
    <link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/asset_mobile/css/change.css"/>
    <!--js-->
    <!--zepto 代替jq-->
    <script src="<%=request.getContextPath()%>/asset_mobile/js/zepto.1.2.0.min.js" type="text/javascript"
            charset="utf-8"></script>
    <%--<script src="<%=request.getContextPath()%>/asset_mobile/js/common.js" type="text/javascript" charset="utf-8"></script>--%>
    <!--layer-->
    <script src="<%=request.getContextPath()%>/asset_mobile/js/layer_mobile/layer.js" type="text/javascript"
            charset="utf-8"></script>
    <!--封装好的好理解layer-->
    <script src="<%=request.getContextPath()%>/asset_mobile/js/layer-packaged.js" type="text/javascript"
            charset="utf-8"></script>

</head>
<%--<%@include file="../mobile/CheckWeixin.jsp"%>--%>
<body>
<div class="container">
    <div class="input-group padding">
        <div class="input-row">
            <span>学号</span>
            <input type="text" class="_3" id="stuNum" placeholder="请输入学号" maxlength="16">
        </div>
        <div class="input-row">
            <span>验证码</span>
            <input type="number" class="_3" id="checkNum" placeholder="请输入验证码" maxlength="16">
            <%--验证码--%>
            <div class=" checkimg">
                <%--图片--%>
                <img id="checkcode" src="" alt="">
            </div>
        </div>
        <span class="hint">*若未提供邮箱，请联系辅导员</span>
    </div>
    <button class="blue-btn block col-90 center" type="button" onclick="sendEmail()">发送验证邮件</button>
</div>
<script type="text/javascript">
    $(function () {
        $("#checkcode").attr("src", "/jsons/checkcode.form?a=" + Math.random());
    });
    //找回密码的验证码
    $("#checkcode").click(function () {
        $("#checkcode").attr("src", "/jsons/checkcode.form?a=" + Math.random());
    });
    //确认修改
    function check(studentid, code) {
        if (studentid == "" || studentid == null) {
            l_msg("请输入学号", 2);
        } else if (code == "" || code == null) {
            l_msg("请输入验证码", 2);
        } else if (code.length != 4) {
            l_msg("请输入四位验证码", 2);
        } else if (isNaN(studentid)) {
            l_msg("学号必须为数字", 2);
        } else {
            l_loading('发送中...');
            $.ajax({
                url: "/AppLogin/findPwd.form",
                type: "post",
                data: {
                    studentid: studentid,
                    usercheckcode: code
                },
                success: function (data) {
                    l_closeAll();
                    var reg = /^([a-zA-Z0-9_-])+@([a-zA-Z0-9_-])+(.[a-zA-Z0-9_-])+/;
                    if (reg.test(data)) {
                        l_msg("重置密码的链接已发送至邮箱"+data+"！请注意查收", 5, function () {
                            window.location.href = "/views/mobile/login.form";
                        });
                    } else if (data == "0") {
                        l_msg("邮件发送失败！");
                    } else {
                        l_msg(data);
                    }
                },
                error: function () {
                    l_closeAll();
                    l_msg("服务器连接失败，请稍后再试");
                }
            });
        }

    }
    function sendEmail() {
        var stuNum = $('#stuNum').val(),
//            email=$('#email').val(),
            checkNum = $('#checkNum').val();
        check(stuNum, checkNum);
    }
    //    $('.blue-btn.block').on('tap', function () {
    //        var stuNum = $('#stuNum').val(),
    ////            email=$('#email').val(),
    //            checkNum = $('#checkNum').val();
    //        check(stuNum, checkNum);
    //    });
</script>
</body>
</html>
