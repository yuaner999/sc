package com.dao.interfaces;

import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Map;

/**
 * Created by admin on 2016/8/18.
 */
@Repository
public interface BlogrollDao {
    List<Map<String,String>> loadblogrollInfo1();
}
