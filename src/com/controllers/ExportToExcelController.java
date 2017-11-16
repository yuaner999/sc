package com.controllers;

//import com.Services.interfaces.BuyOrderService;

import com.Services.interfaces.ActivitiesService;
import com.model.ActivityQuery;
import com.utils.ExcelUtil;
import com.utils.Utils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.util.*;

/**
 * 订单导出excel报表
 * @author hong
 * Created by admin on 2016/9/30.
 */
@Controller
@RequestMapping("/export")
public class ExportToExcelController {
    @Autowired
    private ActivitiesService activitiesService;
    /**
     * 导出excel报表
     * @param request
     * @param response
     */
    @RequestMapping("/conditions")
    public void exportBuyOrder(HttpServletRequest request, HttpServletResponse response){
        String fileName = "活动的相关信息";
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
        HttpSession session=request.getSession();
        String collegeId= (String) session.getAttribute("collegeId");
        String classId= (String) session.getAttribute("classId");
        newmap.put("collegeId",collegeId);
        newmap.put("classId",classId);
        List<ActivityQuery> oldresult=activitiesService.newloadactivities(newmap,1,10000);
        List<Map<String,Object>> result=new ArrayList<>();
        for(ActivityQuery activityQuery:oldresult){
            //对象转map
            result.add(Utils.ObjToMap(activityQuery));
        }
//        System.out.println("result:" +result);
        String columnNames[]={"活动标题","活动范围","活动级别","活动类型","活动性质","活动增加能力",
                "校内校外","活动地点","活动参与方式","活动开始时间","活动结束时间","活动创建时间",
                "活动创建方","申请状态","获得奖励","申请时间","签到状态","签到时间","学生学号","学生姓名",
                "学生班级","学生年级","学生学院","活动评分"};//列名
        String columnkeys[] = {"activityTitle","activityArea","activityLevleMean","activityClassMean",
                "activityNatureMean","activityPowers","activityIsInschool","activityLocation","activityParticipation",
                "activitySdate","activityEdate","activityCreatedate","activityCreator","applyAuditStatus",
                "activityAwardMean","applyDate","signUpStatus","signUpTime","studentID","studentName","stuClassName",
                "stuGradeName","stuCollageName","activitypoint"};//map中的key

        ByteArrayOutputStream os = new ByteArrayOutputStream();
        try {
            ExcelUtil.createWorkBook(result,columnkeys,columnNames,fileName).write(os);
        } catch (IOException e) {
            e.printStackTrace();
        }
        ExcelUtil.sendExcel(response,os,fileName);
    }


}
