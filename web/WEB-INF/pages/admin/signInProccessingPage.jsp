<%--
  Created by IntelliJ IDEA.
  User: admin
  Date: 2016/9/9
  Time: 10:30
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java"  pageEncoding="UTF-8" %>
<html>
<head>
    <title>活动签到</title>
    <link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/asset/easyui/themes/default/easyui.css">
    <link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/asset/easyui/themes/icon.css">
    <script type="text/javascript" src="<%=request.getContextPath()%>/asset/js/jquery-1.8.3.min.js"></script>
    <script type="text/javascript" src="<%=request.getContextPath()%>/asset/easyui/jquery.easyui.min.js"></script>
    <script type="text/javascript" src="<%=request.getContextPath()%>/asset/easyui/locale/easyui-lang-zh_CN.js"></script>
    <script type="text/javascript" src="<%=request.getContextPath()%>/asset/js/manage/massage-helper.js"></script>
    <link rel="stylesheet" href="<%=request.getContextPath()%>/asset/css/common.css" />
    <%--引入公共JS--%>
    <script type="text/javascript" src="<%=request.getContextPath()%>/asset/js/common.js"></script>
    <%--引入图片上传--%>
    <script type="text/javascript" src="<%=request.getContextPath()%>/asset/js/ajaxfileupload.js"></script>
    <style>
        .fitem label{
            width: 100px;
        }
    </style>
    <script type="text/javascript">
        var activityId;
        $(function(){
            //保持光标在输入框
            var flag=setInterval(function(){
                $("#applyid").focus();
            },2000);
            //自动提交
            $("#applyid").keyup(function(e){
                if(e.keyCode==13){
                    var applyid=$("#applyid").val();
                    signIn(applyid,activityId);
                    $("#applyid").val("");
                    $("#applyid").focus();
                }
            });
        });

        function signIn(applyid,activityid){
            if(!applyid || !activityid) return ;
            $.ajax({
                url:"/signin/byid.form",
                type:"post",
                data:{applyId:applyid,activityId:activityid},
                dataType:"json",
                success:function(data){
                    if(data.status==1){
                        $("#wrong_msg").append(applyid+"##提交失败<br>");
                    }
                },
                error:function(){
                    $("#wrong_msg").append(applyid+"##提交失败<br>");
                    ShowMsg("服务器连接失败，请稍后再试");
                }
            });
        }

        /**
         * 选择活动
         */
        function submit_btn(){
            var row=$("#choose_activity").datagrid("getSelected");
            if(!row) ShowMsg("请选择一行数据!");
            activityId=row.activityId;
            $("#activity_title").text(row.activityTitle);
            $("#choose_activity_dlg").dialog("close");
        }

        /**
         * 重新选择活动
         */
        function reChoose(){
            $("#choose_activity_dlg").dialog("open");
        }

        /**
         * 批量导入对话框
         */
        function signInByFile(){
            $("#batch_dlg").dialog("open");
        }
        //弹出加载层
        function load() {
            $("<div class=\"datagrid-mask\" style='z-index: 9999999999999999999;'></div>").css({ display: "block", width: "100%", height: $(window).height() }).appendTo("body");
            $("<div class=\"datagrid-mask-msg\" style='z-index: 9999999999999999999;'></div>").html("正在加载，请稍候...").appendTo("body").css({ display: "block", left: ($(document.body).outerWidth(true) - 190) / 2, top: ($(window).height() - 45) / 2 });
        }

        //取消加载层
        function disLoad() {
            $(".datagrid-mask").remove();
            $(".datagrid-mask-msg").remove();
        }
        /**
         * 上传文件
         */
        function uploadFile(){
            if(!$("#upfile").val()){
                ShowMsg("请选择文件！");
                return;
            }
            load();
            $.ajaxFileUpload({
                url: "/signin/byfile.form?activityId="+activityId, //用于文件上传的服务器端请求地址
                secureuri: false, //一般设置为false
                fileElementId: "upfile", //文件上传空间的id属性
                dataType: 'String', //返回值类型 一般设置为String
                success: function (data)  //服务器成功响应处理函数
                {
//                    console.log(data);
                    showResult(data);
                    disLoad();
                },
                error: function ()//服务器响应失败处理函数
                {
                    ShowMsg("上传文件失败，请重新上传");
                    disLoad();
                }
            });
        }
        /**
         * 上传文件后显示服务器返回的信息
         * @param data
         */
        function showResult(data){
            $("#valid_result").html("");
            //去除返回字符串的  <pre style="word-wrap: break-word; white-space: pre-wrap;"> 标签
            var str=data.substring(data.indexOf('>')+1,data.lastIndexOf('<'));
            var s= eval("("+str+")");
            var str=s.msg+"<br>";
            if(s.data){
                $.each(s.data,function(){
                    if(this.data){
                        str+="&nbsp;&nbsp;"+this.msg+"<br>";
                        $.each(this.data,function(){
                            str+="&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;"+this+"<br>";
                        })
                    }else{
                        str+="&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;"+this+"<br>";
                    }

                });
            }
            $("#valid_result").html(str);
        }
        /**
         * 现场签到按键
         */
        function signInNow(){
            $("#sign_now").dialog("open");
        }
    </script>
</head>
<body>
<div>
    <div style="height: 30px">
        <h3 id="activity_title"></h3>
    </div>

    <a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-remove',plain:false" onclick="reChoose()">重新选择活动</a>
    <a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-remove',plain:false" onclick="signInNow()">活动现场签到</a>
    <a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-remove',plain:false" onclick="signInByFile()">批量上传签到</a>
</div>
<%-- 选择活动对话框 --%>
<div id="choose_activity_dlg" class="easyui-dialog" title="请选择活动..."
     data-options="iconCls: 'icon-save',buttons: '#choose_activity_buttons',modal:true,top:'10%'">
    <table id="choose_activity" class="easyui-datagrid" style="width:500px;height:300px"
           data-options="pagination:true,
               rownumbers:true,
               singleSelect:true,
               method:'post',
               autoRowHeight:false,
               fitColumns:false,
              url:'/jsons/loadSignInActivities.form'">
        <thead>
        <tr>
            <th field="activityId" hidden >活动ID</th>
            <th field="activityTitle" >活动标题</th>
            <th field="activityLocation" >活动地点</th>
            <th field="activityParticipation" >参与形式</th>
            <th field="activitySdate" >活动起始时间</th>
            <th field="activityEdate" >活动截止时间</th>
        </tr>
        </thead>
    </table>
</div>
<%--弹出页面的对话框提交、取消按钮--%>
<div id="choose_activity_buttons">
    <a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls: 'icon-ok'" onclick="submit_btn()">确定</a>
    <a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls: 'icon-cancel'" onclick="javascript:$('#choose_activity_dlg').dialog('close')">取消</a>
</div>
<%--批量导入对话框--%>
<div id="batch_dlg" class="easyui-dialog hide" title="批量导入签到信息" style="width:600px;height:420px;padding:10px;"
     data-options="iconCls: 'icon-save',buttons: '#batch_dlg_buttons',modal:true,top:'10%'" closed="true" >
    <div id="file_box" class="fitem">
        <label>选择文件:</label>
        <input id="upfile" class=" input_ele" name="fileup" type="file"/>
    </div>
    <div id="_box" class="fitem">
        <label></label>
    </div>
    <div id="btn_box" class="fitem">
        <label></label>
        <a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls: 'icon-save'" onclick="uploadFile()">上传并导入</a>
    </div>
    <div id="result_box" class="fitem">
        <label>操作结果:</label>
        <br>
        <label></label>
        <div id="valid_result" class=" input_ele" style="width: 390px;height: 200px;border: 1px solid #95B8E7;overflow: auto"></div>
    </div>
</div>
<div id="batch_dlg_buttons">
    <a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls: 'icon-cancel'" onclick="javascript:$('#batch_dlg').dialog('close')">关闭</a>
</div>
<%--现场签到对话框--%>
<div id="sign_now" class="easyui-dialog hide" title="现场签到" style="width:600px;height:380px;padding:10px;"
     data-options="iconCls: 'icon-save',modal:true,top:'10%'" closed="true" >
    <div  class="fitem">
        <br>
        <label>二维码内容：</label>
        <input id="applyid" class=" input_ele"  style="width: 390px;border: 1px solid #95B8E7;border-radius:4px"  type="text"/>
    </div>
    <div  class="fitem">
        <label>错误信息:</label>
        <br>
        <label></label>
        <div id="wrong_msg" class=" input_ele" style="width: 390px;height: 200px;border: 1px solid #95B8E7;border-radius:4px;overflow: auto"></div>
    </div>
</div>
</body>
</html>
