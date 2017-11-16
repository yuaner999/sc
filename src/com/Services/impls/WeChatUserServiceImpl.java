/*
*Created by liulei on 2016-07-26.
*/
package com.Services.impls;

import com.Services.interfaces.WeChatUserService;
import com.dao.interfaces.WeChatUserDao;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Map;

/**
 * Created by liulei on 2016-07-26.
 */
@Service
public class WeChatUserServiceImpl implements WeChatUserService {

    @Autowired
    private WeChatUserDao weChatUserDao;

    @Override
    public Map<String, Object> getNowUser(String openid) {
        return weChatUserDao.getNowUser(openid);
    }

    @Override
    public int addWeChatStudent(Map<String, String> student) {
        return weChatUserDao.addWeChatStudent(student);
    }
}
