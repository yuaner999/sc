package com.Services.interfaces;

import com.model.Notactivity;

import java.util.List;
import java.util.Map;

/**
 * Created by shaowen on 2016/9/13.
 */
public interface NoactivityApplyService {
    /**
     * 添加一条非活动类别申请
     * @param map
     * @return
     */
    int addBotactivity(Map<String, String> map);
    /**
     * 批量添加非活动类别申请
     * @param list
     * @return
     */
    int addBotactivities(List<Notactivity> list);
}
