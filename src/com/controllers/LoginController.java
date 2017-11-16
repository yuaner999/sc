/*
*Created by liulei on 2016/4/22.
*/
package com.controllers;

import com.Services.interfaces.StatisticsTiemsService;
import com.Services.interfaces.StudentService;
import com.Services.interfaces.WrongAccountService;
import com.common.utils.SpringUtils;
import com.model.Student;
import com.supermapping.jdbcfactories.JdbcFactory;
import com.utils.EmailUtils;
import com.utils.PwdUtil;
import net.sf.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import javax.sql.DataSource;
import java.io.UnsupportedEncodingException;
import java.security.NoSuchAlgorithmException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.Properties;
import java.util.UUID;

/**
 * Created by liulei on 2016/4/22.
 */
@Controller
@RequestMapping(value = "/Login")
public class LoginController {
    /**
     * 可以错误的次数
     */
    private static final int WRONGTIMES=3;
    /**
     * 记录登陆错误的次数，当登陆次数达到三次后账号被锁定30分钟
     * update by hong
     */
    @Autowired
    private WrongAccountService wrongAccountService;


    /**
     * 系统用户登录
     * 登陆的说明：根据type判断是哪种用户登陆  1 系统用户  2校团委  3学院团委  4 职能部门  5年级团总支  6班级团支部  7 学生（前端页面）
     * 系统、学生处账号登陆是查找sysuser
     * 班级团支部账号登陆查询sysuser 以及和班级团支部关联的表，并额外把班级团支部的id添加到session中
     * 学院团委账号登陆查询sysuser 以及和学院团委关联的表，并额外把学院团委的id添加到session中
     * 职能部门账号登陆查询sysuser 以及和职能部门关联的表，并额外把职能部门的id添加到session中
     * 年级团总支账号登陆查询sysuser 以及和年级团总支关联的表，并额外把年级团总支的id添加到session中
     * 学生登陆 查询sysuser表，以及和学生信息关联的表，其中角色为空的即是。
     * @param request
     * @param session
     * @param type
     * @return
     */
    @RequestMapping(value = "/SystemLogin")
    @ResponseBody
    public String SystemLogin(HttpServletRequest request, HttpSession session,String type){
        //返回结果
        String result = "登录失败，请联系服务人员";
        String username = request.getParameter("username");
        String password = request.getParameter("password");

        if(username.equals("")){
            return "用户名错误";//用户名错误
        }
        if(password.equals("")){
            return "密码错误";//密码错误
        }
//        if(type==null || type.equals("")){
//            return "请选择登陆角色";
//        }
        if(isLocked(username)){
            return "您的账号因密码错误次数过多已被锁定，请30分钟后再登录";
        }
        //查询用户限
        type=getRole(username,password,type);

        JdbcFactory factory = SpringUtils.getBean(JdbcFactory.class);
        //学生登录
        if("7".equals(type)){
            result=studentLogin(username,password, factory,session);
            return result;
        }
        //如果是导员登陆
        if("8".equals(type)){
            result=instructorLogin(username,password, factory,session);
            return result;
        }
        //如果不是导员登陆
        Connection connection=null;
        PreparedStatement preparedStatement=null;
        ResultSet resultSet=null;
        try {
            connection = factory.createConnection();
            String sql = "SELECT * FROM sysuser where username=?";
            preparedStatement = connection.prepareStatement(sql);
            preparedStatement.setString(1, username);
            resultSet = preparedStatement.executeQuery();
            if(resultSet.next()){
                String databasePassword = resultSet.getString("password");
                String roleId= resultSet.getString("sysrole_id");
                //验证登陆类型（角色）与用户是否一致 __通过该用户所关联的角色来验证
                if(!(("1".equals(type) && "fe785f38-0baf-11e6-883e-0025b6dd0800".equals(roleId)) ||                  //隐藏的管理员
                        ("1".equals(type) && "1e225d95-126c-11e6-989d-0025b6dd0800".equals(roleId)) ||              //系统管理员
                        ("1".equals(type) && "2630662c-fe50-11e6-a999-00ac2794c53f".equals(roleId)) ||              //学校超级管理员
                        ("2".equals(type) && "df8e77d3-0d26-11e6-b867-0025b6dd0800".equals(roleId)) ||             //校团委
                        ("3".equals(type) && "collegemanager".equals(roleId)) ||                                    //学院团委
                        ("4".equals(type) && "dept".equals(roleId)) ||                                             //职能部门
                        ("5".equals(type) && "grade".equals(roleId)) ||                                            //年级团总支
                        ("6".equals(type) && "class".equals(roleId)))                                              //班级团支部
                        ){
                    return "该用户与所选的登陆角色不符,请选择正确的角色";
                }
                password = PwdUtil.getPassMD5(password);
                if(password.equals(databasePassword)){
                    //登录成功，清除角色登录失败记录
                    wrongAccountService.delWrongLogs(username);
                    String userId = resultSet.getString("sysuser_id");
                    session.setAttribute("loginId",userId);
                    session.setAttribute("loginName",username);//将用户名写入Session
                    session.setAttribute("loginuserpassword",databasePassword);//将用户密码写入Session
                    session.setAttribute("logintype",type);                 //将登陆的角色id保存到session
                    String sysrole ;
                    switch (roleId){

                        case  "1e225d95-126c-11e6-989d-0025b6dd0800":
                            sysrole = "系统管理员";
                            break;
                        case  "df8e77d3-0d26-11e6-b867-0025b6dd0800":
                            sysrole = "校团委";
                            break;
                        case  "collegemanager":
                            sysrole = "学院团委";
                            break;
                        case  "dept":
                            sysrole = "职能部门";
                            break;
                        case  "grade":
                            sysrole = "年级团总支";
                            break;
                        case  "class":
                            sysrole = "班级团支部";
                            break;
                        default:
                            sysrole = null;
                            break;
                    }
                    session.setAttribute("sysrole",sysrole);                 //将登陆的角色类型保存到session.
                    String creatorName ;                                      //实际为登录者具体部门名称，为新闻和活动设定创建者保存到session，下面用"creatorName"
                    if("1".equals(type) || "2".equals(type) || "3".equals(type) || "4".equals(type) || "5".equals(type) || "6".equals(type)){              //如果是系统管理员、学生处、学院管理员，查找菜单权限
                        //设置角色权限菜单
                        sql = "SELECT * FROM sys_sysuser_sysrolemenu_view where username=?";
                        preparedStatement = connection.prepareStatement(sql);
                        preparedStatement.setString(1, username);
                        resultSet = preparedStatement.executeQuery();
                        List<String> rolemenuIdList = new ArrayList<String>();
                        while (resultSet.next()){
                            rolemenuIdList.add(resultSet.getString("sysmenu_id"));
                        }
                        session.setAttribute("rolemenuId",rolemenuIdList);
                        if("1".equals(type)){                   //如果登陆的角色是系统管理员，设置创建者ID未sysadmin并放到session里
                            creatorName = "系统管理员";
                            session.setAttribute("creatorName",creatorName);
                        }
                        if("2".equals(type)){                   //如果登陆的角色是校团委管理员，设置创建者ID未sysadmin并放到session里
                            creatorName = "校团委";
                            session.setAttribute("creatorName",creatorName);
                        }
                        if("3".equals(type)){                   //如果登陆的角色是学院管理员，还要再查找学院ID并放到session里
                            sql="SELECT * from r_sysuer_college where userid=?";
                            preparedStatement = connection.prepareStatement(sql);
                            preparedStatement.setString(1, userId);
                            resultSet = preparedStatement.executeQuery();
                            if(resultSet.next()){
                                String collegeId=resultSet.getString("collegeName");
                                if(collegeId!=null && !"".equals(collegeId)){
                                    session.setAttribute("collegeId",collegeId);
                                    session.setAttribute("creatorName",collegeId);
                                }else {
                                    return "未找到用户相关联的学院信息，请查证后再试或者联系系统管理员";
                                }
                            }else {
                                return "未找到用户相关联的学院信息，请查证后再试或者联系系统管理员";
                            }
                        }
                        if("4".equals(type)){                    //如果登陆的角色是部门管理员，还要再查找部门ID并放到session里
                            sql="SELECT r_sysuser_dept.`id`,r_sysuser_dept.`sysuserId`,department.* FROM r_sysuser_dept LEFT JOIN department ON(r_sysuser_dept.deptId=department.deptId) where sysuserId=?";
                            preparedStatement = connection.prepareStatement(sql);
                            preparedStatement.setString(1, userId);
                            resultSet = preparedStatement.executeQuery();
                            if(resultSet.next()){
                                String deptId=resultSet.getString("deptId");
                                String deptName=resultSet.getString("deptName");
                                if(deptId!=null && !"".equals(deptId)){
                                    session.setAttribute("deptId",deptId);
                                    session.setAttribute("creatorName",deptName);
                                }else {
                                    return "未找到用户相关联的部门信息，请查证后再试或者联系系统管理员";
                                }
                            }else {
                                return "未找到用户相关联的部门信息，请查证后再试或者联系系统管理员";
                            }
                        }
                        if("5".equals(type)){                   //如果登陆的角色是年级管理员，还要再查找年级ID并放到session里
                            sql="SELECT * from r_sysuser_grade where sysuserId=?";
                            preparedStatement = connection.prepareStatement(sql);
                            preparedStatement.setString(1, userId);
                            resultSet = preparedStatement.executeQuery();
                            if(resultSet.next()){
                                String gradeId=resultSet.getString("gradeName");
                                if(gradeId!=null && !"".equals(gradeId)){
                                    session.setAttribute("gradeId",gradeId);
                                    session.setAttribute("creatorName",gradeId);
                                }else {
                                    return "未找到用户相关联的年级信息，请查证后再试或者联系系统管理员";
                                }
                            }else {
                                return "未找到用户相关联的年级信息，请查证后再试或者联系系统管理员";
                            }
                        }
                        if("6".equals(type)){                   //如果登陆的角色是班级管理员，还要再查找班级ID并放到session里
                            sql="SELECT * from r_sysuser_class where sysuserId=?";
                            preparedStatement = connection.prepareStatement(sql);
                            preparedStatement.setString(1, userId);
                            resultSet = preparedStatement.executeQuery();
                            if(resultSet.next()){
                                String classId=resultSet.getString("className");
                                if(classId!=null && !"".equals(classId)){
                                    session.setAttribute("classId",classId);
                                    session.setAttribute("creatorName",classId);
                                }else {
                                    return "未找到用户相关联的班级信息，请查证后再试或者联系系统管理员";
                                }
                            }else {
                                return "未找到用户相关联的班级信息，请查证后再试或者联系系统管理员";
                            }
                        }
//                        String aa = (String) session.getAttribute("creatorName");
//                        System.out.println(aa+"=============================================");
                    }
                    result = "1";//用户名密码正确，登录成功
                }else {
//                    result = "密码错误";//密码错误
                    result=wrongAccountAction(username);
                }
            }else{
                result = "用户名错误";//用户名错误
            }

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
        return result;
    }

    /**
     * 为了满足要求  view/font/login.form 是所有用户登录的登录页
     * 这里需要优化 不在需要type 暂未做
     * @param username
     * @param password
     * @param type
     * @return
     */
    public  String getRole(String username,String password,String type){
        JdbcFactory factory = SpringUtils.getBean(JdbcFactory.class);
        Connection connection=null;
        PreparedStatement preparedStatement=null;
        ResultSet resultSet=null;
        try {
            String sql="SELECT sysrole_id from sysuser where username=?";
            connection = factory.createConnection();
            preparedStatement = connection.prepareStatement(sql);
            preparedStatement.setString(1, username);
            resultSet = preparedStatement.executeQuery();
            if (resultSet.next()){
                switch (resultSet.getString(1)){
                    case ("fe785f38-0baf-11e6-883e-0025b6dd0800"):type="";break;//隐藏的系管理员
                    case ("1e225d95-126c-11e6-989d-0025b6dd0800"):type="1";break;//系统管理员
                    case ("2630662c-fe50-11e6-a999-00ac2794c53f"):type="1";break;//学校超级管理员
                    case ("df8e77d3-0d26-11e6-b867-0025b6dd0800"):type="2";break;//校团委
                    case ("collegemanager"):type="3";break;//学院团委
                    case ("dept"):type="4";break;//职能部门
                    case ("grade"):type="5";break;//年级团总支
                    case ("class"):type="6";break; //班级团支部
                    default:type="-1";break;
                }
            }else {
                sql="SELECT instructorPwd from instructor where instructorLogin=?";
                preparedStatement = connection.prepareStatement(sql);
                preparedStatement.setString(1, username);
                resultSet = preparedStatement.executeQuery();
                if (resultSet.next()){
                    if(resultSet.getString(1)!=null&&!"null".equals(resultSet.getString(1))&&!"".equals(resultSet.getString(1))){
                        type="8";
                    }
                }else {
                    type="7";
                }
            }
//            System.out.println(type+"111111111111111111111");
        } catch (SQLException e) {
            e.printStackTrace();
        } catch (IllegalAccessException e) {
            e.printStackTrace();
        } catch (InstantiationException e) {
            e.printStackTrace();
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        } finally {
            if (preparedStatement!=null){
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
            if (connection!=null){
                try {
                    connection.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
        }
        return  type;
    }


    /**
     * 学生登录处理逻辑
     * @param user
     * @param pwd
     * @param factory
     * @param session
     * @return
     */
    @Autowired
    private StatisticsTiemsService statisticsTiemsService;
    @Autowired
    private PrintTranscriptController printTranscriptController;

    public String studentLogin(String user,String pwd,JdbcFactory factory ,HttpSession session){

        Connection connection=null;
        PreparedStatement preparedStatement=null;
        ResultSet resultSet=null;
        try {
            connection = factory.createConnection();
            String sql = "SELECT * FROM student where studentID=?";
            preparedStatement = connection.prepareStatement(sql);
            preparedStatement.setString(1, user);
            resultSet = preparedStatement.executeQuery();
            String userName="";
            if(resultSet.next()){
                String userId = resultSet.getString("studentID");
                String databasePassword = resultSet.getString("studentPwd");
                userName= resultSet.getString("studentName");
                pwd=PwdUtil.getPassMD5(pwd);
                if(databasePassword.equals(pwd)){
                    //统计学生的登录次数
                    statisticsTiemsService.StaticsTimes(user);
                    //登录成功，清除角色登录失败记录
                    wrongAccountService.delWrongLogs(userName);
//                    System.out.println(databasePassword);
//                    System.out.println(pwd);
                    session.setAttribute("loginId",userId);
                    session.setAttribute("studentid",userId);
                    session.setAttribute("loginName",userName);//将用户名写入Session
                    session.setAttribute("loginuserpassword",databasePassword);//将用户密码写入Session
                    session.setAttribute("logintype","7");                 //将登陆的角色类型保存到session(导员)
                    printTranscriptController.getPoint(session,""); //调用生成六项能力得分的方法，刷新得分
                }else{
//                    return "密码错误";
                    return wrongAccountAction(user);
                }
            }else{
                return "帐号或密码错误";
            }
            return "1|"+userName;
        } catch (Exception e) {
            e.printStackTrace();
        }finally {
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
     * 登陆类型是导员的时候的处理逻辑
     * @param user
     * @param pwd
     * @param factory
     * @param session
     * @return
     */
    private String instructorLogin(String user,String pwd,JdbcFactory factory ,HttpSession session){
        Connection connection=null;
        PreparedStatement preparedStatement=null;
        ResultSet resultSet=null;
        try {
            connection = factory.createConnection();
            String sql = "SELECT * FROM instructor where instructorLogin=?";
            preparedStatement = connection.prepareStatement(sql);
            preparedStatement.setString(1, user);
            resultSet = preparedStatement.executeQuery();
            if(resultSet.next()){
                String userId = resultSet.getString("instructorId");
                String databasePassword = resultSet.getString("instructorPwd");
                String collegeid=resultSet.getString("instructorCollegeName");
                pwd=PwdUtil.getPassMD5(pwd);
                if(databasePassword.equals(pwd)){
                    //登录成功，清除角色登录失败记录
                    wrongAccountService.delWrongLogs(user);
                    session.setAttribute("loginId",userId);
                    session.setAttribute("instructorid",userId);
                    session.setAttribute("loginName",user);//将用户名写入Session
                    session.setAttribute("loginuserpassword",databasePassword);//将用户密码写入Session
                    session.setAttribute("logintype","4");                 //将登陆的角色类型保存到session(导员)
                    session.setAttribute("collegeid",collegeid);                 //将登陆的角色类型保存到session(导员)
                    //设置角色权限菜单
                    sql = "SELECT * FROM sysrolemenu where sysrole_id='instructor'";
                    preparedStatement = connection.prepareStatement(sql);
                    resultSet = preparedStatement.executeQuery();
                    List<String> rolemenuIdList = new ArrayList<String>();
                    while (resultSet.next()){
                        rolemenuIdList.add(resultSet.getString("sysmenu_id"));
                    }
                    session.setAttribute("rolemenuId",rolemenuIdList);
                }else{
//                    return "密码错误";
                    return wrongAccountAction(user);
                }
            }else{
                return "用户名错误";
            }
            return "1";
        } catch (Exception e) {
            e.printStackTrace();
        }finally {
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
     * 添加系统用户
     * @param request
     * @param session
     * @return
     * @throws UnsupportedEncodingException
     * @throws NoSuchAlgorithmException
     */
    @RequestMapping(value = "/AddSysUser")
    @ResponseBody
    public JSONObject AddSysUser(HttpServletRequest request, HttpSession session) throws UnsupportedEncodingException, NoSuchAlgorithmException {
        String result = "{'result':false}";

        String userName = request.getParameter("username")==null?"":request.getParameter("username").toString();
        String loginName = session.getAttribute("loginName")==null?"":session.getAttribute("loginName").toString();
        String remark = request.getParameter("remark")==null?"":request.getParameter("remark").toString();
        String password = PwdUtil.getPassMD5(PwdUtil.getPassMD5("123456").toLowerCase());
        String sysroleid = request.getParameter("sysroleid")==null?"":request.getParameter("sysroleid").toString();

        if(userName.equals("")||loginName.equals("")||sysroleid.equals("")){
            result = "{'result':false}";
            JSONObject json = JSONObject.fromObject(result);
            return json;
        }

        JdbcFactory factory = SpringUtils.getBean(JdbcFactory.class);

        try {
            Connection connection = factory.createConnection();
            String sql = "insert into sysuser(sysuser_id,username,password,sysrole_id,is_sysadmin,create_date,create_man,remark) values(UUID(),?,?,?,'否',now(),?,?)";
            PreparedStatement preparedStatement = connection.prepareStatement(sql);
            preparedStatement.setString(1, userName);
            preparedStatement.setString(2, password);
            preparedStatement.setString(3, sysroleid);
            preparedStatement.setString(4, loginName);
            preparedStatement.setString(5, remark);
            preparedStatement.execute();
            result = "{'result':true}";
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
        JSONObject json = JSONObject.fromObject(result);
        return json;
    }

    /**
     * 退出登录
     * @param session
     */
    @RequestMapping(value = "/ExitLogin")
    @ResponseBody
    public String  ExitLogin(HttpSession session){
        String type= (String) session.getAttribute("logintype");
        session.removeAttribute("loginId");
        session.removeAttribute("loginName");
        session.removeAttribute("rolemenuId");
        session.removeAttribute("logintype");
        session.removeAttribute("collegeId");
        session.removeAttribute("instructorid");
        session.removeAttribute("logintype");
        session.removeAttribute("studentid");
        session.removeAttribute("classId");
        session.removeAttribute("deptId");
        return type;
    }

    /**
     * 修改密码
     * @param request
     * @param session
     * @return
     * @throws UnsupportedEncodingException
     * @throws NoSuchAlgorithmException
     */
    @RequestMapping(value = "/EditPassword",method = RequestMethod.POST)
    @ResponseBody
    public String EditPassword(HttpServletRequest request, HttpSession session) throws UnsupportedEncodingException, NoSuchAlgorithmException {
        String sysuserId = (String) session.getAttribute("loginId");
        if(session.getAttribute("loginuserpassword")==null || sysuserId==null){
            return "登录超时，请重新登录";
        }
        if(sysuserId.equals("1f97b97e-a665-4d46-9ea6-59b1cbfa3873")){
            return "当前帐号密码不可修改";
        }
        String nowPassword = (String) session.getAttribute("loginuserpassword");
        String oldPassword = request.getParameter("oldpassword")==null?"": request.getParameter("oldpassword");
        String newPassword = request.getParameter("newpassword")==null?"": request.getParameter("newpassword");
//        System.out.println("now:"+nowPassword+"|old:"+oldPassword+"|new:"+newPassword);
        oldPassword = PwdUtil.getPassMD5(oldPassword);
        newPassword = PwdUtil.getPassMD5(newPassword);
        String result = "-1";
        if(oldPassword.equals("")||newPassword.equals("")){
            return "-1";
        }
//        System.out.println("now"+nowPassword);
//        System.out.println("old"+oldPassword);
        if(nowPassword.equals(oldPassword)){

            JdbcFactory factory = SpringUtils.getBean(JdbcFactory.class);

            try {
                Connection connection = factory.createConnection();
                String sql;
                //判断是否是导员要更改密码
                String type= (String) session.getAttribute("logintype");
                if(type!=null && type.equals("4")){
                    sql = "UPDATE instructor SET instructorPwd=? WHERE instructorId=?";
                }else if(type!=null && type.equals("5")){
                    sql="UPDATE student SET studentPwd=? WHERE studentID=?";
                }else if(type!=null && type.equals("7")){
                    sql="UPDATE student SET studentPwd=? WHERE studentID=?";
                }else{
                    sql = "UPDATE sysuser SET password=? WHERE sysuser_id=?";
                }
                PreparedStatement preparedStatement = connection.prepareStatement(sql);
                preparedStatement.setString(1, newPassword);
                preparedStatement.setString(2, sysuserId);
                preparedStatement.execute();
                //返回登陆类型
                result = type;
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
        }else {
            return "当前密码错误";
        }
        return result;
    }

    /**
     * 检测是否为登录状态
     * @param session
     * @return
     */
    @RequestMapping("/CheckLogin")
    @ResponseBody
    public String checkLogin(HttpSession session){
        String studentid=(String )session.getAttribute("studentid");
        return (String) session.getAttribute("loginName")+"|"+studentid;
    }

    @Autowired
    private StudentService studentService;
    @Autowired
    @Qualifier("email_config")
    private Properties emailConfig;

    /**
     * 找回密码
     * @param session
     * @param studentid
     * @param usercheckcode
     * @return
     */
    @RequestMapping("/findPwd")
    @ResponseBody
    public String findPwd(HttpSession session,String studentid,String usercheckcode){
//        System.out.println("这是服务器传过来的"+studentid+"验证码"+usercheckcode);
        if(studentid==null || studentid.equals("")){
            return "不正确的学号";
        }
        String code= (String) session.getAttribute("rand");
        if(code==null || !code.equals(usercheckcode))  return "验证码错误！";
        Student student=studentService.getStudentById(studentid);
        if(student==null) return "未找到学生信息";
        String email=student.getStudentEmail();
        if(email==null || email.equals("")) return "该学生未填写email信息，不能找回密码，请与辅导员联系";
        String acc=emailConfig.getProperty("acc");
        String pwd=emailConfig.getProperty("pwd");
        String smtp=emailConfig.getProperty("smtp");
        String url=emailConfig.getProperty("url");
        String id= UUID.randomUUID().toString();
        int i=studentService.saveFindPwdCode(studentid,id);
        if(i<=0) return "保存数据失败，找回密码操作终止，请稍后再试";
        String content= null;
//        try {
            content = "请点击如下链接找回密码 \n"+url+"/views/font/login.form?findPwd=true&id="+ id;
//        } catch (NoSuchAlgorithmException e) {
//            e.printStackTrace();
//        } catch (UnsupportedEncodingException e) {
//            e.printStackTrace();
//        }
        boolean b=EmailUtils.SendTextEmail(acc,pwd,acc,email,smtp,content,"找回密码");
        return b? email:"0";
    }

    /**
     * 当密码错误的时候的动作。记录错误
     * @param account
     * @return
     */
    private String wrongAccountAction(String account){
        int times=wrongAccountService.loadWrongTimes(account);
        if(times<WRONGTIMES-1){
            wrongAccountService.addWrongAccount(account,"0");
            return "密码错误！，若1小时内错误次数达到"+WRONGTIMES+"次，账号将被锁定30分钟，您还有"+(WRONGTIMES-1-times)+"次机会";
        }else if(times==WRONGTIMES-1){
            wrongAccountService.addWrongAccount(account,"1");
            return "密码连续错误"+(times+1)+"次，账号将被锁定30分钟";
        }else{
            wrongAccountService.addWrongAccount(account,"1");
        }
        return "您的账号因密码错误次数过多已被锁定，请30分钟后再登陆";
    }

    /**
     * 检查用户账号是否被锁定
     * @param account
     * @return
     */
    private boolean isLocked(String account){
        String status=wrongAccountService.loadAccountLocked(account);
        if(status!=null && status.equals("1"))
            return true;
        else
            return false;
    }
}
