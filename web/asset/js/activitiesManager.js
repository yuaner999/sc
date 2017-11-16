/**
 * Created by sw on 2016/9/5.
 */
$(function(){
    //选了不限 就不可以选择其他 可多选
    $(".filter_ckeck").click(function(){
        var qxs=$(".filter_ckeck:checked");
        if($(this).hasClass("none")){
            if($(this).attr("checked")){
                $(this).attr("checked",true);
                $(".coll").attr("checked",false);
            }
        }else{
            if($(this).attr("checked")){
                $(this).attr("checked",true);
                $(".none").attr("checked",false);
            }
        }
        if(qxs.length<1){
            ShowMsg("必须选一项活动限制条件的类型");

            $(this).attr("checked",false);
            return false;
        }
    });

    //至少选择一个
    $(".qx_check").click(function(){
        var qxs=$(".qx_check:checked");
        if(qxs.length>3){
            ShowMsg("最多只能选3项增加能力");
            $(this).attr("checked",false);
        }
        if(qxs.length<1){
            ShowMsg("必须选一项增加能力");
            $(this).attr("checked",false);
            return false;
        }
    });

    //点击隐藏对应的下拉列
    $("#ax1").change(function () {
        $("#classCollege").combobox("disable");
        $("#classYear").combobox("disable");
        $("#classCollege").combobox('clear');
        $("#classYear").combobox('clear');
    })
    $("#ax2").change(function () {
        if($(this).attr('checked')){
            $("#classYear").combobox("enable");
            $("#classCollege").combobox("disable");
            $("#classCollege").combobox('clear');
        }if($(this).attr('checked')&&$("#ax3").attr("checked")){
            $("#classYear").combobox("enable");
            $("#classCollege").combobox("enable");
            $("#classYear").combobox('clear');
        }else if(!$(this).attr('checked')){
            $("#classYear").combobox("disable");
            $("#classYear").combobox('clear');
        }
    })
    $("#ax3").change(function () {
        if($(this).attr('checked')){
            $("#classYear").combobox("disable");
            $("#classCollege").combobox("enable");
            $("#classYear").combobox('clear');
        }if($(this).attr('checked')&&$("#ax2").attr("checked")){
            $("#classYear").combobox("enable");
            $("#classCollege").combobox("enable");
            $("#classCollege").combobox('clear');
        }else if(!$(this).attr('checked')){
            $("#classCollege").combobox("disable");
            $("#classCollege").combobox('clear');
        }
    })
})
/*
 * 重写save
 *
 * */
function Saves(){
    //活动限制与过滤信息验证
    var fxs=$(".filter_ckeck:checked");
    var classYear=$("#classYear").combobox("getValue");
    var classCollege=$("#classCollege").combobox("getValue");
    if(fxs.length<1){
        ShowMsg("请按照要求填写活动限制和过滤信息");
        $(this).attr("checked",false);
        return false;
    }
    if($("#ax2").attr('checked')){
        if(classYear==null||classYear==""){
            ShowMsg("请按照要求填写活动限制和过滤信息");
            return false;
        }
    }else{
        if(classYear.length>0){
            ShowMsg("请按照要求填写活动限制和过滤信息");
            return false;
        }
    }
    if($("#ax3").attr('checked')){
        if(classCollege==null||classCollege==""){
            ShowMsg("请按照要求填写活动限制和过滤信息");
            return false;
        }
    }else{
        if(classCollege.length>0){
            ShowMsg("请按照要求填写活动限制和过滤信息");
            return false;
        }
    }
    //增加能力复选框验证
    var qxs=$(".qx_check:checked");
    if(qxs.length<1){
        ShowMsg("必须选一项增加能力");
        $(this).attr("checked",false);
        return false;
    }
    //活动时间进行验证
    var Sdate=$("#activitySdate").datebox("getValue");
    var Edate=$("#activityEdate").datebox("getValue");
    if(Sdate>Edate){
        ShowMsg("请按要求填写活动开始时间，结束时间");
        return false;
    }

    if($("#Form").form('validate')){
        var jsonObject = $("#Form").serializeObject();
        jsonObject["moduleType"] = moduleType;
        if(editorName &&editorName!="null"){
            editor.sync();
            jsonObject[editorName] = $("#"+editorName).val();
        }
        //手动拼接 增加能力 到数据库
        var qxs=$(".qx_check:checked");
        var str="";
        if(qxs!=null&&qxs!=""){
            for(var i=0;i<qxs.length;i++){
                var val=$(qxs[i]).val();
                str=str+val+"|";
            }
            jsonObject["activityPowers"]=null;
            jsonObject["activityPowers"]=str.substring(0,str.length-1);
        }
        //手动拼接 活动限制 到数据库
        var axs=$(".filter_ckeck:checked");
        var str1="";
        if(axs!=null&&axs!=""){
            for(var i=0;i<axs.length;i++){
                var val=$(axs[i]).val();
                str1=str1+val+"|";
            }
            jsonObject["activityFilterType"]=null;
            jsonObject["activityFilterType"]=str1.substring(0,str1.length-1);
        }
        //过滤条件 到数据库
         classYear= $('#classYear').combobox("getValue");
         classCollege= $('#classCollege').combobox("getValue");
        if(classYear!=''&&classYear!=null&&classCollege!=''&&classCollege!=null){
            jsonObject["activityFilter"] =null;
            jsonObject["activityFilter"] =classYear+"|"+classCollege;
        }
        if(classCollege!=''&&classCollege!=null&&classYear==''||classYear==null){
            jsonObject["activityFilter"] =null;
            jsonObject["activityFilter"] =""+"|"+classCollege;
        }
        if(classCollege==''||classCollege==null&&classYear!=''&&classYear!=null){
            jsonObject["activityFilter"] =null;
            jsonObject["activityFilter"] =classYear+"|"+"";
        }

        load();
        //有图片上传
        if($("#"+imageUpload).val()!=null&&$("#"+imageUpload).val()!=""){
            ajaxFileUpload("/ImageUpload/No_Intercept_Upload.form",imageUpload,jsonObject,1);
        }else {
            UploadToDatabase(jsonObject);
        }

    }else {
        ShowMsg("请按照要求填写");
    }
}
/*
 * 重写edits
 *
 * */
function Edits(){
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
    $("#user_photo").attr("src","/Files/Images/"+row.activityImg);


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


        //手动取出
        var str=row.activityFilterType;
        if(str!=null&&str!=""){
            var activityFilterType=str.split("|");
            for(var i=0;i<activityFilterType.length;i++){
                if(activityFilterType[i]=='不限'){
                    $("#ax1").attr("checked",true);
                    $("#classCollege").combobox("disable");
                    $("#classYear").combobox("disable");
                }
                if(activityFilterType[i]=='年级'){
                    $("#ax2").attr("checked",true);
                }
                if(activityFilterType[i]=='学院'){
                    $("#ax3").attr("checked",true);
                }
            }
        }

        var str1=row.activityFilter;
        if(str1!=null&&str1!=""){
            var activityFilter=str1.split("|");
            if(activityFilter[0]!=null&&activityFilter[0]!=''){
                $('#classYear').combobox('setValues',activityFilter[0]);
                $("#classYear").combobox("enable");
            }
            if(activityFilter[1]!=null&&activityFilter[1]!=''){
                $('#classCollege').combobox('setValues',activityFilter[1]);
                $("#classCollege").combobox("enable");
            }
        }

        var str2=row.activityPowers;
        if(str2!=null&&str2!=""){
            var activityPowers=str2.split("|");
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

        $("#ax1").change(function () {
            $("#classCollege").combobox('clear');
            $("#classYear").combobox('clear');
        })
        $("#ax2").change(function () {
            if(!$(this).attr('checked')){
                $("#classYear").combobox('clear');
            }else if($(this).attr('checked')&&!$("#ax3").attr('checked')){
                $("#classCollege").combobox('clear');
            }
        })
        $("#ax3").change(function () {
            if(!$(this).attr('checked')){
                $("#classCollege").combobox('clear');
            }else if($(this).attr('checked')&&!$("#ax2").attr('checked')){
                $("#classYear").combobox('clear');
            }
        })

    }else {
        ShowMsg("请选中一条数据");
    }
}

/**
 * 刷新当前页
 */
function reloadThis(){
    $("#dg").datagrid("reload");
}
function Add_befores(){
    $("#user_photo").attr("src","/asset/image/default.jpg");
    Add();
}