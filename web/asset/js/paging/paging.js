/**
 * 分页
 * Created by hong on 2016/8/1.
 */

var page= 0,rows=14,total=93;
var totalPage=-1;
var flag= true;
var loading = layer.load(1, {shade: [0.1,'#000']});
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
        if(page >= totalPage-2  || totalPage<=5){
            $(".newsNext_group").hide();
        }else{
            $(".newsNext_group").show();
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
        flag=false;
        loadData();
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
    //$("#paging_btn_box").css("margin-right",0-parseInt(ele_width/2));
}
/**
 *  加载数据
 */
//var  checkUrl = "";
function loadData(){
    layer.load(1, {shade: [0.1,'#000']});
        $.ajax({
            url:newsUrl,
            type:"post",
            data:{page:page,rows:rows},
            dataType:"json",
            success:function(data){
                total=data.total;
                if((data!=null && data.rows!=null && data.rows.length>0)){
                    totalPage = Math.ceil(total/rows);
                    $("#news_all").html("");
                    var optionstring = "<ol class=\"circle-list\">";
                    if(data.rows.length>7){
                        //左七条
                        for(var i=0;i<7;i++){
                            var item=data.rows[i];
                            optionstring +=
                                '<li class="center_li" onclick="window.location.href=\'/views/font/news_detail.form?id='+item.newsId+'\'">'+
                                '<div class="hidden">'+
                                '<a class="center_li_span" title="'+item.newsTitle+'"><b>'+item.newsTitle+'</b></a>'+
                                // '<span class="center_li_point">'+
                                // '····························································' +
                                // '·····························································' +
                                // '·····························································' +
                                // '··················'+
                                // '</span>'+
                                '</div>'+
                                '<span class="center_li_time">'+item.nDate+'</span>'+
                                '</li>';
                        }
                        optionstring+="</ol>";
                        optionstring+= '<ol class="circle-list">';
                        //右七条
                        for(var i=7;i<data.rows.length;i++){
                            var item=data.rows[i];
                            optionstring +=
                                '<li class="center_li" onclick="window.location.href=\'/views/font/news_detail.form?id='+item.newsId+'\'">'+
                                '<div class="hidden">'+
                                '<a class="center_li_span" title="'+item.newsTitle+'"><b>'+item.newsTitle+'</b></a>'+
                                // '<span class="center_li_point">'+
                                // '····························································' +
                                // '·····························································' +
                                // '·····························································' +
                                // '··················'+
                                // '</span>'+
                                '</div>'+
                                '<span class="center_li_time">'+item.nDate+'</span>'+
                                '</li>';
                        }
                        optionstring+="</ol>";
                    }else {
                        //不够七条
                        for(var i=0;i<data.rows.length;i++){
                            var item=data.rows[i];
                            optionstring +=
                                '<li class="center_li" onclick="window.location.href=\'/views/font/news_detail.form?id='+item.newsId+'\'">'+
                                '<div class="hidden">'+
                                '<a class="center_li_span" title="'+item.newsTitle+'"><b>'+item.newsTitle+'</b></a>'+
                                // '<span class="center_li_point">'+
                                // '····························································' +
                                // '·····························································' +
                                // '·····························································' +
                                // '··················'+
                                // '</span>'+
                                '</div>'+
                                '<span class="center_li_time">'+item.nDate+'</span>'+
                                '</li>';
                        }
                        optionstring+="</ol>";
                    }
                    $("#news_all").html(optionstring);
                }else{
                        totalPage=1;
                }
                if(flag){
                    pagingInit();
                }
                flag=true;
                keepCenter();
                layer.closeAll('loading');
            },
            error:function(){
                layer.msg("服务器连接失败，请稍后再试");
                layer.closeAll('loading');
            }
        });
    }

/**
 * 初始化
 */
function pagingInit(){
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
/**
 * 当前页码按键的显示效果控制
 * @param btn
 */
function currentPage(btn){
    $(".currentpage").removeClass("currentpage");
    $(btn).addClass("currentpage");
}