package com.hnqj.controller;
import com.hnqj.core.PageData;
import com.hnqj.core.ResultUtils;
import com.hnqj.model.*;
import com.hnqj.services.*;
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
    @Autowired
    CommentServices commentServices;
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
    @RequestMapping("/addComment.do")
    public String addComment(HttpServletRequest request, HttpServletResponse response) {
        logger.info("addComment");
        try{
            String workid = request.getParameter("workid") == null ? "" : request.getParameter("workid");
            String content = request.getParameter("content") == null ? "" : request.getParameter("content");
            PageData pageData = new PageData();
            pageData.put("uid", UUID.randomUUID().toString());
            pageData.put("worksid",workid);
            pageData.put("commentinfo",content);
            pageData.put("commentuserid",getUser().getUid());
            pageData.put("commenttime",new Date());
            pageData.put("delflg",0);
            int flag=commentServices.addComment(pageData);
            if(flag == 1){
                ResultUtils.writeSuccess(response);
            }else{
                ResultUtils.writeFailed(response);
            }
        }catch (Exception e){
            logger.error("addComment e="+e.getMessage());
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
    @RequestMapping("/getComment.do")
    public String getComment(HttpServletRequest request, HttpServletResponse response) {
        logger.info("getComment");
        try{
            String uid = request.getParameter("uid") == null ? "" : request.getParameter("uid");
            List<Comment> commentList=commentServices.getCommentForWorkId(uid);
            List<Map<String, Object>> hashMaps=new ArrayList<>();
            for(Comment comment:commentList){
                Map<String, Object> map = new HashMap<>();
                Userinfo userinfo=userinfoServices.getUserinfoforId(comment.getCommentuserid());
                map.put("userid",userinfo.getUid());
                map.put("username",userinfo.getFristname());
                map.put("userpicurl",userinfo.getUsrpicurl());
                map.put("content",comment.getCommentinfo());
                map.put("time",comment.getCommenttime());
                hashMaps.add(map);
            }
            ResultUtils.write(response,toDateTimeJson(hashMaps));
        }catch (Exception e){
            logger.error("getComment e="+e.getMessage());
            ResultUtils.writeFailed(response);
        }
        return null;
    }

}
