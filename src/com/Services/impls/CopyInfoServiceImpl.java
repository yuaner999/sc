package com.Services.impls;

import com.Services.interfaces.CopyInfoService;
import com.dao.interfaces.CopyInfoDao;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Map;

/**
 * Created by admin on 2016/8/23.
 */
@Service
public class CopyInfoServiceImpl implements CopyInfoService {
    @Autowired
    private CopyInfoDao copyInfoDao;
    public void copyInfo(Map<String, Object> map,String flag){
        switch (flag){
            case "loadClassInfo":
                copyInfoDao.CopyClassInfo(map);
                break;
            case "loadStudentsInfo":
                copyInfoDao.CopyStudInfo(map);
                break;
            case "loadCollegeInfo":
                copyInfoDao.CopyCollegeInfo(map);
                break;
            case "loadGradeInfo":
                copyInfoDao.CopyGradeInfo(map);
                break;
            case "loadMajorInfo":
                copyInfoDao.CopyMajorInfo(map);
                break;
        }
    }
}
