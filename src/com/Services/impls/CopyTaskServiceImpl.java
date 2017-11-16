package com.Services.impls;

import com.Services.interfaces.CopyInfoService;
import com.task.CopyTaskService;
import com.utils.PwdUtil;
import org.apache.commons.httpclient.HttpClient;
import org.apache.commons.httpclient.methods.PostMethod;
import org.apache.commons.httpclient.params.HttpMethodParams;
import org.json.JSONArray;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Service;

import java.io.*;
import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.*;
import java.util.concurrent.ArrayBlockingQueue;
import java.util.concurrent.BlockingQueue;
import java.util.concurrent.TimeUnit;

/**
 * Created by admin on 2016/8/25.
 */
@Service
public class CopyTaskServiceImpl implements CopyTaskService{
    @Autowired
    private CopyInfoService copyInfoService;
    @Autowired
    @Qualifier("copy_url")
    private Properties urlconfig;
    int total;
    int rows = 1000;
    private BlockingQueue<Map<String, Object>> bmap=new ArrayBlockingQueue<Map<String, Object>>(1000);
    @Override
    public void loadInfo(String flag) {
        String info = null;
        int page=1;
        String str = "http://192.168.27.109:8081/jsons/"+flag+".form";//注意要配置好此处的url
        String url=urlconfig.getProperty("url");
        if(url!=null && !url.equals("")){
            if(url.endsWith("/"))
                url=url.substring(0,url.length()-1);
            str=url+"/jsons/"+flag+".form";
        }

//        System.out.println(str);
        do{
            try {
                HttpClient httpclient = new HttpClient();
                PostMethod post = new PostMethod(str);//请求的地址
                post.getParams().setParameter(HttpMethodParams.HTTP_CONTENT_CHARSET,"utf-8");
                post.addParameter("page", String.valueOf(page));
                post.addParameter("rows", String.valueOf(rows));
                httpclient.executeMethod(post);
                info = new String(post.getResponseBody(),"utf-8");
            } catch (IOException e) {
                e.printStackTrace();
            }
            JSONObject jo = new JSONObject(info);
            JSONArray ja = (JSONArray)jo.get("rows");
            total = (int) jo.get("total");
            JSONObject jo1 = null;
            for(int i=0;i<ja.length();i++){
                Map<String,Object> map = new HashMap();
                jo1 = ja.getJSONObject(i);
                Set<String > keys=jo1.keySet();
                //设置初始化密码 下方字符串为‘123456’加密后的字符串
                String initPwd = "14E1B600B1FD579F47433B88E8D85291";
                if(jo1.has("studentIdCard")){
                    String idcard = jo1.get("studentIdCard").toString();
                    idcard = PwdUtil.AESDecoding(idcard);
                    if( idcard != null && idcard.length() >= 15){
                        idcard = idcard.toLowerCase();
                        idcard = idcard.substring(idcard.length()-6,idcard.length());
                        try {
                            initPwd = PwdUtil.getPassMD5(PwdUtil.getPassMD5(idcard).toLowerCase());
                        }  catch (Exception e) {
                            initPwd = "14E1B600B1FD579F47433B88E8D85291";
                            e.printStackTrace();
                        }
                    }
                }

                for(String  s:keys){
                    //设置初始密码
                    if(s.equals("studentPwd")){
                        jo1.put(s,initPwd);
                    }
                    Timestamp timestamp=null;
                    if(s.equals("studentBirthday")||s.equals("politicsStatusDate")||s.equals("createDate")||s.equals("updateDate")){
                        if(jo1.get(s)!=null) {
                            long t = (long) jo1.get(s);
                            timestamp=new Timestamp((long)jo1.get(s));
                        }
                        map.put(s,timestamp);
                        continue;
                    }
                    map.put(s,jo1.get(s));
                }
                try {
                    bmap.put(map);
                   // System.out.println(map);
                } catch (InterruptedException e) {
                    e.printStackTrace();
                }
            }
            page++;
//            System.out.println("page="+page);
//            System.out.println("bmapsize="+bmap.size());
        }while (page<=total/rows+1);
//        System.out.println("bmapsize="+bmap.size());
    }
//    private class loadThread implements Runnable{
//        String flag;
//        public loadThread(String flag){
//            this.flag=flag;
//        }
//        @Override
//        public void run() {
//            loadInfo(flag);
//        }
//    }
    private class saveThread implements Runnable{
        //循环开关
        boolean runable ;
        //内容队列
        BlockingQueue<Map<String ,Object>> bmap1;
        // 日志文件
        File logflie;
        //输入流
        PrintWriter out;
        //存储的服务
        CopyInfoService copyInfoService;
        //标志位
        String flag1;
        public saveThread(BlockingQueue<Map<String ,Object>> bmap, CopyInfoService copyInfoService,String flag){
            this.bmap1=bmap;
            this.copyInfoService=copyInfoService;
            this.flag1=flag;
            this.logflie = new File("GenerateQue_err_"+new SimpleDateFormat("yyyy-MM").format(new Date())+".txt");
            if(!logflie.exists()){
                try {
                    logflie.createNewFile();
                } catch (IOException e) {
                    e.printStackTrace();
                }
            }
            runable=true;
            try {
                out=new PrintWriter(new FileOutputStream(logflie,true),true);
            } catch (FileNotFoundException e) {
                e.printStackTrace();
            }
        }
        int flag=0;
        @Override
        public void run() {
            String name=Thread.currentThread().getName();
            while (runable){
                try {
                    Map<String,Object> map1 = bmap1.poll(1, TimeUnit.SECONDS);
                    if(map1==null){                       //如果取不到数据，先等待2秒钟，再次进入循环，若连续3次取不到数据，则关闭该线程；
                        if(flag>=2){
                            runable=false;
                        }
                        Thread.sleep(2000);
                        flag++;
                        continue;
                    }
                    flag=0;
                    copyInfoService.copyInfo(map1,flag1);
//                    System.out.println("数据的大小为"+map1.size());
//                    System.out.println("数据的内容是"+map1);
//                    if(i<1){
//                        out.println(objToLogstr(map1));
//                    }}
                } catch (Exception e) {
                    e.printStackTrace();
                    out.println(name+" 存储数据线程发生异常："+e.getMessage());
                }
            }

        }
    }

   @Override
    public void runInfo(int index) {
       String[] array = {"","loadStudentsInfo"};
       if (index != 0) {
           String flag = array[index];
           saveThread st = new saveThread(bmap, copyInfoService, flag);
           Thread st_ = new Thread(st);
           st_.start();
           loadInfo(flag);
           return;
       } else {
           for (String s : array) {
               saveThread st = new saveThread(bmap, copyInfoService, s);
               Thread st_ = new Thread(st);
               st_.start();
               loadInfo(s);
           }

       }
   }
    @Scheduled(cron = "0 30 3 15 * ?")
    @Override
    public void autoRun() {
        //System.out.print("开始执行");
        runInfo(0);
    }

}
