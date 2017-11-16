//加载个人信息
$.ajax({
    url:"/jsons/loadInfor.form",
    type:"post",
    datatype:"json",
    success:function(data){
        if(data.total>0){
            var row = data.rows[0];
            $("#sname").html(row.studentName);
            $("#scoll").html(row.collegeName);
            $("#smaj").html(row.majorName);
            $("#scla").html(row.className);
            $("#sid").html(row.studentID);
            $("#spho").html(row.studentPhone);
            var photo = row.studentPhoto;
            var str = '<img class="photo" src=/Files/Images/'+row.studentPhoto+' onerror="(this).src=\'/Files/Images/default.jpg\'" >';//(this).src=\'/Files/Images/default.jpg\'
            if(photo==null||photo==''){
                str = '<img src=/Files/Images/default.jpg>';
            }
            $("#sphoto").html(str);
        }
    }
});
var result ;
// 基于准备好的dom，初始化echarts实例
var myChart = echarts.init(document.getElementById('charts'));

// 指定图表的配置项和数据
option = {
    title: {},
    tooltip: {},
    legend: {
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
                        data.rows[i].chuangye!=null?data.rows[i].chuangye:50,
                        data.rows[i].chuangxin!=null?data.rows[i].chuangxin:50,
                        data.rows[i].lingdao!=null?data.rows[i].lingdao:50,
                        data.rows[i].sibian!=null?data.rows[i].sibian:50,
                        data.rows[i].zhixing!=null?data.rows[i].zhixing:50
                    ],
                    name:data.rows[i].pointYear
                }
            ]
        });
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
        myChart.clear();
        myChart.setOption(option);
    },
    error: function () {
        layer.msg("图表请求数据失败啦!");
    }
});

