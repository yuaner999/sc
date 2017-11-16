/*
*Created by liulei on 2016-07-26.
*/
package com.Services.interfaces;

import java.util.Map;

/**
 * Created by liulei on 2016-07-26.
 */
public interface WeChatUserService {

    /**
     * 判断当前用户是否存在
     * @param openid
     * @return
     */
    Map<String ,Object> getNowUser(String openid);

    /**
     * 添加新的微信用户
     * @param user
     * @return
     */
    int addWeChatStudent(Map<String, String> student);

}
