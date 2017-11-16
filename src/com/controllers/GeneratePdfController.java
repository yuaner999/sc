package com.controllers;


import com.Services.interfaces.GenerPdfService;
import com.lowagie.text.DocumentException;
import com.lowagie.text.pdf.BaseFont;
import com.model.ResultData;
import freemarker.template.Configuration;
import freemarker.template.Template;
import freemarker.template.TemplateException;
import freemarker.template.Version;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.xhtmlrenderer.pdf.ITextFontResolver;
import org.xhtmlrenderer.pdf.ITextRenderer;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.OutputStream;
import java.io.StringWriter;
import java.io.Writer;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;
import java.util.Set;

/**
 * 生成pdf文档
 *
 * @author hong
 *         Created by admin on 2016/8/5.
 */
@Controller
@RequestMapping("/generatepdf")
public class GeneratePdfController {
    @Autowired
    private GenerPdfService generPdfService;
    private Configuration cfg = null;
    public GeneratePdfController() {
        // 创建一个FreeMarker实例
        cfg = new Configuration(new Version(2, 3, 23));
    }

    /**
     * 处理学生证补办的请求
     * @param request
     * @param from 从哪里发来的请求（主要是为了区分学生证补办还是在读证明）
     * @return
     */
    @RequestMapping("/generatepdf")
    public void studentcard(HttpServletRequest request,HttpServletResponse response,String from){
        try {
            Map<String,String[]> map=request.getParameterMap();
            Map<String ,String > params=new HashMap<>();
            Set<String > keys=map.keySet();
            for(String s:keys){
                String value=map.get(s)[0];
                if(value==null || value.equals(""))
                    response.sendRedirect("/views/font/defeat.form?msg=服务器获取到的数据有空值！请联系管理员或稍后再试");
                params.put(s,value);
            }
            SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd");
            String[] datestr=sdf.format(new Date()).split("-");
            params.put("yyyy",datestr[0]);
            params.put("mm",datestr[1]);
            params.put("dd",datestr[2]);
            String tempName="";
            int i=0;
            switch (from){
                case "studnetcard":
                    tempName="studentcard.ftl";
                    i=generPdfService.saveStudentCard(params);
                    break;
                case "instudy":
                    tempName="instudy.ftl";
                    i=generPdfService.saveInStudyProve(params);
                    break;
            }
            if(i<=0) response.sendRedirect("/views/font/defeat.form?msg=保存数据失败！请联系管理员或稍后再试");
            GenerPdf(request,response,tempName,params);
        } catch (Exception e) {
            e.printStackTrace();
            try {
                response.sendRedirect("/views/font/defeat.form?msg=生成pdf过程中发生异常！请联系管理员或稍后再试");
            } catch (IOException e1) {
                e1.printStackTrace();
            }
        }
    }

    /**
     * 生成Pdf并返回
     * @param request
     * @param response
     * @param tempName  模板的名字
     * @param map       模板的数据
     */
    private void GenerPdf(HttpServletRequest request,HttpServletResponse response,String tempName,Map<String ,String > map) throws IOException, TemplateException, DocumentException {
        //设置模板文件的位置
        cfg.setServletContextForTemplateLoading(request.getServletContext(), "/templates");
        //加载模板文件
        Template t = cfg.getTemplate(tempName);
        // 使用text/html MIME-type
        response.setContentType("text/html; charset=utf-8");
        response.setContentType("application/pdf");
        String name=new SimpleDateFormat("yyyyMMddHHmmss").format(new Date());
        response.setHeader("Content-Disposition", "inline; filename="+name+".pdf");
        OutputStream out = response.getOutputStream();
        // 合并数据模型和模板，并将结果输出到out中
        String basePath = request.getSession().getServletContext().getRealPath("/");
//        System.out.println(basePath);
        StringWriter stringWriter = new StringWriter();
        //生成html到字符串流中
        t.process(map, stringWriter);
        //从流中取出html的字符串
        String htmlStr = stringWriter.toString();
        //创建pdf生成器实例
        ITextRenderer renderer = new ITextRenderer();
        //以字符串的形式加载文档
        renderer.setDocumentFromString(htmlStr);
        // 解决中文问题
        ITextFontResolver fontResolver = renderer.getFontResolver();
        fontResolver.addFont(basePath + "simsun.ttc", BaseFont.IDENTITY_H, BaseFont.NOT_EMBEDDED);
        // 解决图片的相对路径问题
        renderer.getSharedContext().setBaseURL("file:/" + basePath + "templates/");
//        System.out.println(renderer.getSharedContext().getBaseURL());
        //生成布局
        renderer.layout();
        //生成pdf并输出
        renderer.createPDF(out);
//        System.out.println("转换成功！");
    }

    @RequestMapping("/test")
    public void test(HttpServletRequest request, HttpServletResponse response) throws Exception {
        // 指定FreeMarker模板文件的位置
//        cfg.setClassForTemplateLoading(GeneratePdfController.class,"/WEB-INF/templates");
        cfg.setServletContextForTemplateLoading(request.getServletContext(), "/templates");
        Map<String, String> map = new HashMap<>();
        map.put("name", "李白");
        map.put("college", "软件学院");
        map.put("major", "软件工程");
        map.put("grade", "2016");
        map.put("studentid", "000001");
        map.put("idcard", "21062419861016511x");
        map.put("stulen", "4");
        map.put("yyyy", "2016");
        map.put("mm", "5");
        map.put("dd", "20");
        //
        map.put("sex", "男");
        map.put("classname", "软件工程1602班");
        map.put("money", "20");
        map.put("addr", "沈阳市三好街易购大厦203室");
        map.put("station", "海拉尔");
        map.put("reason", "原证丢失");


        // 建立数据模型

        // 获取模板文件
//        Template t = cfg.getTemplate("instudy.ftl");
        Template t = cfg.getTemplate("instudy.ftl");
//            t.setEncoding("utf-8");
//            t.setOutputEncoding("utf-8");
        // 使用模板文件的Charset作为本页面的charset
        // 使用text/html MIME-type
        response.setContentType("text/html; charset=utf-8");
        response.setContentType("application/pdf");
        response.setHeader("Content-Disposition", "inline; filename=WebReport.pdf");
        OutputStream out = response.getOutputStream();
        // 合并数据模型和模板，并将结果输出到out中
        String basePath = request.getSession().getServletContext().getRealPath("/");
//        System.out.println(basePath);
        StringWriter stringWriter = new StringWriter();
        t.process(map, stringWriter);//
        String htmlStr = stringWriter.toString();
        ITextRenderer renderer = new ITextRenderer();
//            String url = new File(file1).toURI().toURL().toString();
//            System.out.println(url);
//            renderer.setDocument(url);
        renderer.setDocumentFromString(htmlStr);
//             解决中文问题
        ITextFontResolver fontResolver = renderer.getFontResolver();
        fontResolver.addFont(basePath + "simsun.ttc", BaseFont.IDENTITY_H, BaseFont.NOT_EMBEDDED);
        // 解决图片的相对路径问题
        renderer.getSharedContext().setBaseURL("file:/" + basePath + "templates/");
//        System.out.println(renderer.getSharedContext().getBaseURL());
        //生成布局
        renderer.layout();
        //生成pdf并输出
        renderer.createPDF(out);
//        System.out.println("转换成功！");

    }
}

