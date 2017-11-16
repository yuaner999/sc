package com.Services.interfaces;

import com.model.ScholarShip;

import java.util.List;

/**
 * Created by guoqiang on 2016/11/11.
 */
public interface ScholarshipService {
    //批量添加获得奖学金信息
    int addscholarship(List<ScholarShip> list);
}
