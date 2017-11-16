package com.Services.impls;

import com.Services.interfaces.SchoolActivityService;
import com.dao.interfaces.SchoolActivityDao;
import com.github.pagehelper.PageHelper;
import com.model.activities;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Created by sw on 2016/9/12.
 */
@Service
public class SchoolActivityServiceImpl implements SchoolActivityService {
    @Autowired
    private SchoolActivityDao shcoolActivityDao;

    @Override
    public List<activities> loadSchoolActivityList(int rows, int index,int type,String studentID) {
        PageHelper.startPage(index,rows);
        if (type==1){
            return shcoolActivityDao.loadSchoolActivityList(studentID);
        }
        else if(type==2){
            return shcoolActivityDao.loadcollegeActivityList(studentID);
        }
        else {
            return null;
        }
    }

    @Override
    public List<Map<String, String>> laodStudentActivity(String[] str) {
        Map<String,String> map = new HashMap();
        map.put("activityClass",str[0]);
        map.put("activityLevle",str[1]);
        map.put("activityNature",str[2]);
        map.put("activityPowers",str[3]);
        map.put("activityAward",str[4]);
        map.put("applyStudentId",str[5]);
        map.put("activityIsDelete",str[6]);
        map.put("signUpStatus",str[7]);
        return shcoolActivityDao.laodStudentActivity(map);
    }

    @Override
    public List<Map<String, String>> laodNotActivtity(String studentID) {
        return shcoolActivityDao.laodNotActivtity(studentID);
    }
}
