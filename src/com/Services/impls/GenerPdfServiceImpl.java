package com.Services.impls;

import com.Services.interfaces.GenerPdfService;
import com.dao.interfaces.GenerPdfDao;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Map;

/**
 * @author hong
 * Created by admin on 2016/8/11.
 */
@Service
public class GenerPdfServiceImpl implements GenerPdfService {
    @Autowired
    private GenerPdfDao generPdfDao;

    @Override
    public int saveStudentCard(Map<String, String> map) {
        return generPdfDao.saveStudentCard(map);
    }

    @Override
    public int saveInStudyProve(Map<String, String> map) {
        return generPdfDao.saveInStudyProve(map);
    }
}
