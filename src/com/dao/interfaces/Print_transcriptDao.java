package com.dao.interfaces;

import org.apache.ibatis.annotations.Param;
import org.jaxen.function.StringFunction;
import org.springframework.stereotype.Repository;

import javax.print.DocFlavor;
import java.util.List;
import java.util.Map;

/**
 * 成绩单
 * 打印成绩单对应数据库视图  wh_print_apply_activity
 * @author hong
 * Created by admin on 2016/8/25.
 */
@Repository
public interface Print_transcriptDao {
    /**
     * 加载某个学生的成绩单用做成绩计算
     * @param studentId
     * @return
     */
    List<Map<String ,String >> loadApplies(String studentId);

    /**
     * 根据传递的ID集合查询活动申请
     * @param list
     * @return
     */
    List<Map<String ,String >> loadAppliesByIds(List<String > list);


    /**
     * 根据学生的学号 查询活动申请
     * @param userid
     * @return
     */
    List<Map<String ,String >> loadAppliesByUserid(String userid);

    /**
     * 添加打印申请
     * @param studentid
     * @return
     */
    int addPrint(String printId,String studentid);

    /**
     * 删除某个学生的打印申请（清除和打印申请相关联的活动申请）
     * @param printId
     * @return
     */
    int deletePrintApply(String printId);

    /**
     *添加和打印申请关联的活动申请
     * @param map   格式为  {printId:xxxx,applyIds:[{},{}]}
     * @return
     */
    int addPrintApply(Map<String ,Object> map);

//    ********************************成绩单得分*****************

    /**
     * 添加
     * @param list
     * @return
     */
    int addPoint(List<Map<String ,Object>> list);

    /**
     * 删除原有的得分
     *
     * @param studentId
     * @return
     */
    int delPoint(String studentId);

    /**
     * 加载某个学生的每年的分数
     * @return
     */
    List<Map<String ,Object>> loadPointByYears(String studentId);
    //**********************************打印预览页面**************************************

    /**
     * 根据学生ID加载打印队列中的活动申请
     * @param studentid
     * @return
     */
    List<Map<String ,String >> loadApplyActivitiesByStudentId(@Param("studentid") String studentid,@Param("printid") String printid);

    /**
     * 通过学生ID获取打印ID
     * @param studentid
     * @return
     */
    List<String> loadPrintIdByStudentid(String studentid);
    /**
     * 通过打印ID 获取申请活动ID
     * @param list
     * @return
     */
    List<String> loadApplyIdByPrintId(List<String> list);

    /**
     * 通过活动申请ID 获得活动
     * @param list
     * @return
     */
    List<Map<String ,Object>> loadAcitivityByApplyId(List<String> list);

    /**
     * 通过session中的学生ID 查询到该学生打印过的活动
     * @param studentid
     * @return
     */
    List<Map<String ,String>>loadActivityByStudentId(String studentid);
    /**
     * 查询级别任职得分
     *
     */
    String loadLevlePoint(String workName);
    /**
     * 查询工作组织得分
     */
    String loadSchoolPoint(String workName);
    /**
     * 查询班级职务得分
     */
    String loadClassPoint(String workName);
    /**
     * 获取工作级别
     */
    String workLevle(String organizationName);
    /**
     * 获取职务部门
     */
    String organizationName(String workName);

    /**
     * 排序创建
     * @param map
     * @return
     */
    int insetToSort(Map<String,Object> map );
    /**
     * 删除原始数据
     */
    int deleteStudentName(String studentId);
    /**
     * 获取排序
     * @param map
     * @return
     */
    List <Map<String,Object>> loadSort(Map<String,Object> map);
}
