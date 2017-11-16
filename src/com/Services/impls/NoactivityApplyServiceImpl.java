package com.Services.impls;

import com.Services.interfaces.NoactivityApplyService;
import com.dao.interfaces.NoactivityApplyDao;
import com.model.Notactivity;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;

/**
 * Created by shaowen on 2016/10/24.
 */
@Service
public class NoactivityApplyServiceImpl  implements NoactivityApplyService{
    @Autowired
    private NoactivityApplyDao noactivityApplyDao;
    @Override
    public int addBotactivity(Map<String, String> map) {
        return noactivityApplyDao.addNotactivity(map);
    }

    @Override
    public int addBotactivities(List<Notactivity> list) {
        return noactivityApplyDao.addBotactivities(list);
    }
}
