package com.model;

import java.sql.Date;


public class SupplementApplyEntity {
    private String supStudentId;
    private Date takeDate;
    private String supActivityTitle;
    private String supPowers;
    private String supCredit;


    public String getSupStudentId() {
        return supStudentId;
    }

    public void setSupStudentId(String supStudentId) {
        this.supStudentId = supStudentId;
    }

    public Date getTakeDate() {
        return takeDate;
    }

    public void setTakeDate(Date takeDate) {
        this.takeDate = takeDate;
    }

    public String getSupActivityTitle() {
        return supActivityTitle;
    }

    public void setSupActivityTitle(String supActivityTitle) {
        this.supActivityTitle = supActivityTitle;
    }

    public String getSupPowers() {
        return supPowers;
    }

    public void setSupPowers(String supPowers) {
        this.supPowers = supPowers;
    }

    public String getSupCredit() {
        return supCredit;
    }

    public void setSupCredit(String supCredit) {
        this.supCredit = supCredit;
    }


}
