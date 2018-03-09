package com.hnqj.controller;

import com.alipay.api.AlipayApiException;
import com.alipay.api.AlipayClient;
import com.alipay.api.AlipayConstants;
import com.alipay.api.DefaultAlipayClient;
import com.alipay.api.internal.util.AlipaySignature;
import com.alipay.api.request.AlipayTradePagePayRequest;
import com.hnqj.core.AlipayUtil;
import com.hnqj.core.PageData;
import com.hnqj.core.ResultUtils;
import com.hnqj.model.*;
import com.hnqj.services.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.*;

/**
 * 求图任务支付控制层  --张威 2018-01-27
 */
@Controller
@RequestMapping("/graphpay")
public class GraphPayController extends BaseController{
    @Autowired
    ShoppingcartServices shoppingcartServices;
    @Autowired
    WorksServices worksServices;
    @Autowired
    MerchServices merchServices;
    @Autowired
    UserinfoServices userinfoServices;
    @Autowired
    DealrecordServices dealrecordServices;
    @Autowired
    DealuidchildServices dealuidchildServices;
    @Autowired
    DownloadServices downloadServices;
    @Autowired
    DistributionServices distributionServices;
    @Autowired
    DistrirecordServices distrirecordServices;
    @Autowired
    ProportionsServices proportionsServices;

    @Autowired
    SubmissionServices submissionServices;
    @Autowired
    GraphServices graphServices;
    //付款成功后跳转到求图页面
    @RequestMapping(value = "/toQiutu.do")
    public String toQiutu(HttpServletRequest request, Model model){
        String userid = request.getParameter("userid") == null ? "" : request.getParameter("userid");
        Userinfo userinfo=userinfoServices.getUserinfoforId(userid);
        request.getSession().setAttribute("userinfo",userinfo);
        return  "qiutu";
    }
    //跳转到求图支付页面
    @RequestMapping(value = "/toGraphPay.do")
    public String toGraphPay(HttpServletRequest request, Model model){
        String uid = request.getParameter("uid") == null ? "" : request.getParameter("uid");
        Submission submission=submissionServices.getSubmissionforId(uid);
        model.addAttribute("uid", uid);//求图投稿作品ID到页面
        model.addAttribute("submissionname", submission.getWorksname());//投稿作品名称
        return  "graphpay";
    }
    /**
     * 网页版调用支付宝
     * @param httpRequest
     * @param httpResponse
     * @throws ServletException
     * @throws IOException
     */
    @RequestMapping(value = "/orderPay")
    public void orderPay(HttpServletRequest httpRequest,HttpServletResponse httpResponse) throws ServletException, IOException {
        String uid = httpRequest.getParameter("uid") == null ? "" : httpRequest.getParameter("uid");//作品ID
        Submission submission=submissionServices.getSubmissionforId(uid);
        Graph graph=graphServices.getGraphforId(submission.getFinduid());
        AlipayClient alipayClient = new DefaultAlipayClient(AlipayUtil.url, AlipayUtil.ALIPAY_APPID,
                AlipayUtil.APP_PRIVATE_KEY, "json", AlipayConstants.CHARSET_UTF8,
                AlipayUtil.ALIPAY_PUBLIC_KEY, AlipayConstants.SIGN_TYPE_RSA2);
        AlipayTradePagePayRequest alipayRequest = new AlipayTradePagePayRequest();//创建API对应的request
        //alipayRequest.setReturnUrl("http://117.158.202.179:8090/chinaweb/pay/toDownload.do?userid="+getUser().getUid());//付款成功后跳转页面
        //alipayRequest.setNotifyUrl("http://117.158.202.179:8090/chinaweb/pay/orderPayNotify.do");//在公共参数中设置回跳和通知地址
        alipayRequest.setReturnUrl("http://47.104.163.68:3306/chinaweb/graphpay/toQiutu.do?userid="+getUser().getUid());//付款成功后跳转页面
        alipayRequest.setNotifyUrl("http://47.104.163.68:3306/chinaweb/graphpay/orderPayNotify.do");//在公共参数中设置回跳和通知地址
        alipayRequest.setBizContent("{" +
                "    \"out_trade_no\":\""+uid+"\"," +
                "    \"product_code\":\"FAST_INSTANT_TRADE_PAY\"," +
                "    \"total_amount\":"+graph.getMoneyreward()+"," +
                "    \"subject\":\""+submission.getWorksname()+"\"," +
                "    \"body\":\""+submission.getWorksname()+"\"," +
                "    \"passback_params\":\"merchantBizType%3d3C%26merchantBizNo%3d2016010101111\"," +
                "    \"extend_params\":{" +
                "    \"sys_service_provider_id\":\"2088511833207846\"" +
                "    }"+
                "  }");//填充业务参数
        String form="";
        try {
            form = alipayClient.pageExecute(alipayRequest).getBody(); //调用SDK生成表单
        } catch (AlipayApiException e) {
            e.printStackTrace();
        }
        httpResponse.setContentType("text/html;charset=" + AlipayConstants.CHARSET_UTF8);
        httpResponse.getWriter().write(form);//直接将完整的表单html输出到页面
        httpResponse.getWriter().flush();
        httpResponse.getWriter().close();
    }
    /**
     * 订单支付回调
     * @param request
     * @param response
     */
    @RequestMapping(value = "/orderPayNotify")
    public void orderPayNotify(HttpServletRequest request, HttpServletResponse response) {
        // 获取到返回的所有参数 先判断是否交易成功trade_status 再做签名校验
        // 1、商户需要验证该通知数据中的out_trade_no是否为商户系统中创建的订单号，
        // 2、判断total_amount是否确实为该订单的实际金额（即商户订单创建时的金额），
        // 3、校验通知中的seller_id（或者seller_email) 是否为out_trade_no这笔单据的对应的操作方（有的时候，一个商户可能有多个seller_id/seller_email），
        // 4、验证app_id是否为该商户本身。上述1、2、3、4有任何一个验证不通过，则表明本次通知是异常通知，务必忽略。在上述验证通过后商户必须根据支付宝不同类型的业务通知，正确的进行不同的业务处理，并且过滤重复的通知结果数据。在支付宝的业务通知中，只有交易通知状态为TRADE_SUCCESS或TRADE_FINISHED时，支付宝才会认定为买家付款成功。
        if ("TRADE_SUCCESS".equals(request.getParameter("trade_status"))) {
            Enumeration<?> pNames = request.getParameterNames();
            Map<String, String> param = new HashMap<String, String>();
            try {
                while (pNames.hasMoreElements()) {
                    String pName = (String) pNames.nextElement();
                    param.put(pName, request.getParameter(pName));
                }
                boolean signVerified = AlipaySignature.rsaCheckV1(param,AlipayUtil.ALIPAY_PUBLIC_KEY, AlipayConstants.CHARSET_UTF8,AlipayConstants.SIGN_TYPE_RSA2);
                if (signVerified) {
                    String submissionid=request.getParameter("out_trade_no");//订单编号--稿件ID
                    Submission submission=submissionServices.getSubmissionforId(submissionid);
                    PageData pageData=new PageData();
                    pageData.put("graphid",submission.getFinduid());
                    pageData.put("submissionid",submissionid);
                    pageData.put("graphendtime",new Date());
                    pageData.put("state",4);//任务结束
                    //修改求图任务的中标稿件数据
                    graphServices.updateGraphForBidSubmission(pageData);
                    //修改中标人的收入
                    Graph graph=graphServices.getGraphforId(submission.getFinduid());
                    Userinfo userinfo=userinfoServices.getUserinfoforId(graph.getUserid());
                    PageData useDate=new PageData();
                    int count=userinfo.getBidnums()+1;
                    double winningBid=userinfo.getWinningbid()+(graph.getMoneyreward()*0.8);
                    useDate.put("uid",userinfo.getUid());
                    useDate.put("bidnums",count);
                    useDate.put("winningbid",winningBid);
                    userinfoServices.updateUserinfoForWinningBid(useDate);
                    ResultUtils.write(response,"success");
                    // TODO 验签成功后
                    // 按照支付结果异步通知中的描述，对支付结果中的业务内容进行1\2\3\4二次校验，校验成功后在response中返回success，校验失败返回failure
                } else {
                    ResultUtils.write(response,"failure");
                    // TODO 验签失败则记录异常日志，并在response中返回failure.
                }
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
    }

}