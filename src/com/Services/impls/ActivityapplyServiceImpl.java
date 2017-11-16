package com.Services.impls;

import com.Services.interfaces.ActivityapplyService;
import com.dao.interfaces.ActivityapplyDao;
import com.model.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Created by  sw 2016/8/24.
 */
@Service
public class ActivityapplyServiceImpl implements ActivityapplyService {

    @Autowired
    private ActivityapplyDao activityapplyDao;

    @Override
    public int saveActivityapplys(List<activityapply> list) {
        return activityapplyDao.saveActivityapplys(list);
    }

    @Override
    public Student selectStudentID(String ID) {
        return activityapplyDao.selectStudentID(ID);
    }

    @Override
    public activityapply selectActivty(String applyStudentId, String applyActivityId) {
        return activityapplyDao.selectActivty(applyStudentId, applyActivityId);
    }

    @Override
    public int delApply(String applyId) {
        return activityapplyDao.delApply(applyId);
    }

    @Override
    public int updateApplayIsdelById(String applyId) {
        return activityapplyDao.updateApplayIsdelById(applyId);
    }

    @Transactional
    @Override
    public int updateApplayIsdelByIds(List<String> applyIds) {
        int count = 0;//记录执行成功次数
        int length = applyIds.size();
        for (int i = 0; i < length; i++) {
            int result = activityapplyDao.updateApplayIsdelById(applyIds.get(i));
            if (result <= 0) {
                result = activityapplyDao.updateSupplementIsdelById(applyIds.get(i));
                if (result > 0) {
                    count++;
                }
            } else {
                count++;
            }
        }
        if (count == length) {
            return 1;
        } else {
            return 0;
        }
    }

    @Override
    public int delApplyActivity(String activityId) {
        return activityapplyDao.delApplyActivity(activityId);
    }

    @Override
    public int saveActivtity(apply_activities applyactivities) {
        return activityapplyDao.saveActivtity(applyactivities);
    }

    @Override
    public int addTeaminfor(Team team) {
        return activityapplyDao.addTeaminfor(team);
    }

    @Override
    public int addStudentTeam(Map<String, Object> map) {
        return activityapplyDao.addStudentTeam(map);
    }

    @Override
    public int editTeaminfor(Team team) {
        return activityapplyDao.editTeaminfor(team);
    }

    @Override
    public int editStudentTeam(Map<String, Object> map) {
        String teamid = (String) map.get("teamId");
        int result = 0;
        if (teamid != null && !teamid.equals("")) {
            result = activityapplyDao.delrstudentteam(teamid);
        }
        if (result > 0) {
            result = activityapplyDao.addStudentTeam(map);
        }
        return result;
    }

    @Override
    public int editActivityapply(activityapply Activityapply) {
        return 0;
    }

    @Override
    public activities selectActivities(String activityId) {
        return activityapplyDao.selectActivities(activityId);
    }

    @Override
    public Team selectTeamByname(String teamName, String teamActivityId) {
        return activityapplyDao.selectTeamByname(teamName, teamActivityId);
    }

    @Override
    public List<String> getStudentIds(String stuClassName) {
        return activityapplyDao.getStudentIds(stuClassName);
    }

    @Override
    public List<String> getStudentIdsByActivityid(String activityId) {
        return activityapplyDao.getStudentIdsByActivityid(activityId);
    }

    @Override
    public int editActivityApply(List<String> idslist, String Type, int type) {

        int result = 0;
        if (type == 0) {
            Map<String, Object> map = new HashMap<>();
            map.put("idslist", idslist);
            map.put("regimentAuditStatus", Type);
            result = activityapplyDao.editApplyClass(map);
        }
        if (type == 1) {
            Map<String, Object> map = new HashMap<>();
            map.put("idslist", idslist);
            map.put("collegeAuditStatus", Type);
            result = activityapplyDao.editApplyCollege(map);
        }
        if (type == 2) {
            Map<String, Object> map = new HashMap<>();
            map.put("idslist", idslist);
            map.put("schoolAuditStaus", Type);
            result = activityapplyDao.editApplySchool(map);
        }
        return result;
    }

    @Override
    public int editSupplementApply(List<String> idslist, String Type, int type) {
        int result = 0;
        if (type == 0) {
            Map<String, Object> map = new HashMap<>();
            map.put("idslist", idslist);
            map.put("regimentAuditStatus", Type);
            result = activityapplyDao.editSupplementClass(map);
        }
        if (type == 1) {
            Map<String, Object> map = new HashMap<>();
            map.put("idslist", idslist);
            map.put("collegeAuditStatus", Type);
            result = activityapplyDao.editSupplementCollege(map);
        }
        if (type == 2) {
            Map<String, Object> map = new HashMap<>();
            map.put("idslist", idslist);
            map.put("schoolAuditStaus", Type);
            result = activityapplyDao.editSupplementSchool(map);
        }
        return result;
    }

    @Override
    public int editSupplementApplyScore(List<String> idslist, String Type, String score, int type) {
        int result = 0;
        if (type == 0) {
            Map<String, Object> map = new HashMap<>();
            map.put("idslist", idslist);
            map.put("regimentAuditStatus", Type);
            map.put("score", score);
            result = activityapplyDao.editSupplementClass(map);
        }
        if (type == 1) {
            Map<String, Object> map = new HashMap<>();
            map.put("idslist", idslist);
            map.put("collegeAuditStatus", Type);
            map.put("score", score);
            result = activityapplyDao.editSupplementCollege(map);
        }
        if (type == 2) {
            Map<String, Object> map = new HashMap<>();
            map.put("idslist", idslist);
            map.put("schoolAuditStaus", Type);
            map.put("score", score);
            result = activityapplyDao.editSupplementSchool(map);
        }
        return result;
    }

    @Override
    public int editSupplementApplyScore1(List<String> idslist, String Type, String score, int type) {
        int result = 0;
        if (type == 0) {
            Map<String, Object> map = new HashMap<>();
            map.put("idslist", idslist);
            map.put("regimentAuditStatus", Type);
            map.put("score", score);
            result = activityapplyDao.editSupplementClass(map);
        }
        if (type == 1) {
            Map<String, Object> map = new HashMap<>();
            map.put("idslist", idslist);
            map.put("collegeAuditStatus", Type);
            map.put("score", score);
            result = activityapplyDao.editSupplementCollege(map);
        }
        if (type == 2) {
            Map<String, Object> map = new HashMap<>();
            map.put("idslist", idslist);
            map.put("schoolAuditStaus", Type);
            map.put("score", score);
            result = activityapplyDao.editSupplementSchool(map);
        }
        return result;
    }

    @Override
    public List<Map> SelectAuditSupplement(List<String> idslist, int types) {
        List<Map> list = new ArrayList<>();
        if (types == 0) {
            Map<String, Object> map = new HashMap<>();
            map.put("idslist", idslist);
            list = activityapplyDao.selectSupplementClass(map);
        }
        if (types == 1) {
            Map<String, Object> map = new HashMap<>();
            map.put("idslist", idslist);
            list = activityapplyDao.selectSupplementCollege(map);
        }
        if (types == 2) {
            Map<String, Object> map = new HashMap<>();
            map.put("idslist", idslist);
            list = activityapplyDao.selectSupplementSchool(map);
        }
        return list;
    }

    @Override
    @Transactional
    public int addAndUpdateApplySignInfo(List<Map<String, String>> list) {
        if (list != null && list.size() > 0) {
            //int i=activityapplyDao.deleteByActivity(list.get(0).get("applyActivityId"));
            activityapplyDao.delapplysInfo(list);
            return activityapplyDao.saveapplysInfo(list);
        }
        return -2;
    }

    @Override
    public List<String> getstudentIdByClassName(String className) {
        return activityapplyDao.getstudentIdByClassName(className);
    }
}