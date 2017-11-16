<%--
  Created by IntelliJ IDEA.
  User: gq
  Date: 2016/10/31
  Time: 13:35
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
    <script type="text/javascript" src="<%=request.getContextPath()%>/asset/js/laydate/laydate.js"></script>
    <script type="text/javascript" src="<%=request.getContextPath()%>/asset/js/common.js"></script>
    <script type="text/javascript" src="<%=request.getContextPath()%>/asset_admin_new/js/studentManage.js"></script>
    <!-- 导入layer -->
    <script type="text/javascript" src="<%=request.getContextPath()%>/asset/layer/layer.js"></script>

    <%--引入kindereditor--%>
    <link rel="stylesheet" href="<%=request.getContextPath()%>/asset/kindeditor-4.1.10/themes/default/default.css" />
    <link rel="stylesheet" href="<%=request.getContextPath()%>/asset/kindeditor-4.1.10/plugins/code/prettify.css" />
    <script charset="utf-8" src="<%=request.getContextPath()%>/asset/kindeditor-4.1.10/kindeditor.js"></script>
    <script charset="utf-8" src="<%=request.getContextPath()%>/asset/kindeditor-4.1.10/lang/zh_CN.js"></script>
    <script charset="utf-8" src="<%=request.getContextPath()%>/asset/kindeditor-4.1.10/plugins/code/prettify.js"></script>
    <%--引入表单验证--%>
    <script type="text/javascript" src="<%=request.getContextPath()%>/asset_admin_new/js/Validform_v5.3.2.js"></script>
    <link rel="stylesheet" href="<%=request.getContextPath()%>/asset_admin_new/css/style.css" />
    <link rel="stylesheet" href="<%=request.getContextPath()%>/asset_admin_new/css/demo.css" />
    <%--引入图片上传--%>
    <script type="text/javascript" src="<%=request.getContextPath()%>/asset/js/ajaxfileupload.js"></script>
    <title>第二课堂教师管理界面</title>
    <script>
        //1、第一处修改，修改增删改的请求地址以及deleteId
        var moduleType = GetQueryString("moduleType");//所属模块的ID
        var addUrl = "";
        var editUrl = "";
        var deleteUrl = "";
        var editorName = "";//KindEditor的Textarea的ID，如果没用到，赋值为null
        var imageUpload = "";//图片上传的标识，如果没有图片上传，赋值为空，如果有，赋值为数据库存放图片名称的字段名称，不带_
        var deleteId = "";//用于删除功能的ID参数，赋值为当前数据库表的ID
        var fileUpload='';
        var loadUrl = "/jsons/loadStudentsNew.form";
        var  className=decodeURI(decodeURI(GetQueryString("stuClassName")));
        /**
         * 加载数据
         */
        $(function(){
            page= $(".currentPageNum").val();
            rows = $("#rows").val();
            jsonPara={rows:rows,page:page,stuClassName:className};
            reload();

        });
        function before_reload(){

            page= $(".currentPageNum").val();
            rows = $("#rows").val();
            jsonPara={rows:rows,page:page,stuClassName:className};
            reload();
        }
        function refresh_reload(){
            isSelect='';
            clickStatus='';
            $(".currentPageNum").val(1);
            page=1;
            rows = $("#rows").val();
            if(isCondition=='true'){
                select_box(1);
            }else{
                jsonPara={rows:rows,page:page,stuClassName:className};
                reload();
            }
        }
        function  reload(){
            load();
            $.ajax({
                url:loadUrl,
                type:"post",
                data:jsonPara,
                dataType:"json",
                success:function(data){
                    $("tbody").html("");
                    if(data!=null && data.rows!=null &&data.rows.length>0){
                        for(var i = 0 ;i<data.rows.length;i++){
                            var row = data.rows[i];
                            for(var key in row){
                                if(row[key]==null||row[key]=='null'||row[key]=='NULL')
                                    row[key]='';
                            }
                            var tr = '<tr id="tr'+(i+1)+'">'+
                                    '<td>'+(i+1)+'</td>'+
                                    '<td class="studentID" title="'+row.studentID+'">'+row.studentID+'</td>'+
                                    '<td class="studentName" title="'+row.studentName+'">'+row.studentName+'</td>'+
                                    '<td class="studentGender" title="'+row.studentGender+'">'+row.studentGender+'</td>'+
                                    '<td class="studentNation" title="'+row.studentNation+'">'+row.studentNation+'</td>'+
                                    '<td class="studentBirthday" title="'+row.studentBirthday+'">'+row.studentBirthday+'</td>'+
//                                    '<td class="studentNativePlace" title="'+row.studentNativePlace+'">'+row.studentNativePlace+'</td>'+
//                                    '<td class="studentFamilyAddress" title="'+row.studentFamilyAddress+'">'+row.studentFamilyAddress+'</td>'+
//                                    '<td class="studentFamilyPostcode" title="'+row.studentFamilyPostcode+'">'+row.studentFamilyPostcode+'</td>'+
                                    '<td class="studentIdCard" title="'+row.studentIdCard+'">'+row.studentIdCard+'</td>'+
                                    '<td class="studentPhone" title="'+row.studentPhone+'">'+row.studentPhone+'</td>'+
//                                    '<td class="studentQQ" title="'+row.studentQQ+'">'+row.studentQQ+'</td>'+
//                                    '<td class="studentEmail"title="'+row.studentEmail+'">'+row.studentEmail+'</td>'+
//                                    '<td class="politicsStatus" title="'+row.politicsStatus+'">'+row.politicsStatus+'</td>'+
//                                    '<td class="usiCampus" title="'+row.usiCampus+'">'+row.usiCampus+'</td>'+
//                                    '<td class="entranceDate" title="'+row.entranceDate+'">'+row.entranceDate+'</td>'+
//                                    '<td class="educationLength" title="'+row.educationLength+'">'+row.educationLength+'</td>'+
//                                    '<td class="trainingMode" title="'+row.trainingMode+'">'+row.trainingMode+'</td>'+
//                                    '<td class="orientationUnit" title="'+row.orientationUnit+'">'+row.orientationUnit+'</td>'+
//                                    '<td class="enrollType" title="'+row.enrollType+'">'+row.enrollType+'</td>'+
                                    '<td><a  href="javascript:void(0);" onclick="SearchDetail(\''+row.studentPhoto+'\')">查看详情</a></td>'+
                                    '</tr>';

                            $("tbody").append(tr);
                            $("#tr"+(i+1)).data(row);
                        }
                        rowClick();//绑定行点击事件
                        totalNum=data.total;

                    }else{
                        totalNum=0;
                    }
                    paging();
                    disLoad();
                },error:function(){
                    layer.msg("网络错误");
                    disLoad();
                }
            });


        }
        function SearchDetail(val){
            $("#tb").show();
            $("#dlg").show();
            $("#studentPhotos").attr("src","/Files/Images/"+val);
        }

    </script>
    <script type="text/javascript" src="<%=request.getContextPath()%>/asset_admin_new/js/common_stuMsgManage.js"></script>
</head>
<body>
<div class="stuMsgManage">
    <%--<!--功能栏-->--%>
    <%--<div class="function">--%>
        <%--<ul>--%>
            <%--<li class="function_new" onclick="Add()"><span>新建</span></li>--%>
            <%--<li class="function_edit" onclick="Edit()"><span>修改</span></li>--%>
            <%--<li class="function_remove" onclick="Delete()"><span>删除</span></li>--%>
            <%--<li class="function_refresh" onclick="refresh_reload()"><span>刷新</span></li>--%>
            <%--<li class="function_search"><span>综合条件查询</span></li>--%>
            <%--<li class="function_import" onclick="batchInsert()"><span>导入学生信息</span></li>--%>
            <%--&lt;%&ndash;<li class="function_stuPicture"><span>上传学生照片</span></li>&ndash;%&gt;--%>
            <%--<li class="function_downModel" onclick="getModel()"><span>下载模版</span></li>--%>
        <%--</ul>--%>
    <%--</div>--%>
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
                        <ul id="GradeName" class="asSelect">

                        </ul>
                        <span></span>
                    </div>
                </li>
                <li>
                    <span>寝室楼:</span>
                    <div>
                        <ul id="Building" class="asSelect">

                        </ul>
                        <span></span>
                    </div>
                </li>
                <li>
                    <span>培养方式:</span>
                    <div>
                        <ul id="TrainMode" class="asSelect">

                        </ul>
                        <span></span>
                    </div>
                </li>
            </ul>
            <ul >
                <li>
                    <span>姓名:</span>
                    <input type="text" />
                </li>
                <li>
                    <span>手机号:</span>
                    <input type="text" />
                </li>
                <li>
                    <span>房间号:</span>
                    <div>
                        <ul id="RoomNumber" class="asSelect">

                        </ul>
                        <span></span>
                    </div>
                </li>
                <li>
                    <span>招生类别:</span>
                    <div>
                        <ul id="EnroType" class="asSelect">

                        </ul>
                        <span></span>
                    </div>
                </li>
                <li>
                    <span></span>
                    <div>
                        <ul>

                        </ul>
                        <span style="display: none"></span>
                    </div>
                </li>
            </ul>
            <ul>
                <li>
                    <span>性别:</span>
                    <div>
                        <ul class="asSelect">
                            <li class="asSelectLi"></li>
                            <li class="asSelectLi">男</li>
                            <li class="asSelectLi">女</li>
                        </ul>
                        <span></span>
                    </div>
                </li>
                <li>
                    <span>学院:</span>
                    <div>
                        <ul id="CollageName" class="asSelect">

                        </ul>
                        <span></span>
                    </div>
                </li>

                <li>
                    <span>学籍状态:</span>
                    <div>
                        <ul id="schoolStatus" class="asSelect">

                        </ul>
                        <span></span>
                    </div>
                </li>
                <li>
                    <span></span>
                    <div>
                        <ul>

                        </ul>
                        <span style="display: none"></span>
                    </div>
                </li>
            </ul>
            <ul class="lastUl">
                <li>
                    <span>民族:</span>
                    <div>
                        <ul id="stuNation" class="asSelect">

                        </ul>
                        <span></span>
                    </div>
                </li>
                <li>
                    <span>专业:</span>
                    <div>
                        <ul id="MajorName" class="asSelect">

                        </ul>
                        <span></span>
                    </div>
                </li>
                <li>
                    <span>所在班级:</span>
                    <div>
                        <ul id="ClassName" class="asSelect">

                        </ul>
                        <span></span>
                    </div>
                </li>
                <li>
                    <span>学制:</span>
                    <div>
                        <ul id="educateLength" class="asSelect">

                        </ul>
                        <span></span>
                    </div>
                </li>
            </ul>
        </div>
        <p>注：因为数据经过加密的关系，所有列出条件均为精确匹配，输入的内容必须和数据库中的一致才可以匹配到结果</p>
        <div class="buttons">
            <span class="clearAll" onclick="clear_search()">清空</span>
            <span class="search" onclick="select_box(1)">搜索</span>
        </div>
    </div>
    <!--结果集表格-->
    <div class="table">
        <table id="dataTable" border="0" cellspacing="0" cellpadding="0">
            <thead>
            <tr>
                <td></td>
                <td colspan="8" style="text-align: center">学生基本信息</td>
                <%--<td colspan="6" style="text-align: center">学生高校信息</td>--%>
            </tr>
            <tr>
                <td></td>
                <td>学号</td>
                <td>姓名</td>
                <td>性别</td>
                <td>民族</td>
                <td>出生日期</td>
                <%--<td>籍贯</td>--%>
                <%--<td>家庭住址</td>--%>
                <%--<td>邮编</td>--%>
                <td>身份证号</td>
                <td>手机号</td>
                <%--<td>QQ号</td>--%>
                <%--<td>电子邮件</td>--%>
                <%--<td>政治面貌</td>--%>
                <%--<td>所在校区</td>--%>
                <%--<td>入学年份</td>--%>
                <%--<td>学制</td>--%>
                <%--<td>培养方式</td>--%>
                <%--<td>定向单位</td>--%>
                <%--<td>招生类别</td>--%>
                <td>查看详情</td>
            </tr>
            </thead>
            <tbody>
            </tbody>
        </table>
    </div>
    <!--分页-->
    <div class="pagingTurn">
        <div>
            <span class="turn_left" onclick="turn_left()"></span> 第
            <input class="currentPageNum" type="text" value="1">页，共
            <span class="pageNum"></span> 页
            <span class="turn_right" onclick="turn_right()"></span>
        </div>
        <div>
            <select id="rows" name="rows" onchange="refresh_reload()">
                <option value="10" selected>10</option>
                <option value="20">20</option>
                <option value="50">50</option>
                <option value="100">100</option>
            </select>
        </div>
        <img src="<%=request.getContextPath()%>/asset_admin_new/img/sx2.png" onclick="refresh_reload()" />
        <div>
            显示<span class="pageNum"></span>到<span class="pageNum"></span>，共<span class="pageNum"></span>条记录
        </div>
    </div>
</div>
<!--弹出框的层-->
<style>
    .inputxt{
        margin-left: 25px;
        readonly:readonly;
    }
    #Form li select{
        margin-left: 25px;
        width: 238px;
        height: 26px;
        border: 1px solid #1990fe;
    }
    #Form li span{
        width:60px;
        font-family: "微软雅黑";
        font-size: 12px;
        color: #1990fe;
    }
    /*新建的弹出窗口*/
    .new{
        position: absolute;
        top: 20px;
        left: 324px;
        z-index: 100;
        width:850px;
        height:900px;
        border: 1px solid #197FFE;
        /*margin: 250px auto;*/
        background-color: #FFFFFF;
        display: none;
    }
</style>
<div class="popup" id="tb"></div>
<form id="Form" class="demoform" action=""><!--存在为了提交-->
    <div id="dlg" class="new">

        <div class="header">
            <span id="typ">详细信息</span>
            <span type="reset" class="iconConcel"></span>
        </div>
        <input type="hidden" id="photo_textbox" name="studentPhoto">
        <div id="userphoto_box" style="height: 20px; width: 230px; float: right;">
            <img id="studentPhotos" src="<%=request.getContextPath()%>/Files/Images/default.jpg" onerror="error=null;src='<%=request.getContextPath()%>/Files/Images/default.jpg'" style="width: 180px;height: 200px;margin-right: 300px;">
        </div>
        <ul>

            <li>
                <span>学号:</span>
                <input type="text" id="studentID" name="studentID" datatype="*"  class="notNull inputxt" readonly="readonly"  />
            </li>
            <li>
                <span>姓名:</span>
                <input type="text" id="studentName" name="studentName"  class="inputxt" readonly="readonly"  />
            </li>
            <li>
                <span>曾用名:</span>
                <input type="text" id="studentUsedName" name="studentUsedName"  class="inputxt" readonly="readonly"  />
            </li>
            <%--<li>--%>
            <%--<span>照片:</span>--%>
            <%--<input id="studentPhoto" name="studentPhotos" type="file" style="border:0" onchange="preview(this)" />--%>
            <%--&lt;%&ndash;<input type="hidden"  id="studentImgh" />&ndash;%&gt;--%>
            <%--</li>--%>
            <li>
                <span>性别:</span>
                <input type="text" id="studentGender" name="studentGender"  class="inputxt" readonly="readonly"  />
            </li>
            <li>
                <span>民族:</span>
                <input type="text" id="studentNation" name="studentNation"   class="inputxt" />
            </li>
            <li>
                <span>出生日期:</span>
                <input type="text" id="studentBirthday" name="studentBirthday"   class="inputxt" onclick="laydate()" readonly="readonly"/>
                <span style="margin-left: 100px;width:60px;">籍贯:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span>
                <input type="text" id="studentNativePlace" name="studentNativePlace"  class="inputxt" readonly="readonly"/>
            </li>
            <li>
                <span>家庭住址:</span>
                <input type="text" id="studentFamilyAddress" name="studentFamilyAddress"  class="inputxt" readonly="readonly"/>
                <span style="width:60px;margin-left: 100px;">邮编:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span>
                <input type="text" id="studentFamilyPostcode" name="studentFamilyPostcode"   class="inputxt" readonly="readonly"/>
            </li>
            <li>
                <span>身份证号:</span>
                <input type="text" id="studentIdCard" name="studentIdCard"  class="inputxt" readonly="readonly"/>
                <span style="width:60px;margin-left: 100px;">手机号码:</span>
                <input type="text" id="studentPhone" name="studentPhone" class="inputxt" readonly="readonly"/>
            </li>
            <li>
                <span>qq号:</span>
                <input type="text" id="studentQQ" name="studentQQ" class="inputxt" readonly="readonly"/>
                <span style="width:60px;margin-left: 100px;">邮件:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span>
                <input type="text" id="studentEmail" name="studentEmail"  class="inputxt" readonly="readonly"/>
            </li>
            <li>
                <span>外语语种:</span>
                <input type="text" id="foreignLanguage" name="foreignLanguage"  class="inputxt" readonly="readonly"/>
                <span style="width:60px;margin-left: 100px;">宗教信仰:</span>
                <input type="text" id="faith" name="faith"   class="inputxt" readonly="readonly"/>
            </li>
            <li>
                <span>政治面貌:</span>
                <input type="text" id="politicsStatus" name="politicsStatus"   class="inputxt" readonly="readonly"/>
                <span style="width:60px;margin-left: 100px;">入党时间:</span>
                <input type="text" id="politicsStatusDate" name="politicsStatusDate"   class="inputxt" onclick="laydate()" readonly="readonly"/>
            </li>
            <li>
                <span style="width:60px">所在班级:</span>
                <input type="text" id="stuClassName" name="stuClassName" class="inputxt" readonly="readonly"/>
            </li>
            <li>
                <span>所在年级:</span>
                <input type="text" id="stuGradeName" name="stuGradeName" class="inputxt" readonly="readonly"/>
                <span style="width:60px;margin-left: 100px;">所在专业:</span>
                <input type="text" id="stuMajorName" name="stuMajorName" class="inputxt" readonly="readonly"/>
            </li>

            <li>
                <span>所在学院:</span>
                <input type="text" id="stuCollageName" name="stuCollageName" class="inputxt" readonly="readonly"/>
                <span style="width:60px;margin-left: 100px;">寝室楼号:</span>
                <input type="text" id="usiBuilding" name="usiBuilding"   class="inputxt" readonly="readonly"/>
            </li>

            <li>
                <span>入学年份:</span>
                <input type="text" id="entranceDate" name="entranceDate"  class="inputxt" readonly="readonly"/>
                <span style="width:60px;margin-left: 100px;">学制:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span>
                <input type="text" id="educationLength" name="educationLength"   class="inputxt" readonly="readonly"/>
            </li>

            <li>
                <span>培养方式:</span>
                <input type="text" id="trainingMode" name="trainingMode"   class="inputxt" readonly="readonly"/>
                <span style="width:60px;margin-left: 100px;">招生类别:</span>
                <input type="text" id="enrollType" name="enrollType"   class="inputxt" readonly="readonly"/>
            </li>

            <li>
                <span>学籍状态</span>
                <input type="text" id="schoolRollStatus" name="schoolRollStatus"   class="inputxt" readonly="readonly"/>
                <span style="width:60px;margin-left: 100px;">房间号码:</span>
                <input type="text" id="usiRoomNumber" name="usiRoomNumber"   class="inputxt" readonly="readonly"/>
            </li>

            <li>
                <span>考号:</span>
                <input type="text" id="ceeNumber" name="ceeNumber"   class="inputxt" readonly="readonly"/>
                <span style="width:60px;margin-left: 100px;">所在省份:</span>
                <input type="text" id="ceeProvince" name="ceeProvince"   class="inputxt" readonly="readonly"/>
            </li>

            <li>
                <span>所在市:</span>
                <input type="text" id="ceeCity" name="ceeCity"   class="inputxt" readonly="readonly"/>
                <span style="width:60px;margin-left: 100px;">所在高中:</span>
                <input type="text" id="ceeHighSchool" name="ceeHighSchool"   class="inputxt" readonly="readonly"/>
            </li>

            <li>
                <span>生源地:</span>
                <input type="text" id="ceeOrigin" name="ceeOrigin"   class="inputxt" readonly="readonly"/>
                <span style="width:60px;margin-left: 100px;">学生干部:</span>
                <input type="text" id="studentLeader" name="studentLeader"   class="inputxt" readonly="readonly"/>
            </li>

        </ul>
    </div>
</form>
</body>
</html>