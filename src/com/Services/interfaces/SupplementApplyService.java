package com.Services.interfaces;

import com.model.Notactivity;
import com.model.SupplementApplyEntity;

import java.util.List;
import java.util.Map;

/**
 * Created by shaowen on 2016/11/11.
 */
public interface SupplementApplyService {
    /**
     * 添加一条非活动类别申请
     * @param map
     * @return
     */
    int addSupplement(Map<String, String> map);
    /**
     * 添加一条非活动类别申请
     * @param map
     * @return
     */
    int eidtSupplement(Map<String, String> map);

    /**
     * 查询该学生是否有补充的活动
     * @param studentID
     * @return
     */
    List<Map<String,String>> getSupplement(String studentID);

    /**
     * 根据活动标题查询活动相关
     * @param supActivityTitle
     * @return
     */
    Map<String,String> getActivityByTitle(String supActivityTitle);

    /**
     * 根据打印id获取活动申请id
     * @param printId
     * @return
     */
    List<Map<String,String>> getApplyIdByprintId(String printId);
    /**
     * 查询补充的活动
     * @param ids
     * @return
     */
    List<Map<String,String>> getSupplementAll(Map<String,Object> ids);
    /**
     * 查询补充的活动
     * @param ids
     * @return
     */
    List<Map<String,String>> getSupplementByIds(Map<String,Object> ids);
    /**
     * 查询补充的活动 根据学号
     * @param userid
     * @return
     */
    List<Map<String,String>> getSupplementByUser(String userid);
    /**
     * 批量插入主题团日活动能够
     * @param list
     * @return
     */
    int saveThemeActity(List<SupplementApplyEntity> list);
}
