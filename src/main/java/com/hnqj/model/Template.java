package com.hnqj.model;

public class Template {
    /**
     *
     * This field was generated by MyBatis Generator.
     * This field corresponds to the database column tb_template.templateuid
     *
     * @mbg.generated Tue Jan 09 11:34:57 CST 2018
     */
    private String templateuid;

    /**
     *
     * This field was generated by MyBatis Generator.
     * This field corresponds to the database column tb_template.templatetype
     *
     * @mbg.generated Tue Jan 09 11:34:57 CST 2018
     */
    private String templatetype;

    /**
     *
     * This field was generated by MyBatis Generator.
     * This field corresponds to the database column tb_template.templateurl
     *
     * @mbg.generated Tue Jan 09 11:34:57 CST 2018
     */
    private String templateurl;

    /**
     * This method was generated by MyBatis Generator.
     * This method returns the value of the database column tb_template.templateuid
     *
     * @return the value of tb_template.templateuid
     *
     * @mbg.generated Tue Jan 09 11:34:57 CST 2018
     */
    public String getTemplateuid() {
        return templateuid;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method sets the value of the database column tb_template.templateuid
     *
     * @param templateuid the value for tb_template.templateuid
     *
     * @mbg.generated Tue Jan 09 11:34:57 CST 2018
     */
    public void setTemplateuid(String templateuid) {
        this.templateuid = templateuid == null ? null : templateuid.trim();
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method returns the value of the database column tb_template.templatetype
     *
     * @return the value of tb_template.templatetype
     *
     * @mbg.generated Tue Jan 09 11:34:57 CST 2018
     */
    public String getTemplatetype() {
        return templatetype;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method sets the value of the database column tb_template.templatetype
     *
     * @param templatetype the value for tb_template.templatetype
     *
     * @mbg.generated Tue Jan 09 11:34:57 CST 2018
     */
    public void setTemplatetype(String templatetype) {
        this.templatetype = templatetype == null ? null : templatetype.trim();
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method returns the value of the database column tb_template.templateurl
     *
     * @return the value of tb_template.templateurl
     *
     * @mbg.generated Tue Jan 09 11:34:57 CST 2018
     */
    public String getTemplateurl() {
        return templateurl;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method sets the value of the database column tb_template.templateurl
     *
     * @param templateurl the value for tb_template.templateurl
     *
     * @mbg.generated Tue Jan 09 11:34:57 CST 2018
     */
    public void setTemplateurl(String templateurl) {
        this.templateurl = templateurl == null ? null : templateurl.trim();
    }
}