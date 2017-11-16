package com.dao.interfaces;

import com.model.ActivityQuery;
import com.model.Organization;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Map;

/**
 * Created by wd on 2016/9/9.
 */
@Repository
public interface OrganizationDao {
    /**
     * 批量添加职务
     * @param list
     * @return
     */
    int saveorganization(List<Organization> list);

}
