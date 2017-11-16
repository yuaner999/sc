package com.dao.interfaces;

import org.springframework.stereotype.Repository;

import java.util.Map;

/**
 * Created by guoqiang on 2016/12/9.
 */
@Repository
public interface EditStudentInfoDao {
    int  EditStudentInfo(Map map);
}
