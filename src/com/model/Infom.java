package com.model;

/**
 * Created by guoqiang on 2016/9/18.
 */

import java.sql.Date;

/**
 * 举报信息
 */
public class Infom {
    private String informId;
    private String informStudentId;
    private String informApplyId;
    private String informByStudentId;
    private String informContent;
    private Date informDate;
    private String informAuditStatus;
    private Date informAuditDate;
    private String informType;

    public String getInformId() {
        return informId;
    }

    public void setInformId(String informId) {
        this.informId = informId;
    }

    public String getInformStudentId() {
        return informStudentId;
    }

    public void setInformStudentId(String informStudentId) {
        this.informStudentId = informStudentId;
    }

    public String getInformApplyId() {
        return informApplyId;
    }

    public void setInformApplyId(String informApplyId) {
        this.informApplyId = informApplyId;
    }

    public String getInformByStudentId() {
        return informByStudentId;
    }

    public void setInformByStudentId(String informByStudentId) {
        this.informByStudentId = informByStudentId;
    }

    public String getInformContent() {
        return informContent;
    }

    public void setInformContent(String informContent) {
        this.informContent = informContent;
    }

    public Date getInformDate() {
        return informDate;
    }

    public void setInformDate(Date informDate) {
        this.informDate = informDate;
    }

    public String getInformAuditStatus() {
        return informAuditStatus;
    }

    public void setInformAuditStatus(String informAuditStatus) {
        this.informAuditStatus = informAuditStatus;
    }

    public Date getInformAuditDate() {
        return informAuditDate;
    }

    public void setInformAuditDate(Date informAuditDate) {
        this.informAuditDate = informAuditDate;
    }

    public String getInformType() {
        return informType;
    }

    public void setInformType(String informType) {
        this.informType = informType;
    }
}
