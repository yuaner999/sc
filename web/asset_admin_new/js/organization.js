/**
 * Created by wangao on 2016/10/28.
 */
$(function(){
   //对弹窗的下拉框的进行操作
    $(".modelSelect>select>option").hover(function(){
        $(this).css('background-color', '#ffffff');
        $(this).css('color','#190ffe');
    },function(){
        $(this).css('background-color', '#190ffe');
        $(this).css('color','#ffffff');
    });
});
