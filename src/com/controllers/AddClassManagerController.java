package com.controllers;

import com.dao.interfaces.AddClassManagerDao;
import com.model.ResultData;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.List;
import java.util.UUID;

/**
 * 自动添加班级管理员
 * @author hong
 * Created by admin on 2016/12/20.
 */
@Controller
@RequestMapping("/classmanager")
public class AddClassManagerController {
    @Autowired
    private AddClassManagerDao addClassManagerDao;
    @RequestMapping("/add")
    @ResponseBody
    public ResultData addclassManager(){
        ResultData re=new ResultData();
        List<String > stuClass=addClassManagerDao.loadClassName();
        List<String > managerClass=addClassManagerDao.loadManagerClass();
        stuClass.removeAll(managerClass);
        if(stuClass.size()==0){
            re.sets(0,"没有新的班级");
            return re;
        }
        int i=0;
        for(String s:stuClass){
            int j=addProcessing(UUID.randomUUID().toString(),s);
            if(j>0) i++;
        }
        re.sets(0,"成功创建了"+i+"个班级管理员");
        return re;
    }
    @Transactional
    public int addProcessing(String userid,String username){
        int i=addClassManagerDao.addSysuser(userid,username);
        if(i>0){
            int j=addClassManagerDao.addClassManager(userid,username);
            if(j<=0){
                throw new RuntimeException("插入失败");
            }
            return 1;
        }
        return 0;
    }
}
