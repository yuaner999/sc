$(document).ready(function(){
	$(".include_list").click(function(){
		var num=$(this).index();

		if($(".down").eq(num).css("display")=="none"){
			for(var i=0;i<5;i++){
				$(".down").eq(i).slideUp(200);
			}
			$(".down").eq(num).slideDown(200);
		}
		else{
			$(".down").eq(num).slideUp(200);
		}
	})
	$(".include_list_right").click(function(){
		if($(".down").eq(4).css("display")=="none"){
			for(var i=0;i<5;i++){
				$(".down").eq(i).slideUp(200);
			}
			$(".down").eq(4).slideDown(200);
		}
		else{
			$(".down").eq(4).slideUp(200);
		}
	})
	var a=0;
	$(".include_list").click(function(){
		a=$(this).index();
	})
	//$(".downselect").click(function(){
    //
	//	var id=$(this).text();
	//	$(".project_sort").eq(a).html(id);
	//	page=1;
	//	$(".btn_start").click();
	//	loadAct();
    //
	//})
	setTimeout(function () {
		$(".downselect").click(function(){
			var id=$(this).text();
			$(this).parent().prev().find(".project_sort").html(id);
			page=1;
			$(".btn_start").click();
			loadAct();
		})
	},1000)
	$(".include_list_right").click(function(){
		a=$(this).index();
	})
	//$(".downselect").click(function(){
    //
	//	var id=$(this).text();
	//	$(".project_sort").eq(a).html(id);
	//	load();
    //
	//})
})
//筛选layer
setTimeout(function () {
	$(".include_list li").map(function () {
		var tip;
		var txt=$(this).text();
		$(this).hover(function () {
			if(this.offsetWidth < this.scrollWidth){
				tip=layer.tips(txt, $(this), {
					tips: [2, '#2a458c'],
					time: 4000
				});
			}
		}, function () {
			layer.close(tip);
		})
	})
},1000)
//能力分类layer
setTimeout(function () {
	//$(".NTF_secondblock").map(function () {
	//	var tip;
	//	var txt=$(this).text();
	//	$(this).hover(function () {
	//		if(this.offsetWidth < this.scrollWidth){
	//			tip=layer.tips(txt, $(this), {
	//				tips: [3, '#2a458c'],
	//				time: 4000
	//			});
	//		}
	//	}, function () {
	//		layer.close(tip);
	//	})
	//});
	var tipp;
	var text;
	$("#allNews").on("mouseover",".NTF_secondblock", function () {
		if(this.offsetWidth < this.scrollWidth){
			text=$(this).text();
			tipp=layer.tips(text, $(this), {
				tips: [3, '#2a458c'],
				time: 4000
			});
		}
	})
	$("#allNews").on("mouseout",".NTF_secondblock", function () {
		if(this.offsetWidth < this.scrollWidth){
			layer.close(tipp);
		}
	})
},1000)