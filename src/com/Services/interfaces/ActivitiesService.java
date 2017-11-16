package com.Services.interfaces;

import com.model.ActivityQuery;
import com.model.Dict;

import java.util.List;
import java.util.Map;

/**
 * Created by wd on 2016/9/9.
 */
public interface ActivitiesService {
    List<Map<String,String>> loadActivities(String[] str);

    /**
     * 创建人
     * @return
     */
    List<String > loadactivityCreator();

    /**
     * 搜索活动
     * @return
     */
    List<ActivityQuery> newloadactivities(Map<String ,Object> map, int pagenum, int rows);

    /**
     *
     * @param map
     * @param pagenum
     * @param rows
     * @return
     */
    List<Map<String,String>>   loadCheckActivities(Map<String ,Object> map,int pagenum,int rows);
    List<Map<String,String>>   loadCheckActivitiesNew(Map<String ,Object> map);
    /**
     *
     * @return
     */
    List<String > loadCheckCollege();
    List<String > loadActivityTitle();
    List<Dict> loadActivityScoreTotal();
    List<Dict> loadActivityScoreGet(Map<String ,Object> newmap);
    List<Map> loadActivityScoreGets(String id);
    List<Map> loadSchoolActivityapply(Map newmap,int pagenum, int rows);

    List<Map<String ,String >> loadCheckAct(Map<String, Object> newmap, int pagenum, int pagesize);
    List<Map<String ,String >> loadCheckActNew(Map<String, Object> newmap);
    List<Map> loadSupplementSchoolmybatis(Map<String, Object> newmap,int page,int rows);
}
