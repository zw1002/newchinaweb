package com.hnqj.services;

import com.hnqj.core.PageData;

import com.hnqj.model.Graphleavingmsg;

import javax.annotation.Resource;
import com.hnqj.dao.DaoSupportImpl;
import org.springframework.stereotype.Service;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import java.util.List;
@Service("graphleavingmsg")
public class GraphleavingmsgServices {

protected final Log logger = LogFactory.getLog(getClass());

	@Resource(name = "daoSupportImpl")

	private DaoSupportImpl daoSupport; 

	public int addGraphleavingmsg(PageData pageData) {
	 logger.info("增加Graphleavingmsg");
	 int iFlag =0; 
	 try { 
		iFlag = (int) daoSupport.insert("GraphleavingmsgMapper.addGraphleavingmsg",pageData);
	 }catch (Exception e){ 
	 e.printStackTrace(); 
	 iFlag=0; 
	}
	 return iFlag; 
	}
	public int delGraphleavingmsgByFid(String fid) {
	 logger.info("删除Graphleavingmsg");
	 int iFlag =0; 
	 try { 
		iFlag = (int) daoSupport.delete("GraphleavingmsgMapper.deleteGraphleavingmsgByFid",fid);
	 }catch (Exception e){ 
	 e.printStackTrace(); 
	 iFlag=0; 
	}
	 return iFlag; 
	}
	public int updateGraphleavingmsg(PageData pageData) {
	 logger.info("修改Graphleavingmsg");
	 int iFlag =0; 
	 try { 
		iFlag = (int) daoSupport.update("GraphleavingmsgMapper.updateGraphleavingmsg",pageData);
	 }catch (Exception e){ 
	 e.printStackTrace(); 
	 iFlag=0; 
	}
	 return iFlag; 
	}
	public Graphleavingmsg getGraphleavingmsgforId(String fid) {
	 logger.info("通过ID查询Graphleavingmsg");
	Graphleavingmsg	graphleavingmsg=null;
	 try { 
		graphleavingmsg = (Graphleavingmsg) daoSupport.findForObject("GraphleavingmsgMapper.getGraphleavingmsgForId",fid);
	 }catch (Exception e){ 
	 e.printStackTrace(); 
	 graphleavingmsg=null; 
	}
	 return graphleavingmsg; 
	}
	public List<Graphleavingmsg> getAllGraphleavingmsg(PageData pageData) {
	 logger.info("分页查询Graphleavingmsg");
	List<Graphleavingmsg>	graphleavingmsgList=null;
	 try { 
		graphleavingmsgList = (List<Graphleavingmsg>) daoSupport.findForList("GraphleavingmsgMapper.getAllGraphleavingmsg",pageData);
	 }catch (Exception e){ 
	 e.printStackTrace(); 
	 graphleavingmsgList=null; 
	}
	 return graphleavingmsgList; 
	}
	public List<Graphleavingmsg> selectGraphleavingmsgList() {
	 logger.info("查询所有Graphleavingmsg");
	List<Graphleavingmsg>	graphleavingmsgList=null;
	 try { 
		graphleavingmsgList = (List<Graphleavingmsg>) daoSupport.findForList("GraphleavingmsgMapper.selectGraphleavingmsgList",null);
	 }catch (Exception e){ 
	 e.printStackTrace(); 
	 graphleavingmsgList=null; 
	}
	 return graphleavingmsgList; 
	}

	public List<Graphleavingmsg> getGraphleavingmsgByGraphId(String uid) {
		logger.info("根据任务ID查询所有Graphleavingmsg");
		List<Graphleavingmsg>	graphleavingmsgList=null;
		try {
			graphleavingmsgList = (List<Graphleavingmsg>) daoSupport.findForList("GraphleavingmsgMapper.getGraphleavingmsgByGraphId",uid);
		}catch (Exception e){
			e.printStackTrace();
			graphleavingmsgList=null;
		}
		return graphleavingmsgList;
	}
}
