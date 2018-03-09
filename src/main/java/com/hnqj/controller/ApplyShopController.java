package com.hnqj.controller;
import com.hnqj.services.MerchServices;
import com.hnqj.services.WorksServices;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

/**
 * 开店控制层
 * 2018-01-10  张威
 */
@Controller
@RequestMapping("/applyshop")
public class ApplyShopController extends BaseController{
    @Autowired
    MerchServices merchServices;
    //跳转到开店页面
    @RequestMapping(value = "/toApplyShop.do")
    public String toApplyShop(){
        return  "applyshop";
    }

}
