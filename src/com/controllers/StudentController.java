package com.controllers;

import com.Services.interfaces.StudentService;
import com.github.pagehelper.Page;
import com.model.*;
import com.utils.PwdUtil;
import com.utils.Utils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.lang.reflect.Field;
import java.util.*;

/**
 * 学生信息管理 部分controller
 * Created by    admin on 2016/7/18.
 */
@Controller
@RequestMapping("/jsons")
public class StudentController {
    @Autowired
    private StudentService studentService;

    /**
     * 批量删除
     * @param ids 多个学生ID的拼接
     * @return
     */
    @RequestMapping("/deleteMoreInfor")
    @ResponseBody
    public ResultData deleteMore(String ids){
        ResultData re=new ResultData();
        List<String> list=new ArrayList<>();
        if(ids!=null && ids.contains("|")){
            String[] id=ids.split("[|]");
            for(String s:id){
                list.add(s);
            }
        }
        int result=studentService.deleteMore(list);
        re.setStatusByDBResult(result);
        re.setData(result);
        return re;
    }

    /**
     * 查询和搜索学生信息
     * @param session
     * @param student     搜索条件封装成的对象，目的是为了在封装的时候对条件进行加密，然后与数据库中的数据比对
     * @param rows      分页查询的参数   表示每页的行数
     * @param page      分页查询的参数   表示第几页
     * @return
     */
    @RequestMapping("/loadStudents")
    @ResponseBody
    public DataForDatagrid loadStudents(HttpSession session,Student_Encoding student, String rows, String page, HttpServletRequest request) {
        DataForDatagrid data=new DataForDatagrid();
//        Map<String ,String > map=ObjToStringMap(student);
        //从请求中获得所有的参数
        Map<String ,String[]> parameterMap= request.getParameterMap();
        //为了能然map 修改  通过 request.getParameterMap(); 获得的map不可以修改
        Map<String ,Object> newmap=new HashMap<>(36);
        Set<String> keys=  parameterMap.keySet();
        for(String s:keys){
            //取中map中每个元素（数组）的第一个，并放到新的map中  处理下才有值  负责全是地址
            // 用newmap处理  通过key获得value
            String[] value=parameterMap.get(s);
            if(value.length==0)continue;
            newmap.put(s,value[0]);
        }
//        System.out.println(newmap.toString());
        String collegeid= (String) session.getAttribute("collegeid");
        String instructorid= (String) session.getAttribute("instructorid");
        if(collegeid!=null && !collegeid.equals("")) newmap.put("collegeid",collegeid);
        if(instructorid!=null && !instructorid.equals("")) newmap.put("instructorid",instructorid);
        int pagenum=1,pagesize=30;
        if(rows!=null && !rows.equals("")) {
            try{
                pagesize=Integer.parseInt(rows);
            }catch (Exception e){
                e.printStackTrace();
            }
        }
        if(page!=null && !page.equals("")) {
            try{
                pagenum=Integer.parseInt(page);
            }catch (Exception e){
                e.printStackTrace();
            }
        }
        List<Student_Decoding> students=studentService.loadStudents(newmap,pagenum,pagesize);
        data.setDatas(students);
        data.setTotal((int)((Page)students).getTotal());
        return data;
    }
    @RequestMapping("/loadStudentsByClass")
    @ResponseBody
    public DataForDatagrid loadStudentsByClass(HttpSession session,Student_Encoding student, String rows, String page, HttpServletRequest request) {
        DataForDatagrid data=new DataForDatagrid();
        Map<String ,String > map=ObjToStringMap(student);
        //从请求中获得所有的参数
        Map<String ,String[]> parameterMap= request.getParameterMap();
        //为了能然map 修改  通过 request.getParameterMap(); 获得的map不可以修改
        Map<String ,Object> newmap=new HashMap<>(36);
        Set<String> keys=  parameterMap.keySet();
        for(String s:keys){
            //取中map中每个元素（数组）的第一个，并放到新的map中  处理下才有值  负责全是地址
            // 用newmap处理  通过key获得value
            String[] value=parameterMap.get(s);
            if(value.length==0)continue;
            newmap.put(s,value[0]);
        }
//        System.out.println(newmap.toString());
        String collegeid= (String) session.getAttribute("collegeid");
        String instructorid= (String) session.getAttribute("instructorid");
        if(collegeid!=null && !collegeid.equals("")) map.put("collegeid",collegeid);
        if(instructorid!=null && !instructorid.equals("")) map.put("instructorid",instructorid);
        int pagenum=1,pagesize=30;
        if(rows!=null && !rows.equals("")) {
            try{
                pagesize=Integer.parseInt(rows);
            }catch (Exception e){
                e.printStackTrace();
            }
        }
        if(page!=null && !page.equals("")) {
            try{
                pagenum=Integer.parseInt(page);
            }catch (Exception e){
                e.printStackTrace();
            }
        }
        List<Student_Decoding> students=studentService.loadStudentsByClass(newmap,pagenum,pagesize);
        data.setDatas(students);
        data.setTotal((int)((Page)students).getTotal());
        return data;
    }
    @RequestMapping("/loadStudentsNew")
    @ResponseBody
    public DataForDatagrid loadStudentsNew(HttpSession session, String rows, String page, HttpServletRequest request) {
        DataForDatagrid data=new DataForDatagrid();
        //从请求中获得所有的参数
        Map<String ,String[]> parameterMap= request.getParameterMap();
        //为了能然map 修改  通过 request.getParameterMap(); 获得的map不可以修改
        Map<String ,Object> newmap=new HashMap<>(36);
        Set<String> keys=  parameterMap.keySet();
        for(String s:keys){
            //取中map中每个元素（数组）的第一个，并放到新的map中  处理下才有值  负责全是地址
            // 用newmap处理  通过key获得value
            String[] value=parameterMap.get(s);
            if(value.length==0)continue;
            newmap.put(s,value[0]);
        }
//        System.out.println(newmap.toString());
        String collegeid= (String) session.getAttribute("collegeId");
        String instructorid= (String) session.getAttribute("instructorid");
        if(collegeid!=null && !collegeid.equals("")) newmap.put("collegeid",collegeid);
        if(instructorid!=null && !instructorid.equals("")) newmap.put("instructorid",instructorid);
        int pagenum=1,pagesize=30;
        if(rows!=null && !rows.equals("")) {
            try{
                pagesize=Integer.parseInt(rows);
            }catch (Exception e){
                e.printStackTrace();
            }
        }
        if(page!=null && !page.equals("")) {
            try{
                pagenum=Integer.parseInt(page);
            }catch (Exception e){
                e.printStackTrace();
            }
        }
        List<Student_Decoding> students=studentService.loadStudentsNew(newmap,pagenum,pagesize);
        data.setDatas(students);
        data.setTotal((int)((Page)students).getTotal());
        return data;
    }
    /**
     * 添加学生信息
     * @param
     * @return
     */
    @RequestMapping("/addStudent")
    @ResponseBody
    public ResultData addStudent(HttpServletRequest request) {
        Map<String ,String[]> map= request.getParameterMap();//取出请求中所有传递过来的参数
        Map<String ,String > newmap=new HashMap<>(36);
        Set<String > keys=map.keySet();
        for(String s:keys){     //取中map中每个元素（数组）的第一个，并放到新的map中
            String[] value=map.get(s);
            if(value.length==0)continue;
            newmap.put(s,value[0]);
        }
//        System.out.println(newmap.toString());
        ResultData re=new ResultData();
        try {
            //map转对象
            Student_Encoding student= (Student_Encoding) Utils.mapToObj(newmap,Student_Encoding.class);
            //设置密码为身份证号的后6位
            String idcard=student.getStudentIdCard();
            //解密
            idcard = PwdUtil.AESDecoding(idcard);
            idcard=idcard.substring(idcard.length()-6);
//            System.out.println("这是截取后的idcard-----"+idcard);
            //将密码设置为身为证后六位(两次加密)
            String pwd = PwdUtil.getPassMD5(PwdUtil.getPassMD5(idcard).toLowerCase());
            student.setStudentPwd(pwd);
//            System.out.println("这是新学生的密码:  "+student.getStudentPwd()+"--------"+"这是pwd:  "+pwd);
            int i=studentService.addStudent(student);
            re.setStatusByDBResult(i);
        } catch (Exception e) {
            e.printStackTrace();
            re.sets(1,e.getMessage().substring(0,2000));
        }
        return re;
    }

    /**
     * 修改学生信息
     * @param request
     * @return
     */
    @RequestMapping("/editStudent")
    @ResponseBody
    public ResultData editStudent(HttpServletRequest request) {
        ResultData re=new ResultData();
        Map<String ,String[]> map= request.getParameterMap();//取出请求中所有传递过来的参数
        Map<String ,String > newmap=new HashMap<>(36);
        Set<String > keys=map.keySet();
        for(String s:keys){     //取中map中每个元素（数组）的第一个，并放到新的map中
            String[] value=map.get(s);
            if(value.length==0)continue;
            newmap.put(s,value[0]);
        }
        try {
            //map转对象
            Student_Encoding student= (Student_Encoding) Utils.mapToObj(newmap,Student_Encoding.class);
            int i=studentService.editStudent(student);
            re.setStatusByDBResult(i);
        } catch (Exception e) {
            e.printStackTrace();
            re.sets(1,e.getMessage().substring(0,2000));
        }
        return re;
    }

    /**
     * 加载学制 需要对取出来的字符串解密
     * @return
     */
    @RequestMapping("/loadeducationLength")
    @ResponseBody
    public DataForDatagrid loadeducationLength() {
        DataForDatagrid data=new DataForDatagrid();
        List<String > list=studentService.loadeducationLength();
        List<Map<String ,String > > text= new ArrayList<>();
        for(String s:list){
            if(s==null || s.equals("")) continue;
            Map<String,String > map=new HashMap<>(1);
            map.put("educationLength",PwdUtil.AESDecoding(s));
            text.add(map);
        }
        data.setDatas(text);
        return data;
    }

    /**
     * 培养方式
     * @return
     */
    @RequestMapping("/loadtrainingMode")
    @ResponseBody
    public DataForDatagrid loadtrainingMode() {
        DataForDatagrid data=new DataForDatagrid();
        List<String > list=studentService.loadtrainingMode();
        List<Map<String ,String > > text= new ArrayList<>();
        for(String s:list){
            if(s==null || s.equals("")) continue;
            Map<String,String > map=new HashMap<>(1);
            map.put("trainingMode",PwdUtil.AESDecoding(s));
            text.add(map);
        }
        data.setDatas(text);
        return data;
    }

    /**
     * 招生类别
     * @return
     */
    @RequestMapping("/loadenrollType")
    @ResponseBody
    public DataForDatagrid loadenrollType() {
        DataForDatagrid data=new DataForDatagrid();
        List<String > list=studentService.loadenrollType();
        List<Map<String ,String > > text= new ArrayList<>();
        for(String s:list){
            if(s==null || s.equals("")) continue;
            Map<String,String > map=new HashMap<>(1);
            map.put("enrollType",PwdUtil.AESDecoding(s));
            text.add(map);
        }
        data.setDatas(text);
        return data;
    }

    /**
     * 学籍状态
     * @return
     */
    @RequestMapping("/loadschoolRollStatus")
    @ResponseBody
    public DataForDatagrid loadschoolRollStatus() {
        DataForDatagrid data=new DataForDatagrid();
        List<String > list=studentService.loadschoolRollStatus();
        List<Map<String ,String > > text= new ArrayList<>();
        for(String s:list){
            if(s==null || s.equals("")) continue;
            Map<String,String > map=new HashMap<>(1);
            map.put("schoolRollStatus",PwdUtil.AESDecoding(s));
            text.add(map);
        }
        data.setDatas(text);
        return data;
    }
    /**
     * 寝室楼
     * @return
     */
    @RequestMapping("/loadUsiBuilding")
    @ResponseBody
    public DataForDatagrid loadUsiBuilding() {
        List<String > list=studentService.loadUsiBuilding();
        return decodingList("usiBuilding",list);
    }

    /**
     * 房间号
     * @return
     */
    @RequestMapping("/loadUsiRoomNumber")
    @ResponseBody
    public DataForDatagrid loadUsiRoomNumber() {
        List<String > list=studentService.loadUsiRoomNumber();
        return decodingList("usiRoomNumber",list);
    }

    /**
     * 解密，把传递进来的String  List解密之后再转换成easyui可直接使用的combobox格式
     * @param mapkey
     * @param list
     * @return
     */
    private DataForDatagrid decodingList(String mapkey,List<String > list){
        DataForDatagrid data=new DataForDatagrid();
        List<Map<String ,String >> maplist=new ArrayList<>();
        for(String s:list){
            if(s==null || s.equals("")) continue;
            Map<String,String > map=new HashMap<>(1);
            map.put(mapkey,PwdUtil.AESDecoding(s));
            maplist.add(map);
        }
        data.setDatas(maplist);
        return data;
    }
    /**
     * 年级
     * @return
     */
    @RequestMapping("/loadschoolstuGradeName")
    @ResponseBody
    public DataForDatagrid loadschoolstuGradeName() {
        DataForDatagrid data=new DataForDatagrid();
        List<String > list=studentService.loadschoolstuGradeName();
        List<Map<String ,String > > text= new ArrayList<>();
        for(String s:list){
            if(s==null || s.equals("")) continue;
            Map<String,String > map=new HashMap<>(1);
            map.put("stuGradeName",PwdUtil.AESDecoding(s));
            text.add(map);
        }
        data.setDatas(text);
        return data;
    }

    /**
     *  加载班级
     * @return
     */
    @RequestMapping("/loadclassnames")
    @ResponseBody
    public DataForDatagrid loadclassnames() {
        DataForDatagrid data=new DataForDatagrid();
        List<String > list=studentService.getClassName();
        List<Map<String ,String > > text= new ArrayList<>();
        for(String s:list){
            if(s==null || s.equals("")) continue;
            Map<String,String > map=new HashMap<>(1);
            map.put("stuClassName",PwdUtil.AESDecoding(s));
            text.add(map);
        }
        data.setDatas(text);
        return data;
    }

    /**
     * 民族
     * @return
     */
    @RequestMapping("/loadschoolstudentNation")
    @ResponseBody
    public DataForDatagrid loadschoolstudentNation() {
        DataForDatagrid data=new DataForDatagrid();
        List<String > list=studentService.loadschoolstudentNation();
        List<Map<String ,String > > text= new ArrayList<>();
        for(String s:list){
            if(s==null || s.equals("")) continue;
            Map<String,String > map=new HashMap<>(1);
            map.put("studentNation",PwdUtil.AESDecoding(s));
            text.add(map);
        }
        data.setDatas(text);
        return data;
    }

    /**
     * 学院
     * @return
     */
    @RequestMapping("/loadschoolstuCollageName")
    @ResponseBody
    public DataForDatagrid loadschoolstuCollageName() {
        DataForDatagrid data=new DataForDatagrid();
        List<String > list=studentService.loadschoolstuCollageName();
        List<Map<String ,String > > text= new ArrayList<>();
        for(String s:list){
            if(s==null || s.equals("")) continue;
            Map<String,String > map=new HashMap<>(1);
            map.put("stuCollageName",PwdUtil.AESDecoding(s));
            text.add(map);
        }
        data.setDatas(text);
        return data;
    }

    /**
     * 专业
     * @return
     */
    @RequestMapping("/loadschoolstuMajorName")
    @ResponseBody
    public DataForDatagrid loadschoolstuMajorName() {
        DataForDatagrid data=new DataForDatagrid();
        List<String > list=studentService.loadschoolstuMajorName();
        List<Map<String ,String > > text= new ArrayList<>();
        for(String s:list){
            if(s==null || s.equals("")) continue;
            Map<String,String > map=new HashMap<>(1);
            map.put("stuMajorName",PwdUtil.AESDecoding(s));
            text.add(map);
        }
        data.setDatas(text);
        return data;
    }
    /**
     * 入学年份
     * @return
     */
    @RequestMapping("/loadEntranceDate")
    @ResponseBody
    public DataForDatagrid loadEntranceDate() {
        DataForDatagrid data=new DataForDatagrid();
        List<String > list=studentService.loadEntranceDate();
        List<Map<String ,String > > text= new ArrayList<>();
        for(String s:list){
            if(s==null || s.equals("")) continue;
            Map<String,String > map=new HashMap<>(1);
            map.put("entranceDate",PwdUtil.AESDecoding(s));
            text.add(map);
        }
        data.setDatas(text);
        return data;
    }
    /**
     * 前端页面用，加载学生个人信息
     * @param studentid
     * @return
     */
    @RequestMapping("/loadStudentInfo")
    @ResponseBody
    public DataForDatagrid loadStudentInfo(String studentid,HttpSession session) {
        DataForDatagrid data=new DataForDatagrid();
        if(studentid==null || studentid.equals("")){
            studentid= (String) session.getAttribute("studentid");
        }
        Student_Decoding s=studentService.loadStudentInfo(studentid);
        List<Student> stu=new ArrayList<>();
        stu.add(s);
        data.setDatas(stu);
        return data;
    }
    /**
     * 把对象转换成map ，只取里面是字符串的属性
     * @param obj
     * @return
     */
    private Map<String ,String > ObjToStringMap(Object obj){
        Map<String ,String > map=new HashMap<>();
        Class c=obj.getClass().getSuperclass();
        if(c==Object.class) c=obj.getClass();
        Field[] fields=c.getDeclaredFields();
        for(Field f:fields){
            if(f.getType()!=String.class) continue;
            try {
                f.setAccessible(true);
                String str= (String) f.get(obj);
                if(str==null || str.equals("")) continue;
                map.put(f.getName(),str);
            } catch (IllegalAccessException e) {
                e.printStackTrace();
            }
        }
        return map;
    }
}
