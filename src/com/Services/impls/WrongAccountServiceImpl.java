package com.Services.impls;

import com.Services.interfaces.WrongAccountService;
import com.dao.interfaces.WrongAccountDao;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

/**
 * Created by admin on 2016/10/6.
 */
@Service
public class WrongAccountServiceImpl implements WrongAccountService {
    @Autowired
    private WrongAccountDao wrongAccountDao;

    @Override
    public String loadAccountLocked(String account) {
        return wrongAccountDao.loadAccountLocked(account);
    }

    @Override
    public int addWrongAccount(String account,String islocked) {
        return wrongAccountDao.addWrongAccount(account,islocked);
    }

    @Override
    public int loadWrongTimes(String account) {
        return wrongAccountDao.loadWrongTimes(account);
    }

    @Override
    public int delWrongLogs(String account) {
        return wrongAccountDao.delWrongLogs(account);
    }
}
