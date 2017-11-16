package com.Services.interfaces;

import com.model.*;

import java.util.List;
import java.util.Map;

/**
 * Created by  sw 2016/8/24.
 */
public interface ActivityapplyService {
    /**
     * 批量添加活动申请
     * @param list
     * @return
     */
    int saveActivityapplys(List<activityapply> list);


    /**
     * 查询学生表中是否有这个ID
     * @param ID
     * @return
     */
    Student selectStudentID(String ID);

    /**
     * 验证当前活动 该学生是否已经参加过
     * @param applyStudentId
     * @param applyActivityId
     * @return
     */
    activityapply selectActivty(String applyStudentId,String applyActivityId);

    /**
     * 删除一条活动一个申请
     * @param applyId
     * @return
     */
    int delApply(String applyId);

    /**
     * 删除一条活动一个申请(假删除改变isDel字段)
     * @param applyId
     * @return
     */
    int updateApplayIsdelById(String applyId);

    /**
     * 删除多条活动一个申请(假删除改变isDel字段)
     * @param applyId
     * @return
     */
    int updateApplayIsdelByIds(List<String> applyIds);

    /**
     * 删除一条活动所有申请
     * @param activityId
     * @return
     */
    int delApplyActivity(String activityId);


    /**
     * 添加其他类活动
     * @param applyactivities
     * @return
     */
    int saveActivtity(apply_activities applyactivities);
    /**
     * 添加团体
     * @param
     * @return
     */
    int addTeaminfor(Team team);
    /**
     * 保存团体与学生关系
     * @param
     * @return
     */
    int addStudentTeam(Map<String ,Object> map);
    /**
     * 修改团体
     * @param
     * @return
     */
    int editTeaminfor(Team team);
    /**
     * 修改团体与学生关系
     * @param
     * @return
     */
    int editStudentTeam(Map<String ,Object> map);
    /**
     * 修改团体活动申请
     * @param Activityapply
     * @return
     */
    int editActivityapply(activityapply Activityapply );
    /**
     * 查询活动
     * @param activityId
     * @return
     */
    activities selectActivities(String activityId );

    /**
     * 团体名字
     * @param teamName teamActivityId
     * @return
     */
     Team selectTeamByname(String teamName,String teamActivityId);

    /**
     * 通过班级名字添加活动申请
     * @param stuClassName
     * @return
     */
     List<String> getStudentIds(String stuClassName);

    /**
     * 根据活动id获取申请该活动的所有学生id
     * @param activityId
     * @return
     */
     List<String> getStudentIdsByActivityid(String activityId);

    /**
     *修改活动审核
     * @param idslist
     * @param Type
     * @return
     */
   int editActivityApply(List<String> idslist,String Type,int type);
    /**
     *修改补充活动审核
     * @param idslist
     * @param Type
     * @return
     */
    int editSupplementApply(List<String> idslist,String Type,int type);
    int editSupplementApplyScore(List<String> idslist,String Type,String score,int types);
    int editSupplementApplyScore1(List<String> idslist,String Type,String score,int types);
    List<Map> SelectAuditSupplement(List<String> list,int types);


    int addAndUpdateApplySignInfo(List<Map<String ,String>> list);
    List<String> getstudentIdByClassName(String className);
}
