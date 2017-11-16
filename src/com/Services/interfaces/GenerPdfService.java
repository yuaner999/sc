package com.Services.interfaces;

import java.util.Map;

/**
 * @author hong
 * Created by admin on 2016/8/11.
 */
public interface GenerPdfService {
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
