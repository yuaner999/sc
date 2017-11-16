package com.Services.interfaces;

import com.model.Print;

import java.util.List;
import java.util.Map;

/**
 * Created by admin on 2016/9/20.
 */
public interface Print_backService {
    /**
     * 加载所有的打印申请，如果有学号，则只加载该学号的申请
     * @param map
     * @return
     */
    List<Print> getPrint(Map<String,Object> map, int pagenum, int rows);
    /**
     * 修改审核状态
     * @param printid  打印申请ID
     * @param status   状态文本
     * @return
     */
    int changeAuditStatus(String printid,String status);

    /**
     * 修改打印状态   打印状态只有  已打印  和 空值   空值即表示未打印
     * @param printid 打印申请ID
     * @return
     */
    int changePrintStatus(String printid);

    /***
     * 跟新排序
     * @param activiyId1
     * @param activiryId2
     * @param studentid
     */
    int updateOrderId(String activiyId1,String activiryId2, String studentid );
}
