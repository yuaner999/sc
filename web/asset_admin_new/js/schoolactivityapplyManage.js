var rows1=10; //每页显示行数
var page1=1;//当前页码
var totalNum1;//总数据条数
var isCondition='false';
//	点击功能键'重新选择活动',弹出窗口,背景变暗
function reSelect(){
	isCondition='false';
	$("#searchVal").val('');
	$('.popup').height($(document).height());
	$("#pages").val(1);
	$("#rows").val(10);
	page1 = 1;
	rows1 = 10;
	rowdata1= '';
	activityId='';
	$("tbody").html("");
	clickStatus="";

	loadActivity();

	$('.popup').css('background-color', '#a1a1a1').slideDown(300);
	$('.dialog').slideDown(400);

}
function commit(){
	if(clickStatus!=""){
		activityId = rowdata1.activityId;

		activityParticipation= rowdata1.activityParticipation;
		//console.log(activityParticipation);
		$('#dialog').hide();
		$('.popup').slideUp(400);
		$('.dialog').slideUp(300);
		$(".currentPageNum").html(1);
		page=1;
		before_reload();
	}else{
		layer.msg("请选择一条活动");
	}

}
function close2(){
	$('#dialog').hide();
	$('.popup').slideUp(400);
	$('.dialog').slideUp(300);
}
function paging1(){
	$("#p0").html(Math.ceil( totalNum1/rows1));
	$("#p3").html(totalNum1);
	if(totalNum1<=0){
		$("#p2").html(0);
		$("#p1").html(0);
	}else if(totalNum1<page1*rows1){
		$("#p2").html(totalNum1);
		$("#p1").html(rows1*(page1-1)+1);
	}else{
		$("#p2").html(page1*rows1);
		$("#p1").html(rows1*(page1-1)+1);
	}
	//$("#p0").html(Math.ceil( totalNum1/rows1));
	//$("#p2").html(rows1*(page1-1)+1);
	//if(totalNum1<page1*rows1){
	//	$("#p2").html(totalNum1);
	//	$("#p3").html(totalNum1);
	//}else{
	//	$("#p2").html(page1*rows1);
	//	$("#p3").html(totalNum1);
	//}

	//page1= $("#page1").val();
	//rows1 = $("#rows").val();
	//$("#p0").html(Math.ceil( totalNum1/rows1));
	//$("#p3").html(totalNum);
    //
	//if(totalNum<=0){
	//	$("#p2").html(0);
	//	$("#p1").html(0);
	//	$("#p0").html(1);
	//}else if(totalNum<page*rows){
	//	$("#p2").html(totalNum);
	//	$("#p1").html(rows*(page-1)+1);
	//}else{
	//	$("#p2").html(page*rows);
	//	$("#p1").html(rows*(page-1)+1);
	//}
}
////上一页
//function turn_left1(){
//	var newpage1= parseInt($("#page1").html());
//	if(newpage1<=1){
//		newpage1=1;
//	}else{
//		newpage1=newpage1-1;
//	}
//	$("#page1").html(newpage1);
//	before_loadActivity();
//}
////下一页
//function turn_right1(){
//	var newpage2= parseInt($("#page1").html());
//	if(newpage2>=Math.ceil(totalNum1/rows1)){
//		newpage2=Math.ceil(totalNum1/rows1);
//	}else{
//		newpage2=newpage2+1;
//	}
//	$("#page1").html(newpage2);
//
//	before_loadActivity();
//
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
	var pagNum = $("#page1").html();
	if(isCondition=='true'){
		select_box(pagNum);
	}else if(isCondition=='searchM'){
		Search(pagNum);
	}else if(isCondition=='searchC'){
		searchIn(pagNum);
	}else{
		before_loadActivity();
	}
}
//下一页
function turn_right1(){
	var newpage2= parseInt($("#page1").html());
	if(newpage2>=Math.ceil(totalNum1/rows)){
		newpage2=Math.ceil(totalNum1/rows);
	}else{
		newpage2=newpage2+1;
	}
	$("#page1").html(newpage2);

	var pagNum = $("#page1").html();
	if(isCondition=='true'){
		select_box(pagNum);
	}else if(isCondition=='searchM'){
		Search(pagNum);
	}else if(isCondition=='searchC'){
		searchIn(pagNum);
	}else{
		before_loadActivity();
	}
}
//行点击事件
function rowClick1(){

	$("#tbody1").find("tr").click(function()
	{
		clickStatus='true';
		$("table tr").css('background-color','white');//先将颜色改为以前面的颜色
		$(this).css('background-color','yellow');//再将单击的那行改成需要的颜色
		//editor.html($(this).find(".newsContent").html());
		rowdata1 = $(this).data();
		activityId= rowdata1.activityId;
		//console.log(activityId);
	});
}
//下载模板
function getModels(){
	if(activityParticipation=='团体'){
		layer.msg("操作提示:参与形式为团体的活动不允许批量添加申请，若想添加申请在团体管理里添加");
		return
	}

	if(activityId!=null&&activityId!=""){
		window.open("/Files/ExcelModels/stu_activityapply.xls");
	}else{
		layer.msg("请选择一个活动")
	}
}
//新建
function Add1(){
	if(activityParticipation=='团体'){
		layer.msg("操作提示:参与形式为团体申请不允许添加，若想添加团体活动申请在团体管理里添加");
		return
	}
	postURL = addUrl;
	clickStatus = "add";
	$("#applyStudentId").removeAttr("readonly");
	if(editorName!="null"&&editorName!=""){//清除KindEditor内容
		KindEditor.instances[0].html('');
	}
	//清空表单
	document.getElementById("Form").reset();
	$("#activityTitle").val(rowdata1.activityTitle);
	$("#applyActivityId").val(rowdata1.activityId);
	rowdata=null;
	$("table tr").css('background-color','white');//先将颜色改为以前面的颜色
	$("#user_photo").attr("src","<%=request.getContextPath()%>/asset/image/default.jpg");
	$("#dlg").get(0).scrollTop=0;
	$("#title").text("新建");

	$('.popup').height($(document).height());
	$('.popup').css('background-color', '#a1a1a1').slideDown(200);
	document.getElementById("dlg-buttons1").style.display="none";
	document.getElementById("dlg-buttons").style.display="";
	$('.new').slideDown(400);
}
function before_batchInsert(){
	if(activityParticipation=='团体'){
		layer.msg("操作提示:参与形式为团体的活动不允许批量添加申请，若想添加申请在团体管理里添加");
		return
	}
	batchInsert();
}
//模糊查询
function Search1(){
	isCondition='true';
	sqlStr = $("#searchVal").val();
	page = 1;$(".currentPageNum").val(1);
	jsonPara={rows:rows,page:page,sqlStr:sqlStr};
	reload();
}
//修改
function Edit1(){

	if(clickStatus=='true'){
		clickStatus='edit';
		postURL=editUrl;
		if(!rowdata){
			layer.alert("请先选择一条数据");
			return
		}else{
			$("#applyStudentId").attr("readonly","readonly");
			$("#title").text("颁奖");
			$('.popup').height($(document).height());
			$('.popup').css('background-color', '#a1a1a1').slideDown(300);
			document.getElementById("dlg-buttons").style.display="none";
			document.getElementById("dlg-buttons1").style.display="";
			$('.new').slideDown(400);
		}
	}else{
		layer.alert("请先选择一条数据");
	}
}
//删除
function  Delete1(){
	if(!rowdata) {
		layer.alert("请先选择一条数据");
		return;
	}
		if(rowdata.activityParticipation=="团体"){
			layer.msg("团体活动申请请到团体报名管理删除。");
			return;
		}
		if(clickStatus!=""&&clickStatus!=null){
			postURL=deleteUrl;
			layer.confirm('确认删除此条数据吗?', function(result) {
				if (result) {
					//删除数据库记录
					load();
					var selectId =rowdata[deleteId];
					var deleteJsonObject = eval("(" + "{'" + deleteId + "':'" + selectId + "'}" + ")");
					$.post(postURL, deleteJsonObject, function (data) {
						if (data.result) {
							disLoad();
							clickStatus='';
							//console.log(data);
							layer.msg("删除成功");
							reload();//重新加载数据
						} else {
							layer.msg("删除失败，请重新登录或联系管理员");
						}
					});
				}
			});
		}else{
			layer.msg("请选择一条数据");
		}
}
function uploadActivityFile(){
	if(!$("#upfile").val()){
        layer.msg("请选择文件！");
		return;
	}
	if(activityId==null||activityId==''){
		layer.msg("请先选中一个活动，再进行批量上传");
	}
	load();
	$.ajaxFileUpload({
		url: "/dataupload/studentinfo.form?activityid="+activityId, //用于文件上传的服务器端请求地址
		secureuri: false, //一般设置为false
		fileElementId: "upfile", //文件上传空间的id属性
		dataType: 'String', //返回值类型 一般设置为String
		success: function (data)  //服务器成功响应处理函数
		{

			showResult(data);
			disLoad();
			reload();
		},
		error: function (data, status, e)//服务器响应失败处理函数
		{
            layer.msg("上传文件失败，请重新上传");
			disLoad();
		}
	});
}
//保存
function Save11(){
	//if($("#applyStudentId").val()==""){
	//	layer.msg("请输入学生学号");
	//	return;
	//}1
	checkNull();
	if(notNull) {//表单验证
		var jsonObject = $("#Form").serializeObject();
		jsonObject["moduleType"] = moduleType;
		if (editorName && editorName != "null") {
			editor.sync();
			jsonObject[editorName] = $("#" + editorName).val();
		}
		if (!jsonObject["politicsStatusDate"]) {
			jsonObject["politicsStatusDate"] = null;
		}
		if (!jsonObject["studentBirthday"]) {
			jsonObject["studentBirthday"] = null;
		}
		if(clickStatus=='edit'){
			jsonObject[editId]=rowdata[editId];
		}
		if(clickStatus == "add"){
			jsonObject["applyActivityId"]=activityId;
		}
		if(jsonObject["activityAward"]=="其它"){
			jsonObject["activityAward"]=$("#otherAward").val();
		}
		close();
		load();
		UploadToDatabase(jsonObject);
	}else {
		layer.msg("请按照要求填写");
		return;
	}
}

//刷新按钮
function refresh1(){
	$("#pages").val(1);
	$("#rows").val(10);
	jsonPara={rows:10,page:1,sqlActivityId:activityId};
	reload();
}

//分页加载
function paging0(){
	if(totalNum==null||totalNum==""||activityId==""){
		$("#pages").val(0);
		$(".pageNum").eq(0).html('0');
		$(".pageNum").eq(1).html('0');
		$(".pageNum").eq(2).html('0');
		$(".pageNum").eq(3).html('0');
		return;
	}
	$(".pageNum").eq(0).html(Math.ceil( totalNum/rows));
	$(".pageNum").eq(1).html(rows*(page-1)+1);
	if(totalNum<page*rows){
		$(".pageNum").eq(2).html(totalNum);
		$(".pageNum").eq(3).html(totalNum);
	}else{
		$(".pageNum").eq(2).html(page*rows);
		$(".pageNum").eq(3).html(totalNum);
	}

	//page1= $("#page1").html();
	//rows1 = $("#rows").val();
	//$("#p0").html(Math.ceil( totalNum1/rows1));
	//$("#p3").html(totalNum);
    //
	//if(totalNum<=0){
	//	$("#p2").html(0);
	//	$("#p1").html(0);
	//	$("#p0").html(1);
	//}else if(totalNum<page*rows){
	//	$("#p2").html(totalNum);
	//	$("#p1").html(rows*(page-1)+1);
	//}else{
	//	$("#p2").html(page*rows);
	//	$("#p1").html(rows*(page-1)+1);
	//}
}
//上一页
function turn_left0(){
	if(activityId==""){
		$("#pages").val("0");
		$(".pageNum").eq(0).html('0');
		$(".pageNum").eq(1).html('0');
		$(".pageNum").eq(2).html('0');
		$(".pageNum").eq(3).html('0');
		return;
	}
	var newpage1= parseInt($(".currentPageNum").val());
	if(newpage1<=1){
		newpage1=1;
	}else{
		newpage1=newpage1-1;
	}
	$("#pages").val(newpage1);
	before_reload();
}
//下一页
function turn_right0(){
	if(activityId==""){
		$("#pages").val("0");
		$(".pageNum").eq(0).html('0');
		$(".pageNum").eq(1).html('0');
		$(".pageNum").eq(2).html('0');
		$(".pageNum").eq(3).html('0');
		return;
	}
	var newpage2= parseInt($(".currentPageNum").val());

	if(newpage2>=Math.ceil(totalNum/rows)){
		newpage2=Math.ceil(totalNum/rows);
	}else{
		newpage2=newpage2+1;
	}
	$("#pages").val(newpage2);

	before_reload();

}