/**
 * 分页
 * Created by hong on 2016/8/1.
 */

var page= 0,rowss=5,total=93;
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
        //keepCenter();
        loadAct();
        //loadData1();
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
function loadAct(){
    var loading = layer.load(1, {shade: [0.1,'#000']});
    var aclass = $("#aclass").text();
    var alevel = $("#alevel").text();
    var anature = $("#anature").text();
    var apower = $("#apower").text();
    var apartic = $("#apartic").text();
    var asearch = $(".input").val();
    //console.log(asearch);
    switch (aclass){
        case ("思想政治教育类"):
            aclass="1";
            break;
        case ("能力素质拓展类"):
            aclass="2";
            break;
        case ("学术科技与创新创业类"):
            aclass="3";
            break;
        case ("社会实践与志愿服务类"):
            aclass="4";
            break;
        case ("社会工作与技能培训类"):
            aclass="5";
            break;
        case ("全部"):
            aclass=null;
            break;
        case ("项目类别"):
            aclass=null;
            break;
        default:
            aclass=null;
            break;
    }
    switch (alevel){
        case ("国际级"):
            alevel="0";
            break;
        case ("国家级"):
            alevel="1";
            break;
        case ("省级"):
            alevel="2";
            break;
        case ("市级"):
            alevel="3";
            break;
        case ("校级"):
            alevel="4";
            break;
        case ("院级"):
            alevel="5";
            break;
        case ("团支部级"):
            alevel="6";
            break;
        case ("全部"):
            alevel=null;
            break;
        case ("项目级别"):
            alevel=null;
            break;
        default:
            alevel=null;
            break;
    }
    switch (anature){
        case ("活动参与"):
            anature="1";
            break;
        case ("讲座报告"):
            anature="2";
            break;
        case ("比赛"):
            anature="3";
            break;
        case ("培训"):
            anature="4";
            break;
        case ("其它"):
            anature="5";
            break;
        case ("全部"):
            anature=null;
            break;
        case ("项目性质"):
            anature=null;
            break;
        default:
            anature=null;
            break;
    }
    if(apower=="全部"||apower=="能力方向"){
        apower=null;
    }
    if(apartic=="全部"||apartic=="参与形式"){
        apartic=null;
    }

        $.ajax({
            url:"/jsons/loadPCAct.form",
            type:"post",
            data:{page:page,rows:rowss,aclass:aclass,alevel:alevel,anature:anature,apower:apower,apartic:apartic,asearch:asearch,activityArea:aArea},
            dataType:"json",
            success:function(data) {
                layer.close(loading);
                total = data.total;
                //pagingInit();
                    var $newAreaBody = $("#allNews");
                    $newAreaBody.html("");
                    var str = "";
                    for (var i = 0; i < data.rows.length; i++) {
                        //console.log(data.rows.length);
                        var row = data.rows[i];
                        var aclass;
                        var alevel;
                        var anature;
                        switch (row.activityClass) {
                            case ("1"):
                                aclass = "思想政治教育类";
                                break;
                            case ("2"):
                                aclass = "能力素质拓展类";
                                break;
                            case ("3"):
                                aclass = "学术科技与创新创业类";
                                break;
                            case ("4"):
                                aclass = "社会实践与志愿服务类";
                                break;
                            case ("5"):
                                aclass = "社会工作与技能培训类";
                                break;
                            default:
                                aclass = null;
                                break;
                        }
                        switch (row.activityLevle) {
                            case ("0"):
                                alevel = "国际级";
                                break;
                            case ("1"):
                                alevel = "国家级";
                                break;
                            case ("2"):
                                alevel = "省级";
                                break;
                            case ("3"):
                                alevel = "市级";
                                break;
                            case ("4"):
                                alevel = "校级";
                                break;
                            case ("5"):
                                alevel = "院级";
                                break;
                            case ("6"):
                                alevel = "团支部级";
                                break;
                            default:
                                alevel = null;
                                break;
                        }
                        switch (row.activityNature) {
                            case ("1"):
                                anature = "活动参与";
                                break;
                            case ("2"):
                                anature = "讲座报告";
                                break;
                            case ("3"):
                                anature = "比赛";
                                break;
                            case ("4"):
                                anature = "培训";
                                break;
                            case ("5"):
                                anature = "其它";
                                break;
                            default:
                                anature = null;
                                break;
                        }
                        var power = row.activityPowers.split("|");
                        var substr = "";
                        var reg = new RegExp("<[^<]*>", "gi");

                        switch (power.length) {
                            case (3):
                                substr = substr + '<span class="NTD_thought">' + power[2].replace("能力", "") + '</span>';
                            case (2):
                                substr = substr + '<span class="NTD_thought">' + power[1].replace("能力", "") + '</span>';
                            case (1):
                                substr = substr + '<span class="NTD_thought">' + power[0].replace("能力", "") + '</span>';
                                }
                                str =str+ '<div class="news">' +
                                    '<div class="news_img"><a href="/views/font/activitydetail.form?id='+
                                    row.activityId+'"><img src="/Files/Images/'+row.activityImg+'" class="img_size" onerror="(this).src=\'/Files/Images/newsimg_03.png\'"/></a></div>' +
                                    '<div class="news_text">' +
                                    '<div class="news_text_first">' +
                                    '<hr color="#2a458c" size="3.5"/>' +
                                    '<a href="/views/font/activitydetail.form?id='+row.activityId+'"><div class="NTF_title">' + row.activityTitle + '</div></a>' +
                                    '<div class="NTF_thirdblock">' + anature + '</div>' +
                                    '<div class="NTF_secondblock">' + aclass + '</div>' +
                                    '<div class="NTF_firstblock">' + alevel + '</div>' +
                                    '</div>' +
                                    '<div class="news_text_second">' +
                                    '<div class="NTS_text">' + row.activityContent.replace(reg, "") + '</div>' +
                                    '<hr color="#FFF799" size="3"/>' +
                                    '</div>' +
                                    '</div>' +
                                    '<div class="news_time">' +
                                    '<div  class="news_time_top">'+row.activitySdate+'</div>' +
                                    '<div class="news_time_down">' + substr + '</div>' +
                                    '</div>' +
                                    '</div>';
                        }
                        str = str.replace(/null/gi, "");
                        $newAreaBody.append(str);

                    keepCenter();

            },
                error:function(){
                    layer.close(loading);
                    layer.msg("服务器连接失败，请稍后再试");
            }
        });
    }

/**
 * 初始化
 */
function pagingInit(){
    var aclass = $("#aclass").text();
    var alevel = $("#alevel").text();
    var anature = $("#anature").text();
    var apower = $("#apower").text();
    var apartic = $("#apartic").text();
    var asearch = $(".input").val();
    switch (aclass){
        case ("思想政治教育类"):
            aclass="1";
            break;
        case ("能力素质拓展类"):
            aclass="2";
            break;
        case ("学术科技与创新创业类"):
            aclass="3";
            break;
        case ("社会实践与志愿服务类"):
            aclass="4";
            break;
        case ("社会工作与技能培训类"):
            aclass="5";
            break;
        case ("全部"):
            aclass=null;
            break;
        case ("项目类别"):
            aclass=null;
            break;
        default:
            aclass=null;
            break;
    }
    switch (alevel){
        case ("国际级"):
            alevel="0";
            break;
        case ("国家级"):
            alevel="1";
            break;
        case ("省级"):
            alevel="2";
            break;
        case ("市级"):
            alevel="3";
            break;
        case ("校级"):
            alevel="4";
            break;
        case ("院级"):
            alevel="5";
            break;
        case ("团支部级"):
            alevel="6";
            break;
        case ("全部"):
            alevel=null;
            break;
        case ("项目级别"):
            alevel=null;
            break;
        default:
            alevel=null;
            break;
    }
    switch (anature){
        case ("活动参与"):
            anature="1";
            break;
        case ("讲座报告"):
            anature="2";
            break;
        case ("比赛"):
            anature="3";
            break;
        case ("培训"):
            anature="4";
            break;
        case ("其它"):
            anature="5";
            break;
        case ("全部"):
            anature=null;
            break;
        case ("项目性质"):
            anature=null;
            break;
        default:
            anature=null;
            break;
    }
    if(apower=="全部"||apower=="能力方向"){
        apower=null;
    }
    if(apartic=="全部"||apartic=="参与形式"){
        apartic=null;
    }
    $.ajax({
        url:"/jsons/loadPCAct.form",
        type:"post",
        data:{aclass:aclass,alevel:alevel,anature:anature,apower:apower,apartic:apartic,asearch:asearch},
        dataType:"json",
        success:function(data) {
            var total1 = data.total;
            totalPage=parseInt((total1-1)/rowss+1);
    //console.log(total1);
    //console.log(totalPage);
            pageing();
        }
    })
}
/**
 * 当前页码按键的显示效果控制
 * @param btn
 */
function currentPage(btn){
    $(".currentpage").removeClass("currentpage");
    $(btn).addClass("currentpage");
}
function pageing(){
    $(".btn_end").text(totalPage);
    $(".next_group").show();
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
                    if(totalPage==1){
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
function loadAct1(){
    var loading = layer.load(1, {shade: [0.1,'#000']});
    var aclass = $("#aclass").text();
    var alevel = $("#alevel").text();
    var anature = $("#anature").text();
    var apower = $("#apower").text();
    var apartic = $("#apartic").text();
    var asearch = $(".input").val();
    //console.log(asearch);
    switch (aclass){
        case ("思想政治教育类"):
            aclass="1";
            break;
        case ("能力素质拓展类"):
            aclass="2";
            break;
        case ("学术科技与创新创业类"):
            aclass="3";
            break;
        case ("社会实践与志愿服务类"):
            aclass="4";
            break;
        case ("社会工作与技能培训类"):
            aclass="5";
            break;
        case ("全部"):
            aclass=null;
            break;
        case ("项目类别"):
            aclass=null;
            break;
        default:
            aclass=null;
            break;
    }
    switch (alevel){
        case ("国际级"):
            alevel="0";
            break;
        case ("国家级"):
            alevel="1";
            break;
        case ("省级"):
            alevel="2";
            break;
        case ("市级"):
            alevel="3";
            break;
        case ("校级"):
            alevel="4";
            break;
        case ("院级"):
            alevel="5";
            break;
        case ("团支部级"):
            alevel="6";
            break;
        case ("全部"):
            alevel=null;
            break;
        case ("项目级别"):
            alevel=null;
            break;
        default:
            alevel=null;
            break;
    }
    switch (anature){
        case ("活动参与"):
            anature="1";
            break;
        case ("讲座报告"):
            anature="2";
            break;
        case ("比赛"):
            anature="3";
            break;
        case ("培训"):
            anature="4";
            break;
        case ("其它"):
            anature="5";
            break;
        case ("全部"):
            anature=null;
            break;
        case ("项目性质"):
            anature=null;
            break;
        default:
            anature=null;
            break;
    }
    if(apower=="全部"||apower=="能力方向"){
        apower=null;
    }
    if(apartic=="全部"||apartic=="参与形式"){
        apartic=null;
    }

    $.ajax({
        url:"/jsons/loadPCAct.form",
        type:"post",
        data:{aclass:aclass,alevel:alevel,anature:anature,apower:apower,apartic:apartic,asearch:asearch,activityArea:aArea},
        dataType:"json",
        success:function(data) {
            layer.close(loading);
            totalPage = Math.ceil(data.total/rowss);
            totalPage=totalPage==0?1:totalPage;
            pageing();
            var $newAreaBody = $("#allNews");
            $newAreaBody.html("");
            var str = "";
            for (var i = 0; i < data.rows.length; i++) {
                //console.log(data.rows.length);
                var row = data.rows[i];
                var aclass;
                var alevel;
                var anature;
                switch (row.activityClass) {
                    case ("1"):
                        aclass = "思想政治教育类";
                        break;
                    case ("2"):
                        aclass = "能力素质拓展类";
                        break;
                    case ("3"):
                        aclass = "学术科技与创新创业类";
                        break;
                    case ("4"):
                        aclass = "社会实践与志愿服务类";
                        break;
                    case ("5"):
                        aclass = "社会工作与技能培训类";
                        break;
                    default:
                        aclass = null;
                        break;
                }
                switch (row.activityLevle) {
                    case ("0"):
                        alevel = "国际级";
                        break;
                    case ("1"):
                        alevel = "国家级";
                        break;
                    case ("2"):
                        alevel = "省级";
                        break;
                    case ("3"):
                        alevel = "市级";
                        break;
                    case ("4"):
                        alevel = "校级";
                        break;
                    case ("5"):
                        alevel = "院级";
                        break;
                    case ("6"):
                        alevel = "团支部级";
                        break;
                    default:
                        alevel = null;
                        break;
                }
                switch (row.activityNature) {
                    case ("1"):
                        anature = "活动参与";
                        break;
                    case ("2"):
                        anature = "讲座报告";
                        break;
                    case ("3"):
                        anature = "比赛";
                        break;
                    case ("4"):
                        anature = "培训";
                        break;
                    case ("5"):
                        anature = "其它";
                        break;
                    default:
                        anature = null;
                        break;
                }
                var power = row.activityPowers.split("|");
                var substr = "";
                var reg = new RegExp("<[^<]*>", "gi");

                switch (power.length) {
                    case (3):
                        substr = substr + '<span class="NTD_thought">' + power[2].replace("能力", "") + '</span>';
                    case (2):
                        substr = substr + '<span class="NTD_thought">' + power[1].replace("能力", "") + '</span>';
                    case (1):
                        substr = substr + '<span class="NTD_thought">' + power[0].replace("能力", "") + '</span>';
                }
                str =str+ '<div class="news">' +
                    '<div class="news_img"><a href="/views/font/activitydetail.form?id='+
                    row.activityId+'"><img src="/Files/Images/'+row.activityImg+'" class="img_size" onerror="(this).src=\'/Files/Images/newsimg_03.png\'"/></a></div>' +
                    '<div class="news_text">' +
                    '<div class="news_text_first">' +
                    '<hr color="#2a458c" size="3.5"/>' +
                    '<a href="/views/font/activitydetail.form?id='+row.activityId+'"><div class="NTF_title">' + row.activityTitle + '</div></a>' +
                    '<div class="NTF_thirdblock">' + anature + '</div>' +
                    '<div class="NTF_secondblock">' + aclass + '</div>' +
                    '<div class="NTF_firstblock">' + alevel + '</div>' +
                    '</div>' +
                    '<div class="news_text_second">' +
                    '<div class="NTS_text">' + row.activityContent.replace(reg, "") + '</div>' +
                    '<hr color="#FFF799" size="3"/>' +
                    '</div>' +
                    '</div>' +
                    '<div class="news_time">' +
                    '<div  class="news_time_top">'+row.activitySdate+'</div>' +
                    '<div class="news_time_down">' + substr + '</div>' +
                    '</div>' +
                    '</div>';
            }
            str = str.replace(/null/gi, "");
            $newAreaBody.append(str);

            keepCenter();

        },
        error:function(){
            layer.close(loading);
            layer.msg("服务器连接失败，请稍后再试");
        }
    });
}