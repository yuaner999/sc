$(function(){
	$(".btndown").click(function(){
		$(this).parent().parent().children().eq(1).slideToggle();
	});
	//	设置页面左侧菜单主体的最大高度
	//alert($(window).height());
	//记录选项卡的长度
	var tabLength = 0;
	//获得当前选项卡的长度
	var tabsLength = $('.tabs').width();
    //  点击菜单列表,在右边显示相应的内容
    $('.mainmenu>div>.oneul>.oneli>.twoul>li>a').click(function(){
    	var tabText = $(this).text();
    	var Li = $('<li></li>');
    	Li.html(tabText + '<span></span>');
//  	判断右边是否显示
    	if($('.right').css('display') == 'none')
    	{
			if (tabLength > tabsLength)
			{
				alert("选项卡已满，请删除一些选项卡！")
			}else{
	//  		添加选项卡选项
				addTab(Li, tabText);
				tabLength += 120;
    //          显示右边
				showRight();
			}
    	}else{
    		//添加选项卡选项
            addTab(Li, tabText);
    	}
    });
});

//	获取浏览器可视区域的最大高度
function getClientHeight()
{
	return $(window).height();
}
//添加选项卡添加选项
function addTab(Text, tabText)
{
//	判断选项卡中是否已经存在此选项
    var tabTexts = $('.tabs>ul>li');
    var tag = true;
//  循环遍历已经存在的选项卡的内容,与点击的文本相比较,如果存在就就不添加,如果不存在就添加
    for(var i = 0; i < tabTexts.length; i++)
    {
    	if(tabText == tabTexts.eq(i).text())
    	{
    		tag = false;
    		break;
    	}
    }
    if(tag)
    {
    	chageStyle();
    	$('.tabs>ul').append(Text);
    	//选项卡选项的字体颜色与背景颜色切换事件
    	$('.tabs>ul>li').click(function(){
    		switchTabStyle($(this));
    	});
    	//给选项卡中每个选项的叉形图标添加点击事件
	    $('.tabs>ul>li>span').click(function(){
	    	//判断当前的选项卡背景颜色是否为蓝色
	    	if($(this).parent().css('background-color') == 'rgb(25, 127, 254)')
	    	{
	    		var myLis = $('.tabs>ul>li');
	    		var flag = 0;
	    		var tag = false;
	    		//  循环遍历已经存在的选项卡的内容,与点击的文本相比较,返回当前位置
			    for(var i = 0; i < myLis.length; i++)
			    {
			    	if($(this).parent().text() == myLis.eq(i).text())
			    	{
			    		tag = true;
			    		flag = i;
			    		break;
			    	}
			    }
			    $(this).parent().remove();
			    if($('.tabs>ul>li').length==0){
			    	closeRight();	
			  	}
	    		//保持当前位置上的元素背景颜色与字体颜色和被删除的一样
	    		if(tag)
	    		{
	    		    keepStyle(flag, myLis.length);
	    		}
	    	}
	    });
    }else{
    	alert('已经存在');
    }
}

//再添加新的选项卡之前将所有的改变选项卡选项的字体颜色与背景颜色
function chageStyle()
{
	var myLis = $('.tabs>ul>li');
	myLis.css('background-color', '#FFFFFF');
	myLis.css('color', '#197FFE');
}

//保持当前位置上的元素背景颜色与字体颜色和被删除的一样
function keepStyle(num, length){
	var myLis = $('.tabs>ul>li');
	myLis.css('background-color', '#FFFFFF');
	myLis.css('color', '#197FFE');
	var num2 = num + 1;
	if(num2 == length)
	{
		num -= 1;
		myLis.eq(num).css('background-color', '#197FFE');
	    myLis.eq(num).css('color', '#FFFFFF');
	}else{
		myLis.eq(num).css('background-color', '#197FFE');
	    myLis.eq(num).css('color', '#FFFFFF');
	}
}

//选项卡选项的字体颜色与背景颜色切换事件
function switchTabStyle(obj)
{
	var myLis = $('.tabs>ul>li');
	myLis.css('background-color', '#FFFFFF');
	myLis.css('color', '#197FFE');
	obj.css('background-color', '#197FFE');
	obj.css('color', '#FFFFFF');
}