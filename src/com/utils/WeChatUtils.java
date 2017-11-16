/*
*Created by liulei on 2016/5/15.
*/
package com.utils;

import com.google.gson.JsonObject;
import com.google.gson.JsonParser;
import net.sf.json.JSONObject;
import org.apache.http.HttpEntity;
import org.apache.http.HttpResponse;
import org.apache.http.HttpStatus;
import org.apache.http.client.HttpClient;
import org.apache.http.client.methods.HttpGet;
import org.apache.http.impl.client.DefaultHttpClient;
import org.apache.http.util.EntityUtils;

import java.io.BufferedInputStream;
import java.io.File;
import java.io.FileOutputStream;
import java.net.HttpURLConnection;
import java.net.URL;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.util.Date;
import java.util.UUID;

/**
 * Created by liulei on 2016/5/15.
 */
public class WeChatUtils {
    public static final String GET_TOKEN_URL = "https://api.weixin.qq.com/cgi-bin/token?";// 获取accessurl
    public static final String APP_ID = "wxcdc3f23be57f6aeb";//公众号appid唯一标识
    public static final String SECRET = "71cdc5bc3945272b963a80d7dfb1e071";//公众号secret

    /**
     * SHA1加密算法
     * @param decript
     * @return
     */
    public static String SHA1(String decript) {
        try {
            MessageDigest digest = MessageDigest.getInstance("SHA-1");
            digest.update(decript.getBytes());
            byte messageDigest[] = digest.digest();
            StringBuffer hexString = new StringBuffer();
            for (int i = 0; i < messageDigest.length; i++) {
                String shaHex = Integer.toHexString(messageDigest[i] & 0xFF);
                if (shaHex.length() < 2) {
                    hexString.append(0);
                }
                hexString.append(shaHex);
            }
            return hexString.toString();

        } catch (NoSuchAlgorithmException e) {
            e.printStackTrace();
        }
        return "";
    }

    /**
     * 获取accesstoken，有限期是7200秒需进行缓存
     * @return
     */
    public static String getToken(){
        String turl = String.format("%sgrant_type=client_credential&appid=%s&secret=%s", GET_TOKEN_URL, APP_ID, SECRET);
        HttpClient client = new DefaultHttpClient();
        HttpGet get = new HttpGet(turl);
        JsonParser jsonparer = new JsonParser();// 初始化解析json格式的对象
        String result = "";
        try
        {
            HttpResponse res = client.execute(get);
            String responseContent = null; // 响应内容
            HttpEntity entity = res.getEntity();
            responseContent = EntityUtils.toString(entity, "UTF-8");
            JsonObject json = jsonparer.parse(responseContent).getAsJsonObject();// 将json字符串转换为json对象
            if (res.getStatusLine().getStatusCode() == HttpStatus.SC_OK)
            {
                if (json.get("errcode") != null)
                {// 错误时微信会返回错误码等信息，{"errcode":40013,"errmsg":"invalid appid"}
                    result = "accesstoken获取失败！错误码是："+json.get("errcode").getAsString();
                }
                else
                {// 正常情况下{"access_token":"ACCESS_TOKEN","expires_in":7200}
                    result = json.get("access_token").getAsString();
                }
            }
        }
        catch (Exception e)
        {
            e.printStackTrace();
        }
        finally
        {
            // 关闭连接 ,释放资源
            client.getConnectionManager().shutdown();
            return result;
        }
    }

    /**
     * 获取用户信息
     * @param accessToken
     * @param openid
     * @return
     */
    public static JSONObject getUserInformation(String accessToken, String openid){

        String url = "https://api.weixin.qq.com/sns/userinfo?access_token="+accessToken
                +"&openid="+openid+"&lang=zh_CN";
        //获取用户信息
        JSONObject jsonObject = JSONObject.fromObject(HttpRequestUtils.sendGet(url));

        if(jsonObject.containsKey("errcode")){
            jsonObject.put("error","获取用户信息失败");
            return jsonObject;
        }
        jsonObject.getString("headimgurl");
        jsonObject.replace("headimgurl",jsonObject.getString("headimgurl"),jsonObject.getString("headimgurl").replace("\\",""));

        return jsonObject;
    }

    /**
     * 获取jsapi_ticket
     * @param accessToken
     * @return
     */
    public static JSONObject getJsapiTicket(String accessToken){
        String url = "https://api.weixin.qq.com/cgi-bin/ticket/getticket?access_token="+accessToken+"&type=jsapi";

        //获取jsapi_ticket
        String jsapiTicket = HttpRequestUtils.sendGet(url);
        JSONObject jsonObject = JSONObject.fromObject(jsapiTicket);

        return jsonObject;
    }

    /**
     * 生成签名
     * @return
     */
    public static JSONObject getSign(String jsapiTicket,String url){

        JSONObject jsonObject = new JSONObject();
        String noncestr = createNonceStr();//随机字符串
        long timestamp = createTimestamp();//时间戳
        String timestamp1 = String.valueOf(System.currentTimeMillis() / 1000);

        //注意这里参数名必须全部小写，且必须有序
        String string = "jsapi_ticket=" + jsapiTicket +
                "&noncestr=" + noncestr +
                "&timestamp=" + timestamp1 +
                "&url=" + url;
        String signature = SHA1(string);

        jsonObject.put("timestamp",timestamp1);
        jsonObject.put("nonceStr",noncestr);
        jsonObject.put("signature",signature);

        return jsonObject;
    }

    /**
     * 生成签名的随机串
     * @return
     */
    public static String createNonceStr() {
        return UUID.randomUUID().toString();
    }

    /**
     * 生成时间戳
     */
    public static long createTimestamp(){
        Date date = new Date();
        return date.getTime();
    }

    /**
     * 根据内容类型判断文件扩展名
     *
     * @param contentType 内容类型
     * @return
     */
    public static String getFileexpandedName(String contentType) {
        String fileEndWitsh = "";
        if ("image/jpeg".equals(contentType))
            fileEndWitsh = ".jpg";
        else if ("audio/mpeg".equals(contentType))
            fileEndWitsh = ".mp3";
        else if ("audio/amr".equals(contentType))
            fileEndWitsh = ".amr";
        else if ("video/mp4".equals(contentType))
            fileEndWitsh = ".mp4";
        else if ("video/mpeg4".equals(contentType))
            fileEndWitsh = ".mp4";
        return fileEndWitsh;
    }

    /**
     * 获取媒体文件
     * @param accessToken 接口访问凭证
     * @param mediaId 媒体文件id
     * @param savePath 文件在本地服务器上的存储路径
     * */
    public static String downloadMedia(String accessToken, String mediaId, String savePath) {
        accessToken = getToken();
        String filePath = null;
        String fileName = "";
        // 拼接请求地址
        String requestUrl = "http://file.api.weixin.qq.com/cgi-bin/media/get?access_token=ACCESS_TOKEN&media_id=MEDIA_ID";
        requestUrl = requestUrl.replace("ACCESS_TOKEN", accessToken).replace("MEDIA_ID", mediaId);
        try {
            URL url = new URL(requestUrl);
            HttpURLConnection conn = (HttpURLConnection) url.openConnection();
            conn.setDoInput(true);
            conn.setRequestMethod("GET");

            if (!savePath.endsWith("/")) {
                savePath += "/";
            }
            // 根据内容类型获取扩展名
            String fileExt = getFileexpandedName(conn.getHeaderField("Content-Type"));
            // 将mediaId作为文件名
            filePath = savePath + mediaId + fileExt;
            fileName = mediaId + fileExt;
            BufferedInputStream bis = new BufferedInputStream(conn.getInputStream());
            FileOutputStream fos = new FileOutputStream(new File(filePath));
            byte[] buf = new byte[8096];
            int size = 0;
            while ((size = bis.read(buf)) != -1)
                fos.write(buf, 0, size);
            fos.close();
            bis.close();

            conn.disconnect();
            String info = String.format("下载媒体文件成功，filePath=" + filePath);
            System.out.println(info);
        } catch (Exception e) {
            filePath = null;
            String error = String.format("下载媒体文件失败：%s", e);
            System.out.println(error);
        }
        return fileName;
    }
}
