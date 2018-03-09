package com.hnqj.services;

import com.hnqj.core.PageData;

import com.hnqj.model.Props;

import javax.annotation.Resource;
import com.hnqj.dao.DaoSupportImpl;
import org.springframework.stereotype.Service;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import java.util.List;
@Service("props")
public class PropsServices {

protected final Log logger = LogFactory.getLog(getClass());

	@Resource(name = "daoSupportImpl")

	private DaoSupportImpl daoSupport; 

	public int addProps(PageData pageData) {
	 logger.info("增加Props");
	 int iFlag =0; 
	 try { 
		iFlag = (int) daoSupport.insert("PropsMapper.addProps",pageData);
	 }catch (Exception e){ 
	 e.printStackTrace(); 
	 iFlag=0; 
	}
	 return iFlag; 
	}
	public int delPropsByFid(String fid) {
	 logger.info("删除Props");
	 int iFlag =0; 
	 try { 
		iFlag = (int) daoSupport.delete("PropsMapper.deletePropsByFid",fid);
	 }catch (Exception e){ 
	 e.printStackTrace(); 
	 iFlag=0; 
	}
	 return iFlag; 
	}
	public int updateProps(PageData pageData) {
	 logger.info("修改Props");
	 int iFlag =0; 
	 try { 
		iFlag = (int) daoSupport.update("PropsMapper.updateProps",pageData);
	 }catch (Exception e){ 
	 e.printStackTrace(); 
	 iFlag=0; 
	}
	 return iFlag; 
	}
	public Props getPropsforId(String fid) {
	 logger.info("通过ID查询Props");
	Props	props=null;
	 try { 
		props = (Props) daoSupport.findForObject("PropsMapper.getPropsForId",fid);
	 }catch (Exception e){ 
	 e.printStackTrace(); 
	 props=null; 
	}
	 return props; 
	}
	public List<Props> getAllProps(PageData pageData) {
	 logger.info("分页查询Props");
	List<Props>	propsList=null;
	 try { 
		propsList = (List<Props>) daoSupport.findForList("PropsMapper.getAllProps",pageData);
	 }catch (Exception e){ 
	 e.printStackTrace(); 
	 propsList=null; 
	}
	 return propsList; 
	}
	public List<Props> selectPropsList() {
	 logger.info("查询所有Props");
	List<Props>	propsList=null;
	 try { 
		propsList = (List<Props>) daoSupport.findForList("PropsMapper.selectPropsList",null);
	 }catch (Exception e){ 
	 e.printStackTrace(); 
	 propsList=null; 
	}
	 return propsList; 
	}
}
