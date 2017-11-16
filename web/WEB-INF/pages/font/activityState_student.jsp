<%--
  Created by IntelliJ IDEA.
  User: NEUNB
  Date: 2017/2/14
  Time: 9:00
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java"  pageEncoding="UTF-8" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01//EN"
"http://www.w3.org/TR/html4/strict.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" lang="en">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=9; IE=8; IE=7; IE=EDGE">
    <title>已报名活动</title>
    <link rel="Shortcut Icon" href="<%=request.getContextPath()%>/asset/image/neu.jpg" type="image/x-icon">

    <%--注意引入的时候不能有空格 否则会报错--%>
    <link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/asset_font_new/css/common.css"/>
    <link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/asset_font_new/css/commonhead.css"/>
    <link href="<%=request.getContextPath()%>/asset_font/css/Newslist.css" rel="stylesheet" type="text/css" />
    <link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/asset_font_new/css/index.css"/>
    <link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/asset_font_new/css/all.css"/>
    <link rel="stylesheet" href="<%=request.getContextPath()%>/asset_font/css/Radio2.css" type="text/css" />
    <link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/asset_font_new/css/selectactive.css"/>
    <script type="text/javascript" src="<%=request.getContextPath()%>/asset_font/js/jquery-1.11.1.min.js"></script>
    <script type="text/javascript" src="<%=request.getContextPath()%>/asset_font/js/Newslist.js"></script>
    <script type="text/javascript" src="<%=request.getContextPath()%>/asset/layer/layer.js"></script>
    <script src="<%=request.getContextPath()%>/asset_font_new/js/jquery.dotdotdot.js" type="text/javascript" charset="utf-8"></script>
    <script src="<%=request.getContextPath()%>/asset_font_new/js/common.js" type="text/javascript" charset="utf-8"></script>
    <script src="<%=request.getContextPath()%>/asset_font_new/js/respond.js" type="text/javascript" charset="utf-8"></script>
    <script src="<%=request.getContextPath()%>/asset_font_new/js/index.js" type="text/javascript" charset="utf-8"></script>

    <!--分页-->
    <%--先不用原来的样式--%>
    <link type="text/css" rel="stylesheet" href="<%=request.getContextPath()%>/asset/js/paging/paging.css" />
    <script type="text/javascript" src="<%=request. getContextPath()%>/asset/js/paging/paging_new.js"></script>
    <script type="text/javascript">
        //定义路径
       var newsUrl="/news/loadSchoolNewsBypage.form";
       var state=1;
        //加载所有活动列表
        $(function() {
            //初始时默认为加载所有该生参与的活动信息
            $("#firstchoose").click();
        })
        function reload(val){
            state=val;
            page=1;
            currentPage(".btn_start");
            $(".btn_3").text(4);
            $(".btn_2").text(3);
            $(".btn_1").text(2);
            $(".btn_start").text(1);
            $(".prev_group").hide();
            if (state==1){
                document.getElementById('firstchoose').click();
            }else if(state==2){
                document.getElementById('firstchoose1').click();
            }else if(state==3){
                document.getElementById('firstchoose2').click();
            }else{
                document.getElementById('firstchoose3').click();
            }
            loadActivityData(state);
        }
    </script>
</head>
<body>
<%@include file="header_new.jsp"%>
<%--判断是否是登录状态--%>
<%@include file="../common/CheckLogin.jsp"%>
<div class="section">
    <div class="newsBox">
        <div class="center_head_box">
            <span>参与的活动</span>
            <a href="javascript:history.go(-1);" class="center_head_a" id="return">返回>
                <span class="center_head_span">参与的活动</span>
            </a>
        </div>
        <div class="center_contant_box">
            <div>
                <ol class="choose" >
                    <li class="sele" value="1" ><input id="firstchoose" type="radio" name="statement" onclick="reload(1)"><span onclick="reload(1)">全部</span></li>
                    <li value="2" ><input id="firstchoose1" type="radio" name="statement" onclick="reload(2)"><span onclick="reload(2)">未开始活动</span></li>
                    <li value="3" ><input id="firstchoose2" type="radio" name="statement" onclick="reload(3)"><span onclick="reload(3)">进行中活动</span></li>
                    <li value="4" ><input id="firstchoose3" type="radio" name="statement" onclick="reload(4)"><span onclick="reload(4)">已结束活动</span></li>
                </ol>
            </div>
            <ul class="center_ul list" >
                <ol class="circle-list" id="news_all">
                </ol>
            </ul>

            <div class="page_count_box">
                <ul id="paging_btn_box">
                    <img src="<%=request.getContextPath()%>/asset_font_new/img/pageleft_06.png" alt="" title="上一页"  class="btn_left">
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
                    <span class="newsNext_group">. . .</span>
                    <li>
                        <a href="javascript:void(0);" class="page_count btn_end">10</a>
                    </li>
                    <img src="<%=request.getContextPath()%>/asset_font_new/img/pageright_06.png" alt="" title="下一页" class="btn_right">
                </ul>
            </div>
        </div>
    </div>
    <!--我的信息-->
    <%@include file="myInfo.jsp"%>
    <script>
        var key=3;
        $(".choose li input").click(function () {
            $(this).parent().addClass("sele");
            $(this).parent().siblings().removeClass("sele");
        })
    </script>
</div>
<%@include file="footer_new.jsp"%>
</body>
</html>
