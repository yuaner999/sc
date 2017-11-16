/**
 * Created by sw on 2016/9/18.
 */
var imageUpload = "studentPhotos";
var StudentID=null;
var applyID="";
var newapplyID="";
var studentPhotoval;
var NewPhoto;
var collegename='';
$(function() {
    $(".grade_list").show();
    $(".change_perMsg").click(function(){
        $('.window_Greybg').height($(document).height());
        $('.window_Greybg').css('background-color', '#a1a1a1').slideDown(200);
        $('.window_changeMsg').slideDown(400);
    })
    $(".change_pwd").click(function(){
        $('.window_Greybg').height($(document).height());
        $('.window_Greybg').css('background-color', '#a1a1a1').slideDown(200);
        $('.window_changePwd').slideDown(400);
    })
    $(".change_picture").click(function(){
        $('.window_Greybg').height($(document).height());
        $('.window_Greybg').css('background-color', '#a1a1a1').slideDown(200);
        $('.window_changePicture').slideDown(400);
    })
    $(".loadGrade").click(function(){
        $('.window_Greybg').height($(document).height());
        $('.window_Greybg').css('background-color', '#a1a1a1').slideDown(200);
        $('.window_selectMsg').slideDown(400);
        window.location.href="printPriviewV2.form";
    })
    $("#buttones1").click(function(){
        $(".qx_check").attr("checked",false);
        $('.window_Greybg').hide();
        $('.window_selectMsg').hide();
    });
    $("#updataPhoneNum1").click(function(){
        $('.window_Greybg').hide();
        $('.window_changeMsg').hide();
    });
    $("#updataPwd1").click(function(){
        $('.window_Greybg').hide();
        $('.new_window').hide();
    });
    $("#updataPhoto1").click(function(){
        $('.window_Greybg').hide();
        $('.new_window').hide();
    });
    $(".title1 img").click(function () {
        $(this).parent().parent().hide(200);
        $('.window_Greybg').slideUp(200);
        $(document.body).css({
            "overflow-x":"auto",
            "overflow-y":"auto"
        });
    });

    //判断个人中心活动的审核状态，修改和未通过的要在标题下面加波浪线，并可以弹出提示信息
    $(".grade_list_item_table").on("hover","td span",function () {
        var texclass=$(this).parent().children("input").eq(0).val();
        if(!texclass || texclass=="undefined") texclass="暂无原因";
        if($(this).hasClass("error")){
            layer.tips(texclass,$(this), {
                tips: [3, '#5c85ee'],
                time: 3000
            });
        }
    });

    //加载个人信息
    infor();
    //发送ajax请求加载所有有效活动信息
    selectInfor();
    //初始化加载申请打印过的活动
  //  loadPrintActivity();
    /**
     * 修改密码
     */
    //$("#updataPwd").click(function(){
    //    var oldpwd= $.trim($("#old_pwd").val());
    //    var pwd= $.trim($("#pwd").val());
    //    var repwd= $.trim($("#repwd").val());
    //    if(!(oldpwd && pwd && repwd)){
    //        layer.msg("请检查输入是否完整！",{offset:['70%'] });
    //        return false;
    //    }
    //    if(pwd!=repwd){
    //        layer.msg("两次密码输入不一致",{offset:['70%'] });
    //        return false;
    //    }
    //    $.ajax({
    //        url:"/Login/EditPassword.form",
    //        data:{oldpassword: $.md5(oldpwd),newpassword: $.md5(pwd)},
    //        type:"post",
    //        success:function(data){
    //            // console.log(data);
    //            if(data=="-1"){
    //                layer.msg("原密码或新密码有误，请稍后重试",{offset:['70%'] });
    //                $('.window_Greybg').hide();
    //                $('.window_changePwd').hide();
    //                return;
    //            }
    //            //这里是学生登入 所以返回的type改为7
    //            if(data=="7"){
    //                layer.alert("修改成功！请重新登陆",{offset:['70%'] });
    //                $('.window_Greybg').hide();
    //                $('.window_changePwd').hide();
    //                window.setTimeout("window.location='login.form'",2000);
    //                return;
    //            }
    //            layer.msg(data,{offset:['30%'] });
    //        },
    //        error:function(){
    //            layer.msg("服务器连接失败，请稍后再试",{offset:['70%'] })
    //            $('.window_Greybg').hide();
    //            $('.window_changePwd').hide();
    //        }
    //    });
    //});
    ///**
    // * 修改头像
    // */
    //$("#updataPhoto").click(function(){
    //    if(!imageUpload){
    //        layer.msg("请选择要修改的头像",{offset:['70%'] });
    //        return false;
    //    }
    //    $.ajaxFileUpload({
    //        url: "/ImageUpload/No_Intercept_Upload.form", //用于文件上传的服务器端请求地址
    //        secureuri: false, //一般设置为false
    //        fileElementId: imageUpload, //文件上传空间的id属性
    //        dataType: 'String', //返回值类型 一般设置为String
    //        success: function (data, status)  //服务器成功响应处理函数
    //        {
    //            if(data!=""||data!=null){
    //                var data = eval("(" + data + ")");
    //                if(typeof(data.error) != 'undefined') {
    //                    if (data.error == 0) {
    //                        var NewPhoto = data.filename;
    //                        if(NewPhoto!=null){
    //                            $.ajax({
    //                                url:"/jsons/EditStudentPhoto.form",
    //                                type:"post",
    //                                data:{studentPhoto:NewPhoto,studentID:StudentID},
    //                                dataType:"json",
    //                                success:function(data){
    //                                    if(data.result){
    //                                        layer.msg("保存成功请尝试重新登录",{offset:['70%'] });
    //                                        $('.window_Greybg').hide();
    //                                        $('.window_changePicture').hide();
    //                                        window.setTimeout("window.location='oneself.form'",1000);
    //                                        return;
    //                                    }else {
    //                                        layer.msg("保存中出现错误",{offset:['70%'] });
    //                                        $('.window_Greybg').hide();
    //                                        $('.window_changePicture').hide();
    //                                    }
    //                                },
    //                                error: function () {
    //                                    layer.msg("保存中出现错误",{offset:['70%'] });
    //                                    $('.window_Greybg').hide();
    //                                    $('.window_changePicture').hide();
    //                                }
    //                            });
    //                        }
    //                    }
    //                }
    //                layer.msg("上传文件出错："+data.message,{offset:['70%'] });
    //                $('.window_Greybg').hide();
    //                $('.window_changePicture').hide();
    //            }
    //        },
    //        error: function (data, status, e)//服务器响应失败处理函数
    //        {
    //            layer.msg("上传文件出错："+data.message,{offset:['70%'] });
    //            $('.window_Greybg').hide();
    //            $('.window_changePicture').hide();
    //        }
    //    });
    //});
    //修改密码输入检测
    //$(":password").blur(function(){
    //    var str= $.trim($(this).val());
    //    //if(!str){
    //    //    layer.msg("所有密码为必填项",{offset:['70%'] });
    //    //    return;
    //    //}
    //    if(str.length<6 || str.length>18){
    //        layer.msg("密码长度为6-18个字符！",{offset:['70%'] });
    //        return false;
    //    }
    //});
    /**
     * 修改手机号
     */
    //$("#updataPhoneNum").click(function(){
    //    var phone=$.trim($("#studentPhone").val());
    //    if(!(/^1[34578]\d{9}$/.test(phone))){
    //        layer.msg("手机号码有误，请重填");
    //        return false;
    //    }else {
    //        $.ajax({
    //            url:"/jsons/EditStudentPhone.form?studentPhone="+phone,
    //            type:"post",
    //            success:function(data){
    //                if(data=="-1"){
    //                    layer.msg("修改有误，请稍后重试",{offset:['70%'] });
    //                    $('.window_Greybg').hide();
    //                    $('.window_changeMsg').hide();
    //                   // window.setTimeout("window.location='oneself.form'",1000);
    //                    return;
    //                }
    //                if(data=="0"){
    //                    layer.msg("修改成功，请尝试刷新",{offset:['70%'] });
    //                    $('.window_Greybg').hide();
    //                    $('.window_changeMsg').hide();
    //                    window.setTimeout("window.location='oneself.form'",1000);
    //                }
    //            }
    //        });
    //    }
    //});
    //修改个人信息
    $("#updataPwd").click(function(){
        var phone=$.trim($("#studentPhone").val());
        var oldpwd= $.trim($("#old_pwd").val());
        var pwd= $.trim($("#pwd").val());
        var repwd= $.trim($("#repwd").val());
        if(oldpwd  && (pwd.length < 6 || pwd.length > 18)){
            layer.msg("请输入6-18位新密码",{offset:['70%'] });
            return false;
        }
        if(oldpwd && pwd && '' == repwd){
            layer.msg("请再次输入新密码",{offset:['70%'] });
            return false;
        }
        if(oldpwd||pwd||repwd){
            if(pwd!=repwd){
                layer.msg("两次密码输入不一致",{offset:['70%'] });
                return false;
            }
            if(pwd.length<6||pwd.length>18)  {layer.msg("密码长度应为6-18位",{offset:['70%'] });return false;}
            if(oldpwd.length<6||oldpwd.length>18)  {layer.msg("密码长度应为6-18位",{offset:['70%'] });return false;}
            if(repwd.length<6||repwd.length>18)  {layer.msg("密码长度应为6-18位",{offset:['70%'] });return false;}
        }
        if(oldpwd) oldpwd=$.md5(oldpwd);
        if(repwd) repwd=$.md5(repwd);
        //if(!(oldpwd && pwd && repwd)){
        //    layer.msg("请检查输入是否完整！",{offset:['70%'] });
        //    return false;
        //}

        if(phone&&!(/^1[34578]\d{9}$/.test(phone))){
            layer.msg("手机号码有误，请重填",{offset:['70%'] });
            return false;
        }
        //if(!$("#"+imageUpload).val()){
        //    layer.msg("请选择要修改的头像",{offset:['70%'] });
        //    return false;
        //}
        if(!$("#"+imageUpload).val()&&studentPhotoval==null){
            $.ajax({
                url:"/jsons/EditStudentInfo.form",
                type:"post",
                data:{studentPhoto:'',studentID:StudentID,phone:phone,oldpwd:oldpwd,repwd:repwd},
                dataType:"text",
                success:function(data){
                    if(data=='1'){
                        layer.msg("修改成功请重新登录",{offset:['70%'] });
                        $('.window_Greybg').hide();
                        $('.new_window').hide();
                        window.setTimeout("window.location='oneself.form'",1000);
                        return;
                    }else {
                        console.log(data.length);
                        console.log(data);
                        if(data.length>1){
                            layer.msg(data,{offset:['70%'] });
                            if("原密码输入错误" == data){
                                return false;
                            }
                        }else{
                            layer.msg("保存中出现错误",{offset:['70%'] });
                        }
                        /*$('.window_Greybg').hide();
                        $('.new_window').hide();*/
                    }
                },
                error: function () {
                    layer.msg("服务器连接失败",{offset:['70%'] });
                    $('.window_Greybg').hide();
                    $('.new_window').hide();
                }
            });
        } else{
            if($("#studentPhoto").val()==studentPhotoval&&!$("#"+imageUpload).val()){
                NewPhoto=studentPhotoval;
                $.ajax({
                    url:"/jsons/EditStudentInfo.form",
                    type:"post",
                    data:{studentPhoto:NewPhoto,studentID:StudentID,phone:phone,oldpwd:oldpwd,repwd:repwd},
                    dataType:"text",
                    success:function(data){
                        console.log(data.length);
                        console.log(data);
                        if(data=='1'){
                            layer.msg("修改成功请重新登录",{offset:['70%'] });
                            $('.window_Greybg').hide();
                            $('.new_window').hide();
                            window.setTimeout("window.location='oneself.form'",1000);
                            return;
                        }else {
                            if(data.length>1){
                                layer.msg(data,{offset:['70%'] });
                                return false;
                            }else{
                                layer.msg("保存中出现错误",{offset:['70%'] });
                            }
                            $('.window_Greybg').hide();
                            $('.new_window').hide();
                        }
                    },
                    error: function () {
                        layer.msg("保存中出现错误",{offset:['70%'] });
                        $('.window_Greybg').hide();
                        $('.new_window').hide();
                    }
                });
            } else {
                $.ajaxFileUpload({
                    url: "/ImageUpload/No_Intercept_Upload.form", //用于文件上传的服务器端请求地址
                    secureuri: false, //一般设置为false
                    fileElementId: imageUpload, //文件上传空间的id属性
                    dataType: 'text', //返回值类型 一般设置为String
                    success: function (data, status)  //服务器成功响应处理函数
                    {
                        console.log(data);
                        if (data != "" || data != null) {
                            var data = eval("(" + data + ")");
                            if (typeof(data.error) != 'undefined') {
                                if (data.error == 0) {
                                    NewPhoto = data.filename;
                                    if (NewPhoto != null) {
                                        $.ajax({
                                            url: "/jsons/EditStudentInfo.form",
                                            type: "post",
                                            data: {
                                                studentPhoto: NewPhoto,
                                                studentID: StudentID,
                                                phone: phone,
                                                oldpwd: oldpwd,
                                                repwd: repwd
                                            },
                                            dataType: "text",
                                            success: function (data) {
                                                console.log(data.length);
                                                console.log(data);
                                                if(data=='1'){
                                                    layer.msg("修改成功请重新登录",{offset:['70%'] });
                                                    $('.window_Greybg').hide();
                                                    $('.new_window').hide();
                                                    window.setTimeout("window.location='oneself.form'",1000);
                                                    return;
                                                }else {
                                                    if(data.length>1){
                                                        layer.msg(data,{offset:['70%'] });
                                                    }else{
                                                        layer.msg("保存中出现错误",{offset:['70%'] });
                                                    }
                                                    $('.window_Greybg').hide();
                                                    $('.new_window').hide();
                                                }
                                            },
                                            error: function () {
                                                layer.msg("保存中出现错误", {offset: ['70%']});
                                                $('.window_Greybg').hide();
                                                $('.new_window').hide();
                                            }
                                        });
                                    }
                                }
                            }
                        } else {
                            layer.msg("上传文件出错：" + data.message, {offset: ['70%']});
                            $('.window_Greybg').hide();
                            $('.new_window').hide();
                        }
                    },
                    error: function (data, status, e)//服务器响应失败处理函数
                    {
                        layer.msg("上传文件出错：" + data.message, {offset: ['70%']});
                        $('.window_Greybg').hide();
                        $('.new_window').hide();
                    }
                });
            }
        }
    });
    /***
     *
      * @returns {boolean}
     * @constructor
     */
    function SavePrint(){
        /**
         * 取出选中的数据
         */
        $('input:checkbox:checked').each(function() {
            var row=$(this).parent().parent().parent().data();
            applyID+=row.applyId+"|";
        });
        newapplyID=applyID.substring(0,applyID.length-1);
        //console.log(newapplyID);
        /**
         * 重新加载雷达图 修改数据库中数据
         */
        if(newapplyID!=null&&newapplyID!=""){
            $.ajax({
                url:"/printTranscript/countPoint.form?applyid="+newapplyID,
                type:"post",
                dataType:"json",
                success:function(data){
                    if(data!=null&&data!=""){
                        // 异步加载数据
                        $.ajax({
                            type: "post",
                            async: false,
                            url:"/char/loadSixElementPoint.form" ,
                            dataType: "json",
                            success: function (data) {
                                //因为applyID是全局变量为了不影响上面赋值 这里清空
                                applyID="";
                                // 获得拼穿值
                                var years=generYears(data);
                                var servies=gennerData(data);
                                // 给option对应地方赋值
                                option.legend.data=eval(years);
                                option.series=eval(servies);
                                //先清空之前的数据
                                myChart.clear();
                                // 使用刚指定的配置项和数据显示图表。
                                myChart.setOption(option);
                                layer.msg("图表更新成功!",{offset:['30%'] });
                                $('.window_Greybg').hide();
                                $('.window_selectMsg').hide();
                            },
                            error: function () {
                                layer.msg("图表更新失败!",{offset:['30%'] });
                                $('.window_Greybg').hide();
                                $('.window_selectMsg').hide();
                            }
                        });
                    }
                },
                error: function () {
                    layer.msg("发送更新请求失败",{offset:['30%'] });
                    $('.window_Greybg').hide();
                    $('.window_selectMsg').hide();
                }
            });
        }else{
            layer.msg("您还没有选择活动!",{offset:['30%'] });
            return false;
        }
}

    /**
     * 点击申请打印成绩单
     */
    $("#PrintPoint").click(function (){
        if(newapplyID!=null&&newapplyID!=""){
            $.ajax({
                type: "post",
                async: false,
                url:"/printTranscript/setPrint.form?applyid="+newapplyID,
                dataType: "json",
                success: function (data) {
                    if(data.result){
                        layer.msg("发送打印请求成功!",{offset:['30%'] });
                    }else {
                        layer.msg("发送打印请求失败!",{offset:['30%'] });
                    }
                },
                error: function () {
                    layer.msg("发送打印请求失败!",{offset:['30%'] });
                }
            });
        }else{
            layer.msg("您还没有选择活动!",{offset:['30%'] });
        }
    });
});
/**
 * 有效活动
 */
function selectInfor(){
    var header='<tr class="table_items">'+
        '<td style="width:130px;">时间</td>'+
        '<td style="width:auto;">名称</td>'+
        '<td style="width:75px;">级别</td>'+
        '<td style="width:75px;" class="activityCredit">学分</td>'+
        '<td style="width:auto;">奖项及备注</td>'+
        '<td style="width:90px;">选择</td>'+
    '</tr>';
    var header1='<tr class="table_items">'+
        '<td style="width:130px;">时间</td>'+
        '<td style="width:auto;">名称</td>'+
        '<td style="width:75px;">级别</td>'+
        '<td style="width:75px;" class="activityCredit">学分</td>'+
        '<td style="width:90px;">时长</td>'+
        '<td style="width:auto;">奖项及备注</td>'+
        '<td style="width:90px;">选择</td>'+
    '</tr>';
    $("#aClass").html("");
    $("#bClass").html("");
    $("#cClass").html("");
    $("#dClass").html("");
    $("#eClass").html("");
    $("#fClass").html("");
    $("#aClass").append(header);
    $("#bClass").append(header);
    $("#cClass").append(header);
    $("#dClass").append(header1);
    $("#eClass").append(header);
    $("#fClass").append(header);
    $.ajax({
        url:"/jsons/laodStudentActivity.form",
        type:"post",
        dataType:"json",
        success:function(data) {
            if(data!=null && data.rows!=null && data.rows.length>0){
                var zhutiguanData=[];       //存放主题团日活动的数组
                for(var i=0;i<data.rows.length;i++){
                    var row = data.rows[i];
                    if(row.supType=='主题团日'){        //如果该条记录是主题团日活动，则添加到主题团日活动的数组里，并结束此轮循环
                        row.theme="true";
                        zhutiguanData.push(row);
                        continue;
                    }
                    //根据活动的分类，来分别在表格中显示不同的内容
                    var act_class=row.activityClass;
                    if(act_class=="3"){
                        if(row.supType=="非活动类"){
                            row.activityAward=row.scienceClass;
                            row.activityLevle="--";
                        }
                    }else if(act_class=="5"){
                        if(row.supType=="非活动类" || row.supType=="学生干部任职"){
                            var lvl='';
                            if(row.workClass=="学校组织")
                                lvl="校级";
                            else if(row.workClass=="学院组织" || row.workClass=="社团")
                                lvl="院级";
                            else
                                lvl="班级";
                            row.activityLevle=(lvl?lvl:"--");
                            row.activityAward=(row.orgname ? row.orgname : "学生干部任职");
                        }
                    }else if(act_class=="6"){
                        row.activityAward=row.activityLevle;
                        row.activityLevle="--";
                    }
                    var activityLevle='';
                    switch (row.activityLevle) {
                        case ("0"):activityLevle = "国际级";break;
                        case ("1"):activityLevle = "国家级";break;
                        case ("2"):activityLevle = "省级";break;
                        case ("3"):activityLevle = "市级";break;
                        case ("4"):activityLevle = "校级";break;
                        case ("5"):activityLevle = "院级";break;
                        case ("6"):activityLevle = "团支部级";break;
                        default:activityLevle =row.activityLevle;break;
                    }
                    var str="";
                    var one='<tr>'+
                        '<td style="width:130px;">'+row.applyDate.substring(0,10)+'</td>'+
                        '<td style="width:auto;"><span>'+(row.activityTitle?row.activityTitle:(row.shipName?row.shipName:row.workName))+'</span></td>'+
                        '<td style="width:75px;">'+activityLevle+'</td>'+
                        '<td style="width:75px;" class="activityCredit">'+(row.activityCredit?row.activityCredit:"") + '</td>'+
                        '<td style="width:auto;">'+(row.activityAward?row.activityAward:(row.shipType?row.shipType:""))+'</td>'+
                        '<td style="width:90px;">'+
                        '<input  class="selected_checkbox" onclick="validatepower(this,\''+row.applyId+'\')" type="checkbox" style="width: 20px;height: 18px; position: relative; top: 6px;" />&nbsp;|'+
                        '<a href="javascript:void(0)"  onclick="DeleteApply(\''+row.applyId+'\')"><img class="smdele" src="../../asset_font_new/img/del_ico.png" alt="删除" title="删除"></a>'+
                        '</td>'+
                    '</tr>';
                    var classText="";       //当是修改状态 或者是未通过状态的时候，给活动标题添加该class，会显示不同的效果
                    var reasonText="";      //当是修改状态 或者是未通过的状态时，提示框里要显示出的文字，也就是未通过原因
                    if(!(row.regimentAuditStatus=="已通过" || row.regimentAuditStatus=="待审核" )){       //班级的审核状态验证
                        classText="error";
                        reasonText=row.regimentAuditReason;
                    }
                    if(!(row.collegeAuditStatus=="已通过" || row.collegeAuditStatus=="待审核" )){         //学院的审核状态验证
                        classText="error";
                        reasonText=row.collegeAuditReason;
                    }
                    if(!(row.schoolAuditStaus=="已通过" || row.schoolAuditStaus=="待审核" )){             //学校的审核状态验证
                        classText="error";
                        reasonText=row.schoolAuditReason;
                    }
                    var two='<tr>'+
                        '<td style="width:130px;">'+row.applyDate.substring(0,10)+'</td>'+
                        '<td style="width:auto;"><span class="'+classText+'" >'+(row.activityTitle?row.activityTitle:(row.shipName?row.shipName:row.workName))+'</span><input type="hidden" value="'+reasonText+'"/></td>'+
                        '<td style="width:75px;">'+activityLevle+'</td>'+
                        '<td style="width:75px;" class="activityCredit">'+(row.activityCredit?row.activityCredit:"") + '</td>'+
                        '<td style="width:auto;">'+(row.activityAward?row.activityAward:(row.shipType?row.shipType:""))+'</td>'+
                        '<td style="width:90px;">'+
                        '<a href="javascript:void(0)"  onclick="EditApply(\''+row.applyId+'\')"><img class="smchange" src="../../asset_font_new/img/edit_ico.png" alt="修改" title="修改"></a>|' +
                        '<a href="javascript:void(0)"  onclick="DeleteApply(\''+row.applyId+'\')"><img class="smdele" src="../../asset_font_new/img/del_ico.png" alt="删除" title="删除"></a>'+
                        '</td>'+
                    '</tr>';
                    if(row.schoolAuditStaus!="已通过"||row.collegeAuditStatus!="已通过"){
                        str=two;
                    }else {
                        str=one;
                    }
                    switch (row.activityClass){
                        case ("1"):
                            $("#aClass").append(str);
                            $("#aClass").find("tr:last").data(row);
                            break;
                        case ("2"):
                            $("#bClass").append(str);
                            $("#bClass").find("tr:last").data(row);
                            break;
                        case ("3"):
                            $("#cClass").append(str);
                            $("#cClass").find("tr:last").data(row);
                            break;
                        case ("4"):
                            if(row.worktime){
                                row.activityCredit =   Math.floor(((row.worktime)/12)*100)/100
                            }
                            var str1="";
                            var one='<tr>'+
                                '<td style="width: 130px">'+row.applyDate.substring(0,10)+'</td>'+
                                '<td style="width:auto;"><span>'+row.activityTitle+'</span></td>'+
                                '<td style="width:75px;">'+activityLevle+'</td>'+
                                '<td style="width: 75px">'+(row.activityCredit?row.activityCredit:"")+ '</td>'+
                                '<td style="width:90px;">'+(row.worktime?row.worktime:"")+'</td>'+
                                '<td style="width:auto;" class="activityCredit">'+(row.activityAward?row.activityAward:"")+'</td>'+
                                '<td style="width: 90px">'+
                                '<input  class="selected_checkbox" onclick="validatepower(this,\''+row.applyId+'\')" type="checkbox" style="width: 20px;height: 18px; position: relative; top: 6px;" />&nbsp;|'+
                                '<a href="javascript:void(0)"  onclick="DeleteApply(\''+row.applyId+'\')"><img class="smdele" src="../../asset_font_new/img/del_ico.png" alt="删除" title="删除"></a>'+
                                '</td>'+
                            '</tr>';
                            var classText="";       //当是修改状态 或者是未通过状态的时候，给活动标题添加该class，会显示不同的效果
                            var reasonText="";      //当是修改状态 或者是未通过的状态时，提示框里要显示出的文字，也就是未通过原因
                            if(!(row.regimentAuditStatus=="已通过" || row.regimentAuditStatus=="待审核" )){       //班级的审核状态验证
                                classText="error";
                                reasonText=row.regimentAuditReason;
                            }
                            if(!(row.collegeAuditStatus=="已通过" || row.collegeAuditStatus=="待审核" )){         //学院的审核状态验证
                                classText="error";
                                reasonText=row.collegeAuditReason;
                            }
                            if(!(row.schoolAuditStaus=="已通过" || row.schoolAuditStaus=="待审核" )){             //学校的审核状态验证
                                classText="error";
                                reasonText=row.schoolAuditReason;
                            }
                            var two='<tr>'+
                                '<td style="width:130px;">'+row.applyDate.substring(0,10)+'</td>'+
                                '<td style="width:auto;"><span class="'+classText+'" >'+row.activityTitle+'</span><input type="hidden" value="'+reasonText+'"/></td>'+
                                '<td style="width:75px;">'+activityLevle+'</td>'+
                                '<td style="width:75px;" class="activityCredit">'+(row.activityCredit?row.activityCredit:"")+ '</td>'+
                                '<td style="width:90px;">'+(row.worktime?row.worktime:"")+'</td>'+
                                '<td style="width:auto;">'+(row.activityAward?row.activityAward:"")+'</td>'+
                                '<td style="width:90px;">'+
                                '<a href="javascript:void(0)"  onclick="EditApply(\''+row.applyId+'\')"><img class="smchange" src="../../asset_font_new/img/edit_ico.png" alt="修改" title="修改"></a>|' +
                                '<a href="javascript:void(0)"  onclick="DeleteApply(\''+row.applyId+'\')"><img class="smdele" src="../../asset_font_new/img/del_ico.png" alt="删除" title="删除"></a>'+
                                '</td>'+
                            '</tr>';
                            if(row.schoolAuditStaus!="已通过"||row.collegeAuditStatus!="已通过"){
                                str1=two;
                            }else {
                                str1=one;
                            }
                            $("#dClass").append(str1);
                            $("#dClass").find("tr:last").data(row);
                            break;
                        case ("5"):
                            $("#eClass").append(str);
                            $("#eClass").find("tr:last").data(row);
                            break;
                        case ("6"):
                            $("#fClass").append(str);
                            $("#fClass").find("tr:last").data(row);
                            break;
                    }
                }
                if(zhutiguanData.length>0){
                    //添加主题团日活动的表格
                    var count=zhutiguanData.length;
                    var point=count>=12?1:count>=6?0.6:count>=3?0.3:0;
                    //-----------------------学分的处理-------------------------------------------------------------
                    var text=$(".score_total1").text();
                    $(".score_total1").text("已修学分"+(parseFloat(text.replace("已修学分",""))+point).toFixed(2));
                    //-----------------------学分的处理-------------------------------------------------------------
                    var str='<tr class="spacel">'+
                        '<td style="width:130px;">大学期间</td>'+
                        '<td style="width:auto;"><span>主题团日活动<button></button></span></td>'+
                        '<td style="width:75px;">校级</td>'+
                        '<td style="width:75px;" class="activityCredit">'+(point==0?"":point) + '</td>'+
                        '<td style="width:auto;">共计'+count+'次</td>'+
                        '<td style="width:90px;">'+
                        '<input  type="checkbox" style="width: 20px;height: 18px;" />'+
                        '</td>'+
                        '</tr>';
                    $("#aClass").append(str);
                    $("#aClass").find("tr:last").data(zhutiguanData);
                    genner_ZhuTiTuanRi_detail(zhutiguanData);       //生成主题团日详情的对话框
                }
            }
            $("#eClass .activityCredit").hide();
            $("#fClass .activityCredit").hide();
        },
        error:function(){
            layer.msg("网络错误",{offset:['30%'] });
        }
    })
};
//验证是否有打印预览权限
function validatepower(val,applyID){
    $.ajax({
        url:"/jsons/loadschoolauditstatus.form",
        type:"post",
        data:{applyId:applyID},
        dataType:"json",
        success:function(data){
           if(data.total>0){
               if(data.rows[0].schoolAuditStaus!='已通过'){
                   $(val).attr("checked",false);
                   layer.msg("审核中，不能预览，请选择审核完毕的申请！",{offset:['30%'] });
               }
           }
        }
    });

}
/**
 * 生成主题团日详情的对话框
 * @param data
 */
function genner_ZhuTiTuanRi_detail(data){
    $("#zhutituan_detail_box").html("");
    for(var i=0;i<data.length;i++){
        var row=data[i];
        var str='<ol>'+
            '<li class="first">'+
            '<p>名称</p>'+
            '<span title="'+row.activityTitle+'">'+row.activityTitle+'</span>'+
            '</li>'+
            '<li class="secound">'+
            '<p>时间</p>'+
            '<span>'+row.applyDate+'</span>'+
            '</li>'+
            '<li class="third">'+
             '<p>能力</p>'+
            '<span>'+row.supPowers.replace(/能力/gi,"").replace(/\|/gi,"、")+'</span>'+
            '</li>'+
            '<p></p>'+
            '<span>'+
            '<a href="javascript:void(0)" style="position: relative;top: 31px;"  onclick="DeleteApply(\''+row.applyId+'\')"><img class="smdele" src="../../asset_font_new/img/del_ico.png" alt="删除" title="删除"></a>'+'</span>'+
            '</li>'+
            '</ol>';
        $("#zhutituan_detail_box").append(str);
        $("#zhutituan_detail_box ol:last").data(row);
    }
}

/**
 * 获取个人信息
 */
function infor(){
$.ajax({
    url:"/jsons/loadInfor.form",
    type:"post",
    dataType:"json",
    async:true,
    success:function(data){
        if(data!=null && data.rows!=null && data.rows.length>0){
            StudentID=data.rows[0].studentID;
           collegename=data.rows[0].collegeName;
            $("#picture").attr("src","/Files/Images/"+data.rows[0].studentPhoto);
            $("#newpicture").attr("src","/Files/Images/"+data.rows[0].studentPhoto);
            $("#studentPhoto").val(data.rows[0].studentPhoto);
            studentPhotoval=data.rows[0].studentPhoto;
            $("#information").html("");
            var str= '<li class="item1">'+
                '<label class="person_msg_style person_msg_type"></label>'+
                '<span class="person_msg_style" title="'+data.rows[0].studentName +'">'+data.rows[0].studentName+'</span></li>'+
                '<li class="item6">'+
                '<label class="person_msg_style person_msg_type"></label>'+
                '<span class="person_msg_style" title="'+data.rows[0].studentPhone +'">'+data.rows[0].studentPhone+'</span>'+
                '</li>'+
                '<ol class="itemBox">'+
                '<li class="item2">'+
                '<label class="person_msg_style person_msg_type">学院&nbsp;&nbsp;</label>'+
                '<span class="person_msg_style" title="'+data.rows[0].collegeName +'">'+data.rows[0].collegeName+'</span>'+
                '</li>'+
                '<li class="item3">'+
                '<label class="person_msg_style person_msg_type">专业&nbsp;&nbsp;</label>'+
                '<span class="person_msg_style" title="'+data.rows[0].majorName +'">'+data.rows[0].majorName+'</span>'+
                '</li>'+
                '<li class="item4">'+
                '<label class="person_msg_style person_msg_type">班级&nbsp;&nbsp;</label>'+
                '<span class="person_msg_style" title="'+data.rows[0].className +'">'+data.rows[0].className+'</span>'+
                '</li>'+
                '<li class="item5">'+
                '<label class="person_msg_style person_msg_type">学号&nbsp;&nbsp;</label>'+
                '<span class="person_msg_style" title="'+data.rows[0].studentID +'">'+data.rows[0].studentID+'</span>'+
                '</li>'+
                '</ol>';
            $("#information").append(str);
        }
        $("#changeInfo").click(function(){
            $('.window_Greybg').slideDown(200);
            $('.new_window').show(200);
        });

    },
    error:function(){
        layer.msg("网络错误",{offset:['30%'] });
    }
});
}
/**
 * 预览图片功能
 * @param file
 */
function preview(file) {
    var prevDiv = $("#newpicture");
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
 * 初始化加载申请打印过的活动
 */
function loadPrintActivity(){
    $.ajax({
        url:"/printTranscript/loadPrintActivity.form",
        type:"post",
        dataType:"json",
        success:function(data) {
            //console.log(data);
            if(data!=null && data.rows!=null && data.rows.length>1){
                    document.getElementsByClassName("grade_list")[0].style.display = "block";
                    var header='<tr class="table_items">'+
                        '<td>时间</td>'+
                        '<td>项目名称</td>'+
                        '<td>项目级别</td>'+
                        '<td>所获奖项</td>'+
                        '</tr>';
                    $("#aClass").html("");
                    $("#bClass").html("");
                    $("#cClass").html("");
                    $("#dClass").html("");
                    $("#eClass").html("");
                    $("#fClass").html("");
                    $("#aClass").append(header);
                    $("#bClass").append(header);
                    $("#cClass").append(header);
                    $("#dClass").append(header);
                    $("#eClass").append(header);
                    $("#fClass").append(header);
                    for(var i=0;i<data.rows.length-1;i++){
                        var row = data.rows[i];
                       // console.log(row);
                        switch (row.activityLevle) {
                            case ("0"):activityLevle = "国际级";break;
                            case ("1"):activityLevle = "国家级";break;
                            case ("2"):activityLevle = "省级";break;
                            case ("3"):activityLevle = "市级";break;
                            case ("4"):activityLevle = "校级";break;
                            case ("5"):activityLevle = "院级";break;
                            case ("6"):activityLevle = "团支部级";break;
                            default:activityLevle ="";break;
                        }
                        switch (row.activityAward){
                            case ("1"):activityAward="一等奖";break;
                            case ("2"):activityAward="二等奖";break;
                            case ("3"):activityAward="三等奖";break;
                            case ("4"):activityAward="优秀奖";break;
                            case ("5"):activityAward="纪念奖";break;
                            case ("6"):activityAward="其他奖项";break;
                            default:activityAward="";break;
                        }
                        var str='<tr>'+
                            '<td>'+row.applyDate+'</td>'+
                            '<td>'+row.activityTitle+'</td>'+
                            '<td>'+activityLevle+'</td>'+
                            '<td>'+ activityAward+ '</td>'+
                            '</tr>';
                        switch (row.activityClass){
                            case ("1"):$("#aClass").append(str);break;
                            case ("2"):$("#bClass").append(str);break;
                            case ("3"):$("#cClass").append(str);break;
                            case ("4"):$("#dClass").append(str);break;
                            case ("5"):$("#eClass").append(str);break;
                            //default:"";break;
                        }
                    }
            }else {
                if(data.rows[0].msg!=""){
                    layer.alert(data.rows[0].msg,{offset:['30%'] });
                }else{
                    layer.alert("暂无申请打印成绩单记录!",{offset:['30%'] });
                }
            }
        },
        error:function(){
            layer.alert("暂无申请打印成绩单记录!",{offset:['30%'] });
        }
    })
}

function EditApply(id){
        if (id){
            $.ajax({
                url:"/jsons/loadsupplement.form",
                type:"post",
                data:{id:id},

                success:function(data){
                    canEdit = true;
                    if(data.rows.length>0){
                        var row=data.rows[0];
                        var flag;
                        if(row.regimentAuditStatus=="待审核"){
                            flag=1;
                            canEdit=true;
                        }

                        if(row.regimentAuditStatus=="修改" || row.regimentAuditStatus=="未通过"){
                            flag=1;
                            if(row.regimentAuditStatus=="未通过") canEdit=true;
                        }

                        if(row.collegeAuditStatus=="修改" || row.collegeAuditStatus=="未通过") {
                            flag = 1;
                            if (row.collegeAuditStatus == "未通过") canEdit = true;
                        }
                        if(row.schoolAuditStaus=="修改" || row.schoolAuditStaus=="未通过") {
                            flag = 1;
                            if (row.schoolAuditStaus == "未通过") canEdit = true;
                        }
                        if(!flag){
                            layer.alert("已进入审核阶段不可修改!",{offset:['30%'] });
                            return false;
                        }
                        ////////////////////////////添加三级审核的状态到对话框中一个隐藏区域中////////////////////////////////
                        $("#regimentAuditStatus").val(row.regimentAuditStatus);
                        $("#collegeAuditStatus").val(row.collegeAuditStatus);
                        $("#schoolAuditStaus").val(row.schoolAuditStaus);
                        //////////////////////////////////////////////////////////////////////////////////////////////////////
                        $(".window_selectMsg").show();
                        $(".window_Greybg").show();
                        $("#common").hide();
                        $("#activityClass").attr("disabled","disabled");
                        $("#supType").attr("disabled","disabled");
                        if(row.supClass&&(row.supClass=="1"||row.supClass=="2"||row.supClass=="4")){
                            $("#firstChoose").show();
                            $("#common").show();
                            $("#actNotHave").show();
                            if(row.supClass=="4"){
                                $("#NotfiveShow").show();
                            }
                        }
                        if(row.supClass&&row.supClass=="3"){
                            $("#secondChoose").show();
                            if(row.supType!="非活动类"){
                                $("#actNotHave").show();
                            }else {
                                $("#supType option:last").text("非活动类").val("非活动类");
                                $("#val3Choose").show();
                            }
                            $("#common").show();
                        }
                        if(row.supClass&&row.supClass=="5"){
                            $("#secondChoose").show();
                            if(row.supType!="非活动类"){
                                $("#actNotHave").show();
                            }else {
                                $("#supType option:last").text("学生干部任职").val("非活动类");
                                loadorg("班团任职");
                                $("#val4Choose").show();
                            }
                            $("#common").show();
                        }
                        if(row.supClass&&row.supClass=="6"){
                            $("#var6Choose").show();
                            $("#common").show();
                        }
                        var supPowers=row.supPowers;
                        //console.log(supPowers)
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
                        if(row.supAward!="一等奖"&&row.supAward!="二等奖"&&row.supAward!="三等奖"){
                            $("#Award").show();
                            $("#Award").val(row.supAward);
                            $("#supAward").val("其他");
                        }else {
                            $("#supAward").val(row.supAward);
                        }
                    }
                    for(var key in row){
                        $('[name='+key+']').val(row[key]);
                   }
                }
            });
        }
}

function  DeleteApply(id){
    layer.confirm("确认删除申请吗？此操作不可恢复",{offset:['30%'] },function(result){
        if(result&&id){

            $.ajax({
                url:"/apply/deleteById.form",
                type:"post",
                data:{applyId:id},
                dataType: "json",
                success:function(data){
                    if(data.result == 1){
                        layer.msg("删除成功",{offset:['30%'] });
                        selectInfor();//重新加载数据
                    }else if(data.result == 0){
                        delsupplement(id);
                    }else{
                        layer.msg("删除失败，请重新登录或联系管理员",{offset:['30%'] });
                    }
                }
            })

           /**/
        }else {
            layer.msg("删除失败，请重新登录或联系管理员",{offset:['30%'] });
        }
    });
}
function delsupplement(id){
    $.ajax({
        url:"/jsons/deletesupplement.form",
        type:"post",
        data:{id:id},
        async:false,
        success:function(data){
            if(data.result){
                if (data.result) {
                    //console.log(data);
                    layer.msg("删除成功",{offset:['30%'] });
                    selectInfor();//重新加载数据
                } else {
                    layer.msg("删除失败，请重新登录或联系管理员",{offset:['30%'] });
                }
            }
        }
    })
}
function insetToSort(newapplyID){
    $.ajax({
        url:"/printTranscript/insetToSort.form",
        type:"post",
        data:{applyID:newapplyID},
        success:function(data){
            if(data.result){
                $("input:checkbox").attr("checked",false);
                setTimeout(function(){window.open("/views/font/A4.form?&Enigmatic=","_parent");},1000);
            }
        },error:function(){
            $("input:checkbox").attr("checked",false);
        }
    })
}

setTimeout(function () {
    $(".itemBox>li>span").map(function () {
        var tip;
        var txt=$(this).text();
        $(this).hover(function () {
            if(this.offsetWidth < this.scrollWidth){
                tip=layer.tips(txt, $(this), {
                    tips: [3, '#5c85ee'],
                    time: 4000
                });
            }
        }, function () {
            layer.close(tip);
        });
        //var tip2;
        //$('td span').hover(function () {
        //    var texclass=$(this).parent().children("input").eq(0).val();
        //    if(!texclass || texclass=="undefined") texclass="暂无原因";
        //    if($(this).hasClass("error")){
        //        tip2=layer.tips(texclass,$(this), {
        //            tips: [3, '#5c85ee'],
        //            time: 4000
        //        });
        //    }
        //}, function () {
        //    if($(this).hasClass("error")) {
        //        layer.close(tip2);
        //    }
        //})

        //spacel弹窗
        function closestu(){
            $(".window_Greybg").slideUp(200);
            $(".stuWindow").hide(200);
        }
        $(".stuWindow>b,.stuWindow>button").on("click", function () {
            closestu();
        })
        $("body").on("click",".spacel td span button",function () {
            openstu();
            hehe();
        })
        function openstu(){
            $(".window_Greybg").slideDown(200);
            $(".stuWindow").show(200);
        }

    })
},1000);
