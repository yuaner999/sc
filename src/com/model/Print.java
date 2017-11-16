package com.model;

import java.sql.Date;

/**
 * Created by shaowen on 2016/11/3.
 */
public class Print {
    private String printId;
    private String studentId;
    private String printAuditstatus;
    private Date printAuditdate;
    private String printStatus;
    private Date printDate;
    private Date createDate;
    private String studentPhone;
    private String studentName;
    private String stuClassName;

    public String getPrintId() {
        return printId;
    }

    public void setPrintId(String printId) {
        this.printId = printId;
    }

    public String getStudentId() {
        return studentId;
    }

    public void setStudentId(String studentId) {
        this.studentId = studentId;
    }

    public String getPrintAuditstatus() {
        return printAuditstatus;
    }

    public void setPrintAuditstatus(String printAuditstatus) {
        this.printAuditstatus = printAuditstatus;
    }

    public Date getPrintAuditdate() {
        return printAuditdate;
    }

    public void setPrintAuditdate(Date printAuditdate) {
        this.printAuditdate = printAuditdate;
    }

    public String getPrintStatus() {
        return printStatus;
    }

    public void setPrintStatus(String printStatus) {
        this.printStatus = printStatus;
    }

    public Date getPrintDate() {
        return printDate;
    }

    public void setPrintDate(Date printDate) {
        this.printDate = printDate;
    }

    public Date getCreateDate() {
        return createDate;
    }

    public void setCreateDate(Date createDate) {
        this.createDate = createDate;
    }

    public String getStudentPhone() {
        return studentPhone;
    }

    public void setStudentPhone(String studentPhone) {
        this.studentPhone = studentPhone;
    }

    public String getStudentName() {
        return studentName;
    }

    public void setStudentName(String studentName) {
        this.studentName = studentName;
    }

    public String getStuClassName() {
        return stuClassName;
    }

    public void setStuClassName(String stuClassName) {
        this.stuClassName = stuClassName;
    }

    @Override
    public String toString() {
        return "Print{" +
                "printId='" + printId + '\'' +
                ", studentId='" + studentId + '\'' +
                ", printAuditstatus='" + printAuditstatus + '\'' +
                ", printAuditdate=" + printAuditdate +
                ", printStatus='" + printStatus + '\'' +
                ", printDate=" + printDate +
                ", createDate=" + createDate +
                ", studentPhone='" + studentPhone + '\'' +
                ", studentName='" + studentName + '\'' +
                ", stuClassName='" + stuClassName + '\'' +
                '}';
    }
}
