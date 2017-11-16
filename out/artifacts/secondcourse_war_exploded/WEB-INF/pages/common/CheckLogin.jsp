<%@ page import="javax.jms.Session" %><%--
  Created by IntelliJ IDEA.
  User: admin
  Date: 2016/4/22
  Time: 14:14
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%

    String nowmenu = (String )request.getParameter("moduleType");
    session.setAttribute("nowmenu",nowmenu);

    if(session.getAttribute("loginName")!=null){
        String username = session.getAttribute("loginName").toString();
        if(username.equals("")){%>
            <script>
                window.location = "login.form";
                window.parent.goToLogin();
            </script>
        <%}
    }else {%>
        <script>
            window.location = "login.form";
            window.parent.goToLogin();
        </script>
    <%}
%>