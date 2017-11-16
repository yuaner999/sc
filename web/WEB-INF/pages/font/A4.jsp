<%--
  Created by IntelliJ IDEA.
  User: admin
  Date: 2016/9/10
  Time: 16:51
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java"  pageEncoding="UTF-8" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01//EN"
"http://www.w3.org/TR/html4/strict.dtd">
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
		<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
		<title></title>
		<link rel="stylesheet" href="<%=request.getContextPath()%>/asset_font_new/css/A4.css" />
		<script type="text/javascript" src="<%=request.getContextPath()%>/asset_font_new/js/jquery-1.11.1.min.js" ></script>
		<script type="text/javascript" src="<%=request.getContextPath()%>/asset_font_new/build/echarts.js" ></script>
		<script type="text/javascript" src="<%=request.getContextPath()%>/asset/js/common.js" ></script>
		<script src="<%=request.getContextPath()%>/asset_font_new/js/jquery.dotdotdot.js" type="text/javascript" charset="utf-8"></script>
		<script src="<%=request.getContextPath()%>/asset_font_new/js/common.js" type="text/javascript" charset="utf-8"></script>
		<script src="<%=request.getContextPath()%>/asset_font_new/js/respond.js" type="text/javascript" charset="utf-8"></script>
		<script src="<%=request.getContextPath()%>/asset_font_new/js/index.js" type="text/javascript" charset="utf-8"></script>
		<script type="text/javascript" src="<%=request.getContextPath()%>/asset/js/laydate/laydate.js"></script>
		<script type="text/javascript" src="<%=request.getContextPath()%>/asset/layer/layer.js" ></script>
		<script src="<%=request.getContextPath()%>/asset_font/js/angular.min.js" type="text/javascript" charset="utf-8"></script>
		<script type="text/javascript" src="<%=request.getContextPath()%>/asset/js/jspdf/jspdf.debug.js" ></script>
		<%--<script type="text/javascript" src="<%=request.getContextPath()%>/asset/js/jspdf/html2canvas.min.js" ></script>--%>
		<script type="text/javascript" src="<%=request.getContextPath()%>/asset/js/jspdf/html2canvas.js" ></script>

		<style type="text/css" >
			.print_btn_box{
				width: 116px;
				height: 21px;
				position: fixed;
				top: 30px;
				right: 100px;
				background: #597BBD;
				color: #ffffff;
				font-size: 14px;
				text-align: center;
				border:2px solid #597BBD;
			}
			.print_btn_box>span{
				height: 24px;
				cursor: pointer;
				padding: 4px;
				background: url("/asset_font_new/img/save_btn.png");
				background-repeat: no-repeat;
				background-position: 0px 9px;
				padding-left: 20px;
				font-size: 16px;
				padding-top: 4px;
			}
			.print_btn_box:hover{
				border-left: 2px solid #444;
				border-top: 2px solid #444;
			}
			.loading_box{
				background: #fff;
				width: 100%;
				height:100%;
				position:fixed;
				top:0;
				left:0;
				z-index: 999;
				display:none;
			}
			.loading_box img{
				width:37px;
				height:37px;
				display:block;
				margin: 0 auto;
				margin-top: 200px;
			}
		</style>
		<script type="text/javascript">
			$(function(){
			//		保存成pdf
				$("#save_as_pdf").click(function(){
					if ((navigator.userAgent.indexOf('MSIE') >= 0) && (navigator.userAgent.indexOf('Opera') < 0)){
						alert('报歉，本功能不支持IE浏览器，请使用其它非IE内核的浏览器！比如：谷歌浏览器、火狐浏览器、360极速浏览器、搜狗浏览器等等');
						return;
					}
					//将元素生成canvas 并保存成 imgData的形式
					$(".loading_box").show();
					var doc = new jsPDF("p", "mm", "a4");
					var dom=$($(".A4").get(0)); //你要转变的dom
					$(".A4_box").css("margin","0");
					var width = dom.width();
					var height = dom.height();
					var scaleBy = 2;  //缩放比例
					var canvas = document.createElement('canvas');
					canvas.width = width * scaleBy;
					canvas.height = height * scaleBy;
					canvas.style.width = width * scaleBy + 'px';
					canvas.style.height = height * scaleBy + 'px';
					var context = canvas.getContext('2d');
					context.scale(scaleBy, scaleBy);
					html2canvas(dom[0], {
						canvas:canvas,
						onrendered: function (canvas) {
							doc.addImage(canvas.toDataURL('image/jpeg'), 'JPEG', 0, 0,210,297);
							$($(".A4").get(0)).hide();
							var canvas2 = document.createElement('canvas');
							var dom2=$($(".A4").get(1)); //你要转变的dom
							var width = dom2.width();
							var height = dom2.height();
							canvas2.width = width * scaleBy;
							canvas2.height = height * scaleBy;
							canvas2.style.width = width * scaleBy + 'px';
							canvas2.style.height = height * scaleBy + 'px';
							var context = canvas2.getContext('2d');
							context.scale(scaleBy, scaleBy);
							html2canvas($(".A4").get(1), {
								canvas:canvas2,
								onrendered: function (canvas) {
//									$("#img_2").attr("src",canvas.toDataURL('image/jpeg'));//这是放大了很3倍的图片
									doc.addPage();
									doc.addImage(canvas.toDataURL('image/jpeg'), 'JPEG', 0, 0,210,297);
									var name=$(".first_li_span").text()+"_"+studentid;
									doc.save(name+'.pdf');
									$($(".A4").get(0)).show();
									$(".A4_box").css("margin","0 auto");
									$(".loading_box").fadeOut(300);
								}
							});
						}
					});
				});

			});
		</script>
	</head>
	<body>
	<div class="loading_box">
		<img src="/asset/layer/skin/default/loading-1.gif" />
	</div>
	<div class="A4_box"  ng-app="app" ng-controller="ctrl">
		<div class="A4">
			<!--页眉-->
			<div class="head">
				<img src="<%=request.getContextPath()%>/asset_font_new/img/badge.jpg" class="badge"/>
				<span class="left_title">NEU YOUTH PIONEE-R</span>
				<span class="right_title" id="num"></span>
				<div class="title">东北大学共青团</div>
			</div>
			<!--主体-->
			<div class="content">
				<!--标题-->
				<div class="content_title">
					<%--<img src="<%=request.getContextPath()%>/asset_font_new/img/markleft_03.jpg" class="mark_left"/>--%>
					<span>第二课堂成绩单</span>
					<%--<img src="<%=request.getContextPath()%>/asset_font_new/img/markright_03.jpg" class="mark_right"/>--%>
				</div>
				<!--个人信息、雷达图-->
				<div class="person">
					<div class="person_infor">
						<img src="" class="head_icon"/>
						<ul class="person_infor_ul">
							<li class="first_li">
								<img src="<%=request.getContextPath()%>/asset_font_new/img/name_icon_03.jpg" onerror="error=null;src='<%=request.getContextPath()%>/Files/Images/default.jpg'" class="first_li_img"/>
								<span class="first_li_span"></span>
							</li>
							<li class="person_infor_ul_li">
								<img src="<%=request.getContextPath()%>/asset_font_new/img/phone_icon_03.jpg"/>
								<span class="person_key">电话</span>
								<span class="person_value"></span>
							</li>
							<li class="person_infor_ul_li">
								<img src="<%=request.getContextPath()%>/asset_font_new/img/college_icon_03.jpg"/>
								<span class="person_key">学院</span>
								<span class="person_value"></span>
							</li>
							<li class="person_infor_ul_li">
								<img src="<%=request.getContextPath()%>/asset_font_new/img/class_icon_03.jpg"/>
								<span class="person_key">班级</span>
								<span class="person_value"></span>
							</li>
							<li class="person_infor_ul_li">
								<img src="<%=request.getContextPath()%>/asset_font_new/img/major_icon_03.jpg"/>
								<span class="person_key">专业</span>
								<span class="person_value"></span>
							</li>
							<li class="person_infor_ul_li">
								<img src="<%=request.getContextPath()%>/asset_font_new/img/num_icon_03.jpg"/>
								<span class="person_key">学号</span>
								<span class="person_value"></span>
							</li>
						</ul>
					</div>
					<div id="chart" class="chart_radar"></div>
					<div class="number">
						<!--<div class="year_box" id="YearBox"></div>-->
						<ol class="color2">
							<li class="green" style="display: none">2014年</li>
							<li class="yellow" style="display: none">2015年</li>
							<li class="red" style="display: none">2016年</li>
							<li class="blue" style="display: none">2017年</li>
						</ol>
						<ul class="number_data">
							<li>
								<span>表达</span>
								<span class="number_data_col" style="background: #DF7071;"></span>
								<span class="number_data_value"></span>
							</li>
							<li>
								<span>执行</span>
								<span class="number_data_col" style="background: #799DD2;"></span>
								<span class="number_data_value"></span>
							</li>
							<li>
								<span>思辨</span>
								<span class="number_data_col" style="background: #B0D479;"></span>
								<span class="number_data_value"></span>
							</li>
							<li>
								<span>领导</span>
								<span class="number_data_col" style="background: #E79778;"></span>
								<span class="number_data_value"></span>
							</li>
							<li>
								<span>创新</span>
								<span class="number_data_col" style="background: #D97FB1;"></span>
								<span class="number_data_value"></span>
							</li>
							<li>
								<span>创业</span>
								<span class="number_data_col" style="background: #84CEE6;"></span>
								<span class="number_data_value"></span>
							</li>
						</ul>
					</div>
				</div>
				<!--表格-->
				<div class="tablediv" ng-repeat="table in tables">
					<div class="tablediv_title">
						<div class="tablediv_title_name">
							<img src="<%=request.getContextPath()%>/asset_font_new/img/triangle_03.jpg"/>
							<span class="bold_span">项目类别</span>
							<span ng-bind="table.type"></span>
						</div>
						<div class="tablediv_title_value">
							<%--<img src="<%=request.getContextPath()%>/asset_font_new/img/add_03.jpg"/>--%>
							<span class="score_total1" ng-bind="'已修学分'+table.nowgrade"></span>/
								<span class="score_get1" ng-bind="'必修学分'+table.allgrade"></span>
						</div>
					</div>
					<table border="1" width="100%" class="table1">
						<tr>
							<td class="table_title" width="100mm">时间</td>
							<td class="table_title">名称</td>
							<td class="table_title" width="60mm">级别</td>
							<td class="table_title" width="40mm">学分</td>
							<td class="table_title" width="150mm">奖项及备注</td>
						</tr>
						<tr ng-repeat="row in table.rows">
							<td class="applyDate" ng-bind="row.applyDate"></td>
							<td class="activityTitle"  ng-bind="row.activityTitle"></td>
							<td class="activityLevle" ng-bind="row.activityLevles"></td>
							<td class="activityCredit" ng-bind="row.activityCredit"></td>
							<td class="activityAward" ng-bind="row.activityAward"></td>
						</tr>
					</table>
				</div>
			</div>
			<!--页脚-->
			<div class="foot">
				<img src="<%=request.getContextPath()%>/asset_font_new/img/neu_foot_03.jpg" class="foot_left"/>
				<img src="<%=request.getContextPath()%>/asset_font_new/img/motto_foot_03.jpg" class="foot_right"/>
			</div>
		</div>
		
		<div class="A4">
			<!--页眉-->
			<div class="head">
				<img src="<%=request.getContextPath()%>/asset_font_new/img/badge.jpg" class="badge"/>
				<span class="left_title">NEU YOUTH PIONEE-R</span>
				<%--<span class="right_title" ng-bind="printID">编号：${printId}</span>--%>
			</div>
			<!--主体-->
			<div class="content">
				<!--表格-->
				<div class="tablediv2">
					<div class="tablediv_title">
						<div class="tablediv_title_name"  style="width: 52mm;!important;">
							<img src="<%=request.getContextPath()%>/asset_font_new/img/triangle_03.jpg"/>
							<span class="bold_span">项目类别</span>
							<span>社会实践与志愿服务类</span>
						</div>
						<div class="tablediv_title_value">
							<%--<img src="<%=request.getContextPath()%>/asset_font_new/img/add_03.jpg"/>--%>
							<span class="score_total1" ng-bind="'已修学分'+data_practice.nowgrade"></span>/
							<span class="score_get1" ng-bind="'必修学分'+data_practice.allgrade"></span>
						</div>
					</div>
					<table border="1" width="100%" class="table4">
						<tr>
							<td class="table_title" width="100mm">时间</td>
							<td class="table_title">名称</td>
							<td class="table_title" width="60mm">级别</td>
							<td class="table_title" width="40mm">学分</td>
							<td class="table_title" width="50mm">时长</td>
							<td class="table_title" width="100mm">奖项及备注</td>
						</tr>
						<tr ng-repeat="row in data_practice.rows track  by $index">
							<td class="applyDate" ng-bind="row.applyDate"></td>
							<td class="activityTitle" ng-bind="row.activityTitle"></td>
							<td class="activityLevle" ng-bind="row.activityLevles"></td>
							<td class="activityCredit" ng-bind="row.activityCredit"></td>
							<td class="worktime" ng-bind="row.supWorktime ? row.supWorktime.indexOf('小时')>0 ? row.supWorktime : row.supWorktime+'小时' : ''"></td>
							<td class="activityAward" ng-bind="row.activityAward"></td>
						</tr>
					</table>
				</div>
				<div class="tablediv2">
					<div class="tablediv_title">
						<div class="tablediv_title_name">
							<img src="<%=request.getContextPath()%>/asset_font_new/img/triangle_03.jpg"/>
							<span class="bold_span">项目类别</span>
							<span>社会工作与技能培训类</span>
						</div>
						<div class="tablediv_title_value">
							<span class="score_total1" ng-bind="'已修学分' + data_work.nowgrade"></span>
						</div>
					</div>
					<table border="1" width="100%" class="table5">
						<tr>
							<td class="table_title" width="100mm">时间</td>
							<td class="table_title">名称</td>
							<td class="table_title" width="60mm">级别</td>
							<%--<td class="table_title" width="40mm">学分</td>--%>
							<td class="table_title" width="150mm">奖项及备注</td>
						</tr>
						<tr ng-repeat="row in data_work.rows track  by $index">
							<td class="applyDate" ng-bind="row.applyDate"></td>
							<td class="activityTitle" ng-bind="row.activityTitle"></td>
							<td class="activityLevle" ng-bind="row.activityLevles"></td>
							<td class="activityAward" ng-bind="row.activityAward"></td>
						</tr>
					</table>
				</div>
				<div class="tablediv2">
					<div class="tablediv_title">
						<div class="tablediv_title_name">
							<img src="<%=request.getContextPath()%>/asset_font_new/img/triangle_03.jpg"/>
							<span class="bold_span">项目类别</span>
							<span>综合奖励及其它类</span>
						</div>
						<div class="tablediv_title_value">
							<span class="score_total1" ng-bind="'已修学分'+data_award.nowgrade"></span>
						</div>
					</div>
					<table border="1" width="100%" class="table6">
						<tr>
							<td class="table_title" width="100mm">时间</td>
							<td class="table_title">名称</td>
							<td class="table_title" width="60mm">级别</td>
							<%--<td class="table_title" width="40mm">学分</td>--%>
							<td class="table_title" width="150mm">奖项及备注</td>
						</tr>
						<tr ng-repeat="row in data_award.rows track  by $index">
							<td class="applyDate" ng-bind="row.applyDate"></td>
							<td class="activityTitle" ng-bind="row.activityTitle"></td>
							<td class="activityLevle" ng-bind="row.activityLevles==null?row.activityLevle:row.activityLevles"></td>
							<td class="activityAward" ng-bind="row.activityAward"></td>
						</tr>
					</table>
				</div>
				<!--综合描述-->
				<div class="synthesize_div">
					<img src="<%=request.getContextPath()%>/asset_font_new/img/synthesize_03.jpg" class="synthesize"/>
					<div class="synthesize_word">综合评定</div>
				</div>
				<div class="evaluate">
					<span class="evaluate_tag" id="sname" style="margin-left: 27px;"></span>
					同学在校期间累计参与思想政治教育类活动
					<span ng-bind="tables[0].categorynum"></span> 项，能力素质拓展类活动
					<span ng-bind="tables[1].categorynum"></span>项，学术科技与创新创业类活动
					<span ng-bind="tables[2].categorynum"></span> 项。社会实践类活动
					<span ng-bind="data_practice.categorynum"></span> 项，志愿服务时长
					<span ng-bind="hours"></span> 小时，社会工作与技能培训类活动
					<span ng-bind="data_work.categorynum"></span>项。综上，该生在
					<span class="evaluate_tag"><span id="top1"></span></span> 能力、
					<span class="evaluate_tag"> <span id="top2"></span></span> 能力、
					<span class="evaluate_tag"> <span id="top3"></span></span> 能力提升方面表现突出，综合能力素质评定等级为<span class="evaluate_tag"> <span id="point_level">良好</span></span>。
				</div>
				<div class="publish">
					<%--下面注释 是学校要求的 该位置盖章用--%>
					<%--<img src="<%=request.getContextPath()%>/asset_font_new/img/neu_foot_03.jpg" class="publish_left"/>--%>
					<%--<img src="<%=request.getContextPath()%>/asset_font_new/img/badge.jpg" class="publish_right"/>--%>
					<div class="publish_word">共青团东北大学委员会</div>
				</div>
				<%--<div class="unite">联合颁布</div>--%>
			</div>
			<!--页脚-->
			<div class="foot">
				<img src="<%=request.getContextPath()%>/asset_font_new/img/neu_foot_03.jpg" class="foot_left"/>
				<img src="<%=request.getContextPath()%>/asset_font_new/img/motto_foot_03.jpg" class="foot_right"/>
			</div>
		</div>
			<%--里面有一个按钮，高度为25，2个就50--%>
	</div>
	<div class="print_btn_box" >
		<span id="save_as_pdf">保存为PDF</span>
		<%--<div>打印成绩单</div>--%>
	</div>
	</body>
</html>
<script>
	//angular数据绑定
	var app=angular.module("app",[]).controller('ctrl', function ($scope) {
		$scope.printID=GetQueryString("Enigmatic");
		$scope.tables=[];
		$scope.data_practice={type:"社会实践与志愿服务类",nowgrade:0,allgrade:0,worktime:0, categorynum:0,rows:[]}; //第二页第一个表格（社会实践与志愿服务类）数据
		$scope.data_work={type:"社会工作与技能培训类", nowgrade:0,categorynum:0,rows:[]}; //第二页第一个表格（社会工作与技能培训类）数据
		$scope.data_award={type:"综合奖励及其他类", nowgrade:0,rows:[]}; //第二页第一个表格（综合奖励及其他类）数据
		$scope.hours=0;
		//加载打印预览活动列表数据
		$.ajax({
			url:"/printTranscript/print.form" ,
			data:{studentID:studentid,printID:$scope.printID},
			type:"post",
			dataType:"json",
			async: false,
			success:function(data){
				if(data.status==1){
					layer.msg(data.msg);
					return;
				}
				if(data.data==null || data.data.length==0){
					layer.msg("未添加过打印申请，请先添加打印申请");
					return;
				}
				$scope.tables.push({type:"思想政治教育类",nowgrade:0,allgrade:0,categorynum:0, rows:[]});
				$scope.tables.push({type:"能力素质拓展类", nowgrade:0,allgrade:0, categorynum:0,rows:[]});
				$scope.tables.push({type:"学术科技与创新创业类", nowgrade:0,allgrade:0,categorynum:0,rows:[]});
				if(data.data.length>0){
					var themeData=[];
					for(var i=0;i<data.data.length;i++){
						if(data.data[i].activityClass=='1'&&data.data[i].supType!="主题团日"){
							$scope.tables[0].rows.push(data.data[i]);
						}
						if(data.data[i].activityClass=='1'&&data.data[i].supType=="主题团日"){
							themeData.push(data.data[i]);
						}
						if(data.data[i].activityClass=='2'){
							$scope.tables[1].rows.push(data.data[i]);
						}
						if(data.data[i].activityClass=='3'){
							var row=data.data[i];
							if(row.supType="非活动类"){
								row.activityAward=row.scienceClass;
								row.activityLevle="--";
							}
							$scope.tables[2].rows.push(row);
						}
						if(data.data[i].activityClass=='4'){
							console.log(data.data[i].supWorktime);
							if(data.data[i].supWorktime){
								data.data[i].activityCredit = Math.floor(((data.data[i].supWorktime)/12)*100)/100

							}
							$scope.data_practice.rows.push(data.data[i]);
							//$scope.data_practice.nowgrade+=parseFloat(data.data[i].activityCredit);
						}
						if(data.data[i].activityClass=='5'){
							var row=data.data[i];
							if(row.supType=="非活动类" || row.supType=="学生干部任职"){
								var lvl='';
								if(row.workClass=="学校组织")
									lvl="校级";
								else if(row.workClass=="学院组织" || row.workClass=="社团")
									lvl="院级";
								else
									lvl="班级";
								row.activityLevle=(lvl?lvl:"--");
								row.activityAward=(row.orgname ? row.orgname : "学生干部任职");
							}
							$scope.data_work.rows.push(row);
						}
						if(data.data[i].activityClass=='6'){
							var row=data.data[i];
							row.activityAward=row.activityLevle;
							row.activityLevle="--";
							$scope.data_award.rows.push(data.data[i]);
						}
					}
					var count=themeData.length;
					var point=count>=12?1:count>=6?0.6:count>=3?0.3:0;
					var themedata={applyDate:"大学期间",activityTitle:"主题团日活动",activityLevles:"校级",activityCredit:point,activityAward:"共计"+count+"次"};
					if(count>0) $scope.tables[0].rows.push(themedata);
					//判断第一页数据行数，动态补充空值达到12行效果
					//三大类每类4行
					var firstClassNum=$scope.tables[0].rows.length;
					var secondClassNum=$scope.tables[1].rows.length;
					var thirdClassNum=$scope.tables[2].rows.length;
					if(firstClassNum<=4&&secondClassNum<=4&&thirdClassNum<=4){
						for(var a=1;a<5-firstClassNum;a++){
							$scope.tables[0].rows.push({});
						}
						for(var b=1;b<5-secondClassNum;b++){
							$scope.tables[1].rows.push({});
						}
						for(var c=1;c<5-thirdClassNum;c++){
							$scope.tables[2].rows.push({});
						}
						//缺失行添加到第三大类后
					}else{
						for(var d=1;d<13-firstClassNum-secondClassNum-thirdClassNum;d++){
							$scope.tables[2].rows.push({});
						}
					}
					//第二页表格处理 同上
					var fourClassNum=$scope.data_practice.rows.length;
					var fiveClassNum=$scope.data_work.rows.length;
					var sixClassNum=$scope.data_award.rows.length;
					if(fourClassNum<=4&&fiveClassNum<=4&&sixClassNum<=4){
						for(var o=1;o<5-fourClassNum;o++){
							$scope.data_practice.rows.push({});
						}
						for(var p=1;p<5-fiveClassNum;p++){
							$scope.data_work.rows.push({});
						}
						for(var q=1;q<5-sixClassNum;q++){
							$scope.data_award.rows.push({});
						}
						//缺失行添加到第三大类后
					}else{
						for(var t=1;t<13-fourClassNum-fiveClassNum-sixClassNum;t++){
							$scope.data_award.rows.push({});
						}
					}

				}
				//加载六大类活动总分数
				$.ajax({
					url:"/jsons/loadActivityScoreTotal.form",
					type:"post",
					dataType:"json",
					async:false,
					success:function(data){
						if(data.rows.length>0){
							for(var i=0;i<data.rows.length;i++){
								var item=data.rows[i];
								if(item.dict_mean=='思想政治教育类'){$scope.tables[0].allgrade=item.dict_score;}
								if(item.dict_mean=='能力素质拓展类'){$scope.tables[1].allgrade=item.dict_score;}
								if(item.dict_mean=='学术科技与创新创业类'){$scope.tables[2].allgrade=item.dict_score;}
								if(item.dict_mean=='社会实践与志愿服务类'){$scope.data_practice.allgrade=item.dict_score}
							}
						}
					},
					error:function(XMLHttpRequest,textStatus,errorThrown){
						layer.msg("服务器连接失败，请稍后再试")
					}
				});
				//加载六大类活动已获得分数
				$.ajax({
					url:"/jsons/loadActivityScoreGet.form",
					type:"post",
					data:{loginId:studentid},
					dataType:"json",
					async:false,
					success:function(data){
						if(data.rows.length>0){
							for(var i=0;i<data.rows.length;i++){
								var item=data.rows[i];
								var activityCredit= item.activityCredit  && item.supCredit != '--'?parseFloat(item.activityCredit):0;
								if(isNaN(activityCredit)){continue ;}
								if(item.dict_mean=='思想政治教育类'){$scope.tables[0].nowgrade+=activityCredit;$scope.tables[0].categorynum++;}
								if(item.dict_mean=='能力素质拓展类') {$scope.tables[1].nowgrade+=activityCredit;$scope.tables[1].categorynum++;}
								if(item.dict_mean=='学术科技与创新创业类'){$scope.tables[2].nowgrade+=activityCredit;$scope.tables[2].categorynum++;}
								if(item.dict_mean=='社会实践与志愿服务类') {
									$scope.data_practice.categorynum++;
									if(item.supWorktime == null || item.supWorktime == ''){
										$scope.data_practice.nowgrade+=activityCredit;
										continue;
									}
									$scope.data_practice.worktime=(item.supWorktime ? item.supWorktime.indexOf("小时")>0 ? item.supWorktime : item.supWorktime+"小时" : "");
									console.log($scope.data_practice.worktime+"|"+item.supWorktime);
									//计算志愿服务总时长
									var tim=0;
									if($scope.data_practice.worktime.indexOf("天")>0){
										tim=$scope.data_practice.worktime.replace("天","");
										var time=parseFloat(tim)*24;
										$scope.hours+=(isNaN(time) ? 0 : time);
									}
									if($scope.data_practice.worktime.indexOf("小时")>0){
										tim=$scope.data_practice.worktime.replace("小时","");

										$scope.hours+=(isNaN(parseFloat(tim)) ? 0 : parseFloat(tim));
									}
								}
								if(item.dict_mean=='社会工作与技能培训类') {$scope.data_work.nowgrade+=activityCredit;$scope.data_work.categorynum++;}
								if(item.dict_mean=='综合奖励及其他类') {$scope.data_award.nowgrade+=activityCredit;}
							}
						}
					},
					error:function(XMLHttpRequest,textStatus,errorThrown){
						layer.msg("服务器连接失败，请稍后再试")
					}
				});
				//已获得得分 （学生自己添加的）
				$.ajax({
					url:"/jsons/loadActivityScoreGets.form",
					type:"post",
					data:{loginId:studentid},
					dataType:"json",
					async:false,
					success:function(data){
						if(data.rows.length>0){
							for(var i=0;i<data.rows.length;i++){
								var item=data.rows[i];
								var activityCredit= item.supCredit && item.supCredit != '--'?parseFloat(item.supCredit):0;
								if(isNaN(activityCredit)){continue ;}
								if(item.dict_mean=='思想政治教育类'){$scope.tables[0].nowgrade+=activityCredit;$scope.tables[0].categorynum++;}
								if(item.dict_mean=='能力素质拓展类') {$scope.tables[1].nowgrade+=activityCredit;$scope.tables[1].categorynum++;}
								if(item.dict_mean=='学术科技与创新创业类'){$scope.tables[2].nowgrade+=activityCredit;$scope.tables[2].categorynum++;}
								if(item.dict_mean=='社会实践与志愿服务类') {
									$scope.data_practice.categorynum++;
									if(item.supWorktime == null || item.supWorktime == ''){
										$scope.data_practice.nowgrade+=activityCredit;
										continue;
									}
									$scope.data_practice.worktime=(item.supWorktime ? item.supWorktime.indexOf("小时")>0 ? item.supWorktime : item.supWorktime+"小时" : "");
									//计算志愿服务总时长
									var tim=0;
									if($scope.data_practice.worktime.indexOf("天")>0){
										tim=$scope.data_practice.worktime.replace("天","");
										$scope.hours+=parseFloat(tim)*24;
									}
									if($scope.data_practice.worktime.indexOf("小时")>0){
										tim=$scope.data_practice.worktime.replace("小时","");
										$scope.hours+=parseFloat(tim);
									}
								}
								if(item.dict_mean=='社会工作与技能培训类') {$scope.data_work.nowgrade+=activityCredit;$scope.data_work.categorynum++;}
								if(item.dict_mean=='综合奖励及其他类') {$scope.data_award.nowgrade+=activityCredit;}
							}
						}
					},
					error:function(XMLHttpRequest,textStatus,errorThrown){
						layer.msg("服务器连接失败，请稍后再试")
					}
				});
				if($scope.hours > 0){
					$scope.data_practice.nowgrade+= (Math.round(($scope.hours/12)*100)/100);
				}


			},
			error:function(){
				layer.msg("服务器连接失败，请稍后再试或者联系管理员");
			}
		});
	})
</script>
<script type="text/javascript">
	var studentid="${studentid}";//从session中取得学生id
	var studentID=GetQueryString("studentID");
	studentid=(studentid==null||studentid=="")?studentID:studentid;
	var studentName="";
	var printId="${printId}" ? "${printId}" : GetQueryString("Enigmatic");
	$("#num").text("编号:"+printId);
	// 路径配置
    require.config({
        paths: {
            echarts: '/asset_font_new/build/dist'
        }
    });
    $(function(){
		//获取学生信息
		loadinfor(studentid);
    	var seriesData = [
//            {
//                value : [],
//                name : '',
//            	itemStyle:{
//		            normal:{
//		                color: "#4E82C3" //图标颜色
//		            }
//		        }
//            }
        ];
		var sseriesData_new=[
			{
				value : [],
				name : '',
				itemStyle:{
					normal:{
						color: "#4E82C3" //图标颜色
					}
				}
			}
		];
		function GetQueryString(name)
		{
			var reg = new RegExp("(^|&)"+ name +"=([^&]*)(&|$)");
			var r = window.location.search.substr(1).match(reg);
			if(r!=null)return  decodeURI(r[2]); return null;
		}
		//加载六项能力得分
		$.ajax({
			type:"post",
			url:"/char/loadSixElementPoint.form?studentid="+studentid ,
			dataType: "json",
			async: false,
			success: function (data) {
				if(data.total<=0) return;
				if(data.total>0){
					//取最后一个年份的数据用来计算 综合能力素质评定等级为 优秀还是良好
					point_Level(data.rows[data.rows.length-1]);
					//做个判断 至多给显示4个年份
					//雷达图上线的颜色和右上角年份颜色对应上
					var color=["#bacc1c","#f2bc1f","#da3615","#4d82c3"];
					if(data.total<=4){
						for(var i=0;i<data.total;i++){
							var str={
								value : [],
								name : '',
								itemStyle:{
									normal:{
										color: color[i] //图标颜色
									}
								}
							};
							str.value.push(data.rows[i].biaoda);
							str.value.push(data.rows[i].chuangye);
							str.value.push(data.rows[i].chuangxin);
							str.value.push(data.rows[i].lingdao);
							str.value.push(data.rows[i].sibian);
							str.value.push(data.rows[i].zhixing);
							str.name=data.rows[i].pointYear;
							seriesData.push(str);
						}
					}else{
						//有超过4个年份的数据，取后4条
						for(var i=data.total-4;i<data.total;i++){
							var str={
								value : [],
								name : '',
								itemStyle:{
									normal:{
										color: color[i] //图标颜色
									}
								}
							};
							str.value.push(data.rows[i].biaoda);
							str.value.push(data.rows[i].chuangye);
							str.value.push(data.rows[i].chuangxin);
							str.value.push(data.rows[i].lingdao);
							str.value.push(data.rows[i].sibian);
							str.value.push(data.rows[i].zhixing);
							str.name=data.rows[i].pointYear;
							seriesData.push(str);
						}
					}
					//	分数条赋值数据 (最后一个年份)
					sseriesData_new[0].value.push(data.rows[data.total-1].biaoda);
					sseriesData_new[0].value.push(data.rows[data.total-1].zhixing);
					sseriesData_new[0].value.push(data.rows[data.total-1].sibian);
					sseriesData_new[0].value.push(data.rows[data.total-1].lingdao);
					sseriesData_new[0].value.push(data.rows[data.total-1].chuangxin);
					sseriesData_new[0].value.push(data.rows[data.total-1].chuangye);
					sseriesData_new[0].name=data.rows[data.total-1].pointYear;
					//右上角显示几个年份及数值问题
					for(var i=0;i<seriesData.length;i++){
						$(".color2").children("li").eq(i).html(seriesData[i].name+"年");
					}
					$(".color2").children("li").eq(seriesData.length-1).show();
					$(".color2").children("li").eq(seriesData.length-1).prevAll().show();
				}
			},
			error: function () {
				layer.msg("服务器连接失败，请稍后再试或者联系管理员");
			}
		});

		//赋值年份标签---已不用
        var yearTag = "";
        for(var i=0;i<seriesData.length;i++){
        	yearTag += "<div class='year'><span class='color' style='background:"+seriesData[i].itemStyle.normal.color+"'></span><span class='year_word'>"+seriesData[i].name+"年</span></div>";
        }
        //$("#YearBox").html(yearTag);
        //赋值各项数值
        if(sseriesData_new.length>0){
        	for(var i=0;i<sseriesData_new[0].value.length;i++){
        		var width = parseInt(26*sseriesData_new[0].value[i]/100);
        		$(".number_data").find("li").eq(i).find(".number_data_col").animate({"width":width+"mm"},800,"swing");
        		$(".number_data").find("li").eq(i).find(".number_data_value").text(sseriesData_new[0].value[i]);
        	}
        }
        //赋值雷达图
        chartRadar(seriesData);
    });
	/**
	 * 计算综合成绩评定是优秀还是良好的主程序
	 * @param row
     */
	function point_Level(row){
		if(!row){
			$("#point_level").text("良好");
			return;
		}
		var arr=[row.biaoda,row.chuangxin,row.chuangye,row.lingdao,row.sibian,row.zhixing];
		arr.sort();
		arr.reverse();
		console.log(arr);
		$("#point_level").text(point_Level_subFunc(arr) ? "优秀" : "良好");
	}
	/**
	 * 计算综合成绩评定是优秀还是良好的判断方法
	 *	一个达到85，两个达75 为优秀
	 *	三个达到80 为优秀
	 *	 两个达到90，一个达到70为优秀
	 * @param arr	从大到小排好序的六项能力得分的数组
	 * @returns {boolean}  true 表示优秀 flase 表示良好
     */
	function point_Level_subFunc(arr){
		if(arr[0]>=90 && arr[1]>=90 && arr[2]>=70)
				return true;
		else if(arr[0]>=85 && arr[1]>=75 && arr[2]>=75)
				return true;
		else if(arr[0]>=80 && arr[1]>=80 && arr[2]>=80)
				return true;
		else
			return false;
	}
    //雷达图赋值
    function chartRadar(seriesData){
    	require([
	        'echarts',
	        'echarts/chart/radar'
	    ],function (ec) {
	        // 基于准备好的dom，初始化echarts图表
	        var myChart = ec.init(document.getElementById("chart"),"macarons");
	        option = {
			    title : {
			        text: '',
			        subtext: ''
			    },
			    tooltip : {
			        trigger: 'axis'
			    },
			    legend: {
			        orient : 'vertical',
			        x : 'right',
			        y : 'bottom',
			        data:['','']
			    },
			    toolbox: {
			        show : true
			    },
			    polar : [
			       {
					   splitNumber:4,
			           indicator : [
						   { text: '表达',min:20, max: 100},
						   { text: '创业',min:20, max: 100},
						   { text: '创新',min:20, max: 100},
						   { text: '领导',min:20, max: 100},
						   { text: '思辨',min:20, max: 100},
						   { text: '执行',min:20, max: 100}
			            ],name: {
						    show: true,
						    textStyle:{
						        fontSize: 18,
						        color: "#000000"
						    }
						}
			        }
			    ],
			    
			    calculable : true,
			    series : [
			        {
			            name: '',
			            type: 'radar',
			            data : seriesData
			        }
			    ]
			};
	        // 为echarts对象加载数据
	        myChart.setOption(option);
	    });
    }
	function loadinfor(studentid) {
		//加载个人信息
		$.ajax({
			url: "/jsons/loadInfor.form?studentid=" + studentid,
			type: "post",
			dataType: "json",
			async: false,
			success: function (data) {
				if (data != null && data.rows != null && data.rows.length > 0) {
					var row = data.rows[0];
					$(".head_icon").attr("src", "/Files/Images/" + data.rows[0].studentPhoto);
					$(".first_li_span").text(row.studentName);
					$("#sname").text(row.studentName);
					$(".person_value").eq(0).text(row.studentPhone);
					$(".person_value").eq(1).text(row.collegeName);
					$(".person_value").eq(2).text(row.className);
					$(".person_value").eq(3).text(row.majorName);
					$(".person_value").eq(4).text(row.studentID);
					studentName = row.studentName;
				}
			},
			error: function () {
				layer.msg("服务器连接失败，请稍后再试或者联系管理员");
			}
		});
		calculate();
	}

	//综合评价数据
	function calculate() {
		//查六项能力得分
		$.ajax({
			url: "/sixpoint/sixpoint.form",
			type: "post",
			data: {studentID: studentid},
			dataType: "json",
			success: function (data) {
				var sibian,zhixing,biaoda,lingdao,chuangxin,chuangye;
				var top1 = false,top2 = false,top3 = false;
				if (data.rows.length > 0) {
					sibian = parseFloat(data.rows[0].sibian);
					zhixing = parseFloat(data.rows[0].zhixing);
					biaoda = parseFloat(data.rows[0].biaoda);
					lingdao = parseFloat(data.rows[0].lingdao);
					chuangxin = parseFloat(data.rows[0].chuangxin);
					chuangye = parseFloat(data.rows[0].chuangye);
					var value = [biaoda, zhixing, sibian, lingdao, chuangxin, chuangye];
					var newValue = [biaoda, zhixing, sibian, lingdao, chuangxin, chuangye];
					var textvalue = ['表达', '执行', '思辨', '领导', '创新', '创业'];
					var compare = function (x, y) {//比较函数
						if (x < y) {
							return -1;
						} else if (x > y) {
							return 1;
						} else {
							return 0;
						}
					}
					var value1 = value.sort(compare);
					for (var j = 0; j < 6; j++) {
						if (newValue[j] === value1[5] && top1 == false) {
							$("#top1").text(textvalue[j]);
							top1 = true;
							continue
						}
						if (newValue[j] === value1[4] && top2 == false) {
							$("#top2").text(textvalue[j]);
							top2 = true;
							continue
						}
						if (newValue[j] === value1[3] && top3 == false) {
							$("#top3").text(textvalue[j]);
							top3 = true;
						}
					}
				} else {
					//随便写3个能力（都是50分)
					$("#top1").text('思辨');
					$("#top2").text('执行');
					$("#top3").text('表达');
				}
			}
		});
	}
</script>