$(document).ready(function(){
	var wid=0,hei=0,num=0;
	wid=$(".center_cen_contant_img").width();
	hei=$(".center_cen_contant_img").height();
	num=wid/hei;
	if($(window).width()>=1662.5){
		if(wid>=900){
			hei=900/num;
			$(".center_cen_contant_img").css("width","900px") ;
			$(".center_cen_contant_img").css("height",hei);
		}
	}
	else{
		if(wid>=700){
			hei=700/num;
			$(".center_cen_contant_img").css("width","700px");
			$(".center_cen_contant_img").css("height",hei);
		}
	}
	$(".center_cen_contant_img").click(function(){
		alert($(window).width());
	})
	function get(){
		if($(window).width()>=1662.5){
			hei=900/num;
			$(".center_cen_contant_img").css("width","900px");
			$(".center_cen_contant_img").css("height",hei);
		}
		else{
			hei=700/num;
			$(".center_cen_contant_img").css("width","700px");
			$(".center_cen_contant_img").css("height",hei);
		}
	}

	window.onresize=get;
})
