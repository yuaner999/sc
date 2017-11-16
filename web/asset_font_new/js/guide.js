/**
 * Created by admin on 2016/11/5.
 */
$(document).ready(function () {
    var old_username =$("#username").val();
    var username= $.cookie(old_username);
    //判断浏览器版本
    var browser=navigator.appName
    var b_version=navigator.appVersion
    var version=b_version.split(";");
    var trim_Version=version[1].replace(/[ ]/g,"");
    if(browser=="Microsoft Internet Explorer" && (trim_Version=="MSIE6.0"||trim_Version=="MSIE7.0"||trim_Version=="MSIE8.0")){

    }else if(1==2){
        setTimeout(function(){
            //禁止滚轮
            $("body").css("overflow","hidden");
            $(".guide").get(0).addEventListener("DOMMouseScroll",scroll,false);
            $(".guide").get(0).onmousewheel=scroll;
            function scroll(e){
                e=e||window.event;
                e.preventDefault();
            }
            //初始化
            var t=$(".banner").height();
            $(".guide").css("top",t);
            $(".black").show(0);
            $(".guide").show(0);
            document.body.scrollTop=t;
            var aLeft=[];
            aLeft.push($(".nav li").eq(1).offset().left-171,$(".nav ul li:nth-child(3)").offset().left,parseInt($(".nav ul>li:nth-child(4)").offset().left)-448);
            $(".guide1").css("left",aLeft[0]+"px");
            $(".guide2").css("left",aLeft[1]+"px");
            $(".guide3").css("left",aLeft[2]+"px");
            $(".guide4").css("left",$("#posi").offset().left-618);
            //顺序第12345进行
            $(".guide .open").click(function(){
                $(".guide").hide();
                $("body").css("overflow","auto");
            })
            $(".guide1").show(0);
            $(".guide ul .next").click(function () {
                if($(this).parent().index()==4){
                    $(".guide").hide();
                    $("body").css("overflow","auto");
                    document.body.scrollTop=t;
                } else if($(this).parent().index()==2){
                    document.body.scrollTop=$("#posi").offset().top-100;
                    $(this).parent().hide();
                    $(this).parent().next("ul").show();
                } else if($(this).parent().index()==3){
                    document.body.scrollTop=t;
                    $(this).parent().hide();
                    $(this).parent().next("ul").show();
                }else {
                    $(this).parent().hide();
                    $(this).parent().next("ul").show();
                }
            })
            var username = $("#username").val();
            $.cookie(username, "我是老司机", { expires: 7 });
        },2000);
        window.onresize= function () {
            //初始化
            var t=$(".banner").height();
            if($(".guide4").css("display")=="block"){
                document.body.scrollTop=$("#posi").offset().top-100;
            }else{
                document.body.scrollTop=t;
            }
            $(".guide").css("top",t);
            var aLeft=[];
            aLeft.push($(".nav li").eq(1).offset().left-171,$(".nav ul li:nth-child(3)").offset().left,parseInt($(".nav ul>li:nth-child(4)").offset().left)-448);
            $(".guide1").css("left",aLeft[0]+"px");
            $(".guide2").css("left",aLeft[1]+"px");
            $(".guide3").css("left",aLeft[2]+"px");
            $(".guide4").css("left",$("#posi").offset().left-618);
        }
    }
});