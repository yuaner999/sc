package com.controllers;

import com.Services.interfaces.CheckService;
import com.Services.interfaces.Print_transcriptService;
import com.Services.interfaces.SupplementApplyService;
import com.common.utils.SpringUtils;
import com.model.DataForDatagrid;
import com.model.ResultData;
import com.supermapping.jdbcfactories.JdbcFactory;
import org.apache.commons.collections.map.HashedMap;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import static java.lang.Integer.parseInt;


/**
 * 打印成绩单
 *
 * Created by shaowen on 2016/8/25.
 */
@Controller
@RequestMapping("/printTranscript")
public class PrintController {
    @Autowired
    private Print_transcriptService print_transcriptService;
    @Autowired
    private SupplementApplyService supplementApplyService;

    @RequestMapping(value = "/print", method = RequestMethod.POST)
    @ResponseBody
    public ResultData print(HttpServletRequest request, String studentID,String printID, HttpServletResponse  response, HttpSession session) {
        ResultData re=new ResultData();
        JdbcFactory factory = SpringUtils.getBean(JdbcFactory.class);
        String printId="";
        //后台教师查看打印详情传过来的printID
        if(printID==null||printID.equals("")){
            printId=getPrintId(factory,studentID);
        }else{
            printId=printID;
        }
        session.setAttribute("printId",printId);
        List<Map<String, String>> list = print_transcriptService.loadApplyActivitiesByStudentId(studentID, printId);
        list = getSupplement(printId, list);
        for (Map<String,String> map:list){
            String applyDate= map.get("applyDate");
            String nian=applyDate.substring(0,4);
            String xueqi=applyDate.substring(5,7);
            int year=parseInt(nian);
            int mouth= parseInt(xueqi);
            if(mouth>=3&&mouth<9){
                xueqi="年上学期";
                year=year;
            }else if(mouth<3&&mouth>=1) {
                xueqi="年下学期";
                year=year-1;
            }else if(mouth>=9&&mouth<=12){
                xueqi="年下学期";
                year=year;
            }
            map.put("applyDate",year+xueqi);
        }
//        list = getSort(list,studentID);
        re.setData(list);
        return re;
    }
    /**
     * 通过学生ID 获取打印ID
     * @param factory
     * @param studentid
     * @return map
     * @throws ClassNotFoundException
     * @throws SQLException
     * @throws InstantiationException
     * @throws IllegalAccessException
     */
    public String getPrintId(JdbcFactory factory, String studentid)  {
        Connection connection = null;
        PreparedStatement preparedStatement=null;
        ResultSet resultSet=null;
        String printId="";
        try {
            connection = factory.createConnection();
            String sql="SELECT printId,printAuditstatus,printStatus FROM print WHERE studentId=? AND createDate=(SELECT MAX(createDate) FROM print)";
            preparedStatement = connection.prepareStatement(sql);
            preparedStatement.setString(1, studentid);
            resultSet = preparedStatement.executeQuery();
            if(resultSet.next()){
                printId=resultSet.getString("printId");
            }
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        } catch (IllegalAccessException e) {
            e.printStackTrace();
        } catch (InstantiationException e) {
            e.printStackTrace();
        } catch (SQLException e) {
            e.printStackTrace();
        }finally {
            if(connection!=null){
                try {
                    connection.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
            if(preparedStatement!=null){
                try {
                    preparedStatement.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
            if(resultSet!=null){
                try {
                    resultSet.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
        }
        return printId;
    }
    /**
     * 查看该学生有没有补充活动
     *
     * @param printid
     * @param list
     * @return
     */
    public List<Map<String, String>> getSupplement(String printid, List<Map<String, String>> list) {
        List<Map<String, String>> suplist = new ArrayList<>();
        if (printid != null && !printid.equals("")) {
            suplist = getSupplementByprintid(printid);
        }
        for (Map<String, String> map : suplist) {
            if (map.get("shipName") != null && !map.get("shipName").equals("")) {
                map.put("activityClass", map.get("supClass"));
                map.put("activityLevle", map.get("shipType"));
                map.put("activityCredit", "");
                map.put("activityTitle", map.get("shipName"));
                map.put("supWorktime", map.get("supWorktime"));
                map.put("activityAward", "");
                map.put("id", map.get("applyId"));
            }
            if (map.get("scienceName") != null && !map.get("scienceName").equals("")) {
                map.put("activityClass", map.get("supClass"));
                map.put("activityLevle", map.get("scienceClass"));
                map.put("activityCredit", "");
                map.put("activityTitle", map.get("scienceName"));
                map.put("supWorktime", map.get("supWorktime"));
                map.put("activityAward", "");
                map.put("id", map.get("applyId"));
            }
            if (map.get("workName") != null && !map.get("workName").equals("")) {
                map.put("activityClass", map.get("supClass"));
                map.put("activityLevle", map.get("workClass"));
                map.put("activityCredit", "");
                map.put("activityTitle", map.get("workName"));
                map.put("supWorktime", map.get("supWorktime"));
                map.put("activityAward", "");
                map.put("id", map.get("applyId"));
            }
            if (map.get("supActivityTitle") != null && !map.get("supActivityTitle").equals("")) {
                map.put("activityTitle", map.get("supActivityTitle"));
                map.put("supWorktime", map.get("supWorktime"));
                map.put("activityAward", map.get("supAward"));
                map.put("activityClass", map.get("supClass"));
                map.put("activityLevle", map.get("supLevle"));
                map.put("activityCredit", map.get("supCredit"));
                map.put("id", map.get("applyId"));
            }
            list.add(map);
        }
        return list;
    }

    /**
     * 根据打印id 取补充活动id
     *
     * @param printid
     * @return
     */
    public List<Map<String, String>> getSupplementByprintid(String printid) {
        Map<String, Object> ids = new HashMap<>();
        /**
         * 根据打印ID 取 补充活动id
         */
        List<Map<String, String>> map = supplementApplyService.getApplyIdByprintId(printid);
        List<String> list = new ArrayList<>();
        for (Map<String, String> newmap : map) {
            list.add(newmap.get("applyId"));
        }
        ids.put("applyIds", list);
//        System.out.println(ids);
        /**
         * 根据补充活动id取相关信息
         */
        List<Map<String, String>> supplist = supplementApplyService.getSupplementAll(ids);
        return supplist;
    }

    /**
     *获取排序后的数据
     * @param list
     * @param studentid
     * @return
     */
    public List<Map<String,String>> getSort(List<Map<String,String>> list,String studentid){
        Map<String,Object> map=new HashMap<>();
        List<Map<String,String>> newlist=new ArrayList<>();
        List<String> ids=new ArrayList<>();
        for(Map<String,String> idmap:list){
                ids.add(idmap.get("id"));
        }
        map.put("studentid",studentid);
        map.put("list",ids);
//         System.out.println(map);
        List<Map<String, Object>> sort=print_transcriptService.loadSort(map);
        String sortID="";
//        System.out.println(sort);
        for(Map<String, Object> Sort:sort){
            sortID+=Sort.get("id")+"|";
        }
//       System.out.println(sortID);
        String[] sortIDs=sortID.split("[|]");
        for(int i=0;i<sortIDs.length;i++){
            for (Map<String,String> idmap:list){
                if(idmap.get("id").equals(sortIDs[i])){
                    newlist.add(idmap);
                }
            }
        }
        return  newlist;
    }
}