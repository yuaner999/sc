function  loadSelectInfo(data,str1,str2) {
    //console.log(data);
    var $divId = $("#" + str2);
    $divId.html("");
    for (var i = 0; i < data.rows.length; i++) {
        var str = '<input class="checkbox" onclick="showName(this)" id="' + str1 + i + '" type="checkbox" name="' + str1 + '" value="' + data.rows[i] + '">' +
            '<label for="' + str1 + i + '">' + data.rows[i] + '</label><br/>';
        str = str.replace(/null/gi, "");
        //添加到div下
        $divId.append(str);
    }
}
function  loadSelectInfo2(data,str1,str2) {
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
        //1.年级
        case "stuGradeName":
            name = data.rows[i].stuGradeName;
            return name;
            break;
        //2.学院
        case "stuCollageName":
            name = data.rows[i].stuCollageName;
            return name;
            break;
        //3.班级
        case "stuClassName":
            name = data.rows[i].stuClassName;
            return name;
            break;
        default:
            return null;
    }
}
/**
 * 清空表单
 */
function formreset1(){
    //清除所有的下拉复选的已选项
    $("input:checked").attr("checked",false);
    $("#search_fm").form("clear");
}
function  pretreatment(str1,str2){
    $(str1).combo({//第一个属性，可修改 第二个属性，可多选
        editable: false,
        multiple : true
    });
    $(str2).appendTo($(str1).combo('panel'));//向面板最后添加
}
function  getInfoByAjax(str1,str2){
    $.ajax({
        url:'<%=request.getContextPath()%>/jsons/load'+str1+'.form',
        dataType:"json",
        success:function(data){
            loadSelectInfo(data,str1,str2);
        }
    });
}
function  assignSelectInfo(array,str1,str2){
//        console.log(array);
    var $divId = $("#"+str2);
    $divId.html("");
    for (var i = 0; i < array.length; i++) {
//            var name  = getName(data,str1,i);
        var str = '<input class="checkbox" onclick="showName(this)" id="' + str1 + i + '" type="checkbox" name="' + str1 + '" value="' +array[i] + '">' +
            '<label for="' + str1 + i + '">' + array[i] + '</label><br/>';
        str = str.replace(/null/gi, "");
        //添加到div下
        $divId.append(str);
    }
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

function  showDiv(){

    $(".datagrid-view").show();
    $(".datagrid .datagrid-pager").show();

}
function searchAction1(){
    var json=$("#search_fm").serializeObject();
    json["rows"]=rows;
    json["page"]=page;
    //            console.log(json);
    $('#dg').datagrid('options').url='/jsons/loadactivities.form';
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
function btnExcel(){
    document.getElementById("search_fm").submit();
}
//        //判断平均值的大小顺序是否正确  及输入是否正确
//        var reg1 = new RegExp("^\\d+(\\.\\d+)?$","gi");
//        var reg2 = new RegExp("^\\d+(\\.\\d+)?$","gi");
//        if ( reg1.test(json.highValue ) || reg2.test(json.lowValue ) ) {
//           alert("请在平均分栏中输入正确的数字");
//            return;
//        }
//        //把数字的字符串转为数字
//        var high = parseFloat(json.highValue.trim());
//        var low = parseFloat(json.lowValue.trim());
//        //判断是否处于1-5之间
//        if(high<1 || high >5){
//            alert("请在平均分栏中输入正确的范围(1~5)")
//            return;
//        }
//        if(low<1 || low >5){
//            alert("请在平均分栏中输入正确的范围(1~5)")
//            return;
//        }
//        if(high<low){
//            alert("请在平均分栏中按正确的大小输入");
//            return;
//        }
//        console.log(json.highValue);
//        console.log(json.lowValue);
//        json["rows"]=rows;
//        json["page"]=page;
//            console.log(json);
//        $('#dg').datagrid('options').url='/jsons/loadactivities.form';
////        //$('#dg').datagrid('reload',json);
//        $("#dg").datagrid("load",json);
//        $("#search_condition").removeClass("opened");
//        $("#search_condition").slideUp(300);

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