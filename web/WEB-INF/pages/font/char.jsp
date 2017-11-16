<%--
  Created by IntelliJ IDEA.
  User: admin
  Date: 2016/9/14
  Time: 8:46
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java"  pageEncoding="UTF-8" %>
<!DOCTYPE html>
<script type="text/javascript" src="<%=request.getContextPath()%>/asset_mobile/js/echarts.min.js"></script>

<div id="charts" style="width: 18.75rem;height:400px;">
    <%--<img src="<%=request.getContextPath()%>/asset_font/img/static.png" />--%>
</div>
<script type="text/javascript">
    var result ;
    // 基于准备好的dom，初始化echarts实例
    var myChart = echarts.init(document.getElementById('charts'));
    // 指定图表的配置项和数据
    option = {
        title: {
//                            text: '学生能力得分雷达图'
        },
        tooltip: {},
        legend: {
            // orient : 'vertical',
            //x : 'center',
            data: []
        },
        radar: {
            radius:'50%',
            // shape: 'circle',
            indicator: [
                { name: '表达', max: 100},
                { name: '执行', max: 100},
                { name: '思辨', max: 100},
                { name: '领导', max: 100},
                { name: '创新', max: 100},
                { name: '创业', max: 100}
            ]
        },
        series: []
    };
    //拼穿的2个方法
    function generYears (data){
        var list = [];
        for (var i = 0; i <data.total; i++) {
            list.push(data.rows[i].pointYear);
        }
        return list;
    }

    function gennerData(data) {
        var series = [];
        for(var i = 0;i<data.total;i++){
            series.push({
                name:'能力成绩表',
                type:'radar',
                data:[
                    {
                        value:[
                            data.rows[i].biaoda!=null?data.rows[i].biaoda:50,
                            data.rows[i].zhixing!=null?data.rows[i].zhixing:50,
                            data.rows[i].sibian!=null?data.rows[i].sibian:50,
                            data.rows[i].lingdao!=null?data.rows[i].lingdao:50,
                            data.rows[i].chuangxin!=null?data.rows[i].chuangxin:50,
                            data.rows[i].chuangye!=null?data.rows[i].chuangye:50
                        ],
                        name:data.rows[i].pointYear
                    }
                ]
            })
        }
        return series;
    }

    // 异步加载数据
    $.ajax({
        type: "post",
        async: false,
        url:"/char/loadSixElementPoint.form" ,
        dataType: "json",
        success: function (data) {
            // 获得拼穿值
            var years=generYears(data);
            var servies=gennerData(data);
            // 给option对应地方赋值
            option.legend.data=eval(years);
            option.series=eval(servies);
            // 使用刚指定的配置项和数据显示图表。
            myChart.setOption(option);
        },
        error: function () {
            alert("图表请求数据失败啦!");
        }
    });
</script>
