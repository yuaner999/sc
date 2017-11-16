package com.Services.impls;

import com.Services.interfaces.CheckService;
import com.dao.interfaces.CheckDao;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;

/**
 * Created by guoqiang on 2016/9/18.
 */
@Service
public class CheckServiceImpl implements CheckService {

    @Autowired private CheckDao checkDao;

    @Override
    public List<Map<String, String>> checkReportAgain(Map<String, String> map) {
        return checkDao.checkReportAgain(map);
    }

    @Override
    public int insertReportInfo(Map<String, String> map) {
        return checkDao.insertReportInfo(map);
    }

    @Override
    public List studentIdByteamID(String teamID) {return checkDao.studentIdByteamID(teamID);}
}
