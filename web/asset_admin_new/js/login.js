$(function  () {
	//行高
	setTimeout(function  () {
		var h=$(".loginbox>div ul li").height()
		$(".loginbox>div ul li").css("line-height",h+"px")
	},10)
	window.onresize=function  () {
		var h=$(".loginbox>div ul li").height()
		$(".loginbox>div ul li").css("line-height",h+"px")
	}
	//记住密码
	var p=0;
	$(".loginbox>div div input").click(function  () {
		p++;
		if(p==1){
			$(".loginbox>div div b").css("background","url(/asset_admin_new/images/radio_select.png)");
		}else{
			$(".loginbox>div div b").css("background","url(/asset_admin_new/images/radio_07.png)");
			p=0;
		}
	})
})
