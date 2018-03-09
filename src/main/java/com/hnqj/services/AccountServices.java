package com.hnqj.services;

import com.hnqj.core.PageData;

import com.hnqj.model.Account;

import javax.annotation.Resource;
import com.hnqj.dao.DaoSupportImpl;
import org.springframework.stereotype.Service;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import java.util.List;
@Service("account")
public class AccountServices {

protected final Log logger = LogFactory.getLog(getClass());

	@Resource(name = "daoSupportImpl")

	private DaoSupportImpl daoSupport; 

	public int addAccount(PageData pageData) {
	 logger.info("增加Account");
	 int iFlag =0;
	 try {
		iFlag = (int) daoSupport.insert("AccountMapper.addAccount",pageData);
	 }catch (Exception e){
	 e.printStackTrace();
	 iFlag=0;
	}
	 return iFlag;
	}
	public int delAccountByFid(String fid) {
	 logger.info("删除Account");
	 int iFlag =0; 
	 try { 
		iFlag = (int) daoSupport.delete("AccountMapper.deleteAccountByFid",fid);
	 }catch (Exception e){ 
	 e.printStackTrace(); 
	 iFlag=0; 
	}
	 return iFlag; 
	}
	public int updateAccount(PageData pageData) {
	 logger.info("修改Account");
	 int iFlag =0; 
	 try { 
		iFlag = (int) daoSupport.update("AccountMapper.updateAccount",pageData);
	 }catch (Exception e){ 
	 e.printStackTrace(); 
	 iFlag=0; 
	}
	 return iFlag; 
	}
	public Account getAccountforId(String fid) {
	 logger.info("通过ID查询Account");
	Account	account=null;
	 try { 
		account = (Account) daoSupport.findForObject("AccountMapper.getAccountForId",fid);
	 }catch (Exception e){ 
	 e.printStackTrace(); 
	 account=null; 
	}
	 return account; 
	}
	public List<Account> getAllAccount(PageData pageData) {
	 logger.info("分页查询Account");
	List<Account>	accountList=null;
	 try { 
		accountList = (List<Account>) daoSupport.findForList("AccountMapper.getAllAccount",pageData);
	 }catch (Exception e){ 
	 e.printStackTrace(); 
	 accountList=null; 
	}
	 return accountList; 
	}
	public List<Account> selectAccountList() {
	 logger.info("查询所有Account");
	List<Account>	accountList=null;
	 try { 
		accountList = (List<Account>) daoSupport.findForList("AccountMapper.selectAccountList",null);
	 }catch (Exception e){ 
	 e.printStackTrace(); 
	 accountList=null; 
	}
	 return accountList; 
	}

	public Account getAccountforAccount(String acount) {
		logger.info("通过账号查询Account");
		Account	account=null;
		try {
			account = (Account) daoSupport.findForObject("AccountMapper.getAccountforAccount",acount);
		}catch (Exception e){
			e.printStackTrace();
			account=null;
		}
		return account;
	}

	public Account getAccountForUsreId(String uid) {
		logger.info("通过用户ID查询Account");
		Account	account=null;
		try {
			account = (Account) daoSupport.findForObject("AccountMapper.getAccountForUsreId",uid);
		}catch (Exception e){
			e.printStackTrace();
			account=null;
		}
		return account;
	}

	public int updatePassByAccount(PageData pageData) {
		logger.info("修改密码");
		int iFlag =0;
		try {
			iFlag = (int) daoSupport.update("AccountMapper.updatePassByAccount",pageData);
		}catch (Exception e){
			e.printStackTrace();
			iFlag=0;
		}
		return iFlag;
	}
}
