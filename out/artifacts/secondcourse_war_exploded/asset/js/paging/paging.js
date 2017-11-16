/**
 * 分页
 * Created by hong on 2016/8/1.
 */

var page= 0,rows=10,total=93,totalPage=0;
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
        loadData();
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
function loadData(){
    var loading = layer.load(1, {shade: [0.1,'#000']});
        $.ajax({
            url:"/jsons/loadNewsList.form",
            type:"post",
            data:{page:page || 1,rows:rows},
            dataType:"json",
            success:function(data){
                layer.close(loading);
                total=data.total;
                if((data!=null && data.rows!=null && data.rows.length>0)){
                    $("#news_all").html("");
                    var optionstring = "<ol class=\"circle-list\">";
                    for(var i=0;i<data.rows.length;i++){
                        var item=data.rows[i];
                        optionstring +=
                            '<li onclick="window.location.href=\'/views/font/newspage.form?id='+item.scholarshipnewsId+'\'">'+
                            '<h2></h2>' +
                            '<div style="float: left;">'+item.scholarshipnewsTitle+'</div><div style="float:right;">'+item.scholarshipnewsDate+'</div></li>';
                    }
                    optionstring+="</ol>";
                    $("#news_all").html(optionstring);
                }
                if(page==0){
                    pagingInit();
                }
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
    totalPage=parseInt(total/rows+1);
    $(".btn_end").text(totalPage);
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
                }
            }else{
                $(".btn_3").show();
            }
        }else{
            $(".btn_end").show();
        }
    }else{
        $(".next_group").show();
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