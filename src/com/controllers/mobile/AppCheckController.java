package com.controllers.mobile;

import com.Services.interfaces.CheckService;
import com.model.DataForDatagrid;
import com.model.ResultData;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * 类的描述
 *
 * @Author lirf
 * @Date 2017/6/8 10:58
 */
@Controller
@RequestMapping("/AppCheck")
public class AppCheckController {
    @Autowired
    private CheckService checkService;

    @RequestMapping(value = "/checkReportAgain", method = RequestMethod.POST)
    @ResponseBody
    public DataForDatagrid checkReportAgain(HttpServletRequest request, String informStudentId, String informApplyId, String infomTeamID) {
        DataForDatagrid data = new DataForDatagrid();
        HttpSession session = request.getSession();
        String studentid = (String) session.getAttribute("studentid");
        String informType = "";
        if (studentid.equals(informStudentId)) {
            informType = "质疑";
        } else {
            informType = "举报";
        }
        Map<String, String> map = new HashMap<>();
        map.put("informByStudentId", studentid);
        map.put("informType", informType);
        map.put("informApplyId", informApplyId);
        List<Map<String, String>> list = null;

        if (infomTeamID != null && !"".equals(infomTeamID)) {
            List nlist = new ArrayList<>();
            nlist = checkService.studentIdByteamID(infomTeamID);
            String stuId = "";
            System.out.println();
            if (nlist.size() > 0) {
                stuId = (String) nlist.get(0);
            }
            map.put("informStudentId", stuId);
            list = checkService.checkReportAgain(map);
        } else {
            map.put("informStudentId", informStudentId);
            list = checkService.checkReportAgain(map);
        }
        data.setDatas(list);
        return data;
    }

    @RequestMapping(value = "/insertReportInfo", method = RequestMethod.POST)
    @ResponseBody
    public ResultData insertReportInfo(HttpSession session, String informContent, String informStudentId,
                                       String informApplyId, String infomTeamID, String informTel, String acttitle, String actaward) {
        ResultData re = new ResultData();
        String studentid = (String) session.getAttribute("studentid");
        String informType = "";
        if (studentid.equals(informStudentId)) {
            informType = "质疑";
        } else {
            informType = "举报";
        }
        Map<String, String> map = new HashMap<>();
        map.put("informByStudentId", studentid);
        map.put("informType", informType);
        map.put("informContent", informContent);
        map.put("informApplyId", informApplyId);
        map.put("informTel", informTel);
        map.put("acttitle", acttitle);
        map.put("actaward", actaward);
        for (String s : map.keySet()) {
            map.putIfAbsent(s, "");
        }
        int i = -1;
        if (infomTeamID != null && !"".equals(infomTeamID)) {
            List list = new ArrayList<>();
            System.out.println();
            list = checkService.studentIdByteamID(infomTeamID);
            for (int j = 0; j < list.size(); j++) {
                String sId = (String) list.get(j);
                map.put("informStudentId", sId);
                i = checkService.insertReportInfo(map);
            }

        } else {
            map.put("informStudentId", informStudentId);
            i = checkService.insertReportInfo(map);
        }
        re.setStatusByDBResult(i);
        return re;
    }
}
