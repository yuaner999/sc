$(function(){
//	多行文本溢出
	$(".list_item_content").find("p").dotdotdot();
	$(".News_content_details_content").dotdotdot();
//	
//	$(".News_content_details_content").each(function(i){
//	    var divH = $(this).height();
//	    var $p = $("p", $(this)).eq(0);
//	    while ($p.outerHeight() > divH) {
//	        $p.text($p.text().replace(/(\s)*([a-zA-Z0-9]+|\W)(\.\.\.)?$/, "..."));
//	    };
	
});
