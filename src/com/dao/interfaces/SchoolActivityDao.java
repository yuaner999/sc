package com.dao.interfaces;

import com.model.activities;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Map;

/**
 * Created by sw on 2016/9/12.
 */
@Repository
public interface SchoolActivityDao {
    /**
     * 校院活动
     * @return list
     */
    List<activities> loadSchoolActivityList(String studentID);

    /**
     * 学院活动
     * @return list
     */
    List<activities> loadcollegeActivityList(String studentID);

    /**
     * 该学生参与的活动 map 过滤条件
     * @param map
     * @return
     */
    List<Map<String,String>> laodStudentActivity(Map<String,String> map);
    /**
     * 获取改活动的非活动类
     * @param studentID
     * @return
     */
    List<Map<String,String>> laodNotActivtity(String studentID);

}
