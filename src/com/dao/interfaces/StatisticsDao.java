package com.dao.interfaces;

import org.springframework.stereotype.Repository;

/**
 * Created by sw on 2016/8/24.
 */
@Repository
public interface StatisticsDao {
    void StaticsTimes(String studentID);
}
