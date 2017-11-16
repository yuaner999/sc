package com.Services.impls;

import com.Services.interfaces.StudentService;
import com.dao.interfaces.StudentDao;
import com.github.pagehelper.PageHelper;
import com.model.Student;
import com.model.Student_Decoding;
import com.model.Student_Encoding;
import com.utils.PwdUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.Map;

/**
 * @author hong
 * Created by admin on 2016/7/15.
 */
@Service
public class StudentServiceImpl  implements StudentService{
    @Override
    public List<String> loadschoolstuGradeName() {
        return studentDao.loadschoolstuGradeName();
    }

    @Override
    public List<String> loadschoolstuCollageName() {
        return studentDao.loadschoolstuCollageName();
    }

    @Override
    public List<String> loadschoolstuMajorName() {
        return studentDao.loadschoolstuMajorName();
    }

    @Override
    public List<String> loadschoolstudentNation() {
        return studentDao.loadschoolstudentNation();
    }

    @Autowired
    private StudentDao studentDao;

    @Override
    @Transactional
    public int saveStudents(List<Student> list) {
        return studentDao.saveStudents(list);
    }

    @Override
    public List<String> getKeys(List<Map<String, String>> list) {
        return studentDao.getKeys(list);
    }

    @Override
    public int deleteMore(List<String> list) {
        return studentDao.deleteMore(list);
    }

    @Override
    public List<String> getClassName() {
        return studentDao.getClassName();
    }

    @Override
    public Student getStudentById(String id) {
        return studentDao.getStudentById(id);
    }

    @Override
    public int saveFindPwdCode(String studentId, String validId) {
        return studentDao.saveFindPwdCode(studentId,validId);
    }

    @Override
    public List<Student_Decoding> loadStudents(Map<String, Object> map,int pagenum,int rows) {
        PageHelper.startPage(pagenum,rows);
        //需要加密处理 才能与数据库进行比较 全部AES 加密的方式
        //单独的
        AESDManageSingle(map,"studentIdCard");
        AESDManageSingle(map,"studentPhone");
        AESDManageSingle(map,"usiCampus");
        //多选的
        AESDManageMultiple(map,"educationLength");
        AESDManageMultiple(map,"trainingMode");
        AESDManageMultiple(map,"enrollType");
        AESDManageMultiple(map,"schoolRollStatus");
        AESDManageMultiple(map,"usiRoomNumber");
        AESDManageMultiple(map,"entranceDate");
        AESDManageMultiple(map,"usiBuilding");
        //处理多项查询 把多选项中的参数的String变为数组
        ChangString(map,"studentNation");
        ChangString(map,"stuCollageName");
        ChangString(map,"stuMajorName");
        ChangString(map,"stuGradeName");
//        ChangString(map,"usiCampus");
        ChangString(map,"stuClassName");
//        ChangString(map,"educationLength");
//        ChangString(map,"trainingMode");
//        ChangString(map,"enrollType");
//        ChangString(map,"schoolRollStatus");
        List<Student_Decoding> list=studentDao.loadStudents(map);
//        System.out.println("这是返回后的list"+list);
        return list;
    }
    @Override
    public List<Student_Decoding> loadStudentsNew(Map<String, Object> map,int pagenum,int rows) {
        PageHelper.startPage(pagenum,rows);
        //需要加密处理 才能与数据库进行比较 全部AES 加密的方式
        //单独的
        AESDManageSingle(map,"studentIdCard");
        AESDManageSingle(map,"studentPhone");
        AESDManageSingle(map,"usiCampus");
        AESDManageSingle(map,"usiBuilding");
        AESDManageSingle(map,"trainingMode");
        AESDManageSingle(map,"usiRoomNumber");
        AESDManageSingle(map,"enrollType");
        AESDManageSingle(map,"schoolRollStatus");
        AESDManageSingle(map,"studentNation");
        AESDManageSingle(map,"educationLength");
//        System.out.println(map);

        List<Student_Decoding> list=studentDao.loadStudentsNew(map);
//        System.out.println("这是返回后的list"+list);
        return list;
    }
    @Override
    public List<Student_Decoding> loadStudentsByClass(Map<String, Object> map, int pagenum, int rows) {
        PageHelper.startPage(pagenum,rows);
        List<Student_Decoding> list=studentDao.loadStudentsByClass(map);
        return list;
    }

    @Override
    public int addStudent(Student_Encoding student) {
        return studentDao.addStudent(student);
    }

    @Override
    public int editStudent(Student_Encoding student) {
        return studentDao.editStudent(student);
    }

    @Override
    public List<String> loadeducationLength() {
        return studentDao.loadeducationLength();
    }

    @Override
    public List<String> loadtrainingMode() {
        return studentDao.loadtrainingMode();
    }

    @Override
    public List<String> loadenrollType() {
        return studentDao.loadenrollType();
    }

    @Override
    public List<String> loadschoolRollStatus() {
        return studentDao.loadschoolRollStatus();
    }

    @Override
    public List<String> loadUsiBuilding() {
        return studentDao.loadUsiBuilding();
    }

    @Override
    public List<String> loadEntranceDate() {return studentDao.loadEntranceDate();}

    @Override
    public List<String> loadUsiRoomNumber() {
        return studentDao.loadUsiRoomNumber();
    }

    @Override
    public Student_Decoding loadStudentInfo(String studentid) {
        return studentDao.loadStudentInfo(studentid);
    }

    @Override
    public int editPhone(String studentid, String newphone) {
        return studentDao.editPhone(studentid, newphone);
    }

    @Override
    public int editPhoto(String studentid, String newphoto) {
        return studentDao.editPhoto(studentid, newphoto);
    }

    private void ChangString(Map<String, Object> map, String string){
        String  before =(String) map.get(string);
        if(before !=null && ! "".equals(before)){
            String[] now = before.split(",");
            for (String str: now) {
//                System.out.println("这是修改后的" + str);
            }
            //之后没有形成空的数组
//            System.out.println("拆分后的大小"+now.length);
//            for (int i = 0 ;i<now.length;i++){
//                System.out.println("这是拆分后形成的数组第"+i+"个");
//                System.out.println(now[i]);
//            }
            map.put(string,now);
        }

    }
    //把未加密的加密处理
    private void AESDManageSingle(Map<String, Object> map,String string){
        String before = (String)map .get(string);
        if(before !=null &&  !"".equals(before)) {
            String now = PwdUtil.AESEncoding(before);
            map.put(string, now);
        }
    }
    private void AESDManageMultiple(Map<String, Object> map,String string){
        String before = (String)map .get(string);
        if (before !=null &&  !"".equals(before)) {
            String[] now = before.split(",");
            String[] replace = new String[now.length];
            for (int i = 0; i < now.length; i++) {
                replace[i] = PwdUtil.AESEncoding(now[i]);
//                System.out.println("这是修改完后的"+replace[i]);
            }
            map.put(string, replace);
        }
    }

}
