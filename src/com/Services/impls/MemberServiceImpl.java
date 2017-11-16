package com.Services.impls;

import com.Services.interfaces.MemberService;
import com.dao.interfaces.MemberDao;
import com.github.pagehelper.PageHelper;
import com.model.Member;
import com.model.Member_Decoding;
import com.model.Member_Encoding;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;


import java.util.List;
import java.util.Map;

/**
 * @author hong
 * Created by admin on 2016/7/26.
 */
@Service
public class MemberServiceImpl implements MemberService {
    @Autowired
    private MemberDao memberDao;
    @Override
    public int saveMembers(List<Member> list) {
        return memberDao.saveMembers(list);
    }

    @Override
    public int deleteMoreMember(List<String> list) {
        return memberDao.deleteMoreMember(list);
    }

    @Override
    public int deleteMemberByStudentId(String memberStudentId) {return memberDao.deleteMemberByStudentId(memberStudentId); }

    @Override
    public List<Member_Decoding> loadMemberInfo(Map<String, String> map,int pagenum,int pagerows) {
        PageHelper.startPage(pagenum,pagerows);
        return memberDao.loadMemberInfo(map);
    }

    @Override
    public int addMember(Member_Encoding menber) {
        return memberDao.addMember(menber);
    }

    @Override
    public List<Member_Decoding> loadMemberShip(String studentid) {
        return memberDao.loadMemberShip(studentid);
    }

    @Override
    public int editStudentMember(Member_Encoding member) {
        return memberDao.editStudentMember(member);
    }


}
