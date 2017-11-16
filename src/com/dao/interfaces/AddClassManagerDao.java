package com.dao.interfaces;

import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Map;

/**
 * Created by admin on 2016/12/20.
 */
@Repository
public interface AddClassManagerDao {
    /**
     * 添加班级管理员
     * @param
     * @return
     */
    int addClassManager(String userid,String classname);

    /**
     * 添加用户表中的班级管理员
     * @param userid
     * @param username
     * @return
     */
    int addSysuser(String userid,String username);
    /**
     * 加载已存在在班级管理员的班级
     * @return
     */
    List<String > loadManagerClass();

    /**
     * 加载所有的班级名字
     * @return
     */
    List<String > loadClassName();


}
