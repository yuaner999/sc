package com.Services.interfaces;

import java.util.List;
import java.util.Map;

/**
 * Created by admin on 2017/2/28.
 */
public interface SixDetailService {
    /**
     * 保存
     * @param list
     * @return
     */
    int saveDetailList(List<Map<String ,String >> list);

    /**
     * 删除
     * @param studentId
     * @return
     */
    int deleteDetailByStudentId(String studentId);
}
