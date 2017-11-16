$(document).ready(function(){
	//图片加载
	$("img.load").load(function  () {
		$(this).css("background","transparent");
	});
	setTimeout(function  () {
		$("img.load").css("background","url()");
	},50);
	$("img.load").error(function  () {
		$(this).attr("src","img/noload.png")
	});
	$("body").fadeIn(100);
})