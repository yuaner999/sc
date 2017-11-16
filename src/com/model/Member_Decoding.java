package com.model;

import com.utils.PwdUtil;

/**
 * 学生家庭成员/社会关系    解密
 * @author hong
 * Created by admin on 2016/7/30.
 */
public class Member_Decoding extends Member {
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

    public String getMemberType() {
        return PwdUtil.AESDecoding(memberType);
    }

//    public void setMemberType(String memberType) {
//        this.memberType = memberType;
//    }

    public String getMemberRelation() {
        return PwdUtil.AESDecoding(memberRelation);
    }

//    public void setMemberRelation(String memberRelation) {
//        this.memberRelation = memberRelation;
//    }

    public String getMemberName() {
        return PwdUtil.AESDecoding(memberName);
    }

//    public void setMemberName(String memberName) {
//        this.memberName = memberName;
//    }

//    public Date getMemberBirthday() {
//        return memberBirthday;
//    }
//
//    public void setMemberBirthday(Date memberBirthday) {
//        this.memberBirthday = memberBirthday;
//    }

    public String getMemberWork() {
        return PwdUtil.AESDecoding(memberWork);
    }

//    public void setMemberWork(String memberWork) {
//        this.memberWork = memberWork;
//    }

    public String getMemberPhone() {
        return PwdUtil.AESDecoding(memberPhone);
    }

//    public void setMemberPhone(String memberPhone) {
//        this.memberPhone = memberPhone;
//    }
}
