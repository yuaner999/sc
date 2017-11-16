package com.controllers;

import com.dao.interfaces.SysStatisicDao;
import org.apache.commons.collections.map.HashedMap;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.util.HashMap;
import java.util.Map;

/**
 * 统计信息
 * 如：多少人使用该系统，多少人参加活动，多少人生成成绩单
 * Created by hong on 2017/4/19.
 */
@Controller
@RequestMapping("/sysstatistics")
public class SysStatisticController {
    @Autowired
    private SysStatisicDao sysStatisicDao;

    @RequestMapping("/getstatistics")
    @ResponseBody
    public Map<String ,Object> getStatistic(HttpServletRequest request){
        HttpSession session = request.getSession();
        String classId = (String) session.getAttribute("classId");
        String collegeId = (String) session.getAttribute("collegeId");

        Map<String, String> newMap = new HashMap<>();
        newMap.put("classId",classId);
        newMap.put("collegeId",collegeId);

        int used=sysStatisicDao.howManyUsed(newMap);
        int applyed=sysStatisicDao.howManyApplyed(newMap);
        int gennered=sysStatisicDao.howManyGennered(newMap);
        Map<String ,Object> map=new HashedMap(3);
        map.put("used",used);
        map.put("applyed",applyed);
        map.put("gennered",gennered);
        return map;
    }
}
