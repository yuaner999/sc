package com.controllers.mobile;

import com.Services.interfaces.ActivitiesService;
import com.Services.interfaces.StudentService;
import com.common.utils.SpringUtils;
import com.model.DataForDatagrid;
import com.model.ResultData;
import com.supermapping.jdbcfactories.JdbcFactory;
import com.utils.PwdUtil;
import org.apache.commons.collections.map.HashedMap;
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
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

/**
 * 类的描述
 *
 * @Author lirf
 * @Date 2017/6/6 13:51
 */
@Controller
@RequestMapping(value = "/StudentInfo")
public class AppStudentController {

    @Autowired
    public StudentService studentService;
    @Autowired
    public ActivitiesService activitiesService;

    /**
     * APP用个人信息
     *
     * @param session
     * @param studentid
     * @return data
     */
    @RequestMapping(value = "/loadStudentInfo")
    @ResponseBody
    public DataForDatagrid loadInfor(HttpSession session, String studentid) {
        if (studentid == null || studentid.equals("") || studentid.equals("null")) {
            studentid = (String) session.getAttribute("studentid");
        }
        JdbcFactory factory = SpringUtils.getBean(JdbcFactory.class);
        Connection connection = null;
        PreparedStatement preparedStatement = null;
        ResultSet resultSet = null;
        DataForDatagrid data = new DataForDatagrid();
        try {
            if (studentid != null && studentid != "") {
                connection = factory.createConnection();
                String sql = "SELECT * FROM student WHERE studentID=?";
                preparedStatement = connection.prepareStatement(sql);
                preparedStatement.setString(1, studentid);
                resultSet = preparedStatement.executeQuery();
                if (resultSet.next()) {
                    String studentName = resultSet.getString("studentName");
                    String collegeName = resultSet.getString("stuCollageName");
                    String majorName = resultSet.getString("stuMajorName");
                    String className = resultSet.getString("stuClassName");
                    String studentPhone = resultSet.getString("studentPhone");
                    String studentID = resultSet.getString("studentID");
                    String studentPhoto = resultSet.getString("studentPhoto");
                    Map<String, String> map = new HashedMap();
                    map.put("studentName", studentName);
                    map.put("collegeName", collegeName);
                    map.put("majorName", majorName);
                    map.put("className", className);
                    map.put("studentPhone", PwdUtil.AESDecoding(studentPhone));
                    map.put("studentID", studentID);
                    map.put("studentPhoto", studentPhoto);
                    session.setAttribute("college", collegeName);
                    List<Map<String, String>> list = new ArrayList<>();
                    list.add(map);
                    data.setDatas(list);
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
        } finally {
            try {
                if (resultSet != null) {
                    resultSet.close();
                }
            } catch (SQLException e) {
                e.printStackTrace();
            }
            try {
                if (preparedStatement != null) {
                    preparedStatement.close();
                }
            } catch (SQLException e) {
                e.printStackTrace();
            }
            try {
                if (connection != null) {
                    connection.close();
                }
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        return data;
    }

    /**
     * 修改手机号
     *
     * @param request
     * @param session
     * @return data
     */
    @RequestMapping(value = "/editPhone")
    @ResponseBody
    public String editPhone(HttpServletRequest request, HttpSession session) {
        String studentid = (String) session.getAttribute("studentid");
        if (studentid == null) {
            return "登录超时，请重新登录";
        }

        String newPhone = request.getParameter("newPhone");
        int result = studentService.editPhone(studentid, PwdUtil.AESEncoding(newPhone));
        if (result > 0) {
            return "1";
        } else {
            return "手机号修改错误";
        }
    }
    /**
     * 活动签到
     *
     * @param request
     * @param session
     * @return data
     */
    @RequestMapping(value = "/signIn")
    @ResponseBody
    public ResultData signIn(HttpServletRequest request, HttpSession session) throws UnsupportedEncodingException, NoSuchAlgorithmException {
        String applyId = request.getParameter("applyId");
        String activityId = request.getParameter("activityId");
        ResultData re = new ResultData();
        String studentid = (String) session.getAttribute("studentid");
        if (studentid == null) {
            re.sets(0,"登录超时，请重新登录");
        }

        String data = PwdUtil.mergeStringWithXOROperation(applyId, activityId);
        re.setData(data);
        re.sets(1, "成功");
        return re;
    }
}
