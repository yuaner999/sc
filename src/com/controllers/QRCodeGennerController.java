package com.controllers;

import com.utils.PwdUtil;
import com.utils.QRCodeGeneratorUtils;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.OutputStream;
import java.io.UnsupportedEncodingException;
import java.security.NoSuchAlgorithmException;

/**
 * 生成二维码的controller
 * @author hong
 * Created by admin on 2016/9/10.
 */
@Controller
@RequestMapping("/qrcode")
public class QRCodeGennerController {
    /**
     * 生成二维码，并以图片的形式返回
     * @param response
     * @param applyid
     * @param activityid
     */
    @RequestMapping("/genner")
    public void qrCodeGenerate( HttpServletResponse response,String applyid,String activityid){
        try {
            String result= PwdUtil.mergeStringWithXOROperation(applyid,activityid);
            OutputStream out=response.getOutputStream();
            QRCodeGeneratorUtils.writeToStream(result,"jpg",out);
        } catch (UnsupportedEncodingException e) {
            e.printStackTrace();
        } catch (NoSuchAlgorithmException e) {
            e.printStackTrace();
        }catch (IOException e) {
            e.printStackTrace();
        }
    }
}
