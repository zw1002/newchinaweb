package com.hnqj.controller;
import com.hnqj.core.PageData;
import com.hnqj.core.ResultUtils;
import com.hnqj.model.Cashrecord;
import com.hnqj.model.Works;
import com.hnqj.services.CashrecordServices;
import com.hnqj.services.WorksServices;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.Date;
import java.util.List;
import java.util.UUID;

import static com.hnqj.core.ResultUtils.toDateJson;
import static com.hnqj.core.ResultUtils.toDateTimeJson;

/**
 * 提现管理控制层
 * 2018-01-10  张威
 */
@Controller
@RequestMapping("/withdrawals")
public class WithdrawalsController extends BaseController{
    @Autowired
    CashrecordServices cashrecordServices;
    //跳转到我的作品页面
    @RequestMapping(value = "/toWithdrawals.do")
    public String toWithdrawals(HttpServletRequest request, Model model){
        String uid = request.getParameter("uid") == null ? "" : request.getParameter("uid");
        model.addAttribute("uid", uid);//会员Id传到页面
        return  "withdrawals";
    }

    /**
     * 根据提现状态获取个人提现数据
     * @param request
     * @param response
     * @return
     */
    @RequestMapping("/getCashRecordByState.do")
    public String getCashRecordByState(HttpServletRequest request, HttpServletResponse response) {
        logger.info("getCashRecordByState");
        try{
            String uid = request.getParameter("uid") == null ? "" : request.getParameter("uid");
            String state = request.getParameter("state") == null ? "" : request.getParameter("state");
            int offset = request.getParameter("offset") == null ? 0 : Integer.parseInt(request.getParameter("offset"));
            int count = request.getParameter("count") == null ? 0 : Integer.parseInt(request.getParameter("count"));
            PageData pageData = new PageData();
            pageData.put("userid",uid);
            pageData.put("offset",offset);
            pageData.put("count",count);
            pageData.put("state",state);
            List<Cashrecord> cashrecordList=cashrecordServices.getAllCashrecordByState(pageData);
            ResultUtils.write(response,toDateTimeJson(cashrecordList));
        }catch (Exception e){
            logger.error("getCashRecordByState e="+e.getMessage());
            ResultUtils.writeFailed(response);
        }
        return null;
    }

    /**
     * 提现申请
     * @param request
     * @param response
     * @return
     */
    @RequestMapping("/addCashRecord.do")
    public String addCashRecord(HttpServletRequest request, HttpServletResponse response) {
        logger.info("addCashRecord");
        try{
            String uid = request.getParameter("uid") == null ? "" : request.getParameter("uid");
            String balance = request.getParameter("balance") == null ? "" : request.getParameter("balance");
            String bank = request.getParameter("bank") == null ? "" : request.getParameter("bank");
            String bankaccount = request.getParameter("bankaccount") == null ? "" : request.getParameter("bankaccount");
            String bankaddress = request.getParameter("bankaddress") == null ? "" : request.getParameter("bankaddress");
            String bankuser = request.getParameter("bankuser") == null ? "" : request.getParameter("bankuser");
            PageData pageData = new PageData();
            pageData.put("cashuid",UUID.randomUUID().toString());
            pageData.put("applyuserid",uid);
            pageData.put("applypeople",bankuser);
            pageData.put("applynum",balance);
            pageData.put("cashtype",bank);
            pageData.put("cashaccount",bankaccount);
            pageData.put("applytime",new Date());
            pageData.put("cashstate",0);
            cashrecordServices.addCashrecord(pageData);
            ResultUtils.writeSuccess(response);
        }catch (Exception e){
            logger.error("addCashRecord e="+e.getMessage());
            ResultUtils.writeFailed(response);
        }
        return null;
    }

}
