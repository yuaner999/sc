package com.Services.interfaces;

import java.util.List;
import java.util.Map;

/**
 * Created by shaowen on 2016/11/11.
 */
public interface SupplementInfoService {
    //查询活动补充申请（团支书帐号）
    List<Map<String,String>> loadSupplemenlPageClass(Map<String, String> map,int page,int row);

    //查询活动补充申请（院团委）
    List<Map<String,String>> loadSupplemenlPageCollege(Map<String, String> map,int page,int row);

    //查询活动补充申请（校团委）
    List<Map<String,String>> loadSupplementPageSchool(Map<String, String> map,int page,int row);


}
