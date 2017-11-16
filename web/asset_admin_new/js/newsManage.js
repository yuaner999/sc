
/**
 * 预览图片功能
 * @param file
 */
function preview(file) {
	var prevDiv = $("#newsImgs");
	if (file.files && file.files[0])
	{
		var reader = new FileReader();
		reader.onload = function(evt){
			prevDiv.attr("src",evt.target.result);
		}
		reader.readAsDataURL(file.files[0]);
	}
}
//        /**
//         * 新增前加入图片
//         * @constructor
//         */
//        function Add_before(){
//            $("#user_photo").attr("src","/asset/image/news.jpg");
//            Add();
//        }
//        /**
//         * 修改前加入图片
//         * @constructor
//         */
//        function editMore(){
//            var row = $('#dg').datagrid('getSelected');
//            $("#user_photo").attr("src","/Files/Images/"+row.newsImg);
//            Edit();
//        }

