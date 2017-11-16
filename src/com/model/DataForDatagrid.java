package com.model;

import java.io.Serializable;
import java.math.BigDecimal;
import java.util.List;

/**
 * easyUI中datagrid等需要的json格式
 * @author hong
 * Created by admin on 2015/12/16.
 */
public class DataForDatagrid {
    private int total;
    private List rows;
    private List footer;

    public List getFooter() {
        return footer;
    }

    public void setFooter(List footer) {
        this.footer = footer;
    }

    public DataForDatagrid() {
    }

    public int getTotal() {
        return total;
    }

    public void setTotal(int total) {
        this.total = total;
    }

    public List<Object> getRows() {
        return rows;
    }

    public void setRows(List rows) {
        this.rows = rows;
    }

    public void setDatas(List list){
        this.rows=list;
        this.total=list.size();
    }

    @Override
    public String toString() {
        return "DataForDatagrid{" +
                "total=" + total +
                ", rows=" + rows +
                ", footer=" + footer +
                '}';
    }
}
