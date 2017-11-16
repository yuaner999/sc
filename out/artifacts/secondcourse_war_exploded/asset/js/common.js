//===============================验证表单===============================//

//验证手机号码
function _phone(phoneum){
	var phoneRegex = /^(((13|15|18)[0-9])|14[57]|17[0134678])\d{8}$/;
	if (!phoneRegex.test(phoneum)){
		return false;
	}
	return true;
}

//验证邮箱
function _email(email)
{
	var result = email.match(/^\w+((-\w+)|(\.\w+))*\@[A-Za-z0-9]+((\.|-)[A-Za-z0-9]+)*\.[A-Za-z0-9]+$/);
	if(result==null) {
		return false;
	}
	return true;
}

//验证验证身份证
function isCardNo(card)
{
   	// 身份证号码为15位或者18位，15位时全为数字，18位前17位为数字，最后一位是校验位，可能为数字或字符X
   	var reg = /(^\d{15}$)|(^\d{18}$)|(^\d{17}(\d|X|x)$)/;
   	if(reg.test(card) === false)
   	{
       	return false;
   	}else{
   		return true;
   	}
}

//获取URL参数
function GetQueryString(name)
{
	var reg = new RegExp("(^|&)"+ name +"=([^&]*)(&|$)");
	var r = window.location.search.substr(1).match(reg);
	if(r!=null)return  unescape(r[2]); return null;
}

/*
 *	只能输入数字
 *	onkeyup="value=value.replace(/[^\d]/g,'')"
 * 
 * 
 * 
 * 
 * 
 * */