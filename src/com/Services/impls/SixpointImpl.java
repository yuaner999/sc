package com.Services.impls;

import com.Services.interfaces.CheckService;
import com.Services.interfaces.SixpointService;
import com.dao.interfaces.CheckDao;
import com.dao.interfaces.SixpointDao;
import com.github.pagehelper.PageHelper;
import com.model.ResultData;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;

/**
 * Created by guoqiang on 2016/9/18.
 */
@Service
public class SixpointImpl implements SixpointService {

    @Autowired
    private SixpointDao sixpointDao;


    @Override
    public List<Map<String, String>> getsixpoint(Map<String, String> map, int rows, int pagenum) {
        PageHelper.startPage(pagenum,rows);
        return sixpointDao.getsixpoint(map);
    }
}
