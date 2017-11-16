package com.controllers;

import com.Services.interfaces.BlogrollerService;
import com.model.DataForDatagrid;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.List;
import java.util.Map;

/**
 * Created by admin on 2016/8/18.
 */
@Controller
@RequestMapping("/jsons")
public class BlogrollController {
        @Autowired
        private BlogrollerService blogrollerService;
        @RequestMapping("/loadblogrollInfo1")
        @ResponseBody
        public DataForDatagrid loadMemberShip(){
            DataForDatagrid data=new DataForDatagrid();
            List<Map<String ,String > >  list = blogrollerService.loadblogrollInfo();
            data.setDatas(list);
            return data;
        }
    }

