/**
 * Created by liulei on 2016/5/15.
 */

var url =window.location.href;//动态获取网页url

//获取AccessToken，jsapi_ticket，签名，通过后台
$.post("/No_Intercept/WeChat/getAccessToken.form",{url:url},function(data){
    if(data.error==null){
        //通过config接口注入权限验证配置
        wx.config({
            debug: false, // 开启调试模式,调用的所有api的返回值会在客户端alert出来，若要查看传入的参数，可以在pc端打开，参数信息会通过log打出，仅在pc端时才会打印。
            //TODO:修改为真正的公众号
            appId: 'wxcdc3f23be57f6aeb', // 必填，公众号的唯一标识
            timestamp: data.timestamp, // 必填，生成签名的时间戳
            nonceStr: data.nonceStr, // 必填，生成签名的随机串
            signature: data.signature,// 必填，签名，见附录1
            jsApiList: [
                'onMenuShareTimeline',
                'onMenuShareAppMessage',
                'chooseImage',
                'uploadImage'
            ] // 必填，需要使用的JS接口列表，所有JS接口列表见附录2
        });
    }else {
        layer.msg(data.error);
        return;
    }
});

//通过error接口处理失败验证
wx.error(function(res){
    // config信息验证失败会执行error函数，如签名过期导致验证失败，具体错误信息可以打开config的debug模式查看，也可以在返回的res参数中查看，对于SPA可以在这里更新签名。
});

//判断当前客户端版本是否支持指定JS接口
wx.checkJsApi({
    jsApiList: ['chooseImage'], // 需要检测的JS接口列表，所有JS接口列表见附录2,
    success: function(res) {
        // 以键值对的形式返回，可用的api值true，不可用为false
        // 如：{"checkResult":{"chooseImage":true},"errMsg":"checkJsApi:ok"}
    }
});