package com.hnqj.services;

import com.hnqj.core.PageData;
import com.hnqj.dao.DaoSupportImpl;
import com.hnqj.model.WorksViews;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;

@Service("worksView")
public class WorksViewsServices {

protected final Log logger = LogFactory.getLog(getClass());

	@Resource(name = "daoSupportImpl")

	private DaoSupportImpl daoSupport; 

	public int addWorksView(PageData pageData) {
	 logger.info("增加Works浏览记录");
	 int iFlag =0; 
	 try { 
		iFlag = (int) daoSupport.insert("WorksViewsMapper.addWorksViewlog",pageData);
	 }catch (Exception e){ 
	 e.printStackTrace(); 
	 iFlag=0; 
	}
	 return iFlag; 
	}

	public List<WorksViews> getAllWorksViews(PageData pageData) {
	 logger.info("分页查询Works浏览记录");
	List<WorksViews>	worksList=null;
	 try { 
		worksList = (List<WorksViews>) daoSupport.findForList("WorksViewsMapper.selectWorksViews",pageData);
	 }catch (Exception e){ 
	 e.printStackTrace(); 
	 worksList=null; 
	}
	 return worksList; 
	}
}
