function sended (obj) {
	var t=60;
	obj.addClass('disabled');
	obj.off('tap');
	obj.text("重新发("+t+")");
	var timer=setInterval(_time,1000);
	function _time () {
		t--;
		obj.text("重新发("+t+")");
		if(t==0){
			clearInterval(timer);
			t=60;
			obj.removeClass('disabled');
			obj.text("发送");
			obj.on('tap',function  () {
				btnTap($(this));
			})
		}
	}
}