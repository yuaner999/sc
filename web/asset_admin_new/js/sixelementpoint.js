var rows1 =10;
var page1 = 1;
function close2(){
	$('#dialog').hide();
	$('.popup').slideUp(400);
	$('.dialog').slideUp(300);
	page = 1 ;
	rows = 10;
	clickStatus="";
	jsonPara="";
	//reload();
}
function paging1(){
	$("#p0").html(Math.ceil( totalNum1/rows1));
	if(page1==0) $("#p1").html(0);
	else $("#p1").html(rows1*(page1-1)+1);
	if(totalNum1<page1*rows1){
		$("#p2").html(totalNum1);
		$("#p3").html(totalNum1);
	}else{
		$("#p2").html(page1*rows1);
		$("#p3").html(totalNum1);
	}
}
//function paging1(){
//	$(".pageNum1").eq(0).html(Math.ceil( totalNum/rows));
//	$(".pageNum1").eq(1).html(rows*(page-1)+1);
//	if(totalNum<page*rows){
//		$(".pageNum1").eq(2).html(totalNum);
//		$(".pageNum1").eq(3).html(totalNum-(rows*(page-1)+1)+1);
//		console.log(totalNum-(rows*(page-1)+1)+1);
//	}else{
//		$(".pageNum1").eq(2).html(page*rows);
//		$(".pageNum1").eq(3).html(totalNum);
//	}
//}
//上一页
function turn_left1(){
	var newpage1= parseInt($("#page1").html());
	if(newpage1<=1){
		newpage1=1;
	}else{
		newpage1=newpage1-1;
	}
	$("#page1").html(newpage1);
	page1=newpage1;
	loadActivityPointCount(studentId);
}
////上一页
//function turn_left1(){
//	var newpage1= parseInt($(".currentPageNum").val());
//	if(newpage1<=1){
//		newpage1=1;
//	}else{
//		newpage1=newpage1-1;
//	}
//	$(".currentPageNum").val(newpage1);
//	loadActivityPointCount();
//}
//下一页
function turn_right1(){
	var newpage2= parseInt($("#page1").html());
	if(newpage2>=Math.ceil(totalNum1/rows1)){
		newpage2=Math.ceil(totalNum1/rows1);
	}else{
		newpage2=newpage2+1;
	}
	$("#page1").html(newpage2);
	page1=newpage2;
	loadActivityPointCount(studentId);

}


////下一页
//function turn_right1(){
//	var newpage2= parseInt($(".currentPageNum").val());
//
//	if(newpage2>=Math.ceil(totalNum/rows)){
//		newpage2=Math.ceil(totalNum/rows);
//	}else{
//		newpage2=newpage2+1;
//	}
//	$(".currentPageNum").val(newpage2);
//
//	loadActivityPointCount();
//
//}
//刷新按钮
function refresh1(){
	jsonPara={rows:10,page:1};
	loadActivityPointCount();
}
function clear_search(){
	$("#_studentID").val("");
	$("#_studentName").val("");
	$("#_stuCollageName").val("");
	$("#_activityLocation").val("");
	$("#_stuClassName").val("");
	$("#_stuGradeName").val("");

}