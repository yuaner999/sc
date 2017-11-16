/*
*Created by liulei on 2016/4/22.
*/
package com.controllers.mobile;

import com.Services.interfaces.StatisticsTiemsService;
import com.Services.interfaces.StudentService;
import com.Services.interfaces.WeChatUserService;
import com.Services.interfaces.WrongAccountService;
import com.common.utils.SpringUtils;
import com.controllers.PrintTranscriptController;
import com.model.Student;
import com.supermapping.jdbcfactories.JdbcFactory;
import com.utils.EmailUtils;
import com.utils.PwdUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.io.UnsupportedEncodingException;
import java.security.NoSuchAlgorithmException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Map;
import java.util.Properties;
import java.util.UUID;

/**
 * Created by liulei on 2016/4/22.
 */
@Controller
@RequestMapping(value = "/AppLogin")
public class AppLoginController {
    /**
     * 可以错误的次数
     */
    private static final int WRONGTIMES = 3;
    /**
     * 记录登陆错误的次数，当登陆次数达到三次后账号被锁定30分钟
     * update by hong
     */
    @Autowired
    private WrongAccountService wrongAccountService;
    @Autowired
    private StatisticsTiemsService statisticsTiemsService;
    @Autowired
    private PrintTranscriptController printTranscriptController;
    @Autowired
    private StudentService studentService;
    @Autowired
    WeChatUserService weChatUserService;
    @Autowired
    @Qualifier("email_config")
    private Properties emailConfig;

    /**
     * @param request
     * @param session
     * @return
     */
    @RequestMapping(value = "/SystemLogin")
    @ResponseBody
    public String SystemLogin(HttpServletRequest request, HttpSession session) {
        //返回结果
        String result = "登录失败，请联系服务人员";
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String openid = request.getParameter("openid");

        if (username.equals("")) {
            return "用户名错误";//用户名错误
        }
        if (password.equals("")) {
            return "密码错误";//密码错误
        }
        if (isLocked(username)) {
            return "您的账号因密码错误次数过多已被锁定，请30分钟后再登录";
        }

        JdbcFactory factory = SpringUtils.getBean(JdbcFactory.class);
        //学生登录
        result = studentLogin(username, password, openid, factory, session);
        return result;
    }
    /**
     * @param request
     * @param session
     * @return
     */
    @RequestMapping(value = "/checkOpenId")
    @ResponseBody
    public String checkOpenId(HttpServletRequest request, HttpSession session) {
        //返回结果
        String result = "登录失败，请联系服务人员";
        String openid = request.getParameter("openid");
        Map<String, Object> student = weChatUserService.getNowUser(openid);
        if (student == null) {//如果不存在
            //String area = jsonObject.getString("country") + jsonObject.getString("province") + jsonObject.getString("city");
            result = "1";
        } else {//如果存在
            result = "0";
        }
        return result;
    }

    /**
     * 学生登录处理逻辑
     *
     * @param user
     * @param pwd
     * @param factory
     * @param session
     * @return
     */
    public String studentLogin(String user, String pwd, String openid, JdbcFactory factory, HttpSession session) {

        Connection connection = null;
        PreparedStatement preparedStatement = null;
        ResultSet resultSet = null;
        try {
            connection = factory.createConnection();
            String sql = "SELECT * FROM student where studentID=?";
            preparedStatement = connection.prepareStatement(sql);
            preparedStatement.setString(1, user);
            resultSet = preparedStatement.executeQuery();
            String userName = "";
            if (resultSet.next()) {
                String userId = resultSet.getString("studentID");
                String studentName = resultSet.getString("studentName");
                String phone = PwdUtil.AESDecoding(resultSet.getString("studentPhone"));
                String databasePassword = resultSet.getString("studentPwd");
                userName = resultSet.getString("studentName");
                String stuCollageName = resultSet.getString("stuCollageName");
                pwd = PwdUtil.getPassMD5(pwd);
                if (databasePassword.equals(pwd)) {
                    //统计学生的登录次数
                    statisticsTiemsService.StaticsTimes(user);
                    //登录成功，清除角色登录失败记录
                    wrongAccountService.delWrongLogs(userName);
                    //登录成功,记录openID
                    //Map<String, String> student = new HashMap<>();
                    //student.put("openid", openid);
                    //student.put("studentID", userId);
                    //weChatUserService.addWeChatStudent(student);

                    session.setAttribute("loginId", userId);
                    session.setAttribute("studentid", userId);
                    session.setAttribute("studentPhone", phone);
                    session.setAttribute("studentName", studentName);
                    session.setAttribute("stuCollageName", stuCollageName);
                    session.setAttribute("loginName", userName);//将用户名写入Session
                    session.setAttribute("loginuserpassword", databasePassword);//将用户密码写入Session
                    session.setAttribute("logintype", "7");                 //将登陆的角色类型保存到session(导员)
                    printTranscriptController.getPoint(session, ""); //调用生成六项能力得分的方法，刷新得分
                } else {
//                    return "密码错误";
                    return wrongAccountAction(user);
                }
            } else {
                return "帐号或密码错误";
            }
            //return "1|" + userName;
            return "1";
        } catch (Exception e) {
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

        return "登录失败，请联系服务人员";
    }

    /**
     * 退出登录
     *
     * @param session
     */
    @RequestMapping(value = "/ExitLogin")
    @ResponseBody
    public String ExitLogin(HttpSession session) {
        session.removeAttribute("loginId");
        session.removeAttribute("loginName");
        session.removeAttribute("logintype");
        session.removeAttribute("studentid");
        session.removeAttribute("studentPhone");
        session.removeAttribute("studentName");
        session.removeAttribute("loginuserpassword");
        return "true";
    }

    /**
     * 修改密码
     *
     * @param request
     * @param session
     * @return
     * @throws UnsupportedEncodingException
     * @throws NoSuchAlgorithmException
     */
    @RequestMapping(value = "/EditPassword", method = RequestMethod.POST)
    @ResponseBody
    public String EditPassword(HttpServletRequest request, HttpSession session) throws UnsupportedEncodingException, NoSuchAlgorithmException {
        String studentid = (String) session.getAttribute("studentid");
        if (session.getAttribute("loginuserpassword") == null || studentid == null) {
            return "登录超时，请重新登录";
        }
        String nowPassword = (String) session.getAttribute("loginuserpassword");
        String oldPassword = request.getParameter("oldpassword") == null ? "" : request.getParameter("oldpassword");
        String newPassword = request.getParameter("newpassword") == null ? "" : request.getParameter("newpassword");
//        System.out.println("now:"+nowPassword+"|old:"+oldPassword+"|new:"+newPassword);
        oldPassword = PwdUtil.getPassMD5(oldPassword);
        newPassword = PwdUtil.getPassMD5(newPassword);
        String result = "-1";
        if (oldPassword.equals("") || newPassword.equals("")) {
            return "密码修改失败";
        }
        if (nowPassword.equals(oldPassword)) {
            JdbcFactory factory = SpringUtils.getBean(JdbcFactory.class);
            try {
                Connection connection = factory.createConnection();
                String sql;
                sql = "UPDATE student SET studentPwd=? WHERE studentID=?";
                PreparedStatement preparedStatement = connection.prepareStatement(sql);
                preparedStatement.setString(1, newPassword);
                preparedStatement.setString(2, studentid);
                preparedStatement.execute();
                //微信公众号用这个
                //result = clearOpenId(studentid);
                result = "1";
                //清理session
                ExitLogin(session);
                preparedStatement.close();
                connection.close();
            } catch (ClassNotFoundException e) {
                e.printStackTrace();
            } catch (IllegalAccessException e) {
                e.printStackTrace();
            } catch (InstantiationException e) {
                e.printStackTrace();
            } catch (SQLException e) {
                e.printStackTrace();
            }
            //清理掉session
            ExitLogin(session);
        } else {
            return "原密码错误";
        }
        return result;
    }
    /**
     * 清除微信openID记录
     *
     * @param studentid
     */
    public String clearOpenId (String studentid) {
        JdbcFactory factory = SpringUtils.getBean(JdbcFactory.class);
        try {
            Connection connection = factory.createConnection();
            String sql;
            sql = "UPDATE student SET openID='' WHERE studentID=?";
            PreparedStatement preparedStatement = connection.prepareStatement(sql);
            preparedStatement.setString(1, studentid);
            preparedStatement.execute();
            preparedStatement.close();
            connection.close();
            return "1";
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        } catch (IllegalAccessException e) {
            e.printStackTrace();
        } catch (InstantiationException e) {
            e.printStackTrace();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return "清除微信记录失败";
    }

    /**
     * 检测是否为登录状态
     *
     * @param session
     * @return
     */
    @RequestMapping("/CheckLogin")
    @ResponseBody
    public String checkLogin(HttpSession session) {
        String studentid = (String) session.getAttribute("studentid");
        return (String) session.getAttribute("loginName") + "|" + studentid;
    }

    /**
     * 找回密码
     *
     * @param session
     * @param studentid
     * @param usercheckcode
     * @return
     */
    @RequestMapping("/findPwd")
    @ResponseBody
    public String findPwd(HttpSession session, String studentid, String usercheckcode) {
        if (studentid == null || studentid.equals("")) {
            return "不正确的学号";
        }
        String code = (String) session.getAttribute("rand");
        if (code == null || !code.equals(usercheckcode)) return "验证码错误！";
        Student student = studentService.getStudentById(studentid);
        if (student == null) return "未找到学生信息";
        String email = student.getStudentEmail();
        if (email == null || email.equals("")) return "该学生未填写email信息，不能找回密码，请与辅导员联系";
        //去掉标注线
        System.out.println();
        String acc = emailConfig.getProperty("acc");
        String pwd = emailConfig.getProperty("pwd");
        String smtp = emailConfig.getProperty("smtp");
        String url = emailConfig.getProperty("url");
        String id = UUID.randomUUID().toString();
        int i = studentService.saveFindPwdCode(studentid, id);
        if (i <= 0) return "保存数据失败，找回密码操作终止，请稍后再试";
        String content = null;
        content = "请点击如下链接找回密码 \n" + url + "/views/font/login.form?findPwd=true&id=" + id;
        boolean b = EmailUtils.SendTextEmail(acc, pwd, acc, email, smtp, content, "找回密码");
        return b ? email : "0";
    }

    /**
     * 当密码错误的时候的动作。记录错误
     *
     * @param account
     * @return
     */
    private String wrongAccountAction(String account) {
        int times = wrongAccountService.loadWrongTimes(account);
        if (times < WRONGTIMES - 1) {
            wrongAccountService.addWrongAccount(account, "0");
            return "密码错误！，若1小时内错误次数达到" + WRONGTIMES + "次，账号将被锁定30分钟，您还有" + (WRONGTIMES - 1 - times) + "次机会";
        } else if (times == WRONGTIMES - 1) {
            System.out.println();
            wrongAccountService.addWrongAccount(account, "1");
            return "密码连续错误" + (times + 1) + "次，账号将被锁定30分钟";
        } else {
            wrongAccountService.addWrongAccount(account, "1");
        }
        return "您的账号因密码错误次数过多已被锁定，请30分钟后再登陆";
    }

    /**
     * 检查用户账号是否被锁定
     *
     * @param account
     * @return
     */
    private boolean isLocked(String account) {
        String status = wrongAccountService.loadAccountLocked(account);
        if (status != null && status.equals("1"))
            return true;
        else
            return false;
    }
}
