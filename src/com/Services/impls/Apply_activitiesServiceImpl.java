package com.Services.impls;

import com.Services.interfaces.Apply_activitiesService;
import com.dao.interfaces.Apply_activitiesDao;
import com.model.activities;
import com.model.apply_activities;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;

/**
 * Created by sw on 2016/8/30.
 */
@Service
public class Apply_activitiesServiceImpl implements Apply_activitiesService {
    @Autowired
    private Apply_activitiesDao apply_activitiesDao;

    @Override
    public activities ActivityByID(String activtityID) {
        return apply_activitiesDao.ActivityByID(activtityID);
    }

    @Override
    public int saveActivities(List<activities> list) {
        return apply_activitiesDao.saveActivities(list);
    }

    @Override
   public String selectValue(Map<String,String> map){
        return apply_activitiesDao.selectValue(map);
    };

    @Override
    public String selectActId(String actid) {
        return apply_activitiesDao.selectActId(actid);
    }
}
