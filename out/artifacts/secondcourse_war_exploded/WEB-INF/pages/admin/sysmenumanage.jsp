<%--
  Created by IntelliJ IDEA.
  User: liulei
  Date: 2016/4/23
  Time: 15:37
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>系统菜单管理</title>
    <link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/asset/easyui/themes/default/easyui.css">
    <link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/asset/easyui/themes/icon.css">
    <script type="text/javascript" src="<%=request.getContextPath()%>/asset/easyui/jquery.min.js"></script>
    <script type="text/javascript" src="<%=request.getContextPath()%>/asset/easyui/jquery.easyui.min.js"></script>
    <script type="text/javascript" src="<%=request.getContextPath()%>/asset/easyui/locale/easyui-lang-zh_CN.js"></script>
    <script type="text/javascript" src="<%=request.getContextPath()%>/asset/js/manage/massage-helper.js"></script>
    <script>
        var postURL = "";//发送Post的请求地址
        var childrenId = [];

        $(function(){
            //添加按钮
            $('#tt').datagrid({
                toolbar: [{
                    text: '新建',
                    iconCls: 'icon-add',
                    handler: function () {
                        Add();
                    }
                }, '-', {
                    text: '修改',
                    iconCls: 'icon-edit',
                    handler: function () {
                        Edit();
                    }
                }, '-', {
                    text: '删除',
                    iconCls: 'icon-remove',
                    handler: function () {
                        Delete();
                    }
                }]
            });
        });
        //新建
        function Add(){
            postURL = "/jsons/addMenu.form";
            $("#Form").form("clear");
            $('#sort').numberbox('setValue', 1);
            $("#dlg").dialog({title: "新建"});
            $('#dlg').dialog('open');
        }
        //修改
        function Edit(){
            postURL = "/jsons/editMenu.form";
            var row = $('#tt').datagrid('getSelected');
            if (row){
                childrenId = [];
                getChildrenId(row);//获取当前菜单的所有子菜单的ID
                if(row.sysmenuid=="2c659331-0d1a-11e6-b867-0025b6dd0800"){
                    ShowMsg("菜单根目录不允许修改");
                    return;
                }
                $("#Form").form("clear");
                $('#Form').form('load', row);
                $("#dlg").dialog({title: "修改"});
                $('#dlg').dialog('open');
            }else {
                ShowMsg("请选中一条数据");
            }
        }
        //删除-TODO:删除有Bug待完善，未做删除判断，父子删除，根目录、系统菜单删除等
        function Delete(){
            postURL = "/jsons/deleteMenu.form";
            var row = $('#tt').datagrid('getSelected');
            if (row){
                if(row.issysmanagemenu=="是"){
                    ShowMsg("系统菜单不能删除");
                    return;
                }
                childrenId = [];
                getChildrenId(row);//获取当前菜单的所有子菜单的ID
                var message = "";
                if(childrenId.length>1){
                    message = "此菜单含有子菜单，将删除所有子菜单，确定继续吗？";
                }else {
                    message = "确认删除此条数据吗?";
                }
                $.messager.confirm('提示', message, function(result){
                    if (result){
                        $.post("/SysMenu/deleteMenu.form",{
                            menuIdList:childrenId
                        },function(data){
                            if(data=="1"){
                                ShowMsg("删除成功,刷新页面后生效");
                                //重新加载数据
                                $('#tt').treegrid('reload');
                                $('#parentmenuid').combotree({url: '/SysMenu/getParentMenu.form',required: true});
                            }else {
                                ShowMsg("删除失败，请重新登录或联系管理员");
                            }
                        });
                    }
                });
            }else {
                ShowMsg("请选中一条数据");
            }
        }
        //保存
        function Save(){
            if($("#Form").form('validate')){
                var jsonObject = $("#Form").serializeObject();

                if(isContainStr(childrenId,jsonObject.parentmenuid)){
                    ShowMsg("所选父菜单不能为当前菜单或其子菜单");
                    return;
                }
                $.post(postURL,jsonObject,function(data){
                    if(data.result){
                        $('#dlg').dialog('close');
                        ShowMsg("保存成功,刷新页面后生效");
                        //重新加载数据
                        $('#tt').treegrid('reload');
                        $('#parentmenuid').combotree({url: '/SysMenu/getParentMenu.form',required: true});
                    }else {
                        ShowMsg("保存中出现错误，请联系管理员");
                    }
                });
            }else {
                ShowMsg("请按照要求填写");
            }
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
        //获取所有子菜单的ID
        function getChildrenId(row){
            childrenId.push(row.sysmenuid);
            if(row.children!=null){
                for(var i=0;i<row.children.length;i++){
                    getChildrenId(row.children[i]);
                }
            }
        }
        //判断字符串集合是否包含指定字符串
        function isContainStr(list,str){
            for(var i=0;i<list.length;i++){
                if(list[i]==str){
                    return true;
                }
            }
            return false;
        }
    </script>
    <%--判断是否是登录状态--%>
    <%@include file="../common/CheckLogin.jsp"%>
</head>
<body>
    <%--菜单列表--%>
    <table id="tt" title="" class="easyui-treegrid" style="width:100%;height: 100%;"
           data-options="
                    url: '/SysMenu/getSysMenuList.form',
                    method: 'post',
                    rownumbers: true,
                    idField: 'sysmenuid',
                    treeField: 'sysmenuname'
                ">
        <thead>
            <tr>
                <th field="sysmenuname" width="15%">菜单名称</th>
                <th field="sysmenuid" hidden>ID</th>
                <th field="sysmenuurl" width="10%">菜单路径</th>
                <th field="issysmanagemenu" width="10%">系统菜单</th>
                <th field="sort" width="10%">菜单顺序</th>
                <th field="createdate" width="10%">创建日期</th>
                <th field="createman" width="10%">创建者</th>
                <th field="updatedate" width="10%">更新日期</th>
                <th field="updateman" width="10%">更新者</th>
                <th field="remark" width="10%">备注</th>
                <th field="parentmenuid" hidden>父菜单ID</th>
            </tr>
        </thead>
    </table>
    <%--对话框--%>
    <div id="dlg" class="easyui-dialog hide" title=""
         style="width:400px;height:550px;padding:10px;"
         data-options="iconCls: 'icon-save',buttons: '#dlg-buttons',modal:true" closed="true">
        <form id="Form">
            <div style="margin-bottom:10px;margin-top: 10px;display: none;">
                <div class="word">ID:</div>
                <input class="easyui-textbox" name="sysmenuid" id="sysmenuid">
            </div>
            <div style="margin-bottom:10px;margin-top: 10px;display: none;">
                <div class="word">系统菜单</div>
                <input class="easyui-textbox" name="issysmanagemenu" id="issysmanagemenu">
            </div>
            <div style="margin-bottom:10px;margin-top: 10px;">
                <div class="word">菜单名称:</div>
                <input class="easyui-textbox" data-options="required:true,validType:'length[1,25]'"
                       name="sysmenuname" id="sysmenuname" style="width:100%;height:32px">
            </div>
            <div style="margin-bottom:10px;margin-top: 10px;">
                <div class="word">父菜单:</div>
                <input class="easyui-combotree" style="height:32px;width:100%;"
                       name="parentmenuid" id="parentmenuid"
                       data-options="required:true,url:'/SysMenu/getParentMenu.form',method:'post'">
            </div>
            <div style="margin-bottom:10px;margin-top: 10px;">
                <div class="word">菜单路径:</div>
                <input class="easyui-textbox" data-options="validType:'length[0,250]'"
                       style="height:32px;width:100%;" name="sysmenuurl" id="sysmenuurl">
            </div>
            <div style="margin-bottom:10px;margin-top: 10px;">
                <div class="word">菜单顺序:</div>
                <input class="easyui-numberspinner" value="1" data-options="increment:1" min="0" maxlength="8"
                       style="height:32px;width:100%;" name="sort" id="sort">
            </div>
            <div style="margin-bottom:10px;margin-top: 10px;">
                <div class="word">备注:</div>
                <input class="easyui-textbox" data-options="multiline:true,validType:'length[0,50]'"
                       style="height:100px;width:100%;" name="remark" id="remark">
            </div>
        </form>
    </div>
    <%--对话框保存、取消按钮--%>
    <div id="dlg-buttons">
        <a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls: 'icon-ok'" onclick="Save()">保存</a>
        <a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls: 'icon-cancel'" onclick="javascript:$('#dlg').dialog('close')">取消</a>
    </div>
</body>
</html>