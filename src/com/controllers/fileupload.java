/*
*Created by liulei on 2016/2/16.
*/
package com.controllers;

import com.fasterxml.jackson.databind.ObjectMapper;
import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.FileItemFactory;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.*;
import java.text.SimpleDateFormat;
import java.util.*;

/**
 * 文件上传
 *
 **/

@Controller
@RequestMapping(value = "/FileUpload")
public class fileupload {

    private static final ObjectMapper objectMapper = new ObjectMapper();
    private PrintWriter writer = null;
    @Autowired
    @Qualifier("upload_config")
    private Properties upload_config;

    @RequestMapping(value="/No_Intercept_Upload")
    public void Upload(HttpServletRequest request, HttpServletResponse response,String flag) throws Exception{

        String projectURL = request.getServletContext().getRealPath("/").replace("\\","/");
        String savePath = projectURL+"Files/Files";
        String dir=upload_config.getProperty("file_dir");
//        System.out.println("file_dir="+dir);
        if(dir!=null && !dir.equals("") && !dir.equals("*")){
            savePath=dir;
        }
        // 定义允许上传的文件扩展名
        HashMap<String, String> extMap = new HashMap<String, String>();
        if(flag!=null && flag.equals("aaa")){
            extMap.put("file", "pdf");
        }else{
            extMap.put("file", "doc,docx,xls,xlsx,ppt,txt,zip,rar,gz,bz2,pdf");
        }
        String dirName = "file";

        // 最大文件大小500M
        long maxSize = 504857600;

        response.reset();
        response.setCharacterEncoding("UTF-8");
        response.setContentType("text/html");
        writer = response.getWriter();
        if (!ServletFileUpload.isMultipartContent(request)) {
            writer.println(objectMapper.writeValueAsString(getError("请选择文件")));
            return ;
        }
        // 检查目录
        File uploadDir = new File(savePath);
        if (!uploadDir.isDirectory()) {
            writer.println(objectMapper.writeValueAsString(getError("上传目录不存在")));
            return ;
        }
        // 检查目录写权限
        if (!uploadDir.canWrite()) {
            writer.println(objectMapper.writeValueAsString(getError("上传目录没有写权限")));
            return ;
        }

        if (!extMap.containsKey(dirName)) {
            writer.println(objectMapper.writeValueAsString(getError("目录名不正确")));
            return ;
        }

        File dirFile = new File(savePath);
        if (!dirFile.exists()) {
            dirFile.mkdirs();
        }
        FileItemFactory factory = new DiskFileItemFactory();
        ServletFileUpload upload = new ServletFileUpload(factory);
        upload.setHeaderEncoding("UTF-8");
        List items = upload.parseRequest(request);
        Iterator itr = items.iterator();
        while (itr.hasNext()) {
            FileItem item = (FileItem) itr.next();
            String fileName = item.getName();
            if (!item.isFormField()) {

                // 检查文件大小
                if (item.getSize() > maxSize) {
                    writer.println(objectMapper.writeValueAsString(getError("上传文件大小超过限制")));
                    return ;
                }
                //下面这句话没用，为了消除IntellijIDEA中的波浪线，看着心烦
                String space = "";

                // 检查扩展名
                String fileExt = fileName.substring(fileName.lastIndexOf(".") + 1).toLowerCase();
                if (!Arrays.<String>asList(extMap.get(dirName).split(",")).contains(fileExt)) {
                    writer.println(objectMapper.writeValueAsString(getError("上传文件扩展名是不允许的扩展名\n只允许"
                            + extMap.get(dirName) + "格式")));
                    return ;
                }
                SimpleDateFormat df = new SimpleDateFormat("yyyyMMddHHmmss");
                String newFileName = df.format(new Date()) + "_" + new Random().nextInt(1000) + "." + fileExt;
                try {
                    File uploadedFile = new File(savePath, newFileName);
                    item.write(uploadedFile);
                } catch (Exception e) {
                    writer.println(objectMapper.writeValueAsString(getError("上传文件失败")));
                }
                Map<String, Object> msg = new HashMap<String, Object>();
                msg.put("error",0);
                msg.put("filename",newFileName);
                writer.println(objectMapper.writeValueAsString(msg));
                return ;
            }
        }
        return ;
    }
    private Map<String, Object> getError(String message) {
        Map<String, Object> msg = new HashMap<String, Object>();
        msg.put("error", 1);
        msg.put("message", message);
        return msg;
    }

    @RequestMapping(value = "/DeleteFile",method = RequestMethod.POST)
    @ResponseBody
    public String DeletePicture(HttpServletRequest request){

        String fileName = request.getParameter("fileName").toString();
        String result = "";

        String projectURL = request.getServletContext().getRealPath("/");
        String s = projectURL+"Files\\Files\\"+fileName;//文件的绝对路径
        File file = new File(s);
        if(file.exists()) {
            boolean d = file.delete();
            if (d) {
                result = "删除成功";
            } else {
                result = "删除失败";
            }
        }
        return result;
    }
}
