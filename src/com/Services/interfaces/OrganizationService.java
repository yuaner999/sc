package com.Services.interfaces;

import com.model.ActivityQuery;
import com.model.Organization;

import java.util.List;
import java.util.Map;

/**
 * Created by wd on 2016/9/9.
 */
public interface OrganizationService {
    /**
     * 批量添加职务
     * @param list
     * @return
     */
    int saveorganization(List<Organization> list);

}
