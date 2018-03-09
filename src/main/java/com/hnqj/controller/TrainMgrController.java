package com.hnqj.controller;
import com.hnqj.core.PageData;
import com.hnqj.core.ResultUtils;
import com.hnqj.model.Train;
import com.hnqj.services.TrainServices;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;


/**
 * 名师管理控制层
 * 2018-02-26
 */
@Controller
@RequestMapping("/trainMgr")
public class TrainMgrController extends BaseController{
    @Autowired
    TrainServices trainServices;
    //跳转到名师列表  /trainMgr/toTrainList.do
    @RequestMapping(value = "/toTrainList.do")
    public String toTrainList(){ return  "trainlist";}
    //跳转到名师列表   /trainMgr/toTrainDetails.do
    @RequestMapping(value = "/toTrainDetails.do")
    public String toTrainDetails(HttpServletRequest request, HttpServletResponse response, Model model){
        String uid = request.getParameter("tuid") == null ? "" : request.getParameter("tuid");
        model.addAttribute("tuid", uid);//搜索内容
        return  "traindetails";
    }

    //获取名师列表   /trainMgr/GetTrainList.do
    @RequestMapping(value = "/GetTrainList.do")
    public String GetTrainList(HttpServletRequest request, HttpServletResponse response){
        logger.info("GetTrainList");

        String startCount = request.getParameter("offset") == null ? "0" : request.getParameter("offset");
        String limit = request.getParameter("count") == null ? "" : request.getParameter("count");
        List<Map<String, String>> hashMaps=new ArrayList<>();
        try{
            PageData pageData = new PageData();

            pageData.put("offset",Integer.parseInt(startCount));
            if(limit.equals(""))
                pageData.put("count",null);
            else
                pageData.put("count",Integer.parseInt(limit));

            List<Train> dealuidchildList=trainServices.getAllTrain(pageData);
            for(Train work:dealuidchildList){
                Map<String, String> map = new HashMap<>();
                map.put("teruid",work.getTeruid());
                map.put("trainname",work.getTrainname());
                map.put("createtime",work.getCreatetime());
                map.put("logoimg",work.getLogoimg());
                map.put("traincontent",work.getTraincontent());
                map.put("trainmethod",work.getTrainmethod());
                map.put("coursename",work.getCoursename());
                map.put("trainaddress",work.getTrainaddress());
                map.put("topflag",work.getTopflag());
                map.put("vnums","0");//阅读数量
                map.put("cnums","0");//评论数量
                hashMaps.add(map);
            }
            pageData.put("count",null);
            List<Train> dealuidchildList2=trainServices.getAllTrain(pageData);
            String strResults="{\"code\":\"0000\",\"res\":"+ResultUtils.toJson(hashMaps)+",\"count\":"+dealuidchildList2.size()+"}";
            ResultUtils.write(response,strResults);
        }catch (Exception e){
            logger.error("GetTrainList e="+e.getMessage());
            ResultUtils.writeFailed(response);
        }
        return null;
    }
    //获取名师培训详情   /trainMgr/GetTrainDetails.do
    @RequestMapping(value = "/GetTrainDetails.do")
    public String GetTrainDetails(HttpServletRequest request, HttpServletResponse response){
        logger.info("GetTrainDetails");

        String teruid = request.getParameter("tuid") == null ? "" : request.getParameter("tuid");

        try{

            if(teruid.equals("")){
                ResultUtils.writeFailed(response);
            }

            Train trainModel =trainServices.getTrainforId(teruid);

            ResultUtils.write(response,trainModel);
        }catch (Exception e){
            logger.error("GetTrainDetails e="+e.getMessage());
            ResultUtils.writeFailed(response);
        }
        return null;
    }
}

