/**
 * 分页
 * Created by hong on 2016/8/1.
 */

var page= 1,rowss=8,/*之前是15，信息会隐藏掉*/total=2,totalPage=0;
var flag= true;
$(function(){
    //pagingInit();
    $(".page_count").click(function(){
        currentPage(this);
        page=parseInt($(this).text());
        //左边省略号显示控制
        if(page<=3 || totalPage<=5){
            $(".prev_group").hide();
        }else{
            $(".prev_group").show();
        }
        //右边省略号显示控制
        if(page>=totalPage-2  || totalPage<=5){
            $(".next_group").hide();
        }else{
            $(".next_group").show();
        }
        if($(this).hasClass("btn_3")){
            if(page<totalPage-1){
                $(".btn_1").text(page-1);
                $(".btn_2").text(page);
                $(".btn_3").text(page+1);
                currentPage($(".btn_2"));
            }
        }else if($(this).hasClass("btn_1")){
            if(page>2){
                $(".btn_1").text(page-1);
                $(".btn_2").text(page);
                $(".btn_3").text(page+1);
                currentPage($(".btn_2"));
            }
        }else if($(this).hasClass("btn_end")){
            $(".btn_3").text(page-1);
            $(".btn_2").text(page-2);
            $(".btn_1").text(page-3);
        }else if($(this).hasClass("btn_start")){
            $(".btn_3").text(4);
            $(".btn_2").text(3);
            $(".btn_1").text(2);
        }
        flag=false;
        //keepCenter();
        loadActivityContent();
        //loadData1();
    });
    //左翻页
    $(".btn_left").click(function(){
        var page_count=$(".page_count");
        for(var i=0;i<page_count.length;i++){
            //判断是否被点击赋予class
            if($(".page_count").eq(i).hasClass("currentpage")){
                //判断是否为第1页被选中
                if($(".page_count").eq(i).hasClass("btn_start"))return;
                //上一页触发
                $(".page_count").eq(i-1).click();return;
            }
        }
    });
    //右翻页
    $(".btn_right").click(function(){
        var page_count=$(".page_count");
        for(var i=0;i<page_count.length;i++){
            //判断是否被点击赋予class
            if($(".page_count").eq(i).hasClass("currentpage")){
                //判断是否为最后1页被选中
                if($(".page_count").eq(i).hasClass("btn_end"))return;
                //过滤掉hide()的页数
                if($(".page_count").eq(i+1).css("display")=="none") return;
                //下一页触发
                $(".page_count").eq(i+1).click();return;
            }
        }
    });
});
/**
 * 让翻页按钮保持居中
 */
function keepCenter(){
    var ele_width=$("#paging_btn_box").width();
    $("#paging_btn_box").css("margin-left",0-parseInt(ele_width/2));
}
/**
 *  加载数据
 */
function loadActivityContent(){
    layer.load(1, {shade: [0.1,'#000']});
    var sname=$("#name_input").val();
    /*var sact=$("#act_input").val();*/
    var scollege= $("#collageName").text()=="选择学院"?"":$("#collageName").text();
    var smajor= $("#majorName").text()=="选择专业"?"":$("#majorName").text();
    var sgrade=$("#gradeName").text()=="选择年级"?"":$("#gradeName").text();
    var sclass= $("#className").text()=="选择班级"?"":$("#className").text();
    //console.log(smajor)
    $.ajax({
        url:"/jsons/loadCheckActivities.form",
        type:"post",
        data:{page:page,rows:rowss,scollege:scollege,sname:sname,smajor:smajor,sgrade:sgrade,sclass:sclass},/*,sact:sact*/
        dataType:"json",
        success:function(data) {
            total = data.total;
            //totalPage=parseInt(total/rowss+1);
            totalPage=Math.ceil(total/rowss);
            var check = $(".table_box");
            check.html("");
            for (var i = 0; i < data.rows.length; i++) {
                var row = data.rows[i];
                row.studentName=row.studentName==null?'':row.studentName;
                row.teamName=row.teamName==null?'':row.teamName;
                row.applyStudentId = row.applyStudentId ? row.applyStudentId : row.studentID;
                var time;
                if(row.activitySdate1||row.activityEdate1){
                    time=row.activitySdate1+ '--' +row.activityEdate1;
                }else{
                    time=row.signUpTime1;
                }
                var str = '<div class="list-one">'+
                    '<div class="activityname-one" title="'+row.activityTitle+'" style="cursor: default;"><span class="stubox">' +
                    row.activityTitle+
                    '<b class="stuInfo"></b></span></div>' +
                    '<div class="time-one" title="'+time+'">' +time+ '</div>' +
                    '<div class="name-one">' + row.studentName+row.teamName + '</div>' +
                    '<div class="jubao"><div class="button" onclick="openDialog(this)">'+(row.applyStudentId!=studentId?'举报':'质疑')+'</div></div>' +
                    '<div class="outStudentId" hidden style="display: none">'+row.applyStudentId+'</div>' +
                    '<div class="outID" hidden style="display: none">'+row.applyActivityId+row.id+'</div>'+
                    '<div class="outAuditStatus" hidden style="display: none">'+row.teamId+'</div>'+
                    '</div>';
                str = str.replace(/undefined/, "");
                str = str.replace(/null/, "");
                check.append(str);
                $(".table_box .list-one:last").data(row);/************/
            }
            if(flag){
                pagingInit();
            }
            flag=true;
            layer.closeAll('loading');
        },
        error:function(){
            layer.msg("服务器连接失败，请稍后再试");
            layer.closeAll('loading');
        }
    });
}
/*function openDialog(btn) {
    //举报 对话框
    $(".report").show(100);
    var row = $(btn).parents(".list-one").data();
    informStudentId = row.studentID;
    informApplyId =row.activityId?row.activityId:row.id ;
}*/
function openDialog(obj) {
    var informByStudentId= $("#studentID").val();
    var informTel= $("#inforTel").val();
    var informContent= $(".sreason").val();

    var informType='';
    if(informByStudentId===informStudentId){
        informType='质疑';
    }else {
        informType='举报';
    }
    rowData_=$(obj).parents(".list-one").data();
    var text=$(obj).text();
    $(".jubao_zhiyi").text(text);
    //取隐藏域里的值 赋值给全局变量 举报时候会用到
    informStudentId =  $(obj).parent().parent().children("div").eq(4).html();
    informApplyId = $(obj).parent().parent().children("div").eq(5).html();
    infomTeamID =  $(obj).parent().parent().children("div").eq(6).html();
    //验证重复举报
    $.ajax({
        url: "/Check/checkReportAgain.form",
        type: "post",
        data: {
            informStudentId: informStudentId,
            informApplyId: informApplyId,
            informByStudentId: informByStudentId,
            informType: informType,
            informTel:informTel
        },
        dataType: "json",
        timeout: 30000,
        success: function (data) {
            if(data.rows.length>0){
                layer.alert("同学，你已经举报过了！");
            }else{
                $(".report").show(100);
                $('.window_Greybg').css('background-color', '#a1a1a1').slideDown(200);
//            $("#inforTel").val("");
                $("#informReason").val("");
            }
        },
        error: function (XMLHttpRequest, textStatus, errorThrown) {
            layer.msg(XMLHttpRequest.status);
            layer.msg(XMLHttpRequest.readyState);
            layer.msg(textStatus);
        }
    });
}

/**
 * 初始化
 */
function pagingInit(){
                $(".btn_end").text(totalPage);
    //console.log(totalPage);
    $(".btn_end").show();
    $(".btn_3").show();
    $(".btn_2").show();
    $(".btn_1").show();
    if(totalPage<=5){
        $(".next_group").hide();
        if(totalPage<=4){
            $(".btn_end").hide();
            if(totalPage<=3){
                $(".btn_3").hide();
                if(totalPage<=2){
                    $(".btn_2").hide();
                    if(totalPage<=1){
                        $(".btn_1").hide();
                    }
                }else{
                    $(".btn_2").show();
                    $(".btn_1").show();
                }
            }else{
                $(".btn_3").show();
                $(".btn_2").show();
                $(".btn_1").show();
            }
        }else{
            $(".btn_end").show();
            $(".btn_3").show();
            $(".btn_2").show();
            $(".btn_1").show();
        }
    }else{
        $(".next_group").show();
        $(".btn_end").show();
        $(".btn_3").show();
        $(".btn_2").show();
        $(".btn_1").show();
    }

}
/**
 * 当前页码按键的显示效果控制
 * @param btn
 */
function currentPage(btn){
    $(".currentpage").removeClass("currentpage");
    $(btn).addClass("currentpage");
}
