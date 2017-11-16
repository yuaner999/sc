package com.Services.interfaces;

import com.model.activities;
import com.model.apply_activities;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Map;

/**
 * Created by sw on 2016/8/24.
 */

public interface Apply_activitiesService {

    /**
     * 根据ID 查询活动
     * @param activtityID
     * @return
     */
    activities ActivityByID(String activtityID);

    /**
     * 批量添加
     * @param list
     * @return
     */
    int saveActivities(List<activities> list);

    /**
     * 根据 key mean 查询 value
     * @param map
     * @return
     */
    String selectValue(Map<String,String> map);
    String selectActId(String actid);

}
