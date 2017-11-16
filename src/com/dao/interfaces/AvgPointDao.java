package com.dao.interfaces;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Map;

/**
 * Created by sw 2016/8/26.
 */
@Repository
public interface AvgPointDao {
    /**
     * 获取活动平均分
     * @param sqlStr
     * @return
     */
    List<Map<String,String>> loadavgPointActivity(@Param(value="sqlStr") String sqlStr);
}
