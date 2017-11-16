

var isCondition='';
var isSelect='';
var rowdata ;//行数据
var rows=10; //每页显示行数
var page=1;//当前页码
var totalNum = 0;//总数据条数
var jsonPara;//加载数据的参数
var postURL = "";//请求的URL地址

//序列化
$.fn.serializeObject = function()
{
    var o = {};
    var a = this.serializeArray();
    $.each(a, function() {
        if (o[this.name]) {
            if (!o[this.name].push) {
                o[this.name] = [o[this.name]];
            }
            o[this.name].push(this.value || '');
        } else {
            o[this.name] = this.value || '';
        }
    });
    return o;
};

//弹出加载层
function load() {
    $("<div class=\"datagrid-mask\" style='z-index: 9999999999999999999;'></div>").css({ display: "block", width: "100%", height: $(window).height() }).appendTo("body");
    $("<div class=\"datagrid-mask-msg\" style='z-index: 9999999999999999999;'></div>").html("正在加载，请稍候...").appendTo("body").css({ display: "block", left: ($(document.body).outerWidth(true) - 190) / 2, top: ($(window).height() - 45) / 2 });
}

//取消加载层
function disLoad() {
    $(".datagrid-mask").remove();
    $(".datagrid-mask-msg").remove();
}

//关闭按钮
function close(){
    isSelect='';
    clickStatus='';
    $('#dlg').hide();
    $('.popup').slideUp(400);
    $('.new').slideUp(300);
}
//分页加载
function paging(){
    if($(".currentPageNum").val()==0){
        $(".currentPageNum").val("1");
    }
    page= $(".currentPageNum").val();
    rows = $("#rows").val();
    $(".pageNum").eq(0).html(Math.ceil( totalNum/rows));
    $(".pageNum").eq(3).html(totalNum);
    if(totalNum<=0){
        $(".currentPageNum").val("0");
        page=$(".currentPageNum").val("0");
        $(".pageNum").eq(2).html(0);
        $(".pageNum").eq(1).html(0);
    }else if(totalNum<page*rows){
        $(".pageNum").eq(2).html(totalNum);
        $(".pageNum").eq(1).html(rows*(page-1)+1);
    }else{
        $(".pageNum").eq(2).html(page*rows);
        $(".pageNum").eq(1).html(rows*(page-1)+1);
    }
    //if(totalNum==null||totalNum==""){
    //	$("#pages").val(0);
    //	$(".pageNum").eq(0).html('0');
    //	$(".pageNum").eq(1).html('0');
    //	$(".pageNum").eq(2).html('0');
    //	$(".pageNum").eq(3).html('0');
    //	page= $(".currentPageNum").val('0');
    //	rows = $("#rows").val('10');
    //	return;
    //}
    //
    //$(".pageNum").eq(0).html(Math.ceil( totalNum/rows));
    //$(".pageNum").eq(1).html(rows*(page-1)+1);
    //if(totalNum<page*rows){
    //	$(".pageNum").eq(2).html(totalNum);
    //	$(".pageNum").eq(3).html(totalNum);
    //}else{
    //	$(".pageNum").eq(2).html(page*rows);
    //	$(".pageNum").eq(3).html(totalNum);
    //}
}
//上一页
function turn_left(){
    var newpage1= parseInt($(".currentPageNum").val());
    if(newpage1<=1){
        newpage1=1;
    }else{
        newpage1=newpage1-1;
    }
    $(".currentPageNum").val(newpage1);
    var pagNum = $(".currentPageNum").val();
    select_box(newpage1);
}

//下一页
function turn_right(){
    var newpage2= parseInt($(".currentPageNum").val());

    if(newpage2>=Math.ceil(totalNum/rows)){
        newpage2=Math.ceil(totalNum/rows);
    }else{
        newpage2=newpage2+1;
    }
    $(".currentPageNum").val(newpage2);
    var pagNum = $(".currentPageNum").val();
    select_box(newpage2);

}

//综合查询
function select_box(page) {
    var jsonObject = $("#Form1").serializeObject();
    jsonObject["rows"] = $("#rows").val() ;

    if(Math.ceil(totalNum/$("#rows").val())<page){
        page=Math.ceil(totalNum/$("#rows").val());
    }
    if(page<=0){
        page=1;
    }
    jsonObject["page"] = page;
    $(".currentPageNum").val(page);
    jsonPara=jsonObject;
    $('.searchContent').slideUp();
    reload();
}
//清空
function clear_search(){
    document.getElementById("Form1").reset();
}

