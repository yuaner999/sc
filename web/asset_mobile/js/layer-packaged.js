/*
 * 
 * 李文爽 2017/06/01
 * 基于layer_mobile.js
 * 功能：封装了一些layer-mobile 的功能
 * 
 */
//关闭所有
function l_closeAll () {
	layer.closeAll();
}
//提示信息              参数  （1内容，2时间 整数秒）
function l_msg (txt,t){
	var arg=arguments;
	if(arg.length>3){
		console.error('l_msg()参数过多，最多3位');
		return;
	}else if(arg.length==0){
		console.error('l_msg()未传入参数');
		return;
	}
	var txt=(function  () {
		for(i=0;i<arg.length;i++){
			if(typeof arg[i] == 'string'){
				return arg[i];
			}
		}
		return '';
	})()
	var t=(function  () {
		for(i=0;i<arg.length;i++){
			if(typeof arg[i] == 'number'){
				return arg[i];
			}
		}
		 return parseFloat(arg[1]);
	})()
	var end=(function  () {
		for(i=0;i<arg.length;i++){
			if(typeof arg[i] == 'function'){
				return arg[i];
			}
		}
		return null;
	})()
	layer.open({
		content:txt
		,skin:'footer'
		,time:t || 2
		,shade:'background-color:rgba(30,30,30,0)'
		,end:end
	});
}
//加载中 loading 参数 （1时间，2内容可选）
function l_loading (txt,t) {
	if(typeof txt=== 'number'){
		if(typeof t==='string'){
			var txt2=txt;
			txt=t;
			t=txt2;
		}
	}else if(typeof t==='string'){
		t=parseInt(t);
	}
	layer.open({
		type:2,
		time:t || 2000,
		content:txt || null,
		shade:'background-color:rgba(30,30,30,0)',
		shadeClose:false,
	});
}
//警告框 alert   
function l_alert (txt,btnTxt,yesFn) {
	var arg=arguments;
	if(typeof arg[1] === 'string'){
		var btxt=arg[1];
	}else{
		var btxt='我知道了';
	}
	layer.open({
		content:txt || ' '
		,btn:btxt
		,shade:'background-color:rgba(30,30,30,.3)'
		,yes:function  (index) {
			for(i=0;i<arg.length;i++){
				if(typeof arg[i] === 'function'){
					arg[i]();
				}
			}
			layer.close(index);
		},
	});
}
//确认取消 框
function l_confirm (title,yesFn,noFn,btn) {
	layer.open({
    	content: title
    	,className:'l_confirm'
    	,btn:btn || ["确定","取消"]
    	,yes: yesFn
    	,no: noFn
		,shade:'background-color:rgba(30,30,30,.3)'
	});	
}