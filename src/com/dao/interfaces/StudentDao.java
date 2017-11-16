package com.dao.interfaces;

import com.model.Student;
import com.model.Student_Decoding;
import com.model.Student_Encoding;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Map;

/**
 * @author hong
 * Created by admin on 2016/7/15.
 */
@Repository
public interface StudentDao {
    /**
     * 批量存入数据库
     * @param list
     * @return
     */
    int saveStudents(List<Student> list);

    /**
     * 查询批量导入的数据和数据库中的数据有重复
     * @param list
     * @return
     */
    List<String > getKeys(List<Map<String,String>> list);

    /**
     * 批量删除
     * @param list
     * @return
     */
    int deleteMore(List<String > list);

    /**
     * 获取所有的班级名称
     * @return
     */
    List<String > getClassName();

    /**
     * 获取学生信息，通过学号
     * @param id
     * @return
     */
    Student_Decoding getStudentById(String id);

    /**
     * 找回密码用到的验证码
     * @param studentId
     * @param validId
     * @return
     */
    int saveFindPwdCode(String studentId,String validId);

    /**
     * 加载 && 搜索
     * @param map 各种条件
     * @return
     */
    List<Student_Decoding> loadStudents(Map<String ,Object > map);
    List<Student_Decoding> loadStudentsNew(Map<String ,Object > map);
    List<Student_Decoding> loadStudentsByClass(Map<String ,Object > map);

    /**
     * 新建学生信息
     * @param student 加密后的
     * @return
     */
    int addStudent(Student_Encoding student);

    /**
     * 修改学生信息
     * @param student 加密后的
     * @return
     */
    int editStudent(Student_Encoding student);

    /**
     * 加载——学制
     * @return
     */
    List<String > loadeducationLength();

    /**
     * 培养方式
     * @return
     */
    List<String > loadtrainingMode();

    /**
     * 招生类别
     * @return
     */
    List<String > loadenrollType();

    /**
     * 学籍状态
     * @return
     */
    List<String > loadschoolRollStatus();
    /**
     * 年级
     * @return
     */
    List<String > loadschoolstuGradeName();
    /**
     * 学院
     * @return
     */
    List<String > loadschoolstuCollageName();
    /**
     * 专业
     * @return
     */
    List<String > loadschoolstuMajorName();
    /**
     * 民族
     * @return
     */
    List<String > loadschoolstudentNation();

    /**
     * 加载寝室楼
     * @return
     */
    List<String > loadUsiBuilding();

    /**
     * 加载房间号
     * @return
     */
    List<String > loadUsiRoomNumber();

    /**
     * 加载入学时间(只显示年)
     * @return
     */
    List<String > loadEntranceDate();

    /**
     * 前端页面用，加载学生个人信息
     * @param studentid 学号
     * @return
     */
    Student_Decoding loadStudentInfo(String studentid);

    /**
     * 修改学生手机号
     * @param studentid 学号
     * @param newphone 新手机号
     * @return
     */
    int editPhone(String studentid, String newphone);

    /**
     * 修改学生手机号
     * @param studentid 学号
     * @param newphoto 新照片
     * @return
     */
    int editPhoto(String studentid, String newphoto);
}

