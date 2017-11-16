package com.Services.impls;

import com.Services.interfaces.SupplementApplyService;
import com.Services.interfaces.SupplementInfoService;
import com.dao.interfaces.SupplementDao;
import com.dao.interfaces.SupplementInfoDao;
import com.github.pagehelper.PageHelper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;

/**
 * Created by  shaowen 2016/11/11.
 */
@Service
public class SupplementInfoServiceImpl implements SupplementInfoService {
    @Autowired
    private SupplementInfoDao supplementInfoDao;

    @Override
    public List<Map<String, String>> loadSupplemenlPageClass(Map<String, String> map,int page,int row) {
        PageHelper.startPage(page,row);
        return supplementInfoDao.loadSupplemenlClass(map);
    }

    @Override
    public List<Map<String, String>> loadSupplemenlPageCollege(Map<String, String> map,int page,int row) {
        PageHelper.startPage(page,row);
        return supplementInfoDao.loadSupplemenlCollege(map);
    }

    @Override
    public List<Map<String, String>> loadSupplementPageSchool(Map<String, String> map,int page,int row) {
        PageHelper.startPage(page,row);
        return supplementInfoDao.loadSupplementSchool(map);
    }


}