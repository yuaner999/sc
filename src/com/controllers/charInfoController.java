package com.controllers;

import com.common.utils.SpringUtils;
import com.model.DataForDatagrid;
import com.supermapping.jdbcfactories.JdbcFactory;
import org.omg.CORBA.Object;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpSession;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Created by sw on 2016/9/13.
 */
@Controller
@RequestMapping("/char")
public class charInfoController {
    /**
     *  加载六项能力得分。如果传递学生ID，则会从session中取值，前端页面使用时不需要传递studentID 参数
     *  后台管理页面使用的时候会传递过来一个studentID 的参数。
     * @param session
     * @param studentid  后台管理页面使用该参数。
     * @return
     */
    @RequestMapping(value = "/loadSixElementPoint",method = RequestMethod.POST)
    @ResponseBody
    public DataForDatagrid execute(HttpSession session,String studentid){
        //通过session 获得学生的id
        DataForDatagrid data=new DataForDatagrid();
        if(studentid == null || "".equals(studentid) || studentid.equals("null")){
            studentid= (String) session.getAttribute("studentid");
        }
    //用jdbc 连接数据库
    JdbcFactory factory = SpringUtils.getBean(JdbcFactory.class);
        Connection connection=null;
        PreparedStatement preparedStatement=null;
        ResultSet resultSet=null;
        List list = new ArrayList<>();
        try {
            if(studentid!=null&&studentid!=""){
                connection = factory.createConnection();
                //空id 在之前判断
                String sql = "SELECT id,studentId,pointYear,ROUND(sibian,2) AS sibian,ROUND(zhixing,2) AS zhixing,ROUND(biaoda,2) AS biaoda,ROUND(lingdao,2) " +
                        "AS lingdao,ROUND(chuangxin,2) AS chuangxin,ROUND(chuangye,2) AS chuangye FROM sixelementpoint WHERE  studentId = ? ORDER BY pointYear ";
                preparedStatement = connection.prepareStatement(sql);
                preparedStatement.setString(1, studentid);
                resultSet = preparedStatement.executeQuery();
                while(resultSet.next()) {
                    Map<String, java.lang.Object> map = new HashMap<>();
                    String id = resultSet.getString("id");
                    String pointYear = resultSet.getString("pointYear");
                    String studentId = resultSet.getString("studentId");
                    double  biaoda = resultSet.getDouble("biaoda")>=100.00?100:resultSet.getDouble("biaoda");
                    double  chuangxin = resultSet.getDouble("chuangxin")>=100.00?100:resultSet.getDouble("chuangxin");
                    double  chuangye = resultSet.getDouble("chuangye")>=100.00?100:resultSet.getDouble("chuangye");
                    double  lingdao = resultSet.getDouble("lingdao")>=100.00?100:resultSet.getDouble("lingdao");
                    double  zhixing =resultSet.getDouble("zhixing")>=100.00?100:resultSet.getDouble("zhixing");
                    double  sibian = resultSet.getDouble("sibian")>=100.00?100:resultSet.getDouble("sibian");
                    map.put("id",id);
                    map.put("pointYear",pointYear);
                    map.put("studentId",studentId);
                    map.put("biaoda",biaoda);
                    map.put("chuangxin",chuangxin);
                    map.put("chuangye",chuangye);
                    map.put("lingdao",lingdao);
                    map.put("zhixing",zhixing);
                    map.put("sibian",sibian);
                    list.add(map);
                }
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
            //关闭连接
            try {
                if (connection!=null){
                    connection.close();
                }
            } catch (SQLException e) {
                e.printStackTrace();
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
//        System.out.println(list);
        data.setDatas(list);
        return data ;
    }


}
