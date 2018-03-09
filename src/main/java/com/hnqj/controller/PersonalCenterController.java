package com.hnqj.controller;

import com.hnqj.core.PageData;
import com.hnqj.core.ResultUtils;
import com.hnqj.model.*;
import com.hnqj.model.Collections;
import com.hnqj.services.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.*;

import static com.hnqj.core.ResultUtils.toDateJson;

/**
 *个人中心控制层
 * 2018-01-15  张威
 */
@Controller
@RequestMapping("/personalcenter")
public class PersonalCenterController extends  BaseController{
    @Autowired
    CollectionServices collectionServices;
    @Autowired
    WorksServices worksServices;
    @Autowired
    DealuidchildServices dealuidchildServices;
    @Autowired
    DealrecordServices dealrecordServices;
    @Autowired
    UserinfoServices userinfoServices;
    @Autowired
    MerchServices merchServices;
    @Autowired
    DictServices dictServices;
    @Autowired
    WorklabelServices worklabelServices;
    @Autowired
    DownloadServices downloadServices;
    @Autowired
    WorksViewsServices worksViewsServices;
    //跳转到开店页面
    @RequestMapping(value = "/toShop.do")
    public String toShop(){
        return  "shop";
    }
    //跳转到收藏页面
    @RequestMapping(value = "/toCollection.do")
    public String toCollection(){
        return  "collection_2";
    }
    //跳转到交易页面
    @RequestMapping(value = "/toTransaction.do")
    public String toTransaction(){
        return  "transaction";
    }
    //跳转到提现页面
    @RequestMapping(value = "/toWithdrawals.do")
    public String toWithdrawals(){
        return  "transaction";
    }
    //跳转到我的下载页面
    @RequestMapping(value = "/toDownload.do")
    public String toDownload(){
        return  "download";
    }

    /**
     * 完善个人信息
     * @param request
     * @param response
     * @return
     */
    @RequestMapping("/improveInformation.do")
    public String improveInformation(HttpServletRequest request, HttpServletResponse response) {
        logger.info("improveInformation");
        String merchname = request.getParameter("merchname") == null ? "" : request.getParameter("merchname");
        String userinfouid = request.getParameter("userinfouid") == null ? "" : request.getParameter("userinfouid");
        String bondvalue = request.getParameter("bondvalue") == null ? "" : request.getParameter("bondvalue");
        String remark = request.getParameter("remark") == null ? "" : request.getParameter("remark");
        return null;
    }
    /**
     * 开店申请
     * @param request
     * @param response
     * @return
     */
    @RequestMapping("/shop.do")
    public String shop(HttpServletRequest request, HttpServletResponse response) {
        logger.info("shop");
        String merchname = request.getParameter("merchname") == null ? "" : request.getParameter("merchname");
        String userinfouid = request.getParameter("userinfouid") == null ? "" : request.getParameter("userinfouid");
        String bondvalue = request.getParameter("bondvalue") == null ? "" : request.getParameter("bondvalue");
        String remark = request.getParameter("remark") == null ? "" : request.getParameter("remark");
        return null;
    }

    /**
     * 获取个人收藏作品
     * @param request
     * @param response
     * @return
     */
    @RequestMapping("/getCollectionData.do")
    public String getCollectionData(HttpServletRequest request, HttpServletResponse response) {
        logger.info("getCollectionData");
        try{
            int offset = request.getParameter("offset")== null ? 0 : Integer.parseInt(request.getParameter("offset"));
            int count = request.getParameter("count") == null ? 0 : Integer.parseInt(request.getParameter("count"));
            String userid = request.getParameter("userid") == null ? "" : request.getParameter("userid");
            PageData pageData = new PageData();
            pageData.put("userid",userid);
            pageData.put("offset",offset);
            pageData.put("count",count);
            List<Collections> list=collectionServices.selectCollectionsByUserId(pageData);
            List<Map<String, Object>> hashMaps=new ArrayList<>();
            for(Collections collection:list){
                Map<String, Object> map = new HashMap<>();
                map.put("worksid",collection.getWorksid());
                Works works=worksServices.getWorksforId(collection.getWorksid());
                map.put("worksname",works.getWorksname());
                map.put("worksurl",works.getSamllurl());
                map.put("price",works.getPrice());
                map.put("worklabel",works.getWorklabel());
                map.put("downcount",works.getDowncount());
                map.put("favcount",works.getFavcount());
                map.put("collectiontime",collection.getCollectiontime());
                hashMaps.add(map);
            }
            ResultUtils.write(response,hashMaps);
        }catch (Exception e){
            logger.error("getCollectionData e="+e.getMessage());
            ResultUtils.writeFailed(response);
        }
        return null;
    }

    /**
     * 取消收藏
     * @param request
     * @param response
     * @return
     */
    @RequestMapping("/delCollection.do")
    public String delCollection(HttpServletRequest request, HttpServletResponse response) {
        logger.info("delCollection");
        String workid = request.getParameter("workid") == null ? "" : request.getParameter("workid");
        String userid=getUser().getUid();
        PageData pageData=new PageData();
        pageData.put("workid",workid);
        pageData.put("userid",userid);
        try{
            collectionServices.delCollections(pageData);
            ResultUtils.writeSuccess(response);
        }catch(Exception e){
            logger.error("delCollection e="+e.getMessage());
            ResultUtils.writeFailed(response);
        }
        return null;
    }

    /**
     * 获取个人已出售作品
     * @param request
     * @param response
     * @return
     */
    @RequestMapping("/getAlreadySoldWorks.do")
    public String getAlreadySoldWorks(HttpServletRequest request, HttpServletResponse response) {
        logger.info("getAlreadySoldWorks");
        try{
            String userid=getUser().getUid();
            int offset = request.getParameter("offset") == null ? 0 : Integer.parseInt(request.getParameter("offset"));
            int count = request.getParameter("count") == null ? 0 : Integer.parseInt(request.getParameter("count"));
            PageData pageData = new PageData();
            pageData.put("userid",userid);
            pageData.put("offset",offset);
            pageData.put("count",count);
            List<Dealuidchild> dealuidchildList=dealuidchildServices.getDealuidchildForWorksId(pageData);
            List<Map<String, Object>> hashMaps=new ArrayList<>();
            for(Dealuidchild dealuidchild:dealuidchildList){
                Map<String, Object> map = new HashMap<>();
                map.put("worksid",dealuidchild.getWorksid());
                Works works=worksServices.getWorksforId(dealuidchild.getWorksid());
                map.put("worksname",works.getWorksname());
                map.put("worksurl",works.getSamllurl());
                map.put("price",works.getPrice());
                map.put("worklabel",works.getWorklabel());
                map.put("addtime",dealuidchild.getAddtime());
                Userinfo userinfo=userinfoServices.getUserinfoforId(dealuidchild.getPayuserid());
                map.put("payUserPic",userinfo.getUsrpicurl());
                map.put("payUsername",userinfo.getFristname());
                hashMaps.add(map);
            }
            ResultUtils.write(response,toDateJson(hashMaps));
        }catch(Exception e){
            logger.error("getAlreadySoldWorks e="+e.getMessage());
            ResultUtils.writeFailed(response);
        }
        return null;
    }

    /**
     * 获取个人已购买作品
     * @param request
     * @param response
     * @return
     */
    @RequestMapping("/getAlreadyPurchasedWorks.do")
    public String getAlreadyPurchasedWorks(HttpServletRequest request, HttpServletResponse response) {
        logger.info("getAlreadyPurchasedWorks");
        try{
            String userid=getUser().getUid();
            int offset = request.getParameter("offset") == null ? 0 : Integer.parseInt(request.getParameter("offset"));
            int count = request.getParameter("count") == null ? 0 : Integer.parseInt(request.getParameter("count"));
            PageData pageData = new PageData();
            pageData.put("userid",userid);
            pageData.put("offset",offset);
            pageData.put("count",count);
            List<Dealuidchild> dealuidchildList=dealuidchildServices.getDealuidchildForPayUserId(pageData);
            List<Map<String, Object>> hashMaps=new ArrayList<>();
            for(Dealuidchild dealuidchild:dealuidchildList){
                Map<String, Object> map = new HashMap<>();
                map.put("worksid",dealuidchild.getWorksid());
                Works works=worksServices.getWorksforId(dealuidchild.getWorksid());
                map.put("worksname",works.getWorksname());
                map.put("worksurl",works.getSamllurl());
                map.put("price",works.getPrice());
                map.put("worklabel",works.getWorklabel());
                map.put("addtime",dealuidchild.getAddtime());
                Merch merch=merchServices.getMerchforId(works.getMerchid());
                Userinfo userinfo=userinfoServices.getUserinfoforId(merch.getUserinfouid());
                map.put("payUserPic",userinfo.getUsrpicurl());
                map.put("payUsername",userinfo.getFristname());
                hashMaps.add(map);
            }
            ResultUtils.write(response,toDateJson(hashMaps));
        }catch(Exception e){
            logger.error("getAlreadyPurchasedWorks e="+e.getMessage());
            ResultUtils.writeFailed(response);
        }
        return null;
    }

    /**
     * 获取个人待付款交易
     * @param request
     * @param response
     * @return
     */
    @RequestMapping("/getWaitPayDealrecode.do")
    public String getWaitPayDealrecode(HttpServletRequest request, HttpServletResponse response) {
        logger.info("getWaitPayDealrecode");
        try{
            String userid=getUser().getUid();
            int offset = request.getParameter("offset") == null ? 0 : Integer.parseInt(request.getParameter("offset"));
            int count = request.getParameter("count") == null ? 0 : Integer.parseInt(request.getParameter("count"));
            PageData pageData = new PageData();
            pageData.put("userid",userid);
            pageData.put("offset",offset);
            pageData.put("count",count);
            List<Dealrecord> dealrecordList=dealrecordServices.getDealrecordForPayUserId(pageData);
            List<Map<String, Object>> hashMaps=new ArrayList<>();
            for(Dealrecord dealrecord:dealrecordList){
                Map<String, Object> map = new HashMap<>();
                String [] workids=dealrecord.getBusinesid().split(",");
                String worknames="";
                for(int i=0;i<workids.length;i++){
                    worknames += worksServices.getWorksforId(workids[i]).getWorksname()+",";
                }
                map.put("dealuid",dealrecord.getDealuid());
                map.put("worksname",worknames);
                map.put("price",dealrecord.getDealprice());
                hashMaps.add(map);
            }
            ResultUtils.write(response,toDateJson(hashMaps));
        }catch(Exception e){
            logger.error("getWaitPayDealrecode e="+e.getMessage());
            ResultUtils.writeFailed(response);
        }
        return null;
    }

    /**
     * 根据作品类别获取作品分类
     * @param request
     * @param response
     * @return
     */
    @RequestMapping("/getWorkClassification.do")
    public String getWorkClassification(HttpServletRequest request, HttpServletResponse response) {
        logger.info("getWorkClassification");
        String workstype = request.getParameter("workstype") == null ? "" : request.getParameter("workstype");
        try{
            List<Dict> dictList=dictServices.getDictForValue(workstype);
            ResultUtils.write(response,dictList);
        }catch(Exception e){
            logger.error("getWorkClassification e="+e.getMessage());
            ResultUtils.writeFailed(response);
        }
        return null;
    }

    /**
     * 根据作品分类获取作品标签
     * @param request
     * @param response
     * @return
     */
    @RequestMapping("/getWorklabelByWorktype.do")
    public String getWorklabelByWorktype(HttpServletRequest request, HttpServletResponse response) {
        logger.info("getWorklabelByWorktype");
        String code = request.getParameter("code") == null ? "" : request.getParameter("code");
        try{
            List<Worklabel> worklabelList=worklabelServices.getWorksForCode(code);
            ResultUtils.write(response,worklabelList);
        }catch(Exception e){
            logger.error("getWorklabelByWorktype e="+e.getMessage());
            ResultUtils.writeFailed(response);
        }
        return null;
    }

    /**
     * 和获取个人付款成功后可下载的作品
     * @param request
     * @param response
     * @return
     */
    @RequestMapping("/getDownloadWorksByUserid.do")
    public String getDownloadWorksByUserid(HttpServletRequest request, HttpServletResponse response) {
        logger.info("getDownloadWorksByUserid");
        String userid=getUser().getUid();
        int offset = request.getParameter("offset") == null ? 0 : Integer.parseInt(request.getParameter("offset"));
        int count = request.getParameter("count") == null ? 0 : Integer.parseInt(request.getParameter("count"));
        PageData pageData = new PageData();
        pageData.put("userid",userid);
        pageData.put("offset",offset);
        pageData.put("count",count);
        try{
            List<Download> downloadList=downloadServices.selectDownloadListByUserId(pageData);
            ResultUtils.write(response,toDateJson(downloadList));
        }catch(Exception e){
            logger.error("getDownloadWorksByUserid e="+e.getMessage());
            ResultUtils.writeFailed(response);
        }
        return null;
    }
    /**
     * 删除待付款作品
     * @param request
     * @param response
     * @return
     */
    @RequestMapping("/delWaitPayDealrecod.do")
    public String delWaitPayDealrecod(HttpServletRequest request, HttpServletResponse response) {
        logger.info("delWaitPayDealrecod");
        String dealuid = request.getParameter("dealuid") == null ? "" : request.getParameter("dealuid");
        try{
            dealrecordServices.delDealrecordByFid(dealuid);
            ResultUtils.writeSuccess(response);
        }catch(Exception e){
            logger.error("delWaitPayDealrecod e="+e.getMessage());
            ResultUtils.writeFailed(response);
        }
        return null;
    }

    /**
     * 根据交易ID获取交易数据
     * @param request
     * @param response
     * @return
     */
    @RequestMapping("/getDealrecodByDealuid.do")
    public String getDealrecodByDealuid(HttpServletRequest request, HttpServletResponse response) {
        logger.info("getDealrecodByDealuid");
        String dealuid = request.getParameter("dealuid") == null ? "" : request.getParameter("dealuid");
        try{
            Dealrecord dealrecord=dealrecordServices.getDealrecordforId(dealuid);
            ResultUtils.write(response,dealrecord);
        }catch(Exception e){
            logger.error("getDealrecodByDealuid e="+e.getMessage());
            ResultUtils.writeFailed(response);
        }
        return null;
    }

    /**
     * 查询个人浏览记录
     * @param request
     * @param response
     * @return
     */
    @RequestMapping("/getPersonWorksViews.do")
    public String getPersonWorksViews(HttpServletRequest request, HttpServletResponse response) {
        logger.info("getPersonWorksViews");
        int offset = request.getParameter("offset") == null ? 0 : Integer.parseInt(request.getParameter("offset"));
        int count = request.getParameter("count") == null ? 0 : Integer.parseInt(request.getParameter("count"));
        String userid=getUser().getUid();
        PageData pageData=new PageData();
        pageData.put("offset",offset);
        pageData.put("count",count);
        pageData.put("userid",userid);
        try{
            List<Map<String, Object>> hashMaps=new ArrayList<>();
            List<WorksViews> worksViewsList=worksViewsServices.getAllWorksViews(pageData);
            for(WorksViews worksViews:worksViewsList){
                Works works=worksServices.getWorksforId(worksViews.getWorksid());
                if(works != null){
                    Map<String, Object> map = new HashMap<>();
                    map.put("workname",works.getWorksname());
                    map.put("workid",works.getUid());
                    map.put("workstype",works.getWorkstype());
                    map.put("worksamllurl",works.getSamllurl());
                    map.put("workurl",works.getWorksurl());
                    map.put("downcount",works.getDowncount());
                    map.put("ticknums",works.getTicknums().toString());
                    hashMaps.add(map);
                }
            }
            ResultUtils.write(response,hashMaps);
        }catch(Exception e){
            logger.error("getPersonWorksViews e="+e.getMessage());
            ResultUtils.writeFailed(response);
        }
        return null;
    }
}
