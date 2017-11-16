package com.dao.interfaces;

import org.springframework.stereotype.Repository;

import java.util.Map;

/**
 * Created by wd on 2016/8/23.
 */
@Repository
public interface CopyInfoDao {
    void CopyStudInfo(Map<String, Object> map);
    void CopyClassInfo(Map<String, Object> map);
    void CopyCollegeInfo(Map<String, Object> map);
    void CopyGradeInfo(Map<String, Object> map);
    void CopyMajorInfo(Map<String, Object> map);
}
