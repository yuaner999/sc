<%@ page import="javax.jms.Session" %>
<%--
  Created by IntelliJ IDEA.
  User: admin
  Date: 2016/4/22
  Time: 14:14
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%
    if (session.getAttribute("openid") == null) {
%>
<script>
    window.location = "/views/index.form"
</script>
<%
    }
%>