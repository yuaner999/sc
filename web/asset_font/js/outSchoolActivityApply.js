//$(function(){
//	//选择照片
//	$("#upimg_btn").click(choose())
//	function choose () {
//		var upimg = document.getElementById('upimg_btn');
//		var show  = document.getElementById('show');
//
//
//		if(!(window.FileReader && window.File && window.FileList && window.Blob)){
//			alert ('您的浏览器不支持fileReader，建议使用ie10+浏览器或者谷歌浏览器');
//			upimg.setAttribute('disabled', 'disabled');
//			return false;
//		}
//		upimg.addEventListener('change', function(e){//addEventListener 为 <button> 元素添加点击事件
//			var files = this.files;
//			if(files.length>0 && files.length<=8){
//				// 对文件进行处理，下面会讲解checkFile()会做什么
//				checkFile(this.files);
//			}else if(files.length>8){
//				show.innerHTML="";
//				this.files=null;
//				layer.msg("请选择少于8张图片");
//			}else{
//				show.innerHTML="";
//			}
//		});
//	}
//	function checkFile(files){
//		var html='', i=0;
//		var func = function(){
//			if(i>files.length-1){
//				// 若已经读取完毕，则把html添加页面中
//				show.innerHTML = html;
//				return;
//			}
//			var file = files[i];
//			var reader = new FileReader();
//
//			// show表示<div id='show'></div>，用来展示图片预览的
//			if(!/image\/\w+/.test(file.type)){
//				show.innerHTML = "请确保文件为图像类型";
//				return false;
//			}
//			reader.onload = function(e){
//				html += '<div class="img_box"><img  class="up_img" src="'+e.target.result+'" alt="img"></div>';
//				i++;
//				func(); //选取下一张图片
//			}
//			reader.readAsDataURL(file);
//		}
//		func();
//	}
//
//	/**
//	 * 提交表单
//	 */
//	$("#form1").ajaxForm({
//		beforeSerialize:function(){
//			//layer.load(1, {shade: [0.4,'#000']});
//			var title= $.trim($("#outTitle").val());
//			var award= $.trim($("#outAward").val());
//			var content= $.trim($("#outContent").val());
//			var files=$("#upimg_btn").val();
//			if(!title || !award || !content || !files){
//				layer.msg("表格不能留空");
//				//window.setTimeout("window.location='outSchoolActivityApply.form'",2000);
//				return false;
//			}
//		},
//		dataType:"json",
//		success:function(data){
//			layer.closeAll();
//			$("#form1").clearForm();
//			$("#form1").resetForm();
//			$("#show").html("");
//
//			if(data.status==0){
//
//				layer.msg("提交成功");
//				if(data.data && data.data.length>0){
//					var resutl="";
//					for(var i=0;i<data.data.length;i++){
//						result=resutl+data.data[i]+",";
//					}
//					if(resutl.length>0)
//						layer.alert("未上传成功文件："+resutl.substring(0,resutl.length-1));
//				}
//			}
//		},
//		error:function(){
//			layer.closeAll();
//			layer.msg("服务器连接失败，请稍后再试");
//		}
//	});
//});