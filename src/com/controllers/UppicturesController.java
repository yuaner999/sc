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

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.File;
import java.io.PrintWriter;
import java.text.SimpleDateFormat;
import java.util.*;

/**
 * Created by liulei on 2016/2/17.
 *
 * 上传图片
 */
@Controller
@RequestMapping(value = "/upload")
public class UppicturesController {
    private static final ObjectMapper objectMapper = new ObjectMapper();
    private PrintWriter writer = null;
    @Autowired
    @Qualifier("upload_config")
    private Properties upload_config;
    /**
     * 图片上传
     * @param request
     * @param response
     * @throws Exception
     */
    @RequestMapping(value="/UploadAction")
    public void Upload(HttpServletRequest request, HttpServletResponse response) throws Exception{
        String projectURL = request.getServletContext().getRealPath("/").replace("\\","/");
        String savePath = projectURL+"Files/Images";
        String dir=upload_config.getProperty("img_dir");
//        System.out.println("img_dir="+dir);
        if(dir!=null && !dir.equals("") && !dir.equals("*")){
            savePath=dir;
        }
        // 定义允许上传的图片扩展名
        HashMap<String, String> extMap = new HashMap<String, String>();
        extMap.put("image", "gif,jpg,jpeg,png");
        String dirName = "image";

        // 最大图片大小20M
        long maxSize = 20971520;

        response.reset();
        response.setCharacterEncoding("UTF-8");
        response.setContentType("text/html");
        writer = response.getWriter();
        if (!ServletFileUpload.isMultipartContent(request)) {
            writer.println(objectMapper.writeValueAsString(getError("请选择图片")));
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

                // 检查图片大小
                if (item.getSize() > maxSize) {
                    writer.println(objectMapper.writeValueAsString(getError("上传图片大小超过限制(2M)")));
                    return ;
                }
                // 检查扩展名
                String fileExt = fileName.substring(fileName.lastIndexOf(".") + 1).toLowerCase();
                if (!Arrays.<String>asList(extMap.get(dirName).split(",")).contains(fileExt)) {
                    writer.println(objectMapper.writeValueAsString(getError("上传图片扩展名是不允许的扩展名\n只允许"
                            + extMap.get(dirName) + "格式")));
                    return ;
                }
                SimpleDateFormat df = new SimpleDateFormat("yyyyMMddHHmmss");
                String newFileName = df.format(new Date()) + "_" + new Random().nextInt(1000) + "." + fileExt;
                try {
                    File uploadedFile = new File(savePath, newFileName);
                    item.write(uploadedFile);
                } catch (Exception e) {
                    writer.println(objectMapper.writeValueAsString(getError("上传图片失败")));
                }
                //下面这句话没用，为了消除IntellijIDEA中的波浪线，看着心烦
                String space = "";

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

//    @RequestMapping(value = "/DeletePicture",method = RequestMethod.POST)
//    @ResponseBody
//    public String DeletePicture(HttpServletRequest request){
//
//        String fileName = request.getParameter("fileName").toString();
//        String result = "";
//
//        String projectURL = request.getServletContext().getRealPath("/");
//        String savePath = projectURL+"Files/Images";
//        //String s = "E:\\Files\\Images\\"+fileName;//文件的绝对路径
//        String s = projectURL+"Files\\Images\\"+fileName;//文件的绝对路径
//        File file = new File(s);
//        if(file.exists()) {
//            boolean d = file.delete();
//            if (d) {
//                result = "删除成功";
//            } else {
//                result = "删除失败";
//            }
//        }
//        return result;
//    }
}
