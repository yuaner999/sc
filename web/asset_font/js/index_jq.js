$(function(){
	//flag表示下拉框是否出现，如果出现用0表示，否则1
	var flag = true;
	var imgFlag = true;
	$(".select_list_item").click(function(){
		if(flag)
		{
			$(this).find(".selectContent_list").stop().slideDown(200);
		    $(this).siblings().find(".selectContent_list").stop().slideUp(200);
		    flag = false;
		}
		else{
			$(this).find(".selectContent_list").stop().slideToggle(200);
		    $(this).siblings().find(".selectContent_list").stop().slideUp(200);
		}
		
	});
//	下拉列表悬浮事件
	$(".selectContent_list_item").hover(function(){
		$(this).css("background-color","#4196ff");
		$(this).css("color","#fff");
	},function(){
		$(this).css("background-color","#fff");
		$(this).css("color","#4b93fe");
	});
//	下拉列表选项点击事件
    $(".selectContent_list_item").click(function(){
    	$titleContent = $(this).parent().siblings().eq(0).find(".selectItem_title_content");
//     	alert($titleContent.text());
       	$titleContent.text($(this).text());
    });
//	复选框动态点击事件
	$(".grade_list_item_table").on("click",".selectCheckbox",function(){
		var checked=$(this).find(".hidden_checkbox").get(0).checked;
		if(checked)
		{
			$(this).css("background-image", "url(/asset_font/img/index_selectMsg_trueIcon_03.png)");
			$(this).find(".hidden_checkbox").get(0).checked=true;
			//imgFlag = false;
		}
		else{
			$(this).css("background-image", "url(/asset_font/img/index_selectMsg_selectIcon_06.png)");
			$(this).find(".hidden_checkbox").get(0).checked=false;
			//imgFlag = true;
		}
	})
});
