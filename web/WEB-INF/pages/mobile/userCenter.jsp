<%--
  Created by IntelliJ IDEA.
  User: lirf
  Date: 2017/6/6
  Time: 8:40
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>用户中心</title>
    <meta name="viewport" content="width=device-width,initial-scale=1,minimum-scale=1,maximum-scale=1,user-scalable=no" />
    <!--通用css-->
    <link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/asset_mobile/css/common.css"/>
    <link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/asset_mobile/css/layout.css"/>
    <!--单独css-->
    <link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/asset_mobile/css/user.css"/>
    <!--js-->
    <script src="<%=request.getContextPath()%>/asset_mobile/js/angular1.6.min.js" type="text/javascript" charset="utf-8"></script>
    <script src="<%=request.getContextPath()%>/asset_mobile/js/zepto.1.2.0.min.js" type="text/javascript" charset="utf-8"></script>
    <!--layer-->
    <script src="<%=request.getContextPath()%>/asset_mobile/js/layer_mobile/layer.js" type="text/javascript" charset="utf-8"></script>
    <!--封装好的好理解layer-->
    <script src="<%=request.getContextPath()%>/asset_mobile/js/layer-packaged.js" type="text/javascript" charset="utf-8"></script>
    <!--单独引入js-->
    <%--<script src="http://res.wx.qq.com/open/js/jweixin-1.2.0.js" type="text/javascript" charset="utf-8"></script>--%>
    <%--<script src="<%=request.getContextPath()%>/asset_mobile/js/WeChatJSJDK.js" type="text/javascript" charset="utf-8"></script>--%>
    <script type="text/javascript" src="<%=request.getContextPath()%>/asset/js/jquery-1.8.3.min.js"></script>
    <script src="<%=request.getContextPath()%>/asset/js/jquery.cookie.js" type="text/javascript"></script>
    <script src="<%=request.getContextPath()%>/asset_mobile/js/controller/userCenter.js" type="text/javascript" charset="utf-8"></script>
    <!--引入echartjs-->
    <script src="<%=request.getContextPath()%>/asset_mobile/js/echarts.min.js" type="text/javascript" charset="utf-8"></script>
</head>
<%@include file="../mobile/CheckLogin.jsp"%>
<%--<%@include file="../mobile/CheckWeixin.jsp"%>--%>
<body ng-app='app' ng-controller='ctrl'>
<!--通用导航-->
<%@include file="footer.jsp"%>
<!--主容器-->
<div class="container">
    <!--头部-->
    <div class="photobox padding">
        <div class="rel">
            <%--ng-click="changePhoto()"--%>
            <div class="photo">
                <img ng-src="{{user.studentPhoto}}" onerror="this.src='/Files/Images/default.jpg'"/>
            </div>
            <a ng-click="exit()"><i class="icon right"></i></a>
        </div>
    </div>
    <!--基本信息-->
    <div class="basic padding">
        <div>
            <b class="letter">姓名</b>
            <span class="right" ng-bind="user.studentName"></span>
        </div>
        <div>
            <b class="letter">学院</b>
            <span class="right" ng-bind="user.collegeName"></span>
        </div>
        <div>
            <b class="letter">专业</b>
            <span class="right" ng-bind="user.majorName"></span>
        </div>
        <div>
            <b class="letter">班级</b>
            <span class="right" ng-bind="user.className"></span>
        </div>
        <div>
            <b class="letter">学号</b>
            <span class="right" ng-bind="user.studentID"></span>
        </div>
        <div>
            <a class="block" href="/views/mobile/changePhone.form">
                <b>联系方式</b>
                <span class="right" ng-bind="user.studentPhone"></span>
            </a>
        </div>
        <div>
            <a class="block" href="/views/mobile/myActivity.form" onclick="goToPage('myActivity')">
                <b>参与活动</b>
            </a>
        </div>
        <div>
            <a class="block" href="/views/mobile/changePwd.form">
                <b>密码修改</b>
            </a>
        </div>
        <div>
            <a class="block" href="/views/mobile/newReportCard.form">
                <b>活动补录</b>
            </a>
        </div>
        <div>
            <a class="block" href="/views/mobile/reportCard.form">
                <b>预览成绩单</b>
            </a>
        </div>
    </div>
    <!--放置雷达图-->
    <div id="echartbox" class="padding" style="width: 400px;height: 400px">
        <%--<img src="<%=request.getContextPath()%>/asset_mobile/fakeimg/images/第二课堂手机端-用户中心20170408_07.jpg"/>--%>
    </div>
</div>
</body>
<!--加载六项能力雷达图-->
<script>
    // 基于准备好的dom，初始化echarts实例
    var myChart = echarts.init(document.getElementById('echartbox'));

    // 指定图表的配置项和数据
    option = {
        title: {},
        tooltip: {},
        legend: {
            x : 'right',
            y : '85%',
            data: ['','']
        },
        radar: {
            radius:'50%',
            splitNumber:4,
            indicator: [
                { name: '表达',min:20, max: 100},
                { name: '创业',min:20, max: 100},
                { name: '创新',min:20, max: 100},
                { name: '领导',min:20, max: 100},
                { name: '思辨',min:20, max: 100},
                { name: '执行',min:20, max: 100}
            ]
        },
        series: []
    };
    //拼穿的2个方法
    function generYears (data){
        var list = [];
        for (var i = 0; i <data.total; i++) {
            list.push(data.rows[i].pointYear);
        }
        return list;
    }

    function goToPage(page) {
        if (page = "myActivity") {
            window.sessionStorage["myactivitiesloadtype"] = 'all';
        }
    }

    function gennerData(data) {
        var series = [];
        for(var i = 0;i<data.total;i++){
            series.push({
                name:'能力成绩表',
                type:'radar',
                data:[
                    {
                        value:[
                            formatedata(data.rows[i].biaoda),
                            formatedata(data.rows[i].chuangye),
                            formatedata(data.rows[i].chuangxin),
                            formatedata(data.rows[i].lingdao),
                            formatedata(data.rows[i].sibian),
                            formatedata(data.rows[i].zhixing),
                        ],
                        name:data.rows[i].pointYear
                    }
                ]
            });
        }
        return series;
    }

    //
    //格式化数据
    function formatedata(data) {
        if(data==null){
            return 50;
        }else if(data>100){
            return 100;
        }else if(data<20){
            return 20
        }else {
            return data;
        }
    }

    // 异步加载数据
    var loginId=<%=session.getAttribute("studentid")%>;
    $.ajax({
        type: "post",
        async: false,
        url:"/jsons/loadSixElementPoint.form",
        data:{studentid:loginId},
        dataType: "json",
        success: function (data) {
            // 获得拼穿值
            var years=generYears(data);
            var servies=gennerData(data);
            // 给option对应地方赋值
            option.legend.data=eval(years);
            option.series=eval(servies);
            // 使用刚指定的配置项和数据显示图表。
            myChart.clear();
            myChart.setOption(option);
        },
        error: function () {
            layer.msg("图表请求数据失败啦!");
        }
    });
</script>

</html>
