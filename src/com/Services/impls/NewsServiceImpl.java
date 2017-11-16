package com.Services.impls;

import com.Services.interfaces.NewsService;
import com.dao.interfaces.NewsDao;
import com.github.pagehelper.PageHelper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;

/**
 * Created by admin on 2016/9/8.
 */
@Service
public class NewsServiceImpl implements NewsService {
    @Autowired
    private NewsDao newsDao;
    /**
     * 分页加载学院的新闻信息
     * @param page
     * @param rows
     * @return
     */
    @Override
    public List<Map<String,String>> loadNewsCollegePage(int page, int rows,String newsClass){
        //需要设置下 不用limit  这样就不需要参数 返回可以用data.total和data.rows
        PageHelper.startPage(page,rows);
        return newsDao.loadNewsCollegePage(newsClass);
    }
    /**
     * 分页加载学校的新闻信息
     * @param page
     * @param rows
     * @return
     */
    @Override
    public List<Map<String,String>> loadNewsSchoolPage(int page, int rows,String newsClass){
        //需要设置下 不用limit  这样就不需要参数 返回可以用data.total和data.rows
        PageHelper.startPage(page,rows);
        return newsDao.loadNewsSchoolPage(newsClass);
    }

    /**
     * 按新闻的id查询新闻信息
     * @param newsId 新闻的id
     * @return
     */
    @Override
    public List<Map<String, String>> loadNewsById(String newsId) {
        return newsDao.loadNewsById(newsId);
    }

    @Override
    public List<Map<String, String>> loadActivityStateBypage(int page, int rows, String state,String studentid) {
        PageHelper.startPage(page,rows);
        return newsDao.loadActivityStateBypage(state,studentid);

    }
}
