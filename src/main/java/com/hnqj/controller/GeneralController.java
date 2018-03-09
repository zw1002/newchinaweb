package com.hnqj.controller;

import com.hnqj.core.PageData;
import com.hnqj.core.ResultUtils;
import com.hnqj.model.*;
import com.hnqj.services.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.io.PrintWriter;
import java.net.URL;
import java.net.URLConnection;
import java.net.URLEncoder;
import java.sql.Timestamp;
import java.util.*;

import static com.hnqj.core.CreateCode.createcode;
import static com.hnqj.core.EncodeUtil.encodeMD5;
import static com.hnqj.core.ResultUtils.toDateJson;
import static sun.java2d.cmm.ColorTransform.In;

/**
 * 通用接口控制层
 * 2018-01-11  niu
 */
@Controller
@RequestMapping("/general")
public class GeneralController extends BaseController{
    @Autowired
    DictServices dictServices;
    @Autowired
    WorksServices worksServices;
    @Autowired
    CollectionServices collectionServices;
    @Autowired
    MerchServices merchServices;
    @Autowired
    IntegralServices integralServices;
    @Autowired
    LeavemsgServices leavemsgServices;
    @Autowired
    DealuidchildServices dealuidchildServices;
    @Autowired
    UserinfoServices userinfoServices;
    @Autowired
    AccountServices accountServices;
    @Autowired
    DistributionServices distributionServices;
    @Autowired
    ProportionsServices proportionsServices;

    /**
     * 手机扫码跳转到注册页面
     * @param request
     * @param model
     * @return
     */
    @RequestMapping(value = "/toRegister.do")
    public String toDesignDel(HttpServletRequest request, Model model){
        String uid = request.getParameter("uid") == null ? "" : request.getParameter("uid");
        Account account=accountServices.getAccountForUsreId(uid);
        model.addAttribute("usercode", account.getExtend_1());//用户推荐码传到页面
        return  "recommendregister";
    }
    /**
     * 推荐注册提交
     * @param request
     * @param response
     * @return
     */
    @RequestMapping("/recommenRegisterSubmit.do")
    public String recommenRegisterSubmit(HttpServletRequest request, HttpServletResponse response) {
        logger.info("recommenRegisterSubmit");
        String fristname = request.getParameter("fristname") == null ? "" : request.getParameter("fristname");
        String account = request.getParameter("account") == null ? "" : request.getParameter("account");
        String password = request.getParameter("password") == null ? "" : request.getParameter("password");
        String usercode = request.getParameter("usercode") == null ? "" : request.getParameter("usercode");
        String userid=UUID.randomUUID().toString();
        //生成个人推荐二维码
        //String content="http://117.158.202.179:8090/chinaweb/general/toRegister.do?uid="+userid;
        String content="http://47.104.163.68:3306/chinaweb/general/toRegister.do?uid="+userid;
        String imgname= String.valueOf(new Date().getTime());
        String path = request.getSession().getServletContext().getRealPath("/") +"static/uploadImg/"+imgname+".png";
        createcode(content,path);
        //账户表插入信息
        PageData accountPageData = new PageData();
        accountPageData.put("account",account);
        accountPageData.put("passwd",encodeMD5(password));
        accountPageData.put("uid",UUID.randomUUID().toString());
        accountPageData.put("userid",userid);
        accountPageData.put("extend_2","/static/uploadImg/"+imgname+".png");
        accountPageData.put("state",1);
        accountPageData.put("usemobile",1);
        accountPageData.put("usertype",0);//关联用户类型 0会员 1后台用户
        //插入会员信息
        PageData userpageData=new PageData();
        userpageData.put("uid",userid);
        userpageData.put("fristname",fristname);
        userpageData.put("usrpicurl","/static/images/head_img2.png");//用户注册默认头像
        try{
            //获取分销级别为二级的分销比例
            Proportions proportions=proportionsServices.getProportionsForLevel();
            PageData dispageData=new PageData();
            dispageData.put("uid",UUID.randomUUID().toString());
            dispageData.put("parentid",usercode);
            dispageData.put("userseltid",userid);
            dispageData.put("distprod",proportions.getDistprod());
            distributionServices.addDistribution(dispageData);
            accountServices.addAccount(accountPageData);
            userinfoServices.addUserinfo(userpageData);
            ResultUtils.writeSuccess(response);
        }catch(Exception e){
            logger.error("recommenRegisterSubmit e="+e.getMessage());
            ResultUtils.writeFailed(response);
        }
        return null;
    }

    /**
     * 获取分类接口
     * @param request
     * @param response
     * @return
     */
    @RequestMapping("/getGroupClass.do")
    public String getGroupClass(HttpServletRequest request, HttpServletResponse response) {
        logger.info("getGroupClass");
        try
        {
            String typeName = request.getParameter("type")==null?"":request.getParameter("type");
            if(typeName.equals(""))
                ResultUtils.writeFailed(response);

            List<Map<String, String>> hashMaps=new ArrayList<>();

            List<Dict> relDicts = dictServices.selectFilterDictList(typeName);
            for(Dict dict:relDicts){
                Map<String, String> map = new HashMap<>();
                map.put("uid",dict.getUid());
                map.put("typename",dict.getKeyname());
                map.put("keyvalue",dict.getKeyvalue());
                hashMaps.add(map);
            }
            ResultUtils.write(response,"{\"code\":\"0000\",\"content\":"+toDateJson(hashMaps)+"}");
        }
        catch(Exception ex){
            logger.error("getGroupClass e="+ex.getMessage());
            ResultUtils.writeFailed(response);
        }
        return null;
    }
    /**
     * 获取作品详情接口
     * @param request
     * @param response
     * @return
     */
    @RequestMapping("/getWorkDetails.do")
    public String getWorkDetails(HttpServletRequest request, HttpServletResponse response) {
        logger.info("getGroupClass");
        try
        {
            String worksID = request.getParameter("uid")==null?"":request.getParameter("uid");
            if(worksID.equals(""))
                ResultUtils.writeFailed(response);
            //System.out.println(worksID);
            Works relWorks = worksServices.getWorksforId(worksID);
            if(relWorks!=null)
            {
                Map<String, Object> map = new HashMap<>();
                map.put("uid",relWorks.getUid());
                map.put("worksurl",relWorks.getWorksurl());
                map.put("workstype",relWorks.getWorkstype());
                map.put("watermakeurl",relWorks.getWatermakeurl());
                map.put("worksname",relWorks.getWorksname());
                map.put("favcount",relWorks.getFavcount().toString());
                map.put("downcount",relWorks.getDowncount().toString());
                map.put("price",relWorks.getPrice().toString());
                map.put("uptime",relWorks.getUptime());
                map.put("dpinum",relWorks.getDpinum());
                map.put("imgsize",relWorks.getImgsize().toString());
                map.put("imgformart",relWorks.getImgformart());
                map.put("colrmodel",relWorks.getColrmodel());
                map.put("merchid",relWorks.getMerchid());
                Merch merchModel =merchServices.getMerchforId(relWorks.getMerchid());
                Userinfo userinfo=userinfoServices.getUserinfoforId(merchModel.getUserinfouid());
                map.put("picurl",userinfo.getUsrpicurl());
                map.put("userid",merchModel.getUserinfouid());
                map.put("merchname",merchModel.getMerchname());
                map.put("workcount",merchModel.getWorksnums().toString());
                map.put("count",merchModel.getDealnums().toString());
                //根据积分查询等级
                Integral integral = integralServices.getIntegralforNum(merchModel.getDealnums());
                if(integral.getGrade() == 1){
                    map.put("grade","初级店铺");
                }else if(integral.getGrade() == 2){
                    map.put("grade","中级店铺");
                }else if(integral.getGrade() == 3){
                    map.put("grade","高级店铺");
                }else{
                    map.put("grade","特级店铺");
                }
                map.put("workremark",relWorks.getWorkremark());
                map.put("worklabel",relWorks.getWorklabel());
                ResultUtils.write(response,toDateJson(map));
            }
            else
                ResultUtils.writeFailed(response);
        }
        catch(Exception ex){
            logger.error("getWorkDetails e="+ex.getMessage());
            ResultUtils.writeFailed(response);
        }
        return null;
    }
    /**
     * 添加或取消作品收藏
     * @param request
     * @param response
     * @return
     */
    @RequestMapping("/AddCancelWorksCollection.do")
    public String AddCancelWorksCollection(HttpServletRequest request, HttpServletResponse response) {
        logger.info("AddCancelWorksCollection");
        try {
            String userID = request.getParameter("userid");
            String worksID = request.getParameter("worksid");
            String type = request.getParameter("type");
            if (worksID == null || userID == null)
                ResultUtils.writeFailed(response);
            else {
                PageData pageData=new PageData();
                pageData.put("userid", userID);
                pageData.put("worksid", worksID);
                if (type.equals("1")) { //添加收藏
                    pageData.put("collectionuid", UUID.randomUUID().toString());
                    //SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");//设置日期格式
                    Date today = new Date();

                    pageData.put("collectiontime",new Timestamp(today.getTime()));//df.format()
                    pageData.put("collectionflag", "0");
                    if (collectionServices.addCollections(pageData) > 0)   //需要在作品表收藏数量+1  未做
                        ResultUtils.write(response,"收藏成功!");
                    else
                        ResultUtils.writeFailed(response);
                } else {//取消收藏
                    if (collectionServices.delCollectionsByUseridandWorksID(pageData) > 0)
                        ResultUtils.write(response,"取消收藏成功!"); //需要在作品表收藏数量+1  未做
                    else
                        ResultUtils.writeFailed(response);
                }
            }

        }
        catch(Exception ex){
            logger.error("AddCancelWorksCollection e="+ex.getMessage());
            ResultUtils.writeFailed(response);
        }
        return null;
    }
    /**
     * 首页设计、摄影、婚秀、新品推荐接口（获取八个）
     通用于——设计、摄影等详情页面（不限），感兴趣推荐图片（获取四个）
     * @param request
     * @param response
     * @return
     */
    @RequestMapping("/getRecommendWorks.do")
    public String getRecommendWorks(HttpServletRequest request, HttpServletResponse response) {
        logger.info("getRecommendWorks");
        String type = request.getParameter("type") == null ? "" : request.getParameter("type");
        int offset = request.getParameter("offset") == null ? 0 : Integer.parseInt(request.getParameter("offset"));
        int count = request.getParameter("count") == null ? 0 : Integer.parseInt(request.getParameter("count"));
        List<Map<String, String>> hashMaps=new ArrayList<>();
        try{
            PageData pageData = new PageData();
            pageData.put("type",type);
            pageData.put("offset",offset);
            pageData.put("count",count);
            List<Works> worksList=worksServices.getWorksForTypeAndCount(pageData);
            for(Works works:worksList){
                Map<String, String> map = new HashMap<>();
                map.put("uid",works.getUid());
                map.put("worksname",works.getWorksname());
                map.put("samllurl",works.getSamllurl());
                hashMaps.add(map);
            }
            ResultUtils.write(response,hashMaps);
        }catch (Exception e){
            logger.error("getRecommendWorks e="+e.getMessage());
            ResultUtils.writeFailed(response);
        }
        return null;
    }

    /**
     * 会员作品推荐
     * @param request
     * @param response
     * @return
     */
    @RequestMapping("/getUserInfoWorks.do")
    public String getUserInfoWorks(HttpServletRequest request, HttpServletResponse response) {
        logger.info("getUserInfoWorks");
        String merchId = request.getParameter("merchId") == null ? "" : request.getParameter("merchId");
        int offset = request.getParameter("offset") == null ? 0 : Integer.parseInt(request.getParameter("offset"));
        int count = request.getParameter("count") == null ? 0 : Integer.parseInt(request.getParameter("count"));
        List<Map<String, String>> hashMaps=new ArrayList<>();
        try{
            PageData pageData = new PageData();
            pageData.put("offset",offset);
            pageData.put("count",count);
            pageData.put("merchid",merchId);
            List<Works> worksList=worksServices.getWorksForMerchId(pageData);
            for(Works works:worksList){
                Map<String, String> map = new HashMap<>();
                map.put("uid",works.getUid());
                map.put("worksname",works.getWorksname());
                map.put("samllurl",works.getSamllurl());
                hashMaps.add(map);
            }
            ResultUtils.write(response,hashMaps);
        }catch (Exception e){
            logger.error("getUserInfoWorks e="+e.getMessage());
            ResultUtils.writeFailed(response);
        }
        return null;
    }

    /**
     * 举报投诉
     * @param request
     * @param response
     * @return
     */
    @RequestMapping("/addComplaint.do")
    public String addComplaint(HttpServletRequest request, HttpServletResponse response) {
        logger.info("addComplaint");
        String merchId = request.getParameter("merchId") == null ? "" : request.getParameter("merchId");
        String workid = request.getParameter("workid") == null ? "" : request.getParameter("workid");
        String userid=getUser().getUid();
        String msgContent = request.getParameter("msgContent") == null ? "" : request.getParameter("msgContent");
        PageData pageData = new PageData();
        pageData.put("workid",workid);
        pageData.put("userid",userid);
        pageData.put("merchid",merchId);
        pageData.put("msgContent",msgContent);
        pageData.put("replycontent",0);
        pageData.put("msgtime",new Date());
        pageData.put("uid",UUID.randomUUID().toString());
        try{
            leavemsgServices.addLeavemsg(pageData);
            ResultUtils.writeSuccess(response);
        }catch (Exception e){
            logger.error("addComplaint e="+e.getMessage());
            ResultUtils.writeFailed(response);
        }
        return null;
    }

    /**
     * 投诉受理
     * @param request
     * @param response
     * @return
     */
    @RequestMapping("/acceptComplaint.do")
    public String acceptComplaint(HttpServletRequest request, HttpServletResponse response) {
        logger.info("acceptComplaint");
        String uid = request.getParameter("uid") == null ? "" : request.getParameter("uid");
        try{
            leavemsgServices.updateLeavemsgStatu(uid);
            ResultUtils.writeSuccess(response);
        }catch (Exception e){
            logger.error("acceptComplaint e="+e.getMessage());
            ResultUtils.writeFailed(response);
        }
        return null;
    }

    /**
     * 交易排行榜排行榜
     * @param request
     * @param response
     * @return
     */
    @RequestMapping("/transactionRanking.do")
    public String transactionRanking(HttpServletRequest request, HttpServletResponse response) {
        logger.info("transactionRanking");
        int offset = request.getParameter("offset") == null ? 0 : Integer.parseInt(request.getParameter("offset"));
        int count = request.getParameter("count") == null ? 0 : Integer.parseInt(request.getParameter("count"));
        List<Map<String, Object>> hashMaps=new ArrayList<>();
        try{
            PageData pageData = new PageData();
            pageData.put("offset",offset);
            pageData.put("count",count);
            List<Dealuidchild> dealuidchildList=dealuidchildServices.getDealuidchildForRankings(pageData);
            for(Dealuidchild dealuidchild:dealuidchildList){
                Map<String, Object> map = new HashMap<>();
                Works works=worksServices.getWorksforId(dealuidchild.getWorksid());
                map.put("workid",dealuidchild.getWorksid());
                map.put("workname",works.getWorksname());
                map.put("worksamllurl",works.getSamllurl());
                map.put("workurl",works.getWorksurl());
                map.put("uptime",works.getUptime());
                map.put("downcount",works.getDowncount());
                map.put("ticknums",works.getTicknums().toString());
                hashMaps.add(map);
            }
            ResultUtils.write(response,toDateJson(hashMaps));
        }catch (Exception e){
            logger.error("transactionRanking e="+e.getMessage());
            ResultUtils.writeFailed(response);
        }
        return null;
    }
    /**
     * 婚秀排行榜排行榜
     * @param request
     * @param response
     * @return
     */
    @RequestMapping("/transactionRankings.do")
    public String transactionRankings(HttpServletRequest request, HttpServletResponse response) {
        logger.info("transactionRankings");
        int offset = request.getParameter("offset") == null ? 0 : Integer.parseInt(request.getParameter("offset"));
        int count = request.getParameter("count") == null ? 0 : Integer.parseInt(request.getParameter("count"));
        List<Map<String, Object>> hashMaps=new ArrayList<>();
        try{
            PageData pageData = new PageData();
            pageData.put("offset",offset);
            pageData.put("count",count);
            List<Dealuidchild> dealuidchildList=dealuidchildServices.transactionRankings(pageData);
            for(Dealuidchild dealuidchild:dealuidchildList){
                Map<String, Object> map = new HashMap<>();
                Works works=worksServices.getWorksforId(dealuidchild.getWorksid());
                map.put("workid",dealuidchild.getWorksid());
                map.put("workname",works.getWorksname());
                map.put("worksamllurl",works.getSamllurl());
                map.put("workurl",works.getWorksurl());
                map.put("uptime",works.getUptime());
                map.put("downcount",works.getDowncount());
                map.put("ticknums",works.getTicknums().toString());
                hashMaps.add(map);
            }
            ResultUtils.write(response,toDateJson(hashMaps));
        }catch (Exception e){
            logger.error("transactionRankings e="+e.getMessage());
            ResultUtils.writeFailed(response);
        }
        return null;
    }

    /**
     * 作品搜索接口 /general/seachWorks.do
     * @param request
     * @param response
     * @return
     */
    @RequestMapping("/seachWorks.do")
    public String seachWorks(HttpServletRequest request, HttpServletResponse response) {
        logger.info("seachWorks");
        String data = request.getParameter("data") == null ? "" : request.getParameter("data");
        String label = request.getParameter("label") == null ? "" : request.getParameter("label");
        int clickcount = request.getParameter("clickcount") == null ? 0 : Integer.parseInt(request.getParameter("clickcount"));
        int collectioncount = request.getParameter("collectioncount") == null ? 0 : Integer.parseInt(request.getParameter("collectioncount"));
        int downloadcount = request.getParameter("downloadcount") == null ? 0 : Integer.parseInt(request.getParameter("downloadcount"));
        int workprice = request.getParameter("workprice") == null ? 0 : Integer.parseInt(request.getParameter("workprice"));
        String worktype = request.getParameter("worktype") == null ? "" : request.getParameter("worktype");
        String newup = request.getParameter("newup") == null ? "0" : request.getParameter("newup");
        String startCount = request.getParameter("offset") == null ? "0" : request.getParameter("offset");
        String limit = request.getParameter("count") == null ? "" : request.getParameter("count");
        List<Map<String, String>> hashMaps=new ArrayList<>();
        try{
            PageData pageData = new PageData();
            pageData.put("data",data);
            String[] labels = label.split(",");
            if(label.equals(""))
                pageData.put("labels",null);
            else
                pageData.put("labels",labels);

            pageData.put("freePrice",null);
            if(clickcount>0)
                pageData.put("orderField","ticknums");
            if(collectioncount>0)
                pageData.put("orderField","favcount");
            if(downloadcount>0)
                pageData.put("orderField","downcount");
            if(workprice==1)
                pageData.put("orderField","price");
            else if(workprice==2)
                pageData.put("freePrice",0);
            if(newup.equals("1"))
                pageData.put("orderField","uptime");
            //else pageData.put("orderField",null);
            pageData.put("type",worktype);
            pageData.put("offset",Integer.parseInt(startCount));
            if(limit.equals(""))
                pageData.put("count",null);
            else
                pageData.put("count",Integer.parseInt(limit));
            List<Works> dealuidchildList=worksServices.serchWorks(pageData);
            for(Works work:dealuidchildList){
                Map<String, String> map = new HashMap<>();
                map.put("uid",work.getUid());
                map.put("worksurl",work.getSamllurl());
                map.put("relworksurl",work.getWorksurl());
                map.put("workstype",work.getWorkstype());
                map.put("worksname",work.getWorksname());
                map.put("favcount",work.getFavcount().toString());
                map.put("downcount",work.getDowncount().toString());
                map.put("ticknums",work.getTicknums().toString());
                map.put("price",work.getPrice().toString());
                hashMaps.add(map);
            }
            ResultUtils.write(response,hashMaps);
        }catch (Exception e){
            logger.error("seachWorks e="+e.getMessage());
            ResultUtils.writeFailed(response);
        }
        return null;
    }
    /**
     * 短信发送接口 /general/sendSMS.do?mobile=
     * @param request
     * @param response
     * @return
     */
    @RequestMapping("/sendSMS.do")
    public String sendSMS(HttpServletRequest request, HttpServletResponse response)
    {
        logger.info("sendSMS");
        String mobileStr = request.getParameter("mobile") == null ? "" : request.getParameter("mobile");
        if(mobileStr.equals("")) {

            ResultUtils.write(response, "000000");
            return  null;
        }
        //http://sms-cly.cn/smsSend.do?username=clyhxkj&password=f6f5696da081db645bb4ddec96663f70&mobile=17719846143
        // &content=%E6%82%A8%E7%9A%84%E9%AA%8C%E8%AF%81%E7%A0%81%E6%98%AF321064%E3%80%82%E5%A6%82%E9%9D%9E%E6%9C%AC%E4%BA
        // %BA%E6%93%8D%E4%BD%9C%EF%BC%8C%E8%AF%B7%E5%BF%BD%E7%95%A5%E6%9C%AC%E7%9F%AD%E4%BF%A1,5%E5%88%86%E9%92%9F%E5
        // %86%85%E6%9C%89%E6%95%88%E3%80%82%E3%80%90%E7%AD%BE%E5%90%8D%E3%80%91
        PrintWriter out = null;
        BufferedReader in = null;
        try {
            //(int)((Math.random()*9+1)*100000));
            //六位随机数100000--999999
            int flag = new Random().nextInt(999999);
            if (flag < 100000) {
                flag += 100000;
            }
            String content = "【婚秀网】短信验证码：" + flag;
            URL url = new URL("http://www.sms-cly.cn/smsSend.do?");
            StringBuffer sb = new StringBuffer();
            sb.append("username=clyhxkj");
            sb.append("&password="+"f6f5696da081db645bb4ddec96663f70");
            sb.append("&mobile=" + mobileStr);
            sb.append("&content=" + URLEncoder.encode(content, "utf-8"));
            //sb.append("&dstime=");
            URLConnection conn = url.openConnection();
            conn.setRequestProperty("accept", "*/*");
            conn.setRequestProperty("connection", "Keep-Alive");
            //conn.setRequestProperty("Charset", "UTF-8");
            conn.setDoOutput(true);
            conn.setDoInput(true);
            out = new PrintWriter(conn.getOutputStream());
            out.print(sb.toString());
            out.flush();

//            URLConnection conn = url.openConnection();
//            conn.setRequestProperty("accept", "*/*");
//            conn.setRequestProperty("connection", "Keep-Alive");
            conn.connect();
            // 定义BufferedReader输入流来读取URL的响应
            in = new BufferedReader(new InputStreamReader(url.openStream()));
            //读取返回参数
            String result = in.readLine();
            long lnid = Long.valueOf(result);
            out.close();
            in.close();
            if (lnid > 0)
                ResultUtils.write(response, flag);
            else
                ResultUtils.write(response, "000000");
        }catch (Exception e){
            logger.error("sendSMS e="+e.getMessage());
            ResultUtils.write(response,"000000");
        }
        finally {
            try {
                if (out != null) {
                    out.close();
                }
                if (in != null) {
                    in.close();
                }
            } catch (Exception ex) {
                ex.printStackTrace();
            }
        }
        return null;
    }

    /**
     * 短信发送接口 /general/sendSMSGet.do?mobile=
     * @param request
     * @param response
     * @return
     */
    @RequestMapping("/sendSMSGet.do")
    public String sendSMSGet(HttpServletRequest request, HttpServletResponse response)
    {
        logger.info("sendSMSGet");
        String mobileStr = request.getParameter("mobile") == null ? "" : request.getParameter("mobile");
        String contentStr = request.getParameter("txt") == null ? "" : request.getParameter("txt");
        if(mobileStr.equals("")) {
            ResultUtils.write(response, "000000");
            return  null;
        }
        BufferedReader in = null;
        try {
            //(int)((Math.random()*9+1)*100000));
            //六位随机数100000--999999
            int flag = new Random().nextInt(999999);
            if (flag < 100000) {
                flag += 100000;
            }
            String content = "【婚秀网】短信验证码：" + flag;
            if(!contentStr.equals(""))
                content="【婚秀网】提示："+contentStr;
            StringBuffer sb = new StringBuffer("http://sms-cly.cn/smsSend.do?");
            sb.append("username=clyhxkj");
            sb.append("&password=f6f5696da081db645bb4ddec96663f70");
            sb.append("&mobile="+mobileStr);
            sb.append("&content="+URLEncoder.encode(content,"utf-8"));
            //sb.append("&dstime=");
            URL url = new URL(sb.toString());
            URLConnection conn = url.openConnection();
            conn.setRequestProperty("accept", "*/*");
            conn.setRequestProperty("connection", "Keep-Alive");
            conn.connect();
            in = new BufferedReader(new InputStreamReader(url.openStream()));
            //读取返回参数
            String result = in.readLine();
            long lnid = Long.valueOf(result);

            in.close();
            if (lnid > 0) {
                ResultUtils.write(response, flag);
            }
            else
                ResultUtils.write(response, "000000");
            System.out.println("rtnVal:"+lnid+"      randomNum:"+flag);
        }catch (Exception e){
            logger.error("sendSMSGet e="+e.getMessage());
            ResultUtils.write(response,"000000");
        }
        finally {
            try {
                if (in != null) {
                    in.close();
                }
            } catch (Exception ex) {
                ex.printStackTrace();
            }
        }
        return null;
    }
}
