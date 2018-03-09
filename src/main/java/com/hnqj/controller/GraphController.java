package com.hnqj.controller;

import com.hnqj.core.PageData;
import com.hnqj.core.ResponseUtil;
import com.hnqj.core.ResultUtils;
import com.hnqj.core.imageUtil;
import com.hnqj.model.*;
import com.hnqj.services.*;
import org.apache.commons.fileupload.disk.DiskFileItem;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.commons.CommonsMultipartFile;
import sun.misc.BASE64Encoder;

import javax.imageio.ImageIO;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.awt.image.BufferedImage;
import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.IOException;
import java.math.BigDecimal;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.*;

import static com.hnqj.core.ResultUtils.toDateJson;
import static com.hnqj.core.ResultUtils.toDateTimeJson;

@Controller
@RequestMapping("/graph")
public class GraphController extends  BaseController {
    @Autowired
    WorksServices worksServices;
    @Autowired
    GraphServices graphServices;
    @Autowired
    GraphleavingmsgServices graphleavingmsgServices;
    @Autowired
    UserinfoServices userinfoServices;
    @Autowired
    SubmissionServices submissionServices;
    @Autowired
    CollectiongraphServices collectiongraphServices;
    @Autowired
    CollectionsubmissionServices collectionsubmissionServices;

    private String UPLOADDIR = "upload" + File.separator;
    /**
     * 添加求图数据
     * @param files
     * @param request
     * @return
     */
    @RequestMapping("/filesUpload.do")
    //requestParam要写才知道是前台的那个数组
    public Object filesUpload(@RequestParam("file") MultipartFile[] files, HttpServletRequest request) {
        String graphtype = request.getParameter("graphtype") == null ? "" : request.getParameter("graphtype");
        String graphclassification = request.getParameter("graphclassification") == null ? "" : request.getParameter("graphclassification");
        String graphtitle = request.getParameter("graphtitle") == null ? "" : request.getParameter("graphtitle");
        String graphdetail = request.getParameter("graphdetail") == null ? "" : request.getParameter("graphdetail");
        String moneyreward = request.getParameter("moneyreward") == null ? "" : request.getParameter("moneyreward");
        String endtime = request.getParameter("endtime") == null ? "" : request.getParameter("endtime");
        String HOMEPATH = request.getSession().getServletContext().getRealPath("/") + "static/uploadImg/";
        DateFormat dateFormate = new SimpleDateFormat("yyyy-MM-dd");
        String today = dateFormate.format(new Date());
        String savePath = HOMEPATH + UPLOADDIR
                + today + File.separator;
        String relativePath = "/static/uploadImg/"+UPLOADDIR + today + File.separator;
        File f1 = new File(savePath);
        if (!f1.exists()) {
            f1.mkdirs();
        }
        for(MultipartFile file:files){
            String myFileName = file.getOriginalFilename();
            if (myFileName.trim() != "") {
                File localFile = new File(savePath + myFileName);//上传文件是真实名称
                PageData pageData = new PageData();
                pageData.put("uid",UUID.randomUUID().toString());
                pageData.put("graphclassification",graphclassification);
                pageData.put("graphtype",graphtype);
                pageData.put("graphtitle",graphtitle);
                pageData.put("graphdetail",graphdetail);
                pageData.put("moneyreward",moneyreward);
                pageData.put("addtime",new Date());
                pageData.put("enclosureurl",relativePath+myFileName);
                pageData.put("favcount",0);
                pageData.put("displayflag",0);
                pageData.put("delflag",0);
                pageData.put("ticknums",0);
                pageData.put("submissionnums",0);
                pageData.put("endtime",endtime);
                pageData.put("userid",getUser().getUid());
                try {
                    file.transferTo(localFile);//原件
                    int flag=graphServices.addGraph(pageData);
                    Map<String, Object> map = new HashMap<String, Object>();
                    if(flag == 1){
                        map.put("state","true");
                    }else{
                        map.put("state","false");
                    }
                    return map;
                } catch (IOException e) {
                    e.printStackTrace();
                }
            }
        }
        return null;
    }

    /**
     * 获取个人求图任务
     * @param request
     * @param response
     * @return
     */
    @RequestMapping("/getMyGraph.do")
    public String getMyGraph(HttpServletRequest request, HttpServletResponse response) {
        String userid=getUser().getUid();
        try {
            List<Graph> graphList=graphServices.getGraphByUserId(userid);
            List<Map<String, Object>> hashMaps=new ArrayList<>();
            for(Graph graph:graphList){
                Map<String, Object> map = new HashMap<>();
                map.put("uid",graph.getUid());
                map.put("graphtitle",graph.getGraphtitle());
                map.put("addtime",graph.getAddtime());
                map.put("favcount",graph.getFavcount());
                map.put("graphclassification",graph.getGraphclassification());
                map.put("graphdetail",graph.getGraphdetail());
                map.put("graphtype",graph.getGraphtype());
                map.put("moneyreward",graph.getMoneyreward());
                map.put("ticknums",graph.getTicknums());
                hashMaps.add(map);
            }
            ResultUtils.write(response,toDateTimeJson(hashMaps));
        }catch (Exception e) {
            ResultUtils.writeFailed(response);
        }
        return null;
    }

    /**
     * 我的稿件
     * @param request
     * @param response
     * @return
     */
    @RequestMapping("/getMySubmission.do")
    public String getMySubmission(HttpServletRequest request, HttpServletResponse response) {
        String userid=getUser().getUid();
        try {
            List<Graph> graphList=graphServices.getMySubmissionByUserId(userid);
            List<Map<String, Object>> hashMaps=new ArrayList<>();
            for(Graph graph:graphList){
                Map<String, Object> map = new HashMap<>();
                map.put("uid",graph.getUid());
                map.put("graphtitle",graph.getGraphtitle());
                map.put("addtime",graph.getAddtime());
                map.put("favcount",graph.getFavcount());
                map.put("graphclassification",graph.getGraphclassification());
                map.put("graphdetail",graph.getGraphdetail());
                map.put("graphtype",graph.getGraphtype());
                map.put("moneyreward",graph.getMoneyreward());
                map.put("ticknums",graph.getTicknums());
                Submission submission=submissionServices.getSubmissionforId(graph.getBidsubmission());
                Userinfo userinfo=userinfoServices.getUserinfoforId(submission.getUserid());
                map.put("subusername",userinfo.getFristname());
                map.put("subuserpicurl",userinfo.getUsrpicurl());
                map.put("suburl",submission.getWorksurl());
                map.put("submissionid",submission.getUid());
                hashMaps.add(map);
            }
            ResultUtils.write(response,toDateTimeJson(hashMaps));
        }catch (Exception e) {
            ResultUtils.writeFailed(response);
        }
        return null;
    }

    /**
     * 获取个人任务收藏
     * @param request
     * @param response
     * @return
     */
    @RequestMapping("/getCollectionGraph.do")
    public String getCollectionGraph(HttpServletRequest request, HttpServletResponse response) {
        String userid=getUser().getUid();
        try {
            List<Collectiongraph> collectiongraphList=collectiongraphServices.getCollectiongraphByUserId(userid);
            List<Map<String, Object>> hashMaps=new ArrayList<>();
            for(Collectiongraph collectiongraph:collectiongraphList){
                Map<String, Object> map = new HashMap<>();
                map.put("uid",collectiongraph.getUid());
                map.put("graphid",collectiongraph.getGraphid());
                map.put("addtime",collectiongraph.getAddtime());
                Graph graph=graphServices.getGraphforId(collectiongraph.getGraphid());
                map.put("graphtitle",graph.getGraphtitle());
                map.put("moneyreward",graph.getMoneyreward());
                map.put("graphclassification",graph.getGraphclassification());
                map.put("graphdetail",graph.getGraphdetail());
                map.put("graphtype",graph.getGraphtype());
                hashMaps.add(map);
            }
            ResultUtils.write(response,toDateTimeJson(hashMaps));
        }catch (Exception e) {
            ResultUtils.writeFailed(response);
        }
        return null;
    }
    /**
     * 获取个人稿件收藏
     * @param request
     * @param response
     * @return
     */
    @RequestMapping("/getCollectionSubmission.do")
    public String getCollectionSubmission(HttpServletRequest request, HttpServletResponse response) {
        String userid=getUser().getUid();
        try {
            List<Collectionsubmission> collectionsubmissionList=collectionsubmissionServices.getCollectionsubmissionByUserId(userid);
            List<Map<String, Object>> hashMaps=new ArrayList<>();
            for(Collectionsubmission collectionsubmission:collectionsubmissionList){
                Map<String, Object> map = new HashMap<>();
                map.put("uid",collectionsubmission.getUid());
                map.put("submissionid",collectionsubmission.getSubmissionid());
                map.put("addtime",collectionsubmission.getAddtime());
                Submission submission=submissionServices.getSubmissionforId(collectionsubmission.getSubmissionid());
                map.put("worksname",submission.getWorksname());
                map.put("colrmodel",submission.getColrmodel());
                map.put("imgformart",submission.getImgformart());
                Userinfo userinfo=userinfoServices.getUserinfoforId(submission.getUserid());
                map.put("username",userinfo.getFristname());
                map.put("userpicurl",userinfo.getUsrpicurl());
                Graph graph=graphServices.getGraphforId(submission.getFinduid());
                map.put("graphtitle",graph.getGraphtitle());
                map.put("graphid",graph.getUid());
                map.put("moneyreward",graph.getMoneyreward());
                map.put("graphclassification",graph.getGraphclassification());
                map.put("graphdetail",graph.getGraphdetail());
                map.put("graphtype",graph.getGraphtype());
                map.put("waterurl",submission.getWatermakeurl());
                hashMaps.add(map);
            }
            ResultUtils.write(response,toDateTimeJson(hashMaps));
        }catch (Exception e) {
            ResultUtils.writeFailed(response);
        }
        return null;
    }

    //获取稿件
    @RequestMapping("/getSubmissionByid.do")
    public String getSubmissionByid(HttpServletRequest request, HttpServletResponse response) {
        String uid = request.getParameter("uid") == null ? "" : request.getParameter("uid");
        try {
            List<Submission> submissionList=submissionServices.getSubmissionByGraphId(uid);
            Graph graph=graphServices.getGraphforId(uid);
            List<Map<String, Object>> hashMaps=new ArrayList<>();
            for(Submission submission:submissionList){
                Map<String, Object> map = new HashMap<>();
                map.put("uid",submission.getUid());
                map.put("worksname",submission.getWorksname());
                map.put("uptime",submission.getUptime());
                map.put("samllurl",submission.getSamllurl());
                map.put("watermakeurl",submission.getWatermakeurl());
                map.put("worksurl",submission.getWorksurl());
                map.put("dpinum",submission.getDpinum());
                map.put("imgsize",submission.getImgsize());
                map.put("imgformart",submission.getImgformart());
                map.put("colrmodel",submission.getColrmodel());
                map.put("remark",submission.getRemark());
                map.put("bidSubmission",graph.getBidsubmission());
                Userinfo userinfo=userinfoServices.getUserinfoforId(submission.getUserid());
                map.put("submissionusername",userinfo.getFristname());
                map.put("submissionuserpicurl",userinfo.getUsrpicurl());
                hashMaps.add(map);
            }
            ResultUtils.write(response,toDateTimeJson(hashMaps));
        } catch (Exception e) {
            ResultUtils.writeFailed(response);
        }
        return null;
    }
    //获取评论
    @RequestMapping("/getLeavingmsgByid.do")
    public String getLeavingmsgByid(HttpServletRequest request, HttpServletResponse response) {
        String uid = request.getParameter("uid") == null ? "" : request.getParameter("uid");
        try{
            List<Graphleavingmsg> graphleavingmsgList=graphleavingmsgServices.getGraphleavingmsgByGraphId(uid);
            List<Map<String, Object>> hashMaps=new ArrayList<>();
            for(Graphleavingmsg graphleavingmsg:graphleavingmsgList){
                Map<String, Object> map = new HashMap<>();
                map.put("uid",graphleavingmsg.getUid());
                map.put("addtime",graphleavingmsg.getAddtime());
                map.put("content",graphleavingmsg.getContent()+"!");
                Userinfo userinfo=userinfoServices.getUserinfoforId(graphleavingmsg.getLeavinguserid());
                map.put("leavingusername",userinfo.getFristname());
                map.put("leavinguserpicurl",userinfo.getUsrpicurl());
                hashMaps.add(map);
            }
            ResultUtils.write(response,toDateTimeJson(hashMaps));
        }catch (Exception e) {
            ResultUtils.writeFailed(response);
        }
        return null;
    }

    /**
     * 发表评论
     * @param request
     * @param response
     * @return
     */
    @RequestMapping("/addLeavingmsg.do")
    public String addLeavingmsg(HttpServletRequest request, HttpServletResponse response) {
        String uid = request.getParameter("uid") == null ? "" : request.getParameter("uid");
        String content = request.getParameter("content") == null ? "" : request.getParameter("content");
        try{
            PageData pageData=new PageData();
            pageData.put("uid",UUID.randomUUID().toString());
            pageData.put("graphid",uid);
            pageData.put("leavinguserid",getUser().getUid());
            pageData.put("content",content);
            pageData.put("addtime",new Date());
            int flag=graphleavingmsgServices.addGraphleavingmsg(pageData);
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
     * 选稿
     * @param request
     * @param response
     * @return
     */
    @RequestMapping("/draftSelection.do")
    public String draftSelection(HttpServletRequest request, HttpServletResponse response) {
        String uid = request.getParameter("uid") == null ? "" : request.getParameter("uid");
        String graphid = request.getParameter("graphid") == null ? "" : request.getParameter("graphid");
        try{
            PageData pageData=new PageData();
            pageData.put("uid",graphid);
            pageData.put("bidsubmission",uid);
            pageData.put("graphendtime",new Date());
            pageData.put("state",4);//任务结束
            int flag=graphServices.updateGraphSelection(pageData);
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
     * 文件下载
     * @param request
     * @param response
     * @return
     */
    @RequestMapping("/downloadFile.do")
    public String downloadFile(HttpServletRequest request, HttpServletResponse response) {
        String submission = request.getParameter("submission") == null ? "" : request.getParameter("submission");
        String HOMEPATH = request.getSession().getServletContext().getRealPath("/");
        try {
                Submission submission1=submissionServices.getSubmissionforId(submission);
                // 首先清理缓冲区的内容
                response.reset();
                String destFileName = submission1.getWorksname()+submission1.getImgformart();//文件名称
                String sourceFilePathName = submission1.getWorksurl();//原件地址
                File newfile = new File(sourceFilePathName);
                if (!newfile.exists()) {
                    sourceFilePathName = HOMEPATH + sourceFilePathName;
                    // 处理兼容老数据
                    newfile = new File(sourceFilePathName);
                    if (!newfile.exists()) {
                        return null;
                    }
                }
                ResponseUtil.downloadFile(response, newfile, destFileName);
        } catch (Exception e) {
            ResultUtils.writeFailed(response);
        }
        return null;
    }
}
