package com.Services.interfaces;

import java.util.List;
import java.util.Map;

/**
 * Created by guoqiang on 2016/9/18.
 */
public interface CheckService {
    List<Map<String, String>> checkReportAgain(Map<String, String> map);
    int insertReportInfo(Map<String, String> map);
    List studentIdByteamID(String teamID);
}
