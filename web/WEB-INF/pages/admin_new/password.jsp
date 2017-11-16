<%--
  Created by IntelliJ IDEA.
  User: pjj
  Date: 2016/10/21
  Time: 9:15
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java"  pageEncoding="UTF-8" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01//EN"
"http://www.w3.org/TR/html4/strict.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" lang="en">
<head>
    <link rel="Shortcut Icon" href="<%=request.getContextPath()%>/asset/image/neu.jpg" type="image/x-icon">
    <!-- 导入页面控制js jq必须放最上面 -->
    <script type="text/javascript" src="<%=request.getContextPath()%>/asset_admin_new/js/jquery-1.11.1.min.js"></script>
    <script type="text/javascript" src="<%=request.getContextPath()%>/asset_admin_new/js/common_stuMsgManage.js"></script>
    <!-- 导入layer -->
    <script type="text/javascript" src="<%=request.getContextPath()%>/asset/layer/layer.js"></script>
    <!-- 导入样式css -->
    <link rel="stylesheet" href="<%=request.getContextPath()%>/asset_admin_new/css/StuMsgManage.css" />
    <%--引入公共JS--%>
    <script type="text/javascript" src="<%=request.getContextPath()%>/asset/js/common.js"></script>
    <script type="text/javascript" src="<%=request.getContextPath()%>/asset_admin_new/js/managecommon.js"></script>
    <%--<script type="text/javascript" src="<%=request.getContextPath()%>/asset_admin_new/js/common_stuMsgManage.js"></script>--%>
    <%--<script type="text/javascript" src="<%=request.getContextPath()%>/asset/kindeditor-4.1.10/KindeditorConfig.js"></script>--%>
    <%--引入图片上传--%>
    <%--<script type="text/javascript" src="<%=request.getContextPath()%>/asset/js/ajaxfileupload.js"></script>--%>
    <%--引入表单验证--%>
    <script type="text/javascript" src="<%=request.getContextPath()%>/asset_admin_new/js/Validform_v5.3.2.js"></script>
    <script type="text/javascript" src="<%=request.getContextPath()%>/asset_admin_new/js/passwordStrength.js"></script>
    <link rel="stylesheet" href="<%=request.getContextPath()%>/asset_admin_new/css/style.css"  media="all" />
    <link rel="stylesheet" href="<%=request.getContextPath()%>/asset_admin_new/css/demo.css" />

    <%--引入本页自己的js--%>
    <%--<script type="text/javascript" src="<%=request.getContextPath()%>/asset_admin_new/js/newsManage.js"></script>--%>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
    <!--兼容360浏览器，防止布局乱，设置IE的文档模式为最高版本，并且如果存在chrome插件，自动使用Webkit引擎-->
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <title>第二课堂教师管理界面</title>
    <style type="text/css">
        tr>td:first-child{
            background-color: #ffffff !important;
        }
        td{
            border:0 !important;
        }
        input[type=button],input[type=reset]{
            width: 100px;
            height: 34px;
            font-size: 16px;
            color: #ffffff;
            background-color: #1990fe;
            border: 0;
            cursor: pointer;
        }
    </style>
    <script >
        function checkPassword(){
            var password = '<%=session.getAttribute("loginuserpassword")%>';
//            console.log(password);
            if(password!=$("#oldpassword").val()){
                layer.msg("原密码输入错误。")
                document.getElementById("Form").reset();
                return;
            }
            var jsonObject = $("#Form").serializeObject();
            jsonObject.oldpassword = $.md5(jsonObject.oldpassword);
            jsonObject.newpassword = $.md5(jsonObject.newpassword);
            $.post("/Login/EditPassword.form",jsonObject,function(data){
                if(!isNaN(data) || data!="-1"){
                    ShowMsg("修改成功，请重新登录");
//                    console.log(data);
                    goToLogin(data);
                }else if(data=="-1"){
                    ShowMsg("系统错误，请联系管理员");
                }else {
                    ShowMsg(data);
                }
            })
        }
    </script>
    <%--判断是否是登录状态--%>
    <%--<%@include file="../common/CheckLogin.jsp"%>--%>
</head>
<body>
<div class="main">
    <div class="wraper">

        <form id="Form" class="registerform" >
            <table width="100%" style="table-layout:fixed;" border="0">
                <tr>
                    <td class="need" style="width:10px;">*</td>
                    <td style="width:100px;">原密码：</td><!-- 这个宽度必须要给，确定后面的格式 -->
                    <td ><input type="password" id="oldpassword" name="oldpassword" class="inputxt" datatype="*" errormsg="原密码不能为空" ></td>
                </tr>
                <tr>
                    <td class="need" style="width:10px;">*</td>
                    <td style="width:100px;">密码：</td><!-- 这个宽度，要地方给够，不然会窜位置到下一行 -->
                    <td style="width:350px;">
                        <input id="newpassword" name="newpassword" type="password" value="" name="password" class="inputxt" plugin="passwordStrength"  datatype="*6-18" errormsg="密码至少6个字符,最多18个字符！" />
                        <span class="Validform_checktip"></span>
                        <div class="passwordStrength">密码强度： <span>弱</span><span>中</span><span class="last">强</span></div><!-- 改图要放在可以不写的span的下面，不然页面排版错误 -->
                    </td>
                </tr>
                <tr>
                    <td class="need">*</td>
                    <td>确认密码：</td>
                    <td><input type="password" value="" name="repassword" class="inputxt" recheck="password"  datatype="*6-18" errormsg="两次输入的密码不一致！" /></td>
                    <td><div class="Validform_checktip"></div></td>
                </tr>
                <tr>
                    <td class="need"></td>
                    <td></td>
                    <td colspan="2" style="padding:10px 0 18px 0;">
                        <input id="btn_sub" class="new_buttons" type="button" value="提 交" onclick="checkPassword()" /> <input type="reset" class="new_buttons" value="重 置" />

                    </td>
                </tr>
            </table>
        </form>


    </div>
</div>

<!--此js放在要提交表单的下面，放在上面偶尔失效-->

<script>
    $(function(){
        //$(".registerform").Validform();  //就这一行代码！;

        $(".registerform").Validform({
            tiptype:4,
            btnSubmit:"#btn_sub",
            ajaxPost:true,
            usePlugin:{
                passwordstrength:{
                    minLen:6,
                    maxLen:18
                }
            }
        });
    })
</script>
</body>
</html>