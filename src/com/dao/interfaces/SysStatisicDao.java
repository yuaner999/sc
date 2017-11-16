package com.dao.interfaces;

import org.springframework.stereotype.Repository;

import java.util.Map;

/**
 * 系统的统计信息
 * 主要查询本系统有多少学生使用了，有多少人参加活动，有多少人生成成绩单了
 *
 * Created by hong on 2017/4/19.
 */
@Repository
public interface SysStatisicDao {
    /**
     * 多少用户
     * @return
     */
    int howManyUsed(Map<String, String> map);

    /**
     * 多少人参加活动
     * @return
     */
    int howManyApplyed(Map<String, String> map);

    /**
     * 多少人生成成绩单
     * @return
     */
    int howManyGennered(Map<String, String> map);
}
