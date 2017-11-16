package com.model;

import java.sql.Date;

/**
 * Created by shaowen on 2016/10/19.
 */
public class Team {
    /**
     * 团队id
     */
    private  String teamId;
    /**
     * 团队名称
     */
    private  String teamName;
    /**
     * 团队创建日期
     */
    private Date teamCreateDate;
    /**
     * 关联的活动id
     */
    private  String teamActivityId;

    public String getTeamId() {
        return teamId;
    }

    public void setTeamId(String teamId) {
        this.teamId = teamId;
    }

    public String getTeamName() {
        return teamName;
    }

    public void setTeamName(String teamName) {
        this.teamName = teamName;
    }

    public Date getTeamCreateDate() {
        return teamCreateDate;
    }

    public void setTeamCreateDate(Date teamCreateDate) {
        this.teamCreateDate = teamCreateDate;
    }

    public String getTeamActivityId() {
        return teamActivityId;
    }

    public void setTeamActivityId(String teamActivityId) {
        this.teamActivityId = teamActivityId;
    }

    @Override
    public String toString() {
        return "team{" +
                "teamId='" + teamId + '\'' +
                ", teamName='" + teamName + '\'' +
                ", teamCreateDate='" + teamCreateDate + '\'' +
                ", teamActivityId='" + teamActivityId + '\'' +
                '}';
    }
}
