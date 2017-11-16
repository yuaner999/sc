setTimeout(function () {
	$(".content>li li>div p a").map(function () {
		var tip;
		var txt=$(this).text();
		$(this).hover(function () {
			if(this.offsetWidth < this.scrollWidth){
				tip=layer.tips(txt, $(this), {
					tips: [3, '#5c85ee'],
					time: 4000
				});
			}
		}, function () {
			layer.close(tip);
		})
	})
},1000);
$(function(){
	/*给所有imput输入框添加校验不可以输入‘<’与‘>’*/
	$("input").bind("input", function(){
		var thisVal = $(this).val();
		var thisVal1 = " " + thisVal;
		if(thisVal1.indexOf("<") > 0 || thisVal1.indexOf(">") > 0){
			$(this).val(thisVal.replace('<','').replace('>',''));
		}
	});
});