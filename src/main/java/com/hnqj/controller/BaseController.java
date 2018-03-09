package com.hnqj.controller;

import com.hnqj.model.Userinfo;
import com.hnqj.services.UserinfoServices;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.context.request.RequestAttributes;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

/**
 * 张威 2017/11
 */
public class BaseController {
    protected final Log logger = LogFactory.getLog(getClass());
    /**
     * 获取Session
     *
     * @return
     */
    public HttpSession getSession() {
        RequestAttributes ra = RequestContextHolder.getRequestAttributes();
        HttpServletRequest request = ((ServletRequestAttributes) ra).getRequest();
        return request.getSession();
    }
    /**
     * 获取用户
     *
     * @return
     */
    public Userinfo getUser() {
        RequestAttributes ra = RequestContextHolder.getRequestAttributes();
        HttpServletRequest request = ((ServletRequestAttributes) ra).getRequest();
        Userinfo user = (Userinfo) request.getSession().getAttribute("userinfo");
        return user;
    }

}
