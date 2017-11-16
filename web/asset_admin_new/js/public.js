//var postURL = "";//请求的URL地址
//var oldPicture = "";
//var clickStatus = "";//点击状态
//var fileUpload="";
//var editor;
//var rows=8; //每页显示行数
//var page=1;//当前页码
//var totalNum;//总数据条数
///**
// * 加载数据
// */
//$(function(){
//    KindEditor.ready(function(K) {
//        editor = K.create('textarea[name="'+editorName+'"]', {
//            allowFileManager: true,
//            //添加this.sync ()使数据保存发哦数据库中
//            afterBlur:function(){this.sync();}
//        });
//    });
//    reload();
//});
//function  reload(){
//    load();
//    page= $(".currentPageNum").html();
//    $.ajax({
//        url:loadUrl,
//        type:"post",
//        data:{rows:rows,page:page},
//        dataType:"json",
//        success:function(data){
//            $("tbody").html("");
//            if(data!=null && data.rows!=null &&data.rows.length>0){
//                for(var i = 0 ;i<data.rows.length;i++){
//                    var row = data.rows[i];
//                    var tr = '<tr id="tr'+(i+1)+'">'+
//                        '<td>'+(i+1)+'</td>'+
//                        '<td class="fontStyle newsTitle">'+row.newsTitle+'</td>'+
//                        '<td class="newsContent">'+row.newsContent+'</td>'+
//                        '<td class="newsType">'+row.newsType+'</td>'+
//                        '<td class="newsCreator">'+row.newsCreator+'</td>'+
//                        '<td class="newsId" style="display:none">'+row.newsId+'</td>'+
//                        '<td class="newsImg" style="display:none">'+row.newsImg+'</td>'+
//                        '</tr>';
//                    $("tbody").append(tr);
//                }
//                rowClick();
//                totalNum=data.total;
//                $(".pageNum").eq(0).html(Math.ceil( data.total/rows));
//                $(".pageNum").eq(1).html(rows*(page-1)+1);
//                if(data.total<page*rows){
//                    $(".pageNum").eq(2).html(data.total);
//                }else{
//                    $(".pageNum").eq(2).html(page*rows);
//                }
//                $(".pageNum").eq(3).html(rows);
//            }
//
//        },error:function(){
//            layer.msg("网络错误");
//        }
//    });
//
//    disLoad();
//}
///**
// * 新建
// * @constructor
// */
//function Add(){
//    postURL = addUrl;
//    if(editorName!="null"){//清除KindEditor内容
//        KindEditor.instances[0].html('');
//    }
//    //清空表单
//    document.getElementById("Form").reset();
//    $("#user_photo").attr("src","<%=request.getContextPath()%>/asset/image/default.jpg");
//    $("#dlg").get(0).scrollTop=0;
//    reload();
//    clickStatus="";
//}
///**
// * 修改
// * @constructor
// */
//
//function Edit(){
//    postURL=editUrl;
//
//}
//function  Delete(){
//
//        if(clickStatus!=""&&clickStatus!=null){
//            postURL=deleteUrl;
//            layer.confirm('确认删除此条数据吗?', function(result) {
//                if (result) {
//                    //删除数据库记录
//                    var selectId = $("#newsId").val();
//                    var deleteJsonObject = eval("(" + "{'" + deleteId + "':'" + selectId + "'}" + ")");
//                    $.post(postURL, deleteJsonObject, function (data) {
//                        if (data.result) {
//                            console.log(data);
//                            layer.msg("删除成功");
//                           reload();//重新加载数据
//                        } else {
//                            layer.msg("删除失败，请重新登录或联系管理员");
//                        }
//                    });
//                }
//            });
//        }else{
//            layer.msg("请选择一条数据");
//        }
//
//}
////保存
//function Save(){
//    var jsonObject = $("#Form").serializeObject();
//    jsonObject["moduleType"] = moduleType;
//    if(editorName &&editorName!="null"){
//        editor.sync();
//        jsonObject[editorName] = $("#"+editorName).val();
//    }
//    load();
//    if(imageUpload==null||imageUpload==""){//如果没有图片上传
//        if(!fileUpload){//如果没有文件上传
//            UploadToDatabase(jsonObject);
//        }else {//有文件上传
//            if($("#"+fileUpload).val()!=null&&$("#"+fileUpload).val()!=""){
//                ajaxFileUpload("/FileUpload/No_Intercept_Upload.form",fileUpload,jsonObject,2);
//            }else {
//                UploadToDatabase(jsonObject);
//            }
//        }
//    }else {//有图片上传
//        if($("#"+imageUpload).val()!=null&&$("#"+imageUpload).val()!=""){
//            ajaxFileUpload("/ImageUpload/No_Intercept_Upload.form",imageUpload,jsonObject,1);
//        }else {
//            if(!fileUpload){//如果没有文件上传
//                console.log(jsonObject);
//                UploadToDatabase(jsonObject);
//            }else {//有文件上传
//                if($("#"+fileUpload).val()!=null&&$("#"+fileUpload).val()!=""){
//                    ajaxFileUpload("/FileUpload/No_Intercept_Upload.form",fileUpload,jsonObject,2);
//                }else {
//                    UploadToDatabase(jsonObject);
//                }
//            }
//        }
//    }
//}
////序列化
//$.fn.serializeObject = function()
//{
//    var o = {};
//    var a = this.serializeArray();
//    $.each(a, function() {
//        if (o[this.name]) {
//            if (!o[this.name].push) {
//                o[this.name] = [o[this.name]];
//            }
//            o[this.name].push(this.value || '');
//        } else {
//            o[this.name] = this.value || '';
//        }
//    });
//    return o;
//};
////文件(图片)上传
//function ajaxFileUpload(url,id,jsonObject,time){
//    $.ajaxFileUpload({
//        url: url, //用于文件上传的服务器端请求地址
//        secureuri: false, //一般设置为false
//        fileElementId: id, //文件上传空间的id属性
//        dataType: 'String', //返回值类型 一般设置为String
//        success: function (data, status)  //服务器成功响应处理函数
//        {
//            if(data!=""||data!=null){
//                var data = eval("(" + data + ")");
//                if(typeof(data.error) != 'undefined') {
//                    if (data.error == 0) {
//                        jsonObject[id] = data.filename;
//                        //如果time为1，证明图片已经上传完成，该上传文件，判断是否需要上传文件
//                        if(time==1&&fileUpload!=""&&$("#"+fileUpload).val()!=null&&$("#"+fileUpload).val()!=""){
//                            ajaxFileUpload("/FileUpload/No_Intercept_Upload.form",fileUpload,jsonObject,2);
//                        }else {
//                            UploadToDatabase(jsonObject);
//                        }
//                    } else {
//                        layer.msg("上传文件出错："+data.message);
//                        disLoad();
//                    }
//                }else{
//                    layer.msg("上传文件出错："+data.message);
//                    disLoad();
//                }
//            }else {
//                layer.msg("上传文件失败，请重新上传");
//                disLoad();
//            }
//        },
//        error: function (data, status, e)//服务器响应失败处理函数
//        {
//            layer.msg("上传文件失败，请重新上传");
//            disLoad();
//        }
//    });
//}
////上传数据到数据库
//function UploadToDatabase(jsonObject){
//    $.ajax({
//        url:postURL,
//        type:"post",
//        dataType:"json",
//        data:jsonObject,
//        success:function(data){
//            disLoad();
//            if(data.result){
//                close();
//                layer.msg("保存成功");
//
//            }else {
//                layer.msg("保存中出现错误");
//            }
//        },
//        error:function(){
//            disLoad();
//            layer.msg("服务器连接失败");
//        },
//        complete: function(XMLHttpRequest, textStatus) {
//            reload();
//        }
//    })
//}
//function close(){
//    $('#dlg').hide();
//    $('.popup').slideUp(400);
//    $('.new').slideUp(300);
//}
///**
// * 预览图片功能
// * @param file
// */
//function preview(file) {
//    var prevDiv = $("#user_photo");
//    if (file.files && file.files[0])
//    {
//        var reader = new FileReader();
//        reader.onload = function(evt){
//            prevDiv.attr("src",evt.target.result);
//        }
//        reader.readAsDataURL(file.files[0]);
//    }
//}
////行点击事件
//function rowClick(){
//
//    $("tbody tr").click(function()
//    {
//        clickStatus='true';
//        $("table tr").css('background-color','white');//先将颜色改为以前面的颜色
//        $(this).css('background-color','yellow');//再将单击的那行改成需要的颜色
//
//        $("#newsTitle").val($(this).find(".newsTitle").text()); //赋值弹出的对话框，为edit做准备
//        $("#newsType").val($(this).find(".newsType").text());
//        $("#newsId").val($(this).find(".newsId").text());
//        $("#newsImgh").val($(this).find(".newsImg").text());
//        $("#user_photo").attr("src",'/Files/Images/'+$(this).find(".newsImg").text());
//        editor.html($(this).find(".newsContent").html());
//    });
//}
////弹出加载层
//function load() {
//    $("<div class=\"datagrid-mask\" style='z-index: 9999999999999999999;'></div>").css({ display: "block", width: "100%", height: $(window).height() }).appendTo("body");
//    $("<div class=\"datagrid-mask-msg\" style='z-index: 9999999999999999999;'></div>").html("正在加载，请稍候...").appendTo("body").css({ display: "block", left: ($(document.body).outerWidth(true) - 190) / 2, top: ($(window).height() - 45) / 2 });
//}
//
////取消加载层
//function disLoad() {
//    $(".datagrid-mask").remove();
//    $(".datagrid-mask-msg").remove();
//}
////上一页
//function turn_left(){
//    var newpage1= parseInt($(".currentPageNum").html());
//    if(newpage1<=1){
//        newpage1=1;
//    }else{
//        newpage1=newpage1-1;
//    }
//    $(".currentPageNum").html(newpage1);
//    reload();
//};
////下一页
//function turn_right(){
//    var newpage2= parseInt($(".currentPageNum").html());
//
//    if(newpage2>=Math.ceil(totalNum/rows)){
//        newpage2=Math.ceil(totalNum/rows);
//    }else{
//        newpage2=newpage2+1;
//    }
//    $(".currentPageNum").html(newpage2);
//    reload();
//};
////综合查询
//function select_box(){
//    postURL='/jsons/loadStudents.form';
//    var jsonObject = $(".searchContent").serializeObject();
//    jsonObject["studentID"] = $(".searchContent input").eq(0).val();
//    jsonObject["studentIdCard"] = $(".searchContent input").eq(1).val();
//    jsonObject["studentName"] = $(".searchContent input").eq(2).val();
//    jsonObject["studentPhone"] = $(".searchContent input").eq(3).val();
//    jsonObject["politicsStatusDate"] = $(".searchContent input").eq(4).val();
//    jsonObject["usiCampus"] = $(".searchContent input").eq(5).val();
//
//    jsonObject["stuGradeName"] = $(".searchContent li ul").eq(0).children("li").eq(0).html();
//    jsonObject["usiBuilding"] = $(".searchContent li ul").eq(1).children("li").eq(0).html();
//    jsonObject["trainingMode"] = $(".searchContent li ul").eq(2).children("li").eq(0).html();
//    jsonObject["usiRoomNumber"] = $(".searchContent li ul").eq(3).children("li").eq(0).html();
//    jsonObject["enrollType"] = $(".searchContent li ul").eq(4).children("li").eq(0).html();
//    jsonObject["studentGender"] = $(".searchContent li ul").eq(5).children("li").eq(0).html();
//    jsonObject["stuCollageName"] = $(".searchContent li ul").eq(6).children("li").eq(0).html();
//    jsonObject["entranceDate"] = $(".searchContent li ul").eq(7).children("li").eq(0).html();
//    jsonObject["schoolRollStatus"] = $(".searchContent li ul").eq(8).children("li").eq(0).html();
//    jsonObject["studentNation"] = $(".searchContent li ul").eq(9).children("li").eq(0).html();
//    jsonObject["stuMajorName"] = $(".searchContent li ul").eq(10).children("li").eq(0).html();
//    jsonObject["stuClassName"] = $(".searchContent li ul").eq(11).children("li").eq(0).html();
//    jsonObject["educationLength"] = $(".searchContent li ul").eq(12).children("li").eq(0).html();
//    jsonObject["rows"] =rows;
//    jsonObject["educationLength"] =page;
//
//    $.ajax({
//        url:postURL,
//        type:"post",
//        data:jsonObject,
//        dataType:"json",
//        success:function(data){
//            $("tbody").html("");
//            if(data!=null && data.rows!=null &&data.rows.length>0){
//                for(var i = 0 ;i<data.rows.length;i++){
//                    var row = data.rows[i];
//                    var tr = '<tr id="tr'+(i+1)+'">'+
//                        '<td>'+(i+1)+'</td>'+
//                        '<td class="fontStyle newsTitle">'+row.newsTitle+'</td>'+
//                        '<td class="newsContent">'+row.newsContent+'</td>'+
//                        '<td class="newsType">'+row.newsType+'</td>'+
//                        '<td class="newsCreator">'+row.newsCreator+'</td>'+
//                        '<td class="newsId" style="display:none">'+row.newsId+'</td>'+
//                        '<td class="newsImg" style="display:none">'+row.newsImg+'</td>'+
//                        '</tr>';
//                    $("tbody").append(tr);
//                }
//                rowClick();
//                totalNum=data.total;
//                $(".pageNum").eq(0).html(Math.ceil( data.total/rows));
//                $(".pageNum").eq(1).html(rows*(page-1)+1);
//                if(data.total<page*rows){
//                    $(".pageNum").eq(2).html(data.total);
//                }else{
//                    $(".pageNum").eq(2).html(page*rows);
//                }
//                $(".pageNum").eq(3).html(rows);
//            }
//
//        },error:function(){
//            layer.msg("网络错误");
//        }
//    });
//
//    $('.searchContent').slideToggle();
//
//}
////清空
//function clear_search(){
//    $(".searchContent input").eq(0).val('');
//    $(".searchContent input").eq(1).val('');
//    $(".searchContent input").eq(2).val('');
//    $(".searchContent input").eq(3).val('');
//    $(".searchContent input").eq(4).val('');
//    $(".searchContent input").eq(5).val('');
//
//    $(".searchContent li ul").eq(0).children("li").eq(0).html('<li></li>');
//    $(".searchContent li ul").eq(1).children("li").eq(0).html('<li></li>');
//    $(".searchContent li ul").eq(2).children("li").eq(0).html('<li></li>');
//    $(".searchContent li ul").eq(3).children("li").eq(0).html('<li></li>');
//    $(".searchContent li ul").eq(4).children("li").eq(0).html('<li></li>');
//    $(".searchContent li ul").eq(5).children("li").eq(0).html('<li></li>');
//    $(".searchContent li ul").eq(6).children("li").eq(0).html('<li></li>');
//    $(".searchContent li ul").eq(7).children("li").eq(0).html('<li></li>');
//    $(".searchContent li ul").eq(8).children("li").eq(0).html('<li></li>');
//    $(".searchContent li ul").eq(9).children("li").eq(0).html('<li></li>');
//    $(".searchContent li ul").eq(10).children("li").eq(0).html('<li></li>');
//    $(".searchContent li ul").eq(11).children("li").eq(0).html('<li></li>');
//    $(".searchContent li ul").eq(12).children("li").eq(0).html('<li></li>');
//}