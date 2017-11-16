package com.controllers;

import com.Services.interfaces.Print_backService;
import com.github.pagehelper.Page;
import com.model.DataForDatagrid;
import com.model.Print;
import com.model.ResultData;
import com.utils.PwdUtil;
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
 * 打印管理的后台部分controller
 * @author hong
 * Created by admin on 2016/9/20.
 */
@Controller
@RequestMapping("/printBack")
public class PrintBackgroudController {
    @Autowired
    private Print_backService printBackService;

    /**
     * 后台管理员加载
     * @param request
     * @param sqlStr   学号
     * @param page
     * @param rows
     * @return
     */
    @RequestMapping("/loadPrint")
    @ResponseBody
    public DataForDatagrid loadPrint(HttpServletRequest request,String sqlStr,String page,String rows){
        DataForDatagrid data=new DataForDatagrid();
        //从请求中获得所有的参数
        Map<String ,String[]> parameterMap= request.getParameterMap();
        //为了能然map 修改  通过 request.getParameterMap(); 获得的map不可以修改
        Map<String ,Object> newmap=new HashMap<>(36);
        Set<String> keys=  parameterMap.keySet();
        for(String s:keys){
            //取中map中每个元素（数组）的第一个，并放到新的map中  处理下才有值  负责全是地址
            // 用newmap处理  通过key获得value
            String[] value=parameterMap.get(s);
            if(value.length==0)continue;
            newmap.put(s,value[0]);
        }
        int pageNum=1,pageRows=20;
        if(page!=null && !"".equals(page)){
            pageNum=Integer.parseInt(page);
        }
        if(rows!=null && !"".equals(rows)){
            pageRows=Integer.parseInt(rows);
        }
        List<Print> list=printBackService.getPrint(newmap,pageNum,pageRows);
        for(Print print:list){
            String str=print.getStudentPhone();
            print.setStudentPhone( PwdUtil.AESDecoding(str));
          //  System.out.println(print);
        }
        data.setRows(list);
        data.setTotal((int)((Page)list).getTotal());
        return data;
    }

    /**
     * 修改打印申请的审核状态
     * @param printid
     * @param status
     * @return
     */
    @RequestMapping("/changeAuditstatus")
    @ResponseBody
    public ResultData changeauditstatus(String printid,String status,HttpServletRequest request){
        if(printid==null || printid.equals("")){
            printid= (String) request.getSession().getAttribute("printId");
            status="待审核";
        };
        if(status==null || status.equals("")) return null;
        int i=printBackService.changeAuditStatus(printid,status);
        ResultData re=new ResultData();
        re.setStatusByDBResult(i);
        return re;
    }

    /**
     * 修改打印申请的打印状态
     * @param printid
     * @return
     */
    @RequestMapping("/changePrintstatus")
    @ResponseBody
    public ResultData changePrintStatus(String printid){
        if(printid==null || printid.equals("")) return null;
        int i=printBackService.changePrintStatus(printid);
        ResultData re=new ResultData();
        re.setStatusByDBResult(i);
        return re;
    }
    @RequestMapping("/exchangeOrderId")
    @ResponseBody
    public int updateOrderId(String activiyId1,String activiryId2, String studentid ,HttpServletRequest request){
        String studentId = (String) request.getSession().getAttribute("studentid");
       return( printBackService.updateOrderId(activiyId1, activiryId2, studentId ));
    }
}
