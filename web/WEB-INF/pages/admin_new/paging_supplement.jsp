<%--
  Created by IntelliJ IDEA.
  User: NEU
  Date: 2017/3/9
  Time: 9:59
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java"  pageEncoding="UTF-8" %>

<!--分页-->
<div class="pagingTurn">
    <div>
        <span class="turn_left" onclick="turn_left()"></span> 第
        <input class="currentPageNum" id="currentPageNum" type="text" value="1">页，共
        <span class="pageNum">1</span> 页
        <span class="turn_right" onclick="turn_right()"></span>
    </div>
    <div class="selectRows">
        <select id="rows" name="rows" onchange="select_box(1)">
            <option value="20">20</option>
            <option value="50">50</option>
            <option value="100" selected>100</option>
            <option value="200">200</option>
        </select>
    </div>

    <div>
        显示<span class="pageNum"></span>到<span class="pageNum"></span>，共<span class="pageNum"></span>条记录
    </div>
</div>
