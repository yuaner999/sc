package com.dao.interfaces;

import org.springframework.stereotype.Repository;

import java.util.Map;

/**
 * 所有需要转换成pdf的表格所涉及到的数据库连接
 * @author hong
 * Created by admin on 2016/8/11.
 */
@Repository
public interface GenerPdfDao {
    /**
     * 学生证补办
     * @param map
     * @return
     */
    int saveStudentCard(Map<String, String> map);

    /**
     * 在读证明
     * @param map
     * @return
     */
    int saveInStudyProve(Map<String, String> map);
}
