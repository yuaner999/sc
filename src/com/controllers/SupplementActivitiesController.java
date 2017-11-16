package com.controllers;

import com.Services.interfaces.SupplementInfoService;
import com.github.pagehelper.Page;
import com.model.DataForDatagrid;
import org.apache.poi.util.SystemOutLogger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Set;

/**
 * Created by wd on 2016/9/9.
 */
@Controller
@RequestMapping("/supplementInfo")
public class SupplementActivitiesController {
    @Autowired
    private SupplementInfoService supplementInfoService;

    /**
     * 加载补充活动信息（团支书）
     *
     * @return
     */
    @RequestMapping("/loadSupplementClass")
    @ResponseBody
    public DataForDatagrid loadSupplementClass(String rows, String page, HttpServletRequest request) {
        DataForDatagrid data = new DataForDatagrid();
        //从请求中获得所有的参数
        Map<String, String[]> parameterMap = request.getParameterMap();
        //为了能让map 修改  通过 request.getParameterMap(); 获得的map不可以修改
        Map<String, String> newmap = new HashMap<>(36);
        Set<String> keys = parameterMap.keySet();
        for (String s : keys) {
            //取中map中每个元素（数组）的第一个，并放到新的map中  处理下才有值  负责全是地址
            // 用newmap处理  通过key获得value
            String[] value = parameterMap.get(s);
            if (value.length == 0) continue;
            newmap.put(s, value[0]);
        }

        HttpSession session = request.getSession();
        String classId = (String) session.getAttribute("classId");
        newmap.put("classId", classId);

        int pagenum = 1, pagesize = 100;
        if (rows != null && !rows.equals("")) {
            try {
                pagesize = Integer.parseInt(rows);
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        if (page != null && !page.equals("")) {
            try {
                pagenum = Integer.parseInt(page);
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        List<Map<String,String>> result = supplementInfoService.loadSupplemenlPageClass(newmap,pagenum,pagesize);
        int totalCount = (int) ((Page) result).getTotal();
        System.out.print(result);
        data.setDatas(result);
        data.setTotal(totalCount);
        return data;
    }

    /**
     * 加载补充活动信息（院团委）
     *
     * @return
     */
    @RequestMapping("/loadSupplementCollege")
    @ResponseBody
    public DataForDatagrid loadSupplementCollege(String rows, String page, HttpServletRequest request) {
        DataForDatagrid data = new DataForDatagrid();
        //从请求中获得所有的参数
        Map<String, String[]> parameterMap = request.getParameterMap();
        //为了能让map 修改  通过 request.getParameterMap(); 获得的map不可以修改
        Map<String, String> newmap = new HashMap<>(36);
        Set<String> keys = parameterMap.keySet();
        for (String s : keys) {
            //取中map中每个元素（数组）的第一个，并放到新的map中  处理下才有值  负责全是地址
            // 用newmap处理  通过key获得value
            String[] value = parameterMap.get(s);
            if (value.length == 0) continue;
            newmap.put(s, value[0]);
        }

        HttpSession session = request.getSession();
        String collegeId = (String) session.getAttribute("collegeId");
        newmap.put("collegeId", collegeId);

        int pagenum = 1, pagesize = 100;
        if (rows != null && !rows.equals("")) {
            try {
                pagesize = Integer.parseInt(rows);
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        if (page != null && !page.equals("")) {
            try {
                pagenum = Integer.parseInt(page);
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        List<Map<String,String>> result = supplementInfoService.loadSupplemenlPageCollege(newmap,pagenum,pagesize);
        int totalCount = (int) ((Page) result).getTotal();
        System.out.print(result);
        data.setDatas(result);
        data.setTotal(totalCount);
        return data;
    }

    /**
     * 加载补充活动信息（校团委）
     *
     * @return
     */
    @RequestMapping("/loadSupplementSchool")
    @ResponseBody
    public DataForDatagrid loadSupplementSchool(String rows, String page, HttpServletRequest request) {
        DataForDatagrid data = new DataForDatagrid();
        //从请求中获得所有的参数
        Map<String, String[]> parameterMap = request.getParameterMap();
        //为了能让map 修改  通过 request.getParameterMap(); 获得的map不可以修改
        Map<String, String> newmap = new HashMap<>(36);
        Set<String> keys = parameterMap.keySet();
        for (String s : keys) {
            //取中map中每个元素（数组）的第一个，并放到新的map中  处理下才有值  负责全是地址
            // 用newmap处理  通过key获得value
            String[] value = parameterMap.get(s);
            if (value.length == 0) continue;
            newmap.put(s, value[0]);
        }

        HttpSession session = request.getSession();
        String collegeId = (String) session.getAttribute("collegeId");
        newmap.put("collegeId", collegeId);

        int pagenum = 1, pagesize = 100;
        if (rows != null && !rows.equals("")) {
            try {
                pagesize = Integer.parseInt(rows);
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        if (page != null && !page.equals("")) {
            try {
                pagenum = Integer.parseInt(page);
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        List<Map<String,String>> result = supplementInfoService.loadSupplementPageSchool(newmap,pagenum,pagesize);
        int totalCount = (int) ((Page) result).getTotal();
        System.out.print(result);
        data.setDatas(result);
        data.setTotal(totalCount);
        return data;
    }
}
