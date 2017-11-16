package com.Services.impls;

import com.Services.interfaces.SixDetailService;
import com.dao.interfaces.SixDetailDao;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;

/**
 * Created by admin on 2017/2/28.
 */
@Service
public class SixDetailServiceImpl implements SixDetailService {
    @Autowired
    private SixDetailDao sixDetailDao;
    @Override
    public int saveDetailList(List<Map<String, String>> list) {
        return sixDetailDao.saveDetailList(list);
    }

    @Override
    public int deleteDetailByStudentId(String studentId) {
        return sixDetailDao.deleteDetailByStudentId(studentId);
    }
}
