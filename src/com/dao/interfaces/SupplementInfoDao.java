package com.dao.interfaces;

import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Map;

/**
 * Created by shaowen on 2016/11/11.
 */
@Repository
public interface SupplementInfoDao {
    //班级
    List<Map<String,String>> loadSupplemenlClass(Map<String, String> map);
    //学院
    List<Map<String,String>> loadSupplemenlCollege(Map<String, String> map);
    //学校
    List<Map<String,String>> loadSupplementSchool(Map<String, String> map);
}
