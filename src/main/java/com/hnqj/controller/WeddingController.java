package com.hnqj.controller;
import com.hnqj.services.WorksServices;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpServletRequest;

/**
 * 婚秀控制层
 * 2018-01-10  张威
 */
@Controller
@RequestMapping("/wedding")
public class WeddingController extends BaseController{
    @Autowired
    WorksServices worksServices;
    //跳转到设计页面
    @RequestMapping(value = "/toWedding.do")
    public String toWedding(){
        return  "wedding";
    }
    //跳转到设计明细页面
    @RequestMapping(value = "/toWeddingDel.do")
    public String toWeddingDel(HttpServletRequest request, Model model){
        String uid = request.getParameter("uid") == null ? "" : request.getParameter("uid");
        model.addAttribute("uid", uid);//作品Id传到页面
        return  "wedding_del";
    }

}
