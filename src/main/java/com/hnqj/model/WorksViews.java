package com.hnqj.model;

/**
 * 作品浏览足迹
 */
public class WorksViews {

    private String user_id;
    private String user_name;
    private String worksid;
    private String viewtime;
    private String viewip;


    /**
     * 获取用户ID
     */
    public String getUser_id() {
        return user_id;
    }

    /**
     * 设置用户ID
     */
    public void setUser_id(String value) {
        this.user_id = value;
    }

    /**
     * 获取用户名称
     */
    public String getUser_name() {
        return user_name;
    }

    /**
     * 设置用户名称
     */
    public void setUser_name(String value) {
        this.user_name = value;
    }

    /**
     * 获取作品ID
     */
    public String getWorksid() {
        return worksid;
    }

    /**
     * 设置作品ID
     */
    public void setWorksid(String value) {
        this.worksid = value;
    }

    /**
     * 获取浏览时间
     */
    public String getViewtime() {
        return viewtime;
    }

    /**
     * 设置浏览时间
     */
    public void setViewtime(String value) {
        this.viewtime = value;
    }

    /**
     * 获取浏览IP
     */
    public String getViewip() {
        return viewip;
    }

    /**
     * 设置浏览IP
     */
    public void setViewip(String value) {
        this.viewip = value;
    }
}