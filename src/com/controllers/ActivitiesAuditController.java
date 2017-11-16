package com.controllers;

import com.Services.interfaces.ActivityapplyService;
import com.model.DataForDatagrid;
import com.model.ResultData;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.*;

/**
 * Created by shaowen on 2016/11/9.
 */
@Controller
@RequestMapping("/apply")
public class ActivitiesAuditController {
    @Autowired
    private ActivityapplyService activityapplyService;

    /**
     * 班级团支书审核
     * @param applyId
     * @param Type
     * @return
     */
    @RequestMapping("/ClassAudit")
    @ResponseBody
    public ResultData ClassAudit(String applyId, String Type) {
        ResultData data = new ResultData();
        List<String> idslist = new ArrayList<>();
        if (applyId != null && !applyId.equals("")) {
            idslist = Arrays.asList(applyId.split("[|]"));
//            System.out.println(idslist);
//            System.out.println(Type);
        }
        if (Type != null && !Type.equals("")) {
            int result = activityapplyService.editActivityApply(idslist, Type, 0);
            data.setStatusByDBResult(result);
            data.setData(result);
        }
        return data;
    }

    /**
     * 学院审核
     * @param applyId
     * @param Type
     * @return
     */
    @RequestMapping("/CollegeAudit")
    @ResponseBody
    public ResultData CollegeAudit(String applyId, String Type) {
        ResultData data = new ResultData();
        List<String> idslist = new ArrayList<>();
        if (applyId != null && !applyId.equals("")) {
            idslist = Arrays.asList(applyId.split("[|]"));
//            System.out.println(idslist);
//            System.out.println(Type);
        }
        if (Type != null && !Type.equals("")) {
            int result = activityapplyService.editActivityApply(idslist, Type, 1);
            data.setStatusByDBResult(result);
            data.setData(result);
        }
        return data;
    }

    /**
     * 学校审核
     * @param applyId
     * @param Type
     * @return
     */
    @RequestMapping("/SchoolAudit")
    @ResponseBody
    public ResultData SchoolAudit(String applyId, String Type) {
        ResultData data = new ResultData();
        List<String> idslist = new ArrayList<>();
        if (applyId != null && !applyId.equals("")) {
            idslist = Arrays.asList(applyId.split("[|]"));
//            System.out.println(idslist);
//            System.out.println(Type);
        }
        if (Type != null && !Type.equals("")) {
            int result = activityapplyService.editActivityApply(idslist, Type, 2);
            data.setStatusByDBResult(result);
            data.setData(result);
        }
        return data;
    }

    /**
     * 班级团支书审核
     * @param applyId
     * @param Type
     * @return
     */
    @RequestMapping("/ClassAuditSupplement")
    @ResponseBody
    public ResultData ClassAuditSupplement(String applyId, String Type) {
        ResultData data = new ResultData();
        List<String> idslist = new ArrayList<>();
        if (applyId != null && !applyId.equals("")) {
            idslist = Arrays.asList(applyId.split("[|]"));
//            System.out.println(idslist);
//            System.out.println(Type);
        }
        if (Type != null && !Type.equals("")) {
            int result = activityapplyService.editSupplementApply(idslist, Type, 0);
            data.setStatusByDBResult(result);
            data.setData(result);
        }
        return data;
    }

    /**
     * 班级团支书审核带分数
     * @param applyId
     * @param score
     * @param Type
     * @return
     */
    @RequestMapping("/ClassAuditSupplementScore")
    @ResponseBody
    public ResultData ClassAuditSupplementScore(String applyId, String score, String Type) {
        ResultData data = new ResultData();
        List<String> idslist = new ArrayList<>();
        if (applyId != null && !applyId.equals("")) {
            idslist = Arrays.asList(applyId.split("[|]"));
//            System.out.println(idslist);
//            System.out.println(Type);
        }
        if (Type != null && !Type.equals("")) {
            int result = activityapplyService.editSupplementApplyScore(idslist, Type, score, 0);
            data.setStatusByDBResult(result);
            data.setData(result);
        }
        return data;
    }

    /**
     * 学院审核
     * @param applyId
     * @param Type
     * @return
     */
    @RequestMapping("/CollegeAuditSupplement")
    @ResponseBody
    public ResultData CollegeAuditSupplement(String applyId, String Type) {
        ResultData data = new ResultData();
        List<String> idslist = new ArrayList<>();
        if (applyId != null && !applyId.equals("")) {
            idslist = Arrays.asList(applyId.split("[|]"));
//            System.out.println(idslist);
//            System.out.println(Type);
        }
        if (Type != null && !Type.equals("")) {
            int result = activityapplyService.editSupplementApply(idslist, Type, 1);
            data.setStatusByDBResult(result);
            data.setData(result);
        }
        return data;
    }

    /**
     * 学院审核带分数
     * @param applyId
     * @param Type
     * @return
     */
    @RequestMapping("/CollegeAuditSupplementScore")
    @ResponseBody
    public ResultData CollegeAuditSupplementScore(String applyId, String score, String Type) {
        ResultData data = new ResultData();
        List<String> idslist = new ArrayList<>();
        if (applyId != null && !applyId.equals("")) {
            idslist = Arrays.asList(applyId.split("[|]"));
//            System.out.println(idslist);
//            System.out.println(Type);
        }
        if (Type != null && !Type.equals("")) {
            int result = activityapplyService.editSupplementApplyScore(idslist, Type, score, 1);
            data.setStatusByDBResult(result);
            data.setData(result);
        }
        return data;
    }

    /**
     * 学校审核
     * @param applyId
     * @param Type
     * @return
     */
    @RequestMapping("/SchoolAuditSupplement")
    @ResponseBody
    public ResultData SchoolAuditSupplement(String applyId, String Type) {
        ResultData data = new ResultData();
        List<String> idslist = new ArrayList<>();
        if (applyId != null && !applyId.equals("")) {
            idslist = Arrays.asList(applyId.split("[|]"));
//            System.out.println(idslist);
//            System.out.println(Type);
        }
        if (Type != null && !Type.equals("")) {
            int result = activityapplyService.editSupplementApply(idslist, Type, 2);
            data.setStatusByDBResult(result);
            data.setData(result);
        }
        return data;
    }

    /**
     * 学校审核带分数
     * @param applyId
     * @param Type
     * @return
     */
    @RequestMapping("/SchoolAuditSupplementScore")
    @ResponseBody
    public ResultData SchoolAuditSupplementScore(String applyId, String score, String Type) {
        ResultData data = new ResultData();
        List<String> idslist = new ArrayList<>();
        if (applyId != null && !applyId.equals("")) {
            idslist = Arrays.asList(applyId.split("[|]"));
//            System.out.println(idslist);
//            System.out.println(Type);
        }
        if (Type != null && !Type.equals("")) {
            int result = activityapplyService.editSupplementApplyScore1(idslist, Type, score, 2);
            data.setStatusByDBResult(result);
            data.setData(result);
        }
        return data;
    }

    @RequestMapping("/SelectAuditSupplement")
    @ResponseBody
    public DataForDatagrid SelectAuditSupplement(String applyId, String type) {
        DataForDatagrid data = new DataForDatagrid();
        int types = Integer.parseInt(type);
        List<String> idslist = new ArrayList<>();
        if (applyId != null && !applyId.equals("")) {
            idslist = Arrays.asList(applyId.split("[|]"));
//            System.out.println(idslist);
//            System.out.println(Type);
        }
        List<Map> result = activityapplyService.SelectAuditSupplement(idslist, types);
        data.setDatas(result);
        return data;
    }

    @RequestMapping("/deleteById")
    @ResponseBody
    public ResultData deleteById(String applyId, String asd, int[] a) {
        ResultData data = new ResultData();
        //int result=activityapplyService.delApply(applyId);
        int result = activityapplyService.updateApplayIsdelById(applyId);
        data.setStatusByDBResult(result);
        data.setData(result);
        return data;
    }

    @RequestMapping("/deleteByIds")
    @ResponseBody
    public ResultData deleteByIds(String deleteItems) {
        ResultData data = new ResultData();
        List<String> deleteIdslist = new ArrayList<>();
        if (deleteItems != null && !deleteItems.equals("")) {
            deleteIdslist = Arrays.asList(deleteItems.split(" "));
        }
        int result = activityapplyService.updateApplayIsdelByIds(deleteIdslist);
        data.setStatusByDBResult(result);
        data.setData(result);
        return data;
    }
}
