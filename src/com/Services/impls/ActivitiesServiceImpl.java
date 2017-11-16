package com.Services.impls;

import com.Services.interfaces.ActivitiesService;
import com.dao.interfaces.ActivitiesDao;
import com.github.pagehelper.PageHelper;
import com.model.ActivityQuery;
import com.model.Dict;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Created by wd on 2016/9/9.
 */
@Service
public class ActivitiesServiceImpl implements ActivitiesService{
    @Autowired
    private ActivitiesDao activitiesDao;

    @Override
    public List<Map<String, String>> loadActivities(String[] str) {
        Map<String,String> map = new HashMap();
            map.put("activityClass",str[0]);
            map.put("activityLevle",str[1]);
            map.put("activityNature",str[2]);
            map.put("activityPowers",str[3]);
            map.put("activityParticipation",str[4]);
        return (activitiesDao.loadActivities(map));
    }

    @Override
    public List<String> loadactivityCreator() {
        return activitiesDao.loadactivityCreator();
    }

    @Override
    public List<ActivityQuery> newloadactivities(Map<String, Object> map, int pagenum, int rows) {
        PageHelper.startPage(pagenum,rows);
        //处理多项查询 把多选项中的参数的String变为数组
        //类别
        ChangString(map,"activityClass");
        //级别
        ChangString(map,"activityLevle");
        //能力
        ChangString(map,"activityPowers");
        //性质
        ChangString(map,"activityNature");
        //参与
        ChangString(map,"activityParticipation");
        //创建人
        ChangString(map,"activityCreator");
        //学院
        ChangString(map,"stuCollageName");
        //年级
        ChangString(map,"stuGradeName");
        //班级
        ChangString(map,"stuClassName");
        //专业
        ChangString(map,"stuMajorName");

//        System.out.println("这是传过去的map:"+map);
        List<ActivityQuery> list=activitiesDao.newLoadactivities(map);
        return list;
    }

    private void ChangString(Map<String, Object> map,String string){
//        System.out.println("这是传过来的map-----"+map);
        String  before =(String) map.get(string);
        if(before !=null && ! "".equals(before)){
            String[] now = before.split(",");
            if("activityClass".equals(string)){
               for(int i =0;i<now.length;i++){
                   if("思想政治教育类".equals(now[i])){
                       now[i]="1";
                       continue;
                   }
                   if("能力素质拓展类".equals(now[i])){
                       now[i]="2";
                       continue;
                   }
                   if("学术科技与科技创新类".equals(now[i])){
                       now[i]="3";
                       continue;
                   }
                   if("社会实践与志愿服务类".equals(now[i])){
                       now[i]="4";
                       continue;
                   }
                   if("社会工作与技能培训类".equals(now[i])){
                       now[i]="5";
                       continue;
                   }
                   if("其他类".equals(now[i])){
                       now[i]="6";
                       continue;
                   }
               }
            }

            if("activityLevle".equals(string)){
                for(int i =0;i<now.length;i++){
                    if("国际级".equals(now[i])){
                        now[i]="0";
                        continue;
                    }
                    if("国家级".equals(now[i])){
                        now[i]="1";
                        continue;
                    }
                    if("省级".equals(now[i])){
                        now[i]="2";
                        continue;
                    }
                    if("市级".equals(now[i])){
                        now[i]="3";
                        continue;
                    }
                    if("校级".equals(now[i])){
                        now[i]="4";
                        continue;
                    }
                    if("院级".equals(now[i])){
                        now[i]="5";
                        continue;
                    }
                    if("团支部级".equals(now[i])){
                        now[i]="6";
                        continue;
                    }
                }
            }

            if("activityNature".equals(string)){
                for(int i =0;i<now.length;i++){
                    if("活动参与".equals(now[i])){
                        now[i]="1";
                        continue;
                    }
                    if("讲座报告".equals(now[i])){
                        now[i]="2";
                        continue;
                    }
                    if("比赛".equals(now[i])){
                        now[i]="3";
                        continue;
                    }
                    if("培训".equals(now[i])){
                        now[i]="4";
                        continue;
                    }
                    if("其它".equals(now[i])){
                        now[i]="5";
                        continue;
                    }
                }
            }
            map.put(string,now);
        }else{
            before = null ;
            map.put(string,before);
        }

    }

    @Override
    public List<Map<String, String>> loadCheckActivities(Map<String, Object> map, int pagenum, int rows) {
        PageHelper.startPage(pagenum,rows);
        List<Map<String,String>> list=activitiesDao.loadCheckActivities(map);
        return list;
    }

    @Override
    public List<Map<String, String>> loadCheckActivitiesNew(Map<String, Object> map) {
        List<Map<String,String>> list=activitiesDao.loadCheckActivities(map);
        return list;
    }

    @Override
    public List<String> loadCheckCollege() {
        return activitiesDao.loadCheckCollege();
    }

    @Override
    public List<String> loadActivityTitle() {
        return activitiesDao.loadActivityTitle();
    }

    @Override
    public List<Dict> loadActivityScoreTotal() {
        return activitiesDao.loadActivityScoreTotal();
    }

    @Override
    public List<Dict> loadActivityScoreGet(Map<String, Object> newmap) {
        return activitiesDao.loadActivityScoreGet(newmap);
    }

    @Override
    public List<Map> loadActivityScoreGets(String id) {
        return activitiesDao.loadActivityScoreGets(id);
    }

    @Override
    public List<Map> loadSchoolActivityapply(Map newmap,int pagenum, int rows) {
        PageHelper.startPage(pagenum,rows);
        return activitiesDao.loadSchoolActivityapply(newmap);
    }


    public List<Map<String, String>> loadCheckAct(Map<String, Object> map, int pagenum, int rows) {
        PageHelper.startPage(pagenum,rows);
        List<Map<String,String>> list=activitiesDao.loadCheckAct(map);
        return list;
    }

    @Override
    public List<Map<String, String>> loadCheckActNew(Map<String, Object> newmap) {
        List<Map<String,String>> list=activitiesDao.loadCheckAct(newmap);
        return list;
    }

    @Override
    public List<Map> loadSupplementSchoolmybatis(Map<String, Object> newmap,int page,int rows) {
        PageHelper.startPage(page,rows);
        List<Map> list=activitiesDao.loadSupplementSchoolmybatis(newmap);
        return list;
    }
}
