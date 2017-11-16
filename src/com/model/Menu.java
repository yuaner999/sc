/*
*Created by liulei on 2016/4/26.
*/
package com.model;

import java.util.ArrayList;
import java.util.List;

/**
 * Created by liulei on 2016/4/26.
 */
public class Menu {

    private String sysmenuid;
    private String sysmenuname;
    private String sysmenuurl;
    private String parentmenuid;
    private int sort;
    List<Menu> childMenu;

    public Menu() {
        sysmenuid = "";
        sysmenuname = "";
        sysmenuurl = "";
        parentmenuid = "";
        sort = 1;
        childMenu = new ArrayList<Menu>();
    }

    public Menu(String sysmenuid, String sysmenuname, String sysmenuurl, String parentmenuid, int sort) {
        this.sysmenuid = sysmenuid;
        this.sysmenuname = sysmenuname;
        this.sysmenuurl = sysmenuurl;
        this.parentmenuid = parentmenuid;
        this.sort = sort;
    }

    public Menu(String sysmenuid, String sysmenuname, String sysmenuurl, String parentmenuid, int sort, List<Menu> childMenu) {
        this.sysmenuid = sysmenuid;
        this.sysmenuname = sysmenuname;
        this.sysmenuurl = sysmenuurl;
        this.parentmenuid = parentmenuid;
        this.sort = sort;
        this.childMenu = childMenu;
    }

    public String getSysmenuid() {
        return sysmenuid;
    }

    public void setSysmenuid(String sysmenuid) {
        this.sysmenuid = sysmenuid;
    }

    public String getSysmenuname() {
        return sysmenuname;
    }

    public void setSysmenuname(String sysmenuname) {
        this.sysmenuname = sysmenuname;
    }

    public String getSysmenuurl() {
        return sysmenuurl;
    }

    public void setSysmenuurl(String sysmenuurl) {
        this.sysmenuurl = sysmenuurl;
    }

    public String getParentmenuid() {
        return parentmenuid;
    }

    public void setParentmenuid(String parentmenuid) {
        this.parentmenuid = parentmenuid;
    }

    public int getSort() {
        return sort;
    }

    public void setSort(int sort) {
        this.sort = sort;
    }

    public List<Menu> getChildMenu() {
        return childMenu;
    }

    public void setChildMenu(List<Menu> childMenu) {
        this.childMenu = childMenu;
    }

    @Override
    public String toString() {
        return "Menu{" +
                "sysmenuid='" + sysmenuid + '\'' +
                ", sysmenuname='" + sysmenuname + '\'' +
                ", sysmenuurl='" + sysmenuurl + '\'' +
                ", parentmenuid='" + parentmenuid + '\'' +
                ", sort=" + sort +
                ", childMenu=" + childMenu +
                '}';
    }
}
