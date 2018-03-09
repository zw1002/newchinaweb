package com.hnqj.controller;
import com.hnqj.services.WorksServices;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpServletRequest;

/**
 * 设计控制层
 * 2018-01-10  张威
 */
@Controller
@RequestMapping("/seachs")
public class SeachsController extends BaseController{
//    @Autowired
//    WorksServices worksServices;
    //跳转到搜索
    @RequestMapping(value = "/toSeachs.do")
    public String toSeachs(HttpServletRequest request, Model model){
        String seachTxt = request.getParameter("seachTxt") == null ? "  " : request.getParameter("seachTxt");
        String jysort = request.getParameter("jysort") == null ? "" : request.getParameter("jysort");
        String hxsort = request.getParameter("hxsort") == null ? "" : request.getParameter("hxsort");
        String zjsort = request.getParameter("zjsort") == null ? "" : request.getParameter("zjsort");
        String myjysort = request.getParameter("myjysort") == null ? "" : request.getParameter("myjysort");
        model.addAttribute("seachTxt", seachTxt);//搜索内容
        model.addAttribute("jysort", jysort);//搜索内容
        model.addAttribute("hxsort", hxsort);//搜索内容
        model.addAttribute("zjsort", zjsort);//搜索内容
        model.addAttribute("myjysort", myjysort);//搜索内容
        return  "seachs";
    }

}
