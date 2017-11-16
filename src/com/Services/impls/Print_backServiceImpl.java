package com.Services.impls;

import com.Services.interfaces.Print_backService;
import com.dao.interfaces.Print_backDao;
import com.github.pagehelper.PageHelper;
import com.model.Print;
import com.utils.PwdUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;

/**
 * Created by admin on 2016/9/20.
 */
@Service
public class Print_backServiceImpl implements Print_backService {
    @Autowired
    private Print_backDao printBackDao;

    @Override
    public List<Print> getPrint(Map<String, Object> map, int pagenum, int rows) {
        PageHelper.startPage(pagenum,rows);
        //需要加密处理 才能与数据库进行比较 全部AES 加密的方式
        //单独的
        AESDManageSingle(map,"studentIdCard");
        AESDManageSingle(map,"studentPhone");
        AESDManageSingle(map,"usiCampus");
        AESDManageSingle(map,"usiBuilding");
        AESDManageSingle(map,"trainingMode");
        AESDManageSingle(map,"usiRoomNumber");
        AESDManageSingle(map,"enrollType");
        AESDManageSingle(map,"schoolRollStatus");
        AESDManageSingle(map,"studentNation");
        AESDManageSingle(map,"educationLength");
        return printBackDao.getPrint(map);
    }



    @Override
    public int changeAuditStatus(String printid, String status) {
        return printBackDao.changeAuditStatus(printid,status);
    }

    @Override
    public int changePrintStatus(String printid) {
        return printBackDao.changePrintStatus(printid);
    }
    //把未加密的加密处理
    private void AESDManageSingle(Map<String, Object> map,String string){
        String before = (String)map .get(string);
        if(before !=null &&  !"".equals(before)) {
            String now = PwdUtil.AESEncoding(before);
            map.put(string, now);
        }
    }
    private void AESDManageMultiple(Map<String, Object> map,String string){
        String before = (String)map .get(string);
        if (before !=null &&  !"".equals(before)) {
            String[] now = before.split(",");
            String[] replace = new String[now.length];
            for (int i = 0; i < now.length; i++) {
                replace[i] = PwdUtil.AESEncoding(now[i]);
//                System.out.println("这是修改完后的"+replace[i]);
            }
            map.put(string, replace);
        }
    }
    @Override
    public int updateOrderId(String activiyId1,String activiryId2, String studentid ) {
        return printBackDao.updateOrderId(activiyId1,activiryId2,studentid);
    }
}
