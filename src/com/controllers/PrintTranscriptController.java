package com.controllers;

import com.Services.interfaces.Print_transcriptService;
import com.Services.interfaces.SixDetailService;
import com.Services.interfaces.SupplementApplyService;
import com.common.utils.SpringUtils;
import com.dao.interfaces.NoactivityApplyDao;
import com.model.DataForDatagrid;
import com.model.ResultData;
import com.supermapping.jdbcfactories.JdbcFactory;
import com.utils.PwdUtil;
import com.utils.Utils;
import org.apache.commons.collections.comparators.ComparableComparator;
import org.apache.commons.collections.list.LazyList;
import org.apache.commons.collections.map.HashedMap;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.sql.*;
import java.text.DecimalFormat;
import java.text.SimpleDateFormat;
import java.util.*;
import java.util.Date;

import static java.lang.Integer.parseInt;

/**
 * 打印成绩单.计算成绩
 * @author hong
 * Created by admin on 2016/8/25.
 */
@Controller
@RequestMapping("/printTranscript")
@Scope("prototype")
public class PrintTranscriptController {
    @Autowired
    private Print_transcriptService print_transcriptService;
    @Autowired
    private SupplementApplyService supplementApplyService;
    @Autowired
    private SixDetailService sixDetailService;
    /**
     *
     *
     * 计算6项能力得分，各个活动、奖项、活动级别的得分增加一倍，基础分还是50
     *
     *   2017.01.10 日修改
     *
     */
    /**
     * 基础分数
     */
    private final static double BASE_POINT=50.0;
    /**
     * 国际级和 国家级比赛分数
     */
    private final static double LEVEL_COUNTRY=10.0;
    /**
     * 省级比赛分数
     */
    private final static double LEVEL_PROVINCE=8.0;
    /**
     * 市级比赛分数
     */
    private final static double LEVEL_CITY=6.0;
    /**
     * 校级比赛分数
     */
    private final static double LEVEL_SCHOOL=4.0;
    /**
     * 院级比赛分数
     */
    private final static double LEVEL_COLLEGE=2.0;
    /**
     * 团支部级比赛分数
     */
    private final static double LEVEL_DEPT=1;
    /**
     * 比赛获奖一等奖加分
     */
    private final static double AWARD_1ST=6.0;
    /**
     * 比赛获奖二等奖加分
     */
    private final static double AWARD_2ND=4.0;
    /**
     * 比赛获奖三等奖加分
     */
    private final static double AWARD_3RD=2.0;
    /**
     * 讲座类活动分数
     */
    private final static double NATURE_CHAIR=0.5;
    /**
     * 讲座类活动每学期可积分的次数，目前为4次
     */
    private final static int CHAIR_TIMES=32;

    //    任职主席加分
    private final static int BE_PRESIDENT=7;
    //    任职副主席加分
    private final static int BE_VICE_PRESIDENT=6;
    //    任职部长加分
    private final static int BE_MINISTER=5;
    //    任职副部长加分
    private final static int BE_VICE_MINISTER=4;
    //    任职主任加分
    private final static int BE_DIRECTOR=7;
    //    任职副主任加分
    private final static int BE_VICE_DIRECTOR=6;
    //    任职负责人加分
    private final static int BE_INCHARGE=3;
    //    任职成员加分
    private final static int BE_MEMBER=2;
    //    任职党支书加分
    private final static int PARTY_LEADER=5;
    //    任职党支部组织委员加分
    private final static int PARTY_ORGANIZE=3;
    //    任职党支部宣传委员加分
    private final static int PARTY_PROPAGATE=3;
    //    任职党支部体育委员加分
    private final static int PARTY_SPORTS=2;
    //    任职党支部文艺委员加分
    private final static int PARTY_ART=2;
    //    任职党支部生活委员加分
    private final static int PARTY_LIVING=2;
    //    任职党支部心里委员加分
    private final static int PARTY_PSYCHOLOGY=2;
    //    任团支书加分
    private final static int GROUP_LEADER=5;
    //    任职组织委员加分
    private final static int GROUP_ORGANIZE=3;
    //    任职宣传委员加分
    private final static int GROUP_PROPAGATE=3;
    //    任职班长加分
    private final static int GROUP_MONITOR=5;
    //    任职副班长加分
    private final static int GROUP_VICE_MONITOR=3;
    //    任职学习委员加分
    private final static int GROUP_STUDY=3;
    //    任职生活委员加分
    private final static int GROUP_LIVING=2;
    //    任职体育委员加分
    private final static int GROUP_SPORTS=2;
    //    任职文艺委员加分
    private final static int GROUP_ART=2;
    //    任职心里委员加分
    private final static int GROUP_PSYCHOLOGY=2;
    //给创新和创业能力默认加的分数，每一项活动都加
    private final static double ADD_POINT=0.2;
    /**
     * 六项能力得分的map
     */
    private Map<String ,Double> six_Element;

    /**
     * 六项能力得分的详细情况，记录了某项活动给某些能力标签加分的详细情况
     * 2017-02-27修改
     */
    private List<Map<String ,String >> sixDetail;
    /**
     * 加载用户打印预览中的
     * @param studentid
     * @param request
     * @return
     */
    @RequestMapping("/loadPrintPreview")
    @ResponseBody
    public ResultData loadPrintPreviewApplyActivities(String studentid,String printid,HttpServletRequest request){
        ResultData re=new ResultData();
        if(studentid==null || studentid.equals("")){
            studentid= (String) request.getSession().getAttribute("studentid");
        }
        if(printid==null || printid.equals("")){
            printid= (String) request.getSession().getAttribute("printId");
        }
        if(studentid==null || studentid.equals("")){
            re.sets(1,"获取用户登陆信息失败，请重新登陆！");
            return re;
        }
        List<Map<String ,String >> list=print_transcriptService.loadApplyActivitiesByStudentId(studentid,printid);
       // System.out.println(list);
        list=getSupplement(printid,list);
        for (Map<String,String> map:list){
            String applyDate= map.get("applyDate");
            String nian=applyDate.substring(0,4);
            String xueqi=applyDate.substring(5,7);
            int year=parseInt(nian);
            int mouth= parseInt(xueqi);
            if(mouth>=3&&mouth<9){
                xueqi="年上学期";
                year=year;
            }else if(mouth<3&&mouth>=1) {
                xueqi="年下学期";
                year=year-1;
            }else if(mouth>=9&&mouth<=12){
                xueqi="年下学期";
                year=year;
            }
            map.put("applyDate",year+xueqi);
        }
      //  System.out.println(list);
        re.setData(list);
        return re;
    }

    /**
     *
     *查看该学生有没有补充活动
     *
     * @param printid
     * @param list
     * @return
     */
    public List<Map<String,String>> getSupplement(String printid, List<Map<String,String>> list){
        List<Map<String,String>> suplist=new ArrayList<>();
        if(printid!=null&&!printid.equals("")){
            suplist=getSupplementByprintid(printid);
        }
        for(Map<String,String> map:suplist){
            if(map.get("shipName")!=null&&!map.get("shipName").equals("")){
                map.put("activityClass",map.get("supClass"));
                map.put("activityLevle",map.get("shipType"));
                map.put("activityCredit",map.get("supCredit"));
                map.put("activityTitle",map.get("shipName"));
                map.put("activityAward",map.get("supAward"));
                map.put("collegeAuditStatus",map.get("collegeAuditStatus"));
                map.put("schoolAuditStaus",map.get("schoolAuditStaus"));
            }
            if(map.get("scienceName")!=null&&!map.get("scienceName").equals("")){
                map.put("activityClass",map.get("supClass"));
                map.put("activityLevle",map.get("scienceClass"));
                map.put("activityCredit",map.get("supCredit"));
                map.put("activityTitle",map.get("scienceName"));
                map.put("activityAward",map.get("supAward"));
                map.put("collegeAuditStatus",map.get("collegeAuditStatus"));
                map.put("schoolAuditStaus",map.get("schoolAuditStaus"));
            }
            if(map.get("workName")!=null&&!map.get("workName").equals("")){
                map.put("activityClass",map.get("supClass"));
                map.put("activityLevle",map.get("worklevel"));
                map.put("activityCredit",map.get("supCredit"));
                map.put("activityTitle",map.get("workName"));
                map.put("activityAward",map.get("supAward"));
                map.put("collegeAuditStatus",map.get("collegeAuditStatus"));
                map.put("schoolAuditStaus",map.get("schoolAuditStaus"));
            }
            if(map.get("supActivityTitle")!=null&&!map.get("supActivityTitle").equals("")){
                map.put("activityTitle",map.get("supActivityTitle"));
                map.put("activityAward",map.get("supAward"));
                map.put("activityClass",map.get("supClass"));
                map.put("activityLevle",map.get("supLevle"));
                map.put("activityCredit",map.get("supCredit"));
                map.put("schoolAuditStaus",map.get("schoolAuditStaus"));
                map.put("collegeAuditStatus",map.get("collegeAuditStatus"));
                map.put("worktime",map.get("supWorktime"));
            }
            if("主题团日".equals(map.get("supType"))){
                map.put("supLevle","4");
            }
            list.add(map);
        }
        return  list;
    }

    /**
     * 根据打印id 取补充活动id
     * @param printid
     * @return
     */
    public List<Map<String,String>> getSupplementByprintid(String printid){
        Map<String,Object> ids=new HashMap<>();
        /**
         * 根据打印ID 取 补充活动id
         */
        List<Map<String,String>> map=supplementApplyService.getApplyIdByprintId(printid);
        List<String> list=new ArrayList<>();
        for(Map<String,String> newmap:map){
            list.add(newmap.get("applyId"));
        }
        ids.put("applyIds",list);
//        System.out.println(ids);
        /**
         * 根据补充活动id取相关信息
         */
        List<Map<String,String>> supplist= supplementApplyService.getSupplementAll(ids);
        return supplist;
    }
    /**
     * 加载学生的得分。若是之前
     * @param session
     * @return 正确执行后，msg是该学生的打印申请中关联的活动申请Id，data中是最终的六项能力的分数
     */
    @RequestMapping("/loadPoint")
    @ResponseBody
    public ResultData openPointPage(HttpSession session){
        ResultData re=new ResultData();
        six_Element=new HashMap<>(6);
        String studentId= (String) session.getAttribute("studentid");
        if(studentId==null || studentId.equals("")) {
            re.sets(1,"获取用户信息失败！");
            return re;
        }
        List<Map<String ,Object>> point=print_transcriptService.loadPointByYears(studentId);    //从数据库中取出的数据
        //若取出的得分数据为空 则直接返回
        if(point==null || point.size()==0){
            re.setData(0);
            re.setMsg("未查询到得分数据");
            re.setStatus(1);
            return re;
        }
        //处理取出的得分数据
        Map<String,Map<String ,Double>> pointMap=new LinkedHashMap<>(); //要返回给页面的结果
        for(Map<String ,Object> item:point){
            Map<String ,Double> six_point=new HashMap<>(6);
            for(String key:item.keySet()){
                String notUseKeys="id,studentId,pointYear";             //六项能力得分表中多余的字段
                if(notUseKeys.contains(key)) continue;                  //判断key是否是六项能力的字段
                six_point.put(key,(Double)(item.get(key)==null?50:item.get(key)));  //如果某一项能力是null 则为50分
            }
            pointMap.put((String)item.get("pointYear"),six_point);
        }
        re.setData(pointMap);
        //若是添加过打印申请，则加载出来
        List<Map<String ,String >> list=print_transcriptService.loadApplies(studentId);
        if(list!=null && list.size()>0){
            StringBuilder sb=new StringBuilder();
            for(Map<String,String > m:list){
                sb.append(m.get("applyId")+"|");
            }
            String ids=sb.toString();
            re.setMsg(ids.substring(0,ids.length()-1));
        }
        return re;
    }



    /**
     * 页面用户获取自己的得分
     *          当用户选择若干项活动的申请时统计得分(这是之前的逻辑)
     * 当用户进入个人中心的时候进行分数统计（统计的分数为申请记录为校审批通过的记录）
     * @param applyid
     * @return
     */
    @RequestMapping("/countPoint")
    @ResponseBody
    public ResultData getPoint(HttpSession session, String applyid){
        six_Element=new HashMap<>(6);
        sixDetail=new ArrayList<>();
//        six_Element.put("",50.0);
        ResultData re=new ResultData();
        if(applyid==null || applyid.equals("")){
            re.sets(1,"发送给服务器的数据有误！");
            return re;
        }
        String studentId= (String) session.getAttribute("studentid");
        if(studentId==null || studentId.equals("")){
            re.sets(1,"未查询到用户登陆信息！请重新登陆");
            return re;
        }
        String[] str=applyid.split("[|]");
        List<String> idList=Arrays.asList(str);
//        System.out.println(idList.toString());
        List<Map<String ,String >> list=print_transcriptService.loadAppliesByUserid(studentId);
      //  System.out.println(list+"111111111111");
        list=getSuppment(list,idList,studentId);
       // System.out.println(list+"222222222222");
        if(list==null || list.size()<=0) {
            re.sets(1,"未查询到相关数据！");
            return re;
        }

        Map<String ,Map<String ,Double >> result=generPointByYear(list,studentId);      //计算分数
//        result=NoactivtityAddPoint(studentId,result);
        re.setData(result);     //保存分数
        // 2017/2/28  保存六项能力加分详情
        saveSixDetailList();
        return re;
    }
    /**
     *
     *把补充活动加入活动申请中
     *
     * @param idList
     * @param list
     * @return
     */
    public List<Map<String,String>> getSuppment(List<Map<String,String>> list,List<String> idList,String userid){
        Map<String,Object> ids=new HashMap<>();
        ids.put("applyIds",idList);
        List<Map<String,String>> suplist=new ArrayList<>();
//        suplist=supplementApplyService.getSupplementByIds(ids);       //原来是加载传过来的id，现在改成加载所有该学生id 的，
        suplist=supplementApplyService.getSupplementByUser(userid);
        for(Map<String,String> map:suplist){
                map.put("activityTitle",map.get("supActivityTitle"));
                map.put("activityAward",map.get("supAward"));
                map.put("activityClass",map.get("supClass"));
                map.put("activityLevle",map.get("supLevle"));
                map.put("activityCredit",map.get("supCredit"));
                map.put("activityNature",map.get("supNature"));
                map.put("activityPowers",map.get("supPowers"));
                map.put("applyDate",map.get("takeDate"));
                //自己添加的 用于区别学校活动或者学生自己添加的活动，便于后边计算得分
                map.put("activityKind","sup");
                //活动任职需要的属性
                map.put("workClass",map.get("workClass"));
                map.put("worklevel",map.get("worklevel"));
                map.put("workName",map.get("workName"));
                if("主题团日".equals(map.get("supType"))){
                    map.put("supLevle","4");
                }
                list.add(map);
        }
        list.sort(new Comparator<Map<String, String>>() {
            @Override
            public int compare(Map<String, String> o1, Map<String, String> o2) {
                Object obj1=o1.get("applyDate");
                Object obj2=o2.get("applyDate");
                Timestamp t1=null,t2=null;
                if(obj1 instanceof Timestamp){
                    t1=(Timestamp)obj1;
                }
                if(obj2 instanceof Timestamp){
                    t2=(Timestamp)obj2;
                }
                if(t1!=null && t2!=null){
                    return t1.compareTo(t2);
                }
                return 0;
            }
        });
        return  list;
    }

    /**
     * 添加到打印申请中去
     * @param request
     * @param response
     * @param applyid
     * @return
     */
    @RequestMapping("/setPrint")
    @ResponseBody
    public ResultData addToPrintQueue(HttpServletRequest request,HttpServletResponse response,String applyid,String themeapplyID){
        ResultData re=new ResultData();
        Map<String ,Object> map=new HashMap<>();
        if(applyid==null || applyid.equals("")){
            re.sets(1,"发送给服务器的数据有误！");
            return re;
        }
        if(themeapplyID!=null&&!"".equals(themeapplyID)){
            applyid=applyid+"|"+themeapplyID;
        }
        String[] str=applyid.split("[|]");
        List<String> idList=Arrays.asList(str);
//        System.out.println(idList.toString());
        String printId= (String) request.getSession().getAttribute("printId");
        String studentId= (String)request.getSession().getAttribute("studentid");
        String printAuditstatus=(String)request.getSession().getAttribute("printAuditstatus");
        String printStatus=(String)request.getSession().getAttribute("printStatus");
        if(printId==null || printId.equals("")){
//                SimpleDateFormat df = new SimpleDateFormat("yyyyMMdd");
                long time=System.currentTimeMillis();
                printId = String.valueOf(time+new Random().nextInt(1000));
                //如果没有打印ID 同步打印信息到print表中
                int i= print_transcriptService.addPrint(printId,studentId);
                if(i<0){
                    re.sets(1,"发送给服务器的数据有误！");
                }
        }
        request.getSession().setAttribute("printId",printId);
//        //System.out.println("测试                  "+printAuditstatus+printStatus);
//        if(printStatus!=null&&!printStatus.equals("")&&!printStatus.equals("待打印")||printAuditstatus!=null&&!printAuditstatus.equals("")&&!printAuditstatus.equals("待审核")){
////               SimpleDateFormat df = new SimpleDateFormat("yyyyMMdd");
//               long time=System.currentTimeMillis();
//               printId = String.valueOf(time+new Random().nextInt(1000));
//               request.getSession().setAttribute("printId",printId);
//               //如果如果审核状态 打印状态不为空  新建打印信息到print表中
//               int i= print_transcriptService.addPrint(printId,studentId);
//               if(i<0){
//                   re.sets(1,"发送给服务器的数据有误！");
//              }
//        }
        map.put("printId",printId);
        map.put("applyIds",idList);
        re=print_transcriptService.changePrintApplies(map);
        return re;
    }

    /**
     * 初始化加载申请打印过的活动
     * @param request
     * @return
     */
    @RequestMapping("/loadPrintActivity")
    @ResponseBody
    public DataForDatagrid loadPrintActivity(HttpServletRequest request){
        String studentId= (String)request.getSession().getAttribute("studentid");
        String printAuditstatus=(String)request.getSession().getAttribute("printAuditstatus");
        String printStatus=(String)request.getSession().getAttribute("printStatus");
//        System.out.println(printAuditstatus+"!!!!!!!"+printStatus);
        Map<String,String> map=new HashedMap();
        DataForDatagrid data=new DataForDatagrid();
        List<Map<String,String>> list=new ArrayList<>();
        if(studentId!=null&&studentId!=""){
            if(printAuditstatus==null||("").equals(printAuditstatus)&&printStatus==null||("").equals(printStatus)){
                list=print_transcriptService.loadActivityByStudentId(studentId);
          //    System.out.println(list.toString());
                map.put("msg","");
                list.add(map);
            }else{
                map.put("msg","打印成绩单审核结果为:"+printAuditstatus+"   打印状态为:"+printStatus);
                list.add(map);
            }
        }else {
            map.put("msg","请重新登录");
            list.add(map);
        }
        data.setDatas(list);
        return data;
    }

    /**
     * 按年份统计，并返回每年的分数结果
     * @param list
     * @return
     */
    private Map<String ,Map<String ,Double >> generPointByYear(List<Map<String,String >> list,String studentId){
        Map<String ,Map<String ,Double >> result=new LinkedHashMap<>();    //返回的结果
        SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd");
        Calendar calendar=Calendar.getInstance();
        calendar.set(Calendar.MONTH,2);
        calendar.set(Calendar.DAY_OF_MONTH,1);
        calendar.set(Calendar.HOUR_OF_DAY,0);
        Object tempObj=list.get(0).get("applyDate");             //list中的数据已按照申请日期排序,这是获取第一条的申请日期，也就是起始的日期
        Object lastObj=list.get(list.size()-1).get("applyDate");    //list中的数据已按照申请日期排序,这是获取最后一条的申请日期，也就是结束的日期
        String  start="",end="";
        if(tempObj!=null && tempObj instanceof Timestamp)
            start=sdf.format(tempObj);
        if(lastObj!=null && lastObj instanceof Timestamp)
            end=sdf.format(lastObj);
        int year_Start=start==null||start.equals("")?0:Integer.parseInt(start.split("[-]")[0]);
        int year_End=end==null||start.equals("")?0:Integer.parseInt(end.split("[-]")[0]);
        do{
            List<Map<String,String >> temp=new ArrayList<>();       //临时的list,存放每年的申请
            calendar.set(Calendar.YEAR,year_Start);
            Date sdate=calendar.getTime();
            calendar.set(Calendar.YEAR,year_Start+1);
            Date edate=calendar.getTime();
            for(Map<String,String > m:list){
                Object date=m.get("applyDate");
                Date applyDate=null;
                if(date!=null && date instanceof Timestamp)
                    applyDate=(Date)date;
                if(applyDate==null)
                    continue;
                if(applyDate.compareTo(sdate)>=0 && applyDate.compareTo(edate)<0 ){
                    temp.add(m);
                }
            }
            generatePoint(temp);
            Set<String > keys= six_Element.keySet();
            Map<String ,Double> point=new HashMap<>(6);
            for(String s:keys){
                double value=six_Element.get(s);
                point.put(s, Math.ceil(value));
            }
            //如果没有获得此项技能 默认值是50.00
            Double va=point.get("sibian");
            if(va==null) point.put("sibian",50.00);
            va=point.get("zhixing");
            if(va==null) point.put("zhixing",50.00);
            va=point.get("biaoda");
            if(va==null) point.put("biaoda",50.00);
            va=point.get("lingdao");
            if(va==null) point.put("lingdao",50.00);
            va=point.get("chuangxin");
            if(va==null) point.put("chuangxin",50.00);
            va=point.get("chuangye");
            if(va==null) point.put("chuangye",50.00);
            result.put(""+year_Start,point);
            year_Start++;
        }while (year_Start<=year_End);
//        //保存到数据库");
        //System.out.println(result);
       int i= print_transcriptService.addPoint(result,studentId);
    //    System.out.println("数据库添加分数列表："+i);
        return result;
    }

    /**
     * 计算第二课堂分数的主口
     * 生成6项能力的分数
     * @param list 从数据库中取出的包含活动、活动申请的信息
     * @return
     */
    private void generatePoint(List<Map<String,String >> list){
        List<Map<String ,String >> chairList=new ArrayList<>();
        int i = 0;
        for(Map<String ,String > map:list){
            String activityKind=map.get("activityKind")==null?"":map.get("activityKind");
            String activityClass="sup".equals(activityKind) ? map.get("supClass") : map.get("activityClass");
            String nature="sup".equals(activityKind) ? map.get("supNature") : map.get("activityNature");
            i++;
            if(activityKind.equals("sup") && activityClass == null ){
                continue;
            }
            if(activityKind.equals("") &&  nature == null ){
               continue;
            }

            //补充活动
            if(activityKind.equals("sup")){
                switch (activityClass){
                    case "5":  //社会工作与技能培训类 (任职加分)  后边可以添加其它的类别算分
                        jobCount(map);
                        continue;
                    case "1":
                        if(map.get("supLevel")==null || "".equals(map.get("supLevel"))){
                            map.put("supLevel","4");
                        }
                        competitionCount(map);
                        continue;
                    case "3":
                        String supType = map.get("supType");
                        if(supType!=null && supType.equals("非活动类")){
                            // 非活动类（论文、专利、著作等）的计算方法
                            doScienceClassCount(map);
                            continue;
                        }
                        competitionCount(map);
                        break;
                    case "6":
                        doShipType(map);
                        continue;
                    default:
                        competitionCount(map);
                }
            }
            if(activityKind.equals("")) {
                switch (nature) {
                    case "2":          //如果是讲座的处理
                        chairList.add(map);
                        break;
                    case "1":       //活动参与
                    case "4":       //培训
                    case "3":       //如果是比赛的处理方法
                    default:
                        competitionCount(map);
                }
            }
        }
        //统计讲座的得分的方法
        chairCount(chairList);
    }

    /**
     * 比赛类活动分数计算
     * 其它类型的活动也在这里计算，逻辑和比赛类的活动一样   --2017-02-27修改
     * @param map
     */
    private void competitionCount(Map<String ,String > map){
        String isSup=map.get("activityKind")==null?"":map.get("activityKind");  //是活动表还是学生自己添加的数据
        String actId="sup".equals(isSup) ? map.get("id") : map.get("applyId");
        String studentId="sup".equals(isSup) ? map.get("supStudentId") : map.get("applyStudentId");
        String activityLevle="sup".equals(isSup) ? map.get("supLevle") : map.get("activityLevle");
        String activityPowers="sup".equals(isSup) ? map.get("supPowers") : map.get("activityPowers");
        String activityAward="sup".equals(isSup) ? map.get("supAward") : map.get("activityAward");
        double totalPoint=0;
        if(activityLevle!=null && !activityLevle.equals("")){
            switch (activityLevle){
                case "0":
                case "1":
                    totalPoint+=LEVEL_COUNTRY;
                    break;
                case "2":
                    totalPoint+=LEVEL_PROVINCE;
                    break;
                case "3":
                    totalPoint+=LEVEL_CITY;
                    break;
                case "4":
                    totalPoint+=LEVEL_SCHOOL;
                    break;
                case "5":
                    totalPoint+=LEVEL_COLLEGE;
                    break;
                case "6":
                    totalPoint+=LEVEL_DEPT;
                default:
                        totalPoint+=0;

            }
        }
        if(activityAward==null) activityAward="";
        switch (activityAward){
            case "一等奖":
            case "金奖":
            case "第一名":
                totalPoint+=AWARD_1ST;
                break;
            case "二等奖":
            case "银奖":
            case "第二名":
                totalPoint+=AWARD_2ND;
                break;
            case "三等奖":
            case "铜奖":
            case "第三名":
                totalPoint+=AWARD_3RD;
                break;
            default:
                totalPoint+=0;
        }
        //替换成上面的switch 语句了
//        if(activityAward!=null && !activityAward.equals("")){
//            if(activityAward.equals("一等奖") || activityAward.equals("金奖") || activityAward.equals("第一名"))
//                totalPoint+=AWARD_1ST;
//            else if(activityAward.equals("二等奖"))
//                totalPoint+=AWARD_2ND;
//            else if(activityAward.equals("三等奖"))
//                totalPoint+=AWARD_3RD;
//        }
        cutPoint(totalPoint,activityPowers,actId,studentId);
    }

    /**
     * 类别是3 的
     * 非活动类（论文、专利、著作等）的计算方法
     * @param map
     */
    private void doScienceClassCount(Map<String ,String > map){
        String act=map.get("scienceClass");
        switch (act){
            case "论文":
            case "专利":
            case "著作":
                cutPoint(LEVEL_SCHOOL,"创新能力",map.get("id"),map.get("supStudentId"));        //默认加校级分数
                break;
            case "参与创业项目":
            case "组建/参与创业公司":
                cutPoint(LEVEL_SCHOOL,"创业能力",map.get("id"),map.get("supStudentId"));        //默认加校级分数
                break;
        }
    }

    /**
     * 奖学金及称号的处理
     * 类别是6的
     * @param map
     */
    private void doShipType(Map<String ,String > map){
        cutPoint(LEVEL_SCHOOL,"思辨能力",map.get("id"),map.get("supStudentId"));
    }

    /**
     * 讲座类活动分数计算
     * @param list
     */
    private void chairCount(List<Map<String,String>> list){
        Map<String ,List<Map<String,String>>> map=new HashMap<>();
        //把传递进来的list按照学期进行分类。然后再进行分数统计
        // 分类的方法是  通过申请的时间的年份和月份来判断是哪个学期的，然后放放Map中。
        for(Map<String,String> m:list){
            Object date=m.get("applyDate");
            String datestr="";
            if(date!=null && date instanceof Timestamp){
                datestr=new SimpleDateFormat("yyyy-MM-dd").format(date);
            }
            if( datestr.equals("")) continue;
            String[] datespan=datestr.split("[-]");
            if(datespan.length<3) continue;
            int yyyy=Integer.parseInt(datespan[0]);
            int mon=Integer.parseInt(datespan[1]);
            String keystr="";
            if(mon>=3 && mon<9) //如果月份是3-9之间的，则为本年1学期
                keystr=""+yyyy+1;
            else if(mon<3)      //如果月份是1月2月，则为上一前的2学期
                keystr=""+(yyyy-1)+2;
            else if(mon>=9)      //如果月份是9月以后的，则为本年2学期
                keystr=""+yyyy+2;
            List<Map<String,String>> listInMap=map.get(keystr);
            if(listInMap==null || listInMap.size()==0)
                listInMap=new ArrayList<>();
            listInMap.add(m);
            map.put(keystr,listInMap);
        }
        Set<String > keys=map.keySet();
        for(String key:keys){
            List<Map<String,String>> listInMap=map.get(key);
            //i<4是因为讲座类的活动计分只能每学期4次有积分  次数换成常量，方便修改
            //如果list的数量大于或等于4次，则只需要循环4次就够了
            int count= listInMap.size()<CHAIR_TIMES?listInMap.size():CHAIR_TIMES;
            for(int i=0;i<count;i++){
                Map<String,String> m=listInMap.get(i);
                String isSup=m.get("activityKind")==null?"":m.get("activityKind");  //是活动表还是学生自己添加的数据
                String actId="sup".equals(isSup) ? m.get("id") : m.get("applyId");
                String studentId="sup".equals(isSup) ? m.get("supStudentId") : m.get("applyStudentId");
                cutPoint(NATURE_CHAIR,m.get("activityPowers"),actId,studentId);
            }
        }
    }
    /**
     * 任职分数计算
     * @param map
     */
    private void jobCount(Map<String ,String > map){
        String workClass=map.get("workClass");
        String worklevel=map.get("worklevel");
        String workName=map.get("workName");
        String actId=map.get("id");
        String studentId= map.get("supStudentId");
        String activityPowers=map.get("activityPowers");
        double totalPoint=0;
        if(worklevel!=null && !worklevel.equals("")){
            switch (worklevel){
                case "主席":
                    totalPoint+=BE_PRESIDENT;
                    break;
                case "副主席":
                    totalPoint+=BE_VICE_PRESIDENT;
                    break;
                case "主任":
                    totalPoint+=BE_DIRECTOR;
                    break;
                case "副主任":
                    totalPoint+=BE_VICE_DIRECTOR;
                    break;
                case "负责人":
                    totalPoint+=BE_INCHARGE;
                    break;
                case "部长":
                    totalPoint+=BE_MINISTER;
                    break;
                case "副部长":
                    totalPoint+=BE_VICE_MINISTER;
                    break;
                case "成员":
                    totalPoint+=BE_MEMBER;
                    break;
            }
        }else {
            switch (workName){
                case "党支书":
                    totalPoint+=PARTY_LEADER;
                    break;
                case "党支部组织委员":
                    totalPoint+=PARTY_ORGANIZE;
                    break;
                case "党支部宣传委员":
                    totalPoint+=PARTY_PROPAGATE;
                    break;
                case "党支部体育委员":
                    totalPoint+=PARTY_SPORTS;
                    break;
                case "党支部文艺委员":
                    totalPoint+=PARTY_ART;
                    break;
                case "党支部生活委员":
                    totalPoint+=PARTY_LIVING;
                    break;
                case "党支部心理委员":
                    totalPoint+=PARTY_PSYCHOLOGY;
                    break;
                case "团支书":
                    totalPoint+=GROUP_LEADER;
                    break;
                case "组织委员":
                    totalPoint+=GROUP_ORGANIZE;
                    break;
                case "宣传委员":
                    totalPoint+=GROUP_PROPAGATE;
                    break;
                case "班长":
                    totalPoint+=GROUP_MONITOR;
                    break;
                case "副班长":
                    totalPoint+=GROUP_VICE_MONITOR;
                    break;
                case "学习委员":
                    totalPoint+=GROUP_STUDY;
                    break;
                case "文艺委员":
                    totalPoint+=GROUP_ART;
                    break;
                case "生活委员":
                    totalPoint+=GROUP_LIVING;
                    break;
                case "体育委员":
                    totalPoint+=GROUP_SPORTS;
                    break;
                case "心理委员":
                    totalPoint+=GROUP_PSYCHOLOGY;
                    break;
                default:
                    totalPoint+=1;  //没有匹配的 给加一分
            }
        }
        if(activityPowers==null||activityPowers.equals("")) activityPowers="领导能力";
        cutPoint(totalPoint,activityPowers,actId,studentId);
    }

    /**
     * 把统计出来的分数分散加到各个能力上
     * @param totalPoint 分数
     * @param activityPowers    该项目
     */
    private void cutPoint(double totalPoint,String activityPowers,String actId,String studentId){
        if(activityPowers!=null && !activityPowers.equals("")){
            String[] powers=activityPowers.split("[|]");
            Map<String ,String > eleDetails=new HashedMap(10);  //六项能力得分的详细情况
            eleDetails.put("biaoda","");        //初始化map，防止没有数据的时候在存放数据的过程中出错
            eleDetails.put("zhixing","");
            eleDetails.put("sibian","");
            eleDetails.put("lingdao","");
            eleDetails.put("chuangxin","");
            eleDetails.put("chuangye","");
            double per=totalPoint/powers.length;
            for (String s:powers){
                switch (s){
                    case "表达能力":
                        s="biaoda";
                        break;
                    case "执行能力":
                        s="zhixing";
                        break;
                    case "思辩能力":
                    case "思辨能力":
                        s="sibian";
                        break;
                    case "领导能力":
                        s="lingdao";
                        break;
                    case "创新能力":
                        s="chuangxin";
                        break;
                    case "创业能力":
                        s="chuangye";
                        break;
                }
                Double point=six_Element.get(s);
                if(point==null)
                    six_Element.put(s,BASE_POINT+per);
                else
                    six_Element.put(s,point+per);
                DecimalFormat format=new DecimalFormat("0.0");
                eleDetails.put(s,format.format(per));       //加份详情中的字段
            }
            eleDetails.put("totalPoint",""+totalPoint);
            eleDetails.put("studentId",studentId);
            eleDetails.put("sixId",actId);
            sixDetail.add(eleDetails);  //将生成好的详情信息放到全局的List里。 最后统一存入数据库中。
        }
        //给创新能力额外加分
        Double point=six_Element.get("chuangxin");
        if(point==null)
            six_Element.put("chuangxin",BASE_POINT+ADD_POINT);
        else
            six_Element.put("chuangxin",point+ADD_POINT);
        //给创业能力额外加分
        point=six_Element.get("chuangye");
        if(point==null)
            six_Element.put("chuangye",BASE_POINT+ADD_POINT);
        else
            six_Element.put("chuangye",point+ADD_POINT);
    }

    /***
     * 存储到临时存储顺序表
     * @param applyID
     * @param request
     * @return
     */
    @RequestMapping("/insetToSort")
    @ResponseBody
    public ResultData insetToSort(String applyID, HttpServletRequest request){
        ResultData re=new ResultData();
        if(applyID==null||applyID==""){
            return null;
        }
        String studentId= (String)request.getSession().getAttribute("studentid");
        int n = print_transcriptService.deleteStudentName(studentId);
        applyID.substring(0,applyID.length()-1);
        String arr[] = applyID.split("[|]");
        List<Map<String,Object>> list  = new ArrayList<>();
        int v = arr.length;
        String varr[] = new String[v];
        for(int m =0 ;m<v;m++){
            varr[m]=m+"";
        }
        Map<String,Object> map = new HashMap<>();
        for(int i = 0 ;i<v;i++){
            Map<String,Object>map2 = new HashMap<>();
            map2.put("applyID",arr[i]);
            map2.put("orderId",varr[i]);

            list.add(map2);
        }

        map.put("applyIDs",list );
        map.put("studentId",studentId);
        int m  =  print_transcriptService.insetToSort(map);
        re.setStatusByDBResult(m);
        return re;
    }

    /**
     * 将 六项能力的加分详细情况保存到数据库中，还需要先清空该学生之前的加分详情
     *
     */
    private void saveSixDetailList(){
        if(sixDetail!=null && sixDetail.size()>0){
            System.out.println("数量:"+sixDetail.size());
            String stuId=sixDetail.get(0).get("studentId");
            int i_del=sixDetailService.deleteDetailByStudentId(stuId);
            int i_save=sixDetailService.saveDetailList(sixDetail);
            System.out.println("删除:"+i_del);
            System.out.println("保存:"+i_save);
        }
        // TODO: 2017/2/28 保存了之后的学生学号是空  需要查找一下原因
    }
}
