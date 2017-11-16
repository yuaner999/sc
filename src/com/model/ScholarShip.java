package com.model;

/**
 * Created by guoqiang on 2016/11/11.
 */
public class ScholarShip {
    //奖学金名称
    private String shipName;
    //获得奖学金学生学号
    private  String supStudentId;
    //奖学金年份
    private String takeDate;

    public String getShipName() {
        return shipName;
    }

    public void setShipName(String shipName) {
        this.shipName = shipName;
    }

    public String getSupStudentId() {
        return supStudentId;
    }

    public void setSupStudentId(String supStudentId) {
        this.supStudentId = supStudentId;
    }

    public String getTakeDate() {
        return takeDate;
    }

    public void setTakeDate(String takeDate) {
        this.takeDate = takeDate;
    }

    @Override
    public String toString() {
        return "ScholarShip{" +
                "shipName='" + shipName + '\'' +
                ", supStudentId='" + supStudentId + '\'' +
                ", takeDate='" + takeDate + '\'' +
                '}';
    }
}
