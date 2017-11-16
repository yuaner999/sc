<html>
<head>
    <style type="text/css">
        body{
            font-family:'SimSun';
        }
        /*#box{*/
            /*border:1px solid #aaaaaa;*/
        /*}*/
        #box{
            width: 160mm;
            height: 237mm;
            margin: 0 auto;
            /*padding: 30mm 25mm 30mm 25mm;*/
        }
        #img_logo{
            width: 580px;
            height: 144px;
        }
        #logo{
            width: 250px;
            height: 85px;
            margin-top: 5mm;
        }
        #content{
            width: 580px;
            height: 527px;
        }
        #footer{
            width: 580px;
            height: 128px;
        }
        #footer_box{
            width: 258px;
            height: 105px;
            float: right;
        }
        #title{
            font-size: 30px;
            font-weight: bold;
            text-align: center;
        }
        .text_content{
            font-size: 18px;
        }
        #content p{
            line-height: 54px;
        }
        .under_line{
            display: inline-block;
            width: 86px;
            border-bottom: 1px solid #000;
            height: 43px;
            margin: 0 10px;
            text-align: center;
        }
        .under_class{
            width: 260px;
        }
        .add_length{
            width: 180px;
        }
        .first_inline{
            display: inline-block;
            width: 40px;
        }
        #footer_box p{
            text-align: center;
            line-height: 20px;
        }
        .date_span{
            display: inline-block;
            width: 28px;
            margin: 0 10px;
            text-align: center;
        }
        .yyyy{
            width:42px;
        }
    </style>
</head>
<body>
<div id="box">
    <div id="img_logo">
        <#--<img src="http://localhost:8080/templates/logo.png" id="logo" alt="logo"/>-->
            <img src="logo.png" id="logo" alt="logo"/>
    </div>
    <div id="content">
        <p id="title">证<span class="first_inline"></span>明</p>
        <p class="text_content">
            <span class="first_inline"></span>兹证明<span class="under_line">${proveStuName}</span>
            (姓名)，系东北大学<span class="under_line add_length">${proveCollName}</span>学院
            <span class="under_line add_length">${proveMajorName}</span>专业
            <span class="under_line under_class">${proveClass}</span>级学生，学号<span class="under_line">${proveStuId}</span>
            ，身份证号<span class="under_line add_length">${proveStuIdcard}</span>
            ，学制<span class="under_line">${proveStuEduLen}</span>年。
        </p>
        <p  class="text_content"><span class="first_inline"></span>特此证明。</p>
    </div>
    <div id="footer">
        <div id="footer_box">
            <p class="text_content">东北大学学生处</p>
            <p class="text_content"><span class="date_span yyyy">${yyyy}</span>年<span class="date_span">${mm}</span>月 <span class="date_span">${dd}</span>日</p>
        </div>
    </div>
</div>
</body>
</html>