package com.Services.interfaces;

import java.util.List;

/**
 * Created by admin on 2016/9/8.
 */
public interface SignInService {
    /**
     * 传入活动申请ID的集合，批量签到
     * @param list
     * @return
     */
    int signInByList(List<String > list);

    /**
     * 根据活动申请ID签到
     * @param id
     * @return
     */
    int signInById(String id);
}
