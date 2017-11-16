package com.controllers.mobile;

import com.Services.interfaces.ActivitiesService;
import com.model.DataForDatagrid;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Set;

/**
 * 类的描述
 *
 * @Author lirf
 * @Date 2017/6/7 13:58
 */
@Controller
@RequestMapping(value = "/AppActivityInfo")
public class AppActivityController {

    @Autowired
    public ActivitiesService activitiesService;

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
        System.out.println();
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
            m.put("activityLevel", m.get("supLevle"));
            if (m.get("supActivityTitle") != null && !m.get("supActivityTitle").equals("")) {
                m.put("activityTitle", m.get("supActivityTitle"));
            } else {
                if (m.get("workName") != null && !m.get("workName").equals("")) {
                    m.put("activityTitle", m.get("workName"));
                } else if (m.get("shipName") != null && !m.get("shipName").equals("")) {
                    m.put("activityTitle", m.get("shipName"));
                } else if (m.get("scienceName") != null && !m.get("scienceName").equals("")) {
                    m.put("activityTitle", m.get("scienceName"));
                    System.out.println();
                }
            }
            result.add(m);
        }
        int total = result.size();
        int start = (pagenum - 1) * pagesize;
        if (start > result.size()) {
            List<Map<String, String>> list = null;
            data.setRows(list);
            data.setTotal(total);
            return data;
        }
        int end = start + pagesize;
        if (end > result.size()) {
            end = result.size();
        }
        result = result.subList(start, end);
        data.setDatas(result);
        data.setTotal(total);
        return data;
    }
}
