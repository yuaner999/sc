<%--
  Created by IntelliJ IDEA.
  User: lirf
  Date: 2017/6/6
  Time: 8:41
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>修改绑定手机号</title>
    <meta name="viewport" content="width=device-width,initial-scale=1,minimum-scale=1,maximum-scale=1,user-scalable=no" />
    <!--通用css-->
    <link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/asset_mobile/css/common.css"/>
    <link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/asset_mobile/css/layout.css"/>
    <!--单独css-->
    <link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/asset_mobile/css/change.css"/>
    <!--js-->
    <!--zepto 代替jq-->
    <script src="<%=request.getContextPath()%>/asset_mobile/js/zepto.1.2.0.min.js" type="text/javascript" charset="utf-8"></script>
    <%--<script src="<%=request.getContextPath()%>/asset_mobile/js/common.js" type="text/javascript" charset="utf-8"></script>--%>
    <!--layer-->
    <script src="<%=request.getContextPath()%>/asset_mobile/js/layer_mobile/layer.js" type="text/javascript" charset="utf-8"></script>
    <!--封装好的好理解layer-->
    <script src="<%=request.getContextPath()%>/asset_mobile/js/layer-packaged.js" type="text/javascript" charset="utf-8"></script>

    <!--单独js 发送验证码需要-->
    <script src="<%=request.getContextPath()%>/asset_mobile/js/sendNum.js" type="text/javascript" charset="utf-8"></script>
</head>
<%@include file="../mobile/CheckLogin.jsp"%>
<%--<%@include file="../mobile/CheckWeixin.jsp"%>--%>
<body>
<div class="container" >
    <div class="input-group padding">
        <%--<div class="input-row">--%>
            <%--<span>原手机号</span>--%>
            <%--<input type="text" id="oldPho" placeholder="请输入原手机号" maxlength="11">--%>
        <%--</div>--%>
        <%--<div class="input-row">--%>
            <%--<span>验证码</span>--%>
            <%--<input type="text" id="oldNum" placeholder="请输入验证码" maxlength="6">--%>
            <%--<button class="right" id="oldNumBtn" type="button">发送</button>--%>
        <%--</div>--%>
        <div class="input-row">
            <span>新手机号</span>
            <input type="number" id="newPho" placeholder="请输入新手机号" maxlength="11">
        </div>
        <%--<div class="input-row">--%>
            <%--<span>验证码</span>--%>
            <%--<input type="text" id="newNum" placeholder="请输入验证码" maxlength="6">--%>
            <%--<button class="right" id="newNumBtn" type="button">发送</button>--%>
        <%--</div>--%>
    </div>
    <button class="blue-btn block col-90 center" type="button" onclick="changePhone()">确定修改</button>
</div>
<script type="text/javascript">
    //			发送验证码
    function btnTap (obj) {
        obj.text("发送中...");
        if(true){
            l_closeAll();
            l_msg("发送成功",2,function(){
            });
            sended(obj);
        }
    }
    //			旧手机验证码绑定
    $('#oldNumBtn').on('tap',function  () {
        btnTap($(this));
    });
    //			新手机验证码绑定
    $('#newNumBtn').on('tap',function  () {
        btnTap($(this));
    });

    //			确认修改
    //旧号，新号，旧验证码，新验证码
    function check (oPh,nPh,oN,nN) {
        if (nPh == "") {
            l_msg("请填写新手机号", 2);
        } else if(nPh && !(/^1[34578]\d{9}$/.test(nPh))){
            l_msg("手机号码有误，请重新填写", 2);
        } else {
            l_loading();
            $.ajax({
                url:"/StudentInfo/editPhone.form",
                type:"post",
                dataType:"json",
                data:{
                    newPhone:nPh
                }, success:function (data) {
                    l_closeAll();
                    if (data == "1") {
                        l_msg("手机号修改成功", 2, function () {
                            window.location.href='/views/mobile/userCenter.form';
                        })
                    } else {
                        l_msg(data, 2, function () {
                            return;
                        });
                    }
                }
            });
        }
    }
    function changePhone() {
        var oldPho=$('#oldPho').val(),
            newPho=$('#newPho').val(),
            oldNum=$('#oldNum').val(),
            newNum=$('#newNum').val();

        check(oldPho,newPho,oldNum,newNum);
    }
//    $('.blue-btn.block').on('tap',function(){
//        var oldPho=$('#oldPho').val(),
//            newPho=$('#newPho').val(),
//            oldNum=$('#oldNum').val(),
//            newNum=$('#newNum').val();
//        if (newPho == "") {
//            l_msg("请填写新手机号", 2);
//            return;
//        }
//        if(newPho && !(/^1[34578]\d{9}$/.test(newPho))){
//            l_msg("手机号码有误，请重新填写", 2);
//            return;
//        }
//        check(oldPho,newPho,oldNum,newNum);
//    });
</script>
</body>
</html>

