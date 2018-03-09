package com.hnqj.controller;
import com.hnqj.services.WorksServices;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpServletRequest;

/**
 * 道具控制层
 * 2018-01-10  张威
 */
@Controller
@RequestMapping("/multimedia")
public class MultimediaController extends BaseController{
    @Autowired
    WorksServices worksServices;
    //跳转到设计页面
    @RequestMapping(value = "/toMultimedia.do")
    public String toMultimedia(){
        return  "multimedia";
    }
    //跳转到设计明细页面
    @RequestMapping(value = "/toMultimediaDel.do")
    public String toMultimediaDel(HttpServletRequest request, Model model){
        String uid = request.getParameter("uid") == null ? "" : request.getParameter("uid");
        model.addAttribute("uid", uid);//作品Id传到页面
        return  "media_del";
    }

}
