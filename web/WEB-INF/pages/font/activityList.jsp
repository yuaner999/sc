<%--
  Created by IntelliJ IDEA.
  User: admin
  Date: 2016/9/10
  Time: 16:41
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java"  pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>

<head>
    <meta charset="utf-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=9; IE=8; IE=7; IE=EDGE">
    <title>共青团“第二课堂成绩单”信息认证平台</title>
    <link rel="Shortcut Icon" href="<%=request.getContextPath()%>/asset/image/neu.jpg" type="image/x-icon">
    <script type="text/javascript" src="<%=request.getContextPath()%>/asset_font/js/jquery-1.11.1.min.js"></script>
    <script type="text/javascript" src="<%=request.getContextPath()%>/asset/layer/layer.js"></script>
    <link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/asset_font_new/css/common.css"/>
    <link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/asset_font_new/css/commonhead.css"/>
    <link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/asset_font_new/css/index.css"/>
    <link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/asset_font/css/new_file.css" />
    <link rel="stylesheet" href="<%=request.getContextPath()%>/asset_font/css/headfoot.css" />
    <link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/asset_font_new/css/all.css"/>
    <link rel="stylesheet" href="<%=request.getContextPath()%>/asset_font/css/Radio2.css" type="text/css" />
    <!--分页-->
    <%--先不用原来的样式--%>
    <link type="text/css" rel="stylesheet" href="<%=request.getContextPath()%>/asset/js/paging/paging.css" />
    <script type="text/javascript" src="<%=request.getContextPath()%>/asset_font/js/new.js"></script>
    <script src="<%=request.getContextPath()%>/asset/js/common.js" type="text/javascript" charset="utf-8"></script>
    <script type="text/javascript" src="<%=request.getContextPath()%>/asset_font/js/jquery.dotdotdot.js"></script>
    <script type="text/javascript" src="<%=request.getContextPath()%>/asset_font/js/ellipsis.js"></script>
    <script type="text/javascript" src="<%=request.getContextPath()%>/asset_font/js/click.js"></script>
    <script type="text/javascript" src="<%=request.getContextPath()%>/asset_font/js/downlist.js"></script>
    <script type="text/javascript" src="<%=request.getContextPath()%>/asset_font/js/respond.js"></script>

    <script src="<%=request.getContextPath()%>/asset_font_new/js/common.js" type="text/javascript" charset="utf-8"></script>
    <script src="<%=request.getContextPath()%>/asset_font_new/js/index.js" type="text/javascript" charset="utf-8"></script>
    <script src="<%=request.getContextPath()%>/asset_font/js/headfoot.js"></script>
    <script type="text/javascript" src="<%=request.getContextPath()%>/asset_mobile/js/echarts.min.js"></script>
    <style>
        .per_content_one{
            width:32%;
            margin-left: 4%;
            margin-right: 5%;
            margin-top: 20px;
        }
        .per_content_one>div{
            margin: 0 !important;
            width:100% !important;
        }
        .per_content_one img{
            width:100%;
            margin: 0 !important;
        }
        .per_content_two{
            width:59% ;
        }
        .per_content_two p{
            word-break: break-all;
        }
        @media screen and (max-width: 1441px){
            #posi {
                top:200px !important;
            }
        }
        @media screen and (min-width: 1441px){
            #posi {
                top:258px !important;
                left: 0 !important;
            }
        }
        .NTF_title{
            width: 80% !important;
        }
        #firstBox{
            bottom: 28% !important;
        }
    </style>
    <script>
        var key=2;
        //加载所有活动列表
        $(function() {
            $("#activity_Title").val('');
            load();
            //绑定Enter键
            $("#activity_Title").bind('keypress', function(e) {
                var keycode;
                if(window.event){
                    keycode = e.keyCode; //IE
                }
                else if(e.which){
                    keycode = e.which;
                }
                if (keycode == 13) {
                    $("#search_content").click();
                }
            });

            $("#checkAll").click(function(){
                window.location.href="<%=request.getContextPath()%>/views/font/activityList.form";
            });
        });
        function load(){
            loadAct();
        }
        function jump(){
            window.history.back();
        }
    </script>
</head>
<body>
<%@include file="header_new.jsp"%>
<%--判断是否是登录状态--%>
<%@include file="../common/CheckLogin.jsp"%>
<div class="section">
<div class="main">
    <div class="list_back">
        <b onclick="jump()" style="cursor:pointer;" class="back">返回></b>
        <b>活动公告</b>
        <div class="content_center_searsh"><a href="javascript:void(0)"><span class="CCS_search">搜索</span></a>
            <div class="search">
                <input class="input" type="text" id="activity_Title"/>
                    <span class="search_img">
                    <a id="search_content" href="javascript:void(0)" onclick="load()"><img src="<%=request.getContextPath()%>/asset_font/img/search_new.png" class="Magnifier"/></a>
                </span>
            </div>
        </div>
    </div>
    <div class="contentBox">
        <div class="content_left">
            <div class="content_left_activity"><span class="CLA_text" id="checkAll" style="cursor:pointer;">全部活动</span><span class="CLA_blue"></span></div>
            <%--<div class="content_left_activity gray"><span class="CLA_text" style="cursor:pointer;">活动预告</span><span class="CLA_blue"></span></div>--%>
            <%--<div class="content_left_foreshow"><span class="CLF_text">活动预告</span><span class="CLF_blue"></span></div>--%>
        </div>
        <div class="content_center">
            <div class="content_center_project">
                <div class="include_list">
                    <div class="CCP_project">
                        <div class="project_sort" id="aclass">项目类别</div>
                        <div class="block_bule">
                            <div class="block"></div>
                        </div>
                    </div>
                    <ul class="down">
                        <li class="downselect">全部</li>
                        <li class="downselect">思想政治教育类</li>
                        <li class="downselect">能力素质拓展类</li>
                        <li class="downselect">学术科技与创新创业类</li>
                        <li class="downselect">社会实践与志愿服务类</li>
                        <li class="downselect">社会工作与技能培训类</li>
                    </ul>
                </div>
                <div class="include_list">
                    <div class="CCP_project">
                        <div class="project_sort" id="alevel">项目级别</div>
                        <div class="block_bule">
                            <div class="block"></div>
                        </div>
                    </div>
                    <ul class="down">
                        <li class="downselect">全部</li>
                        <li class="downselect">国际级</li>
                        <li class="downselect">国家级</li>
                        <li class="downselect">省级</li>
                        <li class="downselect">市级</li>
                        <li class="downselect">校级</li>
                        <li class="downselect">院级</li>
                        <li class="downselect">团支部级</li>
                    </ul>
                </div>
                <div class="include_list">
                    <div class="CCP_project">
                        <div class="project_sort" id="anature">项目性质</div>
                        <div class="block_bule">
                            <div class="block"></div>
                        </div>
                    </div>
                    <ul class="down">
                        <li class="downselect">全部</li>
                        <li class="downselect">活动参与</li>
                        <li class="downselect">讲座报告</li>
                        <li class="downselect">比赛</li>
                        <li class="downselect">培训</li>
                        <li class="downselect">其它</li>
                    </ul>
                </div>
                <div class="include_list">
                    <div class="CCP_project">
                        <div class="project_sort" id="apower">能力方向</div>
                        <div class="block_bule">
                            <div class="block"></div>
                        </div>
                    </div>
                    <ul class="down">
                        <li class="downselect">全部</li>
                        <li class="downselect">思辨能力</li>
                        <li class="downselect">执行能力</li>
                        <li class="downselect">表达能力</li>
                        <li class="downselect">领导能力</li>
                        <li class="downselect">创新能力</li>
                        <li class="downselect">创业能力</li>
                    </ul>
                </div>
                <div class="include_list_right">
                    <div class="CCP_modality">
                        <div class="project_sort" id="apartic">参与形式</div>
                        <div class="block_bule">
                            <div class="block"></div>
                        </div>
                    </div>
                    <ul class="down">
                        <li class="downselect">全部</li>
                        <li class="downselect">个人</li>
                        <li class="downselect">团体</li>
                    </ul>
                </div>
            </div>
            <div id="allNews">
            </div>
        </div>
        <div class="page_count_box">
            <ul id="paging_btn_box">
                <img src="<%=request.getContextPath()%>/asset_font_new/img/pageleft_06.png" alt="" title="上一页"  class="btn_left">
                <li>
                    <a href="javascript:void(0);" class="page_count btn_start currentpage">1</a>
                </li>
                <span class="prev_group">. . .</span>
                <li>
                    <a href="javascript:void(0);" class="page_count btn_1">2</a>
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
               <img src="<%=request.getContextPath()%>/asset_font_new/img/pageright_06.png" alt="" title="下一页"  class="btn_right">
            </ul>
        </div>
    </div>
</div>
<!--我的信息-->
<%@include file="myInfo.jsp"%>
</div>
<%@include file="footer_new.jsp"%>
</body>
</html>

