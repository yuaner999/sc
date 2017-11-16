<html>
<head>
    <meta charset="UTF-8"/>
    <title>�����</title>
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
            border-collapse: collapse; /*�߿�ϲ�*/
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
        <p>������ѧ����ѧ��ѧ��֤���������</p>
        <table class="tbl" cellspacing="0" cellpadding="0" >
            <tr>
                <td class="tblname">�� ��</td>
                <td class="tblval "><span class="user_input">${studentName}</span></td>
                <td class="tblname">ѧ ��</td>
                <td class="tblval "><span class="user_input">${studentID}</span></td>
                <td class="tblname">�� ��</td>
                <td class="tblval "><span class="user_input">${studentGenger}</span></td>
            </tr>
            <tr>
                <td class="tblname">ѧ Ժ</td>
                <td class="tblval "><span class="user_input college_"></span>${collegeName}</td>
                <td class="tblname">ר ҵ<br/>�� ��</td>
                <td class="tblval "><span class="user_input class_name"></span>${className}</td>
                <td class="tblname">�� ��<br/>�� ��</td>
                <td class="tblval "><span class="user_input">${money}</span></td>
            </tr>
            <tr>
                <td class="tblname">�� ͥ<br/>�� ַ</td>
                <td colspan="3">
                    <table class="tbl2" cellspacing="0" cellpadding="0">
                        <tr>
                            <td class="tbl2val " style="border: 0;"><span class="user_input home_addr">${homeAddress}</span></td>
                            <td class="tbl2name" style="border-right: 0;border-bottom:0 ;border-top: 0">�� ��<br/>�� ��</td>
                        </tr>
                    </table>
                </td>
                <td class="tblval" colspan="2"><span class="space_"></span>����<img class="qujian_img" src="qujian.png"/>${stationName}</td>
            </tr>
            <tr>
                <td class="tblname2">��<br />��<br />ԭ<br />��</td>
                <td colspan="5" class="tblval">
                    <div style="height: 80px; width: 100%;margin-left: 10px;overflow: hidden" >${reason}</div>
                    <div style="float: right;width: 300px">
                        ����ʱ��:<span class="date date_box yyyy">${yyyy}</span>��<span class="date date_box">${mm}</span>��<span class="date date_box">${dd}</span>��
                        <br />
                        <br />
                        ����ǩ�֣�
                    </div>
                </td>
            </tr>
            <tr>
                <td class="tblname2" >ѧ<br/>Ժ<br/>��<br/>��</td>
                <td colspan="3">
                    <table class="tbl2" cellspacing="0" cellpadding="0">
                        <tr>
                            <td class="tbl2val" style="border-left: 0;border-top: 0;border-bottom: 0">
                                <div style="height: 10px; width: 100%;"></div>
                                <div style="float: left; height: 120px; line-height: 40px;">
                                    <span class="space_"></span>����Աǩ�֣�<br/>
                                    <p style="padding-left: 50px;">��ѧ�칫�£�</p>
                                    <p style="padding-left: 80px;"><span class="date"></span>��<span class="date"></span>��<span class="date"></span>��</p>
                                </div>
                            </td>
                            <td class="tbl2name" style="border-right: 0;border-top: 0;border-bottom: 0">ѧ<br/>У<br/>��<br/>��</td>
                        </tr>
                    </table>
                </td>
                <td class="tblval" colspan="2"></td>
            </tr>
        </table>
        <div class="note">
            <p>ע��1. �������ֽ��ʽѧ��֤����Ʊ�Żݿ��Ĳ��졣<br/>
                <span class="space_X"></span>2. ����ʱ��Ϊÿ�³�ǰ���������ա�<br/>
                <span class="space_X"></span>3. ѧ��֤�ϳ˳�����һ����д��ԭ���ϲ����޸ģ�<br/><span class="space_XX"></span>�����޸ģ��뿪�����֤����
            </p>
        </div>
    </div>
    <!--����-->
    <div style="border-right: 2px dashed #000000; height: 170mm; width: 1%; float: left;margin-top: 5mm;"></div>
    <div class="rightcontent">
        <p>������ѧ����ѧ��ѧ��֤���������</p>
        <table class="tbl" cellspacing="0" cellpadding="0" >
            <tr>
                <td class="tblname">�� ��</td>
                <td class="tblval "><span class="user_input">${studentName}</span></td>
                <td class="tblname">ѧ ��</td>
                <td class="tblval "><span class="user_input">${studentID}</span></td>
                <td class="tblname">�� ��</td>
                <td class="tblval "><span class="user_input">${studentGenger}</span></td>
            </tr>
            <tr>
                <td class="tblname">ѧ Ժ</td>
                <td class="tblval "><span class="user_input college_"></span>${collegeName}</td>
                <td class="tblname">ר ҵ<br/>�� ��</td>
                <td class="tblval "><span class="user_input class_name"></span>${className}</td>
                <td class="tblname">�� ��<br/>�� ��</td>
                <td class="tblval "><span class="user_input">${money}</span></td>
            </tr>
            <tr>
                <td class="tblname">�� ͥ<br/>�� ַ</td>
                <td colspan="3">
                    <table class="tbl2" cellspacing="0" cellpadding="0">
                        <tr>
                            <td class="tbl2val " style="border: 0;"><span class="user_input home_addr">${homeAddress}</span></td>
                            <td class="tbl2name" style="border-right: 0;border-bottom:0 ;border-top: 0">�� ��<br/>�� ��</td>
                        </tr>
                    </table>
                </td>
                <td class="tblval" colspan="2"><span class="space_"></span>����<img class="qujian_img" src="qujian.png"/>${stationName}</td>
            </tr>
            <tr>
                <td class="tblname2">��<br />��<br />ԭ<br />��</td>
                <td colspan="5" class="tblval">
                    <div style="height: 80px; width: 100%;margin-left: 10px;overflow: hidden" >${reason}</div>
                    <div style="float: right;width: 300px">
                        ����ʱ��:<span class="date date_box yyyy">${yyyy}</span>��<span class="date date_box">${mm}</span>��<span class="date date_box">${dd}</span>��
                        <br />
                        <br />
                        ����ǩ�֣�
                    </div>
                </td>
            </tr>
            <tr>
                <td class="tblname2" >ѧ<br/>Ժ<br/>��<br/>��</td>
                <td colspan="3">
                    <table class="tbl2" cellspacing="0" cellpadding="0">
                        <tr>
                            <td class="tbl2val" style="border-left: 0;border-top: 0;border-bottom: 0">
                                <div style="height: 10px; width: 100%;"></div>
                                <div style="float: left; height: 120px; line-height: 40px;">
                                    <span class="space_"></span>����Աǩ�֣�<br/>
                                    <p style="padding-left: 50px;">��ѧ�칫�£�</p>
                                    <p style="padding-left: 80px;"><span class="date"></span>��<span class="date"></span>��<span class="date"></span>��</p>
                                </div>
                            </td>
                            <td class="tbl2name" style="border-right: 0;border-top: 0;border-bottom: 0">ѧ<br/>У<br/>��<br/>��</td>
                        </tr>
                    </table>
                </td>
                <td class="tblval" colspan="2"></td>
            </tr>
        </table>
        <div class="note">
            <p>ע��1. �������ֽ��ʽѧ��֤����Ʊ�Żݿ��Ĳ��졣<br/>
                <span class="space_X"></span>2. ����ʱ��Ϊÿ�³�ǰ���������ա�<br/>
                <span class="space_X"></span>3. ѧ��֤�ϳ˳�����һ����д��ԭ���ϲ����޸ģ�<br/><span class="space_XX"></span>�����޸ģ��뿪�����֤����
            </p>
        </div>
    </div>
    <div style="clear: both;"></div>
    <div style="margin-top: 10px; text-align: center; color: #666666; font-size: 14px;">�˱�������� <img src="cutImg.png"/> �˱�ѧ��������</div>
</div>
</body>
</html>