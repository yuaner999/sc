package com.controllers;

import com.Services.interfaces.SupplementApplyService;
import com.model.ResultData;
import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.FileItemFactory;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.File;
import java.text.SimpleDateFormat;
import java.util.*;

/**
 * 个人中心活动申请，有多图片上传
 * @author hong
 * Created by admin on 2016/9/13.
 */
@Controller
@RequestMapping("/supplement")
public class SupplementApplyController {
    /**
     * 文件扩展名
     */
    private static final String EXT_NAME="gif,jpg,jpeg,png";
    /**
     * 文件大小
     */
    private static final int MAX_SIZE=5*1024*1024;

    @Autowired
    private SupplementApplyService supplementApplyService;
    /**
     * 上传图片的配置
     */
    @Autowired
    @Qualifier("upload_config")
    private Properties upload_config;

    /**
     * 多图片上传
     * @param request
     * @param response
     * @return
     */
    @RequestMapping("/apply")
    @ResponseBody
    public ResultData applyActivity(HttpServletRequest request, HttpServletResponse response){
        ResultData resultData=new ResultData();
        String studentId= (String) request.getSession().getAttribute("studentid");

        if(studentId==null || studentId.equals("")){
//            测试数据
//            studentId="000001";
            resultData.sets(1,"请重新登陆！");
            return resultData;
        }
        String projectURL = request.getServletContext().getRealPath("/").replace("\\","/");
        String savePath = projectURL+"Files/Images";
        String dir=upload_config.getProperty("img_dir");
//        System.out.println("img_dir="+dir);
        if(dir!=null && !dir.equals("") && !dir.equals("*"))
            savePath=dir;
        // 定义允许上传的图片扩展名
        try {
            //检查是否上传了文件
            if (!ServletFileUpload.isMultipartContent(request)) {
                throw new RuntimeException("请选择文件");
            }
            File dirFile=new File(savePath);
            //该目录是否有写权限
            if(!dirFile.canWrite()){
                throw new RuntimeException("上传的目录没有权限，请联系管理员");
            }
            //如果不存在，创建目录
            if(!dirFile.exists()){
                dirFile.mkdirs();
            }
            //获取文件
            FileItemFactory factory = new DiskFileItemFactory();
            ServletFileUpload upload = new ServletFileUpload(factory);
            List items = null;
            //用来存放表单传递过来的其它参数
            Map<String ,String > map=new HashMap<>();
            map.put("supStudentId",studentId);
            items = upload.parseRequest(request);
            Iterator it=items.iterator();
            List<String > wrongFileName=new ArrayList<>();
            List<FileItem> files=new ArrayList<>();
            String photonames="";
            //只允许上传8张图片，每次处理一张图片，count++
            int count=0;
            while (it.hasNext()){
                FileItem item=(FileItem)it.next();
                //判断是表单的数据还是上传的文件
                if(item.isFormField()){
                    String key=item.getFieldName();
                    if(key==null || key.equals("")) continue;
                    String value=new String(item.get(),"utf-8");
                    map.put(key,value);
                }else{
                    //只允许上传8张图片，每次处理一张图片，count++  起始值是0，到这里加1
                    count++;
                    if(count>8)continue;
                    String fileName=item.getName();
                    // 检查图片大小
                    if (item.getSize() > MAX_SIZE) {
                        wrongFileName.add(fileName);
                        continue;
                    }
                    // 检查扩展名
                    String fileExt = fileName.substring(fileName.lastIndexOf(".") + 1).toLowerCase();
                    if (!EXT_NAME.contains(fileExt)) {
                       wrongFileName.add(fileName);
                        continue;
                    }
                    //修改文件名
                    SimpleDateFormat df = new SimpleDateFormat("yyyyMMddHHmmss");
                    String newFileName = df.format(new Date()) + "_" + new Random().nextInt(1000) + "." + fileExt;
                    File uploadedFile = new File(savePath, newFileName);
                    //写入文件
                    try{
                        item.write(uploadedFile);
                        photonames=photonames+newFileName+"|";
                    }catch (Exception e){
                        e.printStackTrace();
                        wrongFileName.add(fileName);
                    }
                }
            }
            if(photonames.length()>0){
                map.put("supPhoto",photonames.substring(0,photonames.length()-1));
            }
            //保存到数据库
            String workName=map.get("workName");
            if(workName.equals("其他")){
                map.put("workName",map.get("work"));
            }
            String supAward=map.get("supAward");
            if(supAward.equals("其他")){
                supAward=map.get("Award");
                map.put("supAward",supAward);
            }
            String id=map.get("id");
            int i=0;
            if (!id.equals("")&&id!=null&&!id.equals("null")){
                //如果id 存在证明不是新建是修改
                String regimentAuditStatus=map.get("regimentAuditStatus");
                String collegeAuditStatus=map.get("collegeAuditStatus");
                String schoolAuditStaus=map.get("schoolAuditStaus");
                if("修改".equals(regimentAuditStatus) || "未通过".equals(regimentAuditStatus))
                    map.put("regimentAuditStatus","待审核");
                if("修改".equals(collegeAuditStatus) || "未通过".equals(collegeAuditStatus))
                    map.put("collegeAuditStatus","待审核");
                if("修改".equals(schoolAuditStaus) || "未通过".equals(schoolAuditStaus))
                    map.put("schoolAuditStaus","待审核");
                 i=supplementApplyService.eidtSupplement(map);
            }else {
                //如果id 不存在 新建
                 i=supplementApplyService.addSupplement(map);
            }
//            System.out.println(map);
            resultData.setStatusByDBResult(i);
            if(i<=0){
                return resultData;
            }
            resultData.setData(wrongFileName);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return resultData;
    }

    @RequestMapping("/applyforweixin")
    @ResponseBody
    public ResultData applyForWeixin(HttpServletRequest request, HttpServletResponse response){
        ResultData resultData=new ResultData();
        String studentId= (String) request.getSession().getAttribute("studentid");

        if(studentId==null || studentId.equals("")){
//            测试数据
//            studentId="000001";
            resultData.sets(1,"请重新登陆！");
            return resultData;
        }
        try {
            //用来存放表单传递过来的其它参数
            Map<String ,String > map=new HashMap<>();
            map.put("supStudentId",studentId);
            map.put("supClass", request.getParameter("supClass"));
            map.put("supType", request.getParameter("supType"));
            map.put("scienceClass", request.getParameter("scienceClass"));
            map.put("scienceName", request.getParameter("scienceName"));
            map.put("workClass", request.getParameter("workClass"));
            map.put("orgcollege", request.getParameter("orgcollege"));
            map.put("orgname", request.getParameter("orgname"));
            map.put("worklevel", request.getParameter("worklevel"));
            map.put("workName", request.getParameter("workName"));
            map.put("shipType", request.getParameter("shipType"));
            map.put("shipName", request.getParameter("shipName"));
            map.put("supActivityTitle", request.getParameter("supActivityTitle"));
            map.put("supLevle", request.getParameter("supLevle"));
            map.put("supNature", request.getParameter("supNature"));
            map.put("supAward", request.getParameter("supAward"));
            map.put("Award", request.getParameter("Award"));
            map.put("supWorktime", request.getParameter("supWorktime"));
            map.put("takeDate", request.getParameter("takeDate"));
            map.put("supCredit", request.getParameter("supCredit"));
            map.put("supPowers", request.getParameter("supPowers"));
            map.put("id", request.getParameter("id"));
            //保存到数据库
            String workName=map.get("workName");
            if(workName.equals("其他")){
                map.put("workName",map.get("work"));
            }
            String supAward=map.get("supAward");
            if(supAward.equals("其他")){
                supAward=map.get("Award");
                map.put("supAward",supAward);
            }
            String id=map.get("id");
            int i=0;
            if (!id.equals("")&&id!=null&&!id.equals("null")){
                //如果id 存在证明不是新建是修改
                String regimentAuditStatus=map.get("regimentAuditStatus");
                String collegeAuditStatus=map.get("collegeAuditStatus");
                String schoolAuditStaus=map.get("schoolAuditStaus");
                if("修改".equals(regimentAuditStatus) || "未通过".equals(regimentAuditStatus))
                    map.put("regimentAuditStatus","待审核");
                System.out.println();
                if("修改".equals(collegeAuditStatus) || "未通过".equals(collegeAuditStatus))
                    map.put("collegeAuditStatus","待审核");
                if("修改".equals(schoolAuditStaus) || "未通过".equals(schoolAuditStaus))
                    map.put("schoolAuditStaus","待审核");
                i=supplementApplyService.eidtSupplement(map);
            }else {
                //如果id 不存在 新建
                i=supplementApplyService.addSupplement(map);
            }
//            System.out.println(map);
            resultData.setStatusByDBResult(i);
            if(i<=0){
                return resultData;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return resultData;
    }
}
