package com.Services.impls;

import com.Services.interfaces.PCActService;
import com.dao.interfaces.PCActDao;
import com.github.pagehelper.PageHelper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Created by wd on 2016/9/12.
 */
@Service
public class PCActServiceImpl implements PCActService{
    @Autowired
    private PCActDao pcActDao;
    @Override
    public List<Map<String, String>> loadPCAct(String[] str,int arows,int apage) {
        Map<String,String> map = new HashMap();
        PageHelper.startPage(apage,arows);
        map.put("activityClass",str[0]);
        map.put("activityLevle",str[1]);
        map.put("activityNature",str[2]);
        map.put("activityPowers",str[3]);
        map.put("activityParticipation",str[4]);
        map.put("activityTitle",str[5]);
        map.put("activityArea",str[6]);
        map.put("studentID",str[7]);
        return (pcActDao.loadPCAct(map));
    }

    @Override
    public List<Map<String, String>> loadActDetail(String actid) {
        return pcActDao.loadActDetail(actid);
    }

    @Override
    public List<Map<String, String>> validatePCApply(String studentid,String actid) {
        Map<String,String> map = new HashMap();
        map.put("studentid",studentid);
        map.put("actid",actid);
        return pcActDao.validatePCApply(map);
    }

    @Override
    public String applyPCAct(String studentid, String actid) {
        Map<String,String> map = new HashMap();
        map.put("studentid",studentid);
        map.put("actid",actid);
        int i = pcActDao.applyPCAct(map);
        String re = null;
        if(i!=0){
            re = "申请成功";
        }else {
            re = "申请失败";
        }
        return re;
    }
}
