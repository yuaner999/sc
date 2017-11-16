package com.dao.interfaces;

import com.model.Notactivity;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Map;

/**
 * Created by shaowen on 2016/9/18.
 */
@Repository
public interface NoactivityApplyDao {
   /**
    * 添加一条非活动类别申请
    * @param map
    * @return
    */
   int addNotactivity(Map<String, String> map);
   /**
    * 批量添加非活动类别申请
    * @param list
    * @return
    */
   int addBotactivities(List<Notactivity> list);
}
