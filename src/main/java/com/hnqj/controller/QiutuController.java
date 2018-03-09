package com.hnqj.controller;
import com.hnqj.core.PageData;
import com.hnqj.core.ResultUtils;
import com.hnqj.model.Leavemsg;
import com.hnqj.model.Merch;
import com.hnqj.model.Userinfo;
import com.hnqj.model.Works;
import com.hnqj.services.LeavemsgServices;
import com.hnqj.services.MerchServices;
import com.hnqj.services.UserinfoServices;
import com.hnqj.services.WorksServices;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.*;

import static com.hnqj.core.ResultUtils.toDateTimeJson;

/**
 * 求助求图控制层
 * 2018-01-10  张威
 */
@Controller
@RequestMapping("/qiutu")
public class QiutuController extends BaseController{
    //跳转到求助求图页面
    @RequestMapping(value = "/toQiutu.do")
    public String toQiutu(){
        return  "qiutu";
    }

}
