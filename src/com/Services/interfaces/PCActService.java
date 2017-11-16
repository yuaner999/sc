package com.Services.interfaces;

import java.util.List;
import java.util.Map;

/**
 * Created by wd on 2016/9/12.
 */
public interface PCActService {
    List<Map<String,String>> loadPCAct(String[] str,int arows,int apage);
    List<Map<String,String>> loadActDetail(String actid);
    List<Map<String,String>> validatePCApply(String studentid,String actid);
    String applyPCAct(String studentid,String actid);
}
