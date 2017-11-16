package com.controllers;

import com.common.utils.SpringUtils;
import com.dynamicspring.DynamicBeanLoader;
import org.springframework.context.support.AbstractApplicationContext;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.context.ContextLoader;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

/**
 * Created by liuzg on 2016/1/31.
 */
@Controller
public class SpringTestController {

    @RequestMapping("refresh")
    public void refresh(HttpServletRequest request, HttpServletResponse response) throws IOException {
        AbstractApplicationContext act = (AbstractApplicationContext) ContextLoader.getCurrentWebApplicationContext();
        act.refresh();
        response.getOutputStream().println("refresh complete!");
    }

}
