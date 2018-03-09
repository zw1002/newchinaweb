package com.hnqj.services;

import com.hnqj.core.PageData;

import com.hnqj.model.Userinfo;

import javax.annotation.Resource;
import com.hnqj.dao.DaoSupportImpl;
import org.springframework.stereotype.Service;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import java.util.List;

@Service("userinfo")
public class UserinfoServices {

protected final Log logger = LogFactory.getLog(getClass());

	@Resource(name = "daoSupportImpl")

	private DaoSupportImpl daoSupport; 

	public int addUserinfo(PageData pageData) throws Exception {
	 logger.info("增加Userinfo");
	 int iFlag = (int) daoSupport.insert("UserinfoMapper.addUserinfo",pageData);
	 return iFlag;
	}
	public int delUserinfoByFid(String fid) {
	 logger.info("删除Userinfo");
	 int iFlag =0; 
	 try { 
		iFlag = (int) daoSupport.delete("UserinfoMapper.deleteUserinfoByFid",fid);
	 }catch (Exception e){ 
	 e.printStackTrace(); 
	 iFlag=0; 
	}
	 return iFlag; 
	}
	public int updateUserinfo(PageData pageData) {
	 logger.info("修改Userinfo");
	 int iFlag =0; 
	 try { 
		iFlag = (int) daoSupport.update("UserinfoMapper.updateUserinfo",pageData);
	 }catch (Exception e){ 
	 e.printStackTrace(); 
	 iFlag=0; 
	}
	 return iFlag; 
	}
	public Userinfo getUserinfoforId(String fid) {
	 logger.info("通过ID查询Userinfo");
	Userinfo	userinfo=null;
	 try { 
		userinfo = (Userinfo) daoSupport.findForObject("UserinfoMapper.getUserinfoForId",fid);
	 }catch (Exception e){ 
	 e.printStackTrace(); 
	 userinfo=null; 
	}
	 return userinfo; 
	}
	public List<Userinfo> getAllUserinfo(PageData pageData) {
	 logger.info("分页查询Userinfo");
	List<Userinfo>	userinfoList=null;
	 try { 
		userinfoList = (List<Userinfo>) daoSupport.findForList("UserinfoMapper.getAllUserinfo",pageData);
	 }catch (Exception e){ 
	 e.printStackTrace(); 
	 userinfoList=null; 
	}
	 return userinfoList; 
	}
	public List<Userinfo> selectUserinfoList() {
	 logger.info("查询所有Userinfo");
	List<Userinfo>	userinfoList=null;
	 try { 
		userinfoList = (List<Userinfo>) daoSupport.findForList("UserinfoMapper.selectUserinfoList",null);
	 }catch (Exception e){ 
	 e.printStackTrace(); 
	 userinfoList=null; 
	}
	 return userinfoList; 
	}

	public Userinfo getUserInfo(PageData pageData) {
		logger.info("登录校验");
		Userinfo userinfo=null;
		try {
			userinfo = (Userinfo) daoSupport.findForObject("UserinfoMapper.getUserInfo",pageData);
		}catch (Exception e){
			e.printStackTrace();
			userinfo=null;
		}
		return userinfo;
	}
	public Userinfo getUserInfoForUid(PageData pageData) {
		logger.info("登录校验");
		Userinfo userinfo=null;
		try {
			userinfo = (Userinfo) daoSupport.findForObject("UserinfoMapper.getUserInfoForUid",pageData);
		}catch (Exception e){
			e.printStackTrace();
			userinfo=null;
		}
		return userinfo;
	}
	public int restPassword(PageData pageData) {
		logger.info("重置密码restPassword");
		int iFlag =0;
		try {
			iFlag = (int) daoSupport.update("UserinfoMapper.restPassword",pageData);
		}catch (Exception e){
			e.printStackTrace();
			iFlag=0;
		}
		return iFlag;
	}

	public List<Userinfo> getSubmissionUser(PageData pageData) {
		logger.info("查询优秀投稿用户");
		List<Userinfo>	userinfoList=null;
		try {
			userinfoList = (List<Userinfo>) daoSupport.findForList("UserinfoMapper.getSubmissionUser",pageData);
		}catch (Exception e){
			e.printStackTrace();
			userinfoList=null;
		}
		return userinfoList;
	}

	public int updateUserinfoForWinningBid(PageData useDate) {
		logger.info("修改中标数据");
		int iFlag =0;
		try {
			iFlag = (int) daoSupport.update("UserinfoMapper.updateUserinfoForWinningBid",useDate);
		}catch (Exception e){
			e.printStackTrace();
			iFlag=0;
		}
		return iFlag;
	}

	public Userinfo getUserInfoByAccount(String account) {
		logger.info("根据账号查找用户");
		Userinfo userinfo=null;
		try {
			userinfo = (Userinfo) daoSupport.findForObject("UserinfoMapper.getUserInfoByAccount",account);
		}catch (Exception e){
			e.printStackTrace();
			userinfo=null;
		}
		return userinfo;
	}
}
