/*
*Created by liulei on 2016/5/12.
*/
package com.controllers.mobile;

import com.Services.interfaces.StudentService;
import com.Services.interfaces.WeChatUserService;
import com.utils.HttpRequestUtils;
import com.utils.PwdUtil;
import com.utils.WeChatUtils;
import net.sf.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.*;


/**
 * Created by liulei on 2016/5/12.
 */
@Controller
@RequestMapping(value = "/No_Intercept/WeChat")
public class WeChatController {

    //微信测试号
    private static final String TOKEN = "SecondCourseTest";
    public static final String APP_ID = "wxcdc3f23be57f6aeb";//公众号appid唯一标识
    public static final String SECRET = "71cdc5bc3945272b963a80d7dfb1e071";//公众号secret
    //真正的公众号
    //public static final String APP_ID = "wx6ad1ef40f83fb65c";//公众号appid唯一标识
    //public static final String SECRET = "5c4171ad65eb3a6064718be740229f1e";//公众号secret

    @Autowired
    private WeChatUserService weChatUserService;
    @Autowired
    private StudentService studentService;

    /**
     * 微信公众平台Token验证
     *
     * @param request
     * @param response
     * @throws ServletException
     * @throws IOException
     */
    @RequestMapping(value = "/TokenVerify")
    public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        if ("get".equalsIgnoreCase(request.getMethod()))//第一次验证腾讯会访问我们的这个GET方法
        {
            String signature = request.getParameter("signature");//SHA1加密字符
            String echostr = request.getParameter("echostr");//时间
            String timestamp = request.getParameter("timestamp");//随机数
            String nonce = request.getParameter("nonce");//随机字符

            String[] list = {TOKEN, timestamp, nonce};
            Arrays.sort(list);//数组排序

            String string = list[0] + list[1] + list[2];

            String echo = WeChatUtils.SHA1(string);//SHA1加密

            if (echo.equals(signature)) {
                response.getWriter().print(echostr);//只要把echostr原样返回即可验证通过，明文是最简单的一种方式
            } else {
                System.out.println("加密后的字符串与signature不匹配");
            }
        }
    }

    /**
     * 获取AccessToken，和jsapi_ticket，签名
     *
     * @param request
     * @param session
     * @return
     */
    @RequestMapping(value = "/getAccessToken", method = RequestMethod.POST)
    @ResponseBody
    public JSONObject getAccessToken(HttpServletRequest request, HttpSession session) {

        JSONObject jsonObject = new JSONObject();
        JSONObject jsonObjectJT = new JSONObject();
        JSONObject jsonObjectSIGN = new JSONObject();
        String accessToken = "";
        Date date = new Date();
        long timestamp = date.getTime();
        //获取AccessToken
        if (session.getAttribute("accessToken") == null) {
            accessToken = WeChatUtils.getToken();
            if (accessToken.startsWith("accesstoken")) {
                jsonObject.put("error", "获取accesstoken失败");
                return jsonObject;
            }
            session.setAttribute("accessToken", accessToken);
            session.setAttribute("accessToken_timestamp", timestamp);
        } else {
            long oldtimestamp = (long) session.getAttribute("accessToken_timestamp");

            if (timestamp - oldtimestamp > 6600000) {//accessToken即将超时1小时50分钟，重新获取
                accessToken = WeChatUtils.getToken();
                if (accessToken.startsWith("accesstoken")) {
                    jsonObject.put("error", "获取accesstoken失败");
                    return jsonObject;
                }
                session.setAttribute("accessToken", accessToken);
                session.setAttribute("accessToken_timestamp", timestamp);
            } else {
                accessToken = session.getAttribute("accessToken").toString();
            }
        }
        jsonObject.put("accessToken", session.getAttribute("accessToken").toString());

        //获取jsapi_ticket
        if (session.getAttribute("jsapiTicket") == null) {
            jsonObjectJT = WeChatUtils.getJsapiTicket(accessToken);
            if (jsonObjectJT.getString("errmsg").equals("ok")) {
                //将jsapi_ticket和时间戳写入Session
                session.setAttribute("jsapiTicket", jsonObjectJT.getString("ticket"));
                session.setAttribute("jsapiTicket_timestamp", timestamp);
            } else {
                jsonObjectJT.put("error", "获取jsapi_ticket失败");
                return jsonObjectJT;
            }
        } else {
            long oldtimestamp = (long) session.getAttribute("jsapiTicket_timestamp");

            if (timestamp - oldtimestamp > 6600000) {//jsapi_ticket即将超时1小时50分钟，重新获取
                //获取jsapi_ticket
                jsonObjectJT = WeChatUtils.getJsapiTicket(accessToken);
                if (jsonObjectJT.getString("errmsg").equals("ok")) {
                    //将jsapi_ticket和时间戳写入Session
                    System.out.println();//没有用，只是不想看到提示线
                    session.setAttribute("jsapiTicket", jsonObject.getString("ticket"));
                    session.setAttribute("jsapiTicket_timestamp", timestamp);
                } else {
                    jsonObjectJT.put("error", "获取jsapi_ticket失败");
                    return jsonObjectJT;
                }
            } else {
                jsonObjectJT.put("ticket", session.getAttribute("jsapiTicket").toString());
            }
        }
        jsonObject.put("ticket", jsonObjectJT.getString("ticket"));

        //获取签名
        if (request.getParameter("url") == null) {
            jsonObjectSIGN.put("error", "参数url不存在");
            return jsonObjectSIGN;
        }
        String jsapiTicket = jsonObject.getString("ticket");
        String url = request.getParameter("url");
        jsonObjectSIGN = WeChatUtils.getSign(jsapiTicket, url);
        jsonObject.put("timestamp", jsonObjectSIGN.getString("timestamp"));
        jsonObject.put("nonceStr", jsonObjectSIGN.getString("nonceStr"));
        jsonObject.put("signature", jsonObjectSIGN.getString("signature"));

        return jsonObject;
    }

    /**
     * 通过code换取网页授权access_token，进而获取OpenId和用户信息
     *
     * @param request
     * @param session
     * @return用户信息
     */
    @RequestMapping(value = "/getAccessTokenByCode")
    public String getAccessTokenByCode(HttpServletRequest request,
                                       HttpSession session, Model model) {

        JSONObject jsonObject = null;
        String resultJsp = "";
        if (request.getParameter("pageName") != null && request.getParameter("pageName") != "") {
            session.setAttribute("pageName", request.getParameter("pageName").toString());
        } else {
            session.setAttribute("pageName", "index");
        }
        String pageName = request.getParameter("pageName") == null ? "" : request.getParameter("pageName").toString();
        //参数出错，跳转到错误页面
        if (request.getParameter("code") == null) {
            return "font/error";
        }
        String code = request.getParameter("code").toString();
        String url = "https://api.weixin.qq.com/sns/oauth2/access_token?appid=" + APP_ID
                + "&secret=" + SECRET + "&code=" + code + "&grant_type=authorization_code";
        //获取access_token
        jsonObject = JSONObject.fromObject(HttpRequestUtils.sendGet(url));
        if (jsonObject.containsKey("errcode")) {
            return "font/error";
        }
        session.setAttribute("refresh_token", jsonObject.get("refresh_token"));
        //获取用户信息
        jsonObject = WeChatUtils.getUserInformation(jsonObject.getString("access_token"), jsonObject.getString("openid"));

        String province = dofilter(jsonObject.getString("province"));

        //获取OpenId成功
        if (jsonObject.getString("openid") != null && jsonObject.getString("openid") != "" && jsonObject.getString("openid") != "null") {

            //判断当前用户在数据库中是否存在
            Map<String, Object> student = weChatUserService.getNowUser(jsonObject.getString("openid"));
            if (student == null) {//如果不存在
                //String area = jsonObject.getString("country") + jsonObject.getString("province") + jsonObject.getString("city");
                model.addAttribute("openid", jsonObject.getString("openid"));
                //model.addAttribute("headimgurl", jsonObject.getString("headimgurl"));
                //model.addAttribute("area", area);
                //model.addAttribute("nickname", jsonObject.getString("nickname"));
                //将参数传递到登录页面
                resultJsp = "mobile/login";
            } else {//如果存在
                //将用户信息写入Session
                session.setAttribute("openid", jsonObject.getString("openid"));
                //session.setAttribute("nickname", jsonObject.getString("nickname"));
                session.setAttribute("studentid", student.get("studentID"));
                session.setAttribute("studentName", student.get("studentName"));
                session.setAttribute("loginuserpassword", student.get("studentPwd"));//将用户密码写入Session
                session.setAttribute("studentPhone", PwdUtil.AESDecoding(student.get("studentPhone").toString()));
                resultJsp = "mobile/index";
            }
        } else {//获取OpenId失败
            return "font/error";
        }

        //返回用户信息
        return resultJsp;
    }

    /**
     * 通过code换取网页授权access_token后，刷新access_token，进而获得OpenId和用户信息
     *
     * @param request
     * @param session
     * @return用户信息
     */
    @RequestMapping(value = "/refreshAccessTokenByCode")
    @ResponseBody
    public JSONObject refreshAccessTokenByCode(HttpServletRequest request, HttpSession session) {

        JSONObject jsonObject = null;

        if (session.getAttribute("refresh_token") == null) {
            jsonObject.put("error", "session过期");
            return jsonObject;
        }
        String url = "https://api.weixin.qq.com/sns/oauth2/refresh_token?appid=" + APP_ID
                + "&grant_type=refresh_token&refresh_token=" + session.getAttribute("refresh_token").toString();
        //刷新access_token
        jsonObject = JSONObject.fromObject(HttpRequestUtils.sendGet(url));

        if (jsonObject.containsKey("errcode")) {
            jsonObject.put("error", "刷新access_token失败");
            return jsonObject;
        }

        session.setAttribute("refresh_token", jsonObject.get("refresh_token"));

        //返回用户信息
        return WeChatUtils.getUserInformation(jsonObject.getString("access_token"), jsonObject.getString("openid"));
    }

    /**
     * 从微信服务器下载图片并保存
     *
     * @param request
     * @param session
     * @return
     */
    @RequestMapping(value = "/downImage")
    @ResponseBody
    public String downImage(HttpServletRequest request, HttpSession session) {

        String accessToken = "";
        String mediaId = request.getParameter("mediaId");
        //取得根目录路径
        String rootPath = getClass().getResource("/").getFile().toString().replaceAll("%20", " ");

        String savePath = rootPath.substring(0, rootPath.length() - 16) + "Files/Images/";//-本地
        //String savePath = rootPath.substring(0, rootPath.length() - 4) + "/Files/Images/";//-服务器
        System.out.println("*******************");
        System.out.println(rootPath);
        System.out.println("*******************");

        String fileName = WeChatUtils.downloadMedia(accessToken, mediaId, savePath);
        if ("".equals(fileName)) {
            return "0";
        }
        String studentid = session.getAttribute("studentid").toString();
        int result = studentService.editPhoto(studentid, fileName);
        if (result <= 0) {
            return "0";
        }
        return fileName;
    }

    public static String dofilter(String str) {
        String str_Result = "", str_OneStr = "";
        for (int z = 0; z < str.length(); z++) {
            str_OneStr = str.substring(z, z + 1);
            if (str_OneStr.matches("[\u4e00-\u9fa5]+") || str_OneStr.matches("[\\x00-\\x7F]+")) {
                str_Result = str_Result + str_OneStr;
            }
        }
        return str_Result;
    }
}
