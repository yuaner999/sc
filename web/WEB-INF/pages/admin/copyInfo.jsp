<%--
  Created by IntelliJ IDEA.
  User: admin
  Date: 2016/8/23
  Time: 9:39
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java"  pageEncoding="UTF-8" %>
<html>
<head>
    <title></title>
    <link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/asset/easyui/themes/default/easyui.css">
    <link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/asset/easyui/themes/icon.css">
    <script type="text/javascript" src="<%=request.getContextPath()%>/asset/js/jquery-1.8.3.min.js"></script>
    <script type="text/javascript" src="<%=request.getContextPath()%>/asset/easyui/jquery.easyui.min.js"></script>
    <script type="text/javascript" src="<%=request.getContextPath()%>/asset/easyui/locale/easyui-lang-zh_CN.js"></script>
    <script type="text/javascript" src="<%=request.getContextPath()%>/asset/js/manage/massage-helper.js"></script>
    <%--引入公共JS--%>
    <script type="text/javascript" src="<%=request.getContextPath()%>/asset/js/common.js"></script>
    <script type="text/javascript" src="<%=request.getContextPath()%>/asset/js/manage/managecommon.js"></script>
    <script>
    function CopyStudInfo(){
        var c = confirm("将要同步学生数据，请勿关闭服务器！点击确定后开始执行。");
        if(c){
            $.ajax({
                url:"/jsons/CopyStudInfo.form",
//            data:{page:"1",rows:"30"},
                type:"post",
                success:function(data){

                    ShowMsg("同步成功");
                },
                error:function(){
                    ShowMsg("同步失败");
                }
            });
        }
    }
    function CopyClassInfo(){
         var c = confirm("将要同步数据，请勿关闭服务器！点击确定后开始执行。");
        if(c){
            $.ajax({
            url:"/jsons/CopyClassInfo.form",
//            data:{page:"1",rows:"30"},
            type:"post",
            success:function(data){
                ShowMsg("同步成功");
            },
            error:function(){
                ShowMsg("同步失败");
            }
        });}

    }
    function CopyCollegeInfo(){
        var c = confirm("将要同步数据，请勿关闭服务器！点击确定后开始执行。");
        if(c){
            $.ajax({
                url:"/jsons/CopyCollegeInfo.form",
//            data:{page:"1",rows:"30"},
                type:"post",
                success:function(data){
                    ShowMsg("同步成功");
                },
                error:function(){
                    ShowMsg("同步失败");
                }
            });
        }
    }
    function CopyGradeInfo(){
        var c = confirm("将要同步数据，请勿关闭服务器！点击确定后开始执行。");
        if(c){
            $.ajax({
                url:"/jsons/CopyGradeInfo.form",
//            data:{page:"1",rows:"30"},
                type:"post",
                success:function(data){
                    ShowMsg("同步成功");
                },
                error:function(){
                    ShowMsg("同步失败");
                }
            });
        }
    }
    function CopyMajorInfo(){
        var c = confirm("将要同步数据，请勿关闭服务器！点击确定后开始执行。");
        if(c){
            $.ajax({
                url:"/jsons/CopyMajorInfo.form",
//            data:{page:"1",rows:"30"},
                type:"post",
                success:function(data){
                    ShowMsg("同步成功");
                },
                error:function(){
                    ShowMsg("同步失败");
                }
            });
        }
    }
    </script>
</head>
<body>
<div id="tb" style="height:auto">
    <a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls: 'icon-ok'" onclick="CopyStudInfo()">同步学生信息</a>
    <a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls: 'icon-ok'" onclick="CopyClassInfo()">同步班级信息</a>
    <a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls: 'icon-ok'" onclick="CopyGradeInfo()">同步年级信息</a>
    <a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls: 'icon-ok'" onclick="CopyCollegeInfo()">同步学院信息</a>
    <a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls: 'icon-ok'" onclick="CopyMajorInfo()">同步专业信息</a>
</div>
</body>
</html>
