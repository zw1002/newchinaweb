package com.hnqj.controller;
import com.hnqj.core.PageData;
import com.hnqj.core.ResultUtils;
import com.hnqj.model.Graph;
import com.hnqj.model.Submission;
import com.hnqj.model.Userinfo;
import com.hnqj.services.GraphServices;
import com.hnqj.services.SubmissionServices;
import com.hnqj.services.UserinfoServices;
import com.hnqj.services.WorksServices;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import static com.hnqj.core.ResultUtils.toDateTimeJson;
import static com.hnqj.core.ResultUtils.toJson;

/**
 * 客服中心控制层
 * 2018-01-10  张威
 */
@Controller
@RequestMapping("/helpd")
public class HelpController extends BaseController{
    @Autowired
    GraphServices graphServices;
    @Autowired
    UserinfoServices userinfoServices;
    @Autowired
    SubmissionServices submissionServices;
    //跳转到求图页面
    @RequestMapping(value = "/toHelp.do")
    public String toHelp(){
        return  "help";
    }
    //跳转到客服中心页面
    @RequestMapping(value = "/toHelpd.do")
    public String toHelpd(){
        return  "helpd_del";
    }
    //跳转到关于我们页面
    @RequestMapping(value = "/toAboutUs.do")
    public String toAboutUs(){
        return  "helpd_del2";
    }

    /**
     * 求图页面获取高额求图任务数据
     * @param request
     * @param response
     * @return
     */
    @RequestMapping("/getHighMoneyGraph.do")
    public String getHighMoneyGraph(HttpServletRequest request, HttpServletResponse response) {
        try {
            int offset = request.getParameter("offset") == null ? 0 : Integer.parseInt(request.getParameter("offset"));
            int count = request.getParameter("count") == null ? 0 : Integer.parseInt(request.getParameter("count"));
            PageData pageData = new PageData();
            pageData.put("offset",offset);
            pageData.put("count",count);
            List<Graph> graphList=graphServices.getAllGraphOrderByMoney(pageData);
            List<Map<String, Object>> hashMaps=new ArrayList<>();
            for(Graph graph:graphList){
                Map<String, Object> map = new HashMap<>();
                map.put("uid",graph.getUid());
                map.put("graphtitle",graph.getGraphtitle());
                map.put("moneyreward",graph.getMoneyreward());
                hashMaps.add(map);
            }
            ResultUtils.write(response,toJson(hashMaps));
        }catch (Exception e) {
            ResultUtils.writeFailed(response);
        }
        return null;
    }
    /**
     * 求图页面获取热门任务数据
     * @param request
     * @param response
     * @return
     */
    @RequestMapping("/getHotGraph.do")
    public String getHotGraph(HttpServletRequest request, HttpServletResponse response) {
        try {
            int offset = request.getParameter("offset") == null ? 0 : Integer.parseInt(request.getParameter("offset"));
            int count = request.getParameter("count") == null ? 0 : Integer.parseInt(request.getParameter("count"));
            PageData pageData = new PageData();
            pageData.put("offset",offset);
            pageData.put("count",count);
            List<Graph> graphList=graphServices.getAllGraphOrderByHot(pageData);
            List<Map<String, Object>> hashMaps=new ArrayList<>();
            for(Graph graph:graphList){
                Map<String, Object> map = new HashMap<>();
                map.put("uid",graph.getUid());
                map.put("graphtitle",graph.getGraphtitle());
                map.put("moneyreward",graph.getMoneyreward());
                hashMaps.add(map);
            }
            ResultUtils.write(response,toJson(hashMaps));
        }catch (Exception e) {
            ResultUtils.writeFailed(response);
        }
        return null;
    }
    /**
     * 求图页面获取最新任务数据
     * @param request
     * @param response
     * @return
     */
    @RequestMapping("/getNewGraph.do")
    public String getNewGraph(HttpServletRequest request, HttpServletResponse response) {
        try {
            int offset = request.getParameter("offset") == null ? 0 : Integer.parseInt(request.getParameter("offset"));
            int count = request.getParameter("count") == null ? 0 : Integer.parseInt(request.getParameter("count"));
            PageData pageData = new PageData();
            pageData.put("offset",offset);
            pageData.put("count",count);
            List<Graph> graphList=graphServices.getAllGraphOrderByNew(pageData);
            List<Map<String, Object>> hashMaps=new ArrayList<>();
            for(Graph graph:graphList){
                Map<String, Object> map = new HashMap<>();
                map.put("uid",graph.getUid());
                map.put("graphtitle",graph.getGraphtitle());
                map.put("moneyreward",graph.getMoneyreward());
                hashMaps.add(map);
            }
            ResultUtils.write(response,toJson(hashMaps));
        }catch (Exception e) {
            ResultUtils.writeFailed(response);
        }
        return null;
    }
    /**
     * 求图页面获取优秀投稿会员数据
     * @param request
     * @param response
     * @return
     */
    @RequestMapping("/getSubmissionUser.do")
    public String getSubmissionUser(HttpServletRequest request, HttpServletResponse response) {
        try {
            int offset = request.getParameter("offset") == null ? 0 : Integer.parseInt(request.getParameter("offset"));
            int count = request.getParameter("count") == null ? 0 : Integer.parseInt(request.getParameter("count"));
            PageData pageData = new PageData();
            pageData.put("offset",offset);
            pageData.put("count",count);
            List<Userinfo> userinfoList=userinfoServices.getSubmissionUser(pageData);
            List<Map<String, Object>> hashMaps=new ArrayList<>();
            for(Userinfo userinfo:userinfoList){
                Map<String, Object> map = new HashMap<>();
                map.put("uid",userinfo.getUid());
                map.put("userpicurl",userinfo.getUsrpicurl());
                map.put("username",userinfo.getFristname());
                map.put("bidnums",userinfo.getBidnums());
                map.put("winningbid",userinfo.getWinningbid());
                hashMaps.add(map);
            }
            ResultUtils.write(response,toJson(hashMaps));
        }catch (Exception e) {
            ResultUtils.writeFailed(response);
        }
        return null;
    }
    /**
     * 求图页面获取成功案例数据
     * @param request
     * @param response
     * @return
     */
    @RequestMapping("/getExcellentCase.do")
    public String getExcellentCase(HttpServletRequest request, HttpServletResponse response) {
        try {
            int offset = request.getParameter("offset") == null ? 0 : Integer.parseInt(request.getParameter("offset"));
            int count = request.getParameter("count") == null ? 0 : Integer.parseInt(request.getParameter("count"));
            PageData pageData = new PageData();
            pageData.put("offset",offset);
            pageData.put("count",count);
            List<Graph> graphList=graphServices.getExcellentCase(pageData);
            List<Map<String, Object>> hashMaps=new ArrayList<>();
            for(Graph graph:graphList){
                Map<String, Object> map = new HashMap<>();
                map.put("uid",graph.getUid());
                Submission submission=submissionServices.getSubmissionforId(graph.getBidsubmission());
                map.put("submissionname",submission.getWorksname());
                map.put("submissionurl",submission.getWatermakeurl());
                map.put("moneyreward",graph.getMoneyreward());
                hashMaps.add(map);
            }
            ResultUtils.write(response,toJson(hashMaps));
        }catch (Exception e) {
            ResultUtils.writeFailed(response);
        }
        return null;
    }

}
