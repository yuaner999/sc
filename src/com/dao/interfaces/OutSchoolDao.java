package com.dao.interfaces;

import org.springframework.stereotype.Repository;

import java.util.Map;

/**
 * 校外活动申请
 * @author hong
 * Created by admin on 2016/9/13.
 */
@Repository
public interface OutSchoolDao {
    /**
     * 添加一条校外活动
     * @param map
     * @return
     */
    int addOutSchoolActivity(Map<String ,String > map);
}
