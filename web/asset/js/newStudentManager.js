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

    $("#stuClassName").textbox("disable");
    $("#stuGradeName").textbox("disable");
    $("#stuMajorName").textbox("disable");
    $("#stuMajorClass").textbox("disable");
    $("#stuCollageName").textbox("disable");
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
    $("#stuClassName").textbox("enable");
    $("#stuGradeName").textbox("enable");
    $("#stuMajorName").textbox("enable");
    $("#stuMajorClass").textbox("enable");
    $("#stuCollageName").textbox("enable");
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
//下载模版文件
function getModel(){
    window.open("/Files/ExcelModels/students_info.xls");
}
function upImages(){
    $("#batch_up_img").dialog("open");
}
function showName(e){
//            console.log(e.name);//className
    var $id = $("#_"+e.name);
//            console.log($id);
    var _value = "";
    var _text = "";
    $("[name="+ e.name+"]:input:checked").each(function() {
        _value += $(this).val() + ",";
        _text += $(this).next("label").text() + ",";
    });
    //设置下拉选中值
    $id.combo('setValue', _value).combo('setText', _text);
}
function  loadSelectInfo(data,str1,str2) {
    var $divId = $("#" + str2);
    $divId.html("");
    for (var i = 0; i < data.rows.length; i++) {
        var name  = getName(data,str1,i);
        var str = '<input onclick="showName(this)" id="' + str1 + i + '" type="checkbox" name="' + str1 + '" value="' + name + '">' +
            '<label for="' + str1 + i + '">' + name + '</label><br/>';
        str = str.replace(/null/gi, "");
        //添加到div下
        $divId.append(str);
    }
}
function  getName(data,str,i){
    //name 属性
    var name = "";
    switch (str) {
        //班级
        case "stuClassName":
            name = data.rows[i].stuClassName;
            return name;
            break;
        //学制
        case "educationLength":
            name = data.rows[i].educationLength;
            return name;
            break;
        //培养方式
        case "trainingMode":
            name = data.rows[i].trainingMode;
            return name;
            break;
        //招生类别
        case "enrollType":
            name = data.rows[i].enrollType;
            return name;
            break;
        //学院
        case "stuCollageName":
            name = data.rows[i].stuCollageName;
            return name;
            break;
        //专业
        case "stuMajorName":
            name = data.rows[i].stuMajorName;
            return name;
            break;
        //年级
        case "stuGradeName":
            name = data.rows[i].stuGradeName;
            return name;
            break;
        //民族
        case "studentNation":
            name = data.rows[i].studentNation;
            return name;
            break;
        //学籍状态
        case "schoolRollStatus":
            name = data.rows[i].schoolRollStatus;
            return name;
            break;
        //房间号
        case "usiRoomNumber":
            name = data.rows[i].usiRoomNumber;
            return name;
            break;
        //寝室楼
        case "usiBuilding":
            name = data.rows[i].usiBuilding;
            return name;
            break;
        //入学年份
        case "entranceDate":
            name = data.rows[i].entranceDate;
            return name;
            break;
        default:
            return null;
    }
}
//格式化函数
// value: 当前绑定的列字段值。
//row: 当前行记录数据。
// index: 当前行索引。
function rowformater(value,row,index) {
    return "<a class='name_a' href='javascript:void(0);' onclick='moveToEdit("+index+")'>"+value+"</a>";
}

function  moveToEdit(index){
    //连接到保存处
    postURL = editUrl;
    var row=$('#dg').datagrid('getRows')[index];
    if(row) {
        $("#user_photo").attr("src","/Files/Images/"+row.studentPhoto);
        $("#ceeOrigin").textbox("disable");
        $("#ceeNumber").textbox("disable");
        $("#ceeProvince").textbox("disable");
        $("#ceeCity").textbox("disable");
        $("#ceeHighSchool").textbox("disable");
        $("#stuCollageName").textbox("disable");
        $("#stuMajorName").textbox("disable");
        $("#stuGradeName").textbox("disable");
        $("#studentID").textbox("readonly");
        $("#Form").form("clear");
        $('#Form').form('load', row);
        $("#dlg").dialog({title: "修改"});
        $("#dlg").dialog('open');
        $("#dlg").get(0).scrollTop=0;
    }
}
function  showDiv(){

    $(".datagrid-view").show();
    $(".datagrid .datagrid-pager").show();

}
function searchAction1(){
    var json=$("#search_fm").serializeObject();
    json["rows"]=rows;
    json["page"]=page;
//            console.log(json);
    $('#dg').datagrid('options').url='/jsons/loadStudents.form';
    //$('#dg').datagrid('reload',json);
    $("#dg").datagrid("load",json);
    $("#search_condition").removeClass("opened");
    $("#search_condition").slideUp(300);
}
/**
 * 清空表单
 */
function formreset1(){
    //清除所有的下拉复选的已选项
    $("input:checked").attr("checked",false);
    $("#search_fm").form("clear");
}
