package com.Services.impls;

import com.Services.interfaces.StatisticsTiemsService;
import com.dao.interfaces.StatisticsDao;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

/**
 * Created by admin on 2016/8/23.
 */
@Service
public class StatisticsTimesServiceImpl implements StatisticsTiemsService {
    @Autowired
    StatisticsDao statisticsDao;
    @Override
    public void StaticsTimes(String studentID){
        statisticsDao.StaticsTimes(studentID);
    }

}
