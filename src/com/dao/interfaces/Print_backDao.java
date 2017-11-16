package com.dao.interfaces;

import com.model.Print;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Map;

/**
 * 打印管理 后台页面
 * @author hong
 * Created by admin on 2016/9/20.
 */
@Repository
public interface Print_backDao {
    /**
     * 加载所有的打印申请，如果有学号，则只加载该学号的申请
     * @param
     * @return
     */
    List<Print> getPrint(Map<String,Object> map);

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

    /**
     * 排序存入数据库
     * @param activiyId1
     * @param activiryId2
     * @param studentid
     * @return
     */
    int updateOrderId(@Param("activiyId1") String activiyId1,@Param("activiryId2") String activiryId2,@Param("studentid") String studentid);

}
