package com.Services.impls;

import com.Services.interfaces.ActivitiesService;
import com.Services.interfaces.OrganizationService;
import com.dao.interfaces.ActivitiesDao;
import com.dao.interfaces.OrganizationDao;
import com.github.pagehelper.PageHelper;
import com.model.ActivityQuery;
import com.model.Organization;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Created by wd on 2016/9/9.
 */
@Service
public class OrganizationServiceImpl implements OrganizationService{
    @Autowired
    private OrganizationDao organizationDao;
    @Override
    public int saveorganization(List<Organization> list) {
        return organizationDao.saveorganization(list);
    }
}
