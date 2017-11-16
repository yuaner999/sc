package com.Services.interfaces;

import java.util.List;
import java.util.Map;

/**
 * Created by admin on 2016/8/18.
 */
public interface BlogrollerService {
    /**
     * 加载友情链接的信息
     * @return
     */
    List<Map<String,String>> loadblogrollInfo();
}
