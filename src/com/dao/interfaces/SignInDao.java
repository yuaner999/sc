package com.dao.interfaces;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

/**
 * 签到
 * @author hong
 * Created by admin on 2016/9/8.
 */
@Repository
public interface SignInDao {
    /**
     * 传入活动申请ID的集合，批量签到
     * @param applist
     * @return
     */
    int signInByList(@Param("applist")List<String > applist);

    /**
     * 根据活动申请ID签到
     * @param id
     * @return
     */
    int signInById(String id);
}
