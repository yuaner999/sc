package com.Services.impls;

import com.Services.interfaces.EditStudentInfoService;
import com.dao.interfaces.EditStudentInfoDao;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Map;

/**
 * Created by guoqiang on 2016/12/9.
 */
@Service
public class EditStudentInfoServiceImpl implements EditStudentInfoService {
    @Autowired
    private EditStudentInfoDao editStudentInfoDao;
    @Override
    public String  EditStudentInfo(Map map) {
        return ""+editStudentInfoDao.EditStudentInfo(map);
    }
}
