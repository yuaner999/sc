/*
 * 
 * 
//李文爽 2017.06.02
	原生js写法，不依赖其他库
	这是一个滑动对象，判断手机端里用户滑动事件
 * 
 * 
 * 
 */
var toucher={
	tBegin:{},
	tEnd:{},
	touchstart:function (obj) {
		obj=obj || window;
		obj.addEventListener('touchstart',function  (e) {
			toucher.tBegin={
				x:e.touches[0].clientX,
				y:e.touches[0].clientY,
			};
			toucher.tEnd={
				x:e.touches[0].clientX,
				y:e.touches[0].clientY,
			};
		});
	},
	touchmove:function (obj) {
		obj=obj || window;
		obj.addEventListener('touchmove',function  (e) {
			toucher.tBegin={
				x:toucher.tEnd.x,
				y:toucher.tEnd.y,
			};
			toucher.tEnd={
				x:e.touches[0].clientX,
				y:e.touches[0].clientY,
			};
			toucher.flagPosi();
		});
	},
	touchend:function (obj) {
		obj=obj || window;
		obj.addEventListener('touchend',function  (e) {
//			toucher.flagPosi();
		});
	},
	flagPosi:function(){
		if(this.tBegin.x<this.tEnd.x){
			if(this.tBegin.y<this.tEnd.y){
				if(this.tEnd.y-this.tBegin.y>this.tEnd.x-this.tBegin.x){
					this.goBottom();
				}else{
					this.goRight();
				}
			}
			else if(this.tBegin.y>this.tEnd.y){
				if(this.tBegin.y-this.tEnd.y>this.tEnd.x-this.tBegin.x){
					this.goTop();
				}else{
					this.goRight();
				}
			}
			else{
				this.goRight();
			}
		}else if(this.tBegin.x>this.tEnd.x){
			if(this.tBegin.y<this.tEnd.y){
				if(this.tEnd.y-this.tBegin.y>this.tBegin.x-this.tEnd.x){
					this.goBottom();
				}else{
					this.goLeft();
				}
			}
			else if(this.tBegin.y>this.tEnd.y){
				if(this.tBegin.y-this.tEnd.y>this.tBegin.x-this.tEnd.x){
					this.goTop();
				}else{
					this.goLeft();
				}
			}
			else{
				this.goLeft();
			}
		}
		else{
			if(this.tBegin.y<this.tEnd.y){
				this.goBottom();
			}else if(this.tBegin.y>this.tEnd.y){
				this.goTop();
			}
		}
		
	},
	goTop:function  () {
	},
	goBottom:function  () {
	},
	goLeft:function(){
	},
	goRight:function(){
	},
	init:function  (obj) {
		this.touchstart(obj),this.touchmove(obj),this.touchend(obj);
	}
};
$(function  () {
//	初始化滑动项
	toucher.goBottom=function  () {
		var obj=$('.navigator~.container');
		if(obj.get(0).scrollHeight==obj.height()){
			$('.navigator').addClass('no-ani');
		}else{
			$('.navigator').removeClass("no-ani");
			$('.navigator').addClass("ani-down");
		}
	}
	toucher.goTop=function  () {
		var obj=$('.navigator~.container');
		if(obj.get(0).scrollHeight==obj.height()){
			$('.navigator').addClass('no-ani');
		}else{
			$('.navigator').removeClass("no-ani");
			$('.navigator').removeClass("ani-down");
		}
	}
	toucher.init();
});

//传入元素选择器，选择的元素当发生下拉时执行callback回调
function dropDownLoad (obj,callback) {
	var posi,posiEnd;
	var o=document.querySelector(obj);
	
	o.addEventListener('touchstart', function(event) {
		posi={
			y:event.touches[0].clientY,
		};
		posiEnd={
			y:event.touches[0].clientY,
		};
	});
	o.addEventListener('touchmove', function(event) {
		posiEnd={
			y:event.touches[0].clientY,
		};
	});
	o.addEventListener('touchend', function(event) {
		if(posiEnd.y<posi.y){
			if(this.scrollHeight-this.scrollTop<=$(this).height()+73){
				callback();
			}
		}
	});

}
function dropLeftLoad (obj,callback) {
	var posi,posiEnd,t,timer;
    var o=document.querySelectorAll(obj);
    for(i=0;i<o.length;i++){
    	o[i].addEventListener('touchstart',function  (e) {
			t=0;
			timer=setInterval(function () {
				t+=10;
			},10);
            posi={
                x:e.touches[0].clientX,
				y:e.touches[0].clientY
            };
            posiEnd={
                x:e.touches[0].clientX,
				y:e.touches[0].clientY
            };
        });
        o[i].addEventListener('touchmove',function  (e) {
            posiEnd={
                x:e.touches[0].clientX,
				y:e.touches[0].clientY
            };
        });
        o[i].addEventListener('touchend',function  () {
			clearInterval(timer);
			if(t<200){
				if(posiEnd.x<posi.x-30 && Math.abs(posiEnd.y-posi.y)<25){
					callback(this,$(this).index());
				}
			}
        });
	}
}
function dropRightLoad (obj,callback) {
	var posi,posiEnd,t,timer;
    var o=document.querySelectorAll(obj);
    for(i=0;i<o.length;i++) {
        o[i].addEventListener('touchstart', function (e) {
			t=0;
			timer=setInterval(function () {
				t+=10;
			},10);
            posi = {
                x: e.touches[0].clientX,
				y:e.touches[0].clientY
            };
            posiEnd = {
                x: e.touches[0].clientX,
				y:e.touches[0].clientY
            };
        });
        o[i].addEventListener('touchmove', function (e) {
            posiEnd = {
                x: e.touches[0].clientX,
				y:e.touches[0].clientY
            };
        });
        o[i].addEventListener('touchend', function () {
			clearInterval(timer);
			if(t<200){
				if (posiEnd.x > posi.x-30 && Math.abs(posiEnd.y-posi.y)<40) {
					callback(this);
				}
			}
        });
    }
}