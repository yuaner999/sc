package com.controllers;

import com.Services.interfaces.EditStudentInfoService;
import com.common.utils.SpringUtils;
import com.supermapping.jdbcfactories.JdbcFactory;
import com.utils.PwdUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.io.UnsupportedEncodingException;
import java.security.NoSuchAlgorithmException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.HashMap;
import java.util.Map;

/**
 * Created by sw on 2016/9/13.
 */
@Controller
@RequestMapping("/jsons")
public class EditStudentPhone {
    @Autowired
    private EditStudentInfoService editStudentInfoService;

    /**
     * 修改手机号
     * @param request
     * @return
     */
    @RequestMapping("/EditStudentPhone")
    @ResponseBody
    public String EditStudentPhone(HttpServletRequest request, HttpSession session){
        Connection connection=null;
        PreparedStatement preparedStatement=null;
        String result=null;
        String studentID= (String) session.getAttribute("studentid");
        String studentPhone= PwdUtil.AESEncoding((String) request.getParameter("studentPhone"));
    //   System.out.println(studentID+"                    "+studentPhone);
        if(studentID!=null&&studentID!=""&&studentPhone!=null&&studentPhone!=""){
            try {
                JdbcFactory factory = SpringUtils.getBean(JdbcFactory.class);
                connection = factory.createConnection();
                String sql=" UPDATE student SET studentPhone=? WHERE studentID =?";
                preparedStatement=connection.prepareStatement(sql.toString());
                preparedStatement.setString(1, studentPhone);
                preparedStatement.setString(2, studentID);
                int i=preparedStatement.executeUpdate();
                if (i>0){
                    return "0";
                }else {
                    return "-1";
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
            }
        }else{
            result="修改失败,发生未知异常";
        }
        return result;
    }

    /**
     * 前端修改学生信息
     * @param request
     * @return
     */
    @RequestMapping("/EditStudentInfo")
    @ResponseBody
    public String EditStudentInfo(HttpServletRequest request, HttpSession session) throws UnsupportedEncodingException, NoSuchAlgorithmException {
        String result="-1";
        String studentID= (String) session.getAttribute("studentid");
        String sphone=request.getParameter("phone");
        String studentPhone="";
        if(sphone!=null||!sphone.equals("")){
            studentPhone= PwdUtil.AESEncoding(sphone);
        }
        String studentPhoto=  request.getParameter("studentPhoto");
        String oldpwd= request.getParameter("oldpwd");
        String repwd=  request.getParameter("repwd");
        String nowPassword = (String) session.getAttribute("loginuserpassword");
        oldpwd = PwdUtil.getPassMD5(oldpwd);
        String  newPassword="";
        if(repwd!=null&&!repwd.equals("")){
            newPassword = PwdUtil.getPassMD5(repwd);
            if(oldpwd==null||oldpwd.equals("")){
                return "原密码输入错误";
            }
            if(!nowPassword.equals(oldpwd)){
                return "原密码输入错误";
            }
        }
        Map map=new HashMap<>();
        map.put("studentID",studentID);
        map.put("studentPhone",studentPhone);
        map.put("studentPwd",newPassword);
        map.put("studentPhoto",studentPhoto);

        result=editStudentInfoService.EditStudentInfo(map);
        return result;

    }

}
