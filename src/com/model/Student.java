package com.model;

import java.sql.Date;

/**
 * 学生信息表
 * @author hong
 * Created by admin on 2016/7/13.
 */
public class Student {
    /**
     * 学号
     */
    protected String studentID;
    /**
     * 密码
     */
    protected String studentPwd;
    /**
     * 学生姓名
     */
    protected String studentName;
    /**
     * 曾用名
     */
    protected String studentUsedName;
    /**
     * 照片
     */
    protected String studentPhoto;
    /**
     * 性别
     */
    protected String studentGender;
    /**
     * 民族
     */
    protected String studentNation;
    /**
     * 出生日期
     */
    protected Date studentBirthday;
    /**
     * 籍贯
     */
    protected String studentNativePlace;
    /**
     * 家庭住址
     */
    protected String studentFamilyAddress;
    /**
     * 家庭邮编
     */
    protected String studentFamilyPostcode;
    /**
     * 身份证号码
     */
    protected String studentIdCard;
    /**
     * 手机号
     */
    protected String studentPhone;
    /**
     * QQ号
     */
    protected String studentQQ;
    /**
     * 邮件
     */
    protected String studentEmail;
    /**
     * 外语语种
     */
    protected String foreignLanguage;
    /**
     * 宗教信仰
     */
    protected String faith;
    /**
     * 政治面貌
     */
    protected String politicsStatus;
    /**
     * 入团或入党时间
     */
    protected Date politicsStatusDate;
    /**
     * 所在校区
     */
    protected String usiCampus;
    /**
     * 班级,关联班级表ID
     */
    protected String usiClassId;
    /**
     * 寝室楼
     */
    protected String usiBuilding;
    /**
     * 房间号
     */
    protected String usiRoomNumber;
    /**
     * 入学年份,只写年
     */
    protected String entranceDate;
    /**
     * 学制
     */
    protected String educationLength;
    /**
     * 培养方式
     */
    protected String trainingMode;
    /**
     * 定向单位
     */
    protected String orientationUnit;
    /**
     * 招生类别
     */
    protected String enrollType;
    /**
     * 学籍状态
     */
    protected String schoolRollStatus;
    /**
     * 学生干部
     */
    protected String studentLeader;
    /**
     * 生源地
     */
    protected String ceeOrigin;
    /**
     * 考号
     */
    protected String ceeNumber;
    /**
     * 所在省
     */
    protected String ceeProvince;
    /**
     * 所在市
     */
    protected String ceeCity;
    /**
     * 所在高中
     */
    protected String ceeHighSchool;
    /**
     * 班级名字(数据库中表格没有该字段，视图中有)
     */
    protected String className;
    /**
     * 2016-09-23修改后新增字段
     * 班级名字
     */
    protected String stuClassName;
    /**
     * 2016-09-23修改后新增字段
     * 专业名字
     */
    protected String stuMajorName;
    /**
     * 2016-09-23修改后新增字段
     * 专业分类
     */
    protected String stuMajorClass;
    /**
     * 2016-09-23修改后新增字段
     * 年级名字
     */
    protected String stuGradeName;
    /**
     * 2016-09-23修改后新增字段
     * 学院名字
     */
    protected String stuCollageName;
    /**
     * 学生经济情况
     */
    protected String stuEconomic;


    public String getClassName() {
        return className;
    }

    public void setClassName(String className) {
        this.className = className;
    }

    public String getStudentID() {
        return studentID;
    }

    public void setStudentID(String studentID) {
        this.studentID = studentID;
    }

    public String getStudentPwd() {
        return studentPwd;
    }

    public void setStudentPwd(String studentPwd) {
        this.studentPwd = studentPwd;
    }

    public String getStudentName() {
        return studentName;
    }

    public void setStudentName(String studentName) {
        this.studentName = studentName;
    }

    public String getStudentUsedName() {
        return studentUsedName;
    }

    public void setStudentUsedName(String studentUsedName) {
        this.studentUsedName = studentUsedName;
    }

    public String getStudentPhoto() {
        return studentPhoto;
    }

    public void setStudentPhoto(String studentPhoto) {
        this.studentPhoto = studentPhoto;
    }

    public String getStudentGender() {
        return studentGender;
    }

    public void setStudentGender(String studentGender) {
        this.studentGender = studentGender;
    }

    public String getStudentNation() {
        return studentNation;
    }

    public void setStudentNation(String studentNation) {
        this.studentNation = studentNation;
    }

    public Date getStudentBirthday() {
        return studentBirthday;
    }

    public void setStudentBirthday(Date studentBirthday) {
        this.studentBirthday = studentBirthday;
    }

    public String getStudentNativePlace() {
        return studentNativePlace;
    }

    public void setStudentNativePlace(String studentNativePlace) {
        this.studentNativePlace = studentNativePlace;
    }

    public String getStudentFamilyAddress() {
        return studentFamilyAddress;
    }

    public void setStudentFamilyAddress(String studentFamilyAddress) {
        this.studentFamilyAddress = studentFamilyAddress;
    }

    public String getStudentFamilyPostcode() {
        return studentFamilyPostcode;
    }

    public void setStudentFamilyPostcode(String studentFamilyPostcode) {
        this.studentFamilyPostcode = studentFamilyPostcode;
    }

    public String getStudentIdCard() {
        return studentIdCard;
    }

    public void setStudentIdCard(String studentIdCard) {
        this.studentIdCard = studentIdCard;
    }

    public String getStudentPhone() {
        return studentPhone;
    }

    public void setStudentPhone(String studentPhone) {
        this.studentPhone = studentPhone;
    }

    public String getStudentQQ() {
        return studentQQ;
    }

    public void setStudentQQ(String studentQQ) {
        this.studentQQ = studentQQ;
    }

    public String getStudentEmail() {
        return studentEmail;
    }

    public void setStudentEmail(String studentEmail) {
        this.studentEmail = studentEmail;
    }

    public String getForeignLanguage() {
        return foreignLanguage;
    }

    public void setForeignLanguage(String foreignLanguage) {
        this.foreignLanguage = foreignLanguage;
    }

    public String getFaith() {
        return faith;
    }

    public void setFaith(String faith) {
        this.faith = faith;
    }

    public String getPoliticsStatus() {
        return politicsStatus;
    }

    public void setPoliticsStatus(String politicsStatus) {
        this.politicsStatus = politicsStatus;
    }

    public Date getPoliticsStatusDate() {
        return politicsStatusDate;
    }

    public void setPoliticsStatusDate(Date politicsStatusDate) {
        this.politicsStatusDate = politicsStatusDate;
    }

    public String getUsiCampus() {
        return usiCampus;
    }

    public void setUsiCampus(String usiCampus) {
        this.usiCampus = usiCampus;
    }

    public String getUsiClassId() {
        return usiClassId;
    }

    public void setUsiClassId(String usiClassId) {
        this.usiClassId = usiClassId;
    }

    public String getUsiBuilding() {
        return usiBuilding;
    }

    public void setUsiBuilding(String usiBuilding) {
        this.usiBuilding = usiBuilding;
    }

    public String getUsiRoomNumber() {
        return usiRoomNumber;
    }

    public void setUsiRoomNumber(String usiRoomNumber) {
        this.usiRoomNumber = usiRoomNumber;
    }

    public String getEntranceDate() {
        return entranceDate;
    }

    public void setEntranceDate(String entranceDate) {
        this.entranceDate = entranceDate;
    }

    public String getEducationLength() {
        return educationLength;
    }

    public void setEducationLength(String educationLength) {
        this.educationLength = educationLength;
    }

    public String getTrainingMode() {
        return trainingMode;
    }

    public void setTrainingMode(String trainingMode) {
        this.trainingMode = trainingMode;
    }

    public String getOrientationUnit() {
        return orientationUnit;
    }

    public void setOrientationUnit(String orientationUnit) {
        this.orientationUnit = orientationUnit;
    }

    public String getEnrollType() {
        return enrollType;
    }

    public void setEnrollType(String enrollType) {
        this.enrollType = enrollType;
    }

    public String getSchoolRollStatus() {
        return schoolRollStatus;
    }

    public void setSchoolRollStatus(String schoolRollStatus) {
        this.schoolRollStatus = schoolRollStatus;
    }

    public String getStudentLeader() {
        return studentLeader;
    }

    public void setStudentLeader(String studentLeader) {
        this.studentLeader = studentLeader;
    }

    public String getCeeOrigin() {
        return ceeOrigin;
    }

    public void setCeeOrigin(String ceeOrigin) {
        this.ceeOrigin = ceeOrigin;
    }

    public String getCeeNumber() {
        return ceeNumber;
    }

    public void setCeeNumber(String ceeNumber) {
        this.ceeNumber = ceeNumber;
    }

    public String getCeeProvince() {
        return ceeProvince;
    }

    public void setCeeProvince(String ceeProvince) {
        this.ceeProvince = ceeProvince;
    }

    public String getCeeCity() {
        return ceeCity;
    }

    public void setCeeCity(String ceeCity) {
        this.ceeCity = ceeCity;
    }

    public String getCeeHighSchool() {
        return ceeHighSchool;
    }

    public void setCeeHighSchool(String ceeHighSchool) {
        this.ceeHighSchool = ceeHighSchool;
    }

    public String getStuClassName() {
        return stuClassName;
    }

    public void setStuClassName(String stuClassName) {
        this.stuClassName = stuClassName;
    }

    public String getStuMajorName() {
        return stuMajorName;
    }

    public void setStuMajorName(String stuMajorName) {
        this.stuMajorName = stuMajorName;
    }

    public String getStuMajorClass() {
        return stuMajorClass;
    }

    public void setStuMajorClass(String stuMajorClass) {
        this.stuMajorClass = stuMajorClass;
    }

    public String getStuGradeName() {
        return stuGradeName;
    }

    public void setStuGradeName(String stuGradeName) {
        this.stuGradeName = stuGradeName;
    }

    public String getStuCollageName() {
        return stuCollageName;
    }

    public void setStuCollageName(String stuCollageName) {
        this.stuCollageName = stuCollageName;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;

        Student student = (Student) o;

        return studentID.equals(student.studentID);

    }

    @Override
    public int hashCode() {
        return studentID.hashCode();
    }

    public String getStuEconomic() {
        return stuEconomic;
    }

    public void setStuEconomic(String stuEconomic) {
        this.stuEconomic = stuEconomic;
    }

    @Override
    public String toString() {
        return "Student{" +
                "studentID='" + studentID + '\'' +
                ", studentPwd='" + studentPwd + '\'' +
                ", studentName='" + studentName + '\'' +
                ", studentUsedName='" + studentUsedName + '\'' +
                ", studentPhoto='" + studentPhoto + '\'' +
                ", studentGender='" + studentGender + '\'' +
                ", studentNation='" + studentNation + '\'' +
                ", studentBirthday=" + studentBirthday +
                ", studentNativePlace='" + studentNativePlace + '\'' +
                ", studentFamilyAddress='" + studentFamilyAddress + '\'' +
                ", studentFamilyPostcode='" + studentFamilyPostcode + '\'' +
                ", studentIdCard='" + studentIdCard + '\'' +
                ", studentPhone='" + studentPhone + '\'' +
                ", studentQQ='" + studentQQ + '\'' +
                ", studentEmail='" + studentEmail + '\'' +
                ", foreignLanguage='" + foreignLanguage + '\'' +
                ", faith='" + faith + '\'' +
                ", politicsStatus='" + politicsStatus + '\'' +
                ", politicsStatusDate=" + politicsStatusDate +
                ", usiCampus='" + usiCampus + '\'' +
                ", usiClassId='" + usiClassId + '\'' +
                ", usiBuilding='" + usiBuilding + '\'' +
                ", usiRoomNumber='" + usiRoomNumber + '\'' +
                ", entranceDate='" + entranceDate + '\'' +
                ", educationLength='" + educationLength + '\'' +
                ", trainingMode='" + trainingMode + '\'' +
                ", orientationUnit='" + orientationUnit + '\'' +
                ", enrollType='" + enrollType + '\'' +
                ", schoolRollStatus='" + schoolRollStatus + '\'' +
                ", studentLeader='" + studentLeader + '\'' +
                ", ceeOrigin='" + ceeOrigin + '\'' +
                ", ceeNumber='" + ceeNumber + '\'' +
                ", ceeProvince='" + ceeProvince + '\'' +
                ", ceeCity='" + ceeCity + '\'' +
                ", ceeHighSchool='" + ceeHighSchool + '\'' +
                ", className='" + className + '\'' +
                ", stuClassName='" + stuClassName + '\'' +
                ", stuMajorName='" + stuMajorName + '\'' +
                ", stuMajorClass='" + stuMajorClass + '\'' +
                ", stuGradeName='" + stuGradeName + '\'' +
                ", stuCollageName='" + stuCollageName + '\'' +
                ", stuEconomic='" + stuEconomic + '\'' +
                '}';
    }
}
