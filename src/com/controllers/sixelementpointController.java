package com.controllers;


import com.Services.interfaces.SixpointService;
import com.model.DataForDatagrid;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Set;

/**
 * Created by dskj012 on 2016/10/7.
 */
@Controller
@RequestMapping("/sixpoint")
public class sixelementpointController {
    @Autowired
    private SixpointService sixpointService;
    @RequestMapping(value = "/sixpoint")
    @ResponseBody
    public DataForDatagrid getsixpoint(HttpServletRequest request,String studentID) {
        DataForDatagrid data = new DataForDatagrid();
        Map<String, String[]> map = request.getParameterMap();//取出请求中所有传递过来的参数
        Map<String, String> newmap = new HashMap<>(36);
        newmap.put("studentID", studentID);
        Set<String> keys = map.keySet();
        for (String s : keys) {     //取中map中每个元素（数组）的第一个，并放到新的map中
            String[] value = map.get(s);
            if (value.length == 0) continue;
            newmap.put(s, value[0]);
        }
//        System.out.println(newmap);
        int rows = (newmap.get("rows") == null || newmap.get("rows").equals("")) ? 10 : Integer.parseInt(newmap.get("rows"));
        int pagenum = (newmap.get("page") == null || newmap.get("page").equals("")) ? 1 : Integer.parseInt(newmap.get("page"));
        List<Map<String, String>> sixpointlist = sixpointService.getsixpoint(newmap, rows, pagenum);

        /**
         * 遍历结果集合中map的六项能力key，判断如果分值大于100就给其赋值为100；
         * mapKeys数组为六项能力的key值；
         */
        String[] mapKeys = {"sibian", "zhixing", "biaoda", "lingdao", "chuangxin", "chuangye"};
        for (int i = 0; i < sixpointlist.size(); i++){
            for (int j = 0; j < mapKeys.length; j++) {
                String temp = String.valueOf( sixpointlist.get(i).get(mapKeys[j]) );
                if (temp != "" && Double.parseDouble(temp) > 100){
                    sixpointlist.get(i).put(mapKeys[j],"100") ;
                }
            }
        }
        data.setDatas(sixpointlist);
        return data;
    }
}
