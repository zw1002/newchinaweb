package com.hnqj.services;

import com.hnqj.core.PageData;

import com.hnqj.model.Merch;

import javax.annotation.Resource;
import com.hnqj.dao.DaoSupportImpl;
import org.springframework.stereotype.Service;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import java.util.List;
@Service("merch")
public class MerchServices {

protected final Log logger = LogFactory.getLog(getClass());

	@Resource(name = "daoSupportImpl")

	private DaoSupportImpl daoSupport; 

	public int addMerch(PageData pageData) {
	 logger.info("增加Merch");
	 int iFlag =0; 
	 try { 
		iFlag = (int) daoSupport.insert("MerchMapper.addMerch",pageData);
	 }catch (Exception e){ 
	 e.printStackTrace(); 
	 iFlag=0; 
	}
	 return iFlag; 
	}
	public int delMerchByFid(String fid) {
	 logger.info("删除Merch");
	 int iFlag =0; 
	 try { 
		iFlag = (int) daoSupport.delete("MerchMapper.deleteMerchByFid",fid);
	 }catch (Exception e){ 
	 e.printStackTrace(); 
	 iFlag=0; 
	}
	 return iFlag; 
	}
	public int updateMerch(PageData pageData) {
	 logger.info("修改Merch");
	 int iFlag =0; 
	 try { 
		iFlag = (int) daoSupport.update("MerchMapper.updateMerch",pageData);
	 }catch (Exception e){ 
	 e.printStackTrace(); 
	 iFlag=0; 
	}
	 return iFlag; 
	}
	public Merch getMerchforId(String fid) {
	 logger.info("通过ID查询Merch");
	Merch	merch=null;
	 try { 
		merch = (Merch) daoSupport.findForObject("MerchMapper.selectByPrimaryKey",fid);
	 }catch (Exception e){ 
	 e.printStackTrace(); 
	 merch=null; 
	}
	 return merch; 
	}
	public List<Merch> getAllMerch(PageData pageData) {
	 logger.info("分页查询Merch");
	List<Merch>	merchList=null;
	 try { 
		merchList = (List<Merch>) daoSupport.findForList("MerchMapper.getAllMerch",pageData);
	 }catch (Exception e){ 
	 e.printStackTrace(); 
	 merchList=null; 
	}
	 return merchList; 
	}
	public List<Merch> selectMerchList() {
	 logger.info("查询所有Merch");
	List<Merch>	merchList=null;
	 try { 
		merchList = (List<Merch>) daoSupport.findForList("MerchMapper.selectMerchList",null);
	 }catch (Exception e){ 
	 e.printStackTrace(); 
	 merchList=null; 
	}
	 return merchList; 
	}

	public Merch getMerchForUserId(String uid) {
		logger.info("通过会员ID查询Merch");
		Merch	merch=null;
		try {
			merch = (Merch) daoSupport.findForObject("MerchMapper.getMerchForUserId",uid);
		}catch (Exception e){
			e.printStackTrace();
			merch=null;
		}
		return merch;
	}

	public int updateWorkDealCount(PageData workdealpageData) {
		logger.info("修改店铺交易量和积分");
		int iFlag =0;
		try {
			iFlag = (int) daoSupport.update("MerchMapper.updateWorkDealCount",workdealpageData);
		}catch (Exception e){
			e.printStackTrace();
			iFlag=0;
		}
		return iFlag;
	}

	public int updateWorkNums(PageData workcountpageData) {
		logger.info("修改店铺作品量");
		int iFlag =0;
		try {
			iFlag = (int) daoSupport.update("MerchMapper.updateWorkNums",workcountpageData);
		}catch (Exception e){
			e.printStackTrace();
			iFlag=0;
		}
		return iFlag;
	}


	public int updateMerchMsg(PageData pageData) {
		logger.info("重新完善开店资料，修改店铺状态");
		int iFlag =0;
		try {
			iFlag = (int) daoSupport.update("MerchMapper.updateMerchMsg",pageData);
		}catch (Exception e){
			e.printStackTrace();
			iFlag=0;
		}
		return iFlag;
	}
}
