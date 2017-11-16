<%--
  Created by IntelliJ IDEA.
  User: dskj012
  Date: 2016/10/21
  Time: 9:15
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java"  pageEncoding="UTF-8" %>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
    <!--兼容360浏览器，防止布局乱，设置IE的文档模式为最高版本，并且如果存在chrome插件，自动使用Webkit引擎-->
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <link rel="Shortcut Icon" href="<%=request.getContextPath()%>/asset/image/neu.jpg" type="image/x-icon">
    <link rel="stylesheet" href="<%=request.getContextPath()%>/asset_admin_new/css/StuMsgManage.css" />
    <script type="text/javascript" src="<%=request.getContextPath()%>/asset_admin_new/js/jquery-1.11.1.min.js"></script>
    <script type="text/javascript" src="<%=request.getContextPath()%>/asset/js/common.js"></script>
    <script type="text/javascript" src="<%=request.getContextPath()%>/asset_admin_new/js/public.js"></script>
    <script type="text/javascript" src="<%=request.getContextPath()%>/asset_admin_new/js/common_stuMsgManage.js"></script>
    <!-- 导入layer -->
    <script type="text/javascript" src="<%=request.getContextPath()%>/asset/layer/layer.js"></script>

    <%--引入kindereditor--%>
    <link rel="stylesheet" href="<%=request.getContextPath()%>/asset/kindeditor-4.1.10/themes/default/default.css" />
    <link rel="stylesheet" href="<%=request.getContextPath()%>/asset/kindeditor-4.1.10/plugins/code/prettify.css" />
    <script charset="utf-8" src="<%=request.getContextPath()%>/asset/kindeditor-4.1.10/kindeditor.js"></script>
    <script charset="utf-8" src="<%=request.getContextPath()%>/asset/kindeditor-4.1.10/lang/zh_CN.js"></script>
    <script charset="utf-8" src="<%=request.getContextPath()%>/asset/kindeditor-4.1.10/plugins/code/prettify.js"></script>
    <%--引入图片上传--%>
    <script type="text/javascript" src="<%=request.getContextPath()%>/asset/js/ajaxfileupload.js"></script>
    <title>第二课堂教师管理界面</title>
    <script>
        var moduleType = GetQueryString("moduleType");//所属模块的ID
        //1、第一处修改，修改增删改的请求地址以及deleteId
        var addUrl = "/jsons/addNews.form";
        var editUrl = "/jsons/editNews.form";
        var deleteUrl = "/jsons/deleteNews.form";
        var editorName = "";//KindEditor的Textarea的ID，如果没用到，赋值为null
        var imageUpload = "newsImg";//图片上传的标识，如果没有图片上传，赋值为空，如果有，赋值为数据库存放图片名称的字段名称，不带_
        var deleteId = "newsId";//用于删除功能的ID参数，赋值为当前数据库表的ID
        var loadUrl = "/jsons/loadNews.form";

    </script>
</head>
<body>
<div class="stuMsgManage">
    <!--功能栏-->
    <div class="function">
        <ul>
            <li class="function_new" onclick="Add()"><span>新建</span></li>
            <li class="function_edit" onclick="Edit()"><span>修改</span></li>
            <li class="function_remove" onclick="Delete()"><span>删除</span></li>
            <li class="function_refresh" onclick="reload()"><span>刷新</span></li>
            <li class="function_search"><span>综合条件查询</span></li>
            <li class="function_import"><span>导入学生信息</span></li>
            <li class="function_stuPicture"><span>上传学生照片</span></li>
            <li class="function_downModel"><span>下载模版</span></li>
        </ul>
    </div>
    <!--综合查询部分-->
    <div class="searchContent">
        <div>
            <ul>
                <li>
                    <span>学号:</span>
                    <input type="text"/>
                </li>
                <li>
                    <span>身份证号:</span>
                    <input type="text" />
                </li>
                <li>
                    <span>年级:</span>
                    <div>
                        <ul class="asSelect">
                            <li>项目培训1</li>
                            <li>项目培训2</li>
                            <li>项目培训3</li>
                        </ul>
                        <span></span>
                    </div>
                </li>
                <li>
                    <span>寝室楼:</span>
                    <div>
                        <ul class="asSelect">
                            <li>项目培训1</li>
                            <li>项目培训2</li>
                            <li>项目培训3</li>
                        </ul>
                        <span></span>
                    </div>
                </li>
                <li>
                    <span>培养方式:</span>
                    <div>
                        <ul class="asSelect">
                            <li>项目培训1</li>
                            <li>项目培训2</li>
                        </ul>
                        <span></span>
                    </div>
                </li>
            </ul>
            <ul>
                <li>
                    <span>姓名:</span>
                    <input type="text" />
                </li>
                <li>
                    <span>手机号:</span>
                    <input type="text" />
                </li>
                <li>
                    <span>入党时间:</span>
                    <input type="date" />
                </li>
                <li>
                    <span>房间号:</span>
                    <div>
                        <ul class="asSelect">
                            <li>项目培训1</li>
                            <li>项目培训1</li>
                        </ul>
                        <span></span>
                    </div>
                </li>
                <li>
                    <span>招生类别:</span>
                    <div>
                        <ul class="asSelect">
                            <li>项目培训1</li>
                        </ul>
                        <span></span>
                    </div>
                </li>
            </ul>
            <ul>
                <li>
                    <span>性别:</span>
                    <div>
                        <ul class="asSelect">
                            <li>项目培训1</li>
                            <li>项目培训1</li>
                        </ul>
                        <span></span>
                    </div>
                </li>
                <li>
                    <span>学院:</span>
                    <div>
                        <ul class="asSelect">
                            <li>项目培训1</li>
                            <li>项目培训1</li>
                        </ul>
                        <span></span>
                    </div>
                </li>

                <li>
                    <span>入学年份:</span>
                    <div>
                        <ul class="asSelect">
                            <li>项目培训</li>
                            <li>项目培训</li>
                        </ul>
                        <span></span>
                    </div>
                </li>
                <li>
                    <span>学籍状态:</span>
                    <div>
                        <ul class="asSelect">
                            <li>项目培训</li>
                            <li>项目培训</li>
                        </ul>
                        <span></span>
                    </div>
                </li>
            </ul>
            <ul class="lastUl">
                <li>
                    <span>民族:</span>
                    <div>
                        <ul class="asSelect">
                            <li>项目培训</li>
                            <li>项目培训</li>
                        </ul>
                        <span></span>
                    </div>
                </li>
                <li>
                    <span>专业:</span>
                    <div>
                        <ul class="asSelect">
                            <li>项目培训</li>
                            <li>项目培训</li>
                        </ul>
                        <span></span>
                    </div>
                </li>
                <li>
                    <span>所在班级:</span>
                    <div>
                        <ul class="asSelect">
                            <li>项目培训</li>
                            <li>项目培训</li>
                        </ul>
                        <span></span>
                    </div>
                </li>
                <li>
                    <span>学制:</span>
                    <div>
                        <ul class="asSelect">
                            <li>项目培训</li>
                            <li>项目培训</li>
                        </ul>
                        <span></span>
                    </div>
                </li>
            </ul>
        </div>
        <p></p>
        <div class="buttons">
            <span class="clearAll" onclick="clear_search()">清空</span>
            <span class="search" onclick="select_box()">搜索</span>
        </div>
    </div>
    <!--结果集表格-->
    <div class="table">
        <table id="dataTable" border="0" cellspacing="0" cellpadding="0">
            <thead>
                <tr>
                    <td></td>
                    <td>新闻标题</td>
                    <td>新闻内容</td>
                    <td>新闻类型</td>
                    <td>新闻创建者</td>
                </tr>
            </thead>
            <tbody>
            </tbody>
        </table>
    </div>
    <div class="pagingTurn">
        <div>
            <span class="turn_left" onclick="turn_left()"></span> 第
            <span class="currentPageNum">1</span> 页，共
            <span class="pageNum"></span> 页
            <span class="turn_right" onclick="turn_right()"></span>
        </div>
        <div>
            显示<span class="pageNum"></span>到<span class="pageNum"></span>，共<span class="pageNum"></span>条记录
        </div>
    </div>
</div>
<!--弹出框的层-->
<div class="popup"></div>
    <form id="Form" class="demoform" action=""><!--存在为了提交-->
        <div id="dlg" class="new">

            <div class="header">
                <span id="typ">新建</span>
                <span class="iconConcel"></span>
            </div>
            <input type="hidden" id="photo_textbox" name="newsImg">
<%--            <div id="userphoto_box" style="height: 20px; width: 230px; float: right;">
                <img id="user_photo" src="<%=request.getContextPath()%>/asset/image/default.jpg" onerror="error=null;src='<%=request.getContextPath()%>/asset/image/default.jpg'" style="width: 200px;height: 130px;margin-right: 5px;">
            </div>--%>
            <ul>
                <li style="display: none;">
                    <input type="text" id="newsId" name="newsId" hidden/>
                </li>
                <li>
                    <span>新闻标题&nbsp;&nbsp;:&nbsp;&nbsp;&nbsp;&nbsp;</span>
                    <input type="text" id="newsTitle" name="newsTitle" type="text" datatype="*" nullmsg="请填写新闻标题" errormsg="新闻标题不能为空" class="inputxt" />
                    <span class="Validform_checktip">请填写新闻标题</span>
                </li>
                <li>
                    <span>新闻类型&nbsp;&nbsp;:&nbsp;&nbsp;&nbsp;&nbsp;</span>
                    <select id="newsType" name="newsType">
                        <option value="学校新闻">学校新闻</option>
                        <option value="学院新闻">学院新闻</option>
                    </select>
                </li>
<%--                <li>
                    <span>新闻封面图片&nbsp;&nbsp;:&nbsp;&nbsp;&nbsp;&nbsp;</span>
                    <input id="newsImg" name="newsImg" type="file" style="border:0" onchange="preview(this)" />
                    <input type="hidden"  id="newsImgh" />
                </li>--%>
                <%--KindEditor文本框放在Form外面，如果不需要KindEditor，注释掉--%>
                <li>
                    <span>新闻内容&nbsp;&nbsp;:&nbsp;&nbsp;&nbsp;&nbsp;</span>
                    <textarea id="newsContent" name="newsContent" style="width:100%;height:330px;"></textarea>
                </li>
            </ul>

            <!--按钮窗口-->
            <div id="dlg-buttons" class="new_buttons">
                <input type="reset" value="保存" onclick="Save()" />
                <input type="reset" value="取消" onclick="close()" />
            </div>

        </div>
    </form>
</body>
</html>