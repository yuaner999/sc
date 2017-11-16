<%--
  Created by IntelliJ IDEA.
  User: pjj
  Date: 2016/10/25
  Time: 9:24
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java"  pageEncoding="UTF-8" %>
<script>
    var loadUrl = '/jsons/loadSchoolActivity.form';
    var jsonPara;
    $(function(){
        before_reload();
    });

    //before_reload :加载前rows和page参数处理
    function before_reload(){

        page= $(".currentPageNum").val();
        rows = $("#rows").val();
        if(page>(totalNum%rows==0?totalNum/rows:totalNum/rows+1)){//进行判断，避免选择rows时出现错误
            page = 1;$(".currentPageNum").val(1);
        }

        if(sqlStr==""||sqlStr==null){
            jsonPara={rows:rows,page:page};
        }else{
            jsonPara={rows:rows,page:page,sqlStr:sqlStr};
        }
//        console.log(jsonPara);
        reload();
    }
    function  reload() {//此处加载数据方法名不能修改，必须用reload
        load();

        $.ajax({
            url: loadUrl,
            type: "post",
            data:jsonPara,
            dataType: "json",
            success: function (data) {
//                    console.log(data);
                $("tbody").html("");
                if (data != null && data.rows != null && data.rows.length > 0) {
                    for (var i = 0; i < data.rows.length; i++) {
                        var row = data.rows[i];
                        var tr = '<tr id="tr'+(i+1)+'">'+
                                '<td>'+(i+1)+'</td>'+
                                    //第二处修改：按照数据库列名进行拼穿
                                '<td class="fontStyle newsTitle ">'+row.newsTitle+'</td>'+
                                '<td class="newsContent ">'+row.newsContent+'</td>'+
                                '<td class="newsType ">'+row.newsType+'</td>'+
                                '<td class="newsCreator ">'+row.newsCreator+'</td>'+
                                '<td class="newsId " style="display:none">'+row.newsId+'</td>'+
                                '<td class="newsImg " style="display:none">'+row.newsImg+'</td>'+
                                '</tr>';
                        $("tbody").append(tr);
                        $("#tr"+(i+1)).data(row);//存入data为后台修改时取数据
                    }

                    rowClick();//绑定行点击事件
                    totalNum=data.total;

                }else{
                    totalNum=0;
                }
                paging();
            }, error: function () {
                layer.msg("网络错误");
            }
        })
        disLoad();
    }
</script>
<!--新建窗口-->
<div class="new">
    <div class="header">
        <span>新建</span>
        <span type="reset" class="iconConcel"></span>
    </div>
    <div class="messagePage">
        <table border="0" cellspacing="0" cellpadding="0" id="tbody">
            <thead>
            <tr>
                <td></td>
                <td>新闻标题</td>
                <td>新闻内容</td>
                <td>新闻类型</td>
                <td>新闻创建者</td>
            </tr>
            </thead>

        </table>
    </div>
    <div class="new_buttons">
        <input type="button" value="提交" />
        <input type="reset" value="取消" />
    </div>
</div>
<div class="pagingTurn">
    <div>
        <span class="turn_left" onclick="turn_left()"></span> 第
        <input class="currentPageNum" type="text" value="1">页，共
        <span class="pageNum"></span> 页
        <span class="turn_right" onclick="turn_right()"></span>
    </div>
    <div>
        <select id="rows" name="rows" onchange="before_reload()">
            <option value="10" selected>10</option>
            <option value="20">20</option>
            <option value="50">50</option>
            <option value="100">100</option>
        </select>
    </div>
    <%--<img src="<%=request.getContextPath()%>/asset_admin_new/img/sx2.png" onclick="refresh()" />--%>
    <div>
        显示<span class="pageNum"></span>到<span class="pageNum"></span>，共<span class="pageNum"></span>条记录
    </div>
</div>

