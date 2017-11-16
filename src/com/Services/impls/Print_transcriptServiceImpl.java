package com.Services.impls;

import com.Services.interfaces.Print_transcriptService;
import com.dao.interfaces.Print_transcriptDao;
import com.model.ResultData;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

/**
 * @author hong
 * Created by admin on 2016/8/25.
 */
@Service
public class Print_transcriptServiceImpl implements Print_transcriptService {
    @Autowired
    private Print_transcriptDao print_transcriptDao;
    @Override
    public List<Map<String, String>> loadApplies(String studentId) {
        return print_transcriptDao.loadApplies(studentId);
    }

    @Override
    public List<Map<String, String>> loadAppliesByIds(List<String> list) {
        return print_transcriptDao.loadAppliesByIds(list);
    }

    @Override
    public List<Map<String, String>> loadAppliesByUserid(String userid) {
        return print_transcriptDao.loadAppliesByUserid(userid);
    }

    @Override
    @Transactional
    public int addPrint(String printId, String studentid) {
        return print_transcriptDao.addPrint(printId,studentid);
    }

    @Override
    @Transactional
    public int deletePrintApply(String printId) {
        return print_transcriptDao.deletePrintApply(printId);
    }

    @Override
    @Transactional
    public int addPrintApply(Map<String, Object> map) {
        return print_transcriptDao.addPrintApply(map);
    }

    @Override
    @Transactional
    public ResultData changePrintApplies(Map<String, Object> map) {
        ResultData re=new ResultData();
        String printId= (String) map.get("printId");
        int i=deletePrintApply(printId);
        if(i!=-1){
            i=addPrintApply(map);
        }
        re.setStatusByDBResult(i);
        return re;
    }

    @Override
    @Transactional
    public int addPoint(Map<String, Map<String, Double>> maplist,String studentId) {
        List<Map<String ,Object>> list=new ArrayList<>();
        for(String key:maplist.keySet()){
            Map<String ,Object> map=new LinkedHashMap<>();
            map.put("pointYear",key);
            map.put("studentId",studentId);
            Map<String ,Double> six=maplist.get(key);
            for(String k:six.keySet()){
                map.put(k,six.get(k));
            }
            list.add(map);
        }
        int i=delPoint(studentId);
//        System.out.println("删除评分的学生ID："+studentId);
//        System.out.println("删除的结果为："+i);
        if(i>=0){
//            System.out.println(list.toString());
            return print_transcriptDao.addPoint(list);
        }
        return -2;
    }

    @Override
    @Transactional
    public int delPoint(String studentId) {
        return print_transcriptDao.delPoint(studentId);
    }

    @Override
    public List<Map<String, Object>> loadPointByYears(String studentId) {
        return print_transcriptDao.loadPointByYears(studentId);
    }

    @Override
    public List<Map<String, String>> loadApplyActivitiesByStudentId(String studentid,String printid) {
        return print_transcriptDao.loadApplyActivitiesByStudentId(studentid,printid);
    }

    @Override
    public List<String> loadPrintIdByStudentid(String studentid) {
        return print_transcriptDao.loadPrintIdByStudentid(studentid);
    }

    @Override
    public List<String> loadApplyIdByPrintId(List<String> list) {
        return print_transcriptDao.loadApplyIdByPrintId(list);
    }


    @Override
    public List<Map<String, Object>> loadAcitivityByApplyId(List<String> list) {
        return print_transcriptDao.loadAcitivityByApplyId(list);
    }

    @Override
    public List<Map<String, String>> loadActivityByStudentId(String studentid) {
        return  print_transcriptDao.loadActivityByStudentId(studentid);
    }

    @Override
    public String loadLevlePoint(String workName) {
        String organizationName=print_transcriptDao.organizationName(workName);
        String workLevle="";
        if (!organizationName.equals("")&&organizationName!=null){
             workLevle=print_transcriptDao.workLevle(organizationName);
        }
        return print_transcriptDao.loadLevlePoint(workLevle);
    }

    @Override
    public String loadSchoolPoint(String schoolworkName) {
        return print_transcriptDao.loadSchoolPoint(schoolworkName);
    }

    @Override
    public String loadClassPoint(String classworkName) {
        return print_transcriptDao.loadClassPoint(classworkName);
    }

    /**
     * 新插入的临时排序
     * @param map
     * @return
     */
    @Override
    public int insetToSort(Map<String, Object> map) {
        return print_transcriptDao.insetToSort(map);
    }

    /**
     * 删除原来的临时排序
     * @param studentId
     * @return
     */
    @Override
    public int deleteStudentName(String studentId) {
        return print_transcriptDao.deleteStudentName(studentId);
    }

    @Override
    public  List <Map<String,Object>> loadSort(Map<String, Object> map) {
        return print_transcriptDao.loadSort(map);
    }
}
