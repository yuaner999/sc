package com.model;

/**
 * Created by guoqiang on 2016/11/19.
 */
public class Dict {
    private String dict_id;
    private String dict_key;
    private String dict_value;
    private String dict_mean;
    private String dict_score;
    private String signUpStatus;
    private String activityId;
    private String activityCredit;
    private String applyStudentId;
    private String worktime;

    public String getDict_score() {
        return dict_score;
    }

    public void setDict_score(String dict_score) {
        this.dict_score = dict_score;
    }

    public String getDict_id() {
        return dict_id;
    }

    public void setDict_id(String dict_id) {
        this.dict_id = dict_id;
    }

    public String getDict_key() {
        return dict_key;
    }

    public void setDict_key(String dict_key) {
        this.dict_key = dict_key;
    }

    public String getDict_value() {
        return dict_value;
    }

    public void setDict_value(String dict_value) {
        this.dict_value = dict_value;
    }

    public String getDict_mean() {
        return dict_mean;
    }

    public void setDict_mean(String dict_mean) {
        this.dict_mean = dict_mean;
    }

    public String getSignUpStatus() {
        return signUpStatus;
    }

    public void setSignUpStatus(String signUpStatus) {
        this.signUpStatus = signUpStatus;
    }

    public String getActivityId() {
        return activityId;
    }

    public void setActivityId(String activityId) {
        this.activityId = activityId;
    }

    public String getActivityCredit() {
        return activityCredit;
    }

    public void setActivityCredit(String activityCredit) {
        this.activityCredit = activityCredit;
    }

    public String getApplyStudentId() {
        return applyStudentId;
    }

    public void setApplyStudentId(String applyStudentId) {
        this.applyStudentId = applyStudentId;
    }

    public String getWorktime() {
        return worktime;
    }

    public void setWorktime(String worktime) {
        this.worktime = worktime;
    }
}
