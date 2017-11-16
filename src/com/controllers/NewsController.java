package com.controllers;

import com.Services.interfaces.NewsService;
import com.github.pagehelper.Page;
import com.model.DataForDatagrid;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import java.util.List;
import java.util.Map;

/**
 * 新闻处理
 * @author Jiangda
 * Created by admin on 2016/9/8.
 */
@Controller
@RequestMapping("/news")
public class NewsController {
    @Autowired
    private NewsService newsService;
    /**
     * 按id加载新闻信息
     * @return
     */
    @RequestMapping(value = "/loadNewsById")
    @ResponseBody
    public DataForDatagrid loadNewsById(HttpServletRequest request){
        String newsId = request.getParameter("newsId");
        DataForDatagrid data = new DataForDatagrid();
        List<Map<String,String>> c= newsService.loadNewsById(newsId);
        data.setDatas(c);
        return data;
    }

    /**
     * 分页查询学院的新闻信息
     * @return
     */
    @RequestMapping(value = "/loadCollegeNewsBypage")
    @ResponseBody
    public DataForDatagrid getCollegeNews(HttpServletRequest request,String newsClass){
        int[] str =  getInt(request);
        int page = str[0];
        int rows = str[1];
        DataForDatagrid data = new DataForDatagrid();
        List<Map<String,String>> c= newsService.loadNewsCollegePage(page,rows,newsClass);
        data.setDatas(c);
        data.setTotal((int)((Page)c).getTotal());
        return data;
    }
    /**
     * 分页查询学校的新闻信息
     * @return
     */
    @RequestMapping(value = "/loadSchoolNewsBypage")
    @ResponseBody
    public DataForDatagrid getSChoolNews(HttpServletRequest request,String newsClass){
        int[] str =  getInt(request);
        int page = str[0];
        int rows = str[1];
        DataForDatagrid data = new DataForDatagrid();
        List<Map<String,String>> c= newsService.loadNewsSchoolPage(page,rows,newsClass);
        data.setDatas(c);
        data.setTotal((int)((Page)c).getTotal());
        return data;
    }

    /**
     * 加载学生参加的活动信息
     * @param request
     * @return
     */
    @RequestMapping(value = "/loadActivityStateBypage")
    @ResponseBody
    public DataForDatagrid loadActivityStateBypage(HttpServletRequest request){
        int[] str =  getInt(request);
        int page = str[0];
        int rows = str[1];
        String state=request.getParameter("state");
        String studentid= request.getSession().getAttribute("studentid").toString();
        DataForDatagrid data = new DataForDatagrid();
        List<Map<String,String>> c= newsService.loadActivityStateBypage(page,rows,state,studentid);
        data.setDatas(c);
        data.setTotal((int)((Page)c).getTotal());
        return data;
    }

    public  int[] getInt(HttpServletRequest request){
        int[] str = new int[2];
        String pageNum = request.getParameter("page");
        String pageSize = request.getParameter("rows");
        int page=1,rows=15;
        if(pageSize!=null && !pageSize.equals("")) {
            try{
                rows=Integer.parseInt(pageSize);
            }catch (Exception e){
                e.printStackTrace();
            }
        }
        if(pageNum!=null && !"".equals(pageNum)) {
            try{
                page=Integer.parseInt(pageNum);
            }catch (Exception e){
                e.printStackTrace();
            }
        }
        str[0] = page;
        str[1] = rows;
        return  str;
    }
}
