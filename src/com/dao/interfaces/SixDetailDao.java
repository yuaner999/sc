package com.dao.interfaces;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Map;

/**
 * 六项能力的得分详细情况
 * @author hong
 * Created by admin on 2017/2/28.
 */
@Repository
public interface SixDetailDao {
    /**
     * 保存
     * @param list
     * @return
     */
    int saveDetailList(@Param("list") List<Map<String ,String >> list);

    /**
     * 删除
     * @param studentId
     * @return
     */
    int deleteDetailByStudentId(String studentId);
}
