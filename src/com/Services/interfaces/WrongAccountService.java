package com.Services.interfaces;

/**
 * Created by admin on 2016/10/6.
 */
public interface WrongAccountService {
    /**
     * 加载账号锁定的状态，只加载30分钟以内的；
     * @param account
     * @return
     */
    String loadAccountLocked(String account);
    /**
     * 添加错误登陆记录
     * @param account
     * @return
     */
    int addWrongAccount(String account, String islocked);

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
