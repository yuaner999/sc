package com.controllers;

import com.Services.interfaces.MemberService;
import com.github.pagehelper.Page;
import com.model.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpSession;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * 学生家庭、社会关系管理部分controller
 * @author hong
 * Created by admin on 2016/7/26.
 */
@Controller
@RequestMapping("/jsons")
public class MemberController {
    @Autowired
    private MemberService memberService;

    @RequestMapping("deleteMoreMember")
    @ResponseBody
    public ResultData exec(String ids){
        ResultData re=new ResultData();
        List<String> list=new ArrayList<>();
        if(ids!=null && ids.contains("|")){
            String[] id=ids.split("[|]");
            for(String s:id){
                list.add(s);
            }
        }
        int result=memberService.deleteMoreMember(list);
        re.setStatusByDBResult(result);
        re.setData(result);
        return re;
    }


    /**
     *加载家庭成员信息
     * @param sqlStr
     * @param page
     * @param rows
     * @param session
     * @return
     */
    @RequestMapping("loadMemberInfo")
    @ResponseBody
    public DataForDatagrid loadMemberInfo(String sqlStr, String rows, String page, HttpSession session) {
        DataForDatagrid data=new DataForDatagrid();
        Map<String ,String > map=new HashMap<>(5);
        String collegeid= (String) session.getAttribute("collegeid");
        String instructorid= (String) session.getAttribute("instructorid");
        if(collegeid!=null && !collegeid.equals("")) map.put("collegeid",collegeid);
        if(instructorid!=null && !instructorid.equals("")) map.put("instructorid",instructorid);
        if(sqlStr!=null && !sqlStr.equals("")) map.put("sqlStr",sqlStr);
        int pagenum=1,pagesize=30;
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
        List<Member_Decoding> memebers=memberService.loadMemberInfo(map,pagenum,pagesize);
        data.setDatas(memebers);
        data.setTotal((int)((Page)memebers).getTotal());
        return data;
    }

    /**
     * 添加一条家庭成员信息
     * @param menber
     * @return
     */
    @RequestMapping("addMember")
    @ResponseBody
    public ResultData addMember(Member_Encoding menber){
        ResultData re=new ResultData();
        int i=memberService.addMember(menber);
        re.setStatusByDBResult(i);
        return re;
    }

    /**
     * 加载家庭成员信息
     * @param studentid
     * @return
     */
    @RequestMapping("loadMemberShip")
    @ResponseBody
    public DataForDatagrid loadMemberShip(String studentid,HttpSession session){
        DataForDatagrid data=new DataForDatagrid();
        if(studentid==null || studentid.equals("")){
            studentid= (String) session.getAttribute("studentid");
        }
        List<Member_Decoding> s=memberService.loadMemberShip(studentid);
        data.setDatas(s);
        return data;
    }

}
