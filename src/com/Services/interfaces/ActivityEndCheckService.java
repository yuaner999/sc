package com.Services.interfaces;

import java.util.List;
import java.util.Map;

/**
 * Created by guoqiang on 2016/11/28.
 */
public interface ActivityEndCheckService {
    List<Map> loadCheckNum(int pagenum,int pagesize,String loadstatus);
    List<Map> loadCheckMajorNum(int pagenum,int pagesize,String collegeName,String status,String loadstatus);
    List<Map> loadCheckClassNum(int pagenum,int pagesize,String majorName,String status,String loadstatus);
    List<Map> loadCheckStudentNum(int pagenum,int pagesize,String className,String status,String loadstatus);
    List<Map> testSchoolRecheck(List<String> list);
    List<Map> testCollegeRecheck(List<String> list,String collegeName,String status);
    List<Map> testMajorRecheck(List<String> list,String majorName,String status);
    List<Map> testClassRecheck(List<String> list,String status);
    int SchoolAuditApply(List<String> li,String type);
    int CollegeAuditApply(List<String> li,String type,String status);
    int MajorAuditApply(List<String> li,String type,String status);
    int ClassAuditApply(List<String> li,String type,String status);
    int superAuditApply(List<String> li,String type,String status);
    List<String> selectApplyIdByCollege(List<String> list);
    List<String> selectApplyIdByMajor(List<String> list,String collegeName,String status);
    List<String> selectApplyIdByClass(List<String> list,String majorName,String status);
    List<String> selectApplyIdByStudent(List<String> list,String status);
}
