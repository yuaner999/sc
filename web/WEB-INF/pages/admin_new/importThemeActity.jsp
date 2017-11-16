<%--
  Created by IntelliJ IDEA.
  User: NEUNB
  Date: 2017/10/26
  Time: 20:11
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java"  pageEncoding="UTF-8" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01//EN"
"http://www.w3.org/TR/html4/strict.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" lang="en">
<head>
    <title>导入团日活动</title>
    <script type="text/javascript" src="<%=request.getContextPath()%>/asset_admin_new/js/jquery-1.11.1.min.js"></script>
    <script type="text/javascript" src="<%=request.getContextPath()%>/asset/layer/layer.js"></script>
    <link rel="stylesheet" href="<%=request.getContextPath()%>/asset_admin_new/css/StuMsgManage.css" />
    <script type="text/javascript" src="<%=request.getContextPath()%>/asset/js/ajaxfileupload.js"></script>
</head>
<body>
<div style="width: 100%;">
    <button onclick="getModel()">下载模版</button><button onclick="uploadFile()">导入数据</button><button onclick="validFile()">校验数据</button>
    <br>

    <div id="file_box" style="margin-bottom: 10px;margin-top: 10px;">
        <input id="upfile" style="display: inline-block;width: 200px;" name="fileup" type="file"/>
    </div>
</div>

<div id="result_box" style="margin-bottom: 10px;margin-top: 10px;">
    <label>操作结果:</label>
    <br>
    <label></label>
    <div id="valid_result"  style="display: inline-block;width: 400px;height: 250px;border: 2px solid #95B8E7;overflow: auto"></div>
</div>
</body>

<script>
    //弹出加载层
    function load() {
        layer.load(1, {
            shade: [0.1,'#fff']//0.1透明度的白色背景
        });
    }

    //取消加载层
    function disLoad() {
        layer.closeAll('loading');
    }

    //下载文件
    function getModel(){
        window.open("/Files/ExcelModels/themeActModel.xls");
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

    //校验数据
    function validFile(){
        if(!$("#upfile").val()){
            layer.msg("请选择文件！");
            return;
        }
        load();
        $.ajaxFileUpload({
            url: "/dataupload/validThemeActityData.form", //用于文件上传的服务器端请求地址
            secureuri: false, //一般设置为false
            fileElementId: "upfile", //文件上传空间的id属性
            dataType: 'String', //返回值类型 一般设置为String
            success: function (data, status)  //服务器成功响应处理函数
            {
                console.log(data);
                showResult(data);
                disLoad();
            },
            error: function (data, status, e)//服务器响应失败处理函数
            {
                console.log('失败');
                layer.msg("上传文件失败，请重新上传");
                disLoad();
            }
        });
    }

    /**
     * 上传文件
     */
    function uploadFile(){
        if(!$("#upfile").val()){
            layer.msg("请选择文件！");
            return;
        }
        load();
        $.ajaxFileUpload({
            url: "/dataupload/importThemeActityData.form", //用于文件上传的服务器端请求地址
            secureuri: false, //一般设置为false
            fileElementId: "upfile", //文件上传空间的id属性
            dataType: 'String', //返回值类型 一般设置为String
            success: function (data)  //服务器成功响应处理函数
            {
                //console.log(data);
                showResult(data);
                disLoad();
            },
            error: function (data, status, e)//服务器响应失败处理函数
            {
                layer.msg("上传文件失败，请重新上传");
                disLoad();
            }
        });
    }

</script>

</html>
