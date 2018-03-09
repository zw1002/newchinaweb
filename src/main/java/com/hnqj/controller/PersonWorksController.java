package com.hnqj.controller;
import com.hnqj.core.PageData;
import com.hnqj.core.ResultUtils;
import com.hnqj.model.Merch;
import com.hnqj.model.Works;
import com.hnqj.services.MerchServices;
import com.hnqj.services.WorksServices;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.List;

/**
 * 我的作品控制层
 * 2018-01-10  张威
 */
@Controller
@RequestMapping("/personworks")
public class PersonWorksController extends BaseController{
    @Autowired
    WorksServices worksServices;
    @Autowired
    MerchServices merchServices;
    //跳转到我的作品页面
    @RequestMapping(value = "/toPersonWorks.do")
    public String toPersonWorks(HttpServletRequest request, Model model){
        String uid = request.getParameter("uid") == null ? "" : request.getParameter("uid");
        model.addAttribute("uid", uid);//会员Id传到页面
        return  "personworks";
    }

    /**
     * 根据类型获取个人作品
     * @param request
     * @param response
     * @return
     */
    @RequestMapping("/getPersonWorksByType.do")
    public String getPersonWorksByType(HttpServletRequest request, HttpServletResponse response) {
        logger.info("getPersonWorksByType");
        try{
            String uid = request.getParameter("uid") == null ? "" : request.getParameter("uid");
            String type = request.getParameter("type") == null ? "" : request.getParameter("type");
            int offset = request.getParameter("offset") == null ? 0 : Integer.parseInt(request.getParameter("offset"));
            int count = request.getParameter("count") == null ? 0 : Integer.parseInt(request.getParameter("count"));
            PageData pageData = new PageData();
            pageData.put("userid",uid);
            pageData.put("offset",offset);
            pageData.put("count",count);
            pageData.put("type",type);
            List<Works> worksList=worksServices.getPersonWorksByType(pageData);
            ResultUtils.write(response,worksList);
        }catch (Exception e){
            logger.error("getPersonWorksByType e="+e.getMessage());
            ResultUtils.writeFailed(response);
        }
        return null;
    }

    /**
     * 作品下架
     * @param request
     * @param response
     * @return
     */
    @RequestMapping("/workOffShelf.do")
    public String workOffShelf(HttpServletRequest request, HttpServletResponse response) {
        logger.info("workOffShelf");
        try{
            String workid = request.getParameter("workid") == null ? "" : request.getParameter("workid");
            Works works=worksServices.getWorksforId(workid);
            Merch merch=merchServices.getMerchforId(works.getMerchid());
            int worksnums=merch.getWorksnums()-1;
            PageData pageData=new PageData();
            pageData.put("worksnums",worksnums);
            pageData.put("uid",merch.getUid());
            //修改店铺作品数
            merchServices.updateWorkNums(pageData);
            worksServices.delWorksByFid(workid);
            ResultUtils.writeSuccess(response);
        }catch (Exception e){
            logger.error("workOffShelf e="+e.getMessage());
            ResultUtils.writeFailed(response);
        }
        return null;
    }

}
