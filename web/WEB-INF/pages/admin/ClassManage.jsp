<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: admin
  Date: 2016/5/9
  Time: 11:37
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java"  pageEncoding="UTF-8" %>
<html>
<head>
    <title></title>
    <%--引入EasyUi--%>
    <link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/asset/easyui/themes/default/easyui.css">
    <link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/asset/easyui/themes/icon.css">
    <script type="text/javascript" src="<%=request.getContextPath()%>/asset/js/jquery-1.8.3.min.js"></script>
    <script type="text/javascript" src="<%=request.getContextPath()%>/asset/easyui/jquery.easyui.min.js"></script>
    <script type="text/javascript" src="<%=request.getContextPath()%>/asset/easyui/locale/easyui-lang-zh_CN.js"></script>
    <script type="text/javascript" src="<%=request.getContextPath()%>/asset/js/manage/massage-helper.js"></script>
    <%--引入kindereditor--%>
    <link rel="stylesheet" href="<%=request.getContextPath()%>/asset/kindeditor-4.1.10/themes/default/default.css" />
    <link rel="stylesheet" href="<%=request.getContextPath()%>/asset/kindeditor-4.1.10/plugins/code/prettify.css" />
    <script charset="utf-8" src="<%=request.getContextPath()%>/asset/kindeditor-4.1.10/kindeditor.js"></script>
    <script charset="utf-8" src="<%=request.getContextPath()%>/asset/kindeditor-4.1.10/lang/zh_CN.js"></script>
    <script charset="utf-8" src="<%=request.getContextPath()%>/asset/kindeditor-4.1.10/plugins/code/prettify.js"></script>

    <%--引入公共JS--%>
    <script type="text/javascript" src="<%=request.getContextPath()%>/asset/js/common.js"></script>
    <script type="text/javascript" src="<%=request.getContextPath()%>/asset/js/manage/managecommon.js"></script>
    <script type="text/javascript" src="<%=request.getContextPath()%>/asset/kindeditor-4.1.10/KindeditorConfig.js"></script>
    <%--引入图片上传--%>
    <script type="text/javascript" src="<%=request.getContextPath()%>/asset/js/ajaxfileupload.js"></script>
    <style type="text/css">
        a{
            color: #34538b;
            text-decoration: none;
        }
    </style>
    <script>
        var moduleType = GetQueryString("moduleType");//所属模块的ID，不可以删除
        //1、第一处修改，修改增删改的请求地址
        var addUrl = "";
        var editUrl = "";
        var deleteUrl = "";
        var editorName = "null";//KindEditor的Textarea的ID，如果没用到，赋值为null
        var imageUpload = "";//图片上传的标识，如果没有图片上传，赋值为空，如果有，赋值为数据库存放图片名称的字段名称，不带_
        var deleteId = "classId";//用于删除功能的ID参数，赋值为当前数据库表的ID
        var stuCollageName;
        var stuMajorName;
        var stuClassName;
        $(function(){
            $("#Board").fadeOut("slow");
            //加载所有学院
            $.ajax({
                url:"/jsons/loadCollegeName.form",
                type:"post",
                dataType:"json",
                success:function(data){
                    if(data!=null && data.rows.length>0){
                        $("#filter_college").combobox({valueField:'stuCollageName',textField:'stuCollageName',panelHeight:'auto'}).combobox("loadData",data.rows).combobox("setText","全部");
                    }
                },
                error:function(XMLHttpRequest,textStatus,errorThrown){
                    alert(XMLHttpRequest.status);
                    alert(XMLHttpRequest.readyState);
                    alert(textStatus);
                }
            });
            //根据学院加载下拉选
            $("#filter_college").combobox({onChange:function(value){
                stuCollageName=value;
                $.ajax({
                    url:"/jsons/loadMajorNameIn.form",
                    type:"post",
                    async:false,
                    data:{stuCollageName:stuCollageName},
                    dataType:"json",
                    timeout: 30000,
                    success:function(data){
                        if(data.rows.length>0){
                            $("#filter_major")
                                    .combobox({valueField:'stuMajorName',textField:'stuMajorName',panelHeight:'auto'})
                                    .combobox("loadData",data.rows).combobox("setText","全部");
                        }

                    },
                    error:function(XMLHttpRequest,textStatus,errorThrown){
                        alert(XMLHttpRequest.status);
                        alert(XMLHttpRequest.readyState);
                        alert(textStatus);
                    },
                    complete:function(XHR, TS){
                    }
                });
            }}) ;
            $.ajax({
                url:"/jsons/loadMajorNameIn.form",
                type:"post",
                data:{stuCollageName:stuCollageName},
                dataType:"json",
                success:function(data){
                    if(data.rows.length>0){
                        $("#filter_major")
                                .combobox({valueField:'stuMajorName',textField:'stuMajorName',panelHeight:'auto'})
                                .combobox("loadData",data.rows).combobox("setText","全部");
                    }

                },
                error:function(XMLHttpRequest,textStatus,errorThrown){
                    alert(XMLHttpRequest.status);
                    alert(XMLHttpRequest.readyState);
                    alert(textStatus);
                },
                complete:function(XHR, TS){
                }
            });
            $("#filter_major").combobox({onChange:function(value){
                stuMajorName=stuMajorName;
            }}) ;
            //加载年级信息
            $.ajax({
                url:"/jsons/loadGradeNameIn.form",
                type:"post",
                dataType:"json",
                success:function(data){
                    if(data.rows.length>0){
                        $("#filter_grade")
                                .combobox({valueField:'stuGradeName',textField:'stuGradeName',panelHeight:'auto'})
                                .combobox("loadData",data.rows).combobox("setText","全部");
                    }
                },
                error:function(XMLHttpRequest,textStatus,errorThrown){
                    alert(XMLHttpRequest.status);
                    alert(XMLHttpRequest.readyState);
                    alert(textStatus);
                },
                complete:function(XHR, TS){
                }
            });
            $("#filter_grade").combobox({onChange:function(value){
                stuClassName=stuClassName;
            }}) ;

        });
        function  searchIn(){
            var classname=$("#filter_college").combobox("getValue");
            var major=$("#filter_major").combobox("getValue");
            var grade=$("#filter_grade").combobox("getValue");
            $("#dg").datagrid("reload",{stuCollageName:classname, stuMajorName:major, stuGradeName:grade});
        }
        function  go(val){
            return '<a href="<%=request.getContextPath()%>/views/admin/ClassStudentInfo.form?stuClassName='+val+'" target="_blank">'+val+'</a>  ';
        }
    </script>
    <%--判断是否是登录状态--%>
    <%@include file="../common/CheckLogin.jsp"%>
</head>
<body>
<div id="Board" style="width: calc(100% - 10px);height: 100%;position: fixed;top: 0;left:0;z-index: 99999;background: #fff;"></div>
<%--数据表格--%>
<table id="dg" class="easyui-datagrid" style="width:100%;min-height:556px;max-height: 100%;"
       data-options="pagination:true,
               rownumbers:true,
               singleSelect:true,
               method:'post',
               autoRowHeight:false,
               toolbar:'#tb',
               fitColumns:true,
               <%--2、第二处修改，修改此处的Json服务，用于加载数据--%>
               url:'/jsons/loadClassInfors.form'">
    <thead>
    <tr>
        <%--3、第三处修改，修改此处的列名称，与数据库一致，显示有必要的--%>
        <th field="stuClassName", width="100px", formatter="go">班级名称</th>
        <th field="stuCollageName" width="100px">所属学院</th>
        <th field="stuMajorClass" width="100px">专业分类</th>
        <th field="stuMajorName" width="100px">所属专业</th>
        <%--如果班级唯一显示，班级不唯一（各个年级都有）不显示--%>
        <th field="stuGradeName" width="100px">所属年级</th>
    </tr>
    </thead>
</table>
<%--表格头部按钮--%>
<div id="tb" style="height:auto">
    <span>学院</span>
    <input  name="filter" id="filter_college" class="easyui-combobox"
            data-options="editable:true,panelHeight:'auto'" style="width:100px"/>
    &nbsp;&nbsp;
    <span>专业</span>
    <select class="easyui-combobox" name="filter" id="filter_major"
            data-options="editable:true,panelHeight:'auto'" style="width:100px">

    </select>&nbsp;&nbsp;
    <span>年级</span>
    <select  class="easyui-combobox" name="filter" id="filter_grade"
             data-options="editable:true,panelHeight:'auto'" style="width:100px">

    </select>&nbsp;&nbsp;
    <a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-search',plain:true" onclick="searchIn()">查找</a>&nbsp;&nbsp;&nbsp;&nbsp;
    <%--4、第四处修改，修改菜单按钮，选择哪些按钮需要--%>
    <input class="easyui-searchbox" data-options="prompt:'请输入班级名称',searcher:doSearch" style="width:200px"/>
</div>

</body>
</html>