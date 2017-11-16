<%--
  Created by IntelliJ IDEA.
  User: lirf
  Date: 2017/6/6
  Time: 8:42
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>修改密码</title>
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
    <!--引入jQuery-->
    <script type="text/javascript" src="<%=request.getContextPath()%>/asset/js/jquery-1.8.3.min.js"></script>
    <script src="<%=request.getContextPath()%>/asset/js/jquery.md5.js" type="text/javascript"></script>

</head>
<%@include file="../mobile/CheckLogin.jsp" %>
<%--<%@include file="../mobile/CheckWeixin.jsp"%>--%>
<body>
<div class="container">
    <div class="input-group padding">
        <div class="input-row">
            <span>原密码</span>
            <input type="password" class="_3" id="oldPword" placeholder="请输入原密码" maxlength="16">
        </div>
        <div class="input-row">
            <span>新密码</span>
            <input type="password" class="_3" id="newPword" placeholder="请输入新密码" maxlength="16">
        </div>
        <div class="input-row _6">
            <span>再次输入密码</span>
            <input type="password" class="_6" id="againPword" placeholder="请再次输入密码" maxlength="16">
        </div>
    </div>
    <button class="blue-btn block col-90 center" type="button" onclick="submitChangePwd()">确定修改密码</button>
</div>
<script type="text/javascript">
    //			确认修改
    function check(oldPword, newPword, againPword) {
        if (!oldPword) {
            l_msg("请输入原密码", 2);
        } else if (!newPword) {
            l_msg("请输入新密码", 2);
        } else if (!againPword) {
            l_msg("请再次输入新密码", 2);
        } else if (oldPword == newPword) {
            l_msg("新密码与原密码相同", 2);
        } else if (newPword != againPword) {
            l_msg("两次密码不一致,请重新输入", 2);
        } else {
            l_loading();
            $.ajax({
                url: "/AppLogin/EditPassword.form",
                type: "post",
                dataType: "json",
                data: {oldpassword: $.md5(oldPword), newpassword: $.md5(newPword)},
                success: function (data) {
                    l_closeAll();
                    if (data == "1") {
                        l_msg('修改成功，请重新登录', 2, function () {
                            window.location.href = '/views/mobile/login.form';
                        });
                    } else {
                        l_msg(data, 2, function () {
                            return;
                        });
                    }
                },
                error: function (data) {
                    l_closeAll();
                    l_msg(data.responseText, 2, function () {
                        return;
                    });
                }
            });
        }
    }

    function submitChangePwd() {
        var oldPword = $('#oldPword').val(),
            newPword = $('#newPword').val(),
            againPword = $('#againPword').val();

        check(oldPword, newPword, againPword);
    }
    //    $('.blue-btn.block').on('tap',function(){
    //    });
</script>
</body>
</html>
