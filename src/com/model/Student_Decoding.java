package com.model;

import com.utils.PwdUtil;


/**
 * 学生信息解密
 * @author hong
 * Created by admin on 2016/7/29.
 */
public class Student_Decoding extends Student{
//    public String getStudentID() {
//        return studentID;
//    }
//
//    public void setStudentID(String studentID) {
//        this.studentID = studentID;
//    }
//
//    public String getStudentPwd() {
//        return studentPwd;
//    }
//
//    public void setStudentPwd(String studentPwd) {
//        this.studentPwd = studentPwd;
//    }

//    public String getStudentName() {
//        return PwdUtil.AESDecoding(studentName);
//    }

//    public void setStudentName(String studentName) {
//        this.studentName = PwdUtil.AESEncoding(studentName);
//    }

    public String getStudentUsedName() {
        return PwdUtil.AESDecoding(studentUsedName);
    }

//    public void setStudentUsedName(String studentUsedName) {
//        this.studentUsedName = PwdUtil.AESEncoding(studentUsedName);
//    }

//    public String getStudentPhoto() {
//        return studentPhoto;
//    }

//    public void setStudentPhoto(String studentPhoto) {
//        this.studentPhoto = studentPhoto;
//    }

//    public String getStudentGender() {
//        return studentGender;
//    }

//    public void setStudentGender(String studentGender) {
//        this.studentGender = studentGender;
//    }

    public String getStudentNation() {
        return PwdUtil.AESDecoding(studentNation);
    }

//    public void setStudentNation(String studentNation) {
//        this.studentNation = PwdUtil.AESEncoding(studentNation);
//    }

//    public Timestamp getStudentBirthday() {
//        return studentBirthday;
//    }

//    public void setStudentBirthday(Timestamp studentBirthday) {
//        this.studentBirthday = studentBirthday;
//    }

    public String getStudentNativePlace() {
        return PwdUtil.AESDecoding(studentNativePlace);
    }

//    public void setStudentNativePlace(String studentNativePlace) {
//        this.studentNativePlace = PwdUtil.AESEncoding(studentNativePlace);
//    }

    public String getStudentFamilyAddress() {
        return PwdUtil.AESDecoding(studentFamilyAddress);
    }

//    public void setStudentFamilyAddress(String studentFamilyAddress) {
//        this.studentFamilyAddress = PwdUtil.AESEncoding(studentFamilyAddress);
//    }

    public String getStudentFamilyPostcode() {
        return PwdUtil.AESDecoding(studentFamilyPostcode);
    }

//    public void setStudentFamilyPostcode(String studentFamilyPostcode) {
//        this.studentFamilyPostcode = PwdUtil.AESEncoding(studentFamilyPostcode);
//    }

    public String getStudentIdCard() {
        return PwdUtil.AESDecoding(studentIdCard);
    }

//    public void setStudentIdCard(String studentIdCard) {
//        this.studentIdCard = PwdUtil.AESEncoding(studentIdCard);
//    }

    public String getStudentPhone() {
        return PwdUtil.AESDecoding(studentPhone);
    }

//    public void setStudentPhone(String studentPhone) {
//        this.studentPhone = PwdUtil.AESEncoding(studentPhone);
//    }

    public String getStudentQQ() {
        return PwdUtil.AESDecoding(studentQQ);
    }

//    public void setStudentQQ(String studentQQ) {
//        this.studentQQ = PwdUtil.AESEncoding(studentQQ);
//    }

    public String getStudentEmail() {
        return PwdUtil.AESDecoding(studentEmail);
    }

//    public void setStudentEmail(String studentEmail) {
//        this.studentEmail = PwdUtil.AESEncoding(studentEmail);
//    }

    public String getForeignLanguage() {
        return PwdUtil.AESDecoding(foreignLanguage);
    }

//    public void setForeignLanguage(String foreignLanguage) {
//        this.foreignLanguage = PwdUtil.AESEncoding(foreignLanguage);
//    }

    public String getFaith() {
        return PwdUtil.AESDecoding(faith);
    }

//    public void setFaith(String faith) {
//        this.faith = PwdUtil.AESEncoding(faith);
//    }

    public String getPoliticsStatus() {
        return PwdUtil.AESDecoding(politicsStatus);
    }

//    public void setPoliticsStatus(String politicsStatus) {
//        this.politicsStatus = PwdUtil.AESEncoding(politicsStatus);
//    }

//    public Timestamp getPoliticsStatusDate() {
//        return politicsStatusDate;
//    }

//    public void setPoliticsStatusDate(Timestamp politicsStatusDate) {
//        this.politicsStatusDate = politicsStatusDate;
//    }

    public String getUsiCampus() {
        return PwdUtil.AESDecoding(usiCampus);
    }

//    public void setUsiCampus(String usiCampus) {
//        this.usiCampus = PwdUtil.AESEncoding(usiCampus);
//    }

//    public String getUsiClassId() {
//        return PwdUtil.AESDecoding(usiClassId);
//    }

//    public void setUsiClassId(String usiClassId) {
//        this.usiClassId = PwdUtil.AESEncoding(usiClassId);
//    }

    public String getUsiBuilding() {
        return PwdUtil.AESDecoding(usiBuilding);
    }

//    public void setUsiBuilding(String usiBuilding) {
//        this.usiBuilding = PwdUtil.AESEncoding(usiBuilding);
//    }

    public String getUsiRoomNumber() {
        return PwdUtil.AESDecoding(usiRoomNumber);
    }

//    public void setUsiRoomNumber(String usiRoomNumber) {
//        this.usiRoomNumber = PwdUtil.AESEncoding(usiRoomNumber);
//    }

    public String getEntranceDate() {
        return PwdUtil.AESDecoding(entranceDate);
    }

//    public void setEntranceDate(String entranceDate) {
//        this.entranceDate = PwdUtil.AESEncoding(entranceDate);
//    }

    public String getEducationLength() {
        return PwdUtil.AESDecoding(educationLength);
    }

//    public void setEducationLength(String educationLength) {
//        this.educationLength = PwdUtil.AESEncoding(educationLength);
//    }

    public String getTrainingMode() {
        return PwdUtil.AESDecoding(trainingMode);
    }

//    public void setTrainingMode(String trainingMode) {
//        this.trainingMode = PwdUtil.AESEncoding(trainingMode);
//    }

    public String getOrientationUnit() {
        return PwdUtil.AESDecoding(orientationUnit);
    }

//    public void setOrientationUnit(String orientationUnit) {
//        this.orientationUnit = PwdUtil.AESEncoding(orientationUnit);
//    }

    public String getEnrollType() {
        return PwdUtil.AESDecoding(enrollType);
    }

//    public void setEnrollType(String enrollType) {
//        this.enrollType = PwdUtil.AESEncoding(enrollType);
//    }

    public String getSchoolRollStatus() {
        return PwdUtil.AESDecoding(schoolRollStatus);
    }

//    public void setSchoolRollStatus(String schoolRollStatus) {
//        this.schoolRollStatus = PwdUtil.AESEncoding(schoolRollStatus);
//    }

    public String getStudentLeader() {
        return PwdUtil.AESDecoding(studentLeader);
    }

//    public void setStudentLeader(String studentLeader) {
//        this.studentLeader = PwdUtil.AESEncoding(studentLeader);
//    }

    public String getCeeOrigin() {
        return PwdUtil.AESDecoding(ceeOrigin);
    }

//    public void setCeeOrigin(String ceeOrigin) {
//        this.ceeOrigin = PwdUtil.AESEncoding(ceeOrigin);
//    }

    public String getCeeNumber() {
        return PwdUtil.AESDecoding(ceeNumber);
    }

//    public void setCeeNumber(String ceeNumber) {
//        this.ceeNumber = PwdUtil.AESEncoding(ceeNumber);
//    }

    public String getCeeProvince() {
        return PwdUtil.AESDecoding(ceeProvince);
    }

//    public void setCeeProvince(String ceeProvince) {
//        this.ceeProvince = PwdUtil.AESEncoding(ceeProvince);
//    }

    public String getCeeCity() {
        return PwdUtil.AESDecoding(ceeCity);
    }

//    public void setCeeCity(String ceeCity) {
//        this.ceeCity = PwdUtil.AESEncoding(ceeCity);
//    }

    public String getCeeHighSchool() {
        return PwdUtil.AESDecoding(ceeHighSchool);
    }

//    public void setCeeHighSchool(String ceeHighSchool) {
//        this.ceeHighSchool = PwdUtil.AESEncoding(ceeHighSchool);
//    }
}
