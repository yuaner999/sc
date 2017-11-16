package com.controllers;

import com.Services.interfaces.SignInService;
import com.model.ResultData;
import com.utils.ExcelUtil;
import com.utils.PwdUtil;
import org.apache.commons.fileupload.FileItem;
import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.InputStream;
import java.util.ArrayList;
import java.util.List;

/**
 * 签到处理
 * @author hong
 * Created by admin on 2016/9/8.
 */
@Controller
@RequestMapping("/signin")
public class SignInController {
    /**
     * 往数据库批量保存的数量
     */
    private final int BATCH_NUM=500;
    @Autowired
    private SignInService signInService;

    @RequestMapping("/byfile")
    @ResponseBody
    public ResultData signInByFile(HttpServletRequest request, HttpServletResponse response,String activityid){
        ResultData resultData=new ResultData();
        FileItem item;
        try {
            item=ExcelUtil.getFileFromRequest(request,"xls");
            List<String > list=excelProcess(item.getInputStream());
            if(list.size()==0){
                resultData.sets(1,"上传的文件中没有数据！");
                return resultData;
            }
            List<String> wrongMsg=new ArrayList<>();
            List<String > temp=new ArrayList<>(BATCH_NUM);
            int i=0;
            for(String s:list){
                temp.add(PwdUtil.mergeStringWithXOROperation(s,activityid));
                i++;
                if(i%BATCH_NUM==0){
                    int num=signInService.signInByList(temp);
//                    System.out.println(num);
                    if(num<=0){
                        String str="第"+(i-BATCH_NUM+1)+"--"+i+"条数据处理失败，请检查活动选择是否正确，或者某个学生未申请该活动";
                        wrongMsg.add(str);
                    }
                    temp.clear();
                }
            }
            int num=signInService.signInByList(temp);
//            System.out.println(num);
            if(num<=0){
                String str="第"+(i<BATCH_NUM?1:(i-BATCH_NUM+1))+"--"+i+"条数据处理失败，请检查活动选择是否正确，或者某个学生未申请该活动";
                wrongMsg.add(str);
            }
            resultData.setData(wrongMsg);
        } catch (Exception e) {
            e.printStackTrace();
            resultData.sets(1,e.getMessage());
            return resultData;
        }
        resultData.setMsg("文件处理完成");
        return resultData;
    }

    /**
     * 处理excel中的数据，返回字符串的集合
     * @param input
     * @return
     * @throws IOException
     */
    private List<String> excelProcess(InputStream input) throws IOException{
        List<String> list=new ArrayList<>();
        HSSFWorkbook hssfWorkbook = new HSSFWorkbook(input);
        HSSFSheet sheet=hssfWorkbook.getSheetAt(0);
        for(int i=0;i<=sheet.getLastRowNum();i++){
            HSSFRow row=sheet.getRow(i);
//            for(int j=0;j<=row.getLastCellNum();j++){
            if(row==null) continue;
            HSSFCell cell=row.getCell(0);
            if(cell==null) continue;
            String value= ExcelUtil.getCellStringValue(cell);
            list.add(value);
//            }
        }
        return list;
    }

    @RequestMapping("/byid")
    @ResponseBody
    public ResultData signInById(String applyId,String activityId){
        ResultData re=new ResultData();
        if(activityId==null || activityId.equals("") || applyId==null || applyId.equals("")){
            re.sets(1,"传输入的数据有误！");
            return re;
        }
       try{
            int i=signInService.signInById(PwdUtil.mergeStringWithXOROperation(applyId,activityId));
            re.setStatusByDBResult(i);
        }catch (Exception e){
            e.printStackTrace();
            re.sets(1,e.getMessage());
        }
        return re;
    }
}
