/**
 * Created by answer on 2017/5/11.
 */
var moduleType = GetQueryString("moduleType");//所属模块的ID，不可以删除
//1、第一处修改，修改增删改的请求地址
var addUrl = "";
var editUrl = "/jsons/UpdateSupplement.form";
var deleteUrl = "";
var editorName = "null";//KindEditor的Textarea的ID，如果没用到，赋值为null
var imageUpload = "";//图片上传的标识，如果没有图片上传，赋值为空，如果有，赋值为数据库存放图片名称的字段名称，不带_
var deleteId = "";//用于删除功能的ID参数，赋值为当前数据库表的ID
var editId = "";//用于修改功能的ID参数，赋值为当前数据库表的ID
var loadUrl = "/supplementInfo/loadSupplementClass.form";//注：此处为新增
var sqlStr = "";//注：模糊查询
var jsonPara;//参数
var applyId="";
var rowM;
var orderByName='1';//按照该字段排序
var sequence=0; // 0正序 1倒序
var box=0.25;
$(function(){
    //全选复选框
    $("#submitAll").change(function(){
        if($(this).is(":checked")){
            $(".checkes").attr("checked",true);
        }else {
            $(".checkes").attr("checked",false);
        }
    });
    //默认直接查询所有
    $("#search").click();
    //点击表格头部实现排序
    $("#forOrder>td").click(function () {
        var str=$(this).html();
        if(str.indexOf("checkbox")>=0)
            return;
        if($(this).hasClass("beSelect")){
            sequence++;
            if(sequence==2) sequence=0;
        }else{
            sequence=0;
            $(this).siblings().removeClass('beSelect');
            $(this).addClass("beSelect");
        }
        orderByName=($(this).text());
        select_box(1);
    });
    //绑定跳页Enter键
    $(".currentPageNum").keyup(function(e){
        var pagNum = $(".currentPageNum").val();
        if(e.keyCode==13){
            select_box(pagNum);
        }
    });
    //关闭蒙板
    $(".iconConcel").click(function(){
        $('.new').slideUp(300);
        $('.popup').slideUp(400);
        $("#getScore").show();
        row=null;
        $(".qx_check").attr("checked",false);
    });
    //至少选择一个
    $(".qx_check").click(function(){
        var qxs=$(".qx_check:checked");
        if(qxs.length>3){
            layer.alert("最多只能选3项增加能力",{offset:['30%'] });
            $(this).attr("checked",false);
        }
        if(qxs.length<1){
            layer.alert("必须选一项增加能力",{offset:['30%'] });
            $(this).attr("checked",false);
            return false;
        }
    });
    //综合查询条件：学院
    $.ajax({
        url: "<%=request.getContextPath()%>/jsons/loadstuCollageName.form",
        dataType: "json",
        data:{stuCollageName:''},
        success: function (data) {
            var friends = $("#_stuCollageName");
            friends.empty();
            friends.append("<option value=''>请选择</option>");
            friends.append("<option value=''>全部</option>");
            if(data.rows !=null && data.rows.length > 0){
                for(var i=0;i<data.rows.length;i++) {
                    var option = $("<option>").text(data.rows[i].stuCollageName).val(data.rows[i].stuCollageName);
                    friends.append(option);
                }
            }else{
                var option = $("<option>").text("无");
                friends.append(option);
            }
        }
    });
    $("#_stuCollageName").change(function(){
        //综合查询条件：专业
        $.ajax({
            url:"<%=request.getContextPath()%>/jsons/loadstuMajorName.form",
            dataType:"json",
            data:{stuCollageName:$(this).val()},
            success:function(data){
                var friends = $("#_stuMajorName");
                friends.empty();
                friends.append("<option value=''>请选择</option>");
                friends.append("<option value=''>全部</option>");
                if(data.rows !=null && data.rows.length > 0){
                    for(var i=0;i<data.rows.length;i++) {
                        var option = $("<option>").text(data.rows[i].stuMajorName).val(data.rows[i].stuMajorName);
                        friends.append(option);
                    }
                }else{
                    var option = $("<option>").text("无");
                    friends.append(option);
                }
            }
        });
    })
    $("#_stuMajorName").change(function(){
        //综合查询条件：年级
        $.ajax({
            url: "<%=request.getContextPath()%>/jsons/loadstuGradeName.form",
            dataType: "json",
            data:{stuMajorName:$(this).val()},
            success: function (data) {
                var friends = $("#_stuGradeName");
                friends.empty();
                friends.append("<option value=''>请选择</option>");
                friends.append("<option value=''>全部</option>");
                if(data.rows !=null && data.rows.length > 0){
                    for(var i=0;i<data.rows.length;i++) {
                        var option = $("<option>").text(data.rows[i].stuGradeName).val(data.rows[i].stuGradeName);
                        friends.append(option);
                    }
                }else{
                    var option = $("<option>").text("无");
                    friends.append(option);
                }
            }
        });
    });
    $("#_stuGradeName").change(function(){
        //z综合查询条件：班级
        $.ajax({
            url: '<%=request.getContextPath()%>/jsons/loadclassnames1.form',
            dataType: "json",
            data:{stuGradeName:$(this).val(),collegename:$("#_stuCollageName").val(),stuMajorName:$("#_stuMajorName").val()},
            success: function (data) {
                var friends = $("#_stuClassName");
                friends.empty();
                friends.append("<option value=''>请选择</option>");
                friends.append("<option value=''>全部</option>");
                if(data.rows !=null && data.rows.length > 0){
                    for(var i=0;i<data.rows.length;i++) {
                        var option = $("<option>").text(data.rows[i].stuClassName).val(data.rows[i].stuClassName);
                        friends.append(option);
                    }
                }else{
                    var option = $("<option>").text("无");
                    friends.append(option);
                }
            }
        });
    });
    //加载待审核、未通过、已通过数据
    function reloadsearch(val){
        jsonPara={rows:$("#rows").val(),page:1,regimentAuditStatus:val}
        reload();
    }
});
//阻止checkbox 冒泡
function stopBubble(e) {
    if (e && e.stopPropagation) {
        e.stopPropagation();
    }
    else {
        window.event.cancelBubble = true;
    }
}
function  reload() {//此处加载数据方法名不能修改，必须用reload
    $(".table").show();
    $(".pagingTurn").show();
    $(".checks").checked=false;
    load();
    $.ajax({
        url: loadUrl,
        type: "post",
        data:jsonPara,
        dataType: "json",
        success: function (data) {
            $("tbody").html("");
            if (data != null && data.rows != null && data.rows.length > 0) {
                for (var i = 0; i < data.rows.length; i++) {
                    var row = data.rows[i];
                    for(var key in row){
                        if(!row[key] || row[key]=="null"){
                            row[key]="";
                        }
                    }
                    var ttt;
                    if(row.supActivityTitle){
                        ttt=row.supActivityTitle;
                    }else if(row.workName){
                        ttt=row.workName;
                    }else if(row.shipName){
                        ttt=row.shipName;
                    }else{
                        ttt=row.scienceName;
                    }
                    var tr = '<tr id="tr'+(i+1)+'">'+
                        '<td onclick="stopBubble(this)">'+ '<input name="test" class="checkes" type="checkbox" id="submint'+i+'" style="width:18px;height: 20px;" />'+'</td>'+
                        //第二处修改：按照数据库列名进行拼穿
                        '<td class="X" title="'+row.stuClassName +'" onclick=" SearchDetail(this)">'+row.stuClassName+'</td>'+
                        '<td class="X" title="'+row.studentName +'" onclick=" SearchDetail(this)">'+row.studentName+'</td>'+
                        '<td class="X" title="'+row.supStudentId +'" onclick=" SearchDetail(this)">'+row.supStudentId+'</td>'+
                        '<td class="X" title="'+row.supActivityTitle +'" onclick=" SearchDetail(this)">'+ttt+'</td>'+
                        '<td class="X" title="'+row.supClasses +'" onclick=" SearchDetail(this)">'+row.supClasses+'</td>'+
                        '<td class="X" title="'+row.regimentAuditStatus +'" onclick=" SearchDetail(this)">'+row.regimentAuditStatus+'</td>'+
                        '<td class="X"><input type="button" class="function_new function_auditPass noborder" onclick="auditsAction(\'已通过\',this)" value="通过">' +
                        '<input type="button" class="function_auditNotPass noborder" style="margin-left: 10px;" onclick="auditsAction_no(\'未通过\',this)" value="不通过"></td>'+
//                                    '<td class="X" title="'+row.collegeAuditStatus +'">'+row.collegeAuditStatus+'</td>'+
//                                    '<td class="X" title="'+row.schoolAuditStaus +'">'+row.schoolAuditStaus+'</td>'+
                        '</tr>';
                    $("tbody").append(tr);
                    $("tbody").find("tr:last").data(row);
                }
                totalNum=data.total;
            }else {
                page=0;
                totalNum=0;
            }
            paging();
            disLoad();
            
        }, error: function () {
            layer.msg("网络错误");
            disLoad();
        }
    })
}
function Info(row) {
    $("#supPhotos").attr("src","/Files/Images/default.jpg");
    if(row){
        if(row.supType=="主题团日") $("#getScore").hide();
        for(var key in row){
            if(row[key]!=null&&row[key]!=""){
                $('#'+key).show();
                $('#Form [name='+key+']').val(row[key]);
                if(key!="supActivityTitle"&&key!="supLevle"&&key!="id"&&key!="supCredit"){
                    $('#Form [name='+key+']').attr("disabled","disabled");
                }
                $('#Form [name='+key+']').attr("title",row[key]);
            }else {
                $('#'+key).hide();
            }
            if(row.supAward!="一等奖"&&row.supAward!="二等奖"&&row.supAward!="三等奖"&&row.supAward!=""&&row.supAward!=null){
                $("#Award").show();
                $('[name="Award"]').val(row.supAward);
                $('[name="supAward"]').val("其他");
            }else {
                $("#Award").hide();
                $("#supAward").val(row.supAward);
            }
            var supPowers=row.supPowers;
            if(supPowers!=null&&supPowers!=""){
                var activityPowers=supPowers.split("|");
                for(var i=0;i<activityPowers.length;i++){
                    if(activityPowers[i]=="思辨能力"){
                        $("#qx1").attr("checked",true);
                    }
                    if(activityPowers[i]=="执行能力"){
                        $("#qx2").attr("checked",true);
                    }
                    if(activityPowers[i]=="表达能力"){
                        $("#qx3").attr("checked",true);
                    }
                    if(activityPowers[i]=="领导能力"){
                        $("#qx4").attr("checked",true);
                    }
                    if(activityPowers[i]=="创新能力"){
                        $("#qx5").attr("checked",true);
                    }
                    if(activityPowers[i]=="创业能力"){
                        $("#qx6").attr("checked",true);
                    }
                }
            }
        }
        if(row.supPhoto){
            var databasephoto=row.supPhoto;
            var photoes=databasephoto.split("|");
            $("#supPhotos").attr("src","/Files/Images/"+photoes[0]);
            $("#index").text("当前第"+1+"张,");
            $("#ids").text(photoes.length);
            var i=0;
            $("#userphoto_box").click(function(){

                i++;
                if(i==photoes.length){
                    i=0;
                }
                $("#supPhotos").attr("src","/Files/Images/"+photoes[i]);
                $("#index").text("当前第"+(i+1)+"张,");
            });
        }else{
            $("#supPhotos").attr("src","<%=request.getContextPath()%>/asset/image/default.jpg");
            $("#index").text("当前第0张,");
            $("#ids").text(0);
            $('#userphoto_box').unbind("click");
        }
    }
}
//查看赋值
function SearchDetail(btn){
    $("#tb").show();
    $("#dlg").show();
    var row=$(btn).parent().data();
    Info(row);
}
//保存
function Saves() {
    var jsonObject = $("#Form").serializeObject();
    jsonObject["moduleType"] = moduleType;
    var supPowers = "";
    var qxs = $(".qx_check:checked");
    if ($("#supClass").val() != "6") {
        if (qxs.length < 1) {
            layer.msg("必须选一项增加能力", {offset: ['30%']});
            $(this).attr("checked", false);
            return false;
        }
        var str = "";
        if (qxs != null && qxs != "") {
            for (var i = 0; i < qxs.length; i++) {
                var val = $(qxs[i]).val();
                str = str + val + "|";
            }
        }
        supPowers = str.substring(0,str.length-1);
    }
    jsonObject["supPowers"] =supPowers
    postURL=editUrl;
    UploadToDatabase(jsonObject);
}
//审核通过
function auditsAction(type,obj){
    //清楚所有选中的复选框
    $(obj).parent().parent().parent().find("input[type=checkbox]").attr("checked", false);
    //选中当前的复选框
    $(obj).parent().parent().find("input[type=checkbox]").attr("checked", true);
    //增加能力复选框验证
    var qxs=$(obj).parent().parent().find("input[type=checkbox]");
    if(qxs.length<1){
        layer.msg("请选择",{offset:['30%'] });
        return false;
    }else if(qxs.length>1){
        $("#score").val("").css("background","#eee").attr("readonly","readonly");
    }else{
        var rowdata=$(qxs[0]).parents("tr").data();
        if(rowdata){
            var point=rowdata.supCredit;
            $("#score").val(point ? point : "0.25").css("background","#fff").removeAttr("readonly");
        }else
            $("#score").val("0.25").css("background","#fff").removeAttr("readonly");
    }
    /**
     * 取出选中的数据
     */
    applyId ="";
    var isNewAdd="";
    var regimentAuditStatuses="";
    var collegeAuditStatuses="";
    var schoolAuditStauses="";
    $('input:checkbox:checked').each(function() {
        var row=$(this).parent().parent().data();
        applyId+=row.id+"|";
        isNewAdd+=row.isNewAdd+"|";
        regimentAuditStatuses+=row.regimentAuditStatus+"|";
        collegeAuditStatuses+=row.collegeAuditStatus+"|";
        schoolAuditStauses+=row.schoolAuditStaus+"|";
    });
    if(applyId==""){
        layer.msg("请选择一行数据");
        return;
    }
    $("#sc_score").show();
    $("#sc_reason").hide();
    $("#score").val();
    layer.confirm('确认此操作吗?!', function(result) {
        layer.closeAll('dialog');
        if (result){
            //验证重复审核
            if (regimentAuditStatuses.indexOf("已通过")>=0||regimentAuditStatuses.indexOf("未通过")>=0||regimentAuditStatuses.indexOf("修改")>=0) {
                layer.msg("您选中的项目中有审核过的，不能重复审核");
            } else {
                // $("#tb2").show();
                // $("#dlg2").show();
                $("#btn_sub").click(function(){
                    var score=  $("#score").val();
                    if(1){
                        $.ajax({
                            url:"/apply/ClassAuditSupplementScore.form",
                            type: "post",
                            data:{applyId:applyId.substring(0,applyId.length-1),Type:type,score:score},
                            dataType: "json",
                            success: function (data) {
                                if(data){
                                    layer.msg(data.msg);
                                    $("#submitAll").attr("checked",false);
                                    $('#dlg2').hide();
                                    $('.popup').slideUp(400);
                                    $('.new').slideUp(300);
                                    select_box(1);
                                    applyId='';
                                }
                            }, error: function () {
                                layer.msg("网络错误");
                                select_box($(".currentPageNum").val());
                                applyId='';
                            }
                        })
                    }else{
                        layer.msg('请输入分数');
                    }
                });
                $("#btn_sub").click();
            }
        }
    })
}
function showpicture(supPhoto){
    $("#tb").show();
    $("#dlg").show();
    $("#user_photo").attr("src","/Files/Images/default.jpg");
    if(supPhoto!=null&&supPhoto!=""){
        var databasephoto=supPhoto;
        var photoes=databasephoto.split("|");
        $("#user_photo").attr("src","/Files/Images/"+photoes[0]);
        $("#index").text("当前第"+1+"张,");
        $("#ids").text(photoes.length);
        var i=0;
        $("#userphoto_box").click(function(){
            i++;
            if(i==photoes.length){
                i=0;
            }
            $("#user_photo").attr("src","/Files/Images/"+photoes[i]);
            $("#index").text("当前第"+(i+1)+"张,");
        });
    }else{
        $("#index").text("当前第0张,");
        $("#ids").text(0);
        $('#userphoto_box').unbind("click");
    }
}
//审核不通过
function auditsAction_no(type,obj){
    //清楚所有选中的复选框
    $(obj).parent().parent().parent().find("input[type=checkbox]").attr("checked", false);
    //选中当前的复选框
    $(obj).parent().parent().find("input[type=checkbox]").attr("checked", true);
    var qxs=$(".checkes:checked");
    applyId = "";
    var regimentAuditStatuses="";
    var collegeAuditStatuses="";
    var schoolAuditStauses="";
    if(qxs.length<1){
        layer.msg("请选择",{offset:['30%'] });
        return false;
    }else if(qxs.length==1){
        $('input:checkbox:checked').each(function () {
            var row = $(this).parent().parent().data();
            applyId = row.id ;
            regimentAuditStatuses=row.regimentAuditStatus;
            collegeAuditStatuses=row.collegeAuditStatus;
            schoolAuditStauses=row.schoolAuditStaus;
        });
        if(applyId==""){
            layer.msg("请选择一行数据");
            return;
        }
        if (regimentAuditStatuses.indexOf('未通过') >= 0 || regimentAuditStatuses.indexOf('已通过') >= 0||regimentAuditStatuses.indexOf('修改') >= 0) {
            layer.msg("您选中的项目已经审核过了，不能重复审核");
            return false;
        }
        $("#dlg2").show();
        $("#sc_score").hide();
        $("#sc_reason").show();
        $("#reason").val("");
        $("#btn_sub").click(function () {
            var reason=$("#reason").val();
            if (!reason || reason == '') {
                layer.msg("审核意见不能为空");
                return;
            }
            layer.confirm('确认此操作吗?!', function (result) {
                if (result) {

                    //验证重复审核
                    $.ajax({
                        url: "/jsons/ClassAuditOneSupplement.form",
                        type: "post",
                        data: {applyId: applyId,reason:reason, Type: type},
                        dataType: "json",
                        success: function (data) {
                            if (data.result) {
                                layer.msg("保存成功");
                                $("#submitAll").attr("checked", false);
                                $("#dlg2").hide();
                                $('.popup').slideUp(400);
                                $('.new').slideUp(300);
                                select_box(1);
                                applyId = '';
                            }
                        }, error: function () {
                            layer.msg("网络错误");
                            $("#submitAll").attr("checked", false);
                            $("#dlg2").hide();
                            $('.popup').slideUp(400);
                            $('.new').slideUp(300);
                            select_box(1);
                            applyId = '';
                        }
                    })
                }


            })
        })
    }else {

        $('input:checkbox:checked').each(function () {
            var row = $(this).parent().parent().data();
            applyId += row.id + "|";
            regimentAuditStatuses+=row.regimentAuditStatus+"|";
            collegeAuditStatuses+=row.collegeAuditStatus+"|";
            schoolAuditStauses+=row.schoolAuditStaus+"|";
        });
        if (applyId == "") {
            layer.msg("请选择一行数据");
            return;
        }

        layer.confirm('确认此操作吗?!', function (result) {
            if (result) {
                //验证重复审核

                if (regimentAuditStatuses.indexOf("已通过")>=0||regimentAuditStatuses.indexOf("未通过")>=0||regimentAuditStatuses.indexOf("修改")>=0) {
                    layer.msg("您选中的项目中有审核过的，不能重复审核");
                } else {
                    $.ajax({
                        url: "/apply/ClassAuditSupplement.form",
                        type: "post",
                        data: {applyId: applyId.substring(0, applyId.length - 1), Type: type},
                        dataType: "json",
                        success: function (data) {
                            if (data) {
                                layer.msg(data.msg);
                                $("#submitAll").attr("checked", false);
                                select_box($(".currentPageNum").val());
                                applyId = '';
                            }
                        }, error: function () {
                            layer.msg("网络错误");
                            select_box(1);
                            applyId = '';
                        }
                    })
                }

            }
        })
    }
}
//关闭按钮
function close_new(){
    $('#dlg2').hide();
    $('.popup').slideUp(400);
    $('.new').slideUp(300);
}
//综合查询
function select_box(page) {
    var jsonObject = $("#Form1").serializeObject();
    jsonObject["rows"] = $("#rows").val() ;
    if(orderByName!=null) jsonObject["orderByName"]=orderByName;
    if(sequence!=null) jsonObject["sequence"]=sequence;
    if(Math.ceil(totalNum/$("#rows").val())<page){
        page=Math.ceil(totalNum/$("#rows").val());
    }
    if(page<=0){
        page=1;
    }
    jsonObject["page"] = page;
    $(".currentPageNum").val(page);
    jsonPara=jsonObject;
    $('.searchContent').slideUp();
    reload();
}
//清空
function clear_search(){
    //清空表单
    document.getElementById("Form1").reset();
}
//上一页
function turn_left(){
    var newpage1= parseInt($(".currentPageNum").val());
    if(newpage1<=1){
        newpage1=1;
    }else{
        newpage1=newpage1-1;
    }
    $(".currentPageNum").val(newpage1);
    var pagNum = $(".currentPageNum").val();

    select_box(newpage1);
}
//下一页
function turn_right(){
    var newpage2= parseInt($(".currentPageNum").val());

    if(newpage2>=Math.ceil(totalNum/rows)){
        newpage2=Math.ceil(totalNum/rows);
    }else{
        newpage2=newpage2+1;
    }
    $(".currentPageNum").val(newpage2);
    var pagNum = $(".currentPageNum").val();

    select_box(newpage2);

}
function  delete_zy(){
    var row;
    $('input:checkbox:checked').each(function () {
        row = $(this).parent().parent().data();
    });
    if(!row) {
        layer.alert("请先选择一条数据");
        return
    }else{
        $.ajax({
            url:"<%=request.getContextPath()%>/jsons/delete_review.form",
            dataType:"json",
            data:{id:row.id},
            success:function(data){
                if(data.result){
                    disLoad();//必须有
                    layer.msg("删除成功");
                    reload();//重新加载数据
                }else {
                    layer.msg("删除失败，请重新登录或联系管理员:"+data.errormessage);
                }
            }
        });
    }
}
//加载待审核、未通过、已通过数据
function reloadsearch(val){
    jsonPara={rows:$("#rows").val(),page:1,regimentAuditStatus:val}
    reload();
}