package com.hnqj.controller;
import com.hnqj.core.PageData;
import com.hnqj.core.ResultUtils;
import com.hnqj.model.Dealuidchild;
import com.hnqj.model.Playimg;
import com.hnqj.model.Train;
import com.hnqj.model.Works;
import com.hnqj.services.DealuidchildServices;
import com.hnqj.services.PlayimgServices;
import com.hnqj.services.TrainServices;
import com.hnqj.services.WorksServices;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.*;

import static com.hnqj.core.ResultUtils.toDateJson;

/**
 * 首页控制层
 * 2018-01-10  张威
 */
@Controller
@RequestMapping("/index")
public class IndexController extends BaseController{
    @Autowired
    PlayimgServices playimgServices;
    @Autowired
    DealuidchildServices dealuidchildServices;
    @Autowired
    WorksServices worksServices;
    @Autowired
    TrainServices trainServices;
    /**
     * 获取首页轮播图
     * @param request
     * @param response
     * @return
     */
    @RequestMapping("/getPlayImg.do")
    public String getPlayImg(HttpServletRequest request, HttpServletResponse response) {
        logger.info("getPlayImg");
        try{
            List<Playimg> playimgList=playimgServices.selectPlayimgList();
            ResultUtils.write(response,playimgList);
        }catch (Exception e){
            logger.error("getPlayImg e="+e.getMessage());
            ResultUtils.writeFailed(response);
        }
        return null;
    }

    /**
     * 交易动态
     * @param request
     * @param response
     * @return
     */
    @RequestMapping("/getTransaction.do")
    public String getTransaction(HttpServletRequest request, HttpServletResponse response) {
        logger.info("getTransaction");
        String uid = request.getParameter("uid") == null ? "" : request.getParameter("uid");
        int offset = request.getParameter("offset") == null ? 0 : Integer.parseInt(request.getParameter("offset"));
        int count = request.getParameter("count") == null ? 0 : Integer.parseInt(request.getParameter("count"));
        PageData pageData=new PageData();
        pageData.put("offset",offset);
        pageData.put("count",count);
        pageData.put("uid",uid);
        try{
            List<Dealuidchild> dealuidchildList=dealuidchildServices.selectDealuidchildList(pageData);
            List<Map<String, Object>> hashMaps=new ArrayList<>();
            for(Dealuidchild dealuidchild:dealuidchildList){
                Map<String, Object> map = new HashMap<>();
                map.put("workid",dealuidchild.getWorksid());
                Works works=worksServices.getWorksforId(dealuidchild.getWorksid());
                if(works != null){
                    map.put("worksamllurl",works.getSamllurl());
                }else{
                    map.put("worksamllurl","");
                }
                map.put("workname",works.getWorksname());
                map.put("worktype",works.getWorkstype());
                map.put("worksprice",dealuidchild.getWorksprice());
                map.put("downcount",works.getDowncount());
                map.put("ticknums",works.getTicknums().toString());
                Date date=dealuidchild.getAddtime();
                long time=(new Date().getTime()-date.getTime())/(1000*60);
                if(time > 60){
                    map.put("time","60分钟前");
                }else{
                    map.put("time",time+"分钟前");
                }
                hashMaps.add(map);
            }
            ResultUtils.write(response,hashMaps);
        }catch (Exception e){
            logger.error("getTransaction e="+e.getMessage());
            ResultUtils.writeFailed(response);
        }
        return null;
    }

    /**
     * 名师面对面   根据顶置标识获取未删除数据
     * @param request
     * @param response
     * @return
     */
    @RequestMapping("/getTain.do")
    public String getTain(HttpServletRequest request, HttpServletResponse response) {
        logger.info("getTain");
        //标识是否搜索顶置的数据
        String flag = request.getParameter("flag") == null ? "" : request.getParameter("flag");
        List<Train> trainList=trainServices.selectTrainListByCount(flag);
        ResultUtils.write(response,toDateJson(trainList));
        return null;
    }

}
