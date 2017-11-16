$(document).ready(function(){
	//图片加载
	$("img.load").load(function  () {
		$(this).css("background","transparent");
	});
	setTimeout(function  () {
		$("img.load").css("background","url()");
	},50);
	$("img.load").error(function  () {
		$(this).attr("src", "img/noload.png");
		if ($(this).parent().height() > $(this).parent().width() / 2) {
			$(this).width("100%");
			$(this).height("auto");
		} else {
			$(this).width("auto");
			$(this).height("100%");
		}
		$(this).css("margin-top", ($(this).parent().height() - $(this).height()) / 2);
	});
	$("body").css("dislpay","none");
	setTimeout(function(){
		$("body").fadeIn(300);
	},200);
	//导航
	$(".nav ul>li").hover(function  () {
		 $(this).find("ol").stop(true).slideDown(200);
	},function  () {
		 $(this).find("ol").stop(true).slideUp(200);
	});
});