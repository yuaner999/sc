package com.dao.interfaces;

import org.springframework.stereotype.Repository;

/**
 * 登陆错误记录
 * @author hong
 * Created by admin on 2016/10/6.
 */
@Repository
public interface WrongAccountDao {
    /**
     * 加载账号锁定的状态，只加载30分钟以内的；
     * @param account
     * @return
     */
    String loadAccountLocked(String account);
    /**
     * 添加错误登陆记录
     * @param account
     * @param isLocked  是否锁定   0-未锁定    1-锁定
     * @return
     */
    int addWrongAccount(String account, String isLocked);

    /**
     * 加载错误的次数
     * @param account
     * @return
     */
    int loadWrongTimes(String account);

    /**
     * 清除某用户的错误次数（提前解除锁定）
     * @param account
     * @return
     */
    int delWrongLogs(String account);
}
