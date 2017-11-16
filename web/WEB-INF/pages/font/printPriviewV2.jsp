<%--
  Created by IntelliJ IDEA.
  User: admin
  Date: 2016/9/10
  Time: 17:03
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java"  pageEncoding="UTF-8" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01//EN"
"http://www.w3.org/TR/html4/strict.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" lang="en">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
    <!--兼容360浏览器，防止布局乱，设置IE的文档模式为最高版本，并且如果存在chrome插件，自动使用Webkit引擎-->
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <title>打印预览</title>
    <link rel="Shortcut Icon" href="<%=request.getContextPath()%>/asset/image/neu.jpg" type="image/x-icon">
    <link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/asset_font_new/css/common.css"/>
    <link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/asset_font_new/css/commonhead.css"/>
    <link rel="stylesheet" href="<%=request.getContextPath()%>/asset_font/css/index.css" type="text/css" />
    <link rel="stylesheet" href="<%=request.getContextPath()%>/asset_font/css/Radio.css" type="text/css" />
    <script type="text/javascript" src="<%=request.getContextPath()%>/asset_font/js/jquery-1.11.1.min.js"></script>
    <script type="text/javascript" src="<%=request.getContextPath()%>/asset/layer/layer.js" ></script>
    <script type="text/javascript" src="<%=request.getContextPath()%>/asset/js/common.js" ></script>
    <script src="<%=request.getContextPath()%>/asset_font_new/js/jquery.dotdotdot.js" type="text/javascript" charset="utf-8"></script>
    <script src="<%=request.getContextPath()%>/asset_font_new/js/common.js" type="text/javascript" charset="utf-8"></script>
    <script src="<%=request.getContextPath()%>/asset_font_new/js/respond.js" type="text/javascript" charset="utf-8"></script>
    <script src="<%=request.getContextPath()%>/asset_font_new/js/index.js" type="text/javascript" charset="utf-8"></script>
    <script type="text/javascript" src="<%=request.getContextPath()%>/asset_mobile/js/echarts.min.js"></script>
    <script type="text/javascript" src="<%=request.getContextPath()%>/asset/js/laydate/laydate.js"></script>

    <script type="text/javascript">
        var studentid="${studentid}";//从session中取得学生id
        var printid="";
        var studentName="";
        $(function(){
//            wb.execwb(8,1);
//            var $li = $(".grade_list_item");//所有的表格
//            var  height1 = 1600-453;
//            for(var i=0;i<$li.length;i++){
//                console.log(height1);
//                console.log($li.eq(i).height());
//                height1 += $li.eq(i).height();
//                var height2 = parseInt(height1);
//                console.log($li.eq(i).height()>=height1);
//
//                if(height2 >= 1600){
////                    alert(height2);
//                    console.log("这是现在的高度"+height2);
////                    alert(111);
//                    console.log("这是第"+i+"个li触发了换页");
//                    li.eq(--i).addClass("pageBreak");
//                    break;
//                }
//
//            }
//            console.log(studentid);
            printid=GetQueryString("printid");
            //加载打印预览活动列表
            $.ajax({
                url:"/printTranscript/loadPrintPreview.form" ,
                data:{studentid:studentid,printid:printid},
                type:"post",
                dataType:"json",
                async: false,
                success:function(data){
                    if(data.status==1){
                        layer.msg(data.msg);

                        return;
                    }
                    if(data.data==null || data.data.length==0){
                        layer.msg("未添加过打印申请，请先添加打印申请");

                        return;
                    }
                    bindActivityData(data.data);
                },
                error:function(){
                    layer.msg("服务器连接失败，请稍后再试或者联系管理员");
                }
            });
            var myChart = echarts.init(document.getElementById('charts'));
            //加载个人信息
            $.ajax({
                url:"/jsons/loadInfor.form?studentid="+studentid,
                type:"post",
                dataType:"json",
                async: false,
                success:function(data){
                    if(data!=null && data.rows!=null && data.rows.length>0){
                        var row=data.rows[0];
                        $("#picture").attr("src","/Files/Images/"+data.rows[0].studentPhoto);
                        $(".stu_name").text(row.studentName);
                        $(".stu_college").text(row.collegeName);
                        $(".stu_major").text(row.majorName);
                        $(".stu_class").text(row.className);
                        $(".stu_id").text(row.studentID);
                        $(".stu_tel").text(row.studentPhone);
                        studentName=row.studentName;
                    }
                },
                error:function(){
                    layer.msg("服务器连接失败，请稍后再试或者联系管理员");
                }
            });
            //加载六项能力得分
            $.ajax({
                type:"post",
                url:"/char/loadSixElementPoint.form?studentid="+studentid ,
                dataType: "json",
                async: false,
                success: function (data) {
                    if(data==null || data.rows==null || data.rows.length==0){
                        layer.msg("未添加过打印申请，请先添加打印申请");
                        return;
                    }
                    // 获得拼穿值
                    var years=generYears(data);
                    var servies=gennerData(data);
                    // 给option对应地方赋值
                    option.legend.data=eval(years);
                    option.series=eval(servies);
                    //先清空之前的数据
                    myChart.clear();
                    // 使用刚指定的配置项和数据显示图表。
                    myChart.setOption(option);
                },
                error: function () {
                    layer.msg("服务器连接失败，请稍后再试或者联系管理员");
                }
            });
            if(printid&&studentid){
                $("#butter").hide();
                $("#autoID").html(printid);
                $(".td_hide").hide();
            }
        });
        // 基于准备好的dom，初始化echarts实例

        /**
         * 日期格式化
         */
        function dateFormater(Value){
            if(!Value) return "";
            return laydate.now(Value,"YYYY-MM-DD");
        }

        // 指定图表的配置项和数据
        var option = {
            title: {
//            text: '学生能力得分雷达图'
            },
            tooltip: {},
            legend: {
                // orient : 'vertical',
                //x : 'center',
                data: []
            },
            radar: {
                radius:'50%',
                // shape: 'circle',
                indicator: [
                    { name: '思辨', max: 100},
                    { name: '执行', max: 100},
                    { name: '表达', max: 100},
                    { name: '领导', max: 100},
                    { name: '创新', max: 100},
                    { name: '创业', max: 100}
                ]
            },
            series: []
        };
        //拼穿的2个方法
        function generYears (data){
            var list = [];
            for (var i = 0; i <data.total; i++) {
                list.push(data.rows[i].pointYear);
            }
            return list;
        }

        function gennerData(data) {
            var series = [];
            for(var i = 0;i<data.total;i++){
                series.push({
                    name:'能力成绩表',
                    type:'radar',
                    data:[
                        {
                            value:[
                                data.rows[i].sibian!=null?data.rows[i].sibian:50,
                                data.rows[i].zhixing!=null?data.rows[i].zhixing:50,
                                data.rows[i].biaoda!=null?data.rows[i].biaoda:50,
                                data.rows[i].lingdao!=null?data.rows[i].lingdao:50,
                                data.rows[i].chuangxin!=null?data.rows[i].chuangxin:50,
                                data.rows[i].chuangye!=null?data.rows[i].chuangye:50
                            ],
                            name:data.rows[i].pointYear
                        }
                    ]
                })
            }
            return series;
        }

        function bindActivityData(rows){
            var header='<tr class="table_items">'+
                    '<td>时间</td>'+
                    '<td>名称</td>'+
                    '<td>级别</td>'+
                    '<td>学分</td>'+
                    '<td>奖项备注</td>'+
                    '<td>排序</td>'+
            '</tr>';
            var header1='<tr class="table_items">'+
                    '<td>时间</td>'+
                    '<td>名称</td>'+
                    '<td>级别</td>'+
                    '<td>学分</td>'+
                    '<td>奖项备注</td>'+
                    '<td>时长</td>'+
                    '<td>排序</td>'+
            '</tr>';
            $("#aClass").html("");
            $("#bClass").html("");
            $("#cClass").html("");
            $("#dClass").html("");
            $("#eClass").html("");
            $("#fClass").html("");
            $("#aClass").append(header);
            $("#bClass").append(header);
            $("#cClass").append(header);
            $("#dClass").append(header1);
            $("#eClass").append(header);
            $("#fClass").append(header);
            for(var i=0;i<rows.length;i++){
                var row = rows[i];
                var activityClass = row.activityClass;
                var activityLevle='';
                switch (row.activityLevle) {
                    case ("0"):activityLevle = "国际级";break;
                    case ("1"):activityLevle = "国家级";break;
                    case ("2"):activityLevle = "省级";break;
                    case ("3"):activityLevle = "市级";break;
                    case ("4"):activityLevle = "校级";break;
                    case ("5"):activityLevle = "院级";break;
                    case ("6"):activityLevle = "团支部级";break;
                    default:activityLevle =row.activityLevle;break;
                }
                var str='<tr id='+activityClass+i+'>'+
                        '<td>'+row.applyDate.substring(0,10)+'</td>'+
                        '<td>'+row.activityTitle+'</td>'+
                        '<td>'+activityLevle+'</td>'+
                        '<td>'+(row.activityCredit?row.activityCredit:"") + '</td>'+
                        '<td>'+(row.activityAward?row.activityAward:"")+'</td>'+
                        '<td class="td_hide"><img src="<%=request.getContextPath()%>/asset_font_new/img/shang.jpg" onclick="upMove()" style="cursor:pointer;" ><img src="<%=request.getContextPath()%>/asset_font_new/img/xia.jpg" onclick="downMove()" style="cursor:pointer;" ></td>'+
                        '</tr>';
                switch (row.activityClass){
                    case ("1"):
                        $("#aClass").append(str);
                        $("#aClass").find("tr:last").data(row);
//                            console.log($("#aClass").find("tr:last").data())
//                        $("#tr"+(activityClass+i)).data(row);//存入data为后台修改时取数据
                        break;
                    case ("2"):
                        $("#bClass").append(str);
                        $("#bClass").find("tr:last").data(row);
//                        $("#tr"+(activityClass+i)).data(row);//存入data为后台修改时取数据
                        break;
                    case ("3"):
                        $("#cClass").append(str);
                        $("#cClass").find("tr:last").data(row);
//                        $("#tr"+(activityClass+i)).data(row);//存入data为后台修改时取数据
                        break;
                    case ("4"):
                        var str1='<tr id='+activityClass+i+'>'+
                                '<td>'+row.applyDate.substring(0,10)+'</td>'+
                                '<td>'+row.activityTitle+'</td>'+
                                '<td>'+activityLevle+'</td>'+
                                '<td>'+(row.activityCredit?row.activityCredit:"")+ '</td>'+
                                '<td>'+(row.activityAward?row.activityAward:"")+'</td>'+
                                '<td>'+(row.worktime?row.worktime:"")+'</td>'+
                                '<td class="td_hide"><img src="<%=request.getContextPath()%>/asset_font_new/img/shang.jpg" onclick="upMove(this)"><img src="<%=request.getContextPath()%>/asset_font_new/img/xia.jpg" onclick="downMove()" style="cursor:pointer;" ></td>'+
                                '</tr>';
                        $("#dClass").append(str1);
                        $("#dClass").find("tr:last").data(row);
//                        $("#tr"+(activityClass+i)).data(row);//存入data为后台修改时取数据
                        break;
                    case ("5"):
                        $("#eClass").append(str);
                        $("#eClass").find("tr:last").data(row);
//                        $("#tr"+(activityClass+i)).data(row);//存入data为后台修改时取数据
                        break;
                    case ("6"):
                        $("#fClass").append(str);
                        $("#aClass").find("tr:last").data(row);
//                        $("#tr"+(activityClass+i)).data(row);//存入data为后台修改时取数据
                        break;

                }
//                console.log("#tr"+(activityClass+i));
//                console.log(row);
//                $("#tr"+(activityClass+i)).data(row);//存入data为后台修改时取数据
//                console.log($("tr"+activityClass+i).data());
                var a = $("#tr"+activityClass+i).data();
//                console.log(a);
            }
//            rowClick();
            }
          function applyprint(){
            $.ajax({
                url:"/printBack/changeAuditstatus.form",
                type:"post",
                dataType:"json",
                success:function(data){
                    layer.msg(data.msg)
                },
                error:function(){
                    layer.msg("服务器连接失败，请稍后再试或者联系管理员");
                }
             });
        }
        //加载六大类活动总分数
        $.ajax({
            url:"/jsons/loadActivityScoreTotal.form",
            type:"post",
            dataType:"json",
            success:function(data){
                if(data.rows.length>0){
                    for(var i=0;i<data.rows.length;i++){
                        var item=data.rows[i];
                        if(item.dict_mean=='思想政治教育类'){$('.score_get1').html('必修学分'+item.dict_score);}
                        if(item.dict_mean=='能力素质拓展类'){$('.score_get2').html('必修学分'+item.dict_score);}
                        if(item.dict_mean=='学术科技与创新创业类'){$('.score_get3').html('必修学分'+item.dict_score);}
                        if(item.dict_mean=='社会实践与志愿服务类'){$('.score_get4').html('必修学分'+item.dict_score);}
//                        if(item.dict_mean=='社会工作与技能培训类'){$('.score_get5').html('必修学分'+item.dict_score);}
//                        if(item.dict_mean=='综合奖励及其他类'){$('.score_get6').html('必修学分'+item.dict_score);}
                    }
                }
            },
            error:function(XMLHttpRequest,textStatus,errorThrown){
                layer.msg("服务器连接失败，请稍后再试")
            }
        });
        var loginId='<%=session.getAttribute("loginId")%>';
        var score1=0,score2=0,score3=0,score4=0,score5=0,score6=0;
        //        六大类活动参与项数
        var num1= 0,num2= 0,num3= 0,num4= 0,num5= 0,hour=0;
        //加载六大类活动已获得分数
        $.ajax({
            url:"/jsons/loadActivityScoreGet.form",
            type:"post",
            data:{loginId:loginId},
            dataType:"json",
            success:function(data){
//                console.log(data);
                $('.score_total1').html('已修学分0');
                $('.score_total2').html('已修学分0');
                $('.score_total3').html('已修学分0');
                $('.score_total4').html('已修学分0');
                $('.score_total5').html('已修学分0');
//                $('.score_total6').html('已修学分0');
                if(data.rows.length>0){
                    for(var i=0;i<data.rows.length;i++){
                        var item=data.rows[i];
                        item.activityCredit=item.activityCredit==null?0:item.activityCredit;
                        if(item.dict_mean=='思想政治教育类'){
                            score1+=parseFloat(item.activityCredit);
                            num1+=1;
                            if(score1!=0){
                                $('.score_total1').html('已修学分'+score1);
                            }
                        }
                        if(item.dict_mean=='能力素质拓展类') {
                            score2 += parseFloat(item.activityCredit);
                            num2+=1;
                            if (score2 != 0) {
                                $('.score_total2').html('已修学分' + score2);
                            }
                        }
                        if(item.dict_mean=='学术科技与创新创业类'){
                            score3+=parseFloat(item.activityCredit);
                            num3+=1;
                            if(score3!=0){
                                $('.score_total3').html('已修学分'+score3);
                            }
                        }
                        if(item.dict_mean=='社会实践与志愿服务类') {
                            score4 += parseFloat(item.activityCredit);
                            num4+=1;
                            if (score4 != 0) {
                                $('.score_total4').html('已修学分' + score4);
                            }
                        }
                        if(item.dict_mean=='社会工作与技能培训类') {
                            score5 += parseFloat(item.activityCredit);
                            num5+=1;
                            if (score5 != 0) {
                                $('.score_total5').html('已修学分' + score5);
                            }
                        }
//                        if(item.dict_mean=='综合奖励及其他类') {
//                            score6 += parseFloat(item.activityCredit);
//                            if (score6 != 0) {
//                                $('.score_total6').html('已修学分' + score6);
//                            }
//                        }
                    }
                    calculate();
                }
            },
            error:function(XMLHttpRequest,textStatus,errorThrown){
                layer.msg("服务器连接失败，请稍后再试")
            }
        });
        //已获得得分 （学生自己添加的）
        $.ajax({
            url:"/jsons/loadActivityScoreGets.form",
            type:"post",
            data:{loginId:loginId},
            dataType:"json",
            success:function(data){
//                console.log(data);
                if(data.rows.length>0){

                    for(var i=0;i<data.rows.length;i++){
                        var item=data.rows[i];
                        item.supCredit=item.supCredit==null?0:item.supCredit;
                        if(item.dict_mean=='思想政治教育类'){
                            score1+=parseFloat(item.supCredit);
                            num1+=1;
                            if(score1!=0){
                                $('.score_total1').html('已修学分'+score1);
                            }
                        }
                        if(item.dict_mean=='能力素质拓展类') {
                            score2 += parseFloat(item.supCredit);
                            num2+=1;
                            if (score2 != 0) {
                                $('.score_total2').html('已修学分' + score2);
                            }
                        }
                        if(item.dict_mean=='学术科技与创新创业类'){
                            score3+=parseFloat(item.supCredit);
                            num3+=1;
                            if(score3!=0){
                                $('.score_total3').html('已修学分'+score3);
                            }
                        }
                        if(item.dict_mean=='社会实践与志愿服务类') {
                            score4 += parseFloat(item.supCredit);
                            num4+=1;
                            if(item.supWorktime!=null&&item.supWorktime!=''){
                                hour+=parseFloat(item.supWorktime);
                            }
                            if (score4 != 0) {
                                $('.score_total4').html('已修学分' + score4);
                            }
                        }
                        if(item.dict_mean=='社会工作与技能培训类') {
                            score5 += parseFloat(item.supCredit);
                            num5+=1;
                            if (score5 != 0) {
                                $('.score_total5').html('已修学分' + score5);
                            }
                        }
                        if(item.dict_mean=='综合奖励及其他类') {
                            score6 += parseFloat(item.supCredit);
                            if (score6 != 0) {
                                $('.score_total6').html('已修学分' + score6);
                            }
                        }
                    }
                    calculate();
                }
            },
            error:function(XMLHttpRequest,textStatus,errorThrown){
                layer.msg("服务器连接失败，请稍后再试")
            }
        });
        //综合评价数据
        function calculate(){
            $("#num1").text(num1);
            $("#num2").text(num2);
            $("#num3").text(num3);
            $("#num4").text(num4);
            $("#num5").text(num5);
            $("#hour").text(hour);
            //查六项能力得分
            $.ajax({
                url:"/sixpoint/sixpoint.form",
                type:"post",
                data:{studentID:studentid},
                dataType:"json",
                success:function(data) {
                    var sibian;
                    var zhixing;
                    var biaoda;
                    var lingdao;
                    var chuangxin;
                    var chuangye;
                    var top1='false';var top2='false';var top3='false';
                    if (data.rows.length > 0) {
                        sibian = data.rows[0].sibian.toString();
                        zhixing = data.rows[0].zhixing.toString();
                        biaoda = data.rows[0].biaoda.toString();
                        lingdao = data.rows[0].lingdao.toString();
                        chuangxin = data.rows[0].chuangxin.toString();
                        chuangye = data.rows[0].chuangye.toString();
                    var value=[sibian,zhixing,biaoda,lingdao,chuangxin,chuangye];
                    var newValue=[sibian,zhixing,biaoda,lingdao,chuangxin,chuangye];
                    var textvalue=['思辨','执行','表达','领导','创新','创业'];
                    var value1=value.sort();
                        for(var j=0;j<6;j++ ){
                            if(newValue[j]===value1[5]&&top1=='false'){$("#top1").text(textvalue[j]); top1='true'; continue}
                            if(newValue[j]===value1[4]&&top2=='false'){$("#top2").text(textvalue[j]);top2='true'; continue}
                            if(newValue[j]===value1[3]&&top3=='false'){$("#top3").text(textvalue[j]);top3='true'; }
                        }
                }else{
                       //随便写3个能力（都是50分)
                       $("#top1").text('思辨');
                       $("#top2").text('执行');
                       $("#top3").text('表达');
                   }
                }
            });

        }
        //获取URL参数
        function GetQueryString(name)
        {
            var reg = new RegExp("(^|&)"+ name +"=([^&]*)(&|$)");
            var r = window.location.search.substr(1).match(reg);
            if(r!=null)return  decodeURI(r[2]); return null;
        }
        function rowClick(){

            $("tbody tr").click(function()
            {
                clickStatus='true';
                //这里差一个再次点击取消
                $("table tr").css('background-color','white');//先将颜色改为以前面的颜色
                $(this).css('background-color','yellow');//再将单击的那行改成需要的颜色

                //editor.html($(this).find(".newsContent").html());
                var rows = this;
                rowdata = $(this).data();


            });
        }

        function upMove(thi){
            var thi = window.event.target;
            var inx;
            var table;
            var data0 = $(thi).parent().parent().data();

            var data1  ;
            if($(thi).parent().parent().index()>1) {
                inx = $(thi).parent().parent().index() - 1;
                table = $(thi).parent().parent().parent();
                data1 =$(table).find("tr").eq(inx).data();
                var clntr = $(thi).parent().parent().clone();
//                console.log(data1);
//                console.log(data0);

                $(thi).parent().parent().remove();
//                data3 =$(table).find("tr").eq(inx).data();
                $(table).find("tr").eq(inx).before(clntr);
            }else{
                return;
            }
            //取到需要的值
            var activityId1 = data0.id;//原史
            var activityId2 = data1.id;//变动
            //为所有元素重新赋值
            $(thi).parent().parent().data(data1);
            $(table).find("tr").eq(inx).data(data0);
//            console.log(activityId1+"activityId1");
//            console.log(activityId2+"activityId2");


            $.ajax({
                    url:"/jsons/exchangeOrderId.form",
                    type:"post",
                    dataType:"json",
                    data:{studentid:studentid,activityId1:activityId1,activityId2:activityId2},
                    success:function(){

                    }
                })



        }
        function downMove(thi){
            var thi = window.event.target;
            var data1  ;
            var inx;
            var data0 = $(thi).parent().parent().data();
            if($(thi).parent().parent().index()!=$(thi).parent().parent().parent().find("tr").length-1) {
                var clntr = $(thi).parent().parent().clone();
                inx = $(thi).parent().parent().index() ,
                        table = $(thi).parent().parent().parent();
                $(thi).parent().parent().remove();
                data1 =$(table).find("tr").eq(inx).data();
                $(table).find("tr").eq(inx).after(clntr);
//                alert(inx)
            }else{
                return;
            }
            var activityId1 = data0.id;//原史
            var activityId2 = data1.id;//变动
//            console.log(data0);
//            console.log(data1);
//            $(thi).parent().parent().data(data0);
            $(table).find("tr").eq(inx).data(data1);
            $(table).find("tr").eq(inx+1).data(data0);
            $.ajax({
                url:"/jsons/exchangeOrderId.form",
                type:"post",
                dataType:"json",
                data:{studentid:studentid,activityId1:activityId1,activityId2:activityId2},
                success:function(){

                }
            })
        }
        //获取URL参数
        function GetQueryString(name)
        {
            var reg = new RegExp("(^|&)"+ name +"=([^&]*)(&|$)");
            var r = window.location.search.substr(1).match(reg);
            if(r!=null)return  decodeURI(r[2]); return null;
        }
    </script>
    <style type="text/css">
        #posi{
            margin-top: 0 !important;
            display: inline-block !important;
            margin-left: 10px;
        }
        #posi li:nth-child(1){
            top: 187px;
            left: 30px;
        }
        #posi li:nth-child(2) {
            top: 187px;
            left: 230px;
        }
        #posi li:nth-child(3) {
            top: 95px;
            left: 230px;
        }
        #posi li:nth-child(4) {
            top: 249px;
            left: 131px;
        }
        #posi li:nth-child(5) {
            top: 31px;
            left: 131px;
        }
        #posi li:nth-child(6) {
            top: 95px;
            left: 30px;
        }
        .secondClassMsgContent .grade_list{
            display: block !important;
        }
        .statistical_graph,.person_MsgContent{
            display: inline-block !important;
        }
        .secondClassMsgContent .grade_list .grade_list_item_table tr, td{
            border: 1px solid #2a458c;
            min-height: 37px;
            line-height: 37px;
            max-height: 37px;
        }
        .person_MsgContent{
            vertical-align: top;
        }
        .person_analyze{
            text-align: left !important;
            width: 90% ;
            margin:  0 auto;
        }
        .person_msg_{
            /*left: 40%;*/
            width: 85%;
            max-height: 215px;
            display: inline-block;
            position: absolute;
            margin-left: 10px;
            /*overflow: hidden;*/
        }
        .person_msg_item{
            overflow:visible !important;
            text-align: left;
            white-space: nowrap;
            margin-bottom: 23px;
            line-height: 16px;
        }
        .person_picture{
            width: 163px !important;
            height: 216px !important;
            display: inline-block !important;
        }
        .person_msg_style{
            display: inline-block;
            position: relative;
            font-size: 14px;
            color: #2a458c;
            letter-spacing: 1px;
            text-align: left;
            white-space: nowrap;
        }
        .grade_list{
            width: 100% !important;
            margin: 0 auto;
            margin-top: 30px;
        }
        .statistical_graph{
            /*margin-left: 10px;*/
        }
        #posi{
            height:318px !important;
            display: inline-block !important;
        }
        .secondClassMsgContent .person_analyze{
            text-align: center !important;
        }
        .secondClassMsgContent .person_analyze .person_MsgContent{
            display: inline-block !important;
            position: relative;
            width: 500px !important;
        }
        .person_msg_{
            position: relative !important;
            width:63% !important;
        }
        td img{
            display: inline-block;
            vertical-align: middle;
            margin: 0 5px;
        }
        .box1{
            text-align: center;
            margin: 0 auto;
        }
        .secondClassMsgContent .yellowBar .blueBar{
            margin-top: 0 !important;
        }
        @media only screen and (max-width:1680px) {
            .box1{
                position: relative;
            }
            .personMsg{
                left:-280px;
            }
            #font{
                margin-left: 200px;
                margin-bottom:-35px;
                height: 50px;
                position: absolute;
                right:0px;
                top:17px;
            }
            #font2{
                position: absolute;
                left: 0;
                width:50px;
                margin-right: 30px;
                margin-bottom: -10px;
            }
        }
        @media only screen and (min-width:1681px) {
            .box1{
                position: relative;
            }
            .personMsg{
                left:-410px;
            }
            #font{
                margin-left: 200px;
                margin-bottom:-35px;
                height: 50px;
                position: absolute;
                right:0px;
                top:17px;
            }
            #font2{
                position: absolute;
                left: 0;
                width:50px;
                margin-right: 30px;
                margin-bottom: -10px;
            }
        }
        #timg{
            width:100%;
        }
        .box1{
            width:1040px;
        }
        .secondClassMsgContent{
            width:1040px !important;
        }
        .grade_list_item_table tr td:nth-child(1){
            width: 10%;
        }
        .grade_list_item_table tr td:nth-child(2){
            width: 20%;
        }
        .grade_list_item_table tr td:nth-child(3){
            width: 6%;
        }
        .grade_list_item_table tr td:nth-child(4){
            width: 5%;
        }
        .grade_list_item_table tr td:nth-child(5){
            width: 17%;
        }
        .grade_list_item_table tr td:nth-child(6){
            width: 6%;
        }
        .grade_list_item_table tr td:nth-child(7){
            width: 6%;
        }
        #dClass tr td:nth-child(5){
            width: 10%;
        }
        #dClass tr td:nth-child(6){
            width: 7%;
        }
        #timg,#xiaoHui{
            width:100px;
            display: inline-block;
        }
        .box1{
            text-align: left;
        }
        #timg{
            width:60px;
            margin-right: 15px;
        }
        #autoID,#timg{
            vertical-align: middle;
        }
        #autoID{
            float: right;
            height: 58px;
            line-height: 58px;
            font-size: 16px;
        }
        .box1>b,.box1>span{
            color: #2a458c;
            font-size: 18px;
        }
        #xiaoHui{
            width:220px;
            float: left;
        }
        #xiaoXun{
            height:60px;
            float: right;
        }
        .secondClassMsgContent>span{
            display: block;
            overflow:hidden;
            position: relative;
            top:-20px;
        }
        .pageBreak{
            page-break-after: always;
        }
    </style>
</head>

<body>
<div class="secondClassMsgContent">
    <div class="box1">
        <%--<img id="font2"src="<%=request.getContextPath()%>/asset_font_new/img/group_logo.png">--%>
        <%--<span class="personMsg">>东北大学共青团 "第二课堂"成绩单</span>--%>
        <img id="timg" src="../../../asset_font_new/img/group_logo.png" alt=""><b>>东北大学共青团"第二课堂"成绩单</b>
        <span id="autoID">编号:&nbsp;${printId}</span>
        <%--<img id="font"src="<%=request.getContextPath()%>/asset_font_new/img/neutitle_blue.png">--%>
        <!--分割线-->
        <%--<div class="yellowBar">--%>
            <%--<div class="blueBar"></div>--%>
        <%--</div>--%>
    </div>
    <div class="person_analyze">
        <!--个人信息板块-->
        <div class="person_MsgContent">
            <img id="picture" class="person_picture"   onerror="onerror=null;src='/Files/Images/default.jpg'"/>
            <ul class="person_msg_" id="information">
                <li class="person_msg_item">
                    <label class="person_msg_style person_msg_type">姓名&nbsp;:&nbsp;</label>
                    <span class="person_msg_style stu_name">王宝玉</span>
                    </li>
                <li class="person_msg_item">
                <label class="person_msg_style person_msg_type">学院&nbsp;:&nbsp;</label>
                <span class="person_msg_style stu_college">计算机学院</span>
                </li>
                <li class="person_msg_item">
                <label class="person_msg_style person_msg_type">专业&nbsp;:&nbsp;</label>
                <span class="person_msg_style stu_major">软件工程</span>
                </li>
                <li class="person_msg_item">
                <label class="person_msg_style person_msg_type">班级&nbsp;:&nbsp;</label>
                <span class="person_msg_style stu_class">软件1602</span>
                </li>
                <li class="person_msg_item">
                <label class="person_msg_style person_msg_type">学号&nbsp;:&nbsp;</label>
                <span class="person_msg_style stu_id">000001</span>
                </li>
                <li class="person_msg_item">
                <label class="person_msg_style person_msg_type">电话&nbsp;:&nbsp;</label>
                <span class="person_msg_style stu_tel">18698854921</span>
                </li>
            </ul>
        </div>
        <!--能力模型图-->
        <div id="posi" style="margin-top: 180px;">
            <ul>
                <li><img src="<%=request.getContextPath()%>/asset_font/img/biaoda.png"/></li>
                <li><img src="<%=request.getContextPath()%>/asset_font/img/chuangxin.png"/></li>
                <li><img src="<%=request.getContextPath()%>/asset_font/img/chuangye.png"/></li>
                <li><img src="<%=request.getContextPath()%>/asset_font/img/lingdao.png"/></li>
                <li><img src="<%=request.getContextPath()%>/asset_font/img/sibian.png"/></li>
                <li><img src="<%=request.getContextPath()%>/asset_font/img/zhixing.png"/></li>
            </ul>
            <div id="charts" class="statistical_graph" style="width: 20rem;height:20rem;"></div>
        </div>
    </div>
    <!--成绩单-->
    <!--成绩单-->
    <ul class="grade_list">
        <li class="grade_list_item">
            <div class="titleYellowBlock"></div>
            <span class="itemName">项目类别&nbsp;:&nbsp;思想政治教育类</span>
            <div class="box">
                <span class="score_get1"></span>&nbsp;&nbsp;/<span class="score_total1"></span>
            </div>
            <table class="grade_list_item_table" border="1" id="aClass">
                <tr class="table_items">
                    <td>时间</td>
                    <td>项目名称</td>
                    <td>项目级别</td>
                    <td>所获奖项</td>
                </tr>
            </table>
        </li>
        <li class="grade_list_item">
            <div class="titleYellowBlock"></div>
            <span class="itemName">项目类别&nbsp;:&nbsp;能力素质拓展类</span>
            <div class="box">
                <span class="score_get2"></span>&nbsp;&nbsp;/<span class="score_total2"></span>
            </div>
            <table class="grade_list_item_table" border="1" id="bClass">
                <tr class="table_items">
                    <td>时间</td>
                    <td>项目名称</td>
                    <td>项目级别</td>
                    <td>所获奖项</td>
                </tr>
            </table>
        </li>
        <li class="grade_list_item">
            <div class="titleYellowBlock"></div>
            <span class="itemName">项目类别&nbsp;:&nbsp;学术科技与创新创业类</span>
            <div class="box">
                <span class="score_get3"></span>&nbsp;&nbsp;/<span class="score_total3"></span>
            </div>
            <table class="grade_list_item_table" border="1" id="cClass">
                <tr class="table_items">
                    <td>时间</td>
                    <td>项目名称</td>
                    <td>项目级别</td>
                    <td>所获奖项</td>
                </tr>
            </table>
        </li>
        <li class="grade_list_item">
            <div class="titleYellowBlock"></div>
            <span class="itemName">项目类别&nbsp;:&nbsp;社会实践与志愿服务类</span>
            <div class="box">
                <span class="score_get4"></span>&nbsp;&nbsp;/<span class="score_total4"></span>
            </div>
            <table class="grade_list_item_table" border="1" id="dClass">
                <tr class="table_items">
                    <td>时间</td>
                    <td>项目名称</td>
                    <td>项目级别</td>
                    <td>所获奖项</td>
                </tr>
            </table>
        </li>
        <li class="grade_list_item">
            <div class="titleYellowBlock"></div>
            <span class="itemName">项目类别&nbsp;:&nbsp;社会工作与技能培训类</span>
            <div class="box">
                <span class="score_get5"></span>&nbsp;&nbsp;/<span class="score_total5"></span>
            </div>
            <table class="grade_list_item_table" border="1" id="eClass">
                <tr class="table_items">
                    <td>时间</td>
                    <td>项目名称</td>
                    <td>项目级别</td>
                    <td>所获奖项</td>
                </tr>
            </table>
        </li>
        <li class="grade_list_item">
            <div class="titleYellowBlock"></div>
            <span class="itemName">项目类别&nbsp;:&nbsp;综合奖励及其它类</span>
            <div class="box" >
                <%--<span class="score_get6"></span>&nbsp;&nbsp;/--%>
                <span class="score_total6"></span>
            </div>
            <table class="grade_list_item_table" border="1" id="fClass">
                <tr class="table_items">
                    <td>时间</td>
                    <td>项目名称</td>
                    <td>项目级别</td>
                    <td>所获奖项</td>
                </tr>
            </table>
        </li>
        <li class="grade_list_item">
            <div class="titleYellowBlock"></div>
            <span class="itemName">综合评价</span>
            <table class="grade_list_item_table" border="" id="" style="text-align: left;border: 2px solid #fff;">
                <tr class="table_items">
                    <td><span class="totally" style="height: 50px"> ${loginName} 同学在校期间累计参与思想政治教育类活动 <span id="num1"></span> 项，能力素质拓展类活动 <span id="num2"></span> 项，学术科技与创新创业类活动 <span id="num3"></span> 项，社会实践与志愿服务类活动 <span id="num4"></span> 项，志愿服务时长 <span id="hour"></span> 小时，社会工作与技能培训类活动 <span id="num5"></span> 项。综上，该生在 <span id="top1"></span> 能力、 <span id="top2"></span> 能力、 <span id="top3"></span> 能力提升方面表现突出，综合能力素质评定等级为（良好/优秀）。
                        <span id="data1"></span>&nbsp; </span></td>
                </tr>
            </table>

        </li>
        <li class="grade_list_item" style="margin-top: 140px">
            <input style="font-size: 14px;color: #fff;background-color: #2a458c;border: 0;cursor: pointer;width: 114px;height: 30px;margin-left: 550px;"
                   type="button"  value="添加到打印列队"  id="laodActivity" onclick="applyprint()"/>
        </li>
    </ul>
   <span>
       <img  id="xiaoHui" src="../../../asset_font_new/img/neu_xiaohui.png" alt="">
       <img  id="xiaoXun"  src="../../../asset_font_new/img/neutitle_blue.png" alt="">
   </span>
</div>
<!-- 此js必须放在div后面，不能独立放到其他页，放到其他位置都有可能失效 -->
<%--<script src="/asset_font/js/oneselfRadio.js"></script>--%>
</body>
</html>

