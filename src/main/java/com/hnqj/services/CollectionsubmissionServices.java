package com.hnqj.services;

import com.hnqj.core.PageData;

import com.hnqj.model.Collectionsubmission;

import javax.annotation.Resource;
import com.hnqj.dao.DaoSupportImpl;
import org.springframework.stereotype.Service;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import java.util.List;
@Service("collectionsubmission")
public class CollectionsubmissionServices {

protected final Log logger = LogFactory.getLog(getClass());

	@Resource(name = "daoSupportImpl")

	private DaoSupportImpl daoSupport; 

	public int addCollectionsubmission(PageData pageData) {
	 logger.info("增加Collectionsubmission");
	 int iFlag =0; 
	 try { 
		iFlag = (int) daoSupport.insert("CollectionsubmissionMapper.addCollectionsubmission",pageData);
	 }catch (Exception e){ 
	 e.printStackTrace(); 
	 iFlag=0; 
	}
	 return iFlag; 
	}
	public int delCollectionsubmissionByFid(String fid) {
	 logger.info("删除Collectionsubmission");
	 int iFlag =0; 
	 try { 
		iFlag = (int) daoSupport.delete("CollectionsubmissionMapper.deleteCollectionsubmissionByFid",fid);
	 }catch (Exception e){ 
	 e.printStackTrace(); 
	 iFlag=0; 
	}
	 return iFlag; 
	}
	public int updateCollectionsubmission(PageData pageData) {
	 logger.info("修改Collectionsubmission");
	 int iFlag =0; 
	 try { 
		iFlag = (int) daoSupport.update("CollectionsubmissionMapper.updateCollectionsubmission",pageData);
	 }catch (Exception e){ 
	 e.printStackTrace(); 
	 iFlag=0; 
	}
	 return iFlag; 
	}
	public Collectionsubmission getCollectionsubmissionforId(String fid) {
	 logger.info("通过ID查询Collectionsubmission");
	Collectionsubmission	collectionsubmission=null;
	 try { 
		collectionsubmission = (Collectionsubmission) daoSupport.findForObject("CollectionsubmissionMapper.getCollectionsubmissionForId",fid);
	 }catch (Exception e){ 
	 e.printStackTrace(); 
	 collectionsubmission=null; 
	}
	 return collectionsubmission; 
	}
	public List<Collectionsubmission> getAllCollectionsubmission(PageData pageData) {
	 logger.info("分页查询Collectionsubmission");
	List<Collectionsubmission>	collectionsubmissionList=null;
	 try { 
		collectionsubmissionList = (List<Collectionsubmission>) daoSupport.findForList("CollectionsubmissionMapper.getAllCollectionsubmission",pageData);
	 }catch (Exception e){ 
	 e.printStackTrace(); 
	 collectionsubmissionList=null; 
	}
	 return collectionsubmissionList; 
	}
	public List<Collectionsubmission> selectCollectionsubmissionList() {
	 logger.info("查询所有Collectionsubmission");
	List<Collectionsubmission>	collectionsubmissionList=null;
	 try { 
		collectionsubmissionList = (List<Collectionsubmission>) daoSupport.findForList("CollectionsubmissionMapper.selectCollectionsubmissionList",null);
	 }catch (Exception e){ 
	 e.printStackTrace(); 
	 collectionsubmissionList=null; 
	}
	 return collectionsubmissionList; 
	}

	public List<Collectionsubmission> getCollectionsubmissionByUserId(String userid) {
		logger.info("查询个人所有Collectionsubmission");
		List<Collectionsubmission>	collectionsubmissionList=null;
		try {
			collectionsubmissionList = (List<Collectionsubmission>) daoSupport.findForList("CollectionsubmissionMapper.getCollectionsubmissionByUserId",userid);
		}catch (Exception e){
			e.printStackTrace();
			collectionsubmissionList=null;
		}
		return collectionsubmissionList;
	}
}
