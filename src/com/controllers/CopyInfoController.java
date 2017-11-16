package com.controllers;

import com.model.ResultData;
import com.task.CopyTaskService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

/**
 * Created by wd on 2016/8/23.
 */
@Controller
@RequestMapping("/jsons")
public class CopyInfoController {
    @Autowired
    private CopyTaskService copyTaskService;
    @RequestMapping("/CopyStudInfo")
    @ResponseBody
    public void CopyStudInfo(){copyTaskService.runInfo(1); }
    @RequestMapping("/CopyClassInfo")
    @ResponseBody
    public void CopyClassInfo(){
        copyTaskService.runInfo(2);
    }
    @RequestMapping("/CopyCollegeInfo")
    @ResponseBody
    public void CopyCollegeInfo(){
        copyTaskService.runInfo(4);
    }
    @RequestMapping("/CopyGradeInfo")
    @ResponseBody
    public void CopyGradeInfo(){
        copyTaskService.runInfo(3);
    }
    @RequestMapping("/CopyMajorInfo")
    @ResponseBody
    public void CopyMajorInfo(){
        copyTaskService.runInfo(5);
    }

}