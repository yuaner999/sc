package com.Services.interfaces;

import java.util.Map;

/**
 * Created by admin on 2016/9/13.
 */
public interface OutSchoolService {
    /**
     * 添加一条校外活动
     * @param map
     * @return
     */
    int addOutSchoolActivity(Map<String ,String > map);
}
