package com.controllers;

import com.Services.interfaces.MemberService;
import com.Services.interfaces.StudentService;
import com.model.*;
import com.utils.Utils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.*;


/**
 * Created by admin on 2016/7/18.
 */
@Controller
@RequestMapping("/jsons")
public class StudentModifyController {
    @Autowired
    private StudentService studentService;
    private Member_Encoding member_encoding;

    //加载要修改的学生的信息
    @RequestMapping("/modifyStudent")
    @ResponseBody
    public Student_Decoding loadStudents(HttpSession session, Student_Decoding student) {
        String studentId = (String) session.getAttribute("studentid");
        Student_Decoding students = studentService.loadStudentInfo(studentId);
        return students;
    }

    @Autowired
    private MemberService memberService;

    @RequestMapping("/modifyStudentMember")
    @ResponseBody
    //加载要修改的学生的家庭成员的信息(同学学生的id) ---完全可以复用原来的啊
    public DataForDatagrid loadMemberShip(String studentid, HttpSession session) {

        DataForDatagrid data = new DataForDatagrid();
        if (studentid == null || studentid.equals("")) {
            studentid = (String) session.getAttribute("studentid");
        }
        List<Member_Decoding> s = memberService.loadMemberShip(studentid);
        data.setDatas(s);
        return data;
    }

    //按成员的id修改
    @RequestMapping("/editStudentMember")
    @ResponseBody
    //添加事务的一致性
    @Transactional
    //需要不参数都放到map里  参照修改学生的信息
    public ResultData execute(HttpSession session,HttpServletRequest request,String str) {
        String studentId = (String) session.getAttribute("studentid");
        ResultData re = new ResultData();
        Map<String, String[]> map = request.getParameterMap();
        List<Member> list=new ArrayList<>();
        String[] members=str.split("/");
        for(String s:members){
            String[] obj=s.split("[|]");
            Member_Encoding m=new Member_Encoding();
            m.setMemberStudentId(studentId);
            m.setMemberType(obj[0]);
            m.setMemberRelation(obj[1]);
            m.setMemberName(obj[2]);
            if(obj[3]!=null && !obj[3].equals("")){
                try {
                    m.setMemberBirthday(new java.sql.Date(new SimpleDateFormat("yyyy-MM-dd").parse(obj[3]).getTime()));
                } catch (ParseException e) {
                    e.printStackTrace();
                }
            }
            m.setMemberWork(obj[4]);
            m.setMemberPhone(obj[5]);
            list.add(m);
        }
        //删除之前的家庭成员的信息
        int j = memberService.deleteMemberByStudentId(studentId);
        //添加修改后的信息
        int i =memberService.saveMembers(list) ;
        re.setStatusByDBResult(i);
        return re;
    }
    //学生表格修改后的保存
    @RequestMapping("/editModifyStudent")
    @ResponseBody
    //添加事务的一致性
    @Transactional
    //需要不参数都放到map里  参照修改学生的信息
    public ResultData execute1(HttpSession session,HttpServletRequest request) {
        String[] str = new String[5];
        int studentRe=0;
        //学生的
        ResultData re=new ResultData();
        Map<String ,String[]> map= request.getParameterMap();//取出请求中所有传递过来的参数
        Map<String ,String > newmap=new HashMap<>(36);
        Set<String > keys=map.keySet();
        for(String s:keys){     //取中map中每个元素（数组）的第一个，并放到新的map中
            //需要去除member的key
            if("member".equals(s)){
                str = map.get(s);
                //暂时删除怕影响之后学生的操作
//                map.remove(s);
            }
            String[] value=map.get(s);
            if(value.length==0)continue;
            newmap.put(s,value[0]);
        }
        try {
            //map转对象
            Student_Encoding student= (Student_Encoding) Utils.mapToObj(newmap,Student_Encoding.class);
            //保存学生的信息
            studentRe=studentService.editStudent(student);
            //最后一起处理返回结果
        } catch (Exception e) {
            e.printStackTrace();
            re.sets(1,e.getMessage().substring(0,2000));
        }



        //学生的家庭成员的
        String studentId = (String) session.getAttribute("studentid");
//        System.out.println("-----------------------------");
//        System.out.println(str+"--------------"+str[0]);
        List<Member> list=new ArrayList<>();
        String[] members=str[0].split("/");
        for(String s:members){
            String[] obj=s.split("[|]");
//            System.out.println("这是---"+obj[0]+"----"+obj[1]+"----"+obj[2]+"----"+obj[3]+"----"
//                    +obj[4]+"----"+obj[5] );
            Member_Encoding m=new Member_Encoding();
            m.setMemberStudentId(studentId);
            m.setMemberType(obj[0]);
            m.setMemberRelation(obj[1]);
            m.setMemberName(obj[2]);
            if(obj[3]!=null && !obj[3].equals("")){
//                try {
//                    m.setMemberBirthday(new java.sql.Date(new SimpleDateFormat("yyyy-MM-dd").parse(obj[3]).getTime()));
                    m.setMemberBirthday(java.sql.Date.valueOf(obj[3]));
//                } catch (ParseException e) {
//                    e.printStackTrace();
//                }
            }
            m.setMemberWork(obj[4]);
            m.setMemberPhone(obj[5]);

            list.add(m);

        }
        for(int i=0;i<list.size();i++){
//            System.out.println("这是list"+ list.get(i));
        }

        int memberRe1 = memberService.deleteMemberByStudentId(studentId);
        int memberRe2 =memberService.saveMembers(list) ;

        //处理结果
        if (studentRe>0 && memberRe1 > 0 && memberRe2> 0){
            //操作成功
            re.setStatusByDBResult(1);
        }else{
            //操作失败
            re.setStatusByDBResult(0);
        }
        return re;
    }
}