package com.model;

import java.sql.Date;

/**
 * 活动申请信息表
 *  activityapply
 *
 * Created by sw on 2016/8/24.
 */
public class activityapply {
    /**
     * 表格ID
     * */
   private String applyId;
    /*
    * 活动ID跟活动关联
    * */
   private String  applyActivityId;
   /*
   * 学生学号跟学生关联
   * */
   private String  applyStudentId;
   /*
   * 学生照片，当活动类型是校外活动的时候需要上传照片，校内活动不需要照片
   * */
   private String  applyStudentPhoto;
    /*
    * 校外活动申请时需要审核，如果是校内活动，则不需要审核
    * */
   private String  applyAuditStatus;
   /**
    * 参与活动的获奖情况
    * */
   private String  activityAward;
    /**
     * 申请时间
     * */
   private Date applyDate;
    /**
     * 签到状态：默认为空或空串，签到之后变更为“已签到”
     * */
   private String signUpStatus;
    /**
     * 签到时间
     * */
   private Date  signUpTime;
    /**
     * 得分日期
     */
   private Date activityCreatedate;
    /**
     * 团体申请id
     */
    private String  applyTeamId;
    /**
     * 参与活动得分
     */
    private String  activitypoint;
    /**
     * 审核日期
     */
    private Date applyAuditStatusDate;
    private  String sta;

    public String getApplyId() {
        return applyId;
    }

    public void setApplyId(String applyId) {
        this.applyId = applyId;
    }

    public String getApplyActivityId() {
        return applyActivityId;
    }

    public void setApplyActivityId(String applyActivityId) {
        this.applyActivityId = applyActivityId;
    }

    public String getApplyStudentId() {
        return applyStudentId;
    }

    public void setApplyStudentId(String applyStudentId) {
        this.applyStudentId = applyStudentId;
    }

    public String getApplyStudentPhoto() {
        return applyStudentPhoto;
    }

    public void setApplyStudentPhoto(String applyStudentPhoto) {
        this.applyStudentPhoto = applyStudentPhoto;
    }

    public String getApplyAuditStatus() {
        return applyAuditStatus;
    }

    public void setApplyAuditStatus(String applyAuditStatus) {
        this.applyAuditStatus = applyAuditStatus;
    }

    public String getActivityAward() {
        return activityAward;
    }

    public void setActivityAward(String activityAward) {
        this.activityAward = activityAward;
    }

    public Date getApplyDate() {
        return applyDate;
    }

    public void setApplyDate(Date applyDate) {
        this.applyDate = applyDate;
    }

    public String getSignUpStatus() {
        return signUpStatus;
    }

    public void setSignUpStatus(String signUpStatus) {
        this.signUpStatus = signUpStatus;
    }

    public Date getSignUpTime() {
        return signUpTime;
    }

    public void setSignUpTime(Date signUpTime) {
        this.signUpTime = signUpTime;
    }

    public Date getActivityCreatedate() {
        return activityCreatedate;
    }

    public void setActivityCreatedate(Date activityCreatedate) {
        this.activityCreatedate = activityCreatedate;
    }

    public String getApplyTeamId() {
        return applyTeamId;
    }

    public void setApplyTeamId(String applyTeamId) {
        this.applyTeamId = applyTeamId;
    }

    public String getActivitypoint() {
        return activitypoint;
    }

    public void setActivitypoint(String activitypoint) {
        this.activitypoint = activitypoint;
    }

    public Date getApplyAuditStatusDate() {
        return applyAuditStatusDate;
    }

    public void setApplyAuditStatusDate(Date applyAuditStatusDate) {
        this.applyAuditStatusDate = applyAuditStatusDate;
    }

    public String getSta() {
        return sta;
    }

    public void setSta(String sta) {
        this.sta = sta;
    }

    @Override
    public String toString() {
        return "activityapply{" +
                "applyId='" + applyId + '\'' +
                ", applyActivityId='" + applyActivityId + '\'' +
                ", applyStudentId='" + applyStudentId + '\'' +
                ", applyStudentPhoto='" + applyStudentPhoto + '\'' +
                ", applyAuditStatus='" + applyAuditStatus + '\'' +
                ", activityAward='" + activityAward + '\'' +
                ", applyDate=" + applyDate +
                ", signUpStatus='" + signUpStatus + '\'' +
                ", signUpTime=" + signUpTime +
                ", activityCreatedate=" + activityCreatedate +
                ", applyTeamId='" + applyTeamId + '\'' +
                ", activitypoint='" + activitypoint + '\'' +
                ", applyAuditStatusDate=" + applyAuditStatusDate +
                '}';
    }
}
