<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>主题团日</title>
    <meta name="viewport" content="width=device-width,initial-scale=1,minimum-scale=1,maximum-scale=1,user-scalable=no" />
    <!--通用css-->
    <link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/asset_mobile/css/common.css"/>
    <link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/asset_mobile/css/layout.css"/>
    <link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/asset_mobile/css/reportCard.css"/>
    <!--单独css-->
    <link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/asset_mobile/css/themedayPage.css"/>
    <!--js-->
    <script src="<%=request.getContextPath()%>/asset/js/jquery-1.8.3.min.js" type="text/javascript" charset="utf-8"></script>
    <script src="<%=request.getContextPath()%>/asset/js/jquery.form.js" type="text/javascript" charset="utf-8"></script>
    <script type="text/javascript" src="<%=request.getContextPath()%>/asset/js/laydate/laydate.js"></script>
    <script type="text/javascript" src="<%=request.getContextPath()%>/asset/js/ajaxfileupload.js"></script>


    <!--layer-->
    <script src="<%=request.getContextPath()%>/asset_mobile/js/layer_mobile/layer.js" type="text/javascript" charset="utf-8"></script>
    <!--封装好的好理解layer-->
    <script src="<%=request.getContextPath()%>/asset_mobile/js/layer-packaged.js" type="text/javascript" charset="utf-8"></script>
    <!--js-->
    <script src="<%=request.getContextPath()%>/asset_mobile/js/angular1.6.min.js" type="text/javascript" charset="utf-8"></script>

</head>
<%@include file="../mobile/CheckLogin.jsp"%>
<body ng-app='app' ng-controller='ctrl'>
<%--主题团日--%>
<div class="themedayPage" style="display: block">

    <%--<div ng-bind="msg"></div>--%>



    <ol id="themedayPage" ng-repeat="item in zhutiguanData">

       <%--删除按钮--%>
        <a class="adele"  href="javascript:void(0)" ng-click="DeleteApply(item.id)">
            <img class="smdele" src="../../asset_font_new/img/del_ico.png" alt="删除" title="删除">
        </a>

           <!---循环ol  每个ol是一列-->
        <ol id="themedayPage1">
            <li class="first">
                <p>名称</p>
                <span ng-bind="item.activityTitle"></span>
            </li>
            <li class="secound">
                <p>时间</p>
                <span ng-bind="item.applyDate"></span>
            </li>
            <li class="third">
                <p>能力</p>
                <span ng-bind="item.supPowers"></span>
            </li>
        </ol>
    </ol>


    <a href="javascript:self.location='reportCard.form'" class="center_head_a" id="return">

        <div class="button" ><button class="blue-btn block col-90 center" type="button">确认</button></div>
    </a>
</div>

</body>

<script>

    var app = angular.module('app', []);
    app.controller('ctrl',function($scope){
        $scope.loadstudent=function(){
            $scope.zhutiguanData=[];              //存放主题团日活动的数组
            $.ajax({
                url:"/jsons/laodStudentActivity.form",
                type:"post",
                dataType:"json",
                success:function(data) {
                    if (data != null && data.rows != null && data.rows.length > 0) {
                        for (var i = 0; i < data.rows.length; i++) {
                            var row = data.rows[i];
                            if (row.supType == '主题团日') {        //如果该条记录是主题团日活动，则添加到主题团日活动的数组里，并结束此轮循环
                                row.theme = "true";
                                $scope.zhutiguanData.push(row);
                                $scope.$apply();
                                continue;
                            }
                        }
                    }
                },
                error:function(data){
                    l_msg("网络错误");
                }
            });
        };


        $scope.loadstudent();
//        删除功能

        $scope.DeleteApply=function(id){
           l_confirm("确认删除申请吗？此操作不可恢复", function (result) {
                if (result ==0 && id) {
                    $.ajax({
                        url: "/apply/deleteById.form",
                        type: "post",
                        data: {applyId: id},
                        dataType: "json",
                        success: function (data) {
                            if (data.result == 1) {
                                l_msg("删除成功");

                            } else if (data.result == 0) {
                                $scope.delsupplement(id);
                            } else {
                                l_msg("删除失败，请重新登录或联系管理员");
                            }
                        }
                    })
                }
            },function(){
               l_msg("取消");
           });
        };
        $scope.delsupplement=function(id){
            $.ajax({
                url:"/jsons/deletesupplement.form",
                type:"post",
                data:{id:id},
                async:false,
                success:function(data){
                    if(data.result){
                        if (data.result) {
                            l_msg("删除成功");
                            $scope.loadstudent();
                            $scope.$apply();//重新加载数据
                        } else {
                            l_msg("删除失败，请重新登录或联系管理员");
                        }
                    }
                }
            })
        }

    });

</script>

</html>

