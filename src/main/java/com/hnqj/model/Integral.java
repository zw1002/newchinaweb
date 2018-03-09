package com.hnqj.model;

import java.math.BigDecimal;

public class Integral {
    /**
     *
     * This field was generated by MyBatis Generator.
     * This field corresponds to the database column tb_integral.uid
     *
     * @mbg.generated Tue Jan 09 11:34:57 CST 2018
     */
    private String uid;

    /**
     *
     * This field was generated by MyBatis Generator.
     * This field corresponds to the database column tb_integral.mininum
     *
     * @mbg.generated Tue Jan 09 11:34:57 CST 2018
     */
    private Integer mininum;

    /**
     *
     * This field was generated by MyBatis Generator.
     * This field corresponds to the database column tb_integral.maxinum
     *
     * @mbg.generated Tue Jan 09 11:34:57 CST 2018
     */
    private Integer maxinum;

    /**
     *
     * This field was generated by MyBatis Generator.
     * This field corresponds to the database column tb_integral.grade
     *
     * @mbg.generated Tue Jan 09 11:34:57 CST 2018
     */
    private Integer grade;

    /**
     *
     * This field was generated by MyBatis Generator.
     * This field corresponds to the database column tb_integral.divided
     *
     * @mbg.generated Tue Jan 09 11:34:57 CST 2018
     */
    private BigDecimal divided;

    /**
     *
     * This field was generated by MyBatis Generator.
     * This field corresponds to the database column tb_integral.basedeposit
     *
     * @mbg.generated Tue Jan 09 11:34:57 CST 2018
     */
    private Double basedeposit;

    /**
     * This method was generated by MyBatis Generator.
     * This method returns the value of the database column tb_integral.uid
     *
     * @return the value of tb_integral.uid
     *
     * @mbg.generated Tue Jan 09 11:34:57 CST 2018
     */
    public String getUid() {
        return uid;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method sets the value of the database column tb_integral.uid
     *
     * @param uid the value for tb_integral.uid
     *
     * @mbg.generated Tue Jan 09 11:34:57 CST 2018
     */
    public void setUid(String uid) {
        this.uid = uid == null ? null : uid.trim();
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method returns the value of the database column tb_integral.mininum
     *
     * @return the value of tb_integral.mininum
     *
     * @mbg.generated Tue Jan 09 11:34:57 CST 2018
     */
    public Integer getMininum() {
        return mininum;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method sets the value of the database column tb_integral.mininum
     *
     * @param mininum the value for tb_integral.mininum
     *
     * @mbg.generated Tue Jan 09 11:34:57 CST 2018
     */
    public void setMininum(Integer mininum) {
        this.mininum = mininum;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method returns the value of the database column tb_integral.maxinum
     *
     * @return the value of tb_integral.maxinum
     *
     * @mbg.generated Tue Jan 09 11:34:57 CST 2018
     */
    public Integer getMaxinum() {
        return maxinum;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method sets the value of the database column tb_integral.maxinum
     *
     * @param maxinum the value for tb_integral.maxinum
     *
     * @mbg.generated Tue Jan 09 11:34:57 CST 2018
     */
    public void setMaxinum(Integer maxinum) {
        this.maxinum = maxinum;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method returns the value of the database column tb_integral.grade
     *
     * @return the value of tb_integral.grade
     *
     * @mbg.generated Tue Jan 09 11:34:57 CST 2018
     */
    public Integer getGrade() {
        return grade;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method sets the value of the database column tb_integral.grade
     *
     * @param grade the value for tb_integral.grade
     *
     * @mbg.generated Tue Jan 09 11:34:57 CST 2018
     */
    public void setGrade(Integer grade) {
        this.grade = grade;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method returns the value of the database column tb_integral.divided
     *
     * @return the value of tb_integral.divided
     *
     * @mbg.generated Tue Jan 09 11:34:57 CST 2018
     */
    public BigDecimal getDivided() {
        return divided;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method sets the value of the database column tb_integral.divided
     *
     * @param divided the value for tb_integral.divided
     *
     * @mbg.generated Tue Jan 09 11:34:57 CST 2018
     */
    public void setDivided(BigDecimal divided) {
        this.divided = divided;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method returns the value of the database column tb_integral.basedeposit
     *
     * @return the value of tb_integral.basedeposit
     *
     * @mbg.generated Tue Jan 09 11:34:57 CST 2018
     */
    public Double getBasedeposit() {
        return basedeposit;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method sets the value of the database column tb_integral.basedeposit
     *
     * @param basedeposit the value for tb_integral.basedeposit
     *
     * @mbg.generated Tue Jan 09 11:34:57 CST 2018
     */
    public void setBasedeposit(Double basedeposit) {
        this.basedeposit = basedeposit;
    }
}