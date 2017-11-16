package com.Services.impls;

import com.Services.interfaces.ActivityEndCheckService;
import com.dao.interfaces.ActivityEndCheckDao;
import com.github.pagehelper.PageHelper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Created by guoqiang on 2016/11/28.
 */
@Service
public class ActivityEndCheckServiceImpl implements ActivityEndCheckService {

    @Autowired
    private ActivityEndCheckDao activityEndCheckDao;

    @Override
    public List<Map> loadCheckNum(int pagenum, int rows,String loadstatus) {
        PageHelper.startPage(pagenum,rows);
        Map map=new HashMap<>();
        map.put("page",pagenum);
        map.put("rows",rows);
        map.put("loadstatus",loadstatus);
        return activityEndCheckDao.loadCheckNum(map);
    }

    @Override
    public List<Map> loadCheckMajorNum(int pagenum, int pagesize,String collegeName,String status,String loadstatus) {
        PageHelper.startPage(pagenum,pagesize);
        Map map=new HashMap<>();
        map.put("page",pagenum);
        map.put("rows",pagesize);
        map.put("collegeName",collegeName);
        map.put("status",status);
        map.put("loadstatus",loadstatus);
        return activityEndCheckDao.loadCheckMajorNum(map);
    }

    @Override
    public List<Map> loadCheckClassNum(int pagenum, int pagesize, String majorName,String status,String loadstatus) {
        PageHelper.startPage(pagenum,pagesize);
        Map map=new HashMap<>();
        map.put("page",pagenum);
        map.put("rows",pagesize);
        map.put("majorName",majorName);
        map.put("status",status);
        map.put("loadstatus",loadstatus);
        return activityEndCheckDao.loadCheckClassNum(map);
    }

    @Override
    public List<Map> loadCheckStudentNum(int pagenum, int pagesize, String className, String status,String loadstatus) {
        PageHelper.startPage(pagenum,pagesize);
        Map map=new HashMap<>();
        map.put("page",pagenum);
        map.put("rows",pagesize);
        map.put("className",className);
        map.put("status",status);
        map.put("loadstatus",loadstatus);
        return activityEndCheckDao.loadCheckStudentNum(map);
    }

    @Override
    public List<Map> testSchoolRecheck(List<String> idslist) {
        List<Map> list=new ArrayList<>();
            Map<String,Object> map=new HashMap<>();
            map.put("idslist",idslist);
            list= activityEndCheckDao.testSchoolRecheck(map);
        return list;
    }

    @Override
    public List<Map> testCollegeRecheck(List<String> idslist,String collegeName,String status) {
        List<Map> list=new ArrayList<>();
        Map<String,Object> map=new HashMap<>();
        map.put("idslist",idslist);
        map.put("collegeName",collegeName);
        map.put("status",status);
        list= activityEndCheckDao.testCollegeRecheck(map);
        return list;
    }

    @Override
    public List<Map> testMajorRecheck(List<String> idslist, String majorName,String status) {
        List<Map> list=new ArrayList<>();
        Map<String,Object> map=new HashMap<>();
        map.put("idslist",idslist);
        map.put("majorName",majorName);
        map.put("status",status);
        list= activityEndCheckDao.testMajorRecheck(map);
        return list;
    }

    @Override
    public List<Map> testClassRecheck(List<String> idslist,String status) {
        List<Map> list=new ArrayList<>();
        Map<String,Object> map=new HashMap<>();
        map.put("idslist",idslist);
        map.put("status",status);
        list= activityEndCheckDao.testClassRecheck(map);
        return list;
    }

    @Override
    public int SchoolAuditApply(List<String> li,String type) {
        int result=0;
        Map<String,Object> map=new HashMap<>();
        map.put("li",li);
        map.put("type",type);
//        map.put("regimentAuditStatus");
        result= activityEndCheckDao.SchoolAuditApply(map);
        return result;
    }

    @Override
    public int CollegeAuditApply(List<String> li, String type,String status) {
        int result=0;
        Map<String,Object> map=new HashMap<>();
        map.put("li",li);
        map.put("type",type);
        map.put("status",status);
//        map.put("regimentAuditStatus");
        result= activityEndCheckDao.CollegeAuditApply(map);
        return result;
    }

    @Override
    public int MajorAuditApply(List<String> li, String type,String status) {
        int result=0;
        Map<String,Object> map=new HashMap<>();
        map.put("li",li);
        map.put("type",type);
        map.put("status",status);
//        map.put("regimentAuditStatus");
        result= activityEndCheckDao.MajorAuditApply(map);
        return result;
    }

    @Override
    public int ClassAuditApply(List<String> li, String type,String status) {
        int result=0;
        Map<String,Object> map=new HashMap<>();
        map.put("li",li);
        map.put("type",type);
        map.put("status",status);
//        map.put("regimentAuditStatus");
        result= activityEndCheckDao.ClassAuditApply(map);
        return result;
    }
    @Override
    public int superAuditApply(List<String> li, String type,String status) {
        int result=0;
        Map<String,Object> map=new HashMap<>();
        map.put("li",li);
        map.put("type",type);
        map.put("status",status);
//        map.put("regimentAuditStatus");
        result= activityEndCheckDao.superAuditApply(map);
        return result;
    }
    @Override
    public List<String> selectApplyIdByCollege(List<String> idslist) {
        List<String> list=new ArrayList<>();
        Map<String,Object> map=new HashMap<>();
        map.put("idslist",idslist);
        list= activityEndCheckDao.selectApplyIdByCollege(map);
        return list;
    }

    @Override
    public List<String> selectApplyIdByMajor(List<String> idslist,String collegeName,String status) {
        List<String> list=new ArrayList<>();
        Map<String,Object> map=new HashMap<>();
        map.put("idslist",idslist);
        map.put("collegeName",collegeName);
        map.put("status",status);
        list= activityEndCheckDao.selectApplyIdByMajor(map);
        return list;
    }

    @Override
    public List<String> selectApplyIdByClass(List<String> idslist, String majorName,String status) {
        List<String> list=new ArrayList<>();
        Map<String,Object> map=new HashMap<>();
        map.put("idslist",idslist);
        map.put("majorName",majorName);
        map.put("status",status);
        list= activityEndCheckDao.selectApplyIdByClass(map);
        return list;
    }

    @Override
    public List<String> selectApplyIdByStudent(List<String> idslist,String status) {
        List<String> list=new ArrayList<>();
        Map<String,Object> map=new HashMap<>();
        map.put("idslist",idslist);
        map.put("status",status);
        list= activityEndCheckDao.selectApplyIdByStudentID(map);
        return list;
    }
}
