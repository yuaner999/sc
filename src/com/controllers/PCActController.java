package com.controllers;

import com.Services.interfaces.PCActService;
import com.github.pagehelper.Page;
import com.model.DataForDatagrid;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpRequest;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpSession;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Created by wd on 2016/9/12.
 */
@Controller
@RequestMapping("/jsons")
public class PCActController {
    @Autowired
    private PCActService pcActService;
    @RequestMapping("/loadPCAct")
    @ResponseBody
    public DataForDatagrid loadPCAct(HttpSession session,String aclass, String alevel, String anature, String apower, String apartic, String asearch, String page, String rows, String activityArea){
        int arows=(rows==null || rows.equals(""))? 10:Integer.parseInt(rows);
        int apage=(page==null || page.equals(""))? 1:Integer.parseInt(page);
        DataForDatagrid data = new DataForDatagrid();
        String  studentID= (String)session.getAttribute("studentid");
        String[] str={aclass,alevel,anature,apower,apartic,asearch,activityArea,studentID};
        List<Map<String,String>> list = pcActService.loadPCAct(str,arows,apage);
        data.setDatas(list);
        data.setTotal((int)((Page)list).getTotal());
        return data;
    }
    @RequestMapping("/loadActDetail")
    @ResponseBody
    public DataForDatagrid loadActDetail(String actid){
        DataForDatagrid data = new DataForDatagrid();
        List<Map<String,String>> list = pcActService.loadActDetail(actid);
        //获取服务器时间传到后台
        Date now = new Date();
        SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        String nowDate = dateFormat.format( now );
        Map<String,String> tempmap = new HashMap<>();
        tempmap.put("nowDate",nowDate);
        list.add(tempmap);

        data.setDatas(list);
        return data;
    }
    @RequestMapping("/validatePCApply")
    @ResponseBody
    public DataForDatagrid validatePCApply(String actid, HttpSession session,String studentid){
        if(studentid==null || studentid.equals("")){
            studentid= (String) session.getAttribute("studentid");
        }
        DataForDatagrid data = new DataForDatagrid();
        List<Map<String,String>> list = pcActService.validatePCApply(studentid,actid);
        data.setDatas(list);
        return data;
    }
    @RequestMapping("/applyPCAct")
    @ResponseBody
    public String applyPCAct(String actid, HttpSession session,String studentid){
        if(studentid==null || studentid.equals("")){
            studentid= (String) session.getAttribute("studentid");
        }
        String re;
        re  = pcActService.applyPCAct(studentid,actid);
        return re;
    }

}
