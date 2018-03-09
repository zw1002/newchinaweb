package com.hnqj.controller;
import com.hnqj.core.PageData;
import com.hnqj.core.ResultUtils;
import com.hnqj.model.Merch;
import com.hnqj.model.Userinfo;
import com.hnqj.services.MerchServices;
import com.hnqj.services.UserinfoServices;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.Date;
import java.util.UUID;

/**
 * 店铺信息控制层
 * 2018-01-10  张威
 */
@Controller
@RequestMapping("/merch")
public class MerchController extends BaseController{
    @Autowired
    UserinfoServices userinfoServices;
    @Autowired
    MerchServices merchServices;

    /**
     * 开店
     * @param request
     * @param response
     * @return
     */
    @RequestMapping("/addMerchData.do")
    public String addMerchData(HttpServletRequest request, HttpServletResponse response) {
        logger.info("addMerchData");
        String merchname = request.getParameter("merchname") == null ? "" : request.getParameter("merchname");
        String merchremark = request.getParameter("merchremark") == null ? "" : request.getParameter("merchremark");
        PageData pageData=new PageData();
        pageData.put("uid", UUID.randomUUID().toString());
        pageData.put("merchname",merchname);
        pageData.put("userinfouid",getUser().getUid());
        pageData.put("builddatetime",new Date());
        pageData.put("bondvalue",0);
        pageData.put("merchscroe",0);
        pageData.put("statu",0);
        pageData.put("worksnums",0);
        pageData.put("dealnums",0);
        pageData.put("remark",merchremark);
        try{
            Merch merch=merchServices.getMerchForUserId(getUser().getUid());
            if(merch == null){
                merchServices.addMerch(pageData);
            }else{
                PageData pageData1=new PageData();
                pageData1.put("uid",merch.getUid());
                pageData1.put("merchname",merchname);
                pageData1.put("remark",merchremark);
                merchServices.updateMerchMsg(pageData1);
            }
            ResultUtils.writeSuccess(response);
        }catch (Exception e){
            logger.error("addMerchData e="+e.getMessage());
            ResultUtils.writeFailed(response);
        }
        return null;
    }

    /**
     * 根据ID获取店铺信息
     * @param request
     * @param response
     * @return
     */
    @RequestMapping("/getMerchData.do")
    public String getMerchData(HttpServletRequest request, HttpServletResponse response) {
        logger.info("getMerchData");
        try{
            String uid = request.getParameter("uid") == null ? "" : request.getParameter("uid");
            Merch merch=merchServices.getMerchForUserId(uid);
            ResultUtils.write(response,merch);
        }catch (Exception e){
            logger.error("getMerchData e="+e.getMessage());
            ResultUtils.writeFailed(response);
        }
        return null;
    }

}
