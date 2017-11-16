<%--
  Created by IntelliJ IDEA.
  User: admin
  Date: 2016/9/10
  Time: 16:59
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java"  pageEncoding="UTF-8" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01//EN"
"http://www.w3.org/TR/html4/strict.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" lang="en">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=9; IE=8; IE=7; IE=EDGE">
    <title>新闻集合</title>
    <link rel="Shortcut Icon" href="<%=request.getContextPath()%>/asset/image/neu.jpg" type="image/x-icon">

    <%--注意引入的时候不能有空格 否则会报错--%>
    <link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/asset_font_new/css/common.css"/>
    <link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/asset_font_new/css/commonhead.css"/>
    <link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/asset_font_new/css/all.css"/>
    <link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/asset_font_new/css/index.css"/>
    <link href="<%=request.getContextPath()%>/asset_font/css/Newlistone.css" rel="stylesheet" type="text/css" />
    <link rel="stylesheet" href="<%=request.getContextPath()%>/asset_font/css/Radio2.css" type="text/css" />
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
    <script type="text/javascript" src="<%=request. getContextPath()%>/asset/js/paging/paging.js"></script>
    <script type="text/javascript">
        var key=1;
        var  newsUrl ="";
        $(function(){

            //先锋新闻的加载
            loadSchoolNews();
            //先锋青年的加载
            loadCollegeNews();

            $("#more1").click(function(){
                location.href="pioneerNews.form";
            });
            $("#more2").click(function(){
                location.href="pioneerYouth.form";
            });
        });
    //定义路径
        function  loadSchoolNews(){
            var loading= layer.load(1, {shade: [0.1,'#000']});
            newsUrl="/news/loadSchoolNewsBypage.form";
            page= 0;rows=8;
            //让 1 重新拥有 当前页的样式
            $.ajax({
                url:newsUrl,
                type:"post",
                data:{page:page,rows:rows},
                dataType:"json",
                success:function(data){
                    total=data.total;

                    //totalPage=parseInt(total/rows+1);
                    if((data!=null && data.rows!=null && data.rows.length>0)){
                        totalPage = Math.ceil(total/rows);
                        $("#news_pioneer").html("");
                        var optionstring = "<ol class=\"circle-list\">";
                        for(var i=0;i<data.rows.length;i++){
                            var item=data.rows[i];
                            optionstring +=
                                    '<li class="center_li" onclick="window.location.href=\'/views/font/news_detail.form?id='+item.newsId+'\'">'+
                                    '<div class="hidden">'+
                                    '<a class="center_li_span" title="'+item.newsTitle+'"><b>'+item.newsTitle+'</b></a>'+
//                                    '<span class="center_li_point">'+
//                                    '····························································' +
//                                    '·····························································' +
//                                    '·····························································' +
//                                    '··················'+
//                                    '</span>'+
                                    '</div>'+
                                    '<span class="center_li_time">'+item.nDate+'</span>'+
                                    '</li>';
                        }
                        optionstring+="</ol>";
                        $("#news_pioneer").html(optionstring);

                    }else{
                        totalPage=1;
                    }
                    pagingInit();
                    layer.close(loading);
                },
                error:function(){
                    layer.msg("服务器连接失败，请稍后再试");
                    layer.close(loading);
                }
            });
        }
        function  loadCollegeNews(){
            var loading=layer.load(1, {shade: [0.1,'#000']});
            newsUrl="/news/loadCollegeNewsBypage.form";
            page= 0;rows=8;
            $.ajax({
                url:newsUrl,
                type:"post",
                data:{page:page,rows:rows},
                dataType:"json",
                success:function(data){
                    total=data.total;

                    //totalPage=parseInt(total/rows+1);
                    if((data!=null && data.rows!=null && data.rows.length>0)){
                        totalPage = Math.ceil(total/rows);
                        $("#news_youth").html("");
                        var optionstring = "<ol class=\"circle-list\">";
                        for(var i=0;i<data.rows.length;i++){
                            var item=data.rows[i];
                            optionstring +=
                                    '<li class="center_li" onclick="window.location.href=\'/views/font/news_detail.form?id='+item.newsId+'\'">'+
                                    '<div class="hidden">'+
                                    '<a class="center_li_span" title="'+item.newsTitle+'"><b>'+item.newsTitle+'</b></a>'+
//                                    '<span class="center_li_point">'+
//                                    '····························································' +
//                                    '·····························································' +
//                                    '·····························································' +
//                                    '··················'+
//                                    '</span>'+
                                    '</div>'+
                                    '<span class="center_li_time">'+item.nDate+'</span>'+
                                    '</li>';
                        }
                        optionstring+="</ol>";
                        $("#news_youth").html(optionstring);

                    }else{
                        totalPage=1;
                    }
                    pagingInit();
                    layer.close(loading);
                },
                error:function(){
                    layer.msg("服务器连接失败，请稍后再试");
                    layer.close(loading);
                }
            });
        }
        //加载所有新闻列表
        $(function() {
            //初始时默认为加载学校新闻的信息
            $(".center_school").click();
        })
    </script>
    <style type="text/css">

    </style>
</head>
<body>
<%@include file="header_new.jsp"%>
<%--判断是否是登录状态--%>
<%@include file="../common/CheckLogin.jsp"%>
<div class="section">
    <div class="box2">
        <div class="center_head_box">
            <a href="javascript:history.go(-1);" class="center_head_a" id="return">返回>
            </a>
            <span class="center_head_span">先锋领航</span>
        </div>

        <div class="center_contant_box">
            <div class="center_cantant_box_left">
                <div class="newsBox">
                    <div class="center_contant_new_box">
                        <div class="center_school">先锋新闻</div>
                        <b></b>
                    </div>
                    <ul class="center_ul list" style="position: relative" >
                        <div id="news_pioneer">

                        </div>
                    </ul>
                    <a class="more" id="more1" href="javascript:void(0)">
                        more >
                    </a>
                </div>
                <div class="newsBox">
                    <div class="center_contant_new_box">
                        <div class="center_accda">先锋青年</div>
                        <b></b>
                    </div>
                    <ul class="center_ul list" style="position: relative" >

                        <div id="news_youth">

                        </div>
                    </ul>
                    <a class="more" id="more2" href="javascript:void(0)">
                        more >
                    </a>
            </div>
            </div>
        </div>
    </div>
    <!--我的信息-->
    <%@include file="myInfo.jsp"%>
</div>

<%@include file="footer_new.jsp"%>
</body>
</html>
