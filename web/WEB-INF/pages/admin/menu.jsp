<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: liulei
  Date: 2016/4/22
  Time: 14:03
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java"  pageEncoding="UTF-8" %>
<%@ page import="com.model.Menu"%>
<%@ page import="java.util.*" %>
<html>
<head>
    <meta charset="UTF-8">
    <title>共青团"第二课堂成绩单"信息认证平台</title>
    <link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/asset/easyui/themes/default/easyui.css">
    <link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/asset/easyui/themes/icon.css">
    <script type="text/javascript" src="<%=request.getContextPath()%>/asset/easyui/jquery.min.js"></script>
    <script type="text/javascript" src="<%=request.getContextPath()%>/asset/easyui/jquery.easyui.min.js"></script>
    <script type="text/javascript" src="<%=request.getContextPath()%>/asset/easyui/locale/easyui-lang-zh_CN.js"></script>
    <script type="text/javascript" src="<%=request.getContextPath()%>/asset/js/manage/massage-helper.js"></script>
    <script type="text/javascript" src="<%=request.getContextPath()%>/asset/js/jquery.md5.js" ></script>
    <style>
        .index_box{
            width:500px;
            margin:0 auto;
            text-align: center;
            font-family: "楷体";
            font-size:30px;
        }
        .no_select{
            -moz-user-select: none;
            -webkit-user-select: none;
            -ms-user-select: none;
            -khtml-user-select: none;
            user-select: none;
        }
        .exit:hover{
            text-decoration: underline;
            cursor: pointer;
        }
    </style>
    <script type="text/javascript">
        //添加Tab标签
        function addTab(title, url){
            if ($('#tt').tabs('exists', title)){
                $('#tt').tabs('select', title);
            } else {
                var content = '<iframe scrolling="auto" frameborder="0"  src="'+url+'" style="width:100%;height:100%;"></iframe>';
                $('#tt').tabs('add',{
                    title:title,
                    content:content,
                    closable:true
                });
            }
        }
        //安全退出
        function Exit(){
            $.messager.confirm('提示', '确认退出当前帐号吗?', function(result){
                if (result){
                    $.post("/Login/ExitLogin.form",{},function(data){
//                        console.log(data);
                        goToLogin(data);
                    });
                }
            });
        }
        //修改密码
        function EditPassword(){
            $("#f").form("clear");
            $('#dd').dialog({
                modal:true
            });
        }
        //保存密码修改
        function OkPassword(){
            if($("#f").form('validate')){
                var jsonObject = $("#f").serializeObject();
                if(jsonObject.newpassword!=jsonObject.querypassword){
                    ShowMsg("两次密码输入不一样");
                    return;
                }
                jsonObject.oldpassword = $.md5(jsonObject.oldpassword);
                jsonObject.newpassword = $.md5(jsonObject.newpassword);
                $.post("/Login/EditPassword.form",jsonObject,function(data){
                    if(!isNaN(data) || data!="-1"){
                        ShowMsg("修改成功，请重新登录");
//                        /console.log(data);
                        goToLogin(data);
//                        setTimeout(function(){
//                            $.post("/Login/ExitLogin.form",{},function(data){
//                                console.log(data);
//                                goToLogin(data);
//                            });
//                        },1500);
                    }else if(data=="-1"){
                        ShowMsg("系统错误，请联系管理员");
                    }else {
                        ShowMsg(data);
                    }
                });
            }else {
                ShowMsg("请按照要求填写");
            }
        }
        function goToLogin(type){
//            console.log(type);
            window.location = "login.form?type="+type;
        }
        //序列化
        $.fn.serializeObject = function()
        {
            var o = {};
            var a = this.serializeArray();
            $.each(a, function() {
                if (o[this.name]) {
                    if (!o[this.name].push) {
                        o[this.name] = [o[this.name]];
                    }
                    o[this.name].push(this.value || '');
                } else {
                    o[this.name] = this.value || '';
                }
            });
            return o;
        };
    </script>
    <%--判断是否是登录状态--%>
    <%@include file="../common/CheckLogin.jsp"%>
</head>
<%!
    List<Menu> menuList = new ArrayList<Menu>();
    String menuStr = "";

    public List<Menu> getMenuList(String parentmenuId){

        List<Menu> list = new ArrayList<Menu>();
        List<Menu> result = new ArrayList<Menu>();
        for (Menu menu : menuList) {
            if(menu.getParentmenuid().equals(parentmenuId)){
                list.add(menu);
            }
        }

        for (Menu m : list) {
            result.add(new Menu(m.getSysmenuid(),m.getSysmenuname(),m.getSysmenuurl(),m.getParentmenuid(),m.getSort(),getMenuList(m.getSysmenuid())));
        }
        return result;
    }

    public void writeMenu(Menu menu){
        if(menu.getChildMenu().size()==0){
            String url = menu.getSysmenuurl() + "?moduleType=" + menu.getSysmenuid();
            menuStr += "<a href=\"#\" class=\"easyui-linkbutton\" style=\"width: 100%;margin-top: 5px;font-family: '微软雅黑';color: #0E2D5F;border: #E0ECFF 1px solid;\" onclick=\"addTab('"+menu.getSysmenuname()+"','"+url+"')\">"+menu.getSysmenuname()+"</a><br>";
        }else {
            menuStr += "<div class=\"easyui-accordion\" style=\"width:100%;height:auto;margin-top: 5px;\">\n" +
                    "<div title='"+menu.getSysmenuname()+"' data-options=\"iconCls:'icon-ok'\" style=\"overflow:auto;padding:10px;\">";
            for (Menu m :menu.getChildMenu()) {
                writeMenu(m);
            }
            if(menu.getSysmenuname().equals("系统功能")){
                menuStr += "</div><div title=\"\" selected></div></div>";
            }else {
                menuStr += "</div></div>";
            }
        }
    }

    public boolean useSet(String[] arr, String targetValue) {
        Set<String> set = new HashSet<String>(Arrays.asList(arr));
        return set.contains(targetValue);
    }

%>
<%
    if(session.getAttribute("loginName")!=null){
        String username = session.getAttribute("loginName").toString();
        if(username.equals("")){
%>
    <script>
        window.location = "login.form";
    </script>
<%
            return;
        }
    }else {
%>
    <script>
        window.location = "login.form";
    </script>
<%
        return;
    }

    List<Map<String,Object>> listData = (List<Map<String, Object>>) request.getAttribute("data");
    List<Map<String,Object>> list = new ArrayList<Map<String, Object>>();
    List<String> rolemenuIdList = (List<String>) session.getAttribute("rolemenuId");
    String[] rolemenuId = new String[rolemenuIdList.size()];
    for (int i=0;i<rolemenuIdList.size();i++){
        rolemenuId[i] = rolemenuIdList.get(i);
    }
    if(session.getAttribute("loginId").equals("1f97b97e-a665-4d46-9ea6-59b1cbfa3873")){
        list = listData;
    }else {
        for (Map<String,Object> map:listData) {
            if(useSet(rolemenuId,map.get("sysmenuid").toString())){
                list.add(map);
            }
        }
    }
    menuList.clear();
    for (Map<String,Object> map:list) {
        Menu menu = new Menu(map.get("sysmenuid").toString(),map.get("sysmenuname").toString(),map.get("sysmenuurl").toString(),map.get("parentmenuid").toString(),Integer.parseInt(map.get("sort").toString()));
        menuList.add(menu);
    }
    List<Menu> menuTree = getMenuList("2c659331-0d1a-11e6-b867-0025b6dd0800");
    menuStr = "";
    for (Menu m : menuTree) {
        writeMenu(m);
    }
%>

<body class="easyui-layout">

    <div data-options="region:'north',border:false" style="height:40px;background:#b3d9ff;
        padding-left: 30px;line-height: 40px;">
        <img src="<%=request.getContextPath()%>/asset/image/manage/neunavylogo.png" height="30px"
            style="vertical-align: top;margin-top: 4px; float: left;">
        <span class="word" style="font-size: 25px;font-family: '华文楷体';margin-left: -15px;
            display: block;margin-top: 7px;">
            沈阳东深科技有限公司
        </span>
        <div style="position: absolute;right: 30px;top: 0px;font-family: '微软雅黑';
            font-size: 12px;" class="no_select">
            欢迎您：<span style="font-size: 14px;color: #375580;"><%=session.getAttribute("loginName")%></span>
            <input type="button" value="安全退出" style="background: transparent;color: #8B00B8; font-family: '微软雅黑';font-size: 12px;border: 0px;" class="exit" onclick="Exit()">
        </div>
    </div>
    <div data-options="region:'west',split:true,title:'导航菜单'" style="width:250px;padding:10px;overflow-x: hidden;">
        <%=menuStr%>
        <div class="easyui-accordion" style="width:100%;height:auto;margin-top: 5px;">
            <div title='帮助' data-options="iconCls:'icon-ok'" style="overflow:auto;padding:10px;">
                <a href="#" class="easyui-linkbutton" style="width: 100%;margin-top: 5px;font-family: '微软雅黑';color: #0E2D5F;border: #E0ECFF 1px solid;" onclick="EditPassword()">修改密码</a><br>
                <a href="#" class="easyui-linkbutton" style="width: 100%;margin-top: 5px;font-family: '微软雅黑';color: #0E2D5F;border: #E0ECFF 1px solid;" onclick="addTab('关于','sysaboutnavy.form?moduleType=g')">关于</a><br>
            </div>
            <div title="" selected></div>
        </div>
    </div>
    <div data-options="region:'south',border:false" class="word no_select"
         style="height:30px;background:#b3d9ff;text-align: center;">
        Copyright &copy; 2016.沈阳东深科技有限公司 All rights reserved<a href="/views/font/index.form" target="_blank">.</a>
    </div>
    <div data-options="region:'center',title:''">
        <div id="tt" class="easyui-tabs" style="height:100%;">
            <div title="首页" style="padding:20px;display:none;">
                <div class="index_box">
                    <%--<img src="<%=request.getContextPath()%>/asset/image/manage/logo.png" width="160px" height="160px" />--%>
                    <%--<div class="index_box_title"></div>--%>
                </div>
            </div>
        </div>
    </div>
    <div id="dd" title="密码修改" style="width:400px;height:220px;display: none;"
         data-options="iconCls: 'icon-save',buttons: '#dlg-buttons'">
        <form id="f">
            <div style="text-align: center;margin-top: 10px;">
                <span class="word">当前密码:</span>
                <input class="easyui-textbox" style="height:32px;width:250px;"
                       name="oldpassword" id="oldpassword" type="password"
                       data-options="required:true,validType:'length[1,50]'">
            </div>
            <div style="text-align: center;margin-top: 10px;">
                <span class="word">新设密码:</span>
                <input class="easyui-textbox" style="height:32px;width:250px;"
                       name="newpassword" id="newpassword" type="password"
                       data-options="required:true,validType:'length[1,50]'">
            </div>
            <div style="text-align: center;margin-top: 10px;">
                <span class="word">确认密码:</span>
                <input class="easyui-textbox" style="height:32px;width:250px;"
                       name="querypassword" id="querypassword" type="password"
                       data-options="required:true,validType:'length[1,50]'">
            </div>
        </form>
    </div>
    <%--对话框保存、取消按钮--%>
    <div id="dlg-buttons">
        <a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls: 'icon-ok'" onclick="OkPassword()">确定</a>
        <a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls: 'icon-cancel'" onclick="javascript:$('#dd').dialog('close')">取消</a>
    </div>
</body>
</html>