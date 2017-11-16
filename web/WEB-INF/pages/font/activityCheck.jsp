<%--
  Created by IntelliJ IDEA.
  User: admin
  Date: 2016/9/10
  Time: 16:51
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java"  pageEncoding="UTF-8" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01//EN"
"http://www.w3.org/TR/html4/strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" lang="en">
<head>
    <title> 活动审核公示</title>
    <link rel="Shortcut Icon" href="<%=request.getContextPath()%>/asset/image/neu.jpg" type="image/x-icon">
    <meta http-equiv="X-UA-Compatible" content="IE=9; IE=8; IE=7; IE=EDGE">
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
    <script type="text/javascript" src="<%=request.getContextPath()%>/asset_font/js/jquery-1.11.1.min.js"></script>
    <script type="text/javascript" src="<%=request.getContextPath()%>/asset/layer/layer.js"></script>
    <link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/asset_font_new/css/common.css"/>
    <link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/asset_font_new/css/commonhead.css"/>
    <link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/asset_font_new/css/index.css"/>
    <link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/asset_font/css/new_file.css" />
    <link href="<%=request.getContextPath()%>/asset_font/css/activity.css" rel="stylesheet" type="text/css" />
    <link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/asset_font_new/css/all.css"/>
    <link rel="stylesheet" href="<%=request.getContextPath()%>/asset_font/css/Radio2.css" type="text/css" />
    <!--分页-->
    <%--先不用原来的样式--%>
    <link type="text/css" rel="stylesheet" href="<%=request.getContextPath()%>/asset/js/paging/paging.css" />
    <script type="text/javascript" src="<%=request. getContextPath()%>/asset_font/js/paging.js"></script>
    <!--人造下拉-->
    <script type="text/javascript" src="<%=request.getContextPath()%>/asset_font/js/activity.js"></script>
    <script src="<%=request.getContextPath()%>/asset_font_new/js/jquery.dotdotdot.js" type="text/javascript" charset="utf-8"></script>
    <script src="<%=request.getContextPath()%>/asset_font_new/js/common.js" type="text/javascript" charset="utf-8"></script>
    <script src="<%=request.getContextPath()%>/asset_font_new/js/respond.js" type="text/javascript" charset="utf-8"></script>
    <script src="<%=request.getContextPath()%>/asset_font_new/js/index.js" type="text/javascript" charset="utf-8"></script>
    <!-- 引入 echarts.js -->
    <script type="text/javascript" src="<%=request.getContextPath()%>/asset_mobile/js/echarts.min.js"></script>
    <style type="text/css">
        .nav{
            z-index: 1000 !important;
        }
    </style>
    <script type="text/javascript">
        var key=2;
        var informStudentId;
        var informApplyId;
        var informAuditStatus;
        var rowData_;
        var studentId='<%=request.getSession().getAttribute("loginId")%>';
        $(document).ready(function(){
            pagingInit();
            loadActivityContent();
            //绑定Enter键
/*            $("#act_input").keyup(function(e){
                if(e.keyCode==13){
                    $("#act_search").click();
                }
            });*/
            //加载学院的下拉选项
            //学生管理：学院
            $.ajax({
                url:"<%=request.getContextPath()%>/jsons/loadstuCollageName.form",
                dataType:"json",
                success:function(data){
                     $("#stuCollageName").html('');
                    $("#stuCollageName").append("<li class='downselect'>选择学院</li>");
                    if(data.rows !=null && data.rows.length > 0){
                        for(var i=0;i<data.rows.length;i++) {
                            var option = "<li class='downselect'>"+data.rows[i].stuCollageName+"</li>";
                            $("#stuCollageName").append(option);
                        }
                    }else{
                        var option = "<li class='downselect'>无</li>";
                        $("#stuCollageName").append(option);
                    }
                }
            });
            //学生管理：专业
            $("#stuCollageName").click(function(){
                cleanFilterOption();
                $("#stuMajorName").html('');
                $.ajax({
                    url:"<%=request.getContextPath()%>/jsons/loadstuMajorName.form",
                    dataType:"json",
                    data:{stuCollageName:$("#collageName").text()},
                    success:function(data){
                        if(data.rows !=null && data.rows.length > 0) {
                            $("#stuMajorName").html('');
                            $("#stuMajorName").append("<li class='downselect'>选择专业</li>");
                            for(var i=0;i<data.rows.length;i++){
                                var option="<li class='downselect'>"+data.rows[i].stuMajorName+"</li>";
                                $("#stuMajorName").append(option);
                            }
                        }else{
                            var option = "<li class='downselect'>无</li>";
                            $("#stuMajorName").append(option);
                        }
                    }
                });
            });
            //学生管理条件：年级
            $("#stuMajorName").click(function(){
                $("#gradeName").html("选择年级");
                $("#className").html("选择班级");
                $("#stuGradeName").html('');
                $.ajax({
                    url: "<%=request.getContextPath()%>/jsons/loadstuGradeName.form",
                    dataType: "json",
                    data:{stuMajorName:$("#majorName").text()},
                    success: function (data) {
                        $("#stuGradeName").html('');
                        $("#stuGradeName").append("<li class='downselect'>选择年级</li>");
                        if(data.rows !=null && data.rows.length > 0){
                            for(var i=0;i<data.rows.length;i++) {
                                var option = "<li class='downselect'>"+data.rows[i].stuGradeName+"</li>";
                                $("#stuGradeName").append(option);
                            }
                        }else{
                            var option = "<li class='downselect'>无</li>";
                            $("#stuGradeName").append(option);
                        }
                    }
                });
            });
            //z综合查询条件：班级
            $("#stuGradeName").click(function() {
                $("#className").html("选择班级");
                $("#stuClassName").html('');
                $.ajax({
                    url: '<%=request.getContextPath()%>/jsons/loadclassnames1.form',
                    dataType: "json",
                    data: {stuGradeName: $("#gradeName").text(),stuCollageName:$("#collageName").text(),stuMajorName:$("#majorName").text()},
                    success: function (data) {
                        $("#stuClassName").html('');
                        $("#stuClassName").append("<li class='downselect'>选择班级</li>");
                        if (data.rows != null && data.rows.length > 0) {
                            for (var i = 0; i < data.rows.length; i++) {
                                var option ="<li class='downselect'>"+data.rows[i].stuClassName+"</li>";
                                $("#stuClassName").append(option);
                            }
                        } else {
                            var option = "<li class='downselect'>无</li>";
                            $("#stuClassName").append(option);
                        }
                    }
                });
            });
            $(".no").click(function(){
                $(".report").hide(100);
                $(".report textarea").val("");
                $('.window_Greybg').slideUp(200);
            })

            //当学院改变时清空之前的过滤条件
            function cleanFilterOption(){
                $("#className").html("选择班级");
                $("#gradeName").html("选择年级");
                $("#majorName").html("选择专业");
            }
       //清空收索条件
            $("#act_reset").click(function(){
                document.getElementById("form1").reset();
            });
            // 提交举报信息
            $(".yes").click(function(){
                var informByStudentId= $("#studentID").val();
                var informTel= $("#inforTel").val();
                var informContent= $(".sreason").val();
                var acttitle=rowData_.activityTitle;
                var actaward=rowData_.activityAward;
                var informType='';
                if(informByStudentId==null||informByStudentId==''){
                    layer.alert("举报人姓名为空不能提交");
                    return;
                }
                if(!_phone(informTel)){
                    layer.alert("手机格式不正确");
                    return;
                }
                if(informContent==null||informContent==''){
                    layer.alert("举报内容为空不能提交");
                    return;
                }
                if(informContent.length >= 400){
                    layer.alert("举报内容不能超过400字！");
                    return;
                }
                if(informByStudentId==informStudentId){
                    informType='质疑';
                }else {
                    informType='举报';
                }
                //验证重复举报
                $.ajax({
                    url: "/Check/checkReportAgain.form",
                    type: "post",
                    data: {
                        informStudentId: informStudentId,
                        informApplyId: informApplyId,
                        informByStudentId: informByStudentId,
                        informType: informType,
                        informTel:informTel
                    },
                    dataType: "json",
                    timeout: 30000,
                    success: function (data) {
                        if(data.rows.length>0){
                            layer.alert("同学，你已经举报过了！");
                        }else{
                            //保存举报信息
                            $.ajax({
                                url: "/Check/insertReportInfo.form",
                                type: "post",
                                data: {
                                    informByStudentId: informByStudentId,
                                    informType: informType,
                                    informContent: informContent,
                                    informStudentId: informStudentId,
                                    informApplyId: informApplyId,
                                    informTel:informTel,
                                    acttitle:acttitle,
                                    actaward:actaward
                                },
                                dataType: "json",
                                timeout: 30000,
                                success: function (data) {
                                    if(data.resultSet){
                                        layer.alert("提交成功");
                                    }else{
                                        layer.alert(data.errormessage);
                                    }
                                },
                                complete: function (XHR, TS) {
                                }
                            });
                        }
                    },
                    error: function (XMLHttpRequest, textStatus, errorThrown) {
                        layer.msg(XMLHttpRequest.status);
                        layer.msg(XMLHttpRequest.readyState);
                        layer.msg(textStatus);
                    },
                    complete: function (XHR, TS) {
                        $(".report").hide(100);
                        $('.window_Greybg').slideUp(200);
                    }
                });
            });
            $(".include_list").click(function(){
                var num=$(this).index();
                if($(".down").eq(num).css("display")=="none"){
                    for(var i=0;i<5;i++){
                        $(".down").eq(i).slideUp(200);
                    }
                    $(".down").eq(num).slideDown(200);
                }
                else{
                    $(".down").eq(num).slideUp(200);
                }
            });
            $(".include_list_right").click(function(){
                if($(".down").eq(4).css("display")=="none"){
                    for(var i=0;i<5;i++){
                        $(".down").eq(i).slideUp(200);
                    }
                    $(".down").eq(4).slideDown(200);
                }
                else{
                    $(".down").eq(4).slideUp(200);
                }
            });
            var a=0;
            $(".include_list").click(function(){
                a=$(this).index();
            });
            $(".include_list_right").click(function(){
                a=$(this).index();
            });
            //筛选layer
            setTimeout(function () {
                $(".include_list li").map(function () {
                    var tip;
                    var txt=$(this).text();
                    $(this).hover(function () {
                        if(this.offsetWidth < this.scrollWidth){
                            tip=layer.tips(txt, $(this), {
                                tips: [2, '#2a458c'],
                                time: 4000
                            });
                        }
                    }, function () {
                        layer.close(tip);
                    });
                });
            },1000);
            $(".down").on("click",".downselect",function(){
                var id=$(this).text();
                $(this).parent().prev().find(".project_sort").html(id);
                page=1;
//                $(".btn_start").click();
                loadActivityContent();    //此处如果打开就会根据每次点击重新加载数据
            });
            var key=2;
            setTimeout(function () {
                $(".activityname-one").map(function () {
                    var tip;
                    var txt=$(this).text();
                    $(this).hover(function () {
                        if(this.offsetWidth < this.scrollWidth){
                            tip=layer.tips(txt, $(this), {
                                tips: [3, '#5c85ee'],
                                time: 4000
                            });
                        }
                    }, function () {
                        layer.close(tip);
                    });
                });
            },1000);
            //点击举报质疑关闭
            $(".title1 img").click(function () {
                $(this).parent().parent().hide(200);
                $(".window_Greybg").slideUp(200);
            });
            //防止IE8闪现，先隐藏，再显示
            setTimeout(function(){
                $(".topsearch").fadeIn("fast");
            },100);
        });

        function loadCheckInfo(){
            //按活动名搜索活动
            loadActivityContent();
        }
        //验证手机号码
        function _phone(phoneum){
            var phoneRegex = /^(((13|15|18)[0-9])|14[57]|17[0134678])\d{8}$/;
            if (!phoneRegex.test(phoneum)){
                return false;
            }
            return true;
        }

        //绑定回车事件
       $(document).ready(function(){
            $('#name_input').bind('keyup',function(event){
                if(event.keyCode=="13"){
                    loadActivityContent();
                }
            });
        });
    </script>
</head>
<body>
    <%@include file="header_new.jsp"%>
    <%--判断是否是登录状态--%>
    <%@include file="../common/CheckLogin.jsp"%>
    <div class="section">
        <div class="outside">
            <div class="rutern"><a href="javascript:history.go(-1);" class="ruterna" style="cursor:pointer;">返回</a><a class="ruterna">></a><a href="" class="ruterna">审核公示</a></div>
            <div class="centent">
                <div class="window_Greybg"></div>
                <div class="report">
                    <p class="title1"><span>举报/质疑</span> <img src="../../../asset_font_new/img/windowclose_03.png" alt=""></p>
                    <div class="repoat-top">
                        <div class="repoat-name"><span class="star">*</span><span class="name-text"><span class="jubao_zhiyi">举报</span>人姓名</span></div>
                        <div class="repoat-textboard"><input type="text" readonly="readonly" class="textborad" value="${loginName}" /></div>
                        <span class="input_memo_text"></span><br><br>
                        <div class="repoat-name"><span class="star">*</span><span class="name-text"><span class="jubao_zhiyi">举报</span>人电话</span></div>
                        <div class="repoat-textboard"><input type="text" class="textborad" value="" readonly="readonly" id="inforTel" /></div>
                        <span class="input_memo_text"></span><br><br>
                        <div class="report-reason"><span class="star">*</span><span class="name-text " ><span class="jubao_zhiyi">举报</span>原因</span></div>
                        <textarea class="sreason" id="informReason" placeholder="最多400字！"></textarea>
                    </div>
                    <div class="yesorno">
                        <div class="yes">确定</div>
                        <div class="no">取消</div>
                    </div>
                </div>
                <%--学生具体信细--%>
                <div class="stuWindow">
                    <b></b>
                    <ul class="top">
                        <li>
                            <b>姓名：</b>
                            <span id="name">王一涵</span>
                        </li>
                        <li>
                            <b>学院：</b>
                            <span id="college">软件学院</span>
                        </li>
                        <li>
                            <b>专业：</b>
                            <span id="major">软件工程</span>
                        </li>
                        <li>
                            <b>班级：</b>
                            <span id="class">0904</span>
                        </li>
                        <li>
                            <b>学号：</b>
                            <span id="stuId">20151505</span>
                        </li>
                    </ul>
                    <div class="middle">
                        <b>活动分类</b>
                    </div>
                    <ol>
                        <ol>
                            <li class="first" id="first">
                                <p>活动标题</p>
                                <span>东北大学演说家大赛</span>
                            </li>
                            <li class="secound" id="secound">
                                <p>活动时间</p>
                                <span>2017-1-22</span>
                            </li>
                            <li class="last" id="last">
                                <p>活动级别</p>
                                <span>国家级</span>
                            </li>
                        </ol>
                        <ol>
                            <li class="first" id="one">
                                <p>能力标签</p>
                                <span>思辨、表达、能力</span>
                            </li>
                            <li class="secound" id="two">
                                <p>获得奖项</p>
                                <span>七等奖</span>
                            </li>
                        </ol>
                    </ol>
                    <button>确认</button>
                </div>
                <div class="topsearch" style="display: none;">
                    <form id="form1" onsubmit="return false;">
                        <div class="include_list">
                            <div class="CCP_project">
                                <div class="project_sort" id="collageName">选择学院</div>
                                <div class="block_bule"><div class="block"></div></div>
                            </div>
                            <ul class="down" id="stuCollageName"><li class="downselect">全部</li></ul>
                        </div>
                        <div class="include_list">
                            <div class="CCP_project">
                                <div class="project_sort" id="majorName">选择专业</div>
                                <div class="block_bule"><div class="block"></div></div>
                            </div>
                            <ul class="down" id="stuMajorName"><li class="downselect">全部</li></ul>
                        </div>
                        <div class="include_list">
                            <div class="CCP_project">
                                <div class="project_sort" id="gradeName">选择年级</div>
                                <div class="block_bule"><div class="block"></div></div>
                            </div>
                            <ul class="down" id="stuGradeName"><li class="downselect">全部</li></ul>
                        </div>
                        <div class="include_list">
                            <div class="CCP_project">
                                <div class="project_sort" id="className">选择班级</div>
                                <div class="block_bule"><div class="block"></div></div>
                            </div>
                            <ul class="down" id="stuClassName"><li class="downselect">全部</li></ul>
                        </div>
                        <input type="text" id="name_input" value="" placeholder="请输入学号或姓名或活动标题">&nbsp;&nbsp;
                        <%--<input type="text" id="act_input" value="" placeholder="请输入活动名">--%>
                        <input type="button" id="act_search" value="搜索" class="ser" onclick="loadActivityContent()">
                    </form>
                </div>
                <div class="list-board">
                    <div class="list-top">
                        <div class="activityname">活动名</div>
                        <div class="time">活动时间</div>
                        <div class="name">学生姓名/团体名字</div>
                        <div class="caozuo">操作</div>
                    </div>
                    <div class="table_box" ></div>
                </div>
            </div>
        </div>
        <!--分页-->
        <div class="page_count_box">
            <ul id="paging_btn_box">
                <img src="<%=request.getContextPath()%>/asset_font_new/img/pageleft_06.png" alt="" title="上一页" class="btn_left">
                <li>
                    <a href="javascript:void(0);" class="page_count btn_start currentpage">1</a>
                </li>
                <span class="prev_group">. . .</span>
                <li>
                    <a href="javascript:void(0);" class="page_count btn_1" >2</a>
                </li>
                <li>
                    <a href="javascript:void(0);" class="page_count btn_2">3</a>
                </li>
                <li>
                    <a href="javascript:void(0);" class="page_count btn_3">4</a>
                </li>
                <span class="next_group">. . .</span>
                <li>
                    <a href="javascript:void(0);" class="page_count btn_end">10</a>
                </li>
                <img src="<%=request.getContextPath()%>/asset_font_new/img/pageright_06.png" alt="" title="下一页" class="btn_right">
            </ul>
        </div>
        <!--我的信息-->
        <%@include file="myInfo.jsp"%>
    </div>
    <input type="hidden" id="studentID" value="${studentid}" />
    <%@include file="footer_new.jsp"%>
</body>
</html>

