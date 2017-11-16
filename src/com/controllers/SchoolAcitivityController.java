package com.controllers;

import com.Services.interfaces.ActivityapplyService;
import com.Services.interfaces.NoactivityApplyService;
import com.Services.interfaces.SchoolActivityService;
import com.Services.interfaces.SupplementApplyService;
import com.common.utils.SpringUtils;
import com.github.pagehelper.Page;
import com.model.*;
import com.supermapping.jdbcfactories.JdbcFactory;
import com.utils.PwdUtil;
import com.utils.Utils;
import org.apache.commons.collections.map.HashedMap;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.*;

import static java.lang.Integer.parseInt;

/**
 * Created by sw 2016/9/12.
 */
@Controller
@RequestMapping("/jsons")
public class SchoolAcitivityController {
    @Autowired
    private SchoolActivityService schoolActivityService;
    @Autowired
    private ActivityapplyService activityapplyService;
    @Autowired
    private NoactivityApplyService noactivityApplyService;
    @Autowired
    private SupplementApplyService supplementApplyService;
    /**
     * 校内活动
     * @param request
     * @return data
     */
    @RequestMapping("/loadshoolActivtityList")
    @ResponseBody
    public DataForDatagrid loadshoolActivtityList(HttpServletRequest request){
        String srows=request.getParameter("rows");
        String spage=request.getParameter("page");
        int rows=(srows==null || srows.equals(""))? 10: parseInt(srows);
        int page=(spage==null || spage.equals(""))? 1: parseInt(spage);
//        int index=(page-1)*rows;
        DataForDatagrid data=new DataForDatagrid();
        String  studentID= (String) request.getSession().getAttribute("studentid");
        List<activities> r = schoolActivityService.loadSchoolActivityList(rows,page,1,studentID);
        data.setDatas(r);
        data.setTotal((int)((Page)r).getTotal());
        return data;
    }


    /**
     * 学院活动
     * @param request
     * @return data
     */
    @RequestMapping("/loadcollegeActivtityList")
    @ResponseBody
    public DataForDatagrid loadcollegeActivtityList(HttpServletRequest request){
        String srows=request.getParameter("rows");
        String spage=request.getParameter("page");
        int rows=(srows==null || srows.equals(""))? 10: parseInt(srows);
        int page=(spage==null || spage.equals(""))? 1: parseInt(spage);
//        int index=(page-1)*rows;
        String  studentID= (String) request.getSession().getAttribute("studentid");
        DataForDatagrid data=new DataForDatagrid();
        List<activities> r = schoolActivityService.loadSchoolActivityList(rows,page,2,studentID);
        data.setDatas(r);
        data.setTotal((int)((Page)r).getTotal());
        return data;
    }


    /**
     * 保存班级整体申请活动
     * @param request
     * @return ResultData
     */
    @RequestMapping(value="/classApply")
    @ResponseBody
    public ResultData classApply(HttpServletRequest request,String stuClassName,String activityId){
        String activityCreator = (String) request.getSession().getAttribute("creatorName");
        ResultData data=new ResultData();
        String msg="";
        List<String> applyedStudents=new ArrayList<>();
        if (stuClassName.equals("")||stuClassName==null) {
            msg= ("班级信息有误");
        }
        if (activityId.equals("")||activityId==null){
            msg=("活动信息有误");
        }else{
            applyedStudents=activityapplyService.getStudentIdsByActivityid(activityId);
        }

        if (msg.equals("")){
            List<String> idList=activityapplyService.getStudentIds(stuClassName);
            if(idList.size()>0){
                List<activityapply> list=new ArrayList<>();
                for(String id:idList){
                    if(applyedStudents.contains(id)) {
                        msg= ("该班级已有部分学生报名了，已成功为其余同学报名");
                        continue;
                    }
                    activityapply Activityapply=new activityapply();
                    java.util.Date curDate = new java.util.Date();//新建一个util类型的date
                    java.sql.Date date = new java.sql.Date(curDate.getTime());//进行日期的转换
                    Activityapply.setApplyActivityId(activityId);
                    Activityapply.setSignUpStatus("未签到");
                    Activityapply.setSignUpTime(null);
                    Activityapply.setApplyStudentId(id);
                    Activityapply.setApplyAuditStatus("待审核");
                    Activityapply.setApplyAuditStatusDate(date);
                    Activityapply.setApplyDate(date);
                    list.add(Activityapply);
                }
                int result=0;
                if(list.size()>0) {
                     result=activityapplyService.saveActivityapplys(list);
                }else{
                    msg= ("该班级学生已全部报过名，不需再次报名");
                }

                data.setStatusByDBResult(result);
                data.setData(result);
            }
        }
        data.setMsg(msg);
        return data;
    }
    /**
     * 保存其他类活动 保存申请的学生
     * @param request
     * @return ResultData
     */
    @RequestMapping(value="/saveOtherActivities")
    @ResponseBody
    public ResultData saveOtherActivities(HttpServletRequest request){
        String activityCreator = (String) request.getSession().getAttribute("creatorName");
        ResultData data=new ResultData();
        Map<String ,String[]> map= request.getParameterMap();//取出请求中所有传递过来的参数
        Map<String ,String > newmap=new HashMap<>(36);
        Set<String > keys=map.keySet();
        for(String s:keys){     //取中map中每个元素（数组）的第一个，并放到新的map中
            String[] value=map.get(s);
            if(value.length==0)continue;
            newmap.put(s,value[0]);
        }
        String str=newmap.get("applyStudentId");
        String ids  =str.replaceAll( "\\s+ ", ",").replaceAll(" ",",").replaceAll("，",",");
        String[] studentid=ids.split(",");
        String msg="";
        ArrayList<String> idList=new ArrayList();
        for(int i=0;i<studentid.length;i++){
            Student student=activityapplyService.selectStudentID(studentid[i]);
            if(student==null){
                msg="学号为"+studentid[i]+"的学生不存在";
            }
            if(!idList.contains(studentid[i])){
                idList.add(studentid[i]);
            }
        }
        if(("").equals(msg)){
            //map转对象
            try {
                apply_activities applyactivities= (apply_activities) Utils.mapToObj(newmap,apply_activities.class);
                String uuid=UUID.randomUUID().toString();
                applyactivities.setApplyId(uuid);
                applyactivities.setActivityCreator(activityCreator);
                List<activityapply> list=new ArrayList<>();
                for(String id:idList){
                    activityapply Activityapply=new activityapply();
                    java.util.Date curDate = new java.util.Date();//新建一个util类型的date
                    java.sql.Date date = new java.sql.Date(curDate.getTime());//进行日期的转换
                    Activityapply.setApplyActivityId(uuid);
                    Activityapply.setSignUpStatus("已签到");
                    Activityapply.setSignUpTime(date);
                    Activityapply.setApplyStudentId(id);
                    Activityapply.setApplyAuditStatus("已通过");
                    Activityapply.setApplyAuditStatusDate(date);
                    list.add(Activityapply);
                }
                int result=activityapplyService.saveActivtity(applyactivities)+activityapplyService.saveActivityapplys(list);
                data.setStatusByDBResult(result);
                data.setData(result);
            } catch (Exception e) {
                e.printStackTrace();
            }
        }else {
            data.setMsg(msg);
//            System.out.println(msg);
        }
        return data;
    }
    /**
     * 通过学号获得学生姓名
     * @param request
     * @return ResultData
     */
    @RequestMapping(value="/getStudentname")
    @ResponseBody
    public String getStudentname(HttpServletRequest request){
        String str= (String) request.getParameter("studentID");
       // System.out.println(str);
        String ids  =str.replaceAll( "\\s+ ", ",").replaceAll(" ",",").replaceAll("，",",");
        String[] studentid=ids.split(",");
        String studentName="";
        String msg="";
        for(int i=0;i<studentid.length;i++){
            Student student=activityapplyService.selectStudentID(studentid[i]);
            if(student==null){
                msg=msg+"学号为"+studentid[i]+"的学生不存在"+",";
            }else {
                studentName=studentName+(studentid[i]+":"+student.getStudentName()+",");
            }
        }
        //System.out.println(studentName+msg);
        return studentName+msg;
    }
    /**
     * 添加团队申请活动
     * @param request
     * @return ResultData
     */
    @RequestMapping(value="/addTeaminfor")
    @ResponseBody
    public ResultData addTeaminfor(HttpServletRequest request){
        String activityCreator = (String) request.getSession().getAttribute("creatorName");
        ResultData data=new ResultData();
        Map<String ,String[]> map= request.getParameterMap();//取出请求中所有传递过来的参数
        Map<String ,String > newmap=new HashMap<>(36);
        Set<String > keys=map.keySet();
        for(String s:keys){     //取中map中每个元素（数组）的第一个，并放到新的map中
            String[] value=map.get(s);
            if(value.length==0)continue;
            newmap.put(s,value[0]);
        }
        String str=newmap.get("applyStudentId");
        String ids  =str.replaceAll( "\\s+ ", ",").replaceAll(" ",",").replaceAll("，",",");
        String[] studentid=ids.split(",");
        ArrayList idList=new ArrayList();
        String msg="";
        for(int i=0;i<studentid.length;i++){
            Student student=activityapplyService.selectStudentID(studentid[i]);
            if(student==null){
                msg="学号为"+studentid[i]+"的学生不存在";
            }
            //学号去重复
            if(!idList.contains(studentid[i])){
                idList.add(studentid[i]);
            }
        }
        Team team1=activityapplyService.selectTeamByname(newmap.get("teamName"),newmap.get("teamActivityId"));
        if(team1!=null){
            msg="团体"+newmap.get("teamName")+"已申请过该活动";
        }
        if(("").equals(msg)){
                String uuid=UUID.randomUUID().toString();
                Team team=new Team();
                team.setTeamId(uuid);
                team.setTeamName(newmap.get("teamName"));
                team.setTeamActivityId(newmap.get("teamActivityId"));
               // System.out.println(team);
              //添加团队
                int result=activityapplyService.addTeaminfor(team);
               // System.out.println(result);
            //添加关联关系 学生与团队
                if(result>0){
                    Map<String ,Object> map1= new HashedMap();
                    map1.put("teamId",uuid);
                    map1.put("studentIDs",idList);
                    result=activityapplyService.addStudentTeam(map1);
                    if(result>0){
                        activityapply Activityapply=new activityapply();
                        for(int i = 0;i < idList.size();i++){
                            Activityapply.setApplyActivityId(newmap.get("teamActivityId"));
                            Activityapply.setApplyStudentId(idList.get(i).toString());
                            Activityapply.setApplyTeamId(uuid);
                            Activityapply.setSignUpStatus("已签到");
                            Activityapply.setApplyAuditStatus("已通过");
                            java.util.Date curDate = new java.util.Date();//新建一个util类型的date
                            java.sql.Date date = new java.sql.Date(curDate.getTime());//进行日期的转换
                            Activityapply.setSignUpTime(date);
                            Activityapply.setApplyDate(date);
                            Activityapply.setApplyAuditStatusDate(date);
                            Activityapply.setActivitypoint("3");
                            List<activityapply> list=new ArrayList<>();
                            list.add(Activityapply);
                            result=activityapplyService.saveActivityapplys(list);
                        }

                    }
                }
                data.setStatusByDBResult(result);
                data.setData(result);
        }else {
            data.setMsg(msg);
//            System.out.println(msg);
        }
        return data;
    }
    /**
     * 添加团队申请活动
     * @param request
     * @return ResultData
     */
    @RequestMapping(value="/addClassTeaminfor")
    @ResponseBody
    public ResultData addClassTeaminfor(HttpServletRequest request){
        String activityCreator = (String) request.getSession().getAttribute("creatorName");
        ResultData data=new ResultData();
        Map<String ,String[]> map= request.getParameterMap();//取出请求中所有传递过来的参数
        Map<String ,String > newmap=new HashMap<>(36);
        Set<String > keys=map.keySet();
        for(String s:keys){     //取中map中每个元素（数组）的第一个，并放到新的map中
            String[] value=map.get(s);
            if(value.length==0)continue;
            newmap.put(s,value[0]);
        }
        String msg="";
        if(newmap.get("teamName")==null || "".equals(newmap.get("teamName"))){
            msg="没有团体名称!";
            data.setMsg(msg);
            return data;
        }
        //获取班级所有学生id
        List<String> idList =activityapplyService.getstudentIdByClassName(newmap.get("teamName"));

        Team team1=activityapplyService.selectTeamByname(newmap.get("teamName"),newmap.get("teamActivityId"));
        if(team1!=null){
            msg="团体"+newmap.get("teamName")+"已申请过该活动";
        }
        if(("").equals(msg)){
            String uuid=UUID.randomUUID().toString();
            Team team=new Team();
            team.setTeamId(uuid);
            team.setTeamName(newmap.get("teamName"));
            team.setTeamActivityId(newmap.get("teamActivityId"));
            // System.out.println(team);
            //添加团队
            int result=activityapplyService.addTeaminfor(team);
            // System.out.println(result);
            //添加关联关系 学生与团队
            if(result>0){
                Map<String ,Object> map1= new HashedMap();
                map1.put("teamId",uuid);
                map1.put("studentIDs",idList);
                result=activityapplyService.addStudentTeam(map1);
                if(result>0){
                    activityapply Activityapply = new activityapply();
                    for(int i = 0;i < idList.size();i++) {
                        Activityapply.setApplyActivityId(newmap.get("teamActivityId"));
                        Activityapply.setApplyStudentId(idList.get(i).toString());
                        Activityapply.setApplyTeamId(uuid);
                        Activityapply.setSignUpStatus("已签到");
                        Activityapply.setApplyAuditStatus("已通过");
                        java.util.Date curDate = new java.util.Date();//新建一个util类型的date
                        java.sql.Date date = new java.sql.Date(curDate.getTime());//进行日期的转换
                        Activityapply.setSignUpTime(date);
                        Activityapply.setApplyDate(date);
                        Activityapply.setApplyAuditStatusDate(date);
                        Activityapply.setActivitypoint("3");
                        List<activityapply> list = new ArrayList<>();
                        list.add(Activityapply);
                        result = activityapplyService.saveActivityapplys(list);
                    }
                }
            }
            data.setStatusByDBResult(result);
            data.setData(result);
        }else {
            data.setMsg(msg);
//            System.out.println(msg);
        }
        return data;
    }
    /**
     * 修改团队申请活动
     * @param request
     * @return ResultData
     */
    @RequestMapping(value="/editTeaminfor")
    @ResponseBody
    public ResultData editTeaminfor(HttpServletRequest request){
        String activityCreator = (String) request.getSession().getAttribute("creatorName");
        ResultData data=new ResultData();
        Map<String ,String[]> map= request.getParameterMap();//取出请求中所有传递过来的参数
        Map<String ,String > newmap=new HashMap<>(36);
        Set<String > keys=map.keySet();
        for(String s:keys){     //取中map中每个元素（数组）的第一个，并放到新的map中
            String[] value=map.get(s);
            if(value.length==0)continue;
            newmap.put(s,value[0]);
        }
        String str=newmap.get("applyStudentId");
        //先去空格，转化一个分隔符
        String ids  =str.replaceAll( "\\s+ ", ",").replaceAll(" ",",").replaceAll("，",",");
        String[] studentid=ids.split(",");
        String msg="";
        ArrayList idList=new ArrayList();
        for(int i=0;i<studentid.length;i++){
            Student student=activityapplyService.selectStudentID(studentid[i]);
            if(student==null){
                msg="学号为"+studentid[i]+"的学生不存在";
            }
            //学号去重复
            if(!idList.contains(studentid[i])){
                idList.add(studentid[i]);
            }
        }
        if(("").equals(msg)){
            Team team=new Team();
            team.setTeamId(newmap.get("teamId"));
            team.setTeamName(newmap.get("teamName"));
            team.setTeamActivityId(newmap.get("teamActivityId"));
         //   System.out.println(team);
            //修改团队
            int result=activityapplyService.editTeaminfor(team);
            // System.out.println(result);
            //修改关联关系 学生与团队
            if(result>0){
                Map<String ,Object> map1= new HashedMap();
                map1.put("teamId",newmap.get("teamId"));
                map1.put("studentIDs",idList);
                result=activityapplyService.editStudentTeam(map1);
            }
            data.setStatusByDBResult(result);
            data.setData(result);
        }else {
            data.setMsg(msg);
//            System.out.println(msg);
        }
        return data;
    }
    /**
     * 删除团体已经关联的学生
     * @param request
     * @return ResultData
     */
    @RequestMapping(value="/deleteTeaminfor")
    @ResponseBody
    public ResultData deleteTeaminfor(HttpServletRequest request){
        ResultData data=new ResultData();
        Map<String ,String[]> map= request.getParameterMap();//取出请求中所有传递过来的参数
        Map<String ,String > newmap=new HashMap<>(36);
        Set<String > keys=map.keySet();
        for(String s:keys){     //取中map中每个元素（数组）的第一个，并放到新的map中
            String[] value=map.get(s);
            if(value.length==0)continue;
            newmap.put(s,value[0]);
        }
        String teamId=newmap.get("teamId");
        JdbcFactory factory = SpringUtils.getBean(JdbcFactory.class);
        Connection connection=null;
        PreparedStatement preparedStatement=null;
        int result=0;
        try {
            //第一次删除 删除团体信息
            connection=factory.createConnection();
            String sql="DELETE FROM team WHERE teamId=?";
            preparedStatement = connection.prepareStatement(sql);
            preparedStatement.setString(1,teamId);
            result=preparedStatement.executeUpdate();
            if(result>0){
                //第二次删除 删除关联的学生信息
                sql="DELETE FROM r_student_team WHERE teamId=?";
                preparedStatement = connection.prepareStatement(sql);
                preparedStatement.setString(1,teamId);
                result=preparedStatement.executeUpdate();
                //第三次删除 删除活动申请信息
                if(result>0){
                    sql="DELETE FROM activityapply WHERE applyTeamId=?";
                    preparedStatement = connection.prepareStatement(sql);
                    preparedStatement.setString(1,teamId);
                    result=preparedStatement.executeUpdate();
                }
            }
            data.setStatusByDBResult(result);
            data.setData(result);
        } catch (SQLException e) {
            e.printStackTrace();
        } catch (IllegalAccessException e) {
            e.printStackTrace();
        } catch (InstantiationException e) {
            e.printStackTrace();
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        }finally {
            if(connection!=null){
                try {
                    connection.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
            if(preparedStatement!=null){
                try {
                    preparedStatement.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
        }
        return data;
    }
    /**
     * 删除其他类活动 与 绑定的学生
     * @param request
     * @return ResultData
     */
    @RequestMapping(value="/deleteOtherActivities")
    @ResponseBody
    public ResultData deleteOtherActivities(HttpServletRequest request){
        ResultData data=new ResultData();
        Map<String ,String[]> map= request.getParameterMap();//取出请求中所有传递过来的参数
        Map<String ,String > newmap=new HashMap<>(36);
        Set<String > keys=map.keySet();
        for(String s:keys){     //取中map中每个元素（数组）的第一个，并放到新的map中
            String[] value=map.get(s);
            if(value.length==0)continue;
            newmap.put(s,value[0]);
        }
        String activityId=newmap.get("activityId");
        String studentid=newmap.get("studentId");
        JdbcFactory factory = SpringUtils.getBean(JdbcFactory.class);
        Connection connection=null;
        PreparedStatement preparedStatement=null;
        ResultSet resultSet=null;
        int result=0;
        int size=0;
        try {
            connection=factory.createConnection();
            String sql="DELETE FROM activityapply WHERE applyActivityId=? and applyStudentId=?";
            preparedStatement = connection.prepareStatement(sql);
            preparedStatement.setString(1,activityId);
            preparedStatement.setString(2,studentid);
            result=preparedStatement.executeUpdate();
            if(result>0){
                sql="SELECT COUNT(*) as countPerson FROM activityapply WHERE applyActivityId=?";
                preparedStatement = connection.prepareStatement(sql);
                preparedStatement.setString(1,activityId);
                resultSet=preparedStatement.executeQuery();
                if(resultSet.next()){
                    size=resultSet.getInt("countPerson");
                }
                if(size==0){
                    sql="DELETE FROM activities WHERE activityId=?";
                    preparedStatement = connection.prepareStatement(sql);
                    preparedStatement.setString(1,activityId);
                    result=preparedStatement.executeUpdate();
                }
            }
            data.setStatusByDBResult(result);
            data.setData(result);
        } catch (SQLException e) {
            e.printStackTrace();
        } catch (IllegalAccessException e) {
            e.printStackTrace();
        } catch (InstantiationException e) {
            e.printStackTrace();
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        }finally {
            if(connection!=null){
                try {
                    connection.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
            if(preparedStatement!=null){
                try {
                    preparedStatement.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
            if(resultSet!=null){
                try {
                    resultSet.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
        }
        return data;
    }

    /**
     * 保存非活动类别申请
     * @param request
     * @return
     */
    @RequestMapping(value="/saveNotactivity")
    @ResponseBody
    public ResultData saveNotactivity(HttpServletRequest request){
        String activityCreator = (String) request.getSession().getAttribute("creatorName");
        ResultData data=new ResultData();
        Map<String ,String[]> map= request.getParameterMap();//取出请求中所有传递过来的参数
        Map<String ,String > newmap=new HashMap<>(36);
        Set<String > keys=map.keySet();
        for(String s:keys){     //取中map中每个元素（数组）的第一个，并放到新的map中
            String[] value=map.get(s);
            if(value.length==0)continue;
            newmap.put(s,value[0]);
        }
        newmap.put("auditStatusName",activityCreator);
        String msg="";
        String studentid=newmap.get("notStudentId");
        Student student=activityapplyService.selectStudentID(studentid);
        if(student==null){
                msg="学号为"+studentid+"的学生不存在";
        }
        if(("").equals(msg)){
            int result=noactivityApplyService.addBotactivity(newmap);
            data.setStatusByDBResult(result);
            data.setData(result);
        }else {
            data.setMsg(msg);
         //  System.out.println(msg);
        }
        return data;
    }
    /**
     * 前端页面用个人信息
     * @param session
     * @param studentid
     * @return data
     */
    @RequestMapping(value = "/loadInfor")
    @ResponseBody
    public DataForDatagrid loadInfor(HttpSession session,String studentid){
        if(studentid==null || studentid.equals("") || studentid.equals("null")){
            studentid= (String) session.getAttribute("studentid");
        }
        JdbcFactory factory = SpringUtils.getBean(JdbcFactory.class);
        Connection connection=null;
        PreparedStatement preparedStatement=null;
        ResultSet resultSet=null;
        DataForDatagrid data=new DataForDatagrid();
        try {
            if(studentid!=null&&studentid!=""){
                connection = factory.createConnection();
                String sql="SELECT * FROM student WHERE studentID=?";
                preparedStatement = connection.prepareStatement(sql);
                preparedStatement.setString(1, studentid);
                resultSet = preparedStatement.executeQuery();
                if(resultSet.next()){
                    String studentName=resultSet.getString("studentName");
                    String collegeName=resultSet.getString("stuCollageName");
                    String majorName=resultSet.getString("stuMajorName");
                    String className=resultSet.getString("stuClassName");
                    String studentPhone=resultSet.getString("studentPhone");
                    String studentID = resultSet.getString("studentID");
                    String studentPhoto = resultSet.getString("studentPhoto");
                    Map<String ,String > map=new  HashedMap();
                    map.put("studentName",studentName);
                    map.put("collegeName",collegeName);
                    map.put("majorName",majorName);
                    map.put("className",className);
                    map.put("studentPhone", PwdUtil.AESDecoding(studentPhone));
                    map.put("studentID",studentID);
                    map.put("studentPhoto",studentPhoto);
                    List<Map<String,String>>  list=new ArrayList<>();
                    list.add(map);
                    data.setDatas(list);
                    /**
                     * 将打印ID 打印审核状态 打印状态 放入session中
                     */
                    map=setSessionData(factory,studentid);
                    session.setAttribute("printId",map.get("printId"));
                    session.setAttribute("printAuditstatus",map.get("printAuditstatus"));
                    session.setAttribute("printStatus",map.get("printStatus"));
                }
            }

        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        } catch (IllegalAccessException e) {
            e.printStackTrace();
        } catch (InstantiationException e) {
            e.printStackTrace();
        } catch (SQLException e) {
            e.printStackTrace();
        }finally {
            try {
                if (resultSet != null) {
                    resultSet.close();
                }
            } catch (SQLException e) {
                e.printStackTrace();
            }
            try {
                if (preparedStatement != null) {
                    preparedStatement.close();
                }
            } catch (SQLException e) {
                e.printStackTrace();
            }
            try {
                if (connection != null) {
                    connection.close();
                }
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        return data;
    }

    /**
     * 该学生参与的活动
     * @param activityClass
     * @param activityLevle
     * @param activityNature
     * @param activityPowers
     * @param activityAward
     * @param session
     * @return data
     */
    @RequestMapping("/laodStudentActivity")
    @ResponseBody
    public DataForDatagrid laodStudentActivity(String activityClass,String activityLevle,String activityNature,String activityPowers,String activityAward,HttpSession session){
        String studentID= (String) session.getAttribute("studentid");
        DataForDatagrid data = new DataForDatagrid();
        List<Map<String,String>> list=new ArrayList<>();
        if(studentID!=null&&!studentID.equals("")){
            //0 代表未删除  状态为已签到
            String[] str={activityClass,activityLevle,activityNature,activityPowers,activityAward,studentID,"0",null};
            list=schoolActivityService.laodStudentActivity(str);
            for (Map<String,String> stringMap:list){
                stringMap.put("regimentAuditStatus","已通过");
                stringMap.put("collegeAuditStatus","已通过");
                stringMap.put("schoolAuditStaus","已通过");
            }
            /**
             *查看该学生有没有补充活动
             */
            list=getSupplement(studentID,list);
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
            data.setDatas(list);
        }
        return data;
    }

    /**
     *
     *查看该学生有没有补充活动
     *
     * @param studentID
     * @param list
     * @return
     */
    public List<Map<String,String>> getSupplement(String studentID, List<Map<String,String>> list){
        List<Map<String,String>> suplist=new ArrayList<>();
        if(studentID!=null&&!studentID.equals("")){
            suplist= supplementApplyService.getSupplement(studentID);
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
                map.put("collegeAuditStatus",map.get("collegeAuditStatus"));
                map.put("schoolAuditStaus",map.get("schoolAuditStaus"));
                map.put("worktime",map.get("supWorktime"));
            }
            list.add(map);
        }
        return  list;
    }
    /**
     * 通过学生ID 获取打印ID
     * @param factory
     * @param studentid
     * @return map
     * @throws ClassNotFoundException
     * @throws SQLException
     * @throws InstantiationException
     * @throws IllegalAccessException
     */
    public Map<String,String> setSessionData(JdbcFactory factory,String studentid)  {
        Map<String,String> map=new HashedMap();
        Connection connection = null;
        PreparedStatement preparedStatement=null;
        ResultSet resultSet=null;
        try {
            connection = factory.createConnection();
            String sql="SELECT printId,printAuditstatus,printStatus FROM print WHERE studentId=? AND createDate=(SELECT MAX(createDate) FROM print)";
            preparedStatement = connection.prepareStatement(sql);
            preparedStatement.setString(1, studentid);
            resultSet = preparedStatement.executeQuery();
            if(resultSet.next()){
                String printId=resultSet.getString("printId");
                String printAuditstatus=resultSet.getString("printAuditstatus");
                String printStatus=resultSet.getString("printStatus");
                map.put("printId",printId);
                map.put("printAuditstatus",printAuditstatus);
                map.put("printStatus",printStatus);
            }
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        } catch (IllegalAccessException e) {
            e.printStackTrace();
        } catch (InstantiationException e) {
            e.printStackTrace();
        } catch (SQLException e) {
            e.printStackTrace();
        }finally {
            if(connection!=null){
                try {
                    connection.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
            if(preparedStatement!=null){
                try {
                    preparedStatement.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
            if(resultSet!=null){
                try {
                    resultSet.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
        }
        return map;
    }
}
