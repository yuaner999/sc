//全局变量
var flag = null;
//查询是否有列被选中
function findSelected()
{
    var trNum = $('tbody').find('tr').length;
    for(var i = 0; i < trNum; i++)
    {
        if($('tbody tr').eq(i).css('background-color') != 'rgba(0, 0, 0, 0)')
        {
            flag = $('tbody tr').eq(i).data();
            break;
        }
    }
    return flag;
}
//审核通过/未通过
function auditAction(action){
    var row= jsonPara;
    if(!row) {
        layer.msg("请先选择一行数据！")
        return;
    }
    var status=row.printAuditstatus;
    //console.log(jsonPara+"auditAction")
    if(status!="待审核"){
        layer.msg("已审核过的打印申请不可以再次审核！")
        return;
    }
    var printid=row.printId;
    layer.load(1,{shade:[0.4,'#000000']});
    $.ajax({
        url:"/printBack/changeAuditstatus.form",
        type:"post",
        dataType:"json",
        data:{printid:printid,status:action},
        success:function(data){
            if(data.status==0){
                reload();
            }
            layer.closeAll();
            layer.msg(data.msg);
        },
        error:function(){
            layer.closeAll();
            layer.msg("服务器连接失败，请与管理员联系");
        }
    })
}
//打印成绩单
function printAction(){
    var row=findSelected();
    if(!row) {
        layer.msg("请先选择一行数据！")
        return;
    }
    var status=row.printAuditstatus;
    if(status!="已通过"){
        layer.msg("必须是通过审核的申请才能打印！")
        return;
    }
    var studentid=row.studentId;
    var printid=row.printId;
    window.open("/views/font/printPriviewV2.form?studentid="+studentid+"&printid="+printid);
    layer.load(1,{shade:[0.4,'#000000']});
    var printid=row.printId;
    $.ajax({
        url:"/printBack/changePrintstatus.form",
        type:"post",
        dataType:"json",
        data:{printid:printid},
        success:function(data){
            if(data.status==0){
                reload();
            }
            layer.closeAll();
            layer.msg(data.msg);
        },
        error:function(){
            layer.closeAll();
            layer.msg("服务器连接失败，请与管理员联系");
        }
    })
}