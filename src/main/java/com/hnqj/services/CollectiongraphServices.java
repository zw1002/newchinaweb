package com.hnqj.services;

import com.hnqj.core.PageData;

import com.hnqj.model.Collectiongraph;

import javax.annotation.Resource;
import com.hnqj.dao.DaoSupportImpl;
import org.springframework.stereotype.Service;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import java.util.List;
@Service("collectiongraph")
public class CollectiongraphServices {

protected final Log logger = LogFactory.getLog(getClass());

	@Resource(name = "daoSupportImpl")

	private DaoSupportImpl daoSupport; 

	public int addCollectiongraph(PageData pageData) {
	 logger.info("增加Collectiongraph");
	 int iFlag =0; 
	 try { 
		iFlag = (int) daoSupport.insert("CollectiongraphMapper.addCollectiongraph",pageData);
	 }catch (Exception e){ 
	 e.printStackTrace(); 
	 iFlag=0; 
	}
	 return iFlag; 
	}
	public int delCollectiongraphByFid(String fid) {
	 logger.info("删除Collectiongraph");
	 int iFlag =0; 
	 try { 
		iFlag = (int) daoSupport.delete("CollectiongraphMapper.deleteCollectiongraphByFid",fid);
	 }catch (Exception e){ 
	 e.printStackTrace(); 
	 iFlag=0; 
	}
	 return iFlag; 
	}
	public int updateCollectiongraph(PageData pageData) {
	 logger.info("修改Collectiongraph");
	 int iFlag =0; 
	 try { 
		iFlag = (int) daoSupport.update("CollectiongraphMapper.updateCollectiongraph",pageData);
	 }catch (Exception e){ 
	 e.printStackTrace(); 
	 iFlag=0; 
	}
	 return iFlag; 
	}
	public Collectiongraph getCollectiongraphforId(String fid) {
	 logger.info("通过ID查询Collectiongraph");
	Collectiongraph	collectiongraph=null;
	 try { 
		collectiongraph = (Collectiongraph) daoSupport.findForObject("CollectiongraphMapper.getCollectiongraphForId",fid);
	 }catch (Exception e){ 
	 e.printStackTrace(); 
	 collectiongraph=null; 
	}
	 return collectiongraph; 
	}
	public List<Collectiongraph> getAllCollectiongraph(PageData pageData) {
	 logger.info("分页查询Collectiongraph");
	List<Collectiongraph>	collectiongraphList=null;
	 try { 
		collectiongraphList = (List<Collectiongraph>) daoSupport.findForList("CollectiongraphMapper.getAllCollectiongraph",pageData);
	 }catch (Exception e){ 
	 e.printStackTrace(); 
	 collectiongraphList=null; 
	}
	 return collectiongraphList; 
	}
	public List<Collectiongraph> selectCollectiongraphList() {
	 logger.info("查询所有Collectiongraph");
	List<Collectiongraph>	collectiongraphList=null;
	 try { 
		collectiongraphList = (List<Collectiongraph>) daoSupport.findForList("CollectiongraphMapper.selectCollectiongraphList",null);
	 }catch (Exception e){ 
	 e.printStackTrace(); 
	 collectiongraphList=null; 
	}
	 return collectiongraphList; 
	}

	public List<Collectiongraph> getCollectiongraphByUserId(String userid) {
		logger.info("查询个人所有Collectiongraph");
		List<Collectiongraph>	collectiongraphList=null;
		try {
			collectiongraphList = (List<Collectiongraph>) daoSupport.findForList("CollectiongraphMapper.getCollectiongraphByUserId",userid);
		}catch (Exception e){
			e.printStackTrace();
			collectiongraphList=null;
		}
		return collectiongraphList;
	}
}
