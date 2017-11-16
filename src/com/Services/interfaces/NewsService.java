package com.Services.interfaces;

import java.util.List;
import java.util.Map;

/**
 * Created by admin on 2016/9/8.
 */
public interface NewsService {

    /**
     * 分页加载学院的新闻信息
     * @param page 当前页
     * @param rows 每页显示的新闻书数
     * @return
     */
    List<Map<String,String>> loadNewsCollegePage(int page, int rows,String newsClass);
    /**
     * 分页加载学院的新闻信息
     * @param page
     * @param rows
     * @return
     */
    List<Map<String,String>> loadNewsSchoolPage(int page, int rows,String newsClass);
    /**
     * 按id加载新闻的信息
     * @param newsId 新闻的id
     * @return
     */
    List<Map<String,String>> loadNewsById(String newsId);

    /**
     *
     * @param page
     * @param rows
     * @param state
     * @return
     */
    List<Map<String,String>> loadActivityStateBypage(int page, int rows,String state,String studentid);
}
