package com.model;

import java.sql.Date;

/**
 * 活动表 activities
 * Created by sw on 2016/8/30.
 */
public class activities {
    /*
    * 活动ID跟活动关联
    * */
    private String activityId;

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
    private String activityCredit;
    //词典里的活动类名称
    private String activityClassMean;

    private String applyState;

    //工作时长
    private String worktime;

    public String getWorktime() {return worktime;}
    public void setWorktime(String worktime) {this.worktime = worktime;}

    public String getApplyState(){return applyState;}
    public void setApplyState(String applyState) {this.applyState = applyState;}

    public String getActivityCredit() {
        return activityCredit;
    }

    public void setActivityCredit(String activityCredit) {
        this.activityCredit = activityCredit;
    }

    public String getActivityId() {
        return activityId;
    }

    public void setActivityId(String activityId) {
        this.activityId = activityId;
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

    public String getCollegeID() {
        return collegeID;
    }

    public void setCollegeID(String collegeID) {
        this.collegeID = collegeID;
    }

    public String getActivityClassMean() {
        return activityClassMean;
    }

    public void setActivityClassMean(String activityClassMean) {
        this.activityClassMean = activityClassMean;
    }

    @Override
    public String toString() {
        return "activities{" +
                "activityId='" + activityId + '\'' +
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
                ", collegeID='" + applyState + '\'' +
                ", worktime='" + worktime + '\'' +
                '}';
    }

}
