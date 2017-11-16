<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%--
  Created by IntelliJ IDEA.
  User: admin
  Date: 2016/9/10
  Time: 17:03
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01//EN"
"http://www.w3.org/TR/html4/strict.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" lang="en">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
    <!--兼容360浏览器，防止布局乱，设置IE的文档  模式为最高版本，并且如果存在chrome插件，自动使用Webkit引擎-->
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <title>个人中心</title>
    <link rel="Shortcut Icon" href="<%=request.getContextPath()%>/asset/image/neu.jpg" type="image/x-icon">
    <link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/asset_font_new/css/common.css"/>
    <link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/asset_font_new/css/commonhead.css"/>
    <link rel="stylesheet" href="<%=request.getContextPath()%>/asset_font/css/index.css" type="text/css"/>
    <link rel="stylesheet" href="<%=request.getContextPath()%>/asset_font_new/css/oneself_new.css" type="text/css"/>
    <link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/asset_font_new/css/all.css"/>
    <script type="text/javascript" src="<%=request.getContextPath()%>/asset/js/jquery-1.8.3.min.js"></script>
    <script src="<%=request.getContextPath()%>/asset/js/jquery.form.js" type="text/javascript" charset="utf-8"></script>
    <script type="text/javascript" src="<%=request.getContextPath()%>/asset/js/laydate/laydate.js"></script>
    <script type="text/javascript" src="<%=request.getContextPath()%>/asset/js/ajaxfileupload.js"></script>
    <script type="text/javascript" src="<%=request.getContextPath()%>/asset/layer/layer.js"></script>
    <script type="text/javascript" src="<%=request.getContextPath()%>/asset/js/jquery.md5.js"></script>
    <script src="<%=request.getContextPath()%>/asset_font_new/js/respond.js" type="text/javascript"
            charset="utf-8"></script>
    <script src="<%=request.getContextPath()%>/asset_font_new/js/index.js" type="text/javascript"
            charset="utf-8"></script>
    <!-- 引入 echarts.js -->
    <script type="text/javascript" src="<%=request.getContextPath()%>/asset_mobile/js/echarts.min.js"></script>
    <!-- 引入 echarts.css -->
    <link rel="stylesheet" href="<%=request.getContextPath()%>/asset_font/css/Radio2.css" type="text/css"/>
    <!--引入该页面js-->
    <script type="text/javascript" src="<%=request.getContextPath()%>/asset_font/js/index.js"></script>
    <script type="text/javascript" src="<%=request.getContextPath()%>/asset_font/js/index_jq.js"></script>
    <script type="text/javascript" src="<%=request.getContextPath()%>/asset_font/js/activity.js"></script>
    <script type="text/javascript" src="<%=request.getContextPath()%>/asset_font/js/oneself.js"></script>
    <style type="text/css ">
        .secondClassMsgContent .person_analyze {
            height: 410px;
        }

        .secondClassMsgContent .person_analyze .person_MsgContent .person_msg .person_msg_item span {
            display: inline;
        }

        .show {
            margin-left: 4.2rem;
            margin-top: 0.4rem;
        }

        .img_box {
            display: inline-block;
            background: #ffffff;
            width: 4rem;
            margin: 0.15rem;
            height: 4rem;
            padding: 1px;
            border: 1px solid #1990FE;
            text-align: center;
            line-height: 4rem;
        }

        .up_img {
            width: auto !important;
            height: auto;
            max-width: 99%;
            max-height: 99%;
            margin: auto auto;
            vertical-align: middle;
        }

        .btn_add {
            width: 28px;
            height: 28px;
            display: inline-block;
            position: relative;
            top: -3px;
        }
    </style>

    <script type="text/javascript">
        var key = 3;
        var canEdit = true; //是否可修改标志位
        var submitState = 0;//防止重复提交
        $(function () {
            refreshCountPoint();
            var loginId = '<%=session.getAttribute("loginId")%>';
            //选择照片
            $("#upimg_btn").click(choose());
            function choose() {
                var upimg = document.getElementById('upimg_btn');
                var show = document.getElementById('show');

                if (!(window.FileReader && window.File && window.FileList && window.Blob)) {
                    layer.alert('您的浏览器不支持fileReader，建议使用ie10+浏览器或者谷歌浏览器', {offset: ['30%']});
                    upimg.setAttribute('disabled', 'disabled');
                    return false;
                }
                upimg.addEventListener('change', function (e) {//addEventListener 为 <button> 元素添加点击事件
                    var files = this.files;
                    if (files.length > 0 && files.length <= 8) {
                        // 对文件进行处理，下面会讲解checkFile()会做什么
                        checkFile(this.files);
                    } else if (files.length > 8) {
                        show.innerHTML = "";
                        this.files = null;
                        layer.msg("请选择少于8张图片", {offset: ['30%']});
                    } else {
                        show.innerHTML = "";
                    }
                });
            }

            function checkFile(files) {
                var html = '', i = 0;
                var func = function () {
                    if (i > files.length - 1) {
                        // 若已经读取完毕，则把html添加页面中
                        show.innerHTML = html;
                        return;
                    }
                    var file = files[i];
                    var reader = new FileReader();

                    // show表示<div id='show'></div>，用来展示图片预览的
                    if (!/image\/\w+/.test(file.type)) {
                        show.innerHTML = "请确保文件为图像类型";
                        return false;
                    }
                    reader.onload = function (e) {
                        html += '<div class="img_box"><img  class="up_img" src="' + e.target.result + '" alt="img"></div>';
                        i++;
                        func(); //选取下一张图片
                    };
                    reader.readAsDataURL(file);
                };
                func();
            }

            /**
             * 提交表单
             */
            $("#form1").ajaxForm({
                beforeSerialize: function () {
                    if (!$("#activityClass").val()) {
                        layer.msg("表单填写不完整", {offset: ['30%']});
                        return false
                    }
                },
                dataType: "json",
                success: function (data) {
                    layer.closeAll();
                    firstChoose(0);
                    $("#form1").clearForm();
                    $("#form1").resetForm();
                    $("#show").html("");
                    if (data.status == 0) {
                        layer.msg("提交成功", {offset: ['30%']});
                        $(".window_selectMsg").hide();
                        $(".window_Greybg").hide();
                        submitState = 0;
                        selectInfor();//重新加载数据
                        if (data.data && data.data.length > 0) {
                            var resutl = "";
                            for (var i = 0; i < data.data.length; i++) {
                                result = resutl + data.data[i] + ",";
                            }
                            if (resutl.length > 0) {
                                $(".window_selectMsg").hide();
                                $(".window_Greybg").hide();
                            }
                            layer.alert("未上传成功文件：" + resutl.substring(0, resutl.length - 1), {offset: ['30%']});
                        }
                    }
                },
                error: function () {
                    $(".window_selectMsg").hide();
                    $(".window_Greybg").hide();
                    layer.closeAll();
                    layer.msg("服务器连接失败，请稍后再试", {offset: ['30%']});
                    submitState = 0;
                }
            });
            //加载六大类活动总分数
            $.ajax({
                url: "/jsons/loadActivityScoreTotal.form",
                type: "post",
                dataType: "json",
                success: function (data) {
                    if (data.rows.length > 0) {
                        for (var i = 0; i < data.rows.length; i++) {
                            var item = data.rows[i];
                            if (item.dict_mean == '思想政治教育类') {
                                $('.score_get1').html('必修学分' + item.dict_score);
                            }
                            if (item.dict_mean == '能力素质拓展类') {
                                $('.score_get2').html('必修学分' + item.dict_score);
                            }
                            if (item.dict_mean == '学术科技与创新创业类') {
                                $('.score_get3').html('必修学分' + item.dict_score);
                            }
                            if (item.dict_mean == '社会实践与志愿服务类') {
                                $('.score_get4').html('必修学分' + item.dict_score);
                            }
                            if (item.dict_mean == '社会工作与技能培训类') {
                                $('.score_get5').html('非必修类');
                            }
                            if (item.dict_mean == '综合奖励及其他类') {
                                $('.score_get6').html('非必修类');
                            }
                        }
                    }
                },
                error: function (XMLHttpRequest, textStatus, errorThrown) {
                    layer.msg("服务器连接失败，请稍后再试")
                }
            });
            //加载六大类活动已获得分数
            var score1 = 0, score2 = 0, score3 = 0, score4 = 0, score5 = 0, score6 = 0,hours = 0;
            $('.score_total1').html('已修学分0');
            $('.score_total2').html('已修学分0');
            $('.score_total3').html('已修学分0');
            $('.score_total4').html('已修学分0');
            $('.score_total5').html('不参与计分');
            $('.score_total6').html('已修学分0');
            var url = "s/loadActivityScoreGe";
            $.ajax({
                url: "/jsons/loadActivityScoreGet.form",
                type: "post",
                data: {loginId: loginId},
                dataType: "json",
                async: false,
                success: function (data) {
                    if (data.rows.length > 0) {
                        for (var i = 0; i < data.rows.length; i++) {
                            var item = data.rows[i];
                            var activityCredit = item.activityCredit ? parseFloat(item.activityCredit) : 0;
                            if (item.dict_mean == '思想政治教育类') {
                                score1 += activityCredit;
                                if (score1 != 0) {
                                    $('.score_total1').html('已修学分' + score1);
                                }
                            }
                            if (item.dict_mean == '能力素质拓展类') {
                                score2 += activityCredit;
                                if (score2 != 0) {
                                    $('.score_total2').html('已修学分' + score2);
                                }
                            }
                            if (item.dict_mean == '学术科技与创新创业类') {
                                score3 += activityCredit;
                                if (score3 != 0) {
                                    $('.score_total3').html('已修学分' + score3);
                                }
                            }
                            if (item.dict_mean == '社会实践与志愿服务类') {
                                if(item.supWorktime == null || item.supWorktime == ''){
                                    score4 += activityCredit;
                                    continue;
                                }
                                var worktime=(item.supWorktime ? item.supWorktime.indexOf("小时")>0 ? item.supWorktime : item.supWorktime+"小时" : "");
                                //计算志愿服务总时长
                                var tim=0;
                                if(worktime.indexOf("天")>0){
                                    tim=worktime.replace("天","");
                                    var time=parseFloat(tim)*24;
                                    hours+=(isNaN(time) ? 0 : time);
                                }
                                if(worktime.indexOf("小时")>0){
                                    tim=worktime.replace("小时","");
                                    hours+=(isNaN(parseFloat(tim)) ? 0 : parseFloat(tim));
                                }
                            }
                            if (item.dict_mean == '社会工作与技能培训类') {
                                score5 += activityCredit;
                                if (score5 != 0) {
                                    $('.score_total5').html('已修学分' + score5);
                                }
                            }
                            if (item.dict_mean == '综合奖励及其他类') {
                                score6 += activityCredit;
                                if (score6 != 0) {
                                    $('.score_total6').html('不参与计分');
                                }
                            }
                        }
                    }
                },
                error: function (XMLHttpRequest, textStatus, errorThrown) {
                    layer.msg("服务器连接失败，请稍后再试")
                }
            });
            //已获得得分 （学生自己添加的）
            $.ajax({
                url: "/jsons/loadActivityScoreGets.form",
                type: "post",
                data: {loginId: loginId},
                dataType: "json",
                async: false,
                success: function (data) {
                    if (data.rows.length > 0) {
                        for (var i = 0; i < data.rows.length; i++) {
                            var item = data.rows[i];
                            var activityCredit = item.supCredit ? parseFloat(item.supCredit) : 0;
                            if (item.dict_mean == '思想政治教育类') {
                                if (item.supType == '主题团日')
                                    continue;
                                score1 += activityCredit;
                                if (score1 != 0) {
                                    $('.score_total1').html('已修学分' + score1);
                                }
                            }
                            if (item.dict_mean == '能力素质拓展类') {
                                score2 += activityCredit;
                                if (score2 != 0) {
                                    $('.score_total2').html('已修学分' + score2);
                                }
                            }
                            if (item.dict_mean == '学术科技与创新创业类') {
                                score3 += activityCredit;
                                if (score3 != 0) {
                                    $('.score_total3').html('已修学分' + score3);
                                }
                            }
                            if (item.dict_mean == '社会实践与志愿服务类') {
                                if(item.supWorktime == null || item.supWorktime == ''){
                                    score4 += activityCredit;
                                    continue;
                                }

                                var worktime=(item.supWorktime ? item.supWorktime.indexOf("小时")>0 ? item.supWorktime : item.supWorktime+"小时" : "");
                                //计算志愿服务总时长
                                var tim=0;
                                if(worktime.indexOf("天")>0){
                                    tim=worktime.replace("天","");
                                    var time=parseFloat(tim)*24;
                                    hours+=(isNaN(time) ? 0 : time);
                                }
                                if(worktime.indexOf("小时")>0){
                                    tim=worktime.replace("小时","");
                                    hours+=(isNaN(parseFloat(tim)) ? 0 : parseFloat(tim));
                                }
                            }
                            if (item.dict_mean == '社会工作与技能培训类') {
                                score5 += activityCredit;
                                if (score5 != 0) {
                                    $('.score_total5').html('已修学分' + score5);
                                }
                            }
                            if (item.dict_mean == '综合奖励及其他类') {
                                score6 += activityCredit;
                                if (score6 != 0) {
                                    $('.score_total6').html('不参与计分');
                                }
                            }
                        }
                    }
                },
                error: function (XMLHttpRequest, textStatus, errorThrown) {
                    layer.msg("服务器连接失败，请稍后再试")
                }
            });

            if(hours > 0){
                score4+= (Math.round((hours/12)*100)/100);
            }
            if (score4 != 0) {
                $('.score_total4').html('已修学分' + score4);
            }
        });

        /**
         * 计算学生六项能力分数
         * 进入页面加载运行
         *
         */

        function refreshCountPoint() {
            $.ajax({
                url: "/printTranscript/countPoint.form",
                type: "post",
                data: {applyid: "564321326448131"}, //随便写的id 没用的参数
                async: false,
                success: function (data) {
                    //layer.alert("六项能力成功更新!",{offset:['30%'] });
                }
            });
        }

        function SavePrint() {
            /**
             * 取出选中的数据
             */
            var len01 = $("#aClass input:checkbox").length;
            var len02 = $("#bClass input:checkbox").length;
            var len03 = $("#cClass input:checkbox").length;
            var len04 = $("#dClass input:checkbox").length;
            var len05 = $("#eClass input:checkbox").length;
            var len06 = $("#fClass input:checkbox").length;

            var len1 = $("#aClass input:checkbox:checked").length;
            var len2 = $("#bClass input:checkbox:checked").length;
            var len3 = $("#cClass input:checkbox:checked").length;
            var len4 = $("#dClass input:checkbox:checked").length;
            var len5 = $("#eClass input:checkbox:checked").length;
            var len6 = $("#fClass input:checkbox:checked").length;
            if (len1 + len2 + len3 > 12) {
                layer.msg("前三大类活动总和不能超过12个,请重新选择", {offset: ['30%']});
                return false;
            }
            if (len4 + len5 + len6 > 12) {
                layer.msg("后三大类活动总和不能超过12个,请重新选择", {offset: ['30%']});
                return false;
            }

            var a = len01 > 0 && len1 < 1;
            var b = len02 > 0 && len2 < 1;
            var c = len03 > 0 && len3 < 1;
            var d = len04 > 0 && len4 < 1;
            var e = len05 > 0 && len5 < 1;
            var f = len06 > 0 && len6 < 1;

            if ((len01 > 0 && len1 < 1) || (len02 > 0 && len2 < 1) || (len03 > 0 && len3 < 1) || (len04 > 0 && len4 < 1) || (len05 > 0 && len5 < 1) || (len06 > 0 && len6 < 1)) {
                layer.msg("每类至少选择一项", {offset: ['30%']});
                return false;
            }
            var newThemeActivity = [];
            $('input:checkbox:checked').each(function () {
                var row = $(this).parent().parent().data();
                if (typeof (row.applyId) == "undefined") {
                    for (var n in row) {
                        newThemeActivity.push(row[n])
                    }
                } else {
                    applyID += row.applyId + "|";
                }
            });
            var themeapplyID = "";
            for (var i = 0; i < newThemeActivity.length; i++) {
                themeapplyID += newThemeActivity[i].applyId + "|";
            }
            themeapplyID = themeapplyID.substring(0, themeapplyID.length - 1);
            newapplyID = applyID.substring(0, applyID.length - 1);
            if (newapplyID != null && newapplyID != "") {
                $.ajax({
                    type: "post",
                    async: false,
                    url: "/printTranscript/setPrint.form",
                    data: {applyid: newapplyID, themeapplyID: themeapplyID},
                    dataType: "json",
                    success: function (data) {
                        if (data.result) {
                            layer.msg("发送打印预览成功!", {offset: ['30%']});
                            countPoint(newapplyID);
                        } else {
                            layer.msg("发送打印请求失败!", {offset: ['30%']});
                        }
                    },
                    error: function () {
                        layer.msg("发送打印请求失败!", {offset: ['30%']});
                    }
                });
            } else {
                layer.msg("请选择活动", {offset: ['30%']});
                return false;
            }
        }
        function countPoint(newapplyID) {
            var myChart = echarts.init(document.getElementById('charts'));
            $.ajax({
                url: "/printTranscript/countPoint.form",
                data: {applyid: newapplyID},
                type: "post",
                dataType: "json",
                async: false,
                success: function (data) {
                    if (data != null && data != "") {
                        // 同步加载数据
                        $.ajax({
                            type: "post",
                            async: false,
                            url: "/char/loadSixElementPoint.form",
                            dataType: "json",
                            success: function (data) {
                                //因为applyID是全局变量为了不影响上面赋值 这里清空
                                applyID = "";
                                // 获得拼穿值
                                var years = generYears(data);
                                var servies = gennerData(data);
                                // 给option对应地方赋值
                                option.legend.data = eval(years);
                                option.series = eval(servies);
                                //先清空之前的数据
                                myChart.clear();
                                // 使用刚指定的配置项和数据显示图表。
                                myChart.setOption(option);
                                layer.msg("图表更新成功!", {offset: ['30%']});
                                insetToSort(newapplyID);
                            },
                            error: function () {
                                layer.msg("图表更新失败!", {offset: ['30%']});
                            }
                        });
                    }
                },
                error: function () {
                    layer.msg("发送打印预览失败!", {offset: ['30%']});
                }
            })
        }
        function apply(type) {
            canEdit = true;
            $(".window_selectMsg").show();
            $(".window_Greybg").show();
            $("#activityClass").removeAttr("disabled");
            $("#supType").removeAttr("disabled");
            firstChoose(0);
        }
//        setTimeout(function () {
//            if ($("#picture").attr("src").length < 3) {
//                $("#picture").attr("src", "../../Files/Images/default.jpg")
//            }
//        }, 200)
        window.onresize = function () {
        }
        $(function () {
            $(".title img").click(function () {
                $(this).parent().parent().hide(200);
                $(".window_Greybg").slideUp(200);
            });
            $("#dClass").find("tr td").eq(5).width("15%");
        })
    </script>
    <style type="text/css">
        .secondClassMsgContent .person_analyze {
            height: 340px;
        }

        .secondClassMsgContent .person_analyze .person_MsgContent .person_msg .person_msg_item span {
            display: inline;
        }

        @media screen and (min-width: 1680px) {
            .person_MsgContent .changeMsg {
                left: 500px;
            }

            .person_MsgContent .change_picture {
                left: 500px;
            }

            .person_MsgContent .change_pwd {
                left: 500px;
            }
        }

        @media screen and (max-width: 1680px) {
            .person_MsgContent .changeMsg {
                left: 450px;
            }

            .person_MsgContent .change_picture {
                left: 450px;
            }

            .person_MsgContent .change_pwd {
                left: 450px;
            }
        }

        .show {
            margin-left: 4.2rem;
            margin-top: 0.4rem;
        }

        .img_box {
            display: inline-block;
            background: #ffffff;
            width: 4rem;
            margin: 0.15rem;
            height: 4rem;
            padding: 1px;
            border: 1px solid #1990FE;
            text-align: center;
            line-height: 4rem;
        }

        .up_img {
            width: auto !important;
            height: auto;
            max-width: 99%;
            max-height: 99%;
            margin: auto auto;
            vertical-align: middle;
        }

        .item {
            padding: 3px 5px;
            cursor: pointer;
            background: #f9f9f9;
            /*border: 1px solid  #87A900;*/
        }

        .addbg {
            background: #fff !important;
        }

        #append {
            height: auto !important;
            border: solid #1990FE 2px;
            border-top: 0;
            margin-left: 475px;
            display: none;
            position: relative;
            z-index: 999;
        }

        #append > div:hover {
            background: #1990FE !important;
        }

        .center_cen_content_put {
            position: relative;
            z-index: 0;
        }

        table {
            table-layout: fixed;
        }

        td {
            height: 47px !important;
            line-height: 22px !important;
            padding: 5px 10px !important;
        }

        .center_cen_content_put.Activity {
            min-height: 44px;
            height: auto !important;
        }

        .center_cen_content_put.Activity .child {
            width: 284px;
            display: inline-block;
        }

        .center_cen_content_put.Activity .child > span {
            float: left;
            height: 62px;
            margin-right: 10px;
        }

        .center_cen_content_put.Activity .child input {
            width: 25px;
        }

        .window_selectMsg {
            text-align: left !important;
        }

        .center_cen_content_put {
            margin-left: 20px !important;
        }

        .smchange, .smdele {
            width: 20px;
            vertical-align: middle;
            margin: 0 5px;
            display: inline-block;
        }
    </style>
    <script type="text/javascript">
        var datas = [];
        //自动补全脚本
        $(document).ready(function () {
            $.ajax({
                url: '/jsons/loadActivityTitle.form',
                type: "post",
                dataType: "json",
                success: function (data) {
                    if (data != null && data.rows.length > 0) {
                        for (var i = 0; i < data.rows.length; i++) {
                            datas[i] = data.rows[i];
                        }
                    }
                }
            });
            //keydown事件
            $(document).keydown(function (e) {
                e = e || window.event;
                var keycode = e.which ? e.which : e.keyCode;
                if (keycode == 38) {
                    if (jQuery.trim($("#append").html()) == "") {
                        return;
                    }
                    movePrev();
                } else if (keycode == 40) {
                    if (jQuery.trim($("#append").html()) == "") {
                        return;
                    }
                    $("#supActivityTitle").blur();
                    if ($(".item").hasClass("addbg")) {
                        moveNext();
                    } else {
                        $(".item").removeClass('addbg').eq(0).addClass('addbg');
                    }

                } else if (keycode == 13) {
                    dojob();
                }
            });
            //失焦事件
            var movePrev = function () {
                $("#supActivityTitle").blur();
                var index = $(".addbg").prevAll().length;
                if (index == 0) {
                    $(".item").removeClass('addbg').eq($(".item").length - 1).addClass('addbg');
                } else {
                    $(".item").removeClass('addbg').eq(index - 1).addClass('addbg');
                }
            };

            var moveNext = function () {
                var index = $(".addbg").prevAll().length;
                if (index == $(".item").length - 1) {
                    $(".item").removeClass('addbg').eq(0).addClass('addbg');
                } else {
                    $(".item").removeClass('addbg').eq(index + 1).addClass('addbg');
                }
            };
            //动态赋值
            var dojob = function () {
                $("#supActivityTitle").blur();
                var value = $(".addbg").text();
                $("#supActivityTitle").val(value);
                $("#append").hide().html("");
            }
        });
        function getContent(obj) {
            var supActivityTitle = jQuery.trim($(obj).val());
            if (supActivityTitle == "") {
                $("#append").hide().html("");
                return false;
            }
            var html = "";
            for (var i = 0; i < datas.length; i++) {
                if (datas[i].indexOf(supActivityTitle) >= 0) {
                    html = html + "<div class='item' onmouseenter='getFocus(this)' onClick='getCon(this);'>" + datas[i] + "</div>"
                }
            }
            if (html != "") {
                $("#append").show().html(html);
            } else {
                $("#append").hide().html("");
            }
        }
        function getFocus(obj) {
            $(".item").removeClass("addbg");
            $(obj).addClass("addbg");
        }
        function getCon(obj) {
            var value = $(obj).text();
            $("#supActivityTitle").val(value);
            $("#append").hide().html("");
        }
        $(function () {
            $(".center_cen_content_put").click(function () {
                $(this).css("z-index", "100");
                $(this).siblings(".center_cen_content_put").css("z-index", "1");
            })
        })
    </script>
    <style>
        .new_window {
            height: 60vh;
            z-index: 9999;
            position: fixed;
            top: 20vh;
            left: 50%;
            margin-left: -250px;
            width: 500px;
            background: #fff;
            border: 1px solid #5c85ee;
            display: none;
            border-top: 47px solid #5c85ee;
        }

        .new_window > div {
            padding-top: 30px;
            padding-bottom: 30px;
            overflow-y: auto;
            max-height: 490px;
            height: 100%;
            -webkit-box-sizing: border-box;
            -moz-box-sizing: border-box;
            box-sizing: border-box;
        }

        .new_window span {
            display: inline-block;
            width: 100px;
            text-align: left;
            vertical-align: middle;
            margin-bottom: 20px;
            margin-left: 50px;
            font-size: 14px;
        }

        .new_window input {
            width: 225px;
            height: 28px;
            font-size: 14px;
            outline: none;
            border: 1px solid #5c85ee;
            vertical-align: middle;
            margin-bottom: 20px;
            padding: 0 3px;
        }

        #studentPhotos {
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            opacity: 0;
            -ms-filter: progid:DXImageTransform.Microsoft.Alpha(Opacity=0);
            filter: progid:DXImageTransform.Microsoft.Alpha(Opacity=0);
        }

        .spbox {
            text-align: center;
        }

        .spbox div {
            width: 120px;
            height: 160px;
            margin: 0 auto 20px;
            margin-left: 155px;
            position: relative;
            border: 1px solid #5c85ee;
        }

        .spbox img {
            width: 100%;
            height: 100%;
        }

        .new_window button {
            width: 80px;
            height: 30px;
            font-size: 14px;
            color: #fff;
            background: #5c85ee;
            border: none;
            outline: none;
            cursor: pointer;
            margin: 0 10px;
        }

        .btn_box {
            text-align: center;
        }
    </style>
</head>
<body>
<%@include file="header_new.jsp" %>
<%--判断是否是登录状态--%>
<%@include file="../common/CheckLogin.jsp" %>
<div class="secondClassMsgContent">
    <a class="return" href="javascript:history.go(-1);">返回</a>
    <span class="personMsg">>个人中心</span>
    <div class="person_analyze">
        <!--个人信息板块-->
        <div class="person_MsgContent">
            <img id="picture" class="person_picture" src=""
                 onerror="error=null;src='<%=request.getContextPath()%>/Files/Images/default.jpg'"/>
            <ul class="person_msg" id="information" onerror="error=null;src='/Files/Images/default.jpg'">
            </ul>
            <span id="changeInfo">
                修改信息
            </span>
        </div>
        <div class="reck">
            <!--能力模型图-->
            <div id="posi">
                <ul>
                    <li><img src="<%=request.getContextPath()%>/asset_font/img/sibian.png"/></li>
                    <li><img src="<%=request.getContextPath()%>/asset_font/img/chuangye.png"/></li>
                    <li><img src="<%=request.getContextPath()%>/asset_font/img/chuangxin.png"/></li>
                    <li><img src="<%=request.getContextPath()%>/asset_font/img/lingdao.png"/></li>
                    <li><img src="<%=request.getContextPath()%>/asset_font/img/biaoda.png"/></li>
                    <li><img src="<%=request.getContextPath()%>/asset_font/img/zhixing.png"/></li>
                </ul>
                <div id="charts" class="statistical_graph" style="height: 400px;margin-top:-90px;">
                </div>
            </div>
            <!---我的能力分数-->
            <ul class="mynum">
                <li>
                    <b>表达</b>
                    <div style="width: 50%;background: #df7071" class="mynum-div"><span class="mynum-span">50</span>
                    </div>
                    <%--这个能力分数的长度就是分数的百分比值--%>
                </li>
                <li>
                    <b>执行</b>
                    <div style="width: 50%;background: #799dd2" class="mynum-div"><span class="mynum-span">50</span>
                    </div>
                    <%--这个能力分数的长度就是分数的百分比值--%>
                </li>
                <li>
                    <b>思辨</b>
                    <div style="width: 50%;background: #b0d479" class="mynum-div"><span class="mynum-span">50</span>
                    </div>
                    <%--这个能力分数的长度就是分数的百分比值 注意颜色我也写行内样式里了 区分开 别就把第一个循环了--%>
                </li>
                <li>
                    <b>领导</b>
                    <div style="width:50%;background: #e79777" class="mynum-div"><span class="mynum-span">50</span>
                    </div>
                    <%--这个能力分数的长度就是分数的百分比值--%>
                </li>
                <li>
                    <b>创新</b>
                    <div style="width: 50%;background: #d97fb1" class="mynum-div"><span class="mynum-span">50</span>
                    </div>
                    <%--这个能力分数的长度就是分数的百分比值--%>
                </li>
                <li>
                    <b>创业</b>
                    <div style="width: 50%;background: #84cee6" class="mynum-div"><span class="mynum-span">50</span>
                    </div>
                    <%--这个能力分数的长度就是分数的百分比值--%>
                </li>

            </ul>
        </div>
    </div>
    <!--成绩单-->
    <ul class="grade_list">
        <li class="grade_list_item">
            <div class="titleYellowBlock"></div>
            <span class="itemName">项目类别&nbsp;:&nbsp;思想政治教育类</span>
            <div class="box">
                <span class="score_get1"></span>&nbsp;&nbsp;/<span class="score_total1"></span>
            </div>
            <a href='javascript:void(0);' onclick="apply(1)" class="apply_text">
                <img class="btn_add"
                     style="width: 28px ;height: 28px ;display: inline-block ;margin-top: -7px;margin-left: 10px;"
                     src="<%=request.getContextPath()%>/asset_font_new/img/icon_add.png"/>
            </a>
            <span></span>
            <table cellspacing="2px" class="grade_list_item_table" border="1" id="aClass">
                <tr>
                    <td style="width: 130px">2016下学期</td>
                    <td style="width: auto">主题团日</td>
                    <td style="width: 75px">校级</td>
                    <td style="width: 75px">1</td>
                    <td style="width: auto">一等奖</td>
                    <td style="width: 90px"><input type="checkbox"></td>
                </tr>
                <tr class="spacel">
                    <td style="width: 130px">2016下学期</td>
                    <td style="width: auto">
                        <span>主题团日<button></button></span>
                    </td>
                    <td style="width: 75px">校级</td>
                    <td style="width: 75px">1</td>
                    <td style="width: auto">一等奖</td>
                    <td style="width: 90px"><input type="checkbox"></td>
                </tr>
            </table>
        </li>
        <li class="grade_list_item">
            <div class="titleYellowBlock"></div>
            <span class="itemName">项目类别&nbsp;:&nbsp;能力素质拓展类</span>
            <div class="box">
                <span class="score_get2"></span>&nbsp;&nbsp;/<span class="score_total2"></span>
            </div>
            <a href='javascript:void(0);' onclick="apply(1)" class="apply_text">
                <img class="btn_add"
                     style="width: 28px ;height: 28px ;display: inline-block ;margin-top: -7px;margin-left: 10px;"
                     src="<%=request.getContextPath()%>/asset_font_new/img/icon_add.png"/>
            </a>
            <table cellspacing="2px" class="grade_list_item_table" border="1" id="bClass">
            </table>
        </li>
        <li class="grade_list_item">
            <div class="titleYellowBlock"></div>
            <span class="itemName">项目类别&nbsp;:&nbsp;学术科技与创新创业类</span>
            <div class="box">
                <span class="score_get3"></span>&nbsp;&nbsp;/<span class="score_total3"></span>
            </div>
            <a href='javascript:void(0);' onclick="apply(1)" class="apply_text">
                <img class="btn_add"
                     style="width: 28px ;height: 28px ;display: inline-block ;margin-top: -7px;margin-left: 10px;"
                     src="<%=request.getContextPath()%>/asset_font_new/img/icon_add.png"/>
            </a>
            <table cellspacing="2px" class="grade_list_item_table" border="1" id="cClass">
            </table>
        </li>
        <li class="grade_list_item">
            <div class="titleYellowBlock"></div>
            <span class="itemName">项目类别&nbsp;:&nbsp;社会实践与志愿服务类</span>
            <div class="box">
                <span class="score_get4"></span>&nbsp;&nbsp;/<span class="score_total4"></span>
            </div>
            <a href='javascript:void(0);' onclick="apply(1)" class="apply_text">
                <img class="btn_add"
                     style="width: 28px ;height: 28px ;display: inline-block ;margin-top: -7px;margin-left: 10px;"
                     src="<%=request.getContextPath()%>/asset_font_new/img/icon_add.png"/>
            </a>
            <table cellspacing="2px" class="grade_list_item_table" border="1" id="dClass">

            </table>
        </li>
        <li class="grade_list_item">
            <div class="titleYellowBlock"></div>
            <span class="itemName">项目类别&nbsp;:&nbsp;社会工作与技能培训类</span>

            <a href='javascript:void(0);' onclick="apply(1)" class="apply_text">
                <img class="btn_add"
                     style="width: 28px ;height: 28px ;display: inline-block ;margin-top: -7px;margin-left: 10px;"
                     src="<%=request.getContextPath()%>/asset_font_new/img/icon_add.png"/>
            </a>
            <table cellspacing="2px" class="grade_list_item_table" border="1" id="eClass">

            </table>
        </li>
        <li class="grade_list_item">
            <div class="titleYellowBlock"></div>
            <span class="itemName">项目类别&nbsp;:&nbsp;综合奖励及其它类</span>

            <a href='javascript:void(0);' onclick="apply(1)" class="apply_text">
                <img class="btn_add"
                     style="width: 28px ;height: 28px ;display: inline-block ;margin-top: -7px;margin-left: 10px;"
                     src="<%=request.getContextPath()%>/asset_font_new/img/icon_add.png"/>
            </a>
            <table cellspacing="2px" class="grade_list_item_table" border="1" id="fClass">
            </table>
        </li>
        <li class="grade_list_item" style="margin-top: 85px">
            <input style="display: block;font-size: 14px;color: #fff;background-color: #5c85ee;border: 0;cursor: pointer;width: 90px;height: 30px;margin:0 auto;"
                   type="button" value="预览成绩单" onclick="SavePrint()"/>
        </li>
    </ul>
</div>
<!--修改信息弹框-->
<div class="window_Greybg">

</div>
<div class="new_window" hidden>
    <p class="title1">修改信息 <img src="../../../asset_font_new/img/windowclose_03.png" alt=""></p>
    <div>
        <div class="spbox">
            <span class="input_name" style="float: left;">头像<br/>(点击修改)</span>
            <div>
                <img id="newpicture" src="<%=request.getContextPath()%>/Files/Images/default.jpg"
                     onerror="error=null;src='/Files/Images/default.jpg'"/>
                <input type="file" id="studentPhotos" name="studentPhot" onchange='preview(this)'/>
                <input type="hidden" id="studentPhoto">
            </div>
        </div>
        <span class="input_name beforePwd passwd">原密码</span>
        <input class="beforePwd_text" type="password" id="old_pwd"/>
        <span class="input_name newPwd">新密码</span>
        <input class="newPwd_text" type="password" id="pwd"/>
        <span class="input_name confirmNewPwd">确认新密码</span>
        <input class="confirmNewPwd_text" type="password" id="repwd"/>
        <span class="input_name">联系方式</span>
        <input type="text" id="studentPhone"/>
        <div class="btn_box">
            <button class="confirm window_changePwd_confirm" id="updataPwd">确认</button>
            <button class="confirm1 window_changePwd_confirm" id="updataPwd1">取消</button>
        </div>
    </div>
</div>
<%--主题团日弹窗--%>
<div class="stuWindow">
    <b></b>
    <ol id="zhutituan_detail_box">
        <!---循环ol  每个ol是一列-->
        <ol>
            <li class="first">
                <p>名称</p>
                <span>东北大学演说家大赛</span>
            </li>
            <li class="secound">
                <p>时间</p>
                <span>2017年1月22日</span>
            </li>
            <li class="third">
                <p>能力</p>
                <span>表达、创新、创业</span>
            </li>
        </ol>
    </ol>
    <button>确认</button>
</div>
<script type="text/javascript">
    $(function () {
        //点击加号时，页面禁止滚动
        $('.btn_add').click(function () {
            $(document.body).css({
                "overflow-x": "hidden",
                "overflow-y": "hidden"
            });
        });
        //退出弹窗时，页面自由滚动
        $('#buttones1').click(function () {
            $(document.body).css({
                "overflow-x": "auto",
                "overflow-y": "auto"
            });
        });

        //退出弹窗时，页面自由滚动
        $('#submit').click(function () {
            $(document.body).css({
                "overflow-x": "auto",
                "overflow-y": "auto"
            });
        });
        $(".otherAward").hide();
        $(".orgcollege").hide();
        $(".supAward").change(function () {
            if ($(this).val() == "其它") {
                $(".otherAward").show();
            } else {
                $(".otherAward").hide();
            }
        });
        $("#workClass").change(function () {
            if ($(this).val() == "学院组织") {
                $(".orgcollege").show();
                $("#orgcollege").val(collegename);
                loadorg(collegename);
                return;
            } else {
                $(".orgcollege").hide();
            }
            if ($(this).val() != "学校组织") {
                loadorg($(this).val());
                return;
            }
            if ($(this).val() != "社团") {
                loadorg($(this).val());
                return;
            }
        });
        //至少选择一个
        $(".qx_check").click(function () {
            var qxs = $(".qx_check:checked");
            if (qxs.length > 3) {
                layer.alert("最多只能选3项增加能力", {offset: ['30%']});
                $(this).attr("checked", false);
            }
            if (qxs.length < 1) {
                layer.alert("必须选一项增加能力", {offset: ['30%']});
                $(this).attr("checked", false);
                return false;
            }
        });

        $("#submit").click(function () {
            if('1' == submitState)return
            var actClass = $("#activityClass").val();
            if ('' == actClass) {
                layer.msg("请先选择活动大类", {offset: ['30%']});
                return false;
            }

            if ("3" == actClass || "5" == actClass) {
                if ('' == $("#supType").val()) {
                    layer.msg("请先选择活动类别", {offset: ['30%']});
                    return false;
                }

                if ('' == $("#scienceName").val() && $("#supType").val() == "非活动类" && "3" == actClass) {
                    layer.msg("请填写全名", {offset: ['30%']});
                    return false;
                }

                if($("#scienceName").val() && $("#scienceName").val().length > 100){
                    layer.msg("标题名称不能超过100个字", {offset: ['30%']});
                    return false;
                }
                if ($("#supType").val() == "非活动类" && "3" == actClass) {
                    $("#supActivityTitle").val($("#scienceName").val());
                }

                if ('' == $("#supActivityTitle").val() && $("#supType").val() == "活动类" && ("5" == actClass || "3" == actClass)) {
                    layer.msg("请填写活动全称", {offset: ['30%']});
                    return false;
                }
                if($("#supActivityTitle").val() && $("#supActivityTitle").val().length > 100){
                    layer.msg("活动名称不能超过100个字", {offset: ['30%']});
                    return false;
                }
                if ($("#supType").val() == "非活动类" && "5" == actClass && '' == $("#workName").val() && '党支部任职' != $("#workClass").val() && '班团任职' != $("#workClass").val()) {
                    layer.msg("请填写职务全称", {offset: ['30%']});
                    return false;
                }
                if($("#workName").val() && $("#workName").val().length > 50){
                    layer.msg("职务名称不能超过50个字", {offset: ['30%']});
                    return false;
                }
                if ($("#supType").val() == "非活动类" && "5" == actClass && '' == $("#takeDate").val() && ('党支部任职' == $("#workClass").val() || '班团任职' == $("#workClass").val())) {
                    layer.msg("请填写任职日期", {offset: ['30%']});
                    return false;
                }
            } else {
                if ('' == $("#supActivityTitle").val() && "6" != actClass) {
                    layer.msg("请填写活动全称", {offset: ['30%']});
                    return false;
                }
                if($("#supActivityTitle").val() && $("#supActivityTitle").val().length > 100){
                    layer.msg("活动名称不能超过50个字", {offset: ['30%']});
                    return false;
                }
            }

            if ($("#supType").val() != "非活动类" && $("#activityClass").val() != "6") {
                //增加能力复选框验证
                var qxs = $(".qx_check:checked");
                if (qxs.length < 1) {
                    layer.msg("必须选一项增加能力", {offset: ['30%']});
                    $(this).attr("checked", false);
                    return false;
                }
                //手动拼接 增加能力 到数据库
                var qxs = $(".qx_check:checked");
                var str = "";
                if (qxs != null && qxs != "") {
                    for (var i = 0; i < qxs.length; i++) {
                        var val = $(qxs[i]).val();
//                        console.log(val)
                        str = str + val + "|";
                    }
                    $("#supPowers").val(str.substring(0, str.length - 1));
                }
            }
            if ($("#supType").val() != "非活动类" && "6" != actClass && $("#zhutituanri_n").attr("checked")) {
                if ($("#activityAward").val() == '') {
                    layer.msg("必须填写获得奖项", {offset: ['30%']});
                    return false;
                }
                if ($("#Award").val() == '' && $("#activityAward").val() == '其它') {
                    layer.msg("请填写奖项全称", {offset: ['30%']});
                    return false;
                }
                if($("#Award").val() && $("#Award").val().length > 100){
                    layer.msg("奖项名称不能超过100个字", {offset: ['30%']});
                    return false;
                }
            }
            if ('4' == actClass && $("#shehuishijian_n").attr("checked")) {
                if ($("#worktime").val() == '') {
                    layer.msg("工作时长不能为空", {offset: ['30%']});
                    return false;
                }
            }
            if($("#worktime").val() && $("#worktime").val().length > 50){
                layer.msg("工作时长填写错误", {offset: ['30%']});
                return false;
            }
            if ("6" == actClass) {
                if ($("#shipName").val() == '') {
                    layer.msg("请填写奖项全称", {offset: ['30%']});
                    return false;
                }
                if($("#shipName").val() && $("#shipName").val().length > 100){
                    layer.msg("奖项全称不能超过100个字", {offset: ['30%']});
                    return false;
                }
            }

            if (!($("#supType").val() == "非活动类" && "3" == actClass) && "6" != actClass && !("5" == actClass && $("#supType").val() == "非活动类")) {
                if ($("#Award").val() == '' && $("#activityAward").val() == '其它') {
                    layer.msg("请填写奖项全称", {offset: ['30%']});
                    return false;
                }
                if($("#Award").val() && $("#Award").val().length > 100){
                    layer.msg("奖项全称不能超过100个字", {offset: ['30%']});
                    return false;
                }
            }

            if (!$("#takeDate").val() || $("#takeDate").val() === '') {
                layer.msg("必须填写参与时间", {offset: ['30%']});
                return false;
            }
            if (!$("#supActivityTitle").val() || $("#supActivityTitle").val() == '') {
                $("#supActivityTitle").val('');
            }
            if (canEdit) {
                submitState = 1;
                $("#form1").submit();
                /*window.location.reload();*/
            } else {
                $(".window_selectMsg").hide();
                $(".window_Greybg").hide();
                layer.alert("审核未通过，不能进行修改了!", {offset: ['30%']});
                return false;
            }
        });
        $("#workClass").change(function () {
            if ($(this).val() == "班团任职" || $(this).val() == "党支部任职") {       //班团任职或者是党支部任职
                $("#level").hide();
                $("#org_name").find("span").text("职务名称");   //修改组织名称的选项框文字为  职称名称
                $("#workName_box").hide();      //职务名称的输入框隐藏
                $("#takeDate_box").find(".center_cen_content_span").text("任职日期");       //修改 参与日期  为   任职日期
                $("#takeDate_box").find(".input_memo_text").text("*请填写任职起始的日期");     //修改参与日期 后的说明
            } else {
                $("#level").show();
                $("#org_name").find("span").text("组织名称");
                $("#workName_box").show();
                $("#workName").val("");         //清空职务名称中的值，因为班团任职和时候会自动填入职务的名称
                $("#takeDate_box").find(".center_cen_content_span").text("参与日期");       //修改 任职日期  为   参与日期
                $("#takeDate_box").find(".input_memo_text").text("*请填写活动起始的日期");     //修改参与日期 后的说明
            }
        });
        /**
         *  学生组织选学生会的时候，职务级别里显示的为   主席 副主席主任 副主任 部长 副部长 部员
         *  如果组织选择的是社团     级别里显示的是 负责人 部长 副部长  部员
         */
        $("#orgname").change(function () {
            var value = $(this).val();
            var workClass = $("#workClass").val();
            if (workClass === '社团' && value !== '学生会') {
                $(".worklevel_val").hide();
                $(".worklevel_val_fuzeren").show();
            } else {
                $(".worklevel_val").show();
                $(".worklevel_val_fuzeren").hide();
            }
            if ($("#workClass").val() == "班团任职" || $("#workClass").val() == "党支部任职") {   //如果是组织类型是班团任职的时候，把选项中的任职放入职务名称的input框中
                $("#workName").val(value);
            }
        });
        /**
         *  主题团日的选择框
         *  控制相关的输入框显示与否
         */
        $(".zhutituanri").click(function () {
            if ($(this).hasClass("yes_val")) {
                $(".zhutituan_ele").show();
                $(".zhutituan_ele_not").hide();
                $("#zhutituanri_y").selected();
//                $("#supType option:eq(1)").selected();    //选中 活动/非活动中 的   主题团日
                $("#supType").find("option[value='主题团日']").selected();
            } else {
                secondChoose("活动类");
                $(".zhutituan_ele").show();
                $(".zhutituan_ele_not").show();
                $("#zhutituanri_n").selected();
                $("#supType option:eq(0)").selected()
            }
        });
        /**
         * 社会实践和志愿服务
         */
        $(".shehuishijian").click(function () {
            if ($(this).hasClass("yes_val")) {
                secondChoose(0);
                $("#lilun_box").show();     //《思想政治理论课实践》
                $("#lilun_n").selected();       //默认选中其它
                secondChoose("活动类");
                $("#NotfiveShow").hide();       //活动时长
                $("#supCredit").val("1");       //默认学分
            } else {
                secondChoose("活动类");
                $("#supCredit").val("0");       //默认学分
//                $("#shehuishijian_n").selected();
                $("#supType option:eq(0)").selected()
                $("#NotfiveShow").show();       //活动时长
                $("#lilun_box").hide();         //《思想政治理论课实践》
                $("#supCredit").val(0);
            }
        });
        $(".lilun").click(function () {
            $("#supCredit").val("0.25");       //默认学分
            if ($(this).hasClass("yes_val")) {
                sixiangzhengzhililun(1);
            } else {
                sixiangzhengzhililun(0);
            }
        });
        /**
         * 活动时长的处理
         */
        $("#worktime").keyup(function () {
            var time = $(this).val();
            time = time.replace(/\D/g, '');
            $(this).val(time);
            if (!isNaN(parseInt(time)))
                time = parseInt(time);
            else
                time = 0;
            var point = Math.floor((time/12)*100)/100;
            /*var point = Math.floor(time / 3) * 0.25;
            point = point >= 1 ? 1 : point;
            if( time >= 2 && time < 3 && point == 0 ) point = 0.25;*/
            $("#supCredit").val(point);
        });
    });
    /**
     * 设置  《思想政治理论课实践》课程学习  时 各个输入框的值
     * @param flag
     */
    function sixiangzhengzhililun(flag) {
        if (flag) {
            $("#supActivityTitle").val("《思想政治理论课实践》课程学习").css("background", "#eee").attr("readonly", "readonly");
            $("#activityLevle").find("option[value='4']").selected();
            $("#activityNature").find("option[value='4']").selected();
        } else {
            $("#supActivityTitle").val("").css("background", "#fff").removeAttr("readonly");
            $("#activityLevle").find("option:eq(0)").selected();
            $("#activityNature").find("option:eq(0)").selected();
        }
    }

    /**
     * 设置学分
     * @param point
     */
    function setSupCredit(point) {
        setTimeout(function () {
            $("#supCredit").val(point);
        }, 100);
    }

    function loadorg(val) {
        $.ajax({
            url: "/jsons/loadorgname.form",
            type: "post",
            data: {orgval: val},
            async: false,
            success: function (data) {
                var friends = $("#orgname");
                friends.empty();
                var option = $("<option>").text("请选择").val("");
                friends.append(option);
                if (data.rows != null && data.rows.length > 0) {
                    for (var i = 0; i < data.rows.length; i++) {
                        var option = $("<option>").text(data.rows[i].orgname).val(data.rows[i].orgname);
                        friends.append(option);
                    }
                } else {
                    var option = $("<option>").text("无");
                    friends.append(option);
                }
            }
        });
    }
    var chooseValue;
    function firstChoose(firstValue) {
        $("#form1 select").val("");
        $("#form1 input").val("");
        sixiangzhengzhililun(0);    //改变活动名称输入框的状态
        $("#qx1").val("思辨能力");
        $("#qx2").val("执行能力");
        $("#qx3").val("表达能力");
        $("#qx4").val("领导能力");
        $("#qx5").val("创新能力");
        $("#qx6").val("创业能力");
        $("#show").html("");
        $("#activityClass").val(firstValue);
        chooseValue = firstValue;
        $("#zhutituanri_box").hide();           //主题团日的选择框
        $("#shehuishijian_box").hide();         //社会实践 下的子类
        $("#lilun_box").hide();                 //《思想政治理论课实践》课程学习
        $(".zhutituan_ele_not").show();         //选主题团日的时候隐藏起来的元素都显示出来
        $("#zhutituanri_n").selected();          //默认选中   否
        $("#supType option:eq(0)").selected()     //清空 活动、非活动选择框保存的值
        $("#supType").find("option[value='主题团日']").remove();
        $("#supType").find("option[value='创业基础']").remove();
        $("#thirdChoose").attr("style", "display:none");
        $("#secondChoose").attr("style", "display:none");
        $("#actHave").attr("style", "display:none");
        $("#actNotHave").attr("style", "display:none");
        $("#common").attr("style", "display:none");
        $("#fiveShow").attr("style", "display:none");
        $("#NotfiveShow").attr("style", "display:none");
        $("#val3Choose").attr("style", "display:none");
        $("#val4Choose").attr("style", "display:none");
        $("#var6Choose").attr("style", "display:none");
        setSupCredit(0.25);          //默认学分
        secondChoose(0);
        //thirdChoose(0);
        if (firstValue == 0) {
            $("#form1 select").val("");
//            $("#form1").reset;
            return;
        }
        if (firstValue == 1 || firstValue == 2 || firstValue == 4) {
            if (firstValue == 1) {
                $("#zhutituanri_box").show();
                $("#supType").append("<option value='主题团日'>主题团日</option>");
                setSupCredit(0.25);          //默认学分
            }
            if (firstValue == 4) {
                $("#shehuishijian_box").show();
                $("#shehuishijian_n").selected();
                setSupCredit(0);          //默认学分
                $("#NotfiveShow").show();
            }
            $("#common").find("input").val("");
            $("#show").html("");
            $("#actNotHave").find("input").val("");
            $("#qx1").val("思辨能力");
            $("#qx2").val("执行能力");
            $("#qx3").val("表达能力");
            $("#qx4").val("领导能力");
            $("#qx5").val("创新能力");
            $("#qx6").val("创业能力");
            $("#actNotHave").find("select").val("");
            $("#common").attr("style", "display:block");
            $("#actNotHave").attr("style", "display:block");
        } else if (firstValue == 3) {
            $("#supType option:last").remove();
            $("#supType").append("<option value='非活动类'>非活动类</option>");
            /*$("#supType").append("<option value='创业基础'>《创业基础》课程学习</option>");*/
            $("#secondChoose").attr("style", "display:block");
        } else if (firstValue == 5) {
            $("#supType option:last").remove();
            $("#supType").append("<option value='非活动类'>学生干部任职</option>");
            $("#secondChoose").attr("style", "display:block");
            setSupCredit("--");          //默认学分
        } else if (firstValue == 6) {
            $("#var6Choose").attr("style", "display:block");
            $("#common").attr("style", "display:block");
            setSupCredit("--");          //默认学分
        } else {
            firstChoose(0);
        }
    }
    function secondChoose(secondValue) {
        var point = $("#supCredit").val();
        sixiangzhengzhililun(0);
        $("#thirdChoose").attr("style", "display:none");
        $("#val3Choose").attr("style", "display:none");
        $("#val4Choose").attr("style", "display:none");
        $("#common").attr("style", "display:none");
        $("#actHave").attr("style", "display:none");
        $("#actNotHave").attr("style", "display:none");
        if (secondValue == 0) {
            return;
        }
        if (secondValue == "活动类") {
            $("#common").find("input").val("");
            $("#show").html("");
            $("#actNotHave").find("input").val("");
            $("#qx1").val("思辨能力");
            $("#qx2").val("执行能力");
            $("#qx3").val("表达能力");
            $("#qx4").val("领导能力");
            $("#qx5").val("创新能力");
            $("#qx6").val("创业能力");
            $("#actNotHave").find("select").val("");
            $("#common").attr("style", "display:block");
            $("#actNotHave").attr("style", "display:block");
        } else if (secondValue == "非活动类") {
            if (chooseValue == 3) {
                $("#val3Choose").find("select").val("");
                $("#common").find("input").val("");
                $("#show").html("");
                $("#val3Choose").attr("style", "display:block");
                $("#common").attr("style", "display:block");
            } else if (chooseValue == 5) {
                $("#val4Choose select").val("");
                $("#val4Choose").attr("style", "display:block");
                $("#common").attr("style", "display:block");
            }
        } else if (secondValue == "创业基础") {
            secondChoose("活动类");
            setSupCredit("0.25");          //默认学分
            sixiangzhengzhililun(1);
            $("#supActivityTitle").val("《创业基础》课程学习");
        } else {
            secondChoose(0);
        }
        $("#supCredit").val(point);
    }

   function setCreditVal(){
       console.log('进来了');
       var activityNatureVal = $('#activityNature').val();
       var activityLevleVal = $('#activityLevle').val();
       if( 3 == activityNatureVal ){
           if((0 == activityLevleVal || 1 ==activityLevleVal) && '' != activityLevleVal ){
               $("#supCredit").val(0.5)
           }else if(2 == activityLevleVal){
               $("#supCredit").val(0.4)
           }else if(3 == activityLevleVal){
               $("#supCredit").val(0.3)
           }else{
               $("#supCredit").val(0.25)
           }

       }else{
           $("#supCredit").val(0.25)
       }
   }

</script>
<style>
    .secondClassMsgContent .personMsg {
        margin-left: 0px;
    }
</style>
<!--申请框-->
<div class="window_selectMsg" style="overflow: visible;">
    <p class="title1">添加活动 <img src="../../../asset_font_new/img/windowclose_03.png" alt="close"></p>
    <div id="content">
        <form class="table" id="form1" method="post" enctype="multipart/form-data" action="/supplement/apply.form">
            <%--存放审核状态的div，当审核状态为“修改”或者“未通过”时需要用到--%>
            <div style="display: none">
                <input id="regimentAuditStatus" name="regimentAuditStatus">
                <input id="collegeAuditStatus" name="collegeAuditStatus">
                <input id="schoolAuditStaus" name="schoolAuditStaus">
            </div>
            <!--firstChoose -->
            <div class="center_cen_content_put" id="firstChoose" name="supClass">
                <span class="center_cen_content_span">活动大类</span>
                <select class="center_cen_content_input" name="supClass" id="activityClass"
                        style="width:210px;height:32px" onchange="firstChoose(this.value)">
                    <option value="" selected="selected">请选择</option>
                    <option value="1">思想政治教育类</option>
                    <option value="2">能力素质拓展类</option>
                    <option value="3">学术科技与创新创业类</option>
                    <option value="4">社会实践与志愿服务类</option>
                    <option value="5">社会工作与技能培训类</option>
                    <option value="6">综合奖励及其它类</option>
                </select>
                <span class="input_memo_text">*请选择活动所属分类</span>
            </div>
            <%--------------------------------------------------------主题团日------------------------------------------------------------------%>
            <div class="center_cen_content_put" id="zhutituanri_box" style="display: none">
                <span class="center_cen_content_span">主题团日</span>
                <span class="zhutituanri yes_val">
                    <input type="radio" name="zhutituanri" value="yes" id="zhutituanri_y"><label
                        for="zhutituanri_y">是</label>
                </span>
                <span class="zhutituanri no_val">
                    <input type="radio" name="zhutituanri" value="no" id="zhutituanri_n" checked><label
                        for="zhutituanri_n">否</label>
                </span>
            </div>
            <%--------------------------------------------------------主题团日------------------------------------------------------------------%>

            <%--------------------------------------------------------社会实践------------------------------------------------------------------%>
            <div class="center_cen_content_put" id="shehuishijian_box" style="display: none">
                <span class="center_cen_content_span">活动子类</span>
                <span class="shehuishijian yes_val">
                    <input type="radio" name="shehuishijian" value="yes" id="shehuishijian_y"><label
                        for="shehuishijian_y">社会实践</label>
                </span>
                <span class="shehuishijian no_val">
                    <input type="radio" name="shehuishijian" value="no" id="shehuishijian_n" checked><label
                        for="shehuishijian_n">志愿服务</label>
                </span>
            </div>
            <%--------------------------------------------------------社会实践------------------------------------------------------------------%>

            <%--------------------------------------------------------思想政治理论课实践------------------------------------------------------------------%>
            <div class="center_cen_content_put" id="lilun_box" style="display: none">
                <span class="center_cen_content_span">理论实践</span>
               <%-- <span class="lilun yes_val">
                <input type="radio" name="lilun" value="yes" id="lilun_y"><label for="lilun_y">《思想政治理论课实践》课程学习</label>
                </span>
                <br>--%>
                <%--<span style="display: inline-block;width: 68px;height:10px"></span>--%>
                <span class="lilun no_val">
                    <input type="radio" name="lilun" value="no" id="lilun_n" checked><label
                        for="lilun_n">其它社会实践活动</label>
                </span>
            </div>
            <%--------------------------------------------------------思想政治理论课实践------------------------------------------------------------------%>

            <%--------------------------------------------------------创新创业基础课程------------------------------------------------------------------%>
            <!--secondChoose -->
            <div class="center_cen_content_put supType" id="secondChoose" style="display: none">
                <span class="center_cen_content_span">活动类别</span>
                <select class="center_cen_content_input" onchange="secondChoose(this.value)" name="supType" id="supType"
                        style="width:210px;height:32px">
                    <option value="" selected="selected">请选择</option>
                    <option value="活动类">活动类</option>
                    <option value="非活动类">非活动类</option>
                </select>
                <span class="input_memo_text">*请选择活动或非活动</span>
            </div>

            <!--学术科技分类-->
            <div id="val3Choose" style="display: none">
                <div class="center_cen_content_put science">
                    <span class="center_cen_content_span_t ">学术科技</span>
                    <select class="center_cen_content_input" name="scienceClass" id="scienceClass"
                            style="width:210px;height:32px">
                        <option value="" selected="selected">请选择</option>
                        <option value="论文">论文</option>
                        <option value="专利">专利</option>
                        <option value="著作">著作</option>
                        <option value="参与创业项目">参与创业项目</option>
                        <option value="组建/参与创业公司">组建/参与创业公司</option>
                    </select>
                </div>
                <div class="center_cen_content_put science" name="scienceName">
                    <span class="center_cen_content_span ">标题名字</span>
                    <input type="text" class="center_cen_content_input" name="scienceName" id="scienceName"
                           value="" style="width:198px;height:30px"/>
                    <span class="input_memo_text">*请输入全名</span>
                </div>
            </div>

            <!--社会工作类-->
            <div id="val4Choose" style="display: none" name="workClass">
                <div class="center_cen_content_put work">
                    <span class="center_cen_content_span ">组织类型</span>
                    <select class="center_cen_content_input" name="workClass" id="workClass"
                            style="width:210px;height:32px">
                        <option value="">请选择</option>
                        <option value="学校组织">学校组织</option>
                        <option value="学院组织">学院组织</option>
                        <option value="党支部任职">党支部任职</option>
                        <option value="班团任职">班团任职</option>
                        <option value="社团">社团</option>
                    </select>
                </div>
                <div class="center_cen_content_put work orgcollege" name="orgcollege">
                    <span class="center_cen_content_span_t ">学院名字</span>
                    <input class="center_cen_content_input" name="orgcollege" id="orgcollege"
                           style="width:198px;height:32px">
                    </input>
                </div>
                <div class="center_cen_content_put work" name="orgname" id="org_name">
                    <span class="center_cen_content_span_t ">组织名称</span>
                    <select class="center_cen_content_input" name="orgname" id="orgname"
                            style="width:210px;height:32px">
                        <option value="">请选择</option>
                    </select>
                </div>
                <div class="center_cen_content_put work" name="worklevel" id="level">
                    <span class="center_cen_content_span_t ">职务级别</span>
                    <select class="center_cen_content_input" name="worklevel" id="worklevel"
                            style="width:210px;height:32px">
                        <option value="">请选择</option>
                        <option class="worklevel_val" value="负责人">主席</option>
                        <option class="worklevel_val" value="负责人">副主席</option>
                        <option class="worklevel_val" value="负责人">主任</option>
                        <option class="worklevel_val" value="负责人">副主任</option>
                        <option class="worklevel_val_fuzeren" value="负责人">负责人</option>
                        <option value="部长">部长</option>
                        <option value="副部长">副部长</option>
                        <option value="成员">成员</option>
                    </select>
                </div>
                <div class="center_cen_content_put work" name="workName" id="workName_box">
                    <span class="center_cen_content_span_t ">职务名称</span>
                    <input type="text" class="center_cen_content_input" name="workName" id="workName"
                           value="" style="width:198px;height:30px" placeholder="请填写职务全称"/>
                    <span class="input_memo_text">*请填写职务全称</span>
                </div>
            </div>

            <!--奖学金分类-->
            <div id="var6Choose" style="display: none" name="shipType">
                <div class="center_cen_content_put ship">
                    <span class="center_cen_content_span ">奖项类型</span>
                    <select class="center_cen_content_input" name="shipType" id="shipType"
                            style="width:210px;height:32px">
                        <option value="">请选择</option>
                        <option value="奖学金类">奖学金类</option>
                        <option value="荣誉称号类">荣誉称号类</option>
                        <%--<option value="主题团日活动">主题团日活动</option>--%>
                    </select>
                </div>
                <div class="center_cen_content_put ship" style="display: none" name="counts" id="counts_box">
                    <span class="center_cen_content_span">参加次数</span>
                    <input type="text" class="center_cen_content_input" name="counts"
                           id="counts" value="" style="width:198px;height:30px">
                </div>
                <div class="center_cen_content_put ship" name="shipName">
                    <span class="center_cen_content_span">奖项名称</span>
                    <input type="text" class="center_cen_content_input" name="shipName"
                           id="shipName" value="" style="width:198px;height:30px">
                    <span class="input_memo_text">*请填写奖项全称</span>
                </div>
            </div>

            <!--活动类-->
            <%--未建立的活动--%>
            <div id="actNotHave" style="display: none">
                <div class="center_cen_content_put  supp  zhutituan_ele">
                    <span class="center_cen_content_span">活动名称</span>
                    <input type="text" class="center_cen_content_input" name="supActivityTitle" id="supActivityTitle"
                           value="" style="width:198px;height:30px" onKeyup="getContent(this);"/>
                    <span class="input_memo_text">*请填写活动全称</span>
                    <div id="append" style="width:198px;height:30px;margin-left: 74px;"></div>
                </div>
                <div class="center_cen_content_put  Activity  zhutituan_ele_not">
                    <span class="center_cen_content_span">活动级别</span>
                    <select class="center_cen_content_input" name="supLevle" id="activityLevle" onchange="setCreditVal()"
                            style="width:210px;height:32px">
                        <option value="">请选择</option>
                        <option value="0">国际级</option>
                        <option value="1">国家级</option>
                        <option value="2">省级</option>
                        <option value="3">市级</option>
                        <option value="4">校级</option>
                        <option value="5">院级</option>
                        <%--<option value="6">团支部级</option>--%>
                    </select>
                </div>
                <div class="center_cen_content_put  Activity  zhutituan_ele_not">
                    <span class="center_cen_content_span">活动性质</span>
                    <select class="center_cen_content_input" name="supNature" id="activityNature"  onchange="setCreditVal()"
                            style="width:210px;height:32px">
                        <option value="">请选择</option>
                        <option value="1">活动参与</option>
                        <option value="2">讲座报告</option>
                        <option value="3">比赛</option>
                        <option value="4">培训</option>
                    </select>
                </div>
                <div class="center_cen_content_put  Activity zhutituan_ele">
                    <div class="child">
                        <span class="center_cen_content_span">能力标签</span>
                        <input type="checkbox" class="qx_check" id="qx1" name="qx" value="思辨能力"/>思辨能力
                        <input type="checkbox" class="qx_check" id="qx2" name="qx" value="执行能力"/>执行能力
                        <input type="checkbox" class="qx_check" id="qx3" name="qx" value="表达能力"/>表达能力
                        <input type="checkbox" class="qx_check" id="qx4" name="qx" value="领导能力"/>领导能力
                        <input type="checkbox" class="qx_check" id="qx5" name="qx" value="创新能力"/>创新能力
                        <input type="checkbox" class="qx_check" id="qx6" name="qx" value="创业能力"/>创业能力
                    </div>
                    <span class="input_memo_text">*只能选择1-3项</span>
                </div>
                <div class="center_cen_content_put  Activity zhutituan_ele_not">
                    <span class="center_cen_content_span">获得奖项</span>
                    <select class="center_cen_content_input supAward" name="supAward" id="activityAward"
                            style="width:210px;height:32px">
                        <option value="">请选择</option>
                        <option value="第一名">第一名</option>
                        <option value="第二名">第二名</option>
                        <option value="一等奖">一等奖</option>
                        <option value="二等奖">二等奖</option>
                        <option value="金奖">金奖</option>
                        <option value="银奖">银奖</option>
                        <option value="冠军">冠军</option>
                        <option value="亚军">亚军</option>
                        <option value="四强">四强</option>
                        <option value="八强">八强</option>
                        <option value="其它">其它</option>
                    </select>
                    <span class="input_memo_text">*若无可选的奖项，请选择"其它"</span>
                </div>
                <div class="center_cen_content_put otherAward zhutituan_ele_not">
                    <span class="center_cen_content_span">奖项名称</span>
                    <input type="text" class="center_cen_content_input" name="Award" id="Award"
                           value="" style="width:198px;height:30px"/>
                    <span class="input_memo_text">*请填写奖项全称</span>
                </div>
                <!-- 只有在社会实践与支援服务才显示-->
                <div class="center_cen_content_put worktime" id="NotfiveShow" style="display: none">
                    <span class="center_cen_content_span">工作时长</span>
                    <input type="text" class="center_cen_content_input" name="supWorktime" id="worktime"
                           style="width:198px;height:30px" placeholder="时间单位：小时" onkeyup=""/>
                    <span class="input_memo_text">*时间单位：小时</span>
                </div>
            </div>
            <!--common  -->
            <div id="common" style="display: none">
                <div class="center_cen_content_put " id="takeDate_box">
                    <span class="center_cen_content_span">参与日期</span>
                    <input type="text" class="center_cen_content_input" name="takeDate" id="takeDate"
                           onclick="laydate()" style="width:198px;height:30px"/>
                    <span class="input_memo_text">*请填写参与的起始日期</span>
                </div>
                <div class="center_cen_content_put " id="Credit_box">
                    <span class="center_cen_content_span">可获学分</span>
                    <input type="text" class="center_cen_content_input" readonly="readonly" name="supCredit"
                           id="supCredit" style="background:#eee;width:198px;height:30px"/>
                    <span class="input_memo_text">*仅供参考，以审核结果为准</span>
                </div>
                <%--此处隐藏，上传图片功能不要了，后台审核也看不到--%>
                <div id="showbox" style="display: none">
                    <div class="center_cen_content_button upload">
                        上传图片<input type="file" name="supPhot" id="upimg_btn" multiple class="center_cen_content_file"/>
                    </div>
                    <%--上传图片插件--%>
                    <div class='show upload' id="show">
                    </div>
                </div>
            </div>
            <input type="hidden" value="" id="supPowers" name="supPowers">
            <input type="hidden" value="" id="id" name="id">
        </form>
        <div class="btbox">
            <button class="window_selectMsg_confirm" name="" type="submit" id="submit">确定提交</button>
            <button class="window_selectMsg_confirm1" type="button" id="buttones1" onclick='firstChoose(0)'/>
            取消提交</button>
        </div>
    </div>
</div>
<!-- 此js必须放在div后面，不能独立放到其他页，放到其他位置都有可能失效 -->
<script src="<%=request.getContextPath()%>/asset_font/js/oneselfRadio.js"></script>
<%@include file="footer_new.jsp" %>
</body>
</html>