package com.model;

import javax.print.DocFlavor;
import java.sql.Date;

/**
 * 活动视图 wh_apply_activites
 *
 */
public class apply_activities {
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
    private Date signUpTime;
    /**
     * 活动封面
     * */
    private String activityImg;
    /**
     *活动标题
     */
    private String activityTitle;
    /**
     *活动内容
     */
    private String activityContent;
    /**
     *活动范围
     */
    private String activityArea;
    /**
     * 活动类型
     */
    private String activityClass;
    /**
     * 活动级别
     */
    private String activityLevle;
    /**
     * 活动性质
     */
    private String activityNature;
    /**
     *增加能力
     */
    private  String activityPowers;
    /**
     * 校内校外
     */
    private String activityIsInschool;
    /**
     * 活动地点
     */
    private String activityLocation;
    /**
     * 参与形式
     */
    private String activityParticipation;
    /**
     * 活动限制
     */
    private String activityFilterType;
    /**
     * 条件过滤值
     */
    private  String activityFilter;
    /**
     * 活动开始时间
     */
    private Date activitySdate;
    /**
     * 活动结束时间
     */
    private  Date activityEdate;
    /**
     * 创建时间
     */
    private  Date activityCreatedate;
    /**
     * 创建者
     */
    private String activityCreator;
    /**
     * 是否被删除
     */
    private String activityIsDelete;
    /**
     * 部门ID
     */
    private String deptID;
    /**
     * 学院ID
     */
    private String collegeID;

    /**
     * 其他类活动 得分 如果不是其他类活动为null
     */
    private String otherActivityPoint;
    private String activityCredit;

    //工作时长
    private String worktime;

    public String getWorktime() {return worktime;}
    public void setWorktime(String worktime) {this.worktime = worktime;}

    public String getActivityCredit() {
        return activityCredit;
    }

    public void setActivityCredit(String activityCredit) {
        this.activityCredit = activityCredit;
    }

    public String getOtherActivityPoint() {
        return otherActivityPoint;
    }

    public void setOtherActivityPoint(String otherActivityPoint) {
        this.otherActivityPoint = otherActivityPoint;
    }

    public String getCollegeID() {
        return collegeID;
    }

    public void setCollegeID(String collegeID) {
        this.collegeID = collegeID;
    }

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

    public String getActivityImg() {
        return activityImg;
    }

    public void setActivityImg(String activityImg) {
        this.activityImg = activityImg;
    }

    public String getActivityTitle() {
        return activityTitle;
    }

    public void setActivityTitle(String activityTitle) {
        this.activityTitle = activityTitle;
    }

    public String getActivityContent() {
        return activityContent;
    }

    public void setActivityContent(String activityContent) {
        this.activityContent = activityContent;
    }

    public String getActivityArea() {
        return activityArea;
    }

    public void setActivityArea(String activityArea) {
        this.activityArea = activityArea;
    }

    public String getActivityClass() {
        return activityClass;
    }



    public void setActivityClass(String activityClass) {
        this.activityClass = activityClass;
    }

    public String getActivityLevle() {
        return activityLevle;
    }

    public void setActivityLevle(String activityLevle) {
        this.activityLevle = activityLevle;
    }

    public String getActivityNature() {
        return activityNature;
    }

    public void setActivityNature(String activityNature) {
        this.activityNature = activityNature;
    }

    public String getActivityPowers() {
        return activityPowers;
    }

    public void setActivityPowers(String activityPowers) {
        this.activityPowers = activityPowers;
    }

    public String getActivityIsInschool() {
        return activityIsInschool;
    }

    public void setActivityIsInschool(String activityIsInschool) {
        this.activityIsInschool = activityIsInschool;
    }

    public String getActivityLocation() {
        return activityLocation;
    }

    public void setActivityLocation(String activityLocation) {
        this.activityLocation = activityLocation;
    }

    public String getActivityParticipation() {
        return activityParticipation;
    }

    public void setActivityParticipation(String activityParticipation) {
        this.activityParticipation = activityParticipation;
    }

    public String getActivityFilterType() {
        return activityFilterType;
    }

    public void setActivityFilterType(String activityFilterType) {
        this.activityFilterType = activityFilterType;
    }

    public String getActivityFilter() {
        return activityFilter;
    }

    public void setActivityFilter(String activityFilter) {
        this.activityFilter = activityFilter;
    }

    public Date getActivitySdate() {
        return activitySdate;
    }

    public void setActivitySdate(Date activitySdate) {
        this.activitySdate = activitySdate;
    }

    public Date getActivityEdate() {
        return activityEdate;
    }

    public void setActivityEdate(Date activityEdate) {
        this.activityEdate = activityEdate;
    }

    public Date getActivityCreatedate() {
        return activityCreatedate;
    }

    public void setActivityCreatedate(Date activityCreatedate) {
        this.activityCreatedate = activityCreatedate;
    }

    public String getActivityCreator() {
        return activityCreator;
    }

    public void setActivityCreator(String activityCreator) {
        this.activityCreator = activityCreator;
    }

    public String getActivityIsDelete() {
        return activityIsDelete;
    }

    public void setActivityIsDelete(String activityIsDelete) {
        this.activityIsDelete = activityIsDelete;
    }

    public String getDeptID() {
        return deptID;
    }

    public void setDeptID(String deptID) {
        this.deptID = deptID;
    }
    @Override
    public String toString() {
        return "apply_activities{" +
                "applyId='" + applyId + '\'' +
                ", applyActivityId='" + applyActivityId + '\'' +
                ", applyStudentId='" + applyStudentId + '\'' +
                ", applyStudentPhoto='" + applyStudentPhoto + '\'' +
                ", applyAuditStatus='" + applyAuditStatus + '\'' +
                ", activityAward='" + activityAward + '\'' +
                ", applyDate=" + applyDate +
                ", signUpStatus='" + signUpStatus + '\'' +
                ", signUpTime=" + signUpTime +
                ", activityImg='" + activityImg + '\'' +
                ", activityTitle='" + activityTitle + '\'' +
                ", activityContent='" + activityContent + '\'' +
                ", activityArea='" + activityArea + '\'' +
                ", activityClass='" + activityClass + '\'' +
                ", activityLevle='" + activityLevle + '\'' +
                ", activityNature='" + activityNature + '\'' +
                ", activityPowers='" + activityPowers + '\'' +
                ", activityIsInschool='" + activityIsInschool + '\'' +
                ", activityLocation='" + activityLocation + '\'' +
                ", activityParticipation='" + activityParticipation + '\'' +
                ", activityFilterType='" + activityFilterType + '\'' +
                ", activityFilter='" + activityFilter + '\'' +
                ", activitySdate=" + activitySdate +
                ", activityEdate=" + activityEdate +
                ", activityCreatedate=" + activityCreatedate +
                ", activityCreator='" + activityCreator + '\'' +
                ", activityIsDelete='" + activityIsDelete + '\'' +
                ", deptID='" + deptID + '\'' +
                ", collegeID='" + collegeID + '\'' +
                ", worktime='" + worktime + '\'' +
                '}';
    }
}
