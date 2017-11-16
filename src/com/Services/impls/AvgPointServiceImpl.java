package com.Services.impls;

import com.Services.interfaces.AvgPointService;
import com.dao.interfaces.AvgPointDao;
import com.github.pagehelper.PageHelper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;

/**
 * Created by sw on 2016/8/27.
 */
@Service
public class AvgPointServiceImpl implements AvgPointService{
    @Autowired
    private AvgPointDao avgPointDao;
    @Override
    public List<Map<String, String>> loadavgPointActivity(int page,int rows,String sqlStr) {
        PageHelper.startPage(page,rows);
        return avgPointDao.loadavgPointActivity(sqlStr);
    }
}
