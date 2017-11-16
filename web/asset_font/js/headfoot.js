$(document).ready(function(){
	$(".navli").hover(showMenu,hideMenu);
	
	//显示二级菜单
	function showMenu(){
		$(this).addClass("on").siblings().removeClass("on");
		$(".secondul").stop().css("height","0px");
		var liheight = $(this).children().eq(1).children().height();
		var linum = $(this).children().eq(1).children().size();
		$(this).children().eq(1).stop().animate({height:linum*liheight},300);
	}
	//隐藏二级菜单
	function hideMenu(){
		$(this).children().eq(1).stop().animate({height:0},200,function(){
			$(this).parent().removeClass("on");
		});
	}
	
})