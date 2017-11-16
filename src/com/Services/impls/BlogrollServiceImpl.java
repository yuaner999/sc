package com.Services.impls;

import com.Services.interfaces.BlogrollerService;
import com.dao.interfaces.BlogrollDao;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;

/**
 * Created by admin on 2016/8/18.
 */
@Service
public class BlogrollServiceImpl implements BlogrollerService{
    @Autowired
    private BlogrollDao blogrollDao;

    @Override
    public List<Map<String,String>> loadblogrollInfo() {
        return blogrollDao.loadblogrollInfo1();
    }
}
