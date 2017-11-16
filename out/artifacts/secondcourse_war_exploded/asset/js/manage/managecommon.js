/**
 * Created by liulei on 2016/4/23.
 *
 *
 * ！！！！！！！！！！！！禁止修改此JS文件！！！！！！！！！！！！
 * ！！！！！！！！！！！！禁止修改此JS文件！！！！！！！！！！！！
 * ！！！！！！！！！！！！禁止修改此JS文件！！！！！！！！！！！！
 * ！！！！！！！！！！！！禁止修改此JS文件！！！！！！！！！！！！
 * ！！！！！！！！！！！！禁止修改此JS文件！！！！！！！！！！！！
 */
var postURL = "";//请求的URL地址
var oldPicture = "";
var clickStatus = "";//点击状态
var fileUpload="";
//新建
function Add(){
    postURL = addUrl;
    clickStatus = "add";
    if(editorName!="null"){//清除KindEditor内容
        KindEditor.instances[0].html('');
    }
    $("#Form").form("clear");
    $("#dlg").dialog({title: "新建"});
    $("#dlg").dialog('open');
    $("#dlg").get(0).scrollTop=0;
}

//删除
function Delete(){
    clickStatus = "delete";
    postURL = deleteUrl;
    var row = $('#dg').datagrid('getSelected');
    if (row){
        $.messager.confirm('提示', '确认删除此条数据吗?', function(result){
            if (result){
                //删除数据库记录
                var selectId = row[deleteId];
                var deleteJsonObject = eval("("+"{'"+deleteId+"':'"+selectId+"'}"+")");
                $.post(postURL,deleteJsonObject,function(data){
                    if(data.result){
                        ShowMsg("删除成功");
                        $("#dg").datagrid("reload");//重新加载数据
                    }else {
                        ShowMsg("删除失败，请重新登录或联系管理员");
                    }
                });
            }
        });
    }else {
        ShowMsg("请选中一条数据");
    }
}
//修改
function Edit(){
    clickStatus = "edit";
    postURL = editUrl;
    var row = $('#dg').datagrid('getSelected');
    if (row){
        $("#Form").form("clear");
        $('#Form').form('load', row);
        if(editorName!="null"){//为KindEditor赋值
            KindEditor.instances[0].html(row[editorName]);
        }
        $("#dlg").dialog({title: "修改"});
        $("#dlg").dialog('open');
        $("#dlg").get(0).scrollTop=0;
    }else {
        ShowMsg("请选中一条数据");
    }
}
//重置
function reset(){
    clickStatus = "reset";
    postURL = resetUrl;
    var row = $('#dg').datagrid('getSelected');
    if (row){
        $.messager.confirm('提示', '确认重置此管理员密码吗?', function(result){
            if (result){
                //删除数据库记录
                var selectId = row[deleteId];
                var deleteJsonObject = eval("("+"{'"+deleteId+"':'"+selectId+"'}"+")");
                $.post(postURL,deleteJsonObject,function(data){
                    if(data.result){
                        ShowMsg("重置成功");
                        $("#dg").datagrid("reload");//重新加载数据
                    }else {
                        ShowMsg("重置失败，请重新登录或联系管理员");
                    }
                });
            }
        });
    }else {
        ShowMsg("请选中一条数据");
    }
}
//搜索
function doSearch(value,name){
    $('#dg').datagrid('reload',{
        sqlStr: value,
        moduleType:moduleType
    });
}
//审核
function check(){
    clickStatus = "edit";
    postURL = editUrl;
    var row = $('#dg').datagrid('getSelected');
    if (row){
        $("#Form").form("clear");
        $('#Form').form('load', row);
        if(editorName!="null"){//为KindEditor赋值
            KindEditor.instances[0].html(row[editorName]);
        }
        $("#dlg").dialog({title: "审核"});
        $("#dlg").dialog('open');
        $("#dlg").get(0).scrollTop=0;
    }else {
        ShowMsg("请选中一条数据");
    }
}
//保存
function Save(){
    if($("#Form").form('validate')){
        var jsonObject = $("#Form").serializeObject();
        jsonObject["moduleType"] = moduleType;
        if(editorName &&editorName!="null"){
            editor.sync();
            jsonObject[editorName] = $("#"+editorName).val();
        }
        if(!jsonObject["politicsStatusDate"]){
            jsonObject["politicsStatusDate"]=null;
        }
        if(!jsonObject["studentBirthday"]){
            jsonObject["studentBirthday"]=null;
        }
        load();
        if(imageUpload==null||imageUpload==""){//如果没有图片上传
            if(!fileUpload){//如果没有文件上传
                UploadToDatabase(jsonObject);
            }else {//有文件上传
                if($("#"+fileUpload).val()!=null&&$("#"+fileUpload).val()!=""){
                    ajaxFileUpload("/FileUpload/No_Intercept_Upload.form",fileUpload,jsonObject,2);
                }else {
                    UploadToDatabase(jsonObject);
                }
            }
        }else {//有图片上传
            if($("#"+imageUpload).val()!=null&&$("#"+imageUpload).val()!=""){
                ajaxFileUpload("/ImageUpload/No_Intercept_Upload.form",imageUpload,jsonObject,1);
            }else {
                if(!fileUpload){//如果没有文件上传
                    UploadToDatabase(jsonObject);
                }else {//有文件上传
                    if($("#"+fileUpload).val()!=null&&$("#"+fileUpload).val()!=""){
                        ajaxFileUpload("/FileUpload/No_Intercept_Upload.form",fileUpload,jsonObject,2);
                    }else {
                        UploadToDatabase(jsonObject);
                    }
                }
            }
        }
    }else {
        ShowMsg("请按照要求填写");
    }
}
//序列化
$.fn.serializeObject = function()
{
    var o = {};
    var a = this.serializeArray();
    $.each(a, function() {
        if (o[this.name]) {
            if (!o[this.name].push) {
                o[this.name] = [o[this.name]];
            }
            o[this.name].push(this.value || '');
        } else {
            o[this.name] = this.value || '';
        }
    });
    return o;
};

//弹出加载层
function load() {
    $("<div class=\"datagrid-mask\" style='z-index: 9999999999999999999;'></div>").css({ display: "block", width: "100%", height: $(window).height() }).appendTo("body");
    $("<div class=\"datagrid-mask-msg\" style='z-index: 9999999999999999999;'></div>").html("正在加载，请稍候...").appendTo("body").css({ display: "block", left: ($(document.body).outerWidth(true) - 190) / 2, top: ($(window).height() - 45) / 2 });
}

//取消加载层
function disLoad() {
    $(".datagrid-mask").remove();
    $(".datagrid-mask-msg").remove();
}

//文件(图片)上传
function ajaxFileUpload(url,id,jsonObject,time){
    $.ajaxFileUpload({
        url: url, //用于文件上传的服务器端请求地址
        secureuri: false, //一般设置为false
        fileElementId: id, //文件上传空间的id属性
        dataType: 'String', //返回值类型 一般设置为String
        success: function (data, status)  //服务器成功响应处理函数
        {
            if(data!=""||data!=null){
                var data = eval("(" + data + ")");
                if(typeof(data.error) != 'undefined') {
                    if (data.error == 0) {
                        jsonObject[id] = data.filename;
                        //如果time为1，证明图片已经上传完成，该上传文件，判断是否需要上传文件
                        if(time==1&&fileUpload!=""&&$("#"+fileUpload).val()!=null&&$("#"+fileUpload).val()!=""){
                            ajaxFileUpload("/FileUpload/No_Intercept_Upload.form",fileUpload,jsonObject,2);
                        }else {
                            UploadToDatabase(jsonObject);
                        }
                    } else {
                        ShowMsg("上传文件出错："+data.message);
                        disLoad();
                    }
                }else{
                    ShowMsg("上传文件出错："+data.message);
                    disLoad();
                }
            }else {
                ShowMsg("上传文件失败，请重新上传");
                disLoad();
            }
        },
        error: function (data, status, e)//服务器响应失败处理函数
        {
            ShowMsg("上传文件失败，请重新上传");
            disLoad();
        }
    });
}

//上传数据到数据库
function UploadToDatabase(jsonObject){
    $.ajax({
        url:postURL,
        type:"post",
        dataType:"json",
        data:jsonObject,
        success:function(data){
            disLoad();
            if(data.result){
                $('#dlg').dialog('close');
                ShowMsg("保存成功");
                $("#dg").datagrid("reload");
            }else {
                ShowMsg("保存中出现错误");
            }
        },
        error:function(){
            disLoad();
            ShowMsg("服务器连接失败");
        }
    })
    //$.post(postURL,jsonObject,function(data){
    //    disLoad();
    //    if(data.result){
    //        $('#dlg').dialog('close');
    //        ShowMsg("保存成功");
    //        $("#dg").datagrid("reload");
    //    }else {
    //        ShowMsg("保存中出现错误");
    //    }
    //});
}
//格式化日期把毫秒值转成字符串
function DateFormat(time,formateStr){
    var date;
    if(!formateStr) formateStr="yyyy-MM-dd";
    if(time)  date=new Date(time);
    else date=new Date();
    var year=date.getFullYear();
    var month=date.getMonth()+1;
    var day=date.getDate();
    var h=date.getHours();
    var min=date.getMinutes();
    var sec=date.getSeconds();
    formateStr=formateStr.replace("yyyy",""+year);
    formateStr=formateStr.replace("MM",""+month>9?month:"0"+month);
    formateStr=formateStr.replace("dd",""+day>9?day:"0"+day);
    formateStr=formateStr.replace("HH",""+h>9?h:"0"+h);
    formateStr=formateStr.replace("mm",""+min>9?min:"0"+min);
    formateStr=formateStr.replace("ss",""+sec>9?sec:"0"+sec);
    return formateStr;
}
//easyui中dateformatter
function datefomatter(Value){
    if(!Value) return "";
    return DateFormat(Value);
}
////查看新闻图片
//function LookPicture(){
//    var row = $('#dg').datagrid('getSelected');
//    if (row){
//        $("#PictureViewer").attr("src","");
//        $('#dd').dialog({
//            modal:true
//        });
//        var pictureName = row.newspicture;
//        $("#PictureViewer").attr("src","/Files/Images/"+pictureName);
//    }else {
//        ShowMsg("请选中一条数据");
//    }
//}
