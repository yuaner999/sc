package com.dao.interfaces;

import com.model.*;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Map;

/**
 * Created by sw on 2016/8/24.
 */
@Repository
public interface ActivityapplyDao {
    /**
     * 批量添加
     * @param list
     * @return
     */
    int saveActivityapplys(List<activityapply> list);

    /**
     * 批量添加
     * @param list
     * @return
     */
    int saveapplysInfo(List<Map<String ,String>> list);

    /**
     * 删除活动的报名信息
     * @param activityId
     * @return
     */
    int deleteByActivity(String activityId);
    /**
     * 根据ID查询学生
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
     * 删除一条活动申请
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
     * 删除一条活动一个申请(假删除改变isDel字段)
     * @param applyId
     * @return
     */
    int updateSupplementIsdelById(String id);

    /**
     * 删除一条活动所有申请
     * @param activityId
     * @return
     */

    int delApplyActivity(String activityId);

    /**
     * 删除多条活动所有申请
     * @param list
     * @return
     */

    int delapplysInfo(List<Map<String ,String>> list);

    /**
     * 添加其他类活动
     * @param applyactivities
     * @return
     */
    int saveActivtity(apply_activities applyactivities);
    /**
     * 添加团体活动申请
     * @param
     * @return
     */
    int addTeaminfor(Team team);
    /**
     * 保存活动与学生关系
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
     * 删除原有学生团体关系
     * @param teamId
     * @return
     */
    int delrstudentteam(String teamId);
    /**
     * 查询活动
     * @param activityId
     * @return
     */
    activities selectActivities(String activityId );

    /**
     * 团体名字
     * @param teamName
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
     *修改班级审核状态
     * @param map
     * @param
     * @return
     */
    int editApplyClass(Map<String,Object> map);
    /**
     *修改学院审核状态
     * @param map
     * @param
     * @return
     */
    int editApplyCollege(Map<String,Object> map);
    /**
     *修改学校审核状态
     * @param map
     * @param
     * @return
     */
    int editApplySchool(Map<String,Object> map);
    /**
     *修改补充活动班级审核状态
     * @param map
     * @param
     * @return
     */
    int editSupplementClass(Map<String,Object> map);
    /**
     *修改补充活动学院审核状态
     * @param map
     * @param
     * @return
     */
    int editSupplementCollege(Map<String,Object> map);
    /**
     *修改补充活动学校审核状态
     * @param map
     * @param
     * @return
     */
    int editSupplementSchool(Map<String,Object> map);
    List<Map> selectSupplementClass(Map<String,Object> map);
    List<Map> selectSupplementCollege(Map<String,Object> map);
    List<Map> selectSupplementSchool(Map<String,Object> map);
    List<String> getstudentIdByClassName(String className);
}
