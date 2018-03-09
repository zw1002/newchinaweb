package com.hnqj.controller;

import com.hnqj.core.PageData;
import com.hnqj.core.ResponseUtil;
import com.hnqj.core.ResultUtils;
import com.hnqj.model.Graph;
import com.hnqj.services.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.File;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;
import java.util.UUID;

@Controller
@RequestMapping("/collection")
public class CollectionController extends  BaseController {
    @Autowired
    CollectiongraphServices collectiongraphServices;
    @Autowired
    CollectionsubmissionServices collectionsubmissionServices;
    @Autowired
    GraphServices graphServices;

    /**
     * 收藏任务
     * @param request
     * @param response
     * @return
     */
    @RequestMapping("/collectionGraph.do")
    public String getSubmissionByid(HttpServletRequest request, HttpServletResponse response) {
        String uid = request.getParameter("uid") == null ? "" : request.getParameter("uid");
        try{
            PageData pageData=new PageData();
            pageData.put("uid", UUID.randomUUID().toString());
            pageData.put("graphid", uid);
            pageData.put("collectionuserid", getUser().getUid());
            pageData.put("addtime", new Date());
            pageData.put("flag", 1);
            Graph graph=graphServices.getGraphforId(uid);
            int count=graph.getFavcount();
            int counts=count+1;
            PageData graphData=new PageData();
            graphData.put("uid",uid);
            graphData.put("favcount",counts);
            graphServices.updateGraphFavcount(graphData);
            int flag=collectiongraphServices.addCollectiongraph(pageData);
            if(flag == 1){
                ResultUtils.writeSuccess(response);
            }else{
                ResultUtils.writeFailed(response);
            }
        }catch (Exception e) {
            ResultUtils.writeFailed(response);
        }
        return null;
    }

    /**
     * 取消收藏任务
     * @param request
     * @param response
     * @return
     */
    @RequestMapping("/delcollectionGraph.do")
    public String delcollectionGraph(HttpServletRequest request, HttpServletResponse response) {
        String uid = request.getParameter("uid") == null ? "" : request.getParameter("uid");
        try{
            PageData pageData=new PageData();
            pageData.put("graphid", uid);
            pageData.put("collectionuserid", getUser().getUid());
            pageData.put("flag", 0);
            int flag=collectiongraphServices.updateCollectiongraph(pageData);
            if(flag == 1){
                ResultUtils.writeSuccess(response);
            }else{
                ResultUtils.writeFailed(response);
            }
        }catch (Exception e) {
            ResultUtils.writeFailed(response);
        }
        return null;
    }

    /**
     * 收藏稿件
     * @param request
     * @param response
     * @return
     */
    @RequestMapping("/collectionSubmission.do")
    public String collectionSubmission(HttpServletRequest request, HttpServletResponse response) {
        String uid = request.getParameter("uid") == null ? "" : request.getParameter("uid");
        try{
            PageData pageData=new PageData();
            pageData.put("uid", UUID.randomUUID().toString());
            pageData.put("submissionid", uid);
            pageData.put("collectionuserid", getUser().getUid());
            pageData.put("addtime", new Date());
            pageData.put("flag", 1);

            int flag=collectionsubmissionServices.addCollectionsubmission(pageData);
            if(flag == 1){
                ResultUtils.writeSuccess(response);
            }else{
                ResultUtils.writeFailed(response);
            }
        }catch (Exception e) {
            ResultUtils.writeFailed(response);
        }
        return null;
    }

    /**
     * 取消收藏稿件
     * @param request
     * @param response
     * @return
     */
    @RequestMapping("/delcollectionSubmission.do")
    public String delcollectionSubmission(HttpServletRequest request, HttpServletResponse response) {
        String uid = request.getParameter("uid") == null ? "" : request.getParameter("uid");
        try{
            PageData pageData=new PageData();
            pageData.put("submissionid", uid);
            pageData.put("collectionuserid", getUser().getUid());
            pageData.put("flag", 0);
            int flag=collectionsubmissionServices.updateCollectionsubmission(pageData);
            if(flag == 1){
                ResultUtils.writeSuccess(response);
            }else{
                ResultUtils.writeFailed(response);
            }
        }catch (Exception e) {
            ResultUtils.writeFailed(response);
        }
        return null;
    }


}
