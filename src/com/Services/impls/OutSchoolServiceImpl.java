package com.Services.impls;

import com.Services.interfaces.OutSchoolService;
import com.dao.interfaces.OutSchoolDao;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Map;

/**
 * Created by admin on 2016/9/13.
 */
@Service
public class OutSchoolServiceImpl implements OutSchoolService {
    @Autowired
    private OutSchoolDao outSchoolDao;
    @Override
    public int addOutSchoolActivity(Map<String, String> map) {
        return outSchoolDao.addOutSchoolActivity(map);
    }
}
