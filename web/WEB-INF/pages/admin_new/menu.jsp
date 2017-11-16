<%@ page contentType="text/html;charset=UTF-8" language="java"  pageEncoding="UTF-8" %>
<%@ page import="com.model.Menu"%>
<%@ page import="java.util.*" %>
<%--
  Created by IntelliJ IDEA.
  User: dskj012
  Date: 2016/10/21
  Time: 9:18
  To change this template use File | Settings | File Templates.
--%>
<head>
    <link rel="Shortcut Icon" href="<%=request.getContextPath()%>/asset/image/neu.jpg" type="image/x-icon">
    <script type="text/javascript" src="<%=request.getContextPath()%>/asset_admin_new/js/jquery-1.11.1.min.js"></script>
    <script type="text/javascript" src="<%=request.getContextPath()%>/asset/js/jquery.md5.js" ></script>
    <!-- 导入layer -->
    <script type="text/javascript" src="<%=request.getContextPath()%>/asset/layer/layer.js"></script>
    <link rel="stylesheet" href="<%=request.getContextPath()%>/asset_admin_new/css/menu.css" />
    <link rel="stylesheet" href="<%=request.getContextPath()%>/asset_admin_new/css/StuMsgManage.css" />
    <link rel="stylesheet" href="<%=request.getContextPath()%>/asset/css/font/login_reg.css" />
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
    <%--<!--兼容360浏览器，防止布局乱，设置IE的文档模式为最高版本，并且如果存在chrome插件，自动使用Webkit引擎-->--%>
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <title>第二课堂教师管理界面</title>
    <script type="text/javascript">
        $(function(){
            $('.right .stuMsgManage').css('max-height', '780px');
            $('.menuBody').css('max-height', '780px');
            $(".change_pwd").click(function(){
            });
            $.ajax({
               url:"/sysstatistics/getstatistics.form",
                type:"post",
                dataType:"json",
                success:function(data){
                    if(data){
                        $("#stat_used").text(data.used);
                        $("#stat_applyed").text(data.applyed);
                        $("#stat_gennered").text(data.gennered);
                    }
                }
            });
        });
    </script>
    <style type="text/css">
        html{
            width:100%!important;
        }
        .stuMsgManage iframe{
            display: none;
        }
        .stuMsgManage iframe html{
            width:100%;
        }
        .frame_selected{
            display: block !important;
        }
        .tabs li{
            background: #ffffff ;
            color:#197FFE ;
        }
        .tab_selected{
            background: #197FFE !important;
            color:#ffffff !important;
        }
        .menuBody{
            max-height: 821px;
        }
        .change_pwd{
            float: right !important;
            margin-right: 20px;
            cursor: pointer;
        }
        .findpwd_box{
            height: 12rem !important;
        }
        .wrap{
            margin-bottom: 10px !important;
        }
        .statistic_info{
            width: 500px;
            /* margin: 0 auto; */
            color: #1990FE;
            float: right;
        }
        .statistic_ele{
            display: inline-block;
            margin:0 15px;
        }
    </style>
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
            menuStr +="<li><a href=\"#\" onclick=\"addTab('"+menu.getSysmenuname()+"','"+url+"')\">"+menu.getSysmenuname()+"</a></li>";
        }else {
            menuStr += "<li class=\"oneli\"><div class=\"onetitlewrap\"><div class=\"onetitle\">"+menu.getSysmenuname()+
                    "</div><img src=\"/asset_admin_new/img/btndown.png\" class=\"btndown\" /><div class=\"devide\"><div class=\"devideleft\"></div><div class=\"devideright\"></div></div></div><ul class=\"twoul\">";
            for (Menu m :menu.getChildMenu()) {
                writeMenu(m);
            }
            menuStr += "</ul></li>";
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
    window.location = "/views/font/login.form";
</script>
<%
        return;
    }
}else {
%>
<script>
    window.location = "/views/font/login.form";
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
    List<Menu> menuTree = getMenuList("5db0147a-0a0e-11e6-8cac-0025b6dd0800");//生成menuTree 菜单列表下的
    menuStr = "";
    for (Menu m : menuTree) {
        writeMenu(m);
    }
%>

<body>
<div class="banner">
    <img src="<%=request.getContextPath()%>/asset_admin_new/img/neulogo.png" alt="" class="newlogo" />
    <span>共青团"第二课堂成绩单"信息认证平台&nbspNEU&nbspY&nbspPionee-R<a href="/views/font/index.form" target="_blank">.</a></span>
    <div class="btnexit" onclick="Exit()">退出</div>
    <span class="change_pwd">修改密码</span>
    <span class="loginmess"><%=session.getAttribute("loginName")%></span>
    <img src="<%=request.getContextPath()%>/asset_admin_new/img/loginimg.png" alt="" class="loginimg" />
</div>
<div class="wrap">
    <div class="mainmenu">
        <div class="menutitle">
            <span>菜单列表</span>
            <div class="btnadd">+</div>
        </div>
        <div class="menuBody">
            <ul class="oneul">
                <%=menuStr%>
            </ul>
        </div>
    </div>
    <div class="right">
        <!--选项卡-->
        <div class="tabs">
            <ul>
            </ul>
        </div>
        <div id="bbg" class="stuMsgManage" style="min-width: 1150px !important;">

        </div>
    </div>
</div>
<div class="statistic_">
    <div class="statistic_info">
        <span class="statistic_ele" title="登陆过本系统的学生人数">使用人数:<span id="stat_used"></span></span>
        <span class="statistic_ele" title="活动申请及活动补充人数">参与活动人数:<span id="stat_applyed"></span></span>
        <span class="statistic_ele" title="生成成绩单人数">生成成绩单人数:<span id="stat_gennered"></span></span>
    </div>
</div>
<div class="login_window"  style="display: none">
    <div class="findpwd_box" >
        <div class="ele">
            <span class="ele_text">原密码：</span><input type="password" id="old_pwd" class="input_ele resetpwd_input">
        </div>
        <div class="ele ele2">
            <span class="ele_text">新密码：</span><input type="password" id="newpwd" class="input_ele resetpwd_input">
        </div>
        <div class="ele ele2">
            <span class="ele_text">重复密码：</span><input type="password" id="renewpwd" class="input_ele resetpwd_input">
        </div>
        <div class="ele"></div>
        <div class="ele ele3">
            <input type="button" class="btn ok_btn" onclick="resetpwd();" value="确定">
            <input type="button" class="btn cancel_btn"  value="取消">
        </div>
    </div>
</div>
<script type="text/javascript">

    //左侧高度
    $(function () {
        var mh=document.body.clientHeight||window.innerHeight;
        $('.menuBody').css('max-height', mh-170+"px");
        $('.stuMsgManage').css('max-height', mh-175+"px");
    })
    window.onresize=function(){
        var mh=document.body.clientHeight||window.innerHeight;
        $('.menuBody').css('max-height', mh-170+"px");
        $('.stuMsgManage').css('max-height', mh-175+"px");
    }
    //        $(window).ready(function(){
    //            //	设置页面左侧菜单主体的最大高度
    //              window.screen.availHeight
    //            $('.menuBody').css('max-height', (getClientHeight()-157) + 'px');
    //        })
    //记录选项卡的总长度
    var tabLength = 0;
    $(function(){
        //选项卡上的关闭按钮  先判断是否是选中的状态，若是选中的先去掉选中的class，然后获取当前标签的class，
        // 上一个，或者下一个标签产生单击事件，然后移除此标签以及对应的ifram
        $(".tabs").on("click","span",function(even){
            even.stopPropagation();
            var tabclass;
            if($(this).parent().hasClass("tab_selected")){
                $(this).parent().removeClass("tab_selected");
            }
            tabclass= $.trim($(this).parent().attr("class"));
            // 上一个，或者下一个标签产生单击事件
            if($(this).parent().next().length){
                $(this).parent().next().click();
            }else if($(this).parent().prev().length){
                $(this).parent().prev().click();
            }
            //移除此标签以及对应的ifram
            $(this).parent().remove();
            $("."+tabclass).remove();
        });
        //选项卡标签点击事件
        $(".tabs").on("click","li",function(){
            $(".tab_selected").removeClass("tab_selected");
            $(".frame_selected").removeClass("frame_selected");
            var tabclass= $.trim($(this).attr("class"));
            $(this).addClass("tab_selected");
            $(".stuMsgManage  ."+tabclass).addClass("frame_selected");
        });
        //菜单列表合并按钮动作  btndown
        $(".oneul").on("click",".onetitlewrap",function(){
            if($(this).parent().find(".twoul:hidden").length){
                $(this).parent().find(".twoul:hidden").slideDown();
            }else{
                $(this).parent().find(".twoul:visible").slideUp();
            }
        });
        //取消按钮
        $(".cancel_btn").click(function(){
            $(".login_window").fadeOut(300);
        });
        //修改密码按钮
        $(".change_pwd").click(function(){
            $(".login_window").fadeIn(300);
            $(".input_ele").val("");
        });
    });
    var tab_index=0;
    function addTab(title, url){
        //	判断选项卡中是否已经存在此选项
        var tabTexts = $('.tabs>ul>li');
        var tag = true;
        var tab;
        //记录当前选项卡的总长度
        var currentTabLen = 0;
        for(var i = 0; i < tabTexts.length; i++)
        {
            currentTabLen = currentTabLen + tabTexts.eq(i).width() + 36;
        }
        //  循环遍历已经存在的选项卡的内容,与点击的文本相比较,如果存在就就不添加,如果不存在就添加
        for(var i = 0; i < tabTexts.length; i++){
            if(title == tabTexts.eq(i).text()){
                tab=tabTexts.eq(i);
                tag = false;
                break;
            }
        }
        tabLength = currentTabLen + 150;
        $(".tab_selected").removeClass("tab_selected");
        $(".frame_selected").removeClass("frame_selected");
        if(tag){
            if ($('.tabs').width() >= tabLength)
            {
                tab='<li  class="tab'+tab_index+' tab_selected">'+title+'<span></span></li>';
                $('.tabs>ul').append(tab);
                //                $(".tabs li:last").attr("tabindex",tab_index);
                var content = '<iframe class="tab'+tab_index+' frame_selected"  scrolling="auto" frameborder="0"  src="'+url+'" style="width:100%;height:100%;"></iframe>';
                $(".stuMsgManage").append(content);
                tab_index++;
            }else {
                layer.alert("选项卡已满，请先关闭一些选项卡！");
                var index=$.trim($('.tabs>ul>li:last').attr("class"));
                $('.tabs>ul>li:last').addClass("tab_selected");
                $(".stuMsgManage ." +index).addClass("frame_selected");
            }
        }else{
            var index=$.trim(tab.attr("class"));
            tab.addClass("tab_selected");
            $(".stuMsgManage ." +index).addClass("frame_selected");
        }
    }

    /**
     * 修改密码
     */
    function resetpwd(){
        var oldpwd= $.trim($("#old_pwd").val());
        var pwd= $.trim($("#newpwd").val());
        var repwd= $.trim($("#renewpwd").val());
        if(!(oldpwd && pwd && repwd)){
            layer.msg("请检查输入是否完整！");
            return;
        }
        if(pwd!=repwd){
            layer.msg("两次密码输入不一致");
            return;
        }
        var index = layer.load(1, {shade: [0.1,'#000']});
        $.ajax({
            url:"/Login/EditPassword.form",
            data:{oldpassword: $.md5(oldpwd),newpassword: $.md5(pwd)},
            type:"post",
            success:function(data){
                layer.close(index);
                if(data=="-1"){
                    layer.msg("原密码或新密码有误，请稍后重试");
                    return;
                }
                //这里是学生登入 所以返回的type改为5
                if(data=="1"){
                    layer.msg("修改成功！请重新登陆");
                    $(".login_window").fadeOut(300);
                    setTimeout(function(){
                        window.location='/views/font/login.form';
                    },2000);
                    return;
                }
                layer.msg(data);
            },
            error:function(){
                layer.close(index);
                layer.msg("服务器连接失败，请稍后再试");
            }
        });
    }

    //安全退出
    function Exit(){
        layer.confirm( '确认退出当前帐号吗?', function(result){
            if (result){
                $.post("/Login/ExitLogin.form",{},function(data){
//                    console.log(data);
                    goToLogin(data);
                });
            }
        });
    }
    function goToLogin(type){
//        console.log(type);
        window.location = "/views/font/login.form?type="+type;
    }
</script>

</body>
</html>


