package com.Services.impls;

import com.Services.interfaces.SupplementApplyService;
import com.dao.interfaces.SupplementDao;
import com.model.SupplementApplyEntity;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;

/**
 * Created by  shaowen 2016/11/11.
 */
@Service
public class SupplementApplyServiceImpl implements SupplementApplyService {
    @Autowired
    private SupplementDao supplementDao;
    @Override
    public int addSupplement(Map<String, String> map) {
        return supplementDao.addSupplement(map);
    }

    @Override
    public int eidtSupplement(Map<String, String> map) {
        return supplementDao.eidtSupplement(map);
    }

    @Override
    public List<Map<String, String>> getSupplement(String studentID) {
        return supplementDao.getSupplement(studentID);
    }

    @Override
    public Map<String, String> getActivityByTitle(String supActivityTitle) {
        return supplementDao.getActivityByTitle(supActivityTitle);
    }

    @Override
    public List<Map<String, String>> getApplyIdByprintId(String printId) {
        return supplementDao.getApplyIdByprintId(printId);
    }

    @Override
    public List<Map<String, String>> getSupplementAll(Map<String, Object> ids) {
        return supplementDao.getSupplementAll(ids);
    }

    @Override
    public List<Map<String, String>> getSupplementByIds(Map<String, Object> ids) {
        return supplementDao.getSupplementByIds(ids);
    }

    @Override
    public List<Map<String, String>> getSupplementByUser(String userid) {
        return supplementDao.getSupplementByUser(userid);
    }

    @Override
    public int saveThemeActity(List<SupplementApplyEntity> list) {
        return supplementDao.saveThemeActity(list);
    }
}