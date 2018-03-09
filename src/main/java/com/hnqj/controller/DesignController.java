package com.hnqj.controller;
import com.hnqj.core.PageData;
import com.hnqj.core.ResultUtils;
import com.hnqj.model.Account;
import com.hnqj.model.Userinfo;
import com.hnqj.services.AccountServices;
import com.hnqj.services.UserinfoServices;
import com.hnqj.services.WorksServices;
import com.hnqj.services.WorksViewsServices;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;
import java.util.UUID;

import static com.hnqj.core.EncodeUtil.encodeMD5;

/**
 * 设计控制层
 * 2018-01-10  张威
 */
@Controller
@RequestMapping("/design")
public class DesignController extends BaseController{
    @Autowired
    WorksServices worksServices;
    @Autowired
    WorksViewsServices worksviewsServices;
    //跳转到设计页面
    @RequestMapping(value = "/toDesign.do")
    public String toDesign(){
        return  "design";
    }
    //跳转到设计明细页面
    @RequestMapping(value = "/toDesignDel.do")
    public String toDesignDel(HttpServletRequest request, Model model){
        String uid = request.getParameter("uid") == null ? "" : request.getParameter("uid");
        model.addAttribute("uid", uid);//作品Id传到页面
        if(getUser()!=null){
            PageData pageData=new PageData();
            pageData.put("user_id",getUser().getUid());
            //pageData.put("user_name",getUser().getFristname());
            pageData.put("worksid",uid);
            SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
            pageData.put("viewtime",df.format(new Date()));
            //pageData.put("viewip",request.getHeader("x-forwarded-for") == null?request.getRemoteAddr():request.getHeader("x-forwarded-for"));
            //记录点击次数
            worksServices.UpdateWoksTrcknum(uid);
            //添加浏览记录
            worksviewsServices.addWorksView(pageData);
        }
        return  "design_del";
    }

}
