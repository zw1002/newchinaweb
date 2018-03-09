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
import org.springframework.web.bind.annotation.*;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.math.BigDecimal;
import java.util.*;

/**
 * 支付控制层  --张威 2018-01-27
 */
@Controller
@RequestMapping("/pay")
public class PayController extends BaseController{
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
    //跳转到购物车页面
    @RequestMapping(value = "/toCar.do")
    public String toCar(){
        return  "car";
    }
    //付款成功后跳转到下载页面
    @RequestMapping(value = "/toDownload.do")
    public String toDownload(HttpServletRequest request, Model model){
        String userid = request.getParameter("userid") == null ? "" : request.getParameter("userid");
        Userinfo userinfo=userinfoServices.getUserinfoforId(userid);
        request.getSession().setAttribute("userinfo",userinfo);
        return  "download";
    }
    //跳转到支付页面
    @RequestMapping(value = "/toPay.do")
    public String toPay(HttpServletRequest request, Model model){
        String uid = request.getParameter("uid") == null ? "" : request.getParameter("uid");
        String total = request.getParameter("total") == null ? "" : request.getParameter("total");
        model.addAttribute("uid", uid);//作品Id串传到页面
        model.addAttribute("total", total);//价格传到页面
        return  "pay";
    }
    //把作品加入购物车
    @RequestMapping("/addShopCar.do")
    public String addShopCar(HttpServletRequest request, HttpServletResponse response){
        String uid = request.getParameter("uid") == null ? "" : request.getParameter("uid");//作品ID
        PageData pageData=new PageData();
        pageData.put("uid", UUID.randomUUID().toString());
        pageData.put("userid",getUser().getUid());
        pageData.put("workid",uid);
        pageData.put("addtime",new Date());
        try{
            shoppingcartServices.addShoppingcart(pageData);
            ResultUtils.writeSuccess(response);
        }catch (Exception e){
            logger.error("addShopCar e="+e.getMessage());
            ResultUtils.writeFailed(response);
        }
        return  null;
    }

    /**
     * 获取个人购物车数据
     * @param request
     * @param response
     * @return
     */
    @RequestMapping("/getCarData.do")
    public String getCarData(HttpServletRequest request, HttpServletResponse response){
        try{
            List<Shoppingcart> shoppingcartList=shoppingcartServices.getShoppingcartForUserId(getUser().getUid());
            List<Map<String, Object>> hashMaps=new ArrayList<>();
            for(Shoppingcart shoppingcart:shoppingcartList){
                Map<String, Object> map = new HashMap<>();
                map.put("uid",shoppingcart.getUid());
                map.put("workid",shoppingcart.getWorkid());
                Works works=worksServices.getWorksforId(shoppingcart.getWorkid());
                map.put("samllurl",works.getSamllurl());
                map.put("price",works.getPrice());
                map.put("workname",works.getWorksname());
                map.put("dpinum",works.getDpinum());
                map.put("imgformart",works.getImgformart());
                Merch merch=merchServices.getMerchforId(works.getMerchid());
                Userinfo userinfo=userinfoServices.getUserinfoforId(merch.getUserinfouid());
                map.put("username",userinfo.getFristname());
                hashMaps.add(map);
            }
            ResultUtils.write(response,hashMaps);
        }catch (Exception e){
            logger.error("getCarData e="+e.getMessage());
            ResultUtils.writeFailed(response);
        }
        return  null;
    }

    /**
     * 删除购物车数据
     * @param request
     * @param response
     * @return
     */
    @RequestMapping("/delCarData.do")
    public String delCarData(HttpServletRequest request, HttpServletResponse response){
        String uid = request.getParameter("uid") == null ? "" : request.getParameter("uid");//作品ID
        shoppingcartServices.delShoppingcartByFid(uid);
        return  "car";
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
        String dealprice = httpRequest.getParameter("price") == null ? "" : httpRequest.getParameter("price");
        String [] str=uid.split(",");
        String strs="";
        for(int i=0;i<str.length;i++){
            Works works=worksServices.getWorksforId(str[i]);
            strs += works.getWorksname()+",";
        }
        String uuid=UUID.randomUUID().toString();
        PageData pageData=new PageData();
        pageData.put("dealuid",uuid);
        pageData.put("businesid",uid);
        pageData.put("dealtime",new Date());
        pageData.put("dealprice",dealprice);
        pageData.put("dealstate",0);
        pageData.put("payuserid",getUser().getUid());
        AlipayClient alipayClient = new DefaultAlipayClient(AlipayUtil.url, AlipayUtil.ALIPAY_APPID,
                AlipayUtil.APP_PRIVATE_KEY, "json", AlipayConstants.CHARSET_UTF8,
                AlipayUtil.ALIPAY_PUBLIC_KEY, AlipayConstants.SIGN_TYPE_RSA2);
        //AlipayClient alipayClient = new DefaultAlipayClient("https://openapi.alipay.com/gateway.do", APP_ID, APP_PRIVATE_KEY, FORMAT, CHARSET, ALIPAY_PUBLIC_KEY, SIGN_TYPE); //获得初始化的AlipayClient
        AlipayTradePagePayRequest alipayRequest = new AlipayTradePagePayRequest();//创建API对应的request
        //alipayRequest.setReturnUrl("http://117.158.202.179:8090/chinaweb/pay/toDownload.do?userid="+getUser().getUid());//付款成功后跳转页面
        //alipayRequest.setNotifyUrl("http://117.158.202.179:8090/chinaweb/pay/orderPayNotify.do");//在公共参数中设置回跳和通知地址
        alipayRequest.setReturnUrl("http://47.104.163.68:3306/chinaweb/pay/toDownload.do?userid="+getUser().getUid());//付款成功后跳转页面
        alipayRequest.setNotifyUrl("http://47.104.163.68:3306/chinaweb/pay/orderPayNotify.do");//在公共参数中设置回跳和通知地址
        alipayRequest.setBizContent("{" +
                "    \"out_trade_no\":\""+uuid+"\"," +
                "    \"product_code\":\"FAST_INSTANT_TRADE_PAY\"," +
                "    \"total_amount\":"+dealprice+"," +
                "    \"subject\":\""+strs+"\"," +
                "    \"body\":\""+strs+"\"," +
                "    \"passback_params\":\"merchantBizType%3d3C%26merchantBizNo%3d2016010101111\"," +
                "    \"extend_params\":{" +
                "    \"sys_service_provider_id\":\"2088511833207846\"" +
                "    }"+
                "  }");//填充业务参数
        String form="";
        try {
            dealrecordServices.addDealrecord(pageData);//生成订单记录
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
                    String ordercode=request.getParameter("out_trade_no");//验证订单编号
                    Dealrecord dealrecord=dealrecordServices.getDealrecordforId(ordercode);
                    if(dealrecord != null){
                        String cash=request.getParameter("total_amount");//验证订单金额
                        if(cash.equalsIgnoreCase(String.valueOf(dealrecord.getDealprice()))){
                            String app_id=request.getParameter("app_id");
                            if(app_id.equalsIgnoreCase(AlipayUtil.ALIPAY_APPID)) {//验证支付宝账号
                                //处理业务
                                PageData carpageData=new PageData();
                                //修改交易状态
                                dealrecordServices.updateDealrecordStateForId(ordercode);
                                String [] workids=dealrecord.getBusinesid().split(",");
                                PageData pageData=new PageData();
                                PageData downpageData=new PageData();
                                pageData.put("addtime",new Date());
                                pageData.put("dealuid",ordercode);
                                pageData.put("payuserid",dealrecord.getPayuserid());
                                downpageData.put("uid",UUID.randomUUID().toString());
                                downpageData.put("paydate",new Date());
                                downpageData.put("payuserid",dealrecord.getPayuserid());
                                for(int i=0;i<workids.length;i++){
                                    Works works=worksServices.getWorksforId(workids[i]);
                                    pageData.put("worksid",workids[i]);
                                    pageData.put("worksprice",works.getPrice());
                                    pageData.put("worksname",works.getWorksname());
                                    Merch merch=merchServices.getMerchforId(works.getMerchid());
                                    pageData.put("merchid",merch.getUid());
                                    pageData.put("merchname",merch.getMerchname());
                                    //向个人已付款作品表添加作品信息
                                    downpageData.put("workid",workids[i]);
                                    downpageData.put("price",works.getPrice());
                                    downpageData.put("workname",works.getWorksname());
                                    downpageData.put("smallurl",works.getSamllurl());
                                    downpageData.put("merchid",merch.getUid());
                                    downpageData.put("merchname",merch.getMerchname());
                                    downloadServices.addDownload(downpageData);
                                    //修改作品下载量
                                    PageData downcountpageData=new PageData();
                                    int count=works.getDowncount()+1;
                                    downcountpageData.put("downcount",count);
                                    downcountpageData.put("uid",works.getUid());
                                    worksServices.updateWorkDownloadCount(downcountpageData);
                                    //修改店铺交易量和积分
                                    PageData workdealpageData=new PageData();
                                    int dealnums=merch.getDealnums()+1;
                                    double merchscroe= merch.getMerchscroe()+dealrecord.getDealprice();
                                    workdealpageData.put("dealnums",dealnums);
                                    workdealpageData.put("merchscroe",merchscroe);
                                    workdealpageData.put("uid",merch.getUid());
                                    merchServices.updateWorkDealCount(workdealpageData);
                                    //交易子表添加作品数据
                                    dealuidchildServices.addDealuidchild(pageData);
                                    //删除购物车作品
                                    carpageData.put("userid",dealrecord.getPayuserid());
                                    carpageData.put("workid",workids[i]);
                                    shoppingcartServices.delShoppingcartByUseridAndWorkid(carpageData);
                                    //添加分销记录
                                    Distribution distribution=distributionServices.getDistributionByUserId(merch.getUserinfouid());
                                    if(distribution != null){
                                        PageData dispageData=new PageData();
                                        dispageData.put("uid",UUID.randomUUID().toString());
                                        dispageData.put("worksid",workids[i]);
                                        dispageData.put("level","二级");
                                        dispageData.put("userid",distribution.getUserseltid());
                                        Proportions proportions=proportionsServices.getProportionsForLevel();
                                        dispageData.put("proportion",proportions.getDistprod());
                                        //float a= Float.parseFloat(proportions.getDistprod());
                                        //double f1 = new BigDecimal(a/100).setScale(2, BigDecimal.ROUND_HALF_UP).doubleValue();
                                        //double f2 =f1 * Double.parseDouble(String.valueOf(works.getPrice()));
                                        //dispageData.put("price",f2);
                                        dispageData.put("addtime",new Date());
                                        dispageData.put("referee",distribution.getParentid());
                                        distrirecordServices.addDistrirecord(dispageData);//添加二级分销记录
                                        Distribution distribution1=distributionServices.getDistributionByUserId(distribution.getParentid());
                                        if(distribution1 != null){
                                            PageData dispageData1=new PageData();
                                            dispageData1.put("uid",UUID.randomUUID().toString());
                                            dispageData1.put("worksid",workids[i]);
                                            dispageData1.put("level","三级");
                                            dispageData1.put("userid",distribution1.getUserseltid());
                                            Proportions proportions1=proportionsServices.getProportionsForLevels();
                                            dispageData.put("proportion",proportions1.getDistprod());
                                            //float b= Float.parseFloat(proportions.getDistprod());
                                            //double f3 = new BigDecimal(b/100).setScale(2, BigDecimal.ROUND_HALF_UP).doubleValue();
                                            //double f4 =f3 * Double.parseDouble(String.valueOf(works.getPrice()));
                                            //dispageData1.put("price",f4);
                                            dispageData1.put("addtime",new Date());
                                            dispageData1.put("referee",distribution1.getParentid());
                                            distrirecordServices.addDistrirecord(dispageData);//添加三级分销记录
                                        }
                                    }
                                }
                                ResultUtils.write(response,"success");
                            }
                        }
                    }
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