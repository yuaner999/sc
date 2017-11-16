$(function(){
//	设置页面左侧菜单主体的最大高度
////	点击功能键'新建',弹出新建窗口,背景变暗
//	$('.function>ul>.function_new').click(function(){
//		$("#typ").html("新建");
//		$('.popup').height($(document).height());
////		$('.popup').css('display', 'block');
//		$('.popup').css('background-color', '#a1a1a1').slideDown(300);
//		$('.new').slideDown(400);
//	});
//	//选中table某一行
//
//	//	点击功能键'修改',弹出修改窗口,背景变暗
//	$('.function>ul>.function_edit').click(function(){
//		if(clickStatus!=""&&clickStatus!=null){
//			$("#typ").html("修改");
//			$('.popup').height($(document).height());
//
//			$('.popup').css('background-color', '#a1a1a1').slideDown(300);
//			$('.new').slideDown(400);
//		}else{
//			layer.msg("请选择一条数据");
//		}
//	});

//	点击新建窗口的取消按钮,弹出窗口关闭,弹出层消失
	$('.new_buttons>input[value=取消]').click(function(){
		$('.popup').slideUp(400);
		$('.new').slideUp(300);
	});
    
//  点击'综合条件查询'关闭查询条件
    $('.function>ul>.function_search').click(function(){
    	$('.searchContent').slideToggle();
    });

//  弹出层的弹出框中的头部关闭图形的点击事件
    $('.new>.header>.iconConcel').click(function(){
    	$('.new').slideUp(300);
    	$('.popup').slideUp(400);
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
    //设置表格样式
    //setTimeout(tableStyle, 200);

	//点击综合查询区域的下拉框的展开和收缩
	$('.select_head').hover(function(){

		var liHeight = $(this).siblings().find('.asSelect>li').eq(0).height();
		var liNum = $(this).siblings().find('.asSelect>li').find('li').length;
		var ulHeight = (liHeight+1) * liNum;
		$(this).siblings().css('z-index', '1000');
		$(this).css('z-index', '1000');
		$(this).siblings().find('.asSelect').css('display', 'block');
		$(this).siblings().find('.asSelect').height(ulHeight);
		if(ulHeight >= 196)
		{
			//$('.asSelect').siblings().css('display', 'hidden');
			$(this).siblings().find('.asSelect').css('max-height', '196'+'px');
			$(this).siblings().find('.asSelect').css('overflow-y', 'auto');
		}
	},function(){
		//$(this).height(28);
		//$(this).css('overflow-y', 'hidden');
	});
	//点击综合查询区域的下拉框上的小图标的展开和收缩
	$('.asSelect').siblings().find('span').hover(function(){
		var liHeight = $(this).siblings().find('.asSelect>li').eq(0).height();
		var liNum = $(this).siblings().find('.asSelect>li').length;
		var ulHeight = (liHeight+1) * liNum;
		$(this).siblings().find('.asSelect').css('display', 'block');
		$(this).siblings().css('z-index', '1000')
		$(this).css('z-index', '1000');
		$(this).siblings().find('.asSelect').height(ulHeight).slideDown(200);
	},function(){
		$(this).siblings().find('.asSelect').slideUp(200);
		//$(this).siblings().slideDown(200).height(26);
		$(this).siblings().css('z-index', '10')
		$(this).css('z-index', '10');
	});
    //点击综合查询区域的下拉框第一个选项为空，当没有点击其他选项时，它的内容和第二个一样
    //当点击其他选项时，它的第一个的内容应与被点击的选项的内容相同
    $('.asSelect>li').click(function(){
		var liText = $(this).text();
		$('.select_head').text(liText);
		$(this).stop().fadeIn(200);
		$(this).parent().slideUp(200);
    });
    //点击清空按钮时，恢复默认值，它的内容和第二个一样
    $('.buttons>.clearAll').click(function(){
    	//清空输入框
    	var inputNum = $('.searchContent input').length;
    	for(var i = 0; i < inputNum; i++)
    	{
    		$('.searchContent input').eq(i).val('');
    	}
    	//选择框的恢复默认值
    	restoreSelect($('.searchContent .asSelect'));
    });
});
//	获取浏览器可视区域的最大高度
    function getClientHeight()
    {
    	return $(window).height();
    }

////计算表格大小
//function tableStyle()
//{
//	$('table>tbody>tr>td').eq(1).css('color', '#1990FE');
//	var oneTdWidth = $('table>thead>tr>td').eq(0).width();
//	var tdWidth = $('table>thead>tr>td').eq(1).width();
//	var tdNum = $('table>thead>tr>td').length;
//	var trWidth = 0;
//	trWidth = (tdNum-1)*(tdWidth+2) + oneTdWidth + 2;
//	$('table').css("width",trWidth+"px");
////	alert($('table>thead>tr').css("width"))
//}

//选择框回复默认值
function restoreSelect(obj)
{
	var selectNum = obj.length;
	for(var j = 0; j < selectNum; j++)
	{
		restoreSelectLi(obj.eq(j));
	}
}
function restoreSelectLi(obj)
{
	obj.find('li').eq(0).text(obj.find('li').eq(1).text());
}
//选中行，变换背景颜色
function sel(obj) {
	obj.style.backgroundColor="yellow";
}
//  活动管理页面的超链接的点击事件
$('.twoul .activeLoad').click(function(){
	$('.activeLoadPopup').slideDown(300);
	$('.activeLoadWindow').slideDown(400);
});
//  活动管理页面弹出窗口的取消按钮的点击事件
$('.activeLoadWindow input[value="取消"]').click(function(){
	$('.activeLoadPopup').slideUp(400);
	$('.activeLoadWindow').slideUp(300);
});