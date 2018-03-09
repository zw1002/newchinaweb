package com.hnqj.controller;
import com.hnqj.core.PageData;
import com.hnqj.core.ResultUtils;
import com.hnqj.model.Leavemsg;
import com.hnqj.model.Merch;
import com.hnqj.model.Userinfo;
import com.hnqj.model.Works;
import com.hnqj.services.LeavemsgServices;
import com.hnqj.services.MerchServices;
import com.hnqj.services.UserinfoServices;
import com.hnqj.services.WorksServices;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.*;

import static com.hnqj.core.ResultUtils.toDateTimeJson;

/**
 * 会员中心控制层
 * 2018-01-10  张威
 */
@Controller
@RequestMapping("/member")
public class MemberController extends BaseController{
    @Autowired
    UserinfoServices userinfoServices;
    @Autowired
    LeavemsgServices leavemsgServices;
    @Autowired
    WorksServices worksServices;
    @Autowired
    MerchServices merchServices;
    //跳转到会员中心页面
    @RequestMapping(value = "/toMember.do")
    public String toMember(){
        return  "member";
    }

    /**
     * 添加作品评论
     * @param request
     * @param response
     * @return
     */
    @RequestMapping("/addLeaveMsg.do")
    public String addLeaveMsg(HttpServletRequest request, HttpServletResponse response) {
        logger.info("addLeaveMsg");
        try{
            String workid = request.getParameter("workid") == null ? "" : request.getParameter("workid");
            String content = request.getParameter("content") == null ? "" : request.getParameter("content");
            PageData pageData = new PageData();
            pageData.put("uid", UUID.randomUUID().toString());
            pageData.put("workid",workid);
            pageData.put("msgcontent",content);
            pageData.put("userid",getUser().getUid());
            pageData.put("msgtime",new Date());
            pageData.put("replycontent",0);
            int flag=leavemsgServices.addLeavemsg(pageData);
            if(flag == 1){
                ResultUtils.writeSuccess(response);
            }else{
                ResultUtils.writeFailed(response);
            }
        }catch (Exception e){
            logger.error("addLeaveMsg e="+e.getMessage());
            ResultUtils.writeFailed(response);
        }
        return null;
    }

    /**
     * 获取作品评论信息
     * @param request
     * @param response
     * @return
     */
    @RequestMapping("/getLeaveMsg.do")
    public String getLeaveMsg(HttpServletRequest request, HttpServletResponse response) {
        logger.info("getLeaveMsg");
        try{
            String uid = request.getParameter("uid") == null ? "" : request.getParameter("uid");
            List<Leavemsg> leavemsgList=leavemsgServices.getLeavemsgForWorkId(uid);
            List<Map<String, Object>> hashMaps=new ArrayList<>();
            for(Leavemsg leavemsg:leavemsgList){
                Map<String, Object> map = new HashMap<>();
                Works works=worksServices.getWorksforId(uid);
                Merch merch=merchServices.getMerchforId(works.getMerchid());
                Userinfo userinfo=userinfoServices.getUserinfoforId(merch.getUserinfouid());
                map.put("userid",userinfo.getUid());
                map.put("username",userinfo.getFristname());
                map.put("userpicurl",userinfo.getUsrpicurl());
                map.put("content",leavemsg.getMsgcontent());
                map.put("time",leavemsg.getMsgtime());
                hashMaps.add(map);
            }
            ResultUtils.write(response,toDateTimeJson(hashMaps));
        }catch (Exception e){
            logger.error("getLeaveMsg e="+e.getMessage());
            ResultUtils.writeFailed(response);
        }
        return null;
    }

}
