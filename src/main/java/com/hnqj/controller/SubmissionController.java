package com.hnqj.controller;

import com.hnqj.core.PageData;
import com.hnqj.core.ResponseUtil;
import com.hnqj.core.ResultUtils;
import com.hnqj.core.imageUtil;
import com.hnqj.model.Graph;
import com.hnqj.model.Works;
import com.hnqj.services.GraphServices;
import com.hnqj.services.SubmissionServices;
import com.hnqj.services.UserinfoServices;
import com.hnqj.services.WorksServices;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import javax.imageio.ImageIO;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.awt.image.BufferedImage;
import java.io.File;
import java.io.IOException;
import java.math.BigDecimal;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.*;

import static com.hnqj.core.ResultUtils.toDateJson;
import static com.hnqj.core.ResultUtils.toDateTimeJson;

@Controller
@RequestMapping("/submission")
public class SubmissionController extends  BaseController {
    @Autowired
    GraphServices graphServices;
    @Autowired
    SubmissionServices submissionServices;
    @Autowired
    UserinfoServices userinfoServices;

    /**
     * 跳转到投稿页面
     * @param request
     * @param model
     * @return
     */
    @RequestMapping(value = "/toTouGao.do")
    public String toTouGao(HttpServletRequest request, Model model){
        String uid = request.getParameter("uid") == null ? "" : request.getParameter("uid");
        //为任务添加点击量
        Graph graph=graphServices.getGraphforId(uid);
        int count=graph.getTicknums();
        int counts=count+1;
        PageData pageData=new PageData();
        pageData.put("uid",uid);
        pageData.put("ticknums",counts);
        graphServices.updateGraphTicknums(pageData);
        model.addAttribute("uid",uid);//任务ID
        return  "tougao";
    }

    /**
     * 获取任务详情
     * @param request
     * @return
     */
    @RequestMapping(value = "/getGraphByUid.do")
    public String getGraphByUid(HttpServletRequest request, HttpServletResponse response){
        String uid = request.getParameter("uid") == null ? "" : request.getParameter("uid");
        try{
            Graph graph=graphServices.getGraphforId(uid);
            Map<String, Object> map = new HashMap<>();
            map.put("uid",graph.getUid());
            map.put("graphtitle",graph.getGraphtitle());
            map.put("addtime",graph.getAddtime());
            map.put("favcount",graph.getFavcount());
            map.put("graphclassification",graph.getGraphclassification());
            map.put("graphdetail",graph.getGraphdetail());
            map.put("graphtype",graph.getGraphtype());
            map.put("endtime",graph.getEndtime());
            map.put("state",graph.getState());
            map.put("moneyreward",graph.getMoneyreward());
            map.put("ticknums",graph.getTicknums());
            map.put("username",userinfoServices.getUserinfoforId(graph.getUserid()).getFristname());
            ResultUtils.write(response,toDateJson(map));
        }catch (Exception e) {
            ResultUtils.writeFailed(response);
        }
        return  null;
    }
    /**
     * 文件下载
     * @param request
     * @param response
     * @return
     */
    @RequestMapping("/downloadFile.do")
    public String downloadFile(HttpServletRequest request, HttpServletResponse response) {
        String uid = request.getParameter("uid") == null ? "" : request.getParameter("uid");
        String HOMEPATH = request.getSession().getServletContext().getRealPath("/");
        try {
            Graph graph=graphServices.getGraphforId(uid);
            // 首先清理缓冲区的内容
            response.reset();
            //String destFileName = works.getWorksname()+works.getImgformart();//文件名称
            int lastIndex = graph.getEnclosureurl().lastIndexOf("\\");
            String destFileName = graph.getEnclosureurl().substring(lastIndex,graph.getEnclosureurl().length());//文件名称
            String sourceFilePathName = graph.getEnclosureurl();//原件地址
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
    /**
     * 投稿
     */
    @RequestMapping("/addSubmission.do")
    @ResponseBody
    public Object addSubmission(@RequestParam(value = "file") MultipartFile[] files, HttpServletRequest request, HttpServletResponse response) {
        logger.info("addSubmission");
        String uid = request.getParameter("uid") == null ? "" : request.getParameter("uid");
        String worksname = request.getParameter("worksname") == null ? "" : request.getParameter("worksname");
        String colrmodel = request.getParameter("colrmodel") == null ? "" : request.getParameter("colrmodel");
        String remark = request.getParameter("remark") == null ? "" : request.getParameter("remark");
        String finduid = request.getParameter("finduid") == null ? "" : request.getParameter("finduid");
        String HOMEPATH = request.getSession().getServletContext().getRealPath("/") + "static/uploadSubmission/";
        DateFormat dateFormate = new SimpleDateFormat("yyyy-MM-dd");
        String today = dateFormate.format(new Date());
        String UPLOADDIR = "upload" + File.separator;
        String savePath = HOMEPATH + UPLOADDIR
                + today + File.separator;
        String relativePath = "/static/uploadSubmission/"+UPLOADDIR + today + File.separator;
        File f1 = new File(savePath);
        if (!f1.exists()) {
            f1.mkdirs();
        }
        for(MultipartFile file:files){
            String myFileName = file.getOriginalFilename();
            String extName = "";
            if (myFileName.trim() != "") {
                long byteSize = file.getSize();
                //重命名上传后的文件名
                if (myFileName.lastIndexOf(".") >= 0) {
                    extName = myFileName.substring(myFileName.lastIndexOf("."));
                }
                File localFile = new File(savePath + myFileName);//上传文件是真实名称
                BigDecimal fileSize = null;
                String measuring = "";
                double fileSizes=0;
                if (byteSize >= 1024 * 1024) {
                    double f = byteSize * 1.0 / (1024 * 1000);
                    fileSize = new BigDecimal(f);
                    fileSizes = fileSize.setScale(2, BigDecimal.ROUND_HALF_UP).doubleValue();
                    measuring = "MB";
                } else {
                    double f = byteSize * 1.0 / (1024);
                    fileSize = new BigDecimal(f);
                    fileSizes = fileSize.setScale(2, BigDecimal.ROUND_HALF_UP).doubleValue();
                    measuring = "KB";
                }
                PageData pageData = new PageData();
                pageData.put("worksname",worksname);
                pageData.put("finduid",finduid);
                pageData.put("uptime",new Date());
                pageData.put("colrmodel",colrmodel);
                pageData.put("favcount",0);
                pageData.put("displayflag",0);
                pageData.put("delflag",0);
                pageData.put("ticknums",0);
                pageData.put("remark",remark);
                pageData.put("userid",getUser().getUid());
                pageData.put("uid", uid);
                pageData.put("worksurl", relativePath + myFileName);
                pageData.put("imgsize", fileSizes + measuring);
                pageData.put("imgformart", extName);
                try {
                    file.transferTo(localFile);//原件
                    submissionServices.updateSubmission(pageData);
                    Map<String, Object> map = new HashMap<String, Object>();
                    map.put("uid",finduid);
                    return map;
                } catch (IOException e) {
                    e.printStackTrace();
                }
            }
        }
        return null;
    }
    /**
     * 投稿文件上传
     */
    @RequestMapping("/uploadSubmission.do")
    @ResponseBody
    public Object uploadSubmission(@RequestParam(value = "file") MultipartFile[] files, HttpServletRequest request, HttpServletResponse response) {
        logger.info("uploadSubmission");
        String HOMEPATH = request.getSession().getServletContext().getRealPath("/") + "static/uploadSubmission/";
        DateFormat dateFormate = new SimpleDateFormat("yyyy-MM-dd");
        String today = dateFormate.format(new Date());
        String UPLOADDIR = "upload" + File.separator;
        String savePath = HOMEPATH + UPLOADDIR
                + today + File.separator;
        String relativePath = "/static/uploadSubmission/"+UPLOADDIR + today + File.separator;
        String path = "";
        String uid="";
        File f1 = new File(savePath);
        if (!f1.exists()) {
            f1.mkdirs();
        }
        for(MultipartFile file:files){
            Long time = new Date().getTime();
            String myFileName = file.getOriginalFilename();
            String extName = "";
            if (myFileName.trim() != "") {
                long byteSize = file.getSize();
                //重命名上传后的文件名
                if (myFileName.lastIndexOf(".") >= 0) {
                    extName = myFileName.substring(myFileName.lastIndexOf("."));
                }
                File localFile = new File(savePath + myFileName);//上传文件是真实名称
                String str=relativePath.replace("\\","/");
                path = str + myFileName;
                uid=UUID.randomUUID().toString();
                try {
                    file.transferTo(localFile);
                    PageData pageData=new PageData();
                    pageData.put("uid",uid);
                    BufferedImage image  = ImageIO.read(new File(savePath + myFileName));
                    String dpinum=image.getWidth() + "x" + image.getHeight();
                    pageData.put("dpinum",dpinum);
                    pageData.put("watermakeurl",relativePath + myFileName);
                    //pageData.put("samllurl",relativePath +"thumb_"+ myFileName);
                    //new imageUtil().thumbnailImage(localFile,280,320);//缩略图
                    submissionServices.addSubmission(pageData);
                    Map<String, Object> map = new HashMap<String, Object>();
                    map.put("uid",uid);
                    return map;
                } catch (IOException e) {
                    e.printStackTrace();
                }
            }
        }
        return null;
    }

}
