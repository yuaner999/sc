package com.dao.interfaces;

import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Map;

/**
 * Created by wd on 2016/9/12.
 */
@Repository
public interface PCActDao {
    List<Map<String,String>> loadPCAct(Map<String,String> map);
    List<Map<String,String>> loadActDetail(String actid);
    List<Map<String,String>> validatePCApply(Map<String,String> map);
    int applyPCAct(Map<String,String> map);
}
