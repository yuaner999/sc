package com.Services.interfaces;

import org.springframework.stereotype.Repository;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;

/**
 * Created by sw 2016/8/26.
 */
public interface AvgPointService {
    /**
     * 获取平分相关信息
     * @return
     */
    List<Map<String,String>> loadavgPointActivity(int rows,int page,String sqlStr);
}
