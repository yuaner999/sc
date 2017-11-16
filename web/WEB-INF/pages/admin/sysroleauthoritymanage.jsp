<%--
  Created by IntelliJ IDEA.
  User: liulei
  Date: 2016/4/28
  Time: 20:41
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java"  pageEncoding="UTF-8" %>
<html>
<head>
    <title>角色权限配置</title>
    <link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/asset/easyui/themes/default/easyui.css">
    <link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/asset/easyui/themes/icon.css">
    <script type="text/javascript" src="<%=request.getContextPath()%>/asset/easyui/jquery.min.js"></script>
    <script type="text/javascript" src="<%=request.getContextPath()%>/asset/easyui/jquery.easyui.min.js"></script>
    <script type="text/javascript" src="<%=request.getContextPath()%>/asset/easyui/locale/easyui-lang-zh_CN.js"></script>
    <script type="text/javascript" src="<%=request.getContextPath()%>/asset/js/manage/massage-helper.js"></script>
    <script>
        var menuIdList = [];//系统菜单
        var parentMenuIdList = [];//系统菜单父节点
        var sysroleId = "";
        $(function(){
            //菜单树选中状态变化时
            $('#tt').tree({
                onCheck: function(node,checked){
                    var row = $('#dg').datagrid('getSelected');
                    if(row){
                        sysroleId = row.sysroleid;
                        var nodes = $('#tt').tree('getChecked');
                        menuIdList = [];
                        parentMenuIdList = [];
                        for(var i=0;i<nodes.length;i++){
                            menuIdList.push(nodes[i].id);
                            getParentNode(nodes[i]);
                        }
                        menuIdList = menuIdList.concat(parentMenuIdList);
                        menuIdList = unique(menuIdList);
                    }else {
                        ShowMsg("请选择一个角色");
                        $("#tt").tree('uncheck',node.target);
                        return;
                    }
                }
            });
            //角色表格选中状态变化时
            $('#dg').datagrid({
                onClickRow: function(rowIndex, rowData){
                    var nodes = $("#tt").tree("getChecked");
                    for(var i=0;i<nodes.length;i++){
                        $("#tt").tree('uncheck',nodes[i].target);
                    }
                    $.post("/jsons/getRoleMenu.form",{
                        sysroleId:rowData.sysroleid
                    },function(data){
                        if(data.result){
                            var node;
                            for(var i=0;i<data.resultSet.length;i++){
                                node = $('#tt').tree('find',data.resultSet[i].sysmenuid);
                                if(node.children.length==0){
                                    $('#tt').tree('check', node.target);
                                }
                            }
                        }else {
                            ShowMsg("获取角色权限菜单失败："+data.errormessage);
                        }
                    });
                }
            });
        });

        //获取父节点信息
        function getParentNode(node){
            if(node.parentId!=""){
                parentMenuIdList.push(node.parentId);
                getParentNode($("#tt").tree('getParent',node.target));
            }
        }

        //去除重复的数组信息
        function unique(arr) {
            var result = [], hash = {};
            for (var i = 0, elem; (elem = arr[i]) != null; i++) {
                if (!hash[elem]) {
                    result.push(elem);
                    hash[elem] = true;
                }
            }
            return result;
        }

        //保存
        function Save(){
            if(sysroleId==""){
                ShowMsg("请选择一个角色");
                return;
            }
            if(menuIdList.length==0){
                menuIdList.push("none");
            }
            load();
            $.post("/SysMenu/saveRoleMenu.form",{
                sysroleId:sysroleId,
                menuIdList:menuIdList
            },function(data){
                $("#BackBoard,#LoadWord").remove();
                if(data=="1"){
                    ShowMsg("保存成功");
                }else if(data=="-1"){
                    ShowMsg("保存失败");
                }else {
                    ShowMsg(data);
                }
            });
        }
        //弹出加载层
        function load() {
            $("<div class=\"datagrid-mask\" id='BackBoard'></div>").css({ display: "block", width: "100%", height: $(window).height() }).appendTo("body");
            $("<div class=\"datagrid-mask-msg\" id='LoadWord'></div>").html("正在加载，请稍候...").appendTo("body").css({ display: "block", left: ($(document.body).outerWidth(true) - 190) / 2, top: ($(window).height() - 45) / 2 });
        }
    </script>
    <%--判断是否是登录状态--%>
    <%@include file="../common/CheckLogin.jsp"%>
</head>
<body>
    <div class="easyui-layout" style="width:100%;height:100%;">
        <div data-options="region:'west'" title="角色" style="width:300px;">
            <%--数据表格--%>
            <table id="dg" class="easyui-datagrid" style="width:100%;height:100%;"
                   data-options="singleSelect:true,url:'/jsons/getRoleName.form',
                        method:'post',rownumbers:true,fitColumns:true">
                <thead>
                    <tr>
                        <th field='sysroleid' hidden style="width: 100%;">角色ID</th>
                        <th field='sysrolename' width="100px">角色名称</th>
                    </tr>
                </thead>
            </table>
        </div>
        <div data-options="region:'center',title:'菜单'">
            <ul id="tt" class="easyui-tree" style="margin: 10px;"
                data-options="url:'/SysMenu/getParentMenu.form',method:'post',
                    animate:true,checkbox:true,lines:true"></ul>
            <div id="dlg-buttons" style="padding: 5px;padding-left:20px;border-top: #95B8E7 1px solid;border-bottom: #95B8E7 1px solid;">
                <a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls: 'icon-ok'" onclick="Save()">保存</a>
            </div>
        </div>
    </div>
</body>
</html>