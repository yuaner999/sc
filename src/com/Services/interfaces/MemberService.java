package com.Services.interfaces;


import com.model.Member;
import com.model.Member_Decoding;
import com.model.Member_Encoding;

import java.util.List;
import java.util.Map;

/**
 * @author hong
 * Created by admin on 2016/7/26.
 */
public interface MemberService {
    /**
     * 批量添加
     * @param list
     * @return
     */
    int saveMembers(List<Member> list);

    /**
     * 批量删除
     * @param list
     * @return
     */
    int deleteMoreMember(List<String> list);

    /**
     *加载家庭成员信息
     * @param map 多重条件查询的条件集合
     * @return
     */
    List<Member_Decoding> loadMemberInfo(Map<String, String> map, int pagenum, int pagerows);

    /**
     * 添加一条家庭成员信息
     * @param menber
     * @return
     */
    int addMember(Member_Encoding menber);

    /**
     * 加载家庭成员信息
     * @param studentid
     * @return
     */
    List<Member_Decoding> loadMemberShip(String studentid);
    /**
     * 修改其中的一条信息(按成员的id)
     * @param member
     * @return
     */
    int editStudentMember(Member_Encoding member);
    /**
     *根据学生的id删除该学生的所有家庭成员信息
     * @param memberStudentId
     * @return
     */
    int deleteMemberByStudentId(String memberStudentId);
}
