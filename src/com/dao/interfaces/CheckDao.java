package com.dao.interfaces;

import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Map;

/**
 * Created by guoqiang on 2016/9/18.
 */
@Repository
public interface CheckDao {
   List<Map<String, String>> checkReportAgain(Map<String, String> map);
   int insertReportInfo(Map<String, String> map);
   List studentIdByteamID(String teamID);
}
