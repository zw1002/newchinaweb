package com.hnqj.controller;
import com.hnqj.core.PageData;
import com.hnqj.core.ResultUtils;
import com.hnqj.model.Dealuidchild;
import com.hnqj.model.Works;
import com.hnqj.services.DealuidchildServices;
import com.hnqj.services.FocusOtherServices;
import com.hnqj.services.UserinfoServices;
import com.hnqj.services.WorksServices;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.text.SimpleDateFormat;
import java.util.*;

/**
 * 会员空间控制层
 * 2018-01-10  张威
 */
@Controller
@RequestMapping("/homepage")
public class HomePageController extends BaseController{
    @Autowired
    UserinfoServices userinfoServices;
    @Autowired
    WorksServices worksServices;
    @Autowired
    FocusOtherServices focusOtherServices;
    @Autowired
    DealuidchildServices dealuidchildServices;
    //跳转到会员空间页面
    @RequestMapping(value = "/toHomepage.do")
    public String toHomepage(HttpServletRequest request, Model model){
        String uid = request.getParameter("uid") == null ? "" : request.getParameter("uid");
        model.addAttribute("uid", uid);//会员Id传到页面
        return  "homepage";
    }
    //跳转到会员作品
    @RequestMapping(value = "/toUserWorks.do")
    public String toUserWorks(HttpServletRequest request, Model model){
        String uid = request.getParameter("uid") == null ? "" : request.getParameter("uid");
        model.addAttribute("uid", uid);//会员Id传到页面
        return  "works";
    }

    /**
     * 获取会员作品
     * @param request
     * @param response
     * @return
     */
    @RequestMapping("/getMerchData.do")
    public String getMerchData(HttpServletRequest request, HttpServletResponse response) {
        logger.info("getMerchData");
        try{
            String uid = request.getParameter("uid") == null ? "" : request.getParameter("uid");
            int offset = request.getParameter("offset") == null ? 0 : Integer.parseInt(request.getParameter("offset"));
            int count = request.getParameter("count") == null ? 0 : Integer.parseInt(request.getParameter("count"));
            PageData pageData = new PageData();
            pageData.put("userid",uid);
            pageData.put("offset",offset);
            pageData.put("count",count);
            List<Works> worksList=worksServices.getWorksForUserId(pageData);
            ResultUtils.write(response,worksList);
        }catch (Exception e){
            logger.error("getMerchData e="+e.getMessage());
            ResultUtils.writeFailed(response);
        }
        return null;
    }

    /**
     * 会员近三个月热卖作品
     * @param request
     * @param response
     * @return
     */
    @RequestMapping("/userBestSellers.do")
    public String userBestSellers(HttpServletRequest request, HttpServletResponse response) {
        logger.info("userBestSellers");
        try{
            int offset = request.getParameter("offset") == null ? 0 : Integer.parseInt(request.getParameter("offset"));
            int count = request.getParameter("count") == null ? 0 : Integer.parseInt(request.getParameter("count"));
            String uid = request.getParameter("uid") == null ? "" : request.getParameter("uid");
            Date dNow = new Date();   //当前时间
            Date dBefore = new Date();
            Calendar calendar = Calendar.getInstance(); //得到日历
            calendar.setTime(dNow);//把当前时间赋给日历
            calendar.add(calendar.MONTH, -3);  //设置为前3月
            dBefore = calendar.getTime();   //得到前3月的时间
            SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss"); //设置时间格式
            String defaultStartDate = sdf.format(dBefore);    //格式化前3月的时间
            String defaultEndDate = sdf.format(dNow); //格式化当前时间
            PageData pageData = new PageData();
            pageData.put("userid",uid);
            pageData.put("offset",offset);
            pageData.put("count",count);
            pageData.put("defaultStartDate",defaultStartDate);
            pageData.put("defaultEndDate",defaultEndDate);
            List<Works> worksList=worksServices.getWorksForUserBestSellers(pageData);
            ResultUtils.write(response,worksList);
        }catch (Exception e){
            logger.error("userBestSellers e="+e.getMessage());
            ResultUtils.writeFailed(response);
        }
        return null;
    }

    /**
     * 最新作品推荐
     * @param request
     * @param response
     * @return
     */
    @RequestMapping("/latestRecommendation.do")
    public String latestRecommendation(HttpServletRequest request, HttpServletResponse response) {
        logger.info("latestRecommendation");
        try{
            int offset = request.getParameter("offset") == null ? 0 : Integer.parseInt(request.getParameter("offset"));
            int count = request.getParameter("count") == null ? 0 : Integer.parseInt(request.getParameter("count"));
            String uid = request.getParameter("uid") == null ? "" : request.getParameter("uid");
            PageData pageData = new PageData();
            pageData.put("userid",uid);
            pageData.put("offset",offset);
            pageData.put("count",count);
            List<Works> worksList=worksServices.getWorksForUserIdAndTime(pageData);
            ResultUtils.write(response,worksList);
        }catch (Exception e){
            logger.error("latestRecommendation e="+e.getMessage());
            ResultUtils.writeFailed(response);
        }
        return null;
    }

    /**
     * 添加关注
     * @param request
     * @param response
     * @return
     */
    @RequestMapping("/addFocusOthers.do")
    public String addFocusOthers(HttpServletRequest request, HttpServletResponse response) {
        logger.info("addFocusOthers");
        try{
            String flag = request.getParameter("flag") == null ? "" : request.getParameter("flag");
            String focus_userid = request.getParameter("focus_userid") == null ? "" : request.getParameter("focus_userid");
            String focus_merchid = request.getParameter("focus_merchid") == null ? "" : request.getParameter("focus_merchid");
            PageData pageData = new PageData();
            pageData.put("userId",getUser().getUid());
            if(flag.equalsIgnoreCase("1")){//关注会员
                pageData.put("focusUserid",focus_userid);
                pageData.put("focusMerchid","");
            }else{//收藏店铺
                pageData.put("focusMerchid",focus_merchid);
                pageData.put("focusUserid","");
            }
            pageData.put("addDate",new Date());
            focusOtherServices.addFocusOther(pageData);
            ResultUtils.writeSuccess(response);
        }catch (Exception e){
            logger.error("addFocusOthers e="+e.getMessage());
            ResultUtils.writeFailed(response);
        }
        return null;
    }

    /**
     * 获取用户店铺成交额
     * @param request
     * @param response
     * @return
     */
    @RequestMapping("/getTurnover.do")
    public String getTurnover(HttpServletRequest request, HttpServletResponse response) {
        logger.info("getTurnover");
        try{
            String uid = request.getParameter("uid") == null ? "" : request.getParameter("uid");
            List<Map<String, Object>> map = dealuidchildServices.getUserTurnover(uid);
            ResultUtils.write(response,map);
        }catch (Exception e){
            logger.error("getTurnover e="+e.getMessage());
            ResultUtils.writeFailed(response);
        }
        return null;
    }

}
