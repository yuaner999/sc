package com.Services.interfaces;

import com.model.activities;

import java.util.List;
import java.util.Map;

/**
 * Created by sw on 2016/9/12.
 */
public interface SchoolActivityService {
    /**
     * 校院活动 1  学院活动 2  type
     * @return list
     */
    List<activities> loadSchoolActivityList(int rows,int index,int type,String studentID);

    /**
     * 该学生参与的活动 str[] 过滤条件
     * @param str
     * @return
     */
    List<Map<String,String>> laodStudentActivity(String[] str);

    /**
     * 获取改活动的非活动类
     * @param studentID
     * @return
     */
    List<Map<String,String>> laodNotActivtity(String studentID);
}
