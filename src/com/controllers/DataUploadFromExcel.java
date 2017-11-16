package com.controllers;

import com.Services.interfaces.*;
import com.model.*;
import com.utils.PwdUtil;
import org.apache.commons.collections.map.HashedMap;
import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.FileItemFactory;
import org.apache.commons.fileupload.FileUploadException;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;
import org.apache.commons.lang.ArrayUtils;
import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.InputStream;
import java.io.UnsupportedEncodingException;
import java.lang.reflect.Method;
import java.security.NoSuchAlgorithmException;
import java.sql.Timestamp;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.*;
import java.util.Map.Entry;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import static com.utils.ExcelUtil.getCellStringValue;

/**
 * 上传excel文件，批量导入数据库的controller
 * @author hong
 * Created by admin on 2016/7/14.
 */
@Transactional
@Controller
@RequestMapping("/dataupload")
@Scope("prototype")
public class DataUploadFromExcel {
    @Autowired
    private StudentService studentService;
    @Autowired
    private MemberService memberService;
    @Autowired
    private ActivityapplyService activityapplyService;
    @Autowired
    private Apply_activitiesService apply_activitiesService;
    @Autowired
    private NoactivityApplyService noactivityApplyService;
    @Autowired
    private ScholarshipService scholarshipService;
    @Autowired
    private OrganizationService organizationService;
    @Autowired
    private SupplementApplyService supplementApplyService;

    /**
     * 文件最大值
     */
//    private long maxSize = 10*1024*1024;
    /**
     * 表格的名字，区分是哪些数据
     */
    private String tableName="";
    /**
     * 数据总行数
     */
    private int totalrows=0;
    /**
     * 成功保存的数据行数
     */
    private int saveRows=0;
    /**
     * 批量保存数据库的批次
     */
    private final int batch=2000;
    /**
     *活动申请导入 补充或覆盖的标志位
     */
    private String status="";
    /**
     * 活动id
     */
    private String activityId="";

    /**
     * 上传学生信息表
     * @param request
     * @param response
     * @return
     */
    @RequestMapping("/studentinfo")
    @ResponseBody
    public ResultData exec(HttpServletRequest request, HttpServletResponse response,String activityid,String sta) {
        long start=System.currentTimeMillis();
        ResultData resultData ;
        response.reset();
        response.setCharacterEncoding("UTF-8");
        response.setContentType("text/html");
        activityId=activityid;
        if(sta==null){
            sta="";
        }
        status=sta;
        //从请求中加载文件
        resultData=getFileFromRequest(request);
        if(resultData.getStatus()!=0)return resultData;
        FileItem item= (FileItem) resultData.getData();
        try {
            //交给excel处理程序 将表格中的数据转换成map的集合，每个map就是一行记录
            List<Map<String ,String >> list=excelProcess(item.getInputStream());
            if(activityid!=null && !activityid.equals("")){
                for(Map<String ,String > map:list){
                    map.put("applyActivityId",activityid);
                }
            }


            //把转换完成的数据交给数据存储处理函数
            List<String > error_list=saveStudentData(list);
            resultData.setData(error_list);
        } catch (IOException e) {
            e.printStackTrace();
            resultData.sets(-1, e.getMessage());
            return resultData;
        }catch (ParseException e){
            e.printStackTrace();
            resultData.sets(-1, e.getMessage());
            return resultData;
        }
        long times=System.currentTimeMillis()-start;
        resultData.setMsg("共计"+totalrows+"行数据，成功保存"+saveRows+"行，用时："+times+"ms");
        saveRows=0;
        return resultData;
    }

    /**
     * 验证上传文件的数据合不合格(主要是重复性检测)
     * @param request
     * @param response
     * @return
     */
    @RequestMapping("/validdata")
    @ResponseBody
    public ResultData validUploadFile(HttpServletRequest request,HttpServletResponse response){
        long start=System.currentTimeMillis();
        ResultData resultData ;
        response.reset();
        response.setCharacterEncoding("UTF-8");
        response.setContentType("text/html");
        resultData=getFileFromRequest(request);
        if(resultData.getStatus()!=0) return resultData;
        FileItem item= (FileItem) resultData.getData();
        //取出文件后把data清空，否则有可能会被返回给客户端，从而导致报错
        resultData.setData(null);
        //交给excel处理程序 将表格中的数据转换成map的集合，每个map就是一行记录
        List<Map<String ,String >> list= null;
        try {
            list = excelProcess(item.getInputStream());
//            System.out.println("从表格中取出数据完成");
        } catch (IOException e) {
            e.printStackTrace();
            resultData.sets(-1,e.getMessage().substring(2001));
            return resultData;
        }
        //验证excel文件中数据的完整及唯一性
        List<ResultData> resultlist=uqValid(list);
//        System.out.println("验证excel文件中数据的完整及唯一性完成");
        if(resultlist.size()>0){
            resultData.sets(1,"文件中有错误");
            resultData.setData(resultlist);
            return resultData;
        }
        //验证数据是否和数据库中的数据有重复
        if(tableName!=null && tableName.contains("students")){
            resultData=primaryKeyValid(list);
            if(resultData.getStatus()!=0) return resultData;
        }
        long times=System.currentTimeMillis()-start;
        resultData.setMsg("文件检测完成，共计"+totalrows+"行数据，用时："+times+"ms");
        return resultData;
    }

    /**
     * 验证上传文件的数据合不合格(主要是重复性检测)
     * @param request
     * @param response
     * @return
     */
    @RequestMapping("/validThemeActityData")
    @ResponseBody
    public ResultData validThemeActityData(HttpServletRequest request,HttpServletResponse response){
        long start=System.currentTimeMillis();
        ResultData resultData ;
        response.reset();
        response.setCharacterEncoding("UTF-8");
        response.setContentType("text/html");
        resultData=getFileFromRequest(request);
        if(resultData.getStatus()!=0) return resultData;
        FileItem item= (FileItem) resultData.getData();
        //取出文件后把data清空，否则有可能会被返回给客户端，从而导致报错
        resultData.setData(null);

        //交给excel处理程序 将表格中的数据转换成map的集合，每个map就是一行记录
        List<Map<String ,String >> list= null;
        try {
            list = excelProcess(item.getInputStream()); //取数据
        } catch (IOException e) {
            e.printStackTrace();
            resultData.sets(-1,e.getMessage().substring(2001));
            return resultData;
        }

        List<String > errorList=new ArrayList<>();
        for(int i = 0 ; i < list.size() ; i++){
            Integer rowNum = i + 1;
            Map<String,String> map = list.get(i);
            String supStudentId = map.get("supStudentId");
            String supActivityTitle = map.get("supActivityTitle");
            String supPowers = map.get("supPowers");
            String supCredit = map.get("supCredit");
            String takeDate = map.get("takeDate");

            //验证是否有空值
            if(isEmpty(supStudentId,supActivityTitle,supPowers,supCredit,takeDate)){
                errorList.add("第" + rowNum + "行有空值");
                continue;
            }

            //验证是否有数据格式错误
            Student_Decoding  studentInfo =  studentService.loadStudentInfo(supStudentId);
            if(null == studentInfo){
                errorList.add("第" + rowNum + "行，学号为" + supStudentId + "的学生不存在");
            }

            if(!isValidDate(takeDate)){
                errorList.add("第" + rowNum + "行，参与时间格式不正确");
            }

            if(!isNumeric(supCredit)){
                errorList.add("第" + rowNum + "行，学分类型不正确，必须为正整数或两位小数");
            }

            if(!isSupPowers(supPowers)){
                errorList.add("第" + rowNum + "行，增加能力：" +supPowers +" 格式不正确");
            }

        }
        resultData.setData(errorList);

        long times=System.currentTimeMillis()-start;
        resultData.setMsg("文件检测完成，共计"+totalrows+"行数据，用时："+times+"ms");
        return resultData;
    }

    /**
     * 保存主题团日数据(主要是重复性检测)
     * @param request
     * @param response
     * @return
     */
    @RequestMapping("/importThemeActityData")
    @ResponseBody
    public ResultData importThemeActityData(HttpServletRequest request,HttpServletResponse response) throws ParseException {
        long start=System.currentTimeMillis();
        ResultData resultData ;
        response.reset();
        response.setCharacterEncoding("UTF-8");
        response.setContentType("text/html");
        resultData=getFileFromRequest(request);
        if(resultData.getStatus()!=0) return resultData;
        FileItem item= (FileItem) resultData.getData();

        resultData.setData(null); //取出文件后把data清空，否则有可能会被返回给客户端，从而导致报错
        List<Map<String ,String >> list= null;
        try {
            list = excelProcess(item.getInputStream()); //取数据
        } catch (IOException e) {
            e.printStackTrace();
            resultData.sets(-1,e.getMessage().substring(2001));
            return resultData;
        }
        List<SupplementApplyEntity> supList = new ArrayList<SupplementApplyEntity>();
        List<String > errorList=new ArrayList<>();
        for(int i = 0 ; i < list.size() ; i++){
            Integer rowNum = i + 1;
            boolean addState = true;
            Map<String,String> map = list.get(i);
            String supStudentId = map.get("supStudentId");
            String supActivityTitle = map.get("supActivityTitle");
            String supPowers = map.get("supPowers");
            String supCredit = map.get("supCredit");
            String takeDate = map.get("takeDate");

            //验证是否有空值
            if(isEmpty(supStudentId,supActivityTitle,supPowers,supCredit,takeDate)){
                errorList.add("第" + rowNum + "行有空值");
                continue;
            }

            //验证是否有数据格式错误
            Student_Decoding  studentInfo =  studentService.loadStudentInfo(supStudentId);
            if(null == studentInfo){
                errorList.add("第" + rowNum + "行，学号为" + supStudentId + "的学生不存在");
                addState = false;
            }

            if(!isValidDate(takeDate)){
                errorList.add("第" + rowNum + "行，参与时间格式不正确");
                addState = false;
            }

            if(!isNumeric(supCredit)){
                errorList.add("第" + rowNum + "行，学分类型不正确，必须为正整数或两位小数");
                addState = false;
            }

            if(!isSupPowers(supPowers)){
                errorList.add("第" + rowNum + "行，增加能力：" +supPowers +" 格式不正确");
                addState = false;
            }
            if(addState){
                SupplementApplyEntity s= (SupplementApplyEntity)mapToObj(map,SupplementApplyEntity.class);
                supList.add(s);
            }

        }
        resultData.setData(errorList);

        int num = supplementApplyService.saveThemeActity(supList);
        long times=System.currentTimeMillis()-start;
        resultData.setMsg("共计"+totalrows+"行数据，成功保存"+num+"条数据，用时："+times+"ms");
        return resultData;
    }

    /**
     * 从request中加载文件
     * @param request
     * @return
     */
    public ResultData getFileFromRequest(HttpServletRequest request) {
        ResultData resultData=new ResultData();
        //检查是否上传了文件
        if (!ServletFileUpload.isMultipartContent(request)) {
            resultData.sets(1, "请选择文件");
            return resultData;
        }
        //获取文件
        FileItemFactory factory = new DiskFileItemFactory();
        ServletFileUpload upload = new ServletFileUpload(factory);
        List items = null;
        try {
            items = upload.parseRequest(request);
//            System.out.println(items.size());
        } catch (FileUploadException e) {
            e.printStackTrace();
            resultData.sets(-1, e.getMessage());
            return resultData;
        }
        Iterator itr = items.iterator();
        FileItem item=null;
        if(itr.hasNext()) {
            item = (FileItem) itr.next();
            String fileName = item.getName();
            if (!item.isFormField()) {
                tableName=fileName.substring(0,fileName.lastIndexOf("."));
                // 检查扩展名
                String fileExt = fileName.substring(fileName.lastIndexOf(".") + 1).toLowerCase();
                if (!"xls".equals(fileExt)) {
                    resultData.sets(1, "上传文件格式不正确！");
                    return resultData;
                }
//                System.out.println("上传文件检查文件完成");
            }
        }
        resultData.setData(item);
        return resultData;
    }

    /**
     * 把数据保存到数据库
     * @param list
     * @return 错误的信息
     * @throws ParseException
     */
    public List<String> saveStudentData(List<Map<String ,String >> list) throws ParseException, RuntimeException {
        //学生列表
        List<Student> students=new ArrayList<>();
        //学生家庭成员列表
        List<Member> members=new ArrayList<>();
        //活动申请集合
        List<activityapply> activityapplies=new ArrayList<>();
       //错误信息存放集合
        List<String > errorList=new ArrayList<>();
        //活动视图集合
        List<apply_activities> apply_activities=new ArrayList<>();
        //活动集合
        List<activities> activities=new ArrayList<>();
        //非活动类集合
        List<Notactivity> notactivities=new ArrayList<>();
        //奖学金model
        List<ScholarShip> scholarShips=new ArrayList<>();
        //组织model
        List<Organization> organizations=new ArrayList<>();
        //上传学生参与过的活动时验证是否有重复的数据需要的临时容器
        Map<String,String > repeatValid=new HashMap<>();
        //批量导入学生参加活动的信息，并签到，审核通过，删除原报名数据
        List<Map<String ,String >> signList=new ArrayList<>();
        int i=0;
        //如果是覆盖导入 ，先删除之前活动所有申请记录
        if((tableName.contains("activityapply") || tableName.contains("applyInfo")) && status.equals("f")){
            activityapplyService.delApplyActivity(activityId);
        }
        for(Map<String ,String > map:list){
            if(tableName.contains("students") ){
                //转换表格中的班级名字为id
                /**
                 * 2016-09-23修改： 学生表发生变动，不再需要将班级名字转换成班级ID
                 */
//                map.put("usiClassId",className.get(map.get("usiClassId")));

                //如果是大陆的设置密码为身份证号的后6位   如果不是 则为123456
                String idcard=map.get("studentIdCard");
                if(idcard.length()>=15){
                    idcard=idcard.toLowerCase();
                    idcard=idcard.substring(idcard.length()-6,idcard.length());

                }else{
                    idcard="123456";
                }
                //截取入学年份
                String entranceDate=map.get("entranceDate");
                if(entranceDate.length()>=4){
                    entranceDate=entranceDate.substring(0,4);
                }
                //学生生日只写年月的  手动补全
                String studentBirthday=map.get("studentBirthday");
                if(studentBirthday.length()<8&&studentBirthday.length()>=6){
                    // System.out.println(studentBirthday+"只写月");
                    studentBirthday=studentBirthday+(studentBirthday.endsWith("/")?"":"/")+"01";
                    // System.out.println(studentBirthday+"替换后");
                } else if(studentBirthday.length()==4){
                    //System.out.println(studentBirthday+"只写年");
                    studentBirthday=studentBirthday+(studentBirthday.endsWith("/")?"":"/")+"01/01";
                    // System.out.println(studentBirthday+"替换后");
                }else if(studentBirthday.indexOf(".")>0||studentBirthday.indexOf("。")>0){
                    studentBirthday=studentBirthday.replace(".","/").replace("。","/");
//                    System.out.println(studentBirthday+"分隔符是。替换后");
                }else if(studentBirthday.length()==8&& !studentBirthday.contains(".") && !studentBirthday.contains("/")){
                    String str=studentBirthday.substring(0,4);
                    String str1=str+"/";
                    String str2=str1+studentBirthday.substring(4,6)+"/";
                    studentBirthday=str2+studentBirthday.substring(6,8);
//                    System.out.println(studentBirthday+"没有分隔符替换后");
                }
//                if(idcard!=null && !idcard.equals("") && idcard.length()>6) {
//                    idcard=idcard.toLowerCase();
//                    idcard=idcard.substring(idcard.length()-6,idcard.length());
//                }

                try {
//                    System.out.println("|"+idcard);
                    map.put("studentPwd", PwdUtil.getPassMD5(PwdUtil.getPassMD5(idcard).toLowerCase()));
                    map.put("entranceDate", entranceDate);
                    map.put("studentBirthday", studentBirthday);
                } catch (NoSuchAlgorithmException | UnsupportedEncodingException e) {
                    e.printStackTrace();
                }
            }
            //把map转换成对象
            if(tableName.contains("students")){
                Student_Encoding s= (Student_Encoding) mapToObj(map,Student_Encoding.class);
                students.add(s);
            }else if(tableName.contains("members")){
                Member_Encoding m=(Member_Encoding) mapToObj(map, Member_Encoding.class);
                members.add(m);
            }else if(tableName.contains("activityapply")){
               activityapply s= (activityapply)mapToObj(map,activityapply.class);
                java.sql.Date d = new java.sql.Date(System.currentTimeMillis());
                s.setApplyAuditStatus("待处理");
                s.setSignUpStatus("已签到");
                s.setApplyAuditStatusDate(d);
                s.setSignUpTime(d);
                if(s.getApplyDate()==null || "".equals(s.getApplyDate())){
                    s.setApplyDate(d);
                }
                if(s.getActivityAward()==null || "".equals(s.getActivityAward())){
                    s.setActivityAward("无");
                }
                //验证ApplyStudentID 是否有效
                Student student=activityapplyService.selectStudentID(s.getApplyStudentId());
                //验证活动类别如果是 团体不允许批量上传信息
                activities Activities=activityapplyService.selectActivities(s.getApplyActivityId());
                //验证该活动 该学生是否已参加过
                activityapply Activityapply=activityapplyService.selectActivty(s.getApplyStudentId(),s.getApplyActivityId());
                if (student!=null){
                    //有结果 删除该条记录
                    if(Activityapply!=null && status.equals("b")){
                        activityapplyService.delApply(Activityapply.getApplyId());
                    }
                    activityapplies.add(s);
                }else if(status.equals("b")){
                    errorList.add("保存至数据库失败，原因：上传表格内数据错误 学生"+s.getApplyStudentId()+" 不存在");
                    return errorList;
//                   System.out.println("方法saveStudentData出现异常 保存至数据库失败，原因：上传表格内数据错误 学生"+s.getApplyStudentId()+"不存在");
                }else{
                    errorList.add("保存至数据库失败，原因：上传表格内数据错误 学生"+s.getApplyStudentId()+" 不存在");
                    throw new RuntimeException();
                }

            }else if(tableName.contains("winscholarship")){
                    ScholarShip s=(ScholarShip)mapToObj(map,ScholarShip.class);
//                System.out.println(s);
                    scholarShips.add(s);
            }else if (tableName.contains("activities")){
                String key=map.get("applyStudentId")+map.get("activityTitle");  //把学生学号和活动标题拼接做为唯一性验证的关键字
                if(repeatValid.containsKey(key))                                //如果容器中存在相同的内容，则表明有重复数据，不处理该条数据
                    continue;
                else                                                            //否则把这个关键字添加到容器中
                    map.put(key,"a");                                           //主要的目的是保存这个key ,value 不重要
                apply_activities s= (apply_activities) mapToObj(map,apply_activities.class);
                //验证ApplyStudentID 是否有效
                Student student=activityapplyService.selectStudentID(s.getApplyStudentId());
                //验证标题是否为空
                String  title=s.getActivityTitle();
                Map<String,String> m=new HashMap();//key mean  查sysdict表中value
                String string=null;
                if(student!=null&&title!=null){
                    String uuid=UUID.randomUUID().toString();
                    String actid=apply_activitiesService.selectActId(s.getActivityTitle());
                    if(actid!=null && !"".equals(actid)) uuid=actid;

                   if(activities.size() > 0){
                       for (com.model.activities activity : activities) {
                           if (s.getActivityTitle().equals(activity.getActivityTitle())) {
                               uuid = activity.getActivityId();
                           }
                       }
                   }

                    activities activities1=new activities();
                    activities1.setActivityId(uuid);
                    activities1.setActivityArea(s.getActivityArea());
                    m.put("dictkey","activityClass");
                    m.put("dictmean",s.getActivityClass());
                    string=apply_activitiesService.selectValue(m);
                    activities1.setActivityClass(string);
                    activities1.setActivityContent(s.getActivityContent());
                    activities1.setActivityCreatedate(s.getActivityCreatedate());
                    activities1.setActivityCreator(s.getActivityCreator());
                    activities1.setActivityCredit(s.getActivityCredit());
                    java.sql.Date d = new java.sql.Date(System.currentTimeMillis());
                    activities1.setActivitySdate(d);
                    activities1.setActivityEdate(d);
                    activities1.setActivityFilter(s.getActivityFilter());
                    activities1.setActivityFilterType(s.getActivityFilterType());
                    activities1.setActivityImg(s.getActivityImg());
                    m.put("dictkey","activityLevle");
                    m.put("dictmean",s.getActivityLevle());
                    string=apply_activitiesService.selectValue(m);
                    activities1.setActivityLevle(string);
                    activities1.setActivityLocation(s.getActivityLocation());
                    m.put("dictkey","activityNature");
                    m.put("dictmean",s.getActivityNature());
                    string=apply_activitiesService.selectValue(m);
                    activities1.setActivityNature(string);
                    activities1.setActivityPowers(s.getActivityPowers());
                    activities1.setActivityTitle(s.getActivityTitle());
                    activities1.setCollegeID(s.getCollegeID());
                    activities1.setDeptID(s.getDeptID());
                    activities1.setWorktime(s.getWorktime());
                    activities.add(activities1);
                    activityapply Activityapply=new activityapply();
//                    m.put("dictkey","activityAward");
//                    m.put("dictmean",s.getActivityAward());
//                    string=apply_activitiesService.selectValue(m);
                    Activityapply.setActivityAward(s.getActivityAward());
                    Activityapply.setApplyActivityId(uuid);
                    Activityapply.setApplyAuditStatus(s.getApplyAuditStatus());
                    Activityapply.setApplyDate(s.getApplyDate());
                    Activityapply.setApplyStudentId(s.getApplyStudentId());
                    Activityapply.setApplyStudentPhoto(s.getApplyStudentPhoto());
                    Activityapply.setSignUpStatus("已签到");
                    Activityapply.setSignUpTime(s.getSignUpTime());
                    Activityapply.setActivitypoint("3");
                    activityapplies.add(Activityapply);
                }else{
                    errorList.add("保存至数据库失败，原因：上传表格内数据错误 学生"+s.getApplyStudentId()+"不存在 标题不可为空");
//                    System.out.println("方法saveStudentData出现异常 保存至数据库失败，原因：上传表格内数据错误 学生"+s.getApplyStudentId()+"不存在 标题不可为空");
                }

            }else if(tableName.contains("Notactivity")){
                Notactivity  notactivity= (Notactivity) mapToObj(map,Notactivity.class);
//                System.out.println(notactivity);
                //验证ApplyStudentID 是否有效
                Student student=activityapplyService.selectStudentID(notactivity.getNotStudentId());
//                System.out.println(student);
                if (student!=null){
                    notactivities.add(notactivity);
                }else {
                    errorList.add("保存至数据库失败，原因：上传表格内数据错误 学生"+notactivity.getNotStudentId()+"不存在 非活动类别类型");
//                    System.out.println("方法saveStudentData出现异常 保存至数据库失败，原因：上传表格内数据错误 学生"+notactivity.getNotStudentId()+"不存在 非活动类别类型不可为空");
                }
            }else if(tableName.contains("organization")){
                Organization  organization= (Organization) mapToObj(map,Organization.class);
                organizations.add(organization);
            }else if(tableName!=null && tableName.contains("applyInfo")){
                signList.add(map);
            }

            i++;
            if(i%batch==0){
                try{
                    int result=0;
                    //根据文件名字的不同，调用不同的service
                    if(tableName.contains("students")){
                        result=studentService.saveStudents(students);
                    }else if(tableName.contains("members")){
                        result=memberService.saveMembers(members);
                    }else if(tableName.contains("activityapply")){
                        result=activityapplyService.saveActivityapplys(activityapplies);
                    }else if(tableName.contains("activities")){
                        String actid=apply_activitiesService.selectActId(activities.get(0).getActivityTitle());
                        if(actid==null || "".equals(actid)) {
                            result=apply_activitiesService.saveActivities(activities);
                        }else{
                            result=1;
                        }
                        if(result>0) result=activityapplyService.saveActivityapplys(activityapplies);
                    }else if(tableName.contains("Notactivity")){
                        result=noactivityApplyService.addBotactivities(notactivities);
                    }else if(tableName.contains("winscholarship")){
                        result=scholarshipService.addscholarship(scholarShips);
                    }else if(tableName.contains("organization")){
                        result=organizationService.saveorganization(organizations);
                    }else if(tableName!=null && tableName.contains("applyInfo")){
                        result=activityapplyService.addAndUpdateApplySignInfo(signList);
                    }
//                    System.out.println(result);
                    if(result<=0){
                        errorList.add("第"+(i-batch<=0?1:i-batch+1)+"行至第"+i+"行保存至数据库失败，原因：未知");
                    }else{
                        saveRows+=result;
                    }
                }catch (Exception e){
                    e.getStackTrace();
                    String msg=e.getMessage();
                    errorList.add("第"+(i-batch<=0?1:i-batch+1)+"行至第"+i+"行保存至数据库失败，原因："+e.getMessage().substring(0,msg.length()>2000?2000:msg.length()));
//                    System.out.println("第"+(i-batch<=0?1:i-batch+1)+"行至第"+i+"行保存至数据库失败，原因："+e.getMessage().substring(0,msg.length()>2000?2000:msg.length()));
                }
                students.clear();
                activityapplies.clear();
                activities.clear();
                notactivities.clear();
            }
        }
        try{
            int result=0;
            //根据文件名字的不同，调用不同的service
            if(tableName.contains("students")){
                result=studentService.saveStudents(students);
            }else if(tableName.contains("members")){
                result=memberService.saveMembers(members);
            }else if(tableName.contains("activityapply")){
                result=activityapplyService.saveActivityapplys(activityapplies);
            }else if(tableName.contains("activities")){
                for (int j = 0; j < activities.size(); j++) {
                    String actid=apply_activitiesService.selectActId(activities.get(j).getActivityTitle());
                    if(actid!=null && !"".equals(actid)) {
                        activities.remove(j);
                        j=0;
                        continue;
                    }
                    if(activities.size()==2){
                        if(activities.get(0).getActivityTitle().equals(activities.get(1).getActivityTitle())){
                            activities.remove(1);
                        }
                    }
                   if(j+1<activities.size()){
                       if(activities.get(j).getActivityTitle().equals(activities.get(j+1).getActivityTitle())){
                           activities.remove(j+1);
                           j=0;
                       }
                   }

                }

                 result=apply_activitiesService.saveActivities(activities)+activityapplyService.saveActivityapplys(activityapplies);
            }else if(tableName.contains("Notactivity")){
                result=noactivityApplyService.addBotactivities(notactivities);
            }else if(tableName.contains("winscholarship")){
                result=scholarshipService.addscholarship(scholarShips);
            }else if(tableName.contains("organization")){
                result=organizationService.saveorganization(organizations);
            }else if(tableName!=null && tableName.contains("applyInfo")){
                for(Map<String ,String> m:signList){
                    System.out.println(m.toString());
                }
                result=activityapplyService.addAndUpdateApplySignInfo(signList);
            }
//            System.out.println(result);
            if(result<=0){
                errorList.add("第"+((i/batch)*batch+1)+"行至第"+i+"行保存至数据库失败，原因：未知");
            }else{
                saveRows+=result;
            }
        }catch (Exception e){
            e.printStackTrace();
            String msg=e.getMessage();
            errorList.add("第"+((i/batch)*batch+1)+"行至第"+i+"行保存至数据库失败，原因："+msg.substring(0,msg.length()>2000?2000:msg.length()));
//            System.out.println("第"+((i/batch)*batch+1)+"行至第"+i+"行保存至数据库失败，原因："+e.getMessage().substring(0,msg.length()>2000?2000:msg.length()));
        }
//        System.out.println(errorList.size());
        return errorList;
    }

    /**
     * 处理excel中的数据，返回Map的集合。每个map 就是一行数据
     * @param input
     * @return
     * @throws IOException
     */
    private List<Map<String ,String >> excelProcess(InputStream input) throws IOException{
        List<Map<String ,String >> list=new ArrayList<>();
        HSSFWorkbook hssfWorkbook = new HSSFWorkbook(input);
        HSSFSheet sheet=hssfWorkbook.getSheetAt(0);
        List<String > fieldName=new ArrayList<>();
        //总数据行数 ，表格的总行数，减去前三行标题
//        String tabname=sheet.getRow(0).getCell(0).getStringCellValue();
//        if(tabname!=null && !tabname.equals("")){
//            tableName=tabname.split("#")[0];
//        }
        totalrows=sheet.getLastRowNum()-3+1;
        for(int i=1;i<=sheet.getLastRowNum();i++){
            //跳过第三行 （中文标题）
            if(i==2)continue;
            HSSFRow row=sheet.getRow(i);
            Map<String ,String> map=new HashMap<>();
            for(int j=0;j<=row.getLastCellNum();j++){
                HSSFCell cell=row.getCell(j);
                if(cell==null)continue;
                String cellvalue=getCellStringValue(cell);
                if(cellvalue!=null && !cellvalue.equals("")){
                    cellvalue=cellvalue.trim().replaceAll("[\n\t\r]*","");
                }
                //如果是第二行（字段名）则放到另一个list中
                if(i==1) {
                    fieldName.add(cellvalue);
                }else{
                    map.put(fieldName.get(j),cellvalue);
                }
            }
            if(i!=1) list.add(map);
        }
        return list;
    }

    /**
     * 把map 转换成对象 (调用set方法，方便加密)
     * @param map 需要转换的map
     * @param c 要转换成对象的class
     * @return
     */
    public Object mapToObj(Map map,Class c) throws ParseException {
        Object o=null;
        try {
            o=c.newInstance();
            Method[] methods=c.getMethods();
            for(Method m:methods){
                m.setAccessible(true);
                String methodName=m.getName();
                if(!methodName.contains("set")) continue;   //如果不是set方法则跳过
                Class paraType=m.getParameterTypes()[0];
                SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd");
                String value=(String)map.get(methodName.substring(3,4).toLowerCase()+methodName.substring(4));      //把方法名中的set去掉，然后第一个字母转小写，就是bean属性，以此为key从map 中取值
                if(value==null || value.equals(""))continue;    //根据bean属性在map中获取不到值则跳过
                if( paraType== java.sql.Date.class){       //如果该set方法的参数类型是date 或者 timestamp
                    //    System.out.println(value +"需要转换的");
                    m.invoke(o,new java.sql.Date(sdf.parse(value.replaceAll("/","-")).getTime()));
                }else if(paraType==Date.class ){
                    m.invoke(o,new Date(sdf.parse(value).getTime()));
                }else if( paraType== Timestamp.class){
                    m.invoke(o,new Timestamp(sdf.parse(value).getTime()));
                }else if(paraType== int.class){                   //如果该set方法的参数类型是int
                    m.invoke(o,Integer.parseInt(value));
                }else if(paraType==String.class) {                //如果该set方法的参数类型是 string
                    m.invoke(o,value);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return o;
    }

    /**
     * excel中数据的唯一性验证
     * @param list
     * @return
     */
    private List<ResultData> uqValid(List<Map<String ,String >> list){
        List<ResultData> resultlist=new ArrayList<>();
//        Map<String ,String > classMap= generateClassMap();  //获取班级的名字map
        List<String> classNameErr=new ArrayList<>();        //存放班级名字错误的信息
        Map<String ,Integer> map=new HashMap<>(batch);       //学号重复验证的容器
        List<String > nlId=new ArrayList<>();               //学号为空的值的集合
        Map<String,String  > stuIdAndTitle=new HashedMap();      //检测活动上传时文件中的重复数据 的临时容器
        List<String > repeatIndex=new ArrayList<>();        //检测活动上传时文件中的重复数据 的结果
        int i=0;
        for(Map<String ,String > m:list){
            if(tableName!=null && tableName.contains("student")&&!tableName.contains("student_applyInfo")){
                i++;
                //班级名字检测
                /**
                 * 2016-09-23 学生信息表修改
                 * 添加班级名、专业、专业类、学院、年级的字段，以及这几个字段值的非空判断
                 */
                String value=m.get("stuClassName");
                if(value==null || value.equals(""))
                    classNameErr.add("第 "+i+" 行:班级为空");
                value=m.get("stuMajorName");
                if(value==null || value.equals(""))
                    classNameErr.add("第 "+i+" 行:专业为空");
                value=m.get("stuMajorClass");
                if(value==null || value.equals(""))
                    classNameErr.add("第 "+i+" 行:专业类为空");
                value=m.get("stuGradeName");
                if(value==null || value.equals(""))
                    classNameErr.add("第 "+i+" 行:年级为空");
                value=m.get("stuCollageName");
                if(value==null || value.equals(""))
                    classNameErr.add("第 "+i+" 行:学院为空");
//                else{
//                    String classid=classMap.get(className);
//                    if(classid==null || classid.equals(""))
//                        classNameErr.add("第 "+i+" 行:班级["+className+"]不存在");
//                }
                //空值检测
                String id=m.get("studentID");
                if(id==null || id.equals("")){
                    String index=m.get("index");
                    if(index==null || index.equals(""))index=i+"";
                    nlId.add("第"+index+"行附近");
                    continue;
                }
                //重复性检测
                if(!map.containsKey(id)) map.put(id,1);
                else map.put(id,map.get(id)+1);
                //如果是家庭成员表 则执行如下语句
            }else if(tableName!=null && tableName.contains("member")){
                String id=m.get("memberStudentId");
                if(id==null || id.equals("")){
                    String index=m.get("index");
                    if(index==null || index.equals(""))index=i+"";
                    nlId.add("第"+index+"行附近");
                }//如果是活动申请表
            }else if (tableName!=null && tableName.contains("activityapply")){
                String id=m.get("applyStudentId");
                if(id==null || id.equals("")){
                    String index=m.get("index");
                    if(index==null || index.equals(""))index=i+"";
                    nlId.add("第"+index+"行附近");
                }
            }else if (tableName!=null && tableName.contains("activities")){
                String id=m.get("applyStudentId");
                if(id==null || id.equals("")){
                    String index=m.get("index");
                    if(index==null || index.equals(""))index=i+"";
                    nlId.add("第"+index+"行附近");
                }
            }else if (tableName!=null && tableName.contains("Notactivity")){
                    String id=m.get("NotStudentId");
                    if(id==null || id.equals("")){
                        String index=m.get("index");
                        if(index==null || index.equals(""))index=i+"";
                        nlId.add("第"+index+"行附近");
                    }
                }
            else if(tableName!=null && tableName.contains("winscholarship")){
                String id=m.get("supStudentId");
                if(id==null || id.equals("")) {
                    String index = m.get("index");
                    if (index == null || index.equals("")) index = i + "";
                    nlId.add("第" + index + "行附近");
                }
            }else if(tableName!=null && tableName.contains("winscholarship")){
                String title=m.get("applyStudentId")+m.get("activityTitle");    //将该条记录的学生学号 和 活动标题拼接成一个字符串
                if(stuIdAndTitle.containsKey(title))                               //如果容器中有相同的key，表明有重复数据，则检测结果中添加该条记录的行号以及重复的数据的行号
                    repeatIndex.add(m.get("index")+"|"+stuIdAndTitle.get(title));
                else                                                            //如果容器中没有相同的字符串，表明没有重复的数据，则往容器中添加该字符串
                    stuIdAndTitle.put(title,m.get("index"));
            }else if(tableName!=null && tableName.contains("applyInfo")){
                //空值检测
                String id=m.get("applyStudentId");
                if(id==null || id.equals("")){
                    String index=m.get("index");
                    if(index==null || index.equals(""))index=i+"";
                    nlId.add("第"+index+"行附近");
                    continue;
                }
                //重复性检测
                if(!map.containsKey(id)) map.put(id,1);
                else map.put(id,map.get(id)+1);
            }
        }
        //验证班级
        if(classNameErr.size()>0){
            ResultData re=new ResultData();
            re.sets(1,"班级、年级、专业、学院数据有错误");
            re.setData(classNameErr);
            resultlist.add(re);
        }
        //验证学号是否有空值
        if(nlId.size()>0){
            ResultData re=new ResultData();
            re.sets(1,"学号有空值");
            re.setData(nlId);
            resultlist.add(re);
        }
        //验证学号是否有重复
        Set<Entry<String ,Integer>> entries=map.entrySet();
        Iterator<Entry<String, Integer>> it=entries.iterator();
        List<String > msg=new ArrayList<>();
        while (it.hasNext()){
            Entry<String, Integer> en=it.next();
            if(en.getValue()>=2) {
                msg.add("学号["+en.getKey()+"]出现次数"+en.getValue());
            }else{
                it.remove();
            }
        }
        if(entries.size()>0){
            ResultData re=new ResultData();
            re.sets(1,"学号有重复");
            re.setData(msg);
            resultlist.add(re);
        }
        if(repeatIndex.size()>0){
            ResultData re=new ResultData();
            re.sets(1,"数据有重复,详见以下行号对");
            re.setData(repeatIndex);
            resultlist.add(re);
        }
        return resultlist;
    }


    /**
     * 检查表格中数据与数据库中数据是否有重复
     * @param list
     * @return
     */
    private ResultData primaryKeyValid(List<Map<String ,String >> list){
        ResultData resultData=new ResultData();
        List<String > temp=new ArrayList<>();
        int i=0;
        for(;list.size()>i+batch;){
            List<Map<String,String >> sub=list.subList(i,i+=batch);
            List<String > keys=studentService.getKeys(sub);
            if(keys!=null && keys.size()>0){
                temp.addAll(keys);
            }
        }
        if(list.size()==0){
            return resultData;
        }
        List<Map<String,String >> sub=list.subList(i,list.size());
        List<String > keys=studentService.getKeys(sub);
        if(keys!=null && keys.size()>0){
            temp.addAll(keys);
        }
        if(temp.size()>0){
            resultData.sets(2,"以下学号与数据库中有重复，请查证");
            resultData.setData(temp);
        }
        return resultData;
    }

    public boolean isEmpty(String ...strs){
        boolean result = false;
        for(String str:strs){
            if(null == str || "".equals(str)){
                result = true;
                break;
            }
        }
        return result;
    }

    public  boolean isValidDate(String s) {
        DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
        try {
            dateFormat.parse(s);
            return true;
        } catch (Exception e) {
            return false;
        }
    }

    public boolean isNumeric(String str){
        Pattern pattern = Pattern.compile("^[0-9][0-9]*(\\.[0-9]{1,2})?$");
        Matcher isNum = pattern.matcher(str);
        if( !isNum.matches() ){
            return false;
        }
        return true;
    }

    public boolean isSupPowers(String supPowersStr){
        String[] suppowers = supPowersStr.split("|");
        String[] powers = {"思辨能力","表达能力","领导能力","创业能力","创新能力","执行能力"};
        if(suppowers.length > 6){
            return false;
        }

        Set<String> set = new HashSet<String>();
        for(String str : suppowers){
           if(!ArrayUtils.contains(powers,str)){
               return false;
           };
            set.add(str);
        }

        if(set.size() != suppowers.length){
            return false;
        }
        return true;
    }
//    /**
//     * 生成班级的map  key 是班级的名字，value是班级的id
//     * @return
//     */
//    private Map<String ,String > generateClassMap(){
//        List<Map<String ,String>> list=studentService.getClassName();
//        Map<String ,String > map=new HashMap<>();
//        for(Map<String ,String> m:list){
//            map.put(m.get("className"),m.get("classId"));
//        }
//        return map;
//    }
}