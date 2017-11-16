/**
 * Created by hong on 2016/7/16.
 */
$(function(){

});
/**
 * 重新加载
 */
function reloadData(){
    $("#dg").datagrid("load",{rows:rows,page:page});
}
/**
 * 刷新当前页
 */
function reloadThis(){
    $("#dg").datagrid("reload");
}
/**
 * 全选
 */
function selectalldata(){
    $("#dg").datagrid("selectAll");
}
/**
 * 取消选择
 */
function unselectdata(){
    $("#dg").datagrid("clearSelections");
}
/**
 * 打开综合条件搜索
 */
function searchBy(){
    if($("#search_condition").hasClass("opened")){
        $("#search_condition").removeClass("opened");
        $("#search_condition").slideUp(300);
    }else{
        $("#search_condition").addClass("opened");
        $("#search_condition").slideDown(300);
    }
}
/**
 * 清空表单
 */
function formreset(){
    $("#search_fm").form("clear");
}
/**
 * 按条件搜索的动作
 */
function searchAction(){
    var json=$("#search_fm").serializeObject();
    json["rows"]=rows;
    json["page"]=page;
    //load();
    $("#dg").datagrid("load",json);
    $("#search_condition").removeClass("opened");
    $("#search_condition").slideUp(300);
    //disLoad();
    //$.ajax({
    //    url:"/jsons/loadStudents.form",
    //    data:json,
    //    type:"post",
    //    dataType:"json",
    //    success:function(data){
    //        if(data){
    //            $("#dg").datagrid("loadData",data);
    //            $("#search_condition").removeClass("opened");
    //            $("#search_condition").slideUp(300);
    //        }
    //        disLoad();
    //
    //    },
    //    error:function(){
    //        ShowMsg("服务器连接失败，请稍后再试");
    //        disLoad();
    //    }
    //})
    //console.log(json);
}

function DeleteMore(){
    var rows=$("#dg").datagrid('getSelections');
    if(rows ==null || rows.length==0){
        ShowMsg("请至少选择一行数据！");
        return;
    }
    var idstr="";
    $.each(rows,function(){
        var id=this[deleteId];
        idstr+=id+"|";
    })
    //console.log(idstr.substring(0,idstr.length-1));
    $.messager.confirm('注意：该操作不可恢复！', '你选择了'+rows.length+'条数据，确认全部删除吗?', function(result){
        if (result){
            //删除数据库记录
            $.ajax({
                url:"/jsons/deleteMoreInfor.form",
                data:{ids:idstr},
                dataType:"json",
                success:function(data){
                    ShowMsg(data.msg);
                    reloadThis();
                },
                error:function(){
                    ShowMsg("服务器连接失败，请重新登陆再试或联系管理员");
                }
            });
        }
    });
}

function editMore(){
    var rows=$("#dg").datagrid('getSelections');
    if(rows ==null || rows.length==0){
        ShowMsg("请至少选择一行数据！");
        return;
    }
    if(rows.length>1){
        ShowMsg("你选择了"+rows.length+"行数据，请取消选择多余的选择！");
        return;
    }
    var row = $('#dg').datagrid('getSelected');
    $("#user_photo").attr("src","/Files/Images/"+row.studentPhoto);
    $("#ceeOrigin").textbox("disable");
    $("#ceeNumber").textbox("disable");
    $("#ceeProvince").textbox("disable");
    $("#ceeCity").textbox("disable");
    $("#ceeHighSchool").textbox("disable");
    $("#studentID").textbox("readonly");
    Edit();
}
function Add_before(){
    $("#user_photo").attr("src","/asset/image/default.jpg");
    $("#ceeOrigin").textbox("enable");
    $("#ceeNumber").textbox("enable");
    $("#ceeProvince").textbox("enable");
    $("#ceeCity").textbox("enable");
    $("#ceeHighSchool").textbox("enable");
    $("#studentID").textbox("readonly",false);
    Add();
}
/**
 * 预览图片功能
  * @param file
 */
function preview(file) {
    var prevDiv = $("#user_photo");
    if (file.files && file.files[0])
    {
        var reader = new FileReader();
        reader.onload = function(evt){
            prevDiv.attr("src",evt.target.result);
        }
        reader.readAsDataURL(file.files[0]);
    }
}
/**
 * 批量导入按键
 */
function batchInsert(){
    $("#batch_dlg").dialog("open");
}
/**
 * 验证文件
 */
function validFile(){
    if(!$("#upfile").val()){
        ShowMsg("请选择文件！");
        return;
    }
    load();
    $.ajaxFileUpload({
        url: "/dataupload/validdata.form", //用于文件上传的服务器端请求地址
        secureuri: false, //一般设置为false
        fileElementId: "upfile", //文件上传空间的id属性
        dataType: 'String', //返回值类型 一般设置为String
        success: function (data, status)  //服务器成功响应处理函数
        {
            //console.log(data);
            showResult(data);
            disLoad();
        },
        error: function (data, status, e)//服务器响应失败处理函数
        {
            ShowMsg("上传文件失败，请重新上传");
            disLoad();
        }
    });
}
/**
 * 上传文件
 */
function uploadFile(){
    if(!$("#upfile").val()){
        ShowMsg("请选择文件！");
        return;
    }
    load();
    $.ajaxFileUpload({
        url: "/dataupload/studentinfo.form", //用于文件上传的服务器端请求地址
        secureuri: false, //一般设置为false
        fileElementId: "upfile", //文件上传空间的id属性
        dataType: 'String', //返回值类型 一般设置为String
        success: function (data)  //服务器成功响应处理函数
        {
            //console.log(data);
            showResult(data);
            disLoad();
        },
        error: function (data, status, e)//服务器响应失败处理函数
        {
            ShowMsg("上传文件失败，请重新上传");
            disLoad();
        }
    });
}
/**
 * 上传文件后显示服务器返回的信息
 * @param data
 */
function showResult(data){
    $("#valid_result").html("");
    //去除返回字符串的  <pre style="word-wrap: break-word; white-space: pre-wrap;"> 标签
    var str=data.substring(data.indexOf('>')+1,data.lastIndexOf('<'));
    var s= eval("("+str+")");
    var str=s.msg+"<br>";
    if(s.data){
        $.each(s.data,function(){
            if(this.data){
                str+="&nbsp;&nbsp;"+this.msg+"<br>";
                $.each(this.data,function(){
                    str+="&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;"+this+"<br>";
                })
            }else{
                str+="&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;"+this+"<br>";
            }

        });
    }
    $("#valid_result").html(str);
}
