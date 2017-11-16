package com.controllers;

import com.Services.interfaces.ActivitiesService;
import com.github.pagehelper.Page;
import com.model.ActivityQuery;
import com.model.DataForDatagrid;
import com.model.Dict;
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
@RequestMapping("/jsons")
public class ActivitiesController {
    @Autowired
    private ActivitiesService activitiesService;

    @RequestMapping("/loadActivities")
    @ResponseBody
    public DataForDatagrid loadActivities(String aclass, String alevel, String anature, String apower, String apartic) {
        DataForDatagrid data = new DataForDatagrid();
        String[] str = {aclass, alevel, anature, apower, apartic};
        List<Map<String, String>> list = activitiesService.loadActivities(str);
        data.setDatas(list);
        return data;
    }


    /**
     * 创建人
     *
     * @return
     */
    @RequestMapping("/loadactivityCreator")
    @ResponseBody
    public DataForDatagrid loadtrainingMode() {
        DataForDatagrid data = new DataForDatagrid();
        List<String> list = activitiesService.loadactivityCreator();
        data.setDatas(list);
        return data;
    }


    /**
     * 搜索活动信息
     *
     * @return
     */
    @RequestMapping("/loadactivities")
    @ResponseBody
    public DataForDatagrid loadStudents(String rows, String page, HttpServletRequest request) {
        DataForDatagrid data = new DataForDatagrid();
        //从请求中获得所有的参数
        Map<String, String[]> parameterMap = request.getParameterMap();
        //为了能让map 修改  通过 request.getParameterMap(); 获得的map不可以修改
        Map<String, Object> newmap = new HashMap<>(36);
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
        String classId = (String) session.getAttribute("classId");
        newmap.put("collegeId", collegeId);
        newmap.put("classId", classId);
        int pagenum = 1, pagesize = 20;
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
        List<ActivityQuery> result = activitiesService.newloadactivities(newmap, pagenum, pagesize);
        data.setDatas(result);
        data.setTotal((int) ((Page) result).getTotal());
        return data;
    }

    @RequestMapping("/loadCheckActivities")
    @ResponseBody
    public DataForDatagrid loadCheckActivities(String rows, String page, HttpServletRequest request) {
        DataForDatagrid data = new DataForDatagrid();
        //从请求中获得所有的参数
        Map<String, String[]> parameterMap = request.getParameterMap();
        //为了能让map 修改  通过 request.getParameterMap(); 获得的map不可以修改
        Map<String, Object> newmap = new HashMap<>(36);
        Set<String> keys = parameterMap.keySet();
        for (String s : keys) {
            //取中map中每个元素（数组）的第一个，并放到新的map中  处理下才有值  负责全是地址
            // 用newmap处理  通过key获得value
            String[] value = parameterMap.get(s);
            if (value.length == 0) continue;
            newmap.put(s, value[0]);
        }
        int pagenum = 1, pagesize = 10;
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
        List<Map<String, String>> result = activitiesService.loadCheckActivitiesNew(newmap);
        List<Map<String, String>> result2 = activitiesService.loadCheckActNew(newmap);
        for (Map<String, String> m : result2) {
            m.put("signUpTime1", m.get("takeDate1"));
            m.put("activityTitle", m.get("supActivityTitle"));
            m.put("activityClass", m.get("supClass"));
            m.put("activityPowers", m.get("supPowers"));
            m.put("activityAward", m.get("supAward"));
            if (m.get("supActivityTitle") != null && !m.get("supActivityTitle").equals("")) {
                m.put("activityTitle", m.get("supActivityTitle"));
            } else {
                if (m.get("workName") != null && !m.get("workName").equals("")) {
                    m.put("activityTitle", m.get("workName"));
                } else if (m.get("shipName") != null && !m.get("shipName").equals("")) {
                    m.put("activityTitle", m.get("shipName"));
                } else if (m.get("scienceName") != null && !m.get("scienceName").equals("")) {
                    m.put("activityTitle", m.get("scienceName"));
                }
            }
            result.add(m);
        }
        int total = result.size();
        int start = (pagenum - 1) * pagesize;
        int end = start + pagesize;
        if (end > result.size()) end = result.size();
        result = result.subList(start, end);
        data.setDatas(result);
        data.setTotal(total);
        return data;
    }

    @RequestMapping("/loadCheckAct")
    @ResponseBody
    public DataForDatagrid loadCheckAct(String rows, String page, HttpServletRequest request) {
        DataForDatagrid data = new DataForDatagrid();
        //从请求中获得所有的参数
        Map<String, String[]> parameterMap = request.getParameterMap();
        //为了能让map 修改  通过 request.getParameterMap(); 获得的map不可以修改
        Map<String, Object> newmap = new HashMap<>(36);
        Set<String> keys = parameterMap.keySet();
        for (String s : keys) {
            //取中map中每个元素（数组）的第一个，并放到新的map中  处理下才有值  负责全是地址
            // 用newmap处理  通过key获得value
            String[] value = parameterMap.get(s);
            if (value.length == 0) continue;
            newmap.put(s, value[0]);
        }
        int pagenum = 1, pagesize = 10;
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
        List result = activitiesService.loadCheckAct(newmap, pagenum, pagesize);
        data.setDatas(result);
        data.setTotal((int) ((Page) result).getTotal());
        return data;
    }

    @RequestMapping("/loadCheckCollege")
    @ResponseBody
    public DataForDatagrid v() {
        DataForDatagrid data = new DataForDatagrid();
        List<String> list = activitiesService.loadCheckCollege();
        data.setDatas(list);
        return data;
    }

    //    自动匹配活动标题
    @RequestMapping("/loadActivityTitle")
    @ResponseBody
    public DataForDatagrid loadActivityTitle() {
        DataForDatagrid data = new DataForDatagrid();
        List<String> list = activitiesService.loadActivityTitle();
        data.setDatas(list);
        return data;
    }

    /**
     * 六大类活动总分数
     *
     * @return
     */
    @RequestMapping("/loadActivityScoreTotal")
    @ResponseBody
    public DataForDatagrid loadActivityScoreTotal() {
        DataForDatagrid data = new DataForDatagrid();
        List<Dict> list = activitiesService.loadActivityScoreTotal();
        data.setDatas(list);
        return data;
    }

    /**
     * 六大类活动已得到分数
     *
     * @return
     */
    @RequestMapping("/loadActivityScoreGet")
    @ResponseBody
    public DataForDatagrid loadActivityScoreGet(HttpServletRequest request) {
        DataForDatagrid data = new DataForDatagrid();

        //从请求中获得所有的参数
        Map<String, String[]> parameterMap = request.getParameterMap();
        //为了能然map 修改  通过 request.getParameterMap(); 获得的map不可以修改
        Map<String, Object> newmap = new HashMap<>(36);
        Set<String> keys = parameterMap.keySet();
        for (String s : keys) {
            //取中map中每个元素（数组）的第一个，并放到新的map中  处理下才有值  负责全是地址
            // 用newmap处理  通过key获得value
            String[] value = parameterMap.get(s);
            if (value.length == 0) continue;
            newmap.put(s, value[0]);
        }
        List<Dict> list = activitiesService.loadActivityScoreGet(newmap);
        data.setDatas(list);
        return data;
    }

    /**
     * 六大类活动已得到分数（学生自己添加）
     *
     * @return
     */
    @RequestMapping("/loadActivityScoreGets")
    @ResponseBody
    public DataForDatagrid loadActivityScoreGets(HttpServletRequest request) {
        DataForDatagrid data = new DataForDatagrid();
        String id = request.getParameter("loginId");
        List<Map> list = activitiesService.loadActivityScoreGets(id);
        data.setDatas(list);
        return data;
    }

    /**
     * 活动管理 报名查看 （需要分页）
     *
     * @return
     */

    //和loadSchoolActivityapply重复，加了空格隐藏了
    @RequestMapping("/loadSchoolActivityapply  ")
    @ResponseBody
    public DataForDatagrid loadSchoolActivityapply(HttpServletRequest request, String rows, String page) {
        DataForDatagrid data = new DataForDatagrid();
        Map<String, String[]> parameterMap = request.getParameterMap();
        //为了能让map 修改  通过 request.getParameterMap(); 获得的map不可以修改
        Map<String, Object> newmap = new HashMap<>(36);
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
        String deptId = (String) session.getAttribute("deptId");
        newmap.put("deptId", deptId);
        String collegeId = (String) session.getAttribute("collegeId");
        newmap.put("collegeId", collegeId);
        String gradeId = (String) session.getAttribute("gradeId");
        newmap.put("gradeId", gradeId);
        int pagenum = 1, pagesize = 10;
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
        List<Map> list = activitiesService.loadSchoolActivityapply(newmap, pagenum, pagesize);
        data.setDatas(list);
        data.setTotal((int) ((Page) list).getTotal());
        return data;
    }

    @RequestMapping("/loadSupplementSchoolmybatis")
    @ResponseBody
    public DataForDatagrid loadSupplementSchoolmybatis(HttpServletRequest request) {
        DataForDatagrid data = new DataForDatagrid();

        Map<String, String[]> parameterMap = request.getParameterMap();
        //为了能让map 修改  通过 request.getParameterMap(); 获得的map不可以修改
        Map<String, Object> newmap = new HashMap<>(36);
        Set<String> keys = parameterMap.keySet();
        for (String s : keys) {
            //取中map中每个元素（数组）的第一个，并放到新的map中  处理下才有值  负责全是地址
            // 用newmap处理  通过key获得value
            String[] value = parameterMap.get(s);
            if (value.length == 0) continue;
            newmap.put(s, value[0]);
        }

        List<Map> list = activitiesService.loadSupplementSchoolmybatis(newmap, Integer.parseInt((String) newmap.get("page")), Integer.parseInt((String) newmap.get("rows")));
        data.setDatas(list);
        data.setTotal((int) ((Page) list).getTotal());
        return data;
    }
}
