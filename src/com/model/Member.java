package com.model;

import java.sql.Date;
import java.sql.Timestamp;

/**
 * 学生家庭成员/社会关系
 * @author hong
 * Created by admin on 2016/7/26.
 */
public class Member {
    /**
     * ID
     */
    protected String memberId;
    /**
     * 学号,管理学生表ID
     */
    protected String memberStudentId;
    protected String studentID;
    protected String studentName;
    protected String classId;
    protected String className;
    protected String collegeId;
    protected String collegeName;
    protected String instructorId;
    protected String instructorName;


    /**
     * 关系类型:家庭成员/社会关系
     */
    protected String memberType;
    /**
     * 成员关系,如父子/母子/同学/朋友等
     */
    protected String memberRelation;
    /**
     * 成员姓名
     */
    protected String memberName;
    /**
     * 出生日期
     */
    protected Date memberBirthday;
    /**
     * 工作单位
     */
    protected String memberWork;
    /**
     * 联系电话
     */
    protected String memberPhone;

    public String getStudentID() {
        return studentID;
    }

    public void setStudentID(String studentID) {
        this.studentID = studentID;
    }

    public String getStudentName() {
        return studentName;
    }

    public void setStudentName(String studentName) {
        this.studentName = studentName;
    }

    public String getClassId() {
        return classId;
    }

    public void setClassId(String classId) {
        this.classId = classId;
    }

    public String getClassName() {
        return className;
    }

    public void setClassName(String className) {
        this.className = className;
    }

    public String getCollegeId() {
        return collegeId;
    }

    public void setCollegeId(String collegeId) {
        this.collegeId = collegeId;
    }

    public String getCollegeName() {
        return collegeName;
    }

    public void setCollegeName(String collegeName) {
        this.collegeName = collegeName;
    }

    public String getInstructorId() {
        return instructorId;
    }

    public void setInstructorId(String instructorId) {
        this.instructorId = instructorId;
    }

    public String getInstructorName() {
        return instructorName;
    }

    public void setInstructorName(String instructorName) {
        this.instructorName = instructorName;
    }

    public String getMemberId() {
        return memberId;
    }

    public void setMemberId(String memberId) {
        this.memberId = memberId;
    }

    public String getMemberStudentId() {
        return memberStudentId;
    }

    public void setMemberStudentId(String memberStudentId) {
        this.memberStudentId = memberStudentId;
    }

    public String getMemberType() {
        return memberType;
    }

    public void setMemberType(String memberType) {
        this.memberType = memberType;
    }

    public String getMemberRelation() {
        return memberRelation;
    }

    public void setMemberRelation(String memberRelation) {
        this.memberRelation = memberRelation;
    }

    public String getMemberName() {
        return memberName;
    }

    public void setMemberName(String memberName) {
        this.memberName = memberName;
    }

    public Date getMemberBirthday() {
        return memberBirthday;
    }

    public void setMemberBirthday(Date memberBirthday) {
        this.memberBirthday = memberBirthday;
    }

    public String getMemberWork() {
        return memberWork;
    }

    public void setMemberWork(String memberWork) {
        this.memberWork = memberWork;
    }

    public String getMemberPhone() {
        return memberPhone;
    }

    public void setMemberPhone(String memberPhone) {
        this.memberPhone = memberPhone;
    }

    @Override
    public String toString() {
        return "Member{" +
                "memberId='" + memberId + '\'' +
                ", memberStudentId='" + memberStudentId + '\'' +
                ", memberType='" + memberType + '\'' +
                ", memberRelation='" + memberRelation + '\'' +
                ", memberName='" + memberName + '\'' +
                ", memberBirthday='" + memberBirthday + '\'' +
                ", memberWork='" + memberWork + '\'' +
                ", memberPhone='" + memberPhone + '\'' +
                '}';
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;

        Member member = (Member) o;

        return memberId != null ? memberId.equals(member.memberId) : member.memberId == null;

    }

    @Override
    public int hashCode() {
        return memberId != null ? memberId.hashCode() : 0;
    }
}
