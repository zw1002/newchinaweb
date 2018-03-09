package com.hnqj.services;

import com.hnqj.core.PageData;

import com.hnqj.model.Collections;

import javax.annotation.Resource;
import com.hnqj.dao.DaoSupportImpl;
import org.springframework.stereotype.Service;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import java.util.List;
@Service("collection")
public class CollectionServices {

protected final Log logger = LogFactory.getLog(getClass());

	@Resource(name = "daoSupportImpl")

	private DaoSupportImpl daoSupport; 

	public int addCollections(PageData pageData) {
	 logger.info("增加Collections");
	 int iFlag =0; 
	 try { 
		iFlag = (int) daoSupport.insert("CollectionsMapper.insert",pageData);
	 }catch (Exception e){ 
	 e.printStackTrace(); 
	 iFlag=0; 
	}
	 return iFlag; 
	}
	public int delCollectionsByFid(String fid) {
	 logger.info("删除Collections");
	 int iFlag =0; 
	 try { 
		iFlag = (int) daoSupport.delete("CollectionsMapper.deleteCollectionByFid",fid);
	 }catch (Exception e){ 
	 e.printStackTrace(); 
	 iFlag=0; 
	}
	 return iFlag; 
	}

	public int delCollectionsByUseridandWorksID(PageData pageData) {
		logger.info("删除delCollectionsByUseridandWorksID");
		int iFlag =0;
		try {
			iFlag = (int) daoSupport.delete("CollectionsMapper.deleteByUidAndWorksid",pageData);
		}catch (Exception e){
			e.printStackTrace();
			iFlag=0;
		}
		return iFlag;
	}
	public int updateCollections(PageData pageData) {
	 logger.info("修改Collections");
	 int iFlag =0; 
	 try { 
		iFlag = (int) daoSupport.update("CollectionsMapper.updateCollection",pageData);
	 }catch (Exception e){ 
	 e.printStackTrace(); 
	 iFlag=0; 
	}
	 return iFlag; 
	}
	public Collections getCollectionsforId(String fid) {
	 logger.info("通过ID查询Collections");
	Collections	collection=null;
	 try { 
		collection = (Collections) daoSupport.findForObject("CollectionsMapper.getCollectionForId",fid);
	 }catch (Exception e){ 
	 e.printStackTrace(); 
	 collection=null; 
	}
	 return collection; 
	}
	public List<Collections> getAllCollections(PageData pageData) {
	 logger.info("分页查询Collections");
	List<Collections>	collectionList=null;
	 try { 
		collectionList = (List<Collections>) daoSupport.findForList("CollectionsMapper.getAllCollection",pageData);
	 }catch (Exception e){ 
	 e.printStackTrace(); 
	 collectionList=null; 
	}
	 return collectionList; 
	}
	public List<Collections> selectCollectionsList() {
	 logger.info("查询所有Collections");
	List<Collections>	collectionList=null;
	 try { 
		collectionList = (List<Collections>) daoSupport.findForList("CollectionsMapper.selectCollectionList",null);
	 }catch (Exception e){ 
	 e.printStackTrace(); 
	 collectionList=null; 
	}
	 return collectionList; 
	}

	public List<Collections> selectCollectionsByUserId(PageData pageData) {
		logger.info("查询个人所有Collections");
		List<Collections>	collectionList=null;
		try {
			collectionList = (List<Collections>) daoSupport.findForList("CollectionsMapper.selectCollectionByUserId",pageData);
		}catch (Exception e){
			e.printStackTrace();
			collectionList=null;
		}
		return collectionList;
	}

	public int delCollections(PageData pageData) {
		logger.info("取消收藏");
		int iFlag =0;
		try {
			iFlag = (int) daoSupport.update("CollectionsMapper.delCollection",pageData);
		}catch (Exception e){
			e.printStackTrace();
			iFlag=0;
		}
		return iFlag;
	}
}
