<%--
  Created by IntelliJ IDEA.
  User: NEUNB
  Date: 2017/10/26
  Time: 20:11
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java"  pageEncoding="UTF-8" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01//EN"
"http://www.w3.org/TR/html4/strict.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" lang="en">
<head>
    <title>重置学生密码</title>
    <script type="text/javascript" src="<%=request.getContextPath()%>/asset_admin_new/js/jquery-1.11.1.min.js"></script>
</head>
<body>
<div style="width: 100%;">
    请输入学号：
    <div style="width: 50%;">
        <input type="text" id="studentId"><button onclick="getStudentInfoById()">获取学生信息</button><button onclick="resetPwd()">重置密码</button>
    </div>
    <div style="width: 50%;">
        <textarea style="width: 100%;" rows="8" id="stuInfo"></textarea>
    </div>
</div>

<br>
<div style="width: 100%;">
    请输入帐号(团支书/院团委)：
    <div style="width: 50%;">
        <input type="text" id="userName"><button onclick="getUserInfoByName()">获取用户信息</button><button onclick="resetUserPwd()">重置密码</button>
    </div>
    <div style="width: 50%;">
        <textarea style="width: 100%;" rows="8" id="userInfo"></textarea>
    </div>
</div>

</body>
<script>
    var result = true;
    function getStudentInfoById(){
        var studentId = $('#studentId').val();
        $.ajax({
            type:'POST',
            url:'/jsons/getStudentInfoById.form',
            data:{'studentId':studentId},
            // data:JSON.stringify(params),
            dataType:'json',
            success:function(data){
                var studentInfo = '';
                if(!data ||data.total == 0){
                    studentInfo = '学号不存在'
                    result = false;
                }else{
                    studentInfo += '姓名：'+ data.rows[0].studentName;
                    studentInfo += '\n学号：'+ data.rows[0].studentID;
                    studentInfo += '\n学籍：'+ data.rows[0].stuGradeName;
                    studentInfo += '\n学院：'+ data.rows[0].stuCollageName;
                    studentInfo += '\n专业：'+ data.rows[0].stuMajorName;
                    studentInfo += '\n班级：'+ data.rows[0].stuClassName;
                    result = true;
                }

                $('#stuInfo').val(studentInfo);
            },
            error:function(){
                if(errorcallback) errorcallback();
            },
            async:false
        });
    }
    function resetPwd(){
        var studentId = $('#studentId').val();
        getStudentInfoById();
        if(!result){
            $('#stuInfo').val( $('#stuInfo').val()+'\n密码重置失败，请确定确定该学生是否存在');
            return;
        }

        $.ajax({
            type:"POST",
            url:'/jsons/resetPwd.form',
            data:{studentId:studentId,'initPwd':'14E1B600B1FD579F47433B88E8D85291'},
            dataType:'json',
            success:function(data){
                if(data.result){
                    $('#stuInfo').val( $('#stuInfo').val()+'\n密码重置成功');
                }else{
                    $('#stuInfo').val( $('#stuInfo').val()+'\n密码重置失败，请确定确定该学生是否存在');
                }
            },
            error:function(){
                if(errorcallback) errorcallback();
            },
            async:false
        });
    }

    var result1 = true;
    function getUserInfoByName(){
        var userName = $('#userName').val();
        $.ajax({
            type:'POST',
            url:'/jsons/getUserInfoByName.form',
            data:{'userName':userName},
            dataType:'json',
            success:function(data){
                var userInfo = '';
                if(!data ||data.total == 0){
                    userInfo = '用户不存在'
                    result1 = false;
                }else{
                    userInfo += '用户名：'+ data.rows[0].username;
                    if(data.rows[0].collegename){
                        userInfo += '\n学院名称：'+ data.rows[0].collegename;
                    }
                    userInfo += '\n角色名称：'+ data.rows[0].sysrolename;
                    result1 = true;
                }
                $('#userInfo').val(userInfo);
            },
            error:function(){
                if(errorcallback) errorcallback();
            },
            async:false
        });
    }
    function resetUserPwd(){
        var userName = $('#userName').val();
        getUserInfoByName();
        if(!result1){
            $('#userInfo').val( $('#userInfo').val()+'\n密码重置失败，请确定确定该用户是否存在');
            return;
        }

        $.ajax({
            type:"POST",
            url:'/jsons/resetUserPwd.form',
            data:{userName:userName,'initPwd':'14E1B600B1FD579F47433B88E8D85291'},
            dataType:'json',
            success:function(data){
                if(data.result){
                    $('#userInfo').val( $('#userInfo').val()+'\n密码重置成功');
                }else{
                    $('#userInfo').val( $('#userInfo').val()+'\n密码重置失败，请确定确定该用户是否存在');
                }
            },
            error:function(){
                if(errorcallback) errorcallback();
            },
            async:false
        });
    }

</script>
</html>
