package com.dao.interfaces;

import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Map;

/**
 * 分页查询学校的信息
 * @author Jiangda
 * Created by admin on 2016/9/8.
 */
@Repository
public interface NewsDao {
    /**
     * 分页加载学院的新闻信息
     * @return
     */
   List<Map<String,String>> loadNewsCollegePage(String newsClass);
    /**
     * 分页加载学校的新闻信息
     * @return
     */
    List<Map<String,String>> loadNewsSchoolPage(String newsClass);
    /**
     * 按id加载新闻的信息
     * @param newsId 新闻的id
     * @return
     */
    List<Map<String,String>> loadNewsById(String newsId);

    /**
     * 加载学生参加活动信息
     * @param state
     * @return
     */
    List<Map<String,String>> loadActivityStateBypage(String state,String studentid);
}
