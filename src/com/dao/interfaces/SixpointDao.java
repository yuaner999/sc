package com.dao.interfaces;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Map;

/**
 *
 * Created by admin on 2016/9/8.
 */
@Repository
public interface SixpointDao {
    /**
     * 加载学生六项能力
     * @param map
     * @return
     *
     */
    List<Map<String,String>> getsixpoint(Map<String,String> map);
}
