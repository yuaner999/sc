package com.Services.impls;

import com.Services.interfaces.ScholarshipService;
import com.dao.interfaces.ScholarshipDao;
import com.model.ScholarShip;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * Created by guoqiang on 2016/11/11.
 */
@Service
public class ScholarshipImp implements ScholarshipService {
    @Autowired
    private ScholarshipDao scholarshipDao;
    @Override
    public int addscholarship(List<ScholarShip> list) {
            return scholarshipDao.addscholarship(list);
    }
}
