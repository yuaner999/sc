<%--
  Created by IntelliJ IDEA.
  User: admin
  Date: 2016/9/10
  Time: 16:37
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java"  pageEncoding="UTF-8" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01//EN"
"http://www.w3.org/TR/html4/strict.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" lang="en">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=9; IE=8; IE=7; IE=EDGE">
    <title>校园新闻</title>
    <link rel="Shortcut Icon" href="<%=request.getContextPath()%>/asset/image/neu.jpg" type="image/x-icon">
    <link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/asset_font_new/css/common.css"/>
    <link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/asset_font_new/css/commonhead.css"/>
    <link href="<%=request.getContextPath()%>/asset_font/css/accNews.css" rel="stylesheet" type="text/css" />
    <link rel="stylesheet" href="<%=request.getContextPath()%>/asset_font/css/headfoot.css" />
    <link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/asset_font_new/css/index.css"/>
    <link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/asset_font_new/css/all.css"/>
    <link rel="stylesheet" href="<%=request.getContextPath()%>/asset_font/css/Radio2.css" type="text/css" />
    <script type="text/javascript" src="<%=request.getContextPath()%>/asset_font/js/jquery-1.11.1.min.js"></script>
    <script type="text/javascript" src="<%=request.getContextPath()%>/asset_font/js/respond.js"></script>
    <script src="<%=request.getContextPath()%>/asset_font/js/headfoot.js"></script>
    <script type="text/javascript" src="<%=request.getContextPath()%>/asset/layer/layer.js"></script>
    <script type="text/javascript" src="<%=request.getContextPath()%>/asset_font/js/accNews.js"></script>
    <script src="<%=request.getContextPath()%>/asset_font_new/js/jquery.dotdotdot.js" type="text/javascript" charset="utf-8"></script>
    <script src="<%=request.getContextPath()%>/asset_font_new/js/common.js" type="text/javascript" charset="utf-8"></script>
    <script src="<%=request.getContextPath()%>/asset_font_new/js/respond.js" type="text/javascript" charset="utf-8"></script>
    <script src="<%=request.getContextPath()%>/asset_font_new/js/index.js" type="text/javascript" charset="utf-8"></script>
</head>
<body>
<%@include file="header_new.jsp"%>
<div class="section">
    <div class="contentdetail">
        <div class="center_head_box">
            <a href="javascript:history.go(-1);" class="center_head_a">返回>
                <span class="center_head_span">新闻详情</span>
            </a>
            <div class="center_head_ri"></div>
            <script type="text/javascript" src="<%=request.getContextPath()%>/asset_font/js/jquery-1.11.1.min.js"></script>
            <script type="text/javascript" src="<%=request.getContextPath()%>/asset_font/js/respond.js"></script>
            <script >
                var key=1;  //不要删，影响导航的选中效果
                //加载数据
                function getQueryString(name) {
                    var reg = new RegExp("(^|&)" + name + "=([^&]*)(&|$)", "i");
                    var r = window.location.search.substr(1).match(reg);
                    if (r != null) return unescape(r[2]);
                    return null;
                }
                //获得传过来的新闻id
                var newsId = getQueryString("id");
                //加载内容
                $(function(){
                    $.ajax({
                        url:"/news/loadNewsById.form",
                        dataType:"json",
                        type:"post",
                        data:{"newsId":newsId},
                        success:function(data){
                            //选择div
                            var $div=$(".center_cen_contant_box");
                            //先清空内容
                            $div.html("");
                            if(data.rows.length==0){
                                layer.msg("加载失败");
                                return;
                            }
                            var str="";
                            str=
                                    '<div class="center_contant_head">'+data.rows[0].newsTitle+'</div>'+
                                    <%--'<div class="center_cen_contant_img_box">'+--%>
                                    <%--'<img src="<%=request.getContextPath()%>/Files/Images/'+data.rows[0].newsImg+'" onerror="(this).src=\'/Files/Images/newsimg_03.png\'" class="center_cen_contant_img" />'+--%>
                                    <%--'</div>'+--%>
                                    '<div class="center_contant_text_box">'+
                                    '<p>'+data.rows[0].newsContent+'</p>'+
                                    '</div>'+
                                    '<span class="center_contant_time">'+data.rows[0].newsCreator+'</span>'+
                                    '<span class="center_contant_time">'+data.rows[0].nDate+'</span>';
                            str=str.replace(/null/gi,"");
                            //添加到div下
                            $div.append(str);
                            //                console.log("加载完毕");
                        },
                        error:function(){
                            layer.msg("加载新闻失败,请稍后重试");
                        }
                    });
                })


            </script>
        </div>
        <div class="center_contant_box">
            <div class="center_cen_contant_box">
                <div class="center_contant_head">东北大学新闻</div>
                <%--<div class="center_cen_contant_img_box">--%>
                <%--<img src="<%=request.getContextPath()%>/asset_font/img/newImg.png" class="center_cen_contant_img"/>--%>
                <%--</div>--%>
                <%--<div class="center_contant_text_box">--%>
                <%--<p>东北大学（Northeastern University），简称东大(NEU)，中华人民共和国教育部直属的理工类研究型大学，坐落于东北中心城市沈阳，是国家首批“211工程”和“985工程”重点建设高校，由教育部、辽宁省、沈阳市三方重点共建，先后入选了国家“2011计划”、“111计划”、“卓越工程师教育培养计划”、“国家大学生创新性实验计划”等工程，为“21世纪学术联盟”合作高校，系首批建立研究生院的32所高校、研究生招生34所自主划线高校之一，是中共中央1960年、1978年确定的全国重点大学，国务院首批批准的具有博士学位授予权的高校。</p>--%>
                <%--<p>东北大学始建于1923年4月，1928年8月至1937年1月，著名爱国将领张学良将军兼任校长。“九·一八”事变后，东北大学被迫先后迁徙北平、开封、西安、四川三台等地。在此期间，广大师生积极参加爱国抗日运动，是一二·九运动的先锋队和主力军。1950年8月，沈阳工学院、抚顺矿专和鞍山工专合组为东北工学院。1993年3月8日，复名为东北大学。学校建有中国第一个大学软件园，第一台模拟电子计算机，第一家上市的大学企业，梁思成、林徽因夫妇创建的中国大学第一个建筑系。</p>--%>
                <%--<p>截至2015年12月，学校占地总面积253万平方米，建筑面积137万平方米。设有66个本科专业，其中国家级特色专业15个；有189个学科有权招收和培养硕士研究生；108个学科有权招收和培养博士研究生；有17个博士后流动站。在校博士研究生3445人，硕士研究生7073人，普通本科生29248人[1]  。</p>--%>
                <%--<p>截至2015年12月，学校占地总面积253万平方米，建筑面积137万平方米。设有66个本科专业，其中国家级特色专业15个；有189个学科有权招收和培养硕士研究生；108个学科有权招收和培养博士研究生；有17个博士后流动站。在校博士研究生3445人，硕士研究生7073人，普通本科生29248人[1]  。</p>--%>
                <%--</div>--%>
                <%--<span class="center_contant_time">2016/8/24</span>--%>
                <%--<span class="center_contant_time">东北大学</span>--%>
            </div>
            <div id="f"></div>
        </div>
    </div>
    <!--我的信息-->
    <%@include file="myInfo.jsp"%>
</div>
<%@include file="footer_new.jsp"%>
</body>
</html>
