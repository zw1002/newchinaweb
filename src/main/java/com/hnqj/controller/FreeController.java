package com.hnqj.controller;
import com.hnqj.services.WorksServices;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

/**
 * 免费下载控制层
 * 2018-01-10  张威
 */
@Controller
@RequestMapping("/free")
public class FreeController extends BaseController{
    @Autowired
    WorksServices worksServices;
    //跳转到免费下载页面
    @RequestMapping(value = "/toFree.do")
    public String toFree(){
        return  "free";
    }
    //跳转到免费下载明细页面
    @RequestMapping(value = "/toFreeDel.do")
    public String toFreeDel(){
        return  "free_del";
    }

}
