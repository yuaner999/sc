package com.model;

import com.utils.PwdUtil;

import java.sql.Date;

/**
 * 学生家庭成员/社会关系    加密
 * @author hong
 * Created by admin on 2016/7/30.
 */
public class Member_Encoding extends Member{
//    public String getMemberId() {
//        return memberId;
//    }
//
//    public void setMemberId(String memberId) {
//        this.memberId = memberId;
//    }
//
//    public String getMemberStudentId() {
//        return memberStudentId;
//    }
//
//    public void setMemberStudentId(String memberStudentId) {
//        this.memberStudentId = memberStudentId;
//    }

//    public String getMemberType() {
//        return memberType;
//    }

    public void setMemberType(String memberType) {
        this.memberType = PwdUtil.AESEncoding(memberType);
    }

//    public String getMemberRelation() {
//        return memberRelation;
//    }

    public void setMemberRelation(String memberRelation) {
        this.memberRelation = PwdUtil.AESEncoding(memberRelation);
    }

//    public String getMemberName() {
//        return memberName;
//    }

    public void setMemberName(String memberName) {
        this.memberName = PwdUtil.AESEncoding(memberName);
    }

//    public Date getMemberBirthday() {
//        return memberBirthday;
//    }
//
//    public void setMemberBirthday(Date memberBirthday) {
//        this.memberBirthday = memberBirthday;
//    }

//    public String getMemberWork() {
//        return memberWork;
//    }

    public void setMemberWork(String memberWork) {
        this.memberWork = PwdUtil.AESEncoding(memberWork);
    }

//    public String getMemberPhone() {
//        return memberPhone;
//    }

    public void setMemberPhone(String memberPhone) {
        this.memberPhone = PwdUtil.AESEncoding(memberPhone);
    }
}
