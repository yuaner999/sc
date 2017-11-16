package com.processors;

import com.superstatemachine.ProcessorBase;
import com.superstatemachine.web.WebStatemachineContext;

import javax.servlet.http.HttpServletRequest;

/**
 * Created by liuzg on 2016/1/31.
 */
public class JspPageProcessor extends ProcessorBase<WebStatemachineContext> {


    @Override
    public void execute(WebStatemachineContext context) {
        HttpServletRequest request = context.getRequest();
        String jspfile = request.getRequestURI().substring(request.getContextPath().length()).substring("views/".length()).replace(".form","");
        context.getModelAndView().setViewName(jspfile);
    }
}
