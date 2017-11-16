package com.model;

import java.sql.Date;

/**
 * Created by shaowen on 2016/10/24.
 */
public class Notactivity {
    /**
     * 非活动类id
     */
    private String notid;
    /**
     * 申请人的id 关联学生表
     */
    private String notStudentId;
    /**
     * 非活动类别类型 社会工作 学术与科技 奖学金
     */
    private String notClass;
    /**
     * 审核状态 已通过 未通过 默认待处理
     */
    private String auditStatus;
    /**
     * 审核时间
     */
    private Date auditStatusDate;
    /**
     * 审核人名字
     */
    private String auditStatusName;
    /**
     *申请时间
     */
    private Date createDate;
    /**
     * 社会工作级别
     */
    private String workLevle;
    /**
     * 工作组织名称
     */
    private String organizationName;
    /**
     * 学生处职务名称
     */
    private String schoolworkName;
    /**
     * 班级职务名称
     */
    private String classworkName;
    /**
     * 学术科技(项目)类别
     */
    private String scienceClass;
    /**
     * 学术科技(项目)名称
     */
    private String scienceName;
    /**
     * 奖学金类别名字
     */
    private String shiptypeName;

    @Override
    public String toString() {
        return "Notactivity{" +
                "notid='" + notid + '\'' +
                ", notStudentId='" + notStudentId + '\'' +
                ", notClass='" + notClass + '\'' +
                ", auditStatus='" + auditStatus + '\'' +
                ", auditStatusDate=" + auditStatusDate +
                ", auditStatusName='" + auditStatusName + '\'' +
                ", createDate=" + createDate +
                ", workLevle='" + workLevle + '\'' +
                ", organizationName='" + organizationName + '\'' +
                ", schoolworkName='" + schoolworkName + '\'' +
                ", classworkName='" + classworkName + '\'' +
                ", scienceClass='" + scienceClass + '\'' +
                ", scienceName='" + scienceName + '\'' +
                ", shiptypeName='" + shiptypeName + '\'' +
                ", sciencePhoto='" + sciencePhoto + '\'' +
                '}';
    }

    /**
     * 学生科技截图
     */
    private String sciencePhoto;

    public String getNotid() {
        return notid;
    }

    public void setNotid(String notid) {
        this.notid = notid;
    }

    public String getNotStudentId() {
        return notStudentId;
    }

    public void setNotStudentId(String notStudentId) {
        this.notStudentId = notStudentId;
    }

    public String getNotClass() {
        return notClass;
    }

    public void setNotClass(String notClass) {
        this.notClass = notClass;
    }

    public String getAuditStatus() {
        return auditStatus;
    }

    public void setAuditStatus(String auditStatus) {
        this.auditStatus = auditStatus;
    }

    public Date getAuditStatusDate() {
        return auditStatusDate;
    }

    public void setAuditStatusDate(Date auditStatusDate) {
        this.auditStatusDate = auditStatusDate;
    }

    public String getAuditStatusName() {
        return auditStatusName;
    }

    public void setAuditStatusName(String auditStatusName) {
        this.auditStatusName = auditStatusName;
    }

    public Date getCreateDate() {
        return createDate;
    }

    public void setCreateDate(Date createDate) {
        this.createDate = createDate;
    }

    public String getWorkLevle() {
        return workLevle;
    }

    public void setWorkLevle(String workLevle) {
        this.workLevle = workLevle;
    }

    public String getOrganizationName() {
        return organizationName;
    }

    public void setOrganizationName(String organizationName) {
        this.organizationName = organizationName;
    }

    public String getSchoolworkName() {
        return schoolworkName;
    }

    public void setSchoolworkName(String schoolworkName) {
        this.schoolworkName = schoolworkName;
    }

    public String getClassworkName() {
        return classworkName;
    }

    public void setClassworkName(String classworkName) {
        this.classworkName = classworkName;
    }

    public String getScienceClass() {
        return scienceClass;
    }

    public void setScienceClass(String scienceClass) {
        this.scienceClass = scienceClass;
    }

    public String getScienceName() {
        return scienceName;
    }

    public void setScienceName(String scienceName) {
        this.scienceName = scienceName;
    }

    public String getShiptypeName() {
        return shiptypeName;
    }

    public void setShiptypeName(String shiptypeName) {
        this.shiptypeName = shiptypeName;
    }

    public String getSciencePhoto() {
        return sciencePhoto;
    }

    public void setSciencePhoto(String sciencePhoto) {
        this.sciencePhoto = sciencePhoto;
    }
}
