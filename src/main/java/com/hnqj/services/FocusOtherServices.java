package com.hnqj.services;

import com.hnqj.core.PageData;

import com.hnqj.model.FocusOther;

import javax.annotation.Resource;
import com.hnqj.dao.DaoSupportImpl;
import org.springframework.stereotype.Service;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import java.util.List;
@Service("focusother")
public class FocusOtherServices {

protected final Log logger = LogFactory.getLog(getClass());

	@Resource(name = "daoSupportImpl")

	private DaoSupportImpl daoSupport; 

	public int addFocusOther(PageData pageData) {
	 logger.info("增加FocusOther");
	 int iFlag =0; 
	 try { 
		iFlag = (int) daoSupport.insert("FocusOtherMapper.addFocusOther",pageData);
	 }catch (Exception e){ 
	 e.printStackTrace(); 
	 iFlag=0; 
	}
	 return iFlag; 
	}
	public int delFocusOtherByFid(String fid) {
	 logger.info("删除FocusOther");
	 int iFlag =0; 
	 try { 
		iFlag = (int) daoSupport.delete("FocusOtherMapper.deleteFocusOtherByFid",fid);
	 }catch (Exception e){ 
	 e.printStackTrace(); 
	 iFlag=0; 
	}
	 return iFlag; 
	}
	public int updateFocusOther(PageData pageData) {
	 logger.info("修改FocusOther");
	 int iFlag =0; 
	 try { 
		iFlag = (int) daoSupport.update("FocusOtherMapper.updateFocusOther",pageData);
	 }catch (Exception e){ 
	 e.printStackTrace(); 
	 iFlag=0; 
	}
	 return iFlag; 
	}
	public FocusOther getFocusOtherforId(String fid) {
	 logger.info("通过ID查询FocusOther");
	FocusOther	focusother=null;
	 try { 
		focusother = (FocusOther) daoSupport.findForObject("FocusOtherMapper.getFocusOtherForId",fid);
	 }catch (Exception e){ 
	 e.printStackTrace(); 
	 focusother=null; 
	}
	 return focusother; 
	}
	public List<FocusOther> getAllFocusOther(PageData pageData) {
	 logger.info("分页查询FocusOther");
	List<FocusOther>	focusotherList=null;
	 try { 
		focusotherList = (List<FocusOther>) daoSupport.findForList("FocusOtherMapper.getAllFocusOther",pageData);
	 }catch (Exception e){ 
	 e.printStackTrace(); 
	 focusotherList=null; 
	}
	 return focusotherList; 
	}
	public List<FocusOther> selectFocusOtherList() {
	 logger.info("查询所有FocusOther");
	List<FocusOther>	focusotherList=null;
	 try { 
		focusotherList = (List<FocusOther>) daoSupport.findForList("FocusOtherMapper.selectFocusOtherList",null);
	 }catch (Exception e){ 
	 e.printStackTrace(); 
	 focusotherList=null; 
	}
	 return focusotherList; 
	}

	public List<FocusOther> getFocusOtherForFocusId(String uid) {
		logger.info("获取用户被关注量");
		List<FocusOther>	focusotherList=null;
		try {
			focusotherList = (List<FocusOther>) daoSupport.findForList("FocusOtherMapper.getFocusOtherForFocusId",uid);
		}catch (Exception e){
			e.printStackTrace();
			focusotherList=null;
		}
		return focusotherList;
	}

	public List<FocusOther> getFocusOtherForUserId(PageData pageData) {
		logger.info("获取用户关注信息");
		List<FocusOther>	focusotherList=null;
		try {
			focusotherList = (List<FocusOther>) daoSupport.findForList("FocusOtherMapper.getFocusOtherForUserId",pageData);
		}catch (Exception e){
			e.printStackTrace();
			focusotherList=null;
		}
		return focusotherList;
	}
}
