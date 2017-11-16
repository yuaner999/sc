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
    <script type="text/javascript" src="<%=request.getContextPath()%>/asset_admin_new/js/common_stuMsgManage.js"></script>


    <%--引入表单验证--%>
    <script type="text/javascript" src="<%=request.getContextPath()%>/asset_admin_new/js/Validform_v5.3.2.js"></script>
    <link rel="stylesheet" href="<%=request.getContextPath()%>/asset_admin_new/css/style.css" />
    <link rel="stylesheet" href="<%=request.getContextPath()%>/asset_admin_new/css/demo.css" />
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
    <!--兼容360浏览器，防止布局乱，设置IE的文档模式为最高版本，并且如果存在chrome插件，自动使用Webkit引擎-->
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <title>第二课堂友情链接管理界面</title>

    <script type="text/javascript">
        $(function(){
            $("#button").click(function(){
                var studentID=$("#studentID").val();
                if(studentID){
                    $.ajax({
                        url:"/jsons/validateStudentInfo.form" ,
                        data:{studentID:studentID},
                        type:"post",
                        async:false,
                        dataType:"json",
                        success:function(data){
                          if(data.total==0){
                              layer.alert("没有这个学号的学生");
                          }else{
                              //查询print表中最后时间的printid
                              $.ajax({
                                  url:"/jsons/searchlatestprintid.form" ,
                                  data:{studentID:studentID},
                                  type:"post",
                                  dataType:"json",
                                  async:false,
                                  success:function(data){
                                      if(data.total>0){
                                          window.open("/views/font/A4.form?studentID="+studentID+"&Enigmatic=" + data.rows[0].printId,"_blank");
                                      }else{
                                          layer.alert("没有该学生的打印申请");
                                      }
                                  }
                              });
                          }
                        }
                    })
                }else {
                    layer.alert("请填写学生学号");
                }
            });
        });
        $(document).keydown(function(event){
            if(event.keyCode == 13){ //绑定回车
                $("#button").click();
            }
        });
    </script>
    <style type="text/css">
        .centerdiv {
            margin:30px 50px;
        }
        .centerdiv li{
            position: relative;
            width: 360px;
            height: 45px;
            background: #fdfdfd;
            box-shadow: 0 2px 2px rgba(0,0,0,.15);
            border-radius: 3px;
        }
        .centerdiv li span{
            display: block;
            position: absolute;
            top: 6px;
            left: 8px;
            width: 52px;
            line-height: 34px;
            font-size: 16px;
            height: 34px;
            color: #0f89f5;
        }
        #studentID{
            position: absolute;
            top: 12.5px;
            left: 70px;
            box-sizing: border-box;
            text-indent: 2px;
            border: none;
            width: 219px;
            height: 20px;
            line-height: 20px;
            padding: 0;
            letter-spacing: .5px;
            font-size: 14px;
            outline:none;
            background: #fdfdfd;
        }
        #button{
            position: absolute;
            top: 0;
            right: 0;
            height: 100%;
            font-size: 19px;
            color: #1990FE;
            padding: 0 5px;
            line-height: 45px;
            background: #fcfcfc;
            border: none;
            width: 50px;
            cursor: pointer;
        }
        #button:active{
            background: #fafafa;
        }
        #sid{
            font-size: 15px;
            color: #1990FE;
        }
    </style>
    <%--判断是否是登录状态--%>
    <%--<%@include file="../common/CheckLogin.jsp"%>--%>
</head>
<body>
    <div class="centerdiv">
            <ul>
                <li>
                    <span id="sid">学生学号:</span>
                    <input type="text" id="studentID" placeholder="请输入学生学号"/>
                    <input type="button" id="button" value="打印"/>
                </li>
            </ul>
    </div>
</body>
</html>