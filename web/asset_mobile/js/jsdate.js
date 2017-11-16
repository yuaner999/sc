//格式化日期把毫秒值转成字符串
function dateformat(time,formateStr) { //author: meizz
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

function dateformat_hhmm(d){
    return dateformat(d,"HH:mm")
}
function dateformat_hhmmss(d){
    return dateformat(d,"HH:mm:ss")
}
function dateformat_yyyyMMdd(d) {
    return dateformat(d,"yyyy-MM-dd")
}
function dateformat_yyyyMMddhhmm(d){
    return dateformat(d,"yyyy-MM-dd HH:mm")
}
function dateformat_yyyyMMddhhmmss(d){
    return dateformat(d,"yyyy-MM-dd HH:mm:ss")
}