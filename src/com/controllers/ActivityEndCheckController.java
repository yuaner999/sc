package com.controllers;

import com.Services.interfaces.ActivityEndCheckService;
import com.github.pagehelper.Page;
import com.model.DataForDatagrid;
import com.model.ResultData;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.Map;

/**
 * Created by guoqiang on 2016/11/28.
 */
@Controller
@RequestMapping("/check")
public class ActivityEndCheckController {
    @Autowired
    private ActivityEndCheckService activityEndCheckService;

    /**
     *加载学院审核数据
     * @return
     */
    @RequestMapping("/loadCheckNum")
    @ResponseBody
    public DataForDatagrid loadCheckNum(String rows,String page,String loadstatus){
        DataForDatagrid data = new DataForDatagrid();
        int pagenum=1,pagesize=10;
        if(rows!=null && !rows.equals("")) {
            try{
                pagesize=Integer.parseInt(rows);
            }catch (Exception e){
                e.printStackTrace();
            }
        }
        if(page!=null && !page.equals("")) {
            try{
                pagenum=Integer.parseInt(page);
            }catch (Exception e){
                e.printStackTrace();
            }
        }
        List<Map> list = activityEndCheckService.loadCheckNum(pagenum,pagesize,loadstatus);
        data.setDatas(list);
        data.setTotal((int)((Page)list).getTotal());
        return data;
    }
    /**
     *加载专业审核数据
     * @return
     */
    @RequestMapping("/loadCheckMajorNum")
    @ResponseBody
    public DataForDatagrid loadCheckMajorNum(String rows,String page,String collegeName,String status,String loadstatus){
        DataForDatagrid data = new DataForDatagrid();
        int pagenum=1,pagesize=10;
        if(rows!=null && !rows.equals("")) {
            try{
                pagesize=Integer.parseInt(rows);
            }catch (Exception e){
                e.printStackTrace();
            }
        }
        if(page!=null && !page.equals("")) {
            try{
                pagenum=Integer.parseInt(page);
            }catch (Exception e){
                e.printStackTrace();
            }
        }
        List<Map> list = activityEndCheckService.loadCheckMajorNum(pagenum,pagesize,collegeName,status,loadstatus);
        data.setDatas(list);
        data.setTotal((int)((Page)list).getTotal());
        return data;
    }
    /**
     *加载班级审核数据
     * @return
     */
    @RequestMapping("/loadCheckClassNum")
    @ResponseBody
    public DataForDatagrid loadCheckClassNum(String rows,String page,String majorName,String status,String loadstatus){
        DataForDatagrid data = new DataForDatagrid();
        int pagenum=1,pagesize=10;
        if(rows!=null && !rows.equals("")) {
            try{
                pagesize=Integer.parseInt(rows);
            }catch (Exception e){
                e.printStackTrace();
            }
        }
        if(page!=null && !page.equals("")) {
            try{
                pagenum=Integer.parseInt(page);
            }catch (Exception e){
                e.printStackTrace();
            }
        }
        List<Map> list = activityEndCheckService.loadCheckClassNum(pagenum,pagesize,majorName,status,loadstatus);
        data.setDatas(list);
        data.setTotal((int)((Page)list).getTotal());
        return data;
    }
    /**
     *加载学生审核数据
     * @return
     */
    @RequestMapping("/loadCheckStudentNum")
    @ResponseBody
    public DataForDatagrid loadCheckStudentNum(String rows,String page,String className,String status,String loadstatus){
        DataForDatagrid data = new DataForDatagrid();
        int pagenum=1,pagesize=10;
        if(rows!=null && !rows.equals("")) {
            try{
                pagesize=Integer.parseInt(rows);
            }catch (Exception e){
                e.printStackTrace();
            }
        }
        if(page!=null && !page.equals("")) {
            try{
                pagenum=Integer.parseInt(page);
            }catch (Exception e){
                e.printStackTrace();
            }
        }
        List<Map> list = activityEndCheckService.loadCheckStudentNum(pagenum,pagesize,className,status,loadstatus);
        data.setDatas(list);
        data.setTotal((int)((Page)list).getTotal());
        return data;
    }
    /**
     *验证学校重复审核
     * @return
     */
    @RequestMapping("/testSchoolRecheck")
    @ResponseBody
    public DataForDatagrid testSchoolRecheck(String stuCollageName){
        DataForDatagrid data=new DataForDatagrid();
        List<String> idslist=new ArrayList<>();
        if(stuCollageName!=null&&!stuCollageName.equals("")){
            idslist= Arrays.asList(stuCollageName.split("[|]"));
        }
        List<Map> result=activityEndCheckService.testSchoolRecheck(idslist);
        data.setDatas(result);
        return data;
    }
    /**
     *验证学院重复审核
     * @return
     */
    @RequestMapping("/testCollegeRecheck")
    @ResponseBody
    public DataForDatagrid testCollegeRecheck(String stuMajorName,String collegeName,String status){
        DataForDatagrid data=new DataForDatagrid();
        List<String> idslist=new ArrayList<>();
        if(stuMajorName!=null&&!stuMajorName.equals("")){
            idslist= Arrays.asList(stuMajorName.split("[|]"));
        }
        List<Map> result=activityEndCheckService.testCollegeRecheck(idslist,collegeName,status);
        data.setDatas(result);
        return data;
    }
    /**
     *验证专业重复审核
     * @return
     */
    @RequestMapping("/testMajorRecheck")
    @ResponseBody
    public DataForDatagrid testMajorRecheck(String stuClassName,String majorName,String status){
        DataForDatagrid data=new DataForDatagrid();
        List<String> idslist=new ArrayList<>();
        if(stuClassName!=null&&!stuClassName.equals("")){
            idslist= Arrays.asList(stuClassName.split("[|]"));
        }
        List<Map> result=activityEndCheckService.testMajorRecheck(idslist,majorName,status);
        data.setDatas(result);
        return data;
    }
    /**
     *验证班级重复审核
     * @return
     */
    @RequestMapping("/testClassRecheck")
    @ResponseBody
    public DataForDatagrid testClassRecheck(String applyStudentId,String status){
        DataForDatagrid data=new DataForDatagrid();
        List<String> idslist=new ArrayList<>();
        if(applyStudentId!=null&&!applyStudentId.equals("")){
            idslist= Arrays.asList(applyStudentId.split("[|]"));
        }
        List<Map> result=activityEndCheckService.testClassRecheck(idslist,status);
        data.setDatas(result);
        return data;
    }
    @RequestMapping("/SchoolAuditApply")
    @ResponseBody
    public ResultData SchoolAuditApply(String stuCollageName,String type){
        ResultData data=new ResultData();
        List<String> idslist=new ArrayList<>();
        if(stuCollageName!=null&&!stuCollageName.equals("")){
            idslist=Arrays.asList(stuCollageName.split("[|]"));
        }
        List<String> li=activityEndCheckService.selectApplyIdByCollege(idslist);
        int result=0;
        if(li.size()>0){
             result=activityEndCheckService.SchoolAuditApply(li,type);
        }
        data.setStatusByDBResult(result);
        data.setData(result);
        data.setMsg(li.size()+"");
        return data;
    }
    @RequestMapping("/CollegeAuditApply")
    @ResponseBody
    public ResultData CollegeAuditApply(String stuMajorName,String type,String collegeName,String status){
        ResultData data=new ResultData();
        List<String> idslist=new ArrayList<>();
        if(stuMajorName!=null&&!stuMajorName.equals("")){
            idslist=Arrays.asList(stuMajorName.split("[|]"));
        }
        List<String> li=activityEndCheckService.selectApplyIdByMajor(idslist,collegeName,status);
        int result=0;
        if(li.size()>0){
            result=activityEndCheckService.CollegeAuditApply(li,type,status);
        }
        data.setStatusByDBResult(result);
        data.setData(result);
        data.setMsg(li.size()+"");
        return data;
    }
    @RequestMapping("/MajorAuditApply")
    @ResponseBody
    public ResultData MajorAuditApply(String stuClassName,String type,String majorName,String status){
        ResultData data=new ResultData();
        List<String> idslist=new ArrayList<>();
        if(stuClassName!=null&&!stuClassName.equals("")){
            idslist=Arrays.asList(stuClassName.split("[|]"));
        }
        List<String> li=activityEndCheckService.selectApplyIdByClass(idslist,majorName,status);
        int result=0;
        if(li.size()>0){
            result=activityEndCheckService.MajorAuditApply(li,type,status);
        }
        data.setStatusByDBResult(result);
        data.setData(result);
        data.setMsg(li.size()+"");
        return data;
    }
    @RequestMapping("/ClassAuditApply")
    @ResponseBody
    public ResultData ClassAuditApply(String applyId,String type,String status){
        ResultData data=new ResultData();
        List<String> idslist=new ArrayList<>();
        if(applyId!=null&&!applyId.equals("")){
            idslist=Arrays.asList(applyId.split("[|]"));
        }
        List<String> li=activityEndCheckService.selectApplyIdByStudent(idslist,status);
        int result=0;
        if(li.size()>0){
            result=activityEndCheckService.ClassAuditApply(li,type,status);
        }
        data.setStatusByDBResult(result);
        data.setData(result);
        data.setMsg(li.size()+"");
        return data;
    }
    @RequestMapping("/superAuditApply")
    @ResponseBody
    public ResultData superAuditApply(String applyId,String type,String status){
        ResultData data=new ResultData();
        List<String> idslist=new ArrayList<>();
        if(applyId!=null&&!applyId.equals("")){
            idslist=Arrays.asList(applyId.split("[|]"));
        }
        int result=0;
        if(idslist.size()>0){
            result=activityEndCheckService.superAuditApply(idslist,type,status);
        }
        data.setStatusByDBResult(result);
        data.setData(result);
        return data;
    }
}
