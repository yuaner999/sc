/*
*Created by liulei on 2016/3/19.
*/
package com.interceptors;

import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.List;

/**
 * Created by liulei on 2016/3/19.
 */
public class PrivilegeInterceptor extends HandlerInterceptorAdapter {
    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {

    return true;
//        String uri = request.getRequestURI();//请求路径
//
//        //不需要拦截的请求路径
//        if(uri.contains("No_Intercept")){
//            return true;
//        }
//        if(uri.contains("/font")){
//            return true;
//        }
//        if(uri.contains("/Front")){
//            return true;
//        }
//        if(uri.contains("/jsons")){
//            return true;
//        }
//        if(uri.contains("studentinfoeditconfig")){
//            return true;
//        }
//        if(uri.contains("/generatepdf")){
//            return true;
//        }
//        //不需要拦截的请求路径
//        if(uri.contains("/Login/")){
//            return true;
//        }
//        if(uri.contains("applycationForStudentCard")){
//            return true;
//        }
//        if(uri.equals("/Login/SystemLogin.form")||uri.equals("/views/admin/login.form")||uri.equals("/views/admin/menu.form")){
//            return true;
//        }
//        if(uri.equals("/font/index.form")||uri.equals("/views/admin/login.form")||uri.equals("/views/admin/menu.form")){
//            return true;
//        }
//        if(uri.equals("/Login/EditPassword.form")||uri.equals("/views/admin/sysaboutnavy.form")||uri.equals("/Login/ExitLogin.form")){
//            return true;
//        }
//        if(uri.equals("/Login/SendEmail.form")||uri.equals("/Login/FontRegist.form")||uri.equals("/Login/FontLogin.form")){
//            return true;
//        }
//
//
//
//        //后台登录拦截，如果是超级管理员，开放所有权限
//        String loginId = (String) request.getSession().getAttribute("loginId");
//        if(loginId!=null && loginId.equals("1f97b97e-a665-4d46-9ea6-59b1cbfa3873")){
//            return true;
//        }
//        //后台菜单权限
//        String nowmenu = "";
//        if(request.getParameter("moduleType")==null){
//            nowmenu = (String) request.getSession().getAttribute("nowmenu");
//        }else {
//            nowmenu = request.getParameter("moduleType");
//        }
//        List<String> rolemenuId = (List<String>) request.getSession().getAttribute("rolemenuId");
//        if(rolemenuId!=null && rolemenuId.contains(nowmenu)){
//            return true;
//        }
//        return false;
    }
}
