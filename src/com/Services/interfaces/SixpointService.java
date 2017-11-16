package com.Services.interfaces;


import com.model.Member;
import com.model.Member_Decoding;
import com.model.Member_Encoding;
import com.model.ResultData;

import java.util.List;
import java.util.Map;


public interface SixpointService {
    /**
     * 加载学生六项能力
     * @param map
     * @param rows
     * @param pagenum
     * @return
     */
    List<Map<String,String>> getsixpoint(Map<String,String> map,int rows,int pagenum);
}
