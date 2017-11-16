$(function(){
//	设置页面右侧主体的最大高度
	var mh=document.body.clientHeight||window.innerHeight;
	$('.menuBody').css('max-height', mh-115+"px");
	window.onresize=function(){
		var mh=document.body.clientHeight||window.innerHeight;
		$('.menuBody').css('max-height', mh-155+"px");
	}
//	设置页面表格外的div的可视高度
//$('.table').css('height', (getClientHeight()-207) + 'px');


////	点击新建窗口的取消按钮,弹出窗口关闭,弹出层消失
	$("input[value='取消']").click(function(){
		$("table tr").css('background-color','white');
		isSelect='';
		clickStatus='';
		$("#studentPhotos").attr("src","<%=request.getContextPath()%>/asset/image/default.jpg");
		rowdata=null;
		$('#dlg').hide();
		$('.popup').slideUp(400);
		$('.new').slideUp(300);
	});
	//	点击新建窗口的X按钮,弹出窗口关闭,弹出层消失
	$(".iconConcel").click(function(){
		$("table tr").css('background-color','white');
		isSelect='';
		clickStatus='';
		$("#studentPhotos").attr("src","<%=request.getContextPath()%>/asset/image/default.jpg");
		$('#dlg').hide();
		$('.popup').slideUp(400);
		$('.new').slideUp(300);
	});

//  点击'综合条件查询'关闭查询条件
    $('.function>ul>.function_search').click(function(){
    	$('.searchContent').slideToggle();
    });

//  弹出层的弹出框中的复选框的点击事件
    $('.new>ul>li>ul>li>input').click(function(){
//  	判断复选框是否选中,如果选中则,再次被点击时,换回原来的图片，如果没有，更换为新的图片
    	if($(this).is(':checked'))
    	{
    		$(this).siblings("span").css('background-image', 'url(img/icon_new_checked.png)');
    	}else{
    		$(this).siblings('span').css('background-image', 'url(img/icon_new_checks.png)');
    	}
    });

//  弹出层的弹出框中的头部关闭图形的点击事件
//    $('.new>.header>.iconConcel').click(function(){
//    	$('.new').slideUp(200);
//    	$('.popup').slideUp(400);
//    });
    //设置表格样式
    //setTimeout(tableStyle, 200);
	//点击综合查询区域的下拉框的展开和收缩
	$('.select_head').click(function(){
		//关闭所有的下拉列表
		$('.select_icon').css('z-index', '10');
		$('.select_head').css('z-index', '10');
		$('.asSelect').css('z-index', '10');
		$('.asSelect').slideUp(200);
		var liHeight = $(this).parent().find('ul').children().eq(0).height();
		var liNum = $(this).parent().find('ul').children().size();
		var ulHeight = (liHeight+1) * liNum;
		$(this).siblings().css('z-index', '1000');
		$(this).css('z-index', '1000');
		$(this).parent().find('ul').css('display', 'block');
		$(this).parent().find('ul').height(ulHeight).slideDown(200);
		if(ulHeight >= 196)
		{
			//$('.asSelect').siblings().css('display', 'hidden');
			$(this).parent().find('ul').css('max-height', '196'+'px');
			$(this).parent().find('ul').css('overflow-y', 'auto');
		}
	});
	$('.select_icon').click(function(){
		//关闭所有的下拉列表,初始化z-index
		$('.select_icon').css('z-index', '10');
		$('.select_head').css('z-index', '10');
		$('.asSelect').css('z-index', '10');
		$('.asSelect').slideUp(200);
		var liHeight = $(this).parent().find('ul').children().eq(0).height();
		var liNum = $(this).parent().find('ul').children().size();
		var ulHeight = (liHeight+1) * liNum;
		$(this).siblings().css('z-index', '1000');
		$(this).css('z-index', '1000');
		$(this).parent().find('ul').css('display', 'block');
		$(this).parent().find('ul').height(ulHeight).slideDown(200);
		if(ulHeight >= 196)
		{
			//$('.asSelect').siblings().css('display', 'hidden');
			$(this).parent().find('ul').css('max-height', '196'+'px');
			$(this).parent().find('ul').css('overflow-y', 'auto');
		}
	});
    //选择列表的悬浮事件
    $('.asSelect').hover(function(){
    },function(){
		$(this).scrollTop(0);
		$(this).siblings().css('z-index', '10');
		$(this).css('z-index', '10');
		$(this).slideUp(200);
    });


    //点击综合查询区域的下拉框第一个选项为空，当没有点击其他选项时，它的内容和第二个一样
    //当点击其他选项时，它的第一个的内容应与被点击的选项的内容相同
	setTimeout(selectLis, 2000);
    //点击清空按钮时，恢复默认值，它的内容和第二个一样
    $('.buttons>.clearAll').click(function(){
    	//清空输入框
    	var inputNum = $('.searchContent input').length;
		var select_headNum = $('.select_head').size();
		for(var i = 0; i < select_headNum; i++)
		{
			$('.select_head').eq(i).text('');
		}
    	for(var i = 0; i < inputNum; i++)
    	{
    		$('.searchContent input').eq(i).val('');
    	}
    	//选择框的恢复默认值
    //	restoreSelect($('.searchContent .asSelect'));
    });
	//  活动管理页面的超链接的点击事件
	$('.twoul .activeLoad').click(function(){
		$('.activeLoadPopup').slideDown(300);
		$('.activeLoadWindow').slideDown(400);
	});
  //活动管理页面弹出窗口的取消按钮的点击事件
	$('.activeLoadWindow input[value="取消"]').click(function(){
		rowdata=null;
		$('.activeLoadPopup').slideUp(400);
		$('.activeLoadWindow').slideUp(300);
	});
});
//当点击其他选项时，它的第一个的内容应与被点击的选项的内容相同
function selectLis()
{
	$('.asSelectLi').click(function(){
		var liText = $(this).text();
		var liTitle = $(this).attr('title');
		$(this).parent().parent().find('.select_head').attr('title', liTitle);
		$(this).parent().parent().find('.select_head').text(liText);
		$(this).stop().fadeIn(200);
		$(this).parent().slideUp(200);
		$(this).parent().scrollTop(0);
		$(this).parent().siblings().css('z-index', '10');
		$(this).parent().css('z-index', '10');
		$(this).parent().slideUp(200);
	});
//点击综合查询区域的下拉框每个选项的展开和收缩
	$('.asSelectLi').hover(function(){
		$(this).css('background-color', '#197FFE');
		$(this).siblings().css('background-color', '#1990FE');
	},function(){
		$(this).css('background-color', '#1990FE');
		$(this).siblings().css('background-color', '#1990FE');
	});
}




