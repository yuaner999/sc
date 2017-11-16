<html>
<head>
    <meta charset="UTF-8"/>
    <title>申请表</title>
    <style>
        @page{size:297mm 210mm;}
        * {
            padding: 0px;
            margin: 0px;
            border: 0px;
            font-family:"SimSun";
        }
        table{
            table-layout:fixed; word-break:break-strict;
        }
        .content {
            width: 267mm;
            height: 180mm;
        }
        .leftcontent{
            width: 49%;
            float: left;
        }
        .rightcontent{
            width: 49%;
            float: right;
        }
        .leftcontent>p,.rightcontent>p{
            font-size: 24px;
            font-weight: bold;
            text-align: center;
            margin: 15px 0 20px 0;
        }
        .tbl{
            width: 96%;
            margin: 0 auto;
            font-size: 16px;
            border-collapse: collapse;

        }

        .tbl td{
            border: 1px solid #000000;
            padding: 10px 0px;
            line-height: 20px;

        }
        .tblname{
            width: 14%;
            text-align: center;
        }
        .tblname2{
            width: 14%;
            text-align: center;
            height: 35mm;
        }
        .tblval{
            width: 18%;

        }
        .tbl2{
            width: 100%;
            margin: -11px 0px;
            border-collapse: collapse; /*边框合并*/
        }
        .tbl2name{
            width: 26%;
            text-align: center;
        }
        .note{
            width: 96%;
            margin: 0 auto;
            font-size: 16px;
            line-height: 20px;
            margin-top: 5px;
        }
        .date{
            width: 20px;
            display: inline-block;
            text-align: center;
            line-height: 30px;
        }
        img{
            vertical-align: middle;
        }
        .date_box{
            width: 40px;
        }
        .yyyy{
            width: 60px;
        }
        .user_input{
            margin-left: 10px;
            display: inline-block;

        }
        .qujian_img{
            margin: 0 5px;
        }
        .space_{
            display: inline-block;
            width: 10px;
        }
        .space_X{
            display: inline-block;
            width: 32px;
        }
        .space_XX{
            display: inline-block;
            width: 55px;
        }
        .home_addr{
            width: 181px;
            height: 61px;
            overflow: hidden;
        }
        /*.class_name{*/
            /*width: 78px;*/
            /*height: 50px;*/
            /*overflow: hidden;*/
        /*}*/
    </style>
</head>
<body>
<div class="content">
    <div class="leftcontent">
        <p>东北大学本科学生学生证补办申请表</p>
        <table class="tbl" cellspacing="0" cellpadding="0" >
            <tr>
                <td class="tblname">姓 名</td>
                <td class="tblval "><span class="user_input">${studentName}</span></td>
                <td class="tblname">学 号</td>
                <td class="tblval "><span class="user_input">${studentID}</span></td>
                <td class="tblname">性 别</td>
                <td class="tblval "><span class="user_input">${studentGenger}</span></td>
            </tr>
            <tr>
                <td class="tblname">学 院</td>
                <td class="tblval "><span class="user_input college_"></span>${collegeName}</td>
                <td class="tblname">专 业<br/>班 级</td>
                <td class="tblval "><span class="user_input class_name"></span>${className}</td>
                <td class="tblname">缴 纳<br/>金 额</td>
                <td class="tblval "><span class="user_input">${money}</span></td>
            </tr>
            <tr>
                <td class="tblname">家 庭<br/>地 址</td>
                <td colspan="3">
                    <table class="tbl2" cellspacing="0" cellpadding="0">
                        <tr>
                            <td class="tbl2val " style="border: 0;"><span class="user_input home_addr">${homeAddress}</span></td>
                            <td class="tbl2name" style="border-right: 0;border-bottom:0 ;border-top: 0">乘 车<br/>区 间</td>
                        </tr>
                    </table>
                </td>
                <td class="tblval" colspan="2"><span class="space_"></span>沈阳<img class="qujian_img" src="qujian.png"/>${stationName}</td>
            </tr>
            <tr>
                <td class="tblname2">补<br />办<br />原<br />因</td>
                <td colspan="5" class="tblval">
                    <div style="height: 80px; width: 100%;margin-left: 10px;overflow: hidden" >${reason}</div>
                    <div style="float: right;width: 300px">
                        补办时间:<span class="date date_box yyyy">${yyyy}</span>年<span class="date date_box">${mm}</span>月<span class="date date_box">${dd}</span>日
                        <br />
                        <br />
                        本人签字：
                    </div>
                </td>
            </tr>
            <tr>
                <td class="tblname2" >学<br/>院<br/>意<br/>见</td>
                <td colspan="3">
                    <table class="tbl2" cellspacing="0" cellpadding="0">
                        <tr>
                            <td class="tbl2val" style="border-left: 0;border-top: 0;border-bottom: 0">
                                <div style="height: 10px; width: 100%;"></div>
                                <div style="float: left; height: 120px; line-height: 40px;">
                                    <span class="space_"></span>辅导员签字：<br/>
                                    <p style="padding-left: 50px;">（学办公章）</p>
                                    <p style="padding-left: 80px;"><span class="date"></span>年<span class="date"></span>月<span class="date"></span>日</p>
                                </div>
                            </td>
                            <td class="tbl2name" style="border-right: 0;border-top: 0;border-bottom: 0">学<br/>校<br/>意<br/>见</td>
                        </tr>
                    </table>
                </td>
                <td class="tblval" colspan="2"></td>
            </tr>
        </table>
        <div class="note">
            <p>注：1. 本表针对纸本式学生证、火车票优惠卡的补办。<br/>
                <span class="space_X"></span>2. 补办时间为每月初前三个工作日。<br/>
                <span class="space_X"></span>3. 学生证上乘车区间一经填写，原则上不得修改；<br/><span class="space_XX"></span>如需修改，须开具相关证明。
            </p>
        </div>
    </div>
    <!--竖线-->
    <div style="border-right: 2px dashed #000000; height: 170mm; width: 1%; float: left;margin-top: 5mm;"></div>
    <div class="rightcontent">
        <p>东北大学本科学生学生证补办申请表</p>
        <table class="tbl" cellspacing="0" cellpadding="0" >
            <tr>
                <td class="tblname">姓 名</td>
                <td class="tblval "><span class="user_input">${studentName}</span></td>
                <td class="tblname">学 号</td>
                <td class="tblval "><span class="user_input">${studentID}</span></td>
                <td class="tblname">性 别</td>
                <td class="tblval "><span class="user_input">${studentGenger}</span></td>
            </tr>
            <tr>
                <td class="tblname">学 院</td>
                <td class="tblval "><span class="user_input college_"></span>${collegeName}</td>
                <td class="tblname">专 业<br/>班 级</td>
                <td class="tblval "><span class="user_input class_name"></span>${className}</td>
                <td class="tblname">缴 纳<br/>金 额</td>
                <td class="tblval "><span class="user_input">${money}</span></td>
            </tr>
            <tr>
                <td class="tblname">家 庭<br/>地 址</td>
                <td colspan="3">
                    <table class="tbl2" cellspacing="0" cellpadding="0">
                        <tr>
                            <td class="tbl2val " style="border: 0;"><span class="user_input home_addr">${homeAddress}</span></td>
                            <td class="tbl2name" style="border-right: 0;border-bottom:0 ;border-top: 0">乘 车<br/>区 间</td>
                        </tr>
                    </table>
                </td>
                <td class="tblval" colspan="2"><span class="space_"></span>沈阳<img class="qujian_img" src="qujian.png"/>${stationName}</td>
            </tr>
            <tr>
                <td class="tblname2">补<br />办<br />原<br />因</td>
                <td colspan="5" class="tblval">
                    <div style="height: 80px; width: 100%;margin-left: 10px;overflow: hidden" >${reason}</div>
                    <div style="float: right;width: 300px">
                        补办时间:<span class="date date_box yyyy">${yyyy}</span>年<span class="date date_box">${mm}</span>月<span class="date date_box">${dd}</span>日
                        <br />
                        <br />
                        本人签字：
                    </div>
                </td>
            </tr>
            <tr>
                <td class="tblname2" >学<br/>院<br/>意<br/>见</td>
                <td colspan="3">
                    <table class="tbl2" cellspacing="0" cellpadding="0">
                        <tr>
                            <td class="tbl2val" style="border-left: 0;border-top: 0;border-bottom: 0">
                                <div style="height: 10px; width: 100%;"></div>
                                <div style="float: left; height: 120px; line-height: 40px;">
                                    <span class="space_"></span>辅导员签字：<br/>
                                    <p style="padding-left: 50px;">（学办公章）</p>
                                    <p style="padding-left: 80px;"><span class="date"></span>年<span class="date"></span>月<span class="date"></span>日</p>
                                </div>
                            </td>
                            <td class="tbl2name" style="border-right: 0;border-top: 0;border-bottom: 0">学<br/>校<br/>意<br/>见</td>
                        </tr>
                    </table>
                </td>
                <td class="tblval" colspan="2"></td>
            </tr>
        </table>
        <div class="note">
            <p>注：1. 本表针对纸本式学生证、火车票优惠卡的补办。<br/>
                <span class="space_X"></span>2. 补办时间为每月初前三个工作日。<br/>
                <span class="space_X"></span>3. 学生证上乘车区间一经填写，原则上不得修改；<br/><span class="space_XX"></span>如需修改，须开具相关证明。
            </p>
        </div>
    </div>
    <div style="clear: both;"></div>
    <div style="margin-top: 10px; text-align: center; color: #666666; font-size: 14px;">此表财务处留存 <img src="cutImg.png"/> 此表学生处留存</div>
</div>
</body>
</html>