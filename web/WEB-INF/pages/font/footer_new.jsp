<%--
  Created by IntelliJ IDEA.
  User: yuanshenghan
  Date: 2016/11/1
  Time: 13:33
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java"  pageEncoding="UTF-8" %>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/asset_font_new/css/foot.css"/>
<script>
    <%--加载友情链接--%>
    <%--兼容ie9,走ssm--%>
    <%--客户不需要此功能，暂时注释关闭掉--%>
//    $(function(){
//        $.ajax({
//            url:"/jsons/loadblogrollInfo1.form",
//            type:"post",
//            dataType:"json",
//            success:function(data){
//                if(data.rows.length>0){
//                    var length=data.rows.length;
//                    var str="";
//                    for(var i=0;i<length-1;i++){
//                        str += "<li><a href=http://"+data.rows[i].linkAddress+" target='_blank'style='color:#ffffff'>"+data.rows[i].linkName+"</a>|</li>";
//                    }
//                    str += "<li><a href=http://"+data.rows[i].linkAddress+" target='_blank' style='color:#ffffff'>"+data.rows[length-1].linkName+"</a></li>";
//                    str=str.replace(/null/gi,"");
//                    //将str加到ul下
//                    $("#footer_ul").append(str);
//                }
//            },
//            error:function(){
//                layer.alert("服务器连接失败");
//            }
//        });
//    })
</script>
<body>
<!--底部
 -->
<div class="footer">
    <div class="footup">
        <div class="footup_left">
            <p>校址：辽宁省沈阳市和平区文化路三巷11号 | 邮编：110819 | 辽ICP备05001360号</p>
            <p>Northeastern University 2015 | 设计制作：<a href="http://www.neunb.com/" target="_blank">东深科技</a> | 技术运维：<a href="http://test.neupioneer.com/index.html" target="_blank">共青团东北大学委员会</a></p>
            <p>共青团“第二课堂成绩单”信息认证系统（PC端）版本号：V 1.0</p>
        </div>
    </div>
    <%--<div class="footdown">--%>
        <%--<ul id="footer_ul">--%>

        <%--</ul>--%>
    <%--</div>--%>
</div>
