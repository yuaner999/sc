<%--
  Created by IntelliJ IDEA.
  User: yuanshenghan
  Date: 2016/11/2
  Time: 11:12
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java"  pageEncoding="UTF-8" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01//EN"
"http://www.w3.org/TR/html4/strict.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" lang="en">
<head>
    <link rel="Shortcut Icon" href="<%=request.getContextPath()%>/asset/image/neu.jpg" type="image/x-icon">
    <!-- 导入页面控制js -->
    <script type="text/javascript" src="<%=request.getContextPath()%>/asset_admin_new/js/jquery-1.11.1.min.js"></script>

    <%--引入公共JS--%>
    <script type="text/javascript" src="<%=request.getContextPath()%>/asset/js/common.js"></script>
    <script type="text/javascript" src="<%=request.getContextPath()%>/asset_admin_new/js/managecommon.js"></script>
    <!-- 导入layer -->
    <script type="text/javascript" src="<%=request.getContextPath()%>/asset/layer/layer.js"></script>

    <!--兼容360浏览器，防止布局乱，设置IE的文档模式为最高版本，并且如果存在chrome插件，自动使用Webkit引擎-->
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <title></title>

    <script type="text/javascript">
        function CopyStudInfo(){
            layer.confirm("将要同步学生数据，请勿关闭服务器！点击确定后开始执行。",function(c){
                if(c){
                    $.ajax({
                        url:"/jsons/CopyStudInfo.form",
//            data:{page:"1",rows:"30"},
                        type:"post",
                        success:function(data){

                            layer.msg("同步成功");
                        },
                        error:function(){
                            layer.msg("同步失败");
                        }
                    });
                }
            });

        }
        function CopyClassInfo(){
            var c = layer.confirm("将要同步数据，请勿关闭服务器！点击确定后开始执行。");
            if(c){
                $.ajax({
                    url:"/jsons/CopyClassInfo.form",
//            data:{page:"1",rows:"30"},
                    type:"post",
                    success:function(data){
                        layer.msg("同步成功");
                    },
                    error:function(){
                        layer.msg("同步失败");
                    }
                });}

        }
        function CopyCollegeInfo(){
            var c = layer.confirm("将要同步数据，请勿关闭服务器！点击确定后开始执行。");
            if(c){
                $.ajax({
                    url:"/jsons/CopyCollegeInfo.form",
//            data:{page:"1",rows:"30"},
                    type:"post",
                    success:function(data){
                        layer.msg("同步成功");
                    },
                    error:function(){
                        layer.msg("同步失败");
                    }
                });
            }
        }
        function CopyGradeInfo(){
            var c = layer.confirm("将要同步数据，请勿关闭服务器！点击确定后开始执行。");
            if(c){
                $.ajax({
                    url:"/jsons/CopyGradeInfo.form",
//            data:{page:"1",rows:"30"},
                    type:"post",
                    success:function(data){
                        layer.msg("同步成功");
                    },
                    error:function(){
                        layer.msg("同步失败");
                    }
                });
            }
        }
        function CopyMajorInfo(){
            var c = layer.confirm("将要同步数据，请勿关闭服务器！点击确定后开始执行。");
            if(c){
                $.ajax({
                    url:"/jsons/CopyMajorInfo.form",
//            data:{page:"1",rows:"30"},
                    type:"post",
                    success:function(data){
                        layer.msg("同步成功");
                    },
                    error:function(){
                        layer.msg("同步失败");
                    }
                });
            }
        }
    </script>
    <%--判断是否是登录状态--%>
    <%--<%@include file="../common/CheckLogin.jsp"%>--%>
    <style type="text/css">
        .buttons{
            width: 134px;
            height: 34px;
            font-size: 16px;
            color: #e9f6ff;
            margin-left: 20px;
            border: 1px solid #1990FE;
            background-color: #1990fe;
            cursor: pointer;
            border-radius: 4px;
        }
    </style>
</head>
<body>
    <div id="tb" style="height:auto">
        <input type="button"  class="buttons" onclick="CopyStudInfo()"  value="同步学生信息">
        <%--<input type="button"  class="buttons" onclick="CopyClassInfo()" value="同步班级信息">--%>
        <%--<input type="button"  class="buttons"  onclick="CopyGradeInfo()"value="同步年级信息">--%>
        <%--<input type="button"  class="buttons"  onclick="CopyCollegeInfo()"value="同步学院信息">--%>
        <%--<input type="button"  class="buttons"  onclick="CopyMajorInfo()"value="同步专业信息">--%>
    </div>
</body>
</html>