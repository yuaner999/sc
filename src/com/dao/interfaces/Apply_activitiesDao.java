package com.dao.interfaces;

import com.model.Student;
import com.model.activities;
import com.model.activityapply;
import com.model.apply_activities;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Map;

/**
 * Created by sw on 2016/8/24.
 */
@Repository
public interface Apply_activitiesDao {
    /**
     * 查询活动ID
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
     * 根据key mean查询value
     * @param map
     * @return
     */
    String selectValue(Map<String,String> map);
    String selectActId(String actid);
}
