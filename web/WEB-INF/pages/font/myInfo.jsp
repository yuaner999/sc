<%--
  Created by IntelliJ IDEA.
  User: admin
  Date: 2016/9/14
  Time: 9:24
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java"  pageEncoding="UTF-8" %>
<style>
    <%--让雷达图左右居中--%>
    .info ul li {
        color: #2b458c !important;
        word-break: break-all;
        position: relative;
    }
</style>
<script type="text/javascript" src="<%=request.getContextPath()%>/asset_mobile/js/echarts.min.js"></script>  <%--<script type="text/javascript" src="<%=request.getContextPath()%>/asset_font/js/jquery-1.11.1.min.js"></script>--%>
<script>
    //刷新学生的能力数据
    function refreshCountPoint(){
        $.ajax({
            url:"/printTranscript/countPoint.form",
            type:"post",
            data:{applyid:"564321326448131"}, //随便写的id 没用的参数
            async: false,
            success:function(data){
                //layer.alert("六项能力成功更新!",{offset:['30%'] });
            }
        });
    }
    //获得学生的id
    var studentID = '<%=session.getAttribute("studentid")%>';
    //加载学生的信息
    $(function() {
        refreshCountPoint();
        $.ajax({
            url: "/jsons/loadInfor.form",
            type: "post",
            dataType: "json",
            success: function (data) {
                //将信息写入
                var row ;
                if(data.rows && data.rows.length>0)
                    row = data.rows[0];
                else{
                    row={studentName:'xxx',collegeName:'xxx',majorName:'xxx',className:'xxx',studentID:'xxx',studentPhone:'xxx'};
                    $("#hehe").hide();      //隐藏导航中的 个人中心 按键
                    $("#logintime").next("span").text("xxx");       //改变登陆后的姓名显示
                    $(".userinfo>p>a").hide();      //个人信息里的more
                }
                $("#sname").html(row.studentName);
                $("#scoll").html(row.collegeName);
                $("#smaj").html(row.majorName);
                $("#scla").html(row.className);
                $("#sid").html(row.studentID);
                $("#spho").html(row.studentPhone);


//                $(".per_content_two span").eq(0).html(row.studentName);
//                $(".per_content_two span").eq(1).html(row.collegeName);
//                $(".per_content_two span").eq(2).html(row.majorName);
//                $(".per_content_two span").eq(3).html(row.className);
//                $(".per_content_two span").eq(4).html(row.studentID);
//                $(".per_content_two span").eq(5).html(row.studentPhone);
                /////////////////////////////////////////修改审核公示页面中质疑举报对话框中的电话号码////////////////////////////////////////////////////////
                $("#inforTel").val(row.studentPhone);
                /////////////////////////////////////////修改审核公示页面中质疑举报对话框中的电话号码////////////////////////////////////////////////////////
                var photo = row.studentPhoto;
                var str = '<img class="photo" src=/Files/Images/'+row.studentPhoto+' onerror="(this).src=\'/Files/Images/default.jpg\'" >';//(this).src=\'/Files/Images/default.jpg\'
                if(photo==null||photo==''){
                    str = '<img src=/Files/Images/default.jpg>';
                }
                //没有图片则是默认的图片
//                $(".per_content_one div").html(str);
                $("#sphoto").html(str);
            },
            error: function () {
                layer.alert("服务器连接失败");
            }
        });
    });
</script>
<!--人物照
-->
<div class="userinfo">
    <p>
        我的信息
        <a href="<%=request.getContextPath()%>/views/font/oneself.form">more>></a>
    </p>
    <div class="info">
        <div id="sphoto">
            <%--<img class="photo" src="<%=request.getContextPath()%>/asset_font_new/img/phpto_26.png"/>--%>
        </div>
        <ul>
            <li>
                <a>姓名：</a><span id="sname"></span>
            </li>
            <li>
                <a> 学院：</a><span id="scoll"></span>
            </li>
            <li>
                <a> 专业：</a><span id="smaj"></span>
            </li>
            <li>
                <a> 班级：</a><span id="scla"></span>
            </li>
            <li>
                <a> 学号：</a><span id="sid"></span>
            </li>
            <li>
                <a> 电话：</a><span id="spho"></span>
            </li>
        </ul>
    </div>
    <div class="model" id="posi">
        <!--放雷达图
        -->
        <ul>
            <li><img src="<%=request.getContextPath()%>/asset_font/img/biaoda.png"/></li>
            <li><img src="<%=request.getContextPath()%>/asset_font/img/chuangxin.png"/></li>
            <li><img src="<%=request.getContextPath()%>/asset_font/img/chuangye.png"/></li>
            <li><img src="<%=request.getContextPath()%>/asset_font/img/lingdao.png"/></li>
            <li><img src="<%=request.getContextPath()%>/asset_font/img/sibian.png"/></li>
            <li><img src="<%=request.getContextPath()%>/asset_font/img/zhixing.png"/></li>
        </ul>
        <div id="charts">
        </div>
    </div>
</div>
<!-- 此js必须放在div后面，不能独立放到其他页，放到其他位置都有可能失效 -->
<script src="<%=request.getContextPath()%>/asset/js/Radio.js"></script>