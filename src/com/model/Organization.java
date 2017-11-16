package com.model;

/**
 * Created by shaowen on 2016/11/19.
 */
public class Organization {
    private String orgid;
    private String orgclass;
    private String orglevel;
    private String orgname;
    private String orgcollege;
    private String workname;
    private String worklevel;

    public String getOrgid() {
        return orgid;
    }

    public void setOrgid(String orgid) {
        this.orgid = orgid;
    }

    public String getOrgclass() {
        return orgclass;
    }

    public void setOrgclass(String orgclass) {
        this.orgclass = orgclass;
    }

    public String getOrglevel() {
        return orglevel;
    }

    public void setOrglevel(String orglevel) {
        this.orglevel = orglevel;
    }

    public String getOrgname() {
        return orgname;
    }

    public void setOrgname(String orgname) {
        this.orgname = orgname;
    }

    public String getOrgcollege() {
        return orgcollege;
    }

    public void setOrgcollege(String orgcollege) {
        this.orgcollege = orgcollege;
    }

    public String getWorkname() {
        return workname;
    }

    public void setWorkname(String workname) {
        this.workname = workname;
    }

    public String getWorklevel() {
        return worklevel;
    }

    public void setWorklevel(String worklevel) {
        this.worklevel = worklevel;
    }

    @Override
    public String toString() {
        return "Organization{" +
                "orgid='" + orgid + '\'' +
                ", orgclass='" + orgclass + '\'' +
                ", orglevel='" + orglevel + '\'' +
                ", orgname='" + orgname + '\'' +
                ", orgcollege='" + orgcollege + '\'' +
                ", workname='" + workname + '\'' +
                ", worklevel='" + worklevel + '\'' +
                '}';
    }
}
