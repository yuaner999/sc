package com.dao.interfaces;

import com.model.ScholarShip;
import org.springframework.stereotype.Repository;

import java.util.List;

/**
 * Created by guoqiang on 2016/11/11.
 */
@Repository
public interface ScholarshipDao {

     int addscholarship(List<ScholarShip> list);
}
