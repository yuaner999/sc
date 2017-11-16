$(document).ready(function() {
	$(".button").click(function () {
		$(".report").css('display', 'block');
		$(".shadow").css('display', 'block');
		$(":text").val("");
		$("textarea").val("");
	});
	$(".selectright").click(function () {
		if ($(".select-one").css("display") == "none") {
			$(".select-one").css('display', 'block');
			$(".select-two").css('display', 'block');
			$(".select").css('display', 'none');
		}
		else {
			$(".select-one").css('display', 'none');
			$(".select-two").css('display', 'none');
			$(".select").css('display', 'block');
		}
	});
	$(".select-one").click(function () {
		$(".select").css('display', 'block');
		$('.select').html('举报');
		$(".select-one").css('display', 'none');
		$(".select-two").css('display', 'none');
	});
	$(".select-two").click(function () {
		$(".select").css('display', 'block');
		$('.select').html('质疑');
		$(".select-one").css('display', 'none');
		$(".select-two").css('display', 'none');
	});

	$(".stuWindow>b,.stuWindow>button").on("click", function () {
		closestu();
	})
	$("body").on("click", ".stuInfo", function () {
		openstu(this);
		hehe();
	})
});
	//学生信息弹窗
	function closestu(){
		$(".window_Greybg").slideUp(200);
		$(".stuWindow").html();
		$(".stuWindow").hide(200);
	}
	function openstu(btn) {
		$(".window_Greybg").slideDown(200);
		$(".stuWindow").show(200);
		var row = $(btn).parents(".list-one").data();
		var aclass="";
		switch (row.activityClass){
			case ("1"):
				aclass="思想政治教育类";
				break;
			case ("2"):
				aclass="能力素质拓展类";
				break;
			case ("3"):
				aclass="学术科技与创新创业类";
				break;
			case ("4"):
				aclass="社会实践与志愿服务类";
				break;
			case ("5"):
				aclass="社会工作与技能培训类";
				break;
			case ("6"):
				aclass="综合奖励及其他类";
				break;
			default:
				aclass="其他";
				break;
		}
		top_zy(row);
		$(".middle b").html(aclass);
		if (row) {
			if (row.activityClass == '3' || row.activityClass== '5') {
				if (row.supType == "非活动类") {
					other(row);
				}else {
					five(row);
				}

			} else if (row.activityClass == '1' || row.activityClass == '2' || row.activityClass == '4') {
				//显示5个字段
				five(row);
			}else if(row.activityClass == '6'){
				other(row);
			}
		}
	}
function top_zy(row){
	$(".top #name").html(row.studentName);
	$(".top #college").html(row.stuCollageName);
	$(".top #major").html(row.stuMajorName);
	$(".top #class").html(row.stuClassName);
	$(".top #stuId").html(row.studentID);
}
function five(row){
	var alevel = "";
	var actpower="";
	switch (row.activityLevle) {
		case ("0"):
			alevel = "国际级";
			break;
		case ("1"):
			alevel = "国家级";
			break;
		case ("2"):
			alevel = "省级";
			break;
		case ("3"):
			alevel = "市级";
			break;
		case ("4"):
			alevel = "校级";
			break;
		case ("5"):
			alevel = "院级";
			break;
		case ("6"):
			alevel = "团支部级";
			break;
		default:
			alevel = "其他";
			break;
	}
	actpower=row.activityPowers.replace(/能力/gi,"").replace(/\|/gi,"、");
	var time;
	if(row.activitySdate1||row.activityEdate1){
		time=row.activitySdate1+ '--' +row.activityEdate1;
	}else{
		time=row.signUpTime1;
	}
	$("#first p").html("活动标题");
	$("#first span").html(row.activityTitle);
	$("#secound p").html("活动时间");
	$("#secound span").html(time);
	$(".last p").html("活动级别");
	$(".last span").html(alevel);
	$("#one p").html("增加能力");
	$("#one span").html(actpower);
	$("#two p").html("获得奖项");
	$("#two span").html(row.activityAward);
	$("#one").show();
	$("#two").show();
}
function other(row) {
	var time;
	if(row.activitySdate1||row.activityEdate1){
		time=row.activitySdate1+ '--' +row.activityEdate1;
	}else{
		time=row.signUpTime1;
	}
	if (row.workName != null || row.shipName != null || row.scienceName != null) {
		if (row.workName) {
			$("#first p").html("任职");
			$("#first span").html("学生干部");
			$("#secound p").html("组织类型");
			$("#secound span").html(row.workClass);
			$("#last p").html("组织名称");
			$(".last span").html(row.orgname);
			$("#one p").html("职务名称");
			$("#one span").html(row.workName);
			$("#two p").html("任职时间");
			$("#two span").html(time);
			$("#one").show();
			$("#two").show();
		} else if (row.shipName) {
			$("#first p").html("荣誉称号类");
			$("#first span").html("奖学金/称号");
			$("#secound p").html("名称");
			$("#secound span").html(row.shipName);
			$(".last p").html("日期");
			$(".last span").html(time);
			$("#one").hide();
			$("#two").hide();
		} else if (row.scienceName){
			$("#first p").html("学术科技");
			$("#first span").html(row.scienceClass);
			$("#secound p").html("标题");
			$("#secound span").html(row.scienceName);
			$(".last p").html("参与时间");
			$(".last span").html(time);
			$("#one").hide();
			$("#two").hide();
		}
	}

}
function hehe(){
	setTimeout(function () {
		$(".stuWindow .top li span").map(function () {
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
			});
		})
	},500);
}