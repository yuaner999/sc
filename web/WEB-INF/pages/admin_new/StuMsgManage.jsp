<%--
  Created by IntelliJ IDEA.
  User: dskj012
  Date: 2016/10/21
  Time: 9:18
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java"  pageEncoding="UTF-8" %>
<head>
    <link rel="Shortcut Icon" href="<%=request.getContextPath()%>/asset/image/neu.jpg" type="image/x-icon">
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
    <!--兼容360浏览器，防止布局乱，设置IE的文档模式为最高版本，并且如果存在chrome插件，自动使用Webkit引擎-->
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <title>第二课堂教师管理界面</title>
    <script type="text/javascript" src="<%=request.getContextPath()%>/asset/js/common.js"></script>
    <script type="text/javascript" src="<%=request.getContextPath()%>/asset_admin_new/js/jquery-1.11.1.min.js"></script>
    <script type="text/javascript" src="<%=request.getContextPath()%>/asset_admin_new/js/common_stuMsgManage.js"></script>
    <script type="text/javascript" src="<%=request.getContextPath()%>/asset_admin_new/js/common_tabs.js"></script>
    <%--<script type="text/javascript" src="<%=request.getContextPath()%>/asset_admin_new/js/menu.js"></script>--%>
    <%--<script type="text/javascript" src="<%=request.getContextPath()%>/asset_admin_new/js/StuMsgManage.js"></script>--%>

    <link rel="stylesheet" href="<%=request.getContextPath()%>/asset_admin_new/css/menu.css" />
    <link rel="stylesheet" href="<%=request.getContextPath()%>/asset_admin_new/css/StuMsgManage.css" />
    <%--<link rel="stylesheet" type="text/css" href="css/StuMsgManage.css" />--%>
    <%--<link rel="stylesheet" href="css/menu.css" />--%>
    <%--<script src="js/jquery-1.11.1.min.js"></script>--%>
    <%--<script src="js/menu.js"></script>--%>
    <%--<!--<script src="js/StuMsgManage.js" type="text/javascript"></script>-->--%>
    <%--<script src="js/common_tabs.js" type="text/javascript"></script>--%>
    <%--<script src="js/common_stuMsgManage.js" type="text/javascript"></script>--%>
  <script>
  </script>
</head>
<body>
<div class="banner">
    <img src="<%=request.getContextPath()%>/asset_admin_new/img/neulogo.png" alt="" class="newlogo" />
    <span>共青团"第二课堂成绩单"信息认证平台&nbspNEU&nbspY&nbspPionee-R</span>
    <div class="btnexit">退出</div>
    <span class="loginmess">下午好,刘雷同学</span>
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
                <li class="oneli">
                    <div class="onetitlewrap">
                        <div class="onetitle">学校</div>
                        <img src="<%=request.getContextPath()%>/asset_admin_new/img/btndown.png" alt="" class="btndown" />
                        <div class="devide">
                            <div class="devideleft"></div>
                            <div class="devideright"></div>
                        </div>
                    </div>
                    <ul class="twoul">
                        <li>
                            ·
                            <a href="#">学校宣传引导</a>
                        </li>
                        <li>
                            ·
                            <a href="#">导入校内活动</a>
                        </li>
                        <li>
                            ·
                            <a href="#">学校活动管理</a>
                        </li>
                        <li>
                            ·
                            <a href="#">学校审核公示</a>
                        </li>
                        <li>
                            ·
                            <a href="#">活动申请管理</a>
                        </li>
                        <li>
                            ·
                            <a href="#">校外活动审核</a>
                        </li>
                        <li>
                            ·
                            <a href="#">打印申请管理</a>
                        </li>
                    </ul>
                </li>
                <li class="oneli">
                    <div class="onetitlewrap">
                        <div class="onetitle">职能部门</div>
                        <img src="<%=request.getContextPath()%>/asset_admin_new/img/btndown.png" alt="" class="btndown" />
                        <div class="devide">
                            <div class="devideleft"></div>
                            <div class="devideright"></div>
                        </div>
                    </div>
                    <ul class="twoul">
                        <li>
                            ·
                            <a href="#">学校审核公示</a>
                        </li>
                        <li>
                            ·
                            <a href="#">导入校内活动</a>
                        </li>
                        <li>
                            ·
                            <a href="#">学校活动管理</a>
                        </li>

                    </ul>
                </li>
                <li class="oneli">
                    <div class="onetitlewrap">
                        <div class="onetitle">学院</div>
                        <img src="<%=request.getContextPath()%>/asset_admin_new/img/btndown.png" alt="" class="btndown" />
                        <div class="devide">
                            <div class="devideleft"></div>
                            <div class="devideright"></div>
                        </div>
                    </div>
                    <ul class="twoul">
                        <li>
                            ·
                            <a href="#">学校宣传引导</a>
                        </li>
                        <li>
                            ·
                            <a href="#">导入校内活动</a>
                        </li>
                        <li>
                            ·
                            <a href="#">学校活动管理</a>
                        </li>
                    </ul>
                </li>
                <li class="oneli">
                    <div class="onetitlewrap">
                        <div class="onetitle">年级团总支</div>
                        <img src="<%=request.getContextPath()%>/asset_admin_new/img/btndown.png" alt="" class="btndown" />
                        <div class="devide">
                            <div class="devideleft"></div>
                            <div class="devideright"></div>
                        </div>
                    </div>
                    <ul class="twoul">
                        <li>
                            ·
                            <a href="#">学校宣传引导</a>
                        </li>
                        <li>
                            ·
                            <a href="#">导入校内活动</a>
                        </li>
                        <li>
                            ·
                            <a href="#">学校活动管理</a>
                        </li>

                    </ul>
                </li>
                <li class="oneli">
                    <div class="onetitlewrap">
                        <div class="onetitle">班级</div>
                        <img src="<%=request.getContextPath()%>/asset_admin_new/img/btndown.png" alt="" class="btndown" />
                        <div class="devide">
                            <div class="devideleft"></div>
                            <div class="devideright"></div>
                        </div>
                    </div>
                    <ul class="twoul">
                        <li>
                            ·
                            <a href="#">学校宣传引导</a>
                        </li>

                    </ul>
                </li>
                <li class="oneli">
                    <div class="onetitlewrap">
                        <div class="onetitle">基本管理</div>
                        <img src="<%=request.getContextPath()%>/asset_admin_new/img/btndown.png" alt="" class="btndown" />
                        <div class="devide">
                            <div class="devideleft"></div>
                            <div class="devideright"></div>
                        </div>
                    </div>
                    <ul class="twoul">
                        <li>
                            ·
                            <a href="#">学校宣传引导</a>
                        </li>
                    </ul>
                </li>
            </ul>
        </div>
    </div>
    <div class="right">
        <!--选项卡-->
        <div class="tabs">
            <ul>
            </ul>
        </div>
        <div class="stuMsgManage">
            <!--功能栏-->
            <div class="function">
                <ul>
                    <li class="function_new"><span>新建</span></li>
                    <li class="function_edit"><span>修改</span></li>
                    <li class="function_remove"><span>删除</span></li>
                    <li class="function_refresh"><span>刷新</span></li>
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
                            <input type="text" />
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
                                    <li>项目培训1</li>
                                    <li>项目培训2</li>
                                    <li>项目培训3</li>
                                    <li>项目培训1</li>
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
                                    <li>项目培训1</li>
                                    <li>项目培训2</li>
                                    <li>项目培训3</li>
                                    <li>项目培训1</li>
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
                                    <li>项目培训1</li>
                                    <li>项目培训2</li>
                                    <li>项目培训3</li>
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
                            <input type="text" />
                        </li>
                        <li>
                            <span>房间号:</span>
                            <div>
                                <ul class="asSelect">
                                    <li>项目培训1</li>
                                    <li>项目培训1</li>
                                    <li>项目培训2</li>
                                    <li>项目培训3</li>
                                </ul>
                                <span></span>
                            </div>
                        </li>
                        <li>
                            <span>招生类别:</span>
                            <div>
                                <ul class="asSelect">
                                    <li>项目培训1</li>
                                    <li>项目培训1</li>
                                    <li>项目培训2</li>
                                    <li>项目培训3</li>
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
                                    <li>项目培训2</li>
                                    <li>项目培训3</li>
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
                                    <li>项目培训2</li>
                                    <li>项目培训3</li>
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
                                    <li>项目培训</li>
                                    <li>项目培训</li>
                                </ul>
                                <span></span>
                            </div>
                        </li>
                    </ul>
                </div>
                <p>注：因为数据经过加密的关系，所有列出条件均为精确匹配，输入的内容必须和数据库中的一致才可以匹配到结果</p>
                <div class="buttons">
                    <span class="clearAll">清空</span>
                    <span class="search">搜索</span>
                </div>
            </div>
            <!--结果集表格-->
            <div class="table">
                <table border="0" cellspacing="0" cellpadding="0">
                    <thead>
                    <tr>
                        <td></td>
                        <td>活动标题</td>
                        <td>活动标题</td>
                        <td>活动标题</td>
                        <td>活动标题</td>
                        <td>活动标题</td>
                        <td>活动标题</td>
                        <td>活动标题</td>
                        <td>活动标题</td>
                        <td>活动标题</td>
                        <td>活动标题</td>
                        <td>活动标题</td>
                        <td>活动标题</td>
                        <td>活动标题</td>
                        <td>活动标题</td>
                        <td>活动标题</td>
                        <td>活动标题</td>
                    </tr>
                    </thead>
                    <tbody>
                    <tr>
                        <td>1</td>
                        <td class="fontStyle">"颂歌给党"</td>
                        <td>学校</td>
                        <td>学校</td>
                        <td>学校</td>
                        <td>学校</td>
                        <td>学校</td>
                        <td>学校</td>
                        <td>学校</td>
                        <td>学校</td>
                        <td>学校</td>
                        <td>学校</td>
                        <td>学校</td>
                        <td>学校</td>
                        <td>学校</td>
                        <td>学校</td>
                        <td>学校</td>
                    </tr>
                    <tr>
                        <td>1</td>
                        <td class="fontStyle">"颂歌给党"</td>
                        <td>学校</td>
                        <td>学校</td>
                        <td>学校</td>
                        <td>学校</td>
                        <td>学校</td>
                        <td>学校</td>
                        <td>学校</td>
                        <td>学校</td>
                        <td>学校</td>
                        <td>学校</td>
                        <td>学校</td>
                        <td>学校</td>
                        <td>学校</td>
                        <td>学校</td>
                        <td>学校</td>
                    </tr>
                    <tr>
                        <td>1</td>
                        <td class="fontStyle">"颂歌给党"</td>
                        <td>学校</td>
                        <td>学校</td>
                        <td>学校</td>
                        <td>学校</td>
                        <td>学校</td>
                        <td>学校</td>
                        <td>学校</td>
                        <td>学校</td>
                        <td>学校</td>
                        <td>学校</td>
                        <td>学校</td>
                        <td>学校</td>
                        <td>学校</td>
                        <td>学校</td>
                        <td>学校</td>
                    </tr>
                    <tr>
                        <td>1</td>
                        <td class="fontStyle">"颂歌给党"</td>
                        <td>学校</td>
                        <td>学校</td>
                        <td>学校</td>
                        <td>学校</td>
                        <td>学校</td>
                        <td>学校</td>
                        <td>学校</td>
                        <td>学校</td>
                        <td>学校</td>
                        <td>学校</td>
                        <td>学校</td>
                        <td>学校</td>
                        <td>学校</td>
                        <td>学校</td>
                        <td>学校</td>
                    </tr>
                    <tr>
                        <td>1</td>
                        <td class="fontStyle">"颂歌给党"</td>
                        <td>学校</td>
                        <td>学校</td>
                        <td>学校</td>
                        <td>学校</td>
                        <td>学校</td>
                        <td>学校</td>
                        <td>学校</td>
                        <td>学校</td>
                        <td>学校</td>
                        <td>学校</td>
                        <td>学校</td>
                        <td>学校</td>
                        <td>学校</td>
                        <td>学校</td>
                        <td>学校</td>
                    </tr>
                    <tr>
                        <td>1</td>
                        <td class="fontStyle">"颂歌给党"</td>
                        <td>学校</td>
                        <td>学校</td>
                        <td>学校</td>
                        <td>学校</td>
                        <td>学校</td>
                        <td>学校</td>
                        <td>学校</td>
                        <td>学校</td>
                        <td>学校</td>
                        <td>学校</td>
                        <td>学校</td>
                        <td>学校</td>
                        <td>学校</td>
                        <td>学校</td>
                        <td>学校</td>
                    </tr>
                    <tr>
                        <td>1</td>
                        <td class="fontStyle">"颂歌给党"</td>
                        <td>学校</td>
                        <td>学校</td>
                        <td>学校</td>
                        <td>学校</td>
                        <td>学校</td>
                        <td>学校</td>
                        <td>学校</td>
                        <td>学校</td>
                        <td>学校</td>
                        <td>学校</td>
                        <td>学校</td>
                        <td>学校</td>
                        <td>学校</td>
                        <td>学校</td>
                        <td>学校</td>
                    </tr>
                    <tr>
                        <td>1</td>
                        <td class="fontStyle">"颂歌给党"</td>
                        <td>学校</td>
                        <td>学校</td>
                        <td>学校</td>
                        <td>学校</td>
                        <td>学校</td>
                        <td>学校</td>
                        <td>学校</td>
                        <td>学校</td>
                        <td>学校</td>
                        <td>学校</td>
                        <td>学校</td>
                        <td>学校</td>
                        <td>学校</td>
                        <td>学校</td>
                        <td>学校</td>
                    </tr>
                    <tr>
                        <td>1</td>
                        <td class="fontStyle">"颂歌给党"</td>
                        <td>学校</td>
                        <td>学校</td>
                        <td>学校</td>
                        <td>学校</td>
                        <td>学校</td>
                        <td>学校</td>
                        <td>学校</td>
                        <td>学校</td>
                        <td>学校</td>
                        <td>学校</td>
                        <td>学校</td>
                        <td>学校</td>
                        <td>学校</td>
                        <td>学校</td>
                        <td>学校</td>
                    </tr>
                    <tr>
                        <td>1</td>
                        <td class="fontStyle">"颂歌给党"</td>
                        <td>学校</td>
                        <td>学校</td>
                        <td>学校</td>
                        <td>学校</td>
                        <td>学校</td>
                        <td>学校</td>
                        <td>学校</td>
                        <td>学校</td>
                        <td>学校</td>
                        <td>学校</td>
                        <td>学校</td>
                        <td>学校</td>
                        <td>学校</td>
                        <td>学校</td>
                        <td>学校</td>
                    </tr>
                    <tr>
                        <td>1</td>
                        <td class="fontStyle">"颂歌给党"</td>
                        <td>学校</td>
                        <td>学校</td>
                        <td>学校</td>
                        <td>学校</td>
                        <td>学校</td>
                        <td>学校</td>
                        <td>学校</td>
                        <td>学校</td>
                        <td>学校</td>
                        <td>学校</td>
                        <td>学校</td>
                        <td>学校</td>
                        <td>学校</td>
                        <td>学校</td>
                        <td>学校</td>
                    </tr>
                    <tr>
                        <td>1</td>
                        <td class="fontStyle">"颂歌给党"</td>
                        <td>学校</td>
                        <td>学校</td>
                        <td>学校</td>
                        <td>学校</td>
                        <td>学校</td>
                        <td>学校</td>
                        <td>学校</td>
                        <td>学校</td>
                        <td>学校</td>
                        <td>学校</td>
                        <td>学校</td>
                        <td>学校</td>
                        <td>学校</td>
                        <td>学校</td>
                        <td>学校</td>
                    </tr>
                    <tr>
                        <td>1</td>
                        <td class="fontStyle">"颂歌给党"</td>
                        <td>学校</td>
                        <td>学校</td>
                        <td>学校</td>
                        <td>学校</td>
                        <td>学校</td>
                        <td>学校</td>
                        <td>学校</td>
                        <td>学校</td>
                        <td>学校</td>
                        <td>学校</td>
                        <td>学校</td>
                        <td>学校</td>
                        <td>学校</td>
                        <td>学校</td>
                        <td>学校</td>
                    </tr>
                    <tr>
                        <td>1</td>
                        <td class="fontStyle">"颂歌给党"</td>
                        <td>学校</td>
                        <td>学校</td>
                        <td>学校</td>
                        <td>学校</td>
                        <td>学校</td>
                        <td>学校</td>
                        <td>学校</td>
                        <td>学校</td>
                        <td>学校</td>
                        <td>学校</td>
                        <td>学校</td>
                        <td>学校</td>
                        <td>学校</td>
                        <td>学校</td>
                        <td>学校</td>
                    </tr>
                    <tr>
                        <td>1</td>
                        <td class="fontStyle">"颂歌给党"</td>
                        <td>学校</td>
                        <td>学校</td>
                        <td>学校</td>
                        <td>学校</td>
                        <td>学校</td>
                        <td>学校</td>
                        <td>学校</td>
                        <td>学校</td>
                        <td>学校</td>
                        <td>学校</td>
                        <td>学校</td>
                        <td>学校</td>
                        <td>学校</td>
                        <td>学校</td>
                        <td>学校</td>
                    </tr>
                    <tr>
                        <td>1</td>
                        <td class="fontStyle">"颂歌给党"</td>
                        <td>学校</td>
                        <td>学校</td>
                        <td>学校</td>
                        <td>学校</td>
                        <td>学校</td>
                        <td>学校</td>
                        <td>学校</td>
                        <td>学校</td>
                        <td>学校</td>
                        <td>学校</td>
                        <td>学校</td>
                        <td>学校</td>
                        <td>学校</td>
                        <td>学校</td>
                        <td>学校</td>
                    </tr>
                    <tr>
                        <td>1</td>
                        <td class="fontStyle">"颂歌给党"</td>
                        <td>学校</td>
                        <td>学校</td>
                        <td>学校</td>
                        <td>学校</td>
                        <td>学校</td>
                        <td>学校</td>
                        <td>学校</td>
                        <td>学校</td>
                        <td>学校</td>
                        <td>学校</td>
                        <td>学校</td>
                        <td>学校</td>
                        <td>学校</td>
                        <td>学校</td>
                        <td>学校</td>
                    </tr>
                    <tr>
                        <td>1</td>
                        <td class="fontStyle">"颂歌给党"</td>
                        <td>学校</td>
                        <td>学校</td>
                        <td>学校</td>
                        <td>学校</td>
                        <td>学校</td>
                        <td>学校</td>
                        <td>学校</td>
                        <td>学校</td>
                        <td>学校</td>
                        <td>学校</td>
                        <td>学校</td>
                        <td>学校</td>
                        <td>学校</td>
                        <td>学校</td>
                        <td>学校</td>
                    </tr>
                    </tbody>
                </table>
            </div>
            <div class="pagingTurn">
                <div>
                    <span class="turn_left"></span>
                    第
                    <span class="currentPageNum">2</span>
                    页，共
                    <span class="pageNum">5</span>
                    页
                    <span class="turn_right"></span>
                </div>
                <div>
                    显示1到<span class="pageNum">5</span>，共<span class="pageNum">5</span>条记录
                </div>
            </div>
        </div>
    </div>
</div>
<!--弹出框的层-->
<div class="popup"></div>
<!--新建窗口-->
<div class="new">
    <div class="header">
        <span>新建</span>
        <span class="iconConcel"></span>
    </div>
    <ul>
        <li>
            <span>活动标题&nbsp;&nbsp;:&nbsp;&nbsp;&nbsp;&nbsp;</span>
            <input type="text" />
        </li>
        <li>
            <span>活动标题&nbsp;&nbsp;:&nbsp;&nbsp;&nbsp;&nbsp;</span>
            <input type="text" />
        </li>
        <li>
            <span>活动标题&nbsp;&nbsp;:&nbsp;&nbsp;&nbsp;&nbsp;</span>
            <input type="text" />
        </li>
        <li>
            <span>活动标题&nbsp;&nbsp;:&nbsp;&nbsp;&nbsp;&nbsp;</span>
            <input type="text" />
        </li>
        <li>
            <span>能力标签&nbsp;&nbsp;:&nbsp;&nbsp;&nbsp;&nbsp;</span>
            <ul>
                <li>
                    <span></span>
                    <input type="checkbox" name="addAbility" value="思辨能力" />思辨能力
                </li>
                <li>
                    <span></span>
                    <input type="checkbox" name="addAbility" value="执行能力" />执行能力
                </li>
                <li>
                    <span></span>
                    <input type="checkbox" name="addAbility" value="执行能力" />执行能力
                </li>
                <li>
                    <span></span>
                    <input type="checkbox" name="addAbility" value="执行能力" />执行能力
                </li>
                <li>
                    <span></span>
                    <input type="checkbox" name="addAbility" value="执行能力" />执行能力
                </li>
                <li>
                    <span></span>
                    <input type="checkbox" name="addAbility" value="执行能力" />执行能力
                </li>
            </ul>
        </li>
    </ul>
    <div class="new_buttons">
        <input type="button" value="保存" />
        <input type="reset" value="取消" />
    </div>
</div>
</body>
</html>
