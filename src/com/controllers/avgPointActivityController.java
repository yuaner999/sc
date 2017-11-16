package com.controllers;

import com.Services.interfaces.AvgPointService;
import com.Services.interfaces.BlogrollerService;
import com.github.pagehelper.Page;
import com.model.DataForDatagrid;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import java.util.List;
import java.util.Map;

/**
 * Created by  sw on 2016/8/18.
 */
@Controller
@RequestMapping("/jsons")
public class avgPointActivityController {
        @Autowired
        private AvgPointService avgPointService;
        @RequestMapping("/loadactivityAVG")
        @ResponseBody
        public DataForDatagrid loadactivityAVG(HttpServletRequest request){
            String srows=request.getParameter("rows");
            String spage=request.getParameter("page");
            String sqlStr=request.getParameter("sqlStr");
            int rows=(srows==null || srows.equals(""))? 10:Integer.parseInt(srows);
            int page=(spage==null || spage.equals(""))? 1:Integer.parseInt(spage);
            DataForDatagrid data=new DataForDatagrid();
            List<Map<String ,String > >  list = avgPointService.loadavgPointActivity(page,rows,sqlStr);
            data.setDatas(list);
            data.setTotal((int)((Page)list).getTotal());
            return data;
        }
    }

