package com.hnqj.services;

import com.hnqj.core.PageData;

import com.hnqj.model.PropsImage;

import javax.annotation.Resource;
import com.hnqj.dao.DaoSupportImpl;
import org.springframework.stereotype.Service;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import java.util.List;
@Service("propsimage")
public class PropsImageServices {

protected final Log logger = LogFactory.getLog(getClass());

	@Resource(name = "daoSupportImpl")

	private DaoSupportImpl daoSupport; 

	public int addPropsImage(PageData pageData) {
	 logger.info("增加PropsImage");
	 int iFlag =0; 
	 try { 
		iFlag = (int) daoSupport.insert("PropsImageMapper.addPropsImage",pageData);
	 }catch (Exception e){ 
	 e.printStackTrace(); 
	 iFlag=0; 
	}
	 return iFlag; 
	}
	public int delPropsImageByFid(String fid) {
	 logger.info("删除PropsImage");
	 int iFlag =0; 
	 try { 
		iFlag = (int) daoSupport.delete("PropsImageMapper.deletePropsImageByFid",fid);
	 }catch (Exception e){ 
	 e.printStackTrace(); 
	 iFlag=0; 
	}
	 return iFlag; 
	}
	public int updatePropsImage(PageData pageData) {
	 logger.info("修改PropsImage");
	 int iFlag =0; 
	 try { 
		iFlag = (int) daoSupport.update("PropsImageMapper.updatePropsImage",pageData);
	 }catch (Exception e){ 
	 e.printStackTrace(); 
	 iFlag=0; 
	}
	 return iFlag; 
	}
	public PropsImage getPropsImageforId(String fid) {
	 logger.info("通过ID查询PropsImage");
	PropsImage	propsimage=null;
	 try { 
		propsimage = (PropsImage) daoSupport.findForObject("PropsImageMapper.getPropsImageForId",fid);
	 }catch (Exception e){ 
	 e.printStackTrace(); 
	 propsimage=null; 
	}
	 return propsimage; 
	}
	public List<PropsImage> getAllPropsImage(PageData pageData) {
	 logger.info("分页查询PropsImage");
	List<PropsImage>	propsimageList=null;
	 try { 
		propsimageList = (List<PropsImage>) daoSupport.findForList("PropsImageMapper.getAllPropsImage",pageData);
	 }catch (Exception e){ 
	 e.printStackTrace(); 
	 propsimageList=null; 
	}
	 return propsimageList; 
	}
	public List<PropsImage> selectPropsImageList() {
	 logger.info("查询所有PropsImage");
	List<PropsImage>	propsimageList=null;
	 try { 
		propsimageList = (List<PropsImage>) daoSupport.findForList("PropsImageMapper.selectPropsImageList",null);
	 }catch (Exception e){ 
	 e.printStackTrace(); 
	 propsimageList=null; 
	}
	 return propsimageList; 
	}
}
