/**
 * Created by pjj on 2016/10/24.
 *
 *
 * ！！！！！！！！！！！！禁止修改此JS文件！！！！！！！！！！！！
 * ！！！！！！！！！！！！禁止修改此JS文件！！！！！！！！！！！！
 * ！！！！！！！！！！！！禁止修改此JS文件！！！！！！！！！！！！
 * ！！！！！！！！！！！！禁止修改此JS文件！！！！！！！！！！！！
 * ！！！！！！！！！！！！禁止修改此JS文件！！！！！！！！！！！！
 */
var postURL = "";//请求的URL地址
var oldPicture = "";
var clickStatus = "";//点击状态
var fileUpload="";
var rowdata ;//行数据
var rows=10; //每页显示行数
var page=1;//当前页码
var totalNum = 1;//总数据条数
var notNull = false; //表单验证
//新建
function Add(){
	postURL = addUrl;
	clickStatus = "add";
	if(editorName!="null"&&editorName!=""){//清除KindEditor内容
		KindEditor.instances[0].html('');
	}
	//清空表单
	document.getElementById("Form").reset();
	rowdata=null;
	$("table tr").css('background-color','white');//先将颜色改为以前面的颜色
	$("#user_photo").attr("src","<%=request.getContextPath()%>/asset/image/default.jpg");
	$("#newsImgs").attr("src","<%=request.getContextPath()%>/asset/image/default.jpg");
	$("#dlg").get(0).scrollTop=0;
	$("#tpy").text("新建");
	$('.popup').height($(document).height());
	$('.popup').css('background-color', '#a1a1a1').slideDown(200);
	$('.new').slideDown(400);
}
//删除
function  Delete(){
	if(!rowdata) {
		layer.alert("请先选择一条数据");
		return
	}
	if(clickStatus!=""&&clickStatus!=null){
		postURL=deleteUrl;
		layer.confirm('确认删除此条数据吗?', function(result) {
			if (result) {
				//删除数据库记录

				var selectId =rowdata[deleteId];
				var deleteJsonObject = eval("(" + "{'" + deleteId + "':'" + selectId + "'}" + ")");
				$.post(postURL, deleteJsonObject, function (data) {
					if (data.result) {

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

//修改
function Edit(){
	clickStatus='edit';
	postURL=editUrl;
	if(!rowdata){
		layer.alert("请先选择一条数据");
		return
	}else{
		$("#tpy").text("修改");
		$('.popup').height($(document).height());
		$('.popup').css('background-color', '#a1a1a1').slideDown(300);
		$('.new').slideDown(400);
	}
}

//保存
function Save(){
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
		load();
		if (imageUpload == null || imageUpload == "") {//如果没有图片上传
			if (!fileUpload) {//如果没有文件上传
				UploadToDatabase(jsonObject);
			} else {//有文件上传
				if ($("#" + fileUpload).val() != null && $("#" + fileUpload).val() != "") {
					ajaxFileUpload("/FileUpload/No_Intercept_Upload.form", fileUpload, jsonObject, 2);
				} else {
					UploadToDatabase(jsonObject);
				}
			}
		} else {//有图片上传
			if ($("#" + imageUpload).val() != null && $("#" + imageUpload).val() != "") {
				ajaxFileUpload("/ImageUpload/No_Intercept_Upload.form", imageUpload, jsonObject, 1);
			} else {
				if (!fileUpload) {//如果没有文件上传
					UploadToDatabase(jsonObject);
				} else {//有文件上传
					if ($("#" + fileUpload).val() != null && $("#" + fileUpload).val() != "") {
						ajaxFileUpload("/FileUpload/No_Intercept_Upload.form", fileUpload, jsonObject, 2);
					} else {
						UploadToDatabase(jsonObject);
					}
				}
			}
		}
	}else {
		layer.msg("请按照要求填写");
		return;
	}
}
//序列化
$.fn.serializeObject = function()
{
	var o = {};
	var a = this.serializeArray();
	$.each(a, function() {
		if (o[this.name]) {
			if (!o[this.name].push) {
				o[this.name] = [o[this.name]];
			}
			o[this.name].push(this.value || '');
		} else {
			o[this.name] = this.value || '';
		}
	});
	return o;
};

//弹出加载层
function load() {
	layer.load(1, {
		shade: [0.1,'#fff']//0.1透明度的白色背景
	});
	//$("<div class=\"datagrid-mask\" style='z-index: 9999999999999999999;'></div>").css({ display: "block", width: "100%", height: $(window).height() }).appendTo("body");
	//$("<div class=\"datagrid-mask-msg\" style='z-index: 9999999999999999999;'></div>").html("正在加载，请稍候...").appendTo("body").css({ display: "block", left: ($(document.body).outerWidth(true) - 190) / 2, top: ($(window).height() - 45) / 2 });
}

//取消加载层
function disLoad() {
	//$(".datagrid-mask").remove();
	//$(".datagrid-mask-msg").remove();
	layer.closeAll('loading');
}

//文件(图片)上传
function ajaxFileUpload(url,id,jsonObject,time){
	$.ajaxFileUpload({
		url: url, //用于文件上传的服务器端请求地址
		secureuri: false, //一般设置为false
		fileElementId: id, //文件上传空间的id属性
		dataType: 'String', //返回值类型 一般设置为String
		success: function (data, status)  //服务器成功响应处理函数
		{
			if(data!=""||data!=null){
				var data = eval("(" + data + ")");
				if(typeof(data.error) != 'undefined') {
					if (data.error == 0) {
						jsonObject[id] = data.filename;
						//如果time为1，证明图片已经上传完成，该上传文件，判断是否需要上传文件
						if(time==1&&fileUpload!=""&&$("#"+fileUpload).val()!=null&&$("#"+fileUpload).val()!=""){
							ajaxFileUpload("/FileUpload/No_Intercept_Upload.form",fileUpload,jsonObject,2);
						}else {
							UploadToDatabase(jsonObject);
						}
					} else {
						layer.msg("上传文件出错："+data.message);
						disLoad();
					}
				}else{
					layer.msg("上传文件出错："+data.message);
					disLoad();
				}
			}else {
				layer.msg("上传文件失败，请重新上传");
				disLoad();
			}
		},
		error: function (data, status, e)//服务器响应失败处理函数
		{
			layer.msg("上传文件失败，请重新上传");
			disLoad();
		}
	});
}

//上传数据到数据库
function UploadToDatabase(jsonObject){
	$.ajax({
		url:postURL,
		type:"post",
		dataType:"json",
		data:jsonObject,
		success:function(data){
			disLoad();
			if(data.result){
				//console.log(data.result);
				close();
				layer.msg("保存成功");

			}else {
				layer.msg("保存中出现错误");
			}
		},
		error:function(){
			disLoad();
			layer.msg("服务器连接失败");
		},
		complete: function(XMLHttpRequest, textStatus) {
			reload();
		}
	})

}
//格式化日期把毫秒值转成字符串
function DateFormat(time,formateStr){
	var date;
	if(!formateStr) formateStr="yyyy-MM-dd";
	if(time)  date=new Date(time);
	else date=new Date();
	var year=date.getFullYear();
	var month=date.getMonth()+1;
	var day=date.getDate();
	var h=date.getHours();
	var min=date.getMinutes();
	var sec=date.getSeconds();
	formateStr=formateStr.replace("yyyy",""+year);
	formateStr=formateStr.replace("MM",""+month>9?month:"0"+month);
	formateStr=formateStr.replace("dd",""+day>9?day:"0"+day);
	formateStr=formateStr.replace("HH",""+h>9?h:"0"+h);
	formateStr=formateStr.replace("mm",""+min>9?min:"0"+min);
	formateStr=formateStr.replace("ss",""+sec>9?sec:"0"+sec);
	return formateStr;
}

//关闭按钮
function close(){
	$('#dlg').hide();
	$('.popup').slideUp(400);
	$('.new').slideUp(300);
    $("table tr").css('background-color','white');
	rowdata=null;
}
//行点击事件
function rowClick(){

	$("tbody tr").click(function()
	{
		clickStatus='true';
		$("table tr").css('background-color','white');//先将颜色改为以前面的颜色
		$(this).css('background-color','yellow');//再将单击的那行改成需要的颜色
		$("tbody .selected_tr").removeClass("selected_tr");
		$(this).addClass("selected_tr");
		//editor.html($(this).find(".newsContent").html());
		rowdata = $(this).data();
		if(rowdata){
			for(var key in rowdata){
				//如果包含时间特殊处理
				if(key.indexOf("date")>0||key.indexOf("Date")>0){
					//	console.log(rowdata[key]);
					//rowdata[key]=DateFormat(rowdata[key]);
				}
				var name = $("#"+key).attr("name");
				if(!name){
					continue;
				}
				//如果包含图片特殊处理
				if(name.indexOf("Img")>=0){
					$("#"+key+"s").attr("src",'/Files/Images/'+rowdata[key]);
					continue;
				}
				//如果包含图片特殊处理
				if(name.indexOf("Photo")>=0){
					$("#"+key+"s").attr("src",'/Files/Images/'+rowdata[key]);
					continue;
				}
				//为KindEditor赋值
				if(editorName!="null"){
					KindEditor.instances[0].html(rowdata[editorName]);
				}
				$("#"+key).val(rowdata[key]);
			}
		}

	});
}
//分页加载
function paging(){
	if($(".currentPageNum").val()==0){
		$(".currentPageNum").val("1");
	}
	page= $(".currentPageNum").val();
	rows = $("#rows").val();
	$(".pageNum").eq(0).html(Math.ceil( totalNum/rows));
	$(".pageNum").eq(3).html(totalNum);
	if(totalNum<=0){
		$(".currentPageNum").val("0");
		page=$(".currentPageNum").val("0");
		$(".pageNum").eq(2).html(0);
		$(".pageNum").eq(1).html(0);
	}else if(totalNum<=page*rows){
		$(".pageNum").eq(2).html(totalNum);
		$(".pageNum").eq(1).html(rows*(page-1)+1);
	}else{
		$(".pageNum").eq(2).html(page*rows);
		$(".pageNum").eq(1).html(rows*(page-1)+1);
	}

	//if(totalNum==null||totalNum==""){
	//	$("#pages").val(0);
	//	$(".pageNum").eq(0).html('0');
	//	$(".pageNum").eq(1).html('0');
	//	$(".pageNum").eq(2).html('0');
	//	$(".pageNum").eq(3).html('0');
	//	page= $(".currentPageNum").val('0');
	//	rows = $("#rows").val('10');
	//	return;
	//}
    //
	//$(".pageNum").eq(0).html(Math.ceil( totalNum/rows));
	//$(".pageNum").eq(1).html(rows*(page-1)+1);
	//if(totalNum<page*rows){
	//	$(".pageNum").eq(2).html(totalNum);
	//	$(".pageNum").eq(3).html(totalNum);
	//}else{
	//	$(".pageNum").eq(2).html(page*rows);
	//	$(".pageNum").eq(3).html(totalNum);
	//}
}
//上一页
function turn_left(){
	var newpage1= parseInt($(".currentPageNum").val());
	if(newpage1<=1){
		newpage1=1;
	}else{
		newpage1=newpage1-1;
	}
	$(".currentPageNum").val(newpage1);
	/*before_reload();*/
	var pagNum = $(".currentPageNum").val();

	select_box(newpage1);
}
//综合查询
function select_box(page) {
	var jsonObject = $("#Form1").serializeObject();
	jsonObject["sqlStr"]=$("#searchVal").val();
	jsonObject["rows"] = $("#rows").val() ;

	if(Math.ceil(totalNum/$("#rows").val())<page){
		page=Math.ceil(totalNum/$("#rows").val());
	}
	if(page<=0){
		page=1;
	}
	jsonObject["page"] = page;
	$(".currentPageNum").val(page);
	jsonPara=jsonObject;
	$('.searchContent').slideUp();
	reload();
}

//下一页
function turn_right(){
	var newpage2= parseInt($(".currentPageNum").val());

	if(newpage2>=Math.ceil(totalNum/rows)){
		newpage2=Math.ceil(totalNum/rows);
	}else{
		newpage2=newpage2+1;
	}
	$(".currentPageNum").val(newpage2);

	/*before_reload();*/
	var pagNum = $(".currentPageNum").val();

	select_box(newpage2);

}
//回车事件：为加载某页
//document.onkeydown=function(event){
//	var e = event || window.event || arguments.callee.caller.arguments[0];
//	if(e && e.keyCode==13){ // enter 键
//
//		before_reload();
//	}
//};
/**
 * 批量导入按键
 */
function batchInsert(){
	document.getElementById("batch_dlg").style.display="";//显示
}
function batchInsertClose(){
	document.getElementById("batch_dlg").style.display="none";//不显示
}
/**
 * 验证文件
 */
function validFile(){
	if(!$("#upfile").val()){
		layer.msg("请选择文件！");
		return;
	}
	load();
	$.ajaxFileUpload({
		url: "/dataupload/validdata.form", //用于文件上传的服务器端请求地址
		secureuri: false, //一般设置为false
		fileElementId: "upfile", //文件上传空间的id属性
		dataType: 'String', //返回值类型 一般设置为String
		success: function (data, status)  //服务器成功响应处理函数
		{
			//console.log(data);
			showResult(data);
			disLoad();
		},
		error: function (data, status, e)//服务器响应失败处理函数
		{
			layer.msg("上传文件失败，请重新上传");
			disLoad();
		}
	});
}
/**
 * 上传文件
 */
function uploadFile(){
	if(!$("#upfile").val()){
		layer.msg("请选择文件！");
		return;
	}
	load();
	$.ajaxFileUpload({
		url: "/dataupload/studentinfo.form", //用于文件上传的服务器端请求地址
		secureuri: false, //一般设置为false
		fileElementId: "upfile", //文件上传空间的id属性
		dataType: 'String', //返回值类型 一般设置为String
		success: function (data)  //服务器成功响应处理函数
		{
			//console.log(data);
			showResult(data);
			disLoad();
		},
		error: function (data, status, e)//服务器响应失败处理函数
		{
			layer.msg("上传文件失败，请重新上传");
			disLoad();
		}
	});
}

function uploadActivityFile(){
	if(!$("#upfile").val()){
		ShowMsg("请选择文件！");
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
			ShowMsg("上传文件失败，请重新上传");
			disLoad();
		}
	});
}
/**
 * 上传文件后显示服务器返回的信息
 * @param data
 */
function showResult(data){
	$("#valid_result").html("");
	//去除返回字符串的  <pre style="word-wrap: break-word; white-space: pre-wrap;"> 标签
	var str=data.substring(data.indexOf('>')+1,data.lastIndexOf('<'));
	var s= eval("("+str+")");
	var str=s.msg+"<br>";
	if(s.data){
		$.each(s.data,function(){
			if(this.data){
				str+="&nbsp;&nbsp;"+this.msg+"<br>";
				$.each(this.data,function(){
					str+="&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;"+this+"<br>";
				})
			}else{
				str+="&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;"+this+"<br>";
			}

		});
	}
	$("#valid_result").html(str);
}
////下载模版文件
//function getModel(){
//	window.open("/Files/ExcelModels/students_info.xls");
//}
//模糊查询
function Search(){
	sqlStr = $("#searchVal").val();
	page = 1;$(".currentPageNum").val(1);
	jsonPara={rows:rows,page:page,sqlStr:sqlStr};
	reload();
}
$(function(){
	//过滤下拉
	$("#filter").change(function(){
		filter=$("#filter").val();
		sqlStr = $("#searchVal").val();
		page = 1;$(".currentPageNum").val(1);
		jsonPara={rows:rows,page:page,sqlStr:sqlStr,filter:filter};
		reload();
	});
	//点击关闭
	$(".iconConcel").click(function(){
		$('.new').slideUp(300);
		$('.popup').slideUp(400);
        $("table tr").css('background-color','white');
		rowdata=null;
	});
});
//刷新按钮
//function refresh(){
//	jsonPara={rows:10,page:1};
//	reload();
//}
//刷新当期页面
function reload_this(){
	window.location.reload();
}
$("#searchVal").keydown(function(event){

	var e = event || window.event || arguments.callee.caller.arguments[0];
	if(e==13){
		Search();

	}
})
//表单验证判断（将需要判断的input标签，添加class="notNull" 属性）
function checkNull(){
	for(var i = 0;i<$(".notNull").length;i++){
		if(!$(".notNull").eq(i).val()){
			return;
		}
	}
	notNull= true ;
}