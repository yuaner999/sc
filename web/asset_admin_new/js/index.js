$(function  () {
	var w=$(".content>li li>span img").width();
	$(".content>li li>span img").height(w*0.5);
	//里诶啊哦高度
	var imgh=$(".content>li li>span").height();
	$(".content>li li>div").height(imgh);
	window.onresize=function  () {
		var w=$(".content>li li>span img").width();
		$(".content>li li>span img").height(w*0.5);
		var imgh=$(".content>li li>span").height();
		$(".content>li li>div").height(imgh)	;
	}
	//文本溢出
	$(".content>li li>div>span").dotdotdot();
	//照片错误的替换图
	$(".photo").error(function  () {
		$(this).attr("src","");//默认头像图片路径
	});
})
