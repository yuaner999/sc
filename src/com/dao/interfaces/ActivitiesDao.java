package com.dao.interfaces;

import com.model.ActivityQuery;
import com.model.Dict;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Map;

/**
 * Created by wd on 2016/9/9.
 */
@Repository
public interface ActivitiesDao {
    /**
     *
     * @param map
     * @return
     */
   List<Map<String,String>> loadActivities(Map<String,String> map);
   /**
    * 加载创建者
    * @return
    */
   List<String > loadactivityCreator();


    /**
     * 搜索
     * @return
     */
    List<ActivityQuery> newLoadactivities(Map<String, Object> map);

    /**
     *
     * @param map
     * @return
     */
    List<Map<String,String> > loadCheckActivities(Map<String ,Object> map);
    List<Map<String,String> > loadCheckAct(Map<String ,Object> map);
    /**
     *
     * @return
     */
    List<String> loadCheckCollege();
    List<String> loadActivityTitle();
    List<Dict> loadActivityScoreTotal();
    List<Dict> loadActivityScoreGet(Map<String ,Object> newmap);
    List<Map> loadActivityScoreGets(String id);
    List<Map> loadSchoolActivityapply(Map  newmap);
    List<Map> loadSupplementSchoolmybatis(Map<String, Object>  newmap);
}
