package com.controllers;

import com.Services.interfaces.CheckService;
import com.model.DataForDatagrid;
import com.model.ResultData;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.util.*;

/**
 * Created by guoqiang on 2016/9/18.
 */
@Controller
@RequestMapping("/Check")
public class CheckController {
@Autowired private CheckService checkService;

    @RequestMapping(value = "/checkReportAgain",method = RequestMethod.POST)
    @ResponseBody
    public DataForDatagrid checkReportAgain(HttpServletRequest request,String informByStudentId, String informType, String informStudentId, String informApplyId,String infomTeamID){
        DataForDatagrid data=new DataForDatagrid();
        HttpSession session=request.getSession();
        String studentid=(String)session.getAttribute("studentid");
        Map<String, String> map = new HashMap<>();
        map.put("informByStudentId",studentid);
        map.put("informType",informType);
        map.put("informApplyId",informApplyId);
        List<Map<String, String>> list=null;

        if(infomTeamID!=null && !"".equals(infomTeamID)){
            List nlist=new ArrayList<>();
            nlist=checkService.studentIdByteamID(infomTeamID);
                String stuId="";
                    if(nlist.size()>0){
                        stuId= (String) nlist.get(0);
                    }
                map.put("informStudentId",stuId);
                list=checkService.checkReportAgain(map);
        }else{
            map.put("informStudentId",informStudentId);
            list=  checkService.checkReportAgain(map);
        }
       data.setDatas(list);
      return data;
    }
    @RequestMapping(value = "/insertReportInfo",method = RequestMethod.POST)
    @ResponseBody
    public ResultData insertReportInfo(HttpSession session,String informByStudentId, String informType, String informContent, String informStudentId,
                                            String informApplyId,String infomTeamID,String informTel,String acttitle,String actaward){
        ResultData re=new ResultData();
        String studentid=(String)session.getAttribute("studentid");
        Map<String, String> map = new HashMap<>();
        map.put("informByStudentId",studentid);
        map.put("informType",informType);
        map.put("informContent",informContent);
        map.put("informApplyId",informApplyId);
        map.put("informTel",informTel);
        map.put("acttitle",acttitle);
        map.put("actaward",actaward);
        for(String s:map.keySet()){
            map.putIfAbsent(s,"");
        }
        int i=-1;
        if(infomTeamID != null && !"".equals(infomTeamID)){
            List list=new ArrayList<>();
            list=checkService.studentIdByteamID(infomTeamID);
            for(int j=0;j<list.size();j++){
                String sId= (String) list.get(j);
                map.put("informStudentId",sId);
                i=checkService.insertReportInfo(map);
            }

        }else{
            map.put("informStudentId",informStudentId);
             i=checkService.insertReportInfo(map);
        }
        re.setStatusByDBResult(i);
        return re;
    }
}
