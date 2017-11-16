package com.Services.impls;

import com.Services.interfaces.SignInService;
import com.dao.interfaces.SignInDao;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

/**
 * Created by admin on 2016/9/8.
 */
@Service
public class SignInServiceImpl implements SignInService {
    @Autowired
    private SignInDao signInDao;
    @Override
    @Transactional
    public int signInByList(List<String> list) {
        return signInDao.signInByList(list);
    }

    @Override
    @Transactional
    public int signInById(String id) {
        return signInDao.signInById(id);
    }
}
