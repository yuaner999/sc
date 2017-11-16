//window.onload = function(){
//	var height = document.body.scrollHeight;
//	var width = document.body.scrollWidth;
//	var personMsg = document.getElementsByClassName("change_perMsg")[0];
//	var personPwd = document.getElementsByClassName("change_pwd")[0];
//	var personPic = document.getElementsByClassName("change_picture")[0];
//	var popup_changeMsg = document.getElementsByClassName("window_changeMsg")[0];
//	var popup_changePwd = document.getElementsByClassName("window_changePwd")[0];
//	var confirm_changeMsg = document.getElementsByClassName("window_changeMsg_confirm")[0];
//	var window_Greybg = document.getElementsByClassName("window_Greybg")[0];
//	var confirm_changePwd = document.getElementsByClassName("window_changePwd_confirm")[0];
//	var loadGrade = document.getElementsByClassName("loadGrade")[0];
//	var gradeList = document.getElementsByClassName("grade_list")[0];
//	var popup_selectMsg = document.getElementsByClassName("window_selectMsg")[0];
//	var confirm_selectMsg = document.getElementsByClassName("window_selectMsg_confirm")[0];
//	var popup_changePic = document.getElementsByClassName("window_changePicture")[0];
//	var confirm_changePic = document.getElementsByClassName("window_changePic_confirm")[0];
//	//修改头像点击事件
//	personPic.onclick=function(){
//		window_Greybg.style.height = height.toString() + "px";
//		window_Greybg.style.width = width.toString() + "px";
//		window_Greybg.style.display = "block";
//		popup_changePic.style.display = "block";
//	}
//	////修改头像的确认按钮点击事件
//	//confirm_changePic.onclick = function()
//	//{
//	//	window_Greybg.style.display = "none";
//	//	popup_changePic.style.display = "none";
//	//}
//	//修改信息点击事件
//	personMsg.onclick = function()
//	{
////		alert(height);
////		alert(width);
//		window_Greybg.style.height = height.toString() + "px";
//		window_Greybg.style.width = width.toString() + "px";
//		window_Greybg.style.display = "block";
//		popup_changeMsg.style.display = "block";
//	}
//	////修改信息弹框的确认按钮点击事件
//	//confirm_changeMsg.onclick = function()
//	//{
//	//	window_Greybg.style.display = "none";
//	//	popup_changeMsg.style.display = "none";
//	//}
//	//修改密码点击事件
//	personPwd.onclick = function()
//	{
//		window_Greybg.style.height = height.toString() + "px";
//		window_Greybg.style.width = width.toString() + "px";
//		window_Greybg.style.display = "block";
//		popup_changePwd.style.display = "block";
//	}
//	////修改密码弹框的确认按钮点击事件
//	//confirm_changePwd.onclick = function()
//	//{
//	//	window_Greybg.style.display = "none";
//	//	popup_changePwd.style.display = "none";
//	//}
//	//加载成绩单点击事件
//	loadGrade.onclick = function()
//	{
//		window_Greybg.style.width = width.toString() + "px";
//		window_Greybg.style.height = height.toString() + "px";
//		window_Greybg.style.display = "block";
//		popup_selectMsg.style.display = "block";
//	}
//	confirm_selectMsg.onclick = function()
//	{
//		window_Greybg.style.display = "none";
//		popup_selectMsg.style.display = "none";
//		gradeList.style.display = "block";
//	}
//
//}
