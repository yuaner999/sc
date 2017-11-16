<%--
  Created by IntelliJ IDEA.
  User: admin
  Date: 2016/9/10
  Time: 17:37
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java"  pageEncoding="UTF-8" %>
<!DOCTYPE html>
<script>
    <%--加载友情链接--%>
    <%--兼容ie9,走ssm--%>
    $(function(){
        $.ajax({
            url:"/jsons/loadblogrollInfo1.form",
            type:"post",
            dataType:"json",
            success:function(data){
                var length=data.rows.length;
                var str="";
                for(var i=0;i<length-1;i++){
                    str += "<li><a href=http://"+data.rows[i].linkAddress+" target='_blank'>"+data.rows[i].linkName+"</a></li><span>|</span>";
                }
                str += "<li><a href=http://"+data.rows[length-1].linkAddress+" target='_blank'>"+data.rows[length-1].linkName+"</a></li>";
                str=str.replace(/null/gi,"");
                //将str加到ul下
                $("#footer_ul").append(str);

            },
            error:function(){
                layer.alert("服务器连接失败");
            }
        });
    })

</script>
<div class="foot">
    <div class="footup">
        <span class="schaddress">校址：辽宁省沈阳市和平区文化路三巷11号</span> |
        <span class="postcode">邮编：110819</span> |
        <span class="recordnum">辽ICP备05001360号</span>
        <span class="schyear">Northeastern University 2015</span>
    </div>
    <div class="footdown">
        <ul class="department" id="footer_ul">
        </ul>
    </div>
</div>
