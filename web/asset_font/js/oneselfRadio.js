/**
 * Created by sw on 2016/9/18.
 */
var result ;
// 基于准备好的dom，初始化echarts实例
var myChart = echarts.init(document.getElementById('charts'));

// 指定图表的配置项和数据
option = {
    title: {
//            text: '学生能力得分雷达图'
    },
    tooltip: {},
    legend: {
        // orient : 'vertical',
        x : 'right',
        y : '85%',

        data: ['','']
    },
    radar: {
        radius:'50%',
        splitNumber:4,
        indicator: [
            { name: '表达',min:20, max: 100},
            { name: '创业',min:20, max: 100},
            { name: '创新',min:20, max: 100},
            { name: '领导',min:20, max: 100},
            { name: '思辨',min:20, max: 100},
            { name: '执行',min:20, max: 100}
        ],name: {
            show: true,
            textStyle:{
                fontSize: 18,
                color: "#000000"
            }
        }
    },
    series: []
};
$(function(){
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
            setNumdata(data);
            // 给option对应地方赋值
            option.legend.data=eval(years);
            option.series=eval(servies);
            // 使用刚指定的配置项和数据显示图表。
            myChart.clear();
            myChart.setOption(option);
        },
        error: function () {
            layer.msg("图表请求数据失败啦!");
        }
    });
});
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
                        data.rows[i].chuangye!=null?data.rows[i].chuangye:50,
                        data.rows[i].chuangxin!=null?data.rows[i].chuangxin:50,
                        data.rows[i].lingdao!=null?data.rows[i].lingdao:50,
                        data.rows[i].sibian!=null?data.rows[i].sibian:50,
                        data.rows[i].zhixing!=null?data.rows[i].zhixing:50
                    ],
                    name:data.rows[i].pointYear
                }
            ]
        })
    }
    return series;
}

//为柱状图动态赋值
function setNumdata(data){
    if(data.total>0){
        for(var i=0;i<data.total;i++){
            $(".mynum-div").eq(0).width(parseInt(data.rows[i].biaoda!=null?data.rows[i].biaoda:50)+"%");
            $(".mynum-span").eq(0).text(parseInt(data.rows[i].biaoda!=null?data.rows[i].biaoda:50));
            $(".mynum-div").eq(1).width(parseInt(data.rows[i].zhixing!=null?data.rows[i].zhixing:50)+"%");
            $(".mynum-span").eq(1).text(parseInt(data.rows[i].zhixing!=null?data.rows[i].zhixing:50));
            $(".mynum-div").eq(2).width(parseInt(data.rows[i].sibian!=null?data.rows[i].sibian:50)+"%");
            $(".mynum-span").eq(2).text(parseInt(data.rows[i].sibian!=null?data.rows[i].sibian:50));
            $(".mynum-div").eq(3).width(parseInt(data.rows[i].lingdao!=null?data.rows[i].lingdao:50)+"%");
            $(".mynum-span").eq(3).text(parseInt(data.rows[i].lingdao!=null?data.rows[i].lingdao:50));
            $(".mynum-div").eq(4).width(parseInt(data.rows[i].chuangxin!=null?data.rows[i].chuangxin:50)+"%");
            $(".mynum-span").eq(4).text(parseInt(data.rows[i].chuangxin!=null?data.rows[i].chuangxin:50));
            $(".mynum-div").eq(5).width(parseInt(data.rows[i].chuangye!=null?data.rows[i].chuangye:50)+"%");
            $(".mynum-span").eq(5).text(parseInt(data.rows[i].chuangye!=null?data.rows[i].chuangye:50));
        }
    }
}



