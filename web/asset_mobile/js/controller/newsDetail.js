var app=angular.module('app',[]);
//放在controller前面，是一个自定义的指令，用来绑定  HTML  bind-html
app.directive('bindHtml',function  () {
	return {
		restrict:'A',
		scope:false,
		link:function  (scope,ele,attr) {
			ele[0].innerHTML=attr.bindHtml;
		}
	}
});
app.controller('ctrl',function  ($scope) {
//	数据
	var _newsId=getUrlParam("newsId");
	$scope.refresh=function () {
		$.ajax({
			url:"/jsons/getNewsDetailById.form",
			type:"post",
			async:true,
			dataType:"json",
			data:{newsId:_newsId},
			success:function(data){
				$scope.nowNews=data.rows[0];
				$("#content").html($scope.nowNews.newsContent);
				// $scope.nowNews.newsContent=$scope.nowNews.newsContent.replace(/<(.|\n)+?>/gi,"").replace(/&nbsp;/ig,"");
				$scope.$apply();
			},
			error:function(data){
				l_msg("数据请求失败，请稍后重试……");
			}
		});
	}

	$scope.refresh();

    //导航下标
    $scope.navSele=2;
});
