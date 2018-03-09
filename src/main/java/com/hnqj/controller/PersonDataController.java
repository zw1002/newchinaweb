package com.hnqj.controller;
import com.hnqj.core.EncodeUtil;
import com.hnqj.core.PageData;
import com.hnqj.core.ResultUtils;
import com.hnqj.model.Account;
import com.hnqj.model.Dict;
import com.hnqj.model.Syslog;
import com.hnqj.model.Userinfo;
import com.hnqj.services.AccountServices;
import com.hnqj.services.DictServices;
import com.hnqj.services.SyslogServices;
import com.hnqj.services.UserinfoServices;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.MultiValueMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.support.DefaultMultipartHttpServletRequest;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.File;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.List;

/**
 * 个人资料控制层
 * 2018-01-10  张威
 */
@Controller
@RequestMapping("/persondata")
public class PersonDataController extends BaseController{
    @Autowired
    UserinfoServices userinfoServices;
    @Autowired
    SyslogServices syslogservices;
    @Autowired
    DictServices dictservices;
    @Autowired
    AccountServices accountServices;
    //跳转到个人资料页面
    @RequestMapping(value = "/toPersonData.do")
    public String toPersonData(HttpServletRequest request, Model model){
       //根据SESSION获取所有个人信息，并输出到前端

try{
        Userinfo userinfo = (Userinfo)request.getSession().getAttribute("userinfo");
        userinfo = userinfoServices.getUserinfoforId(userinfo.getUid());
        request.getSession().setAttribute("userinfo",userinfo);
        //获取银行信息
        Account accinfo = accountServices.getAccountforId(userinfo.getUid());
        model.addAttribute("accinfo",accinfo);
}catch (Exception ee){
    return  "index";
}
        return  "persondata";
    }
    //查询用户日志信息persondata/getUserOperatLog.do
    @RequestMapping(value = "/getUserOperatLog.do")
    public String getUserOperatLog(HttpServletRequest request, HttpServletResponse response)
    {
        String strVal="";
        logger.info("getUserOperatLog");
        String uuids = request.getParameter("uid") == null ? "" : request.getParameter("uid");

        String logType = request.getParameter("logType") == null ? "" : request.getParameter("logType");
        String logStime = request.getParameter("logStime") == null ? "" : request.getParameter("logStime");
        String logEtime = request.getParameter("logEtime") == null ? "" : request.getParameter("logEtime");
        int page = request.getParameter("page") == null ? 1 : Integer.parseInt(request.getParameter("page"));
        int limit = request.getParameter("limit") == null ? 10 : Integer.parseInt(request.getParameter("limit"));

        PageData pageData=new PageData();
        pageData.put("username",uuids);
        pageData.put("logtype",logType);
        pageData.put("minTime",logStime);
        pageData.put("maxTime",logEtime);
        pageData.put("offset",((page-1)*limit));
        pageData.put("limit",limit);

        try{
            List<Syslog> logs = syslogservices.getAllSyslog(pageData);
            pageData.put("limit",0);
            List<Syslog> logCount = syslogservices.getAllSyslog(pageData);

            strVal="{\"code\":0,\"msg\":\"\",\"count\":"+logCount.size()+",\"data\":"+ResultUtils.toJson(logs)+"}";

            ResultUtils.write(response,strVal);
        }catch (Exception e){
            logger.error("getUserOperatLog e="+e.getMessage());
            strVal="{\"code\":1,\"msg\":\"\",\"count\":0,\"data\":[]}";
            ResultUtils.write(response,strVal);
        }
        return null;
    }

    //重置密码persondata/restPassword.do
    @RequestMapping(value = "/restPassword.do")
    public String restPassword(HttpServletRequest request, HttpServletResponse response)
    {
        String strVal="";
        logger.info("restPassword");
        String newPassword = request.getParameter("newPassword") == null ? "" : request.getParameter("newPassword");
        String oldPassword = request.getParameter("oldPassword") == null ? "" : request.getParameter("oldPassword");
        String uid = request.getParameter("uid") == null ? "" : request.getParameter("uid");

        PageData pageData=new PageData();
        pageData.put("userid", uid);
        pageData.put("passwd", EncodeUtil.encodeMD5(newPassword));
        oldPassword = EncodeUtil.encodeMD5(oldPassword);

        try {
            PageData pd1 = new PageData();
            pd1.put("userid", uid);
            pd1.put("passwd", oldPassword);
            Userinfo uinfo = userinfoServices.getUserInfoForUid(pd1);
            if (uinfo == null) {
                ResultUtils.write(response, "密码重置失败,旧密码输入错误!");
            } else if (userinfoServices.restPassword(pageData) > 0)

                ResultUtils.writeSuccess(response);
            else
                ResultUtils.write(response, "密码重置失败,稍后重试");

        }catch (Exception e){
            logger.error("restPassword e="+e.getMessage());

            ResultUtils.write(response,"密码重置失败,稍后重试");
        }
        return null;
    }

    //用户信息认证persondata/userSfzUp.do
    @RequestMapping(value = "/userSfzUp.do")
    public String userSfzUp(HttpServletRequest request, HttpServletResponse response)
    {
        String strVal="";
        logger.info("userSfzUp");

        String uid = request.getParameter("uid") == null ? "" : request.getParameter("uid");
        String zxname = request.getParameter("zsname") == null ? "" : request.getParameter("zsname");
        String sfzh = request.getParameter("sfzcode") == null ? "" : request.getParameter("sfzcode");
        String sfzdate = request.getParameter("sfzdate") == null ? "" : request.getParameter("sfzdate");
        String sex = request.getParameter("sex") == null ? "" : request.getParameter("sex");
        String sfzImgUrl=request.getParameter("upload") == null ? "" : request.getParameter("upload");

        PageData pageData=new PageData();
        pageData.put("uid", uid);
        pageData.put("firstname",zxname);
        pageData.put("iccode",sfzh);
        pageData.put("sfzdate",sfzdate);
        pageData.put("sex",sex);
        pageData.put("idpic",sfzImgUrl);
        try{

            if(userinfoServices.updateUserinfo(pageData)>0)
                ResultUtils.writeSuccess(response);
            else ResultUtils.write(response,"认证信息保存失败,稍后重试");

        }catch (Exception e){
            logger.error("userSfzUp e="+e.getMessage());

            ResultUtils.write(response,"认证信息保存失败,请重试");
        }
        return null;
    }
    //用户信息绑定persondata/userInfoBind.do
    @RequestMapping(value = "/userInfoBind.do")
    public String userInfoBind(HttpServletRequest request, HttpServletResponse response)
    {
        String strVal="";
        logger.info("userInfoBind");
        String uid = request.getParameter("uid") == null ? "" : request.getParameter("uid");
        String phone = request.getParameter("phone") == null ? "" : request.getParameter("phone");
        String email = request.getParameter("email") == null ? "" : request.getParameter("email");
        String weibo = request.getParameter("weibo") == null ? "" : request.getParameter("weibo");
        String bankcode = request.getParameter("bankcode") == null ? "" : request.getParameter("bankcode");
        String bankaddr = request.getParameter("bankaddr") == null ? "" : request.getParameter("bankaddr");


        PageData pageData=new PageData();
        pageData.put("uid", uid);
        pageData.put("telephone",phone);
        pageData.put("email",email);
        pageData.put("weibo",weibo);
        pageData.put("bankcode",bankcode);
        pageData.put("bankaddr",bankaddr);

        try{

            if(userinfoServices.updateUserinfo(pageData)>0)
                ResultUtils.writeSuccess(response);
            else ResultUtils.write(response,"绑定信息失败,稍后重试");

            ResultUtils.writeSuccess(response);
        }catch (Exception e){
            logger.error("userInfoBind e="+e.getMessage());

            ResultUtils.write(response,"绑定信息失败,稍后重试");
        }
        return null;
    }

    //用户基础信息persondata/userBaseInfo.do
    @RequestMapping(value = "/userBaseInfo.do")
    public String userBaseInfo(HttpServletRequest request, HttpServletResponse response)
    {

        logger.info("userBaseInfo");
        String uid = request.getParameter("uid") == null ? "" : request.getParameter("uid");
        String ofphone = request.getParameter("officephone") == null ? "" : request.getParameter("officephone");
        String email = request.getParameter("email") == null ? "" : request.getParameter("email");
        String address = request.getParameter("address") == null ? "" : request.getParameter("address");
        String usertype = request.getParameter("usertype") == null ? "" : request.getParameter("usertype");
        String userlabel = request.getParameter("userlabel") == null ? "" : request.getParameter("userlabel");
        String nicheng = request.getParameter("nicheng") == null ? "" : request.getParameter("nicheng");
        String qqid = request.getParameter("qqid") == null ? "" : request.getParameter("qqid");
        String msnid = request.getParameter("msnid") == null ? "" : request.getParameter("msnid");
        String imglogo = request.getParameter("imglogo") == null ? "" : request.getParameter("imglogo");



        PageData pageData=new PageData();
        pageData.put("uid", uid);
        pageData.put("ofphone",ofphone);
        pageData.put("email",email);
        pageData.put("address",address);
        pageData.put("zhiye",usertype);
        pageData.put("label",userlabel);
        pageData.put("smname",nicheng);
        pageData.put("qqid",qqid);
        pageData.put("msnid",msnid);
        pageData.put("usrpicurl",imglogo);

        try{

            if(userinfoServices.updateUserinfo(pageData)>0)
                ResultUtils.writeSuccess(response);
            else ResultUtils.write(response,"信息更新失败,稍后重试");

        }catch (Exception e){
            logger.error("userBaseInfo e="+e.getMessage());

            ResultUtils.write(response,"信息更新失败,稍后重试");
        }
        return null;
    }

    //文件上传persondata/upFileInfo.do
    @RequestMapping(value = "/upFileInfo.do")
    public String upFileInfo(HttpServletRequest request, HttpServletResponse response)
    {
        String strVal="";
        logger.info("upFileInfo");

        String upFile = request.getParameter("upFile") == null ? "" : request.getParameter("upFile");
        if(!upFile.equals("")) {
            try {
                MultiValueMap<String, MultipartFile> multFiles = ((DefaultMultipartHttpServletRequest) request).getMultiFileMap();
                List<MultipartFile> files = multFiles.get("file");
                String HOMEPATH = request.getSession().getServletContext().getRealPath("/") + "static/uploadImg/"+upFile+"/";
                // 如果目录不存在则创建
                File uploadDir = new File(HOMEPATH);
                if (!uploadDir.exists()) {
                    uploadDir.mkdir();
                }
                String sfzImgUrl = "";
                for (MultipartFile file : files) {//读取文件并上保存

                    String myFileName = file.getOriginalFilename();
                    SimpleDateFormat df = new SimpleDateFormat("yyyyMMddHHmmss");//设置日期格式df.format(new Date())

                    myFileName = getUser().getUid()+upFile + myFileName;

                    //保存文件
                    File localFile = new File(HOMEPATH + myFileName);
                    file.transferTo(localFile);
                    sfzImgUrl = "/static/uploadImg/"+upFile+"/" + myFileName;
                }
                ResultUtils.write(response, "{\"code\":0,\"msg\":\"上传成功!\",\"data\":\"" + sfzImgUrl + "\"}");//
            } catch (IOException e) {
                e.printStackTrace();
                ResultUtils.write(response, "{\"code\":1111,\"msg\":\"上传失败!\",\"data\":\"\"}");//
            }

        }
        else
            ResultUtils.write(response,"{\"code\":1111,\"msg\":\"上传失败!\",\"data\":\"\"}");//
        return null;
    }
}
