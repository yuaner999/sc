$(document).ready(function(){
	var num = 0;
	$(".center_btn").eq(0).css("background-color","#FFF799")
	$(".center_btn").click(function(){
		$(".center_btn").css("background-color","#FFFFFF");
		$(this).css("background-color","#FFF799");
		num=$(this).text()-1;
	})
	$(".center_btn_left").click(function(){
		if(num!=0){
			$(".center_btn").css("background-color","#FFFFFF");
			num--;
			$(".center_btn").eq(num).css("background-color","#FFF799");
		}
	})
	$(".center_btn_right").click(function(){
		if(num!=140){
			$(".center_btn").css("background-color","#FFFFFF");
			num++;
			$(".center_btn").eq(num).css("background-color","#FFF799");
		}
	})
	$(".center_school").click(function(){
		//$(".center_accda").css({"color":"#C4C5F3","border-right":"10px solid #C4C5F3"});
		//$(".center_school").css({"color":"#2a458c","border-right":"10px solid #2a458c"});
	})
	$(".center_accda").click(function(){
		//$(".center_school").css({"color":"#C4C5F3","border-right":"10px solid #C4C5F3"});
		//$(".center_accda").css({"color":"#2a458c","border-right":"10px solid #2a458c"});
	})
})
