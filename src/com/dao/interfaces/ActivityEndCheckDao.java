package com.dao.interfaces;

import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Map;

/**
 * Created by guoqiang on 2016/11/28.
 */
@Repository
public interface ActivityEndCheckDao {
    List<Map> loadCheckNum(Map map);
    List<Map> loadCheckMajorNum(Map map);
    List<Map> loadCheckClassNum(Map map);
    List<Map> loadCheckStudentNum(Map map);
    List<Map> testSchoolRecheck(Map<String,Object> map);
    List<Map> testCollegeRecheck(Map<String,Object> map);
    List<Map> testMajorRecheck(Map<String,Object> map);
    List<Map> testClassRecheck(Map<String,Object> map);
    int SchoolAuditApply(Map<String,Object> map);
    int CollegeAuditApply(Map<String,Object> map);
    int MajorAuditApply(Map<String,Object> map);
    int ClassAuditApply(Map<String,Object> map);
    int superAuditApply(Map<String,Object> map);
    List<String> selectApplyIdByCollege(Map<String,Object> map);
    List<String> selectApplyIdByMajor(Map<String,Object> map);
    List<String> selectApplyIdByClass(Map<String,Object> map);
    List<String> selectApplyIdByStudentID(Map<String,Object> map);
}
