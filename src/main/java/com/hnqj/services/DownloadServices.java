package com.hnqj.services;

import com.hnqj.core.PageData;

import com.hnqj.model.Download;

import javax.annotation.Resource;
import com.hnqj.dao.DaoSupportImpl;
import org.springframework.stereotype.Service;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import java.util.List;
@Service("download")
public class DownloadServices {

protected final Log logger = LogFactory.getLog(getClass());

	@Resource(name = "daoSupportImpl")

	private DaoSupportImpl daoSupport; 

	public int addDownload(PageData pageData) {
	 logger.info("增加Download");
	 int iFlag =0; 
	 try { 
		iFlag = (int) daoSupport.insert("DownloadMapper.addDownload",pageData);
	 }catch (Exception e){ 
	 e.printStackTrace(); 
	 iFlag=0; 
	}
	 return iFlag; 
	}
	public int delDownloadByFid(String fid) {
	 logger.info("删除Download");
	 int iFlag =0; 
	 try { 
		iFlag = (int) daoSupport.delete("DownloadMapper.deleteDownloadByFid",fid);
	 }catch (Exception e){ 
	 e.printStackTrace(); 
	 iFlag=0; 
	}
	 return iFlag; 
	}
	public int updateDownload(PageData pageData) {
	 logger.info("修改Download");
	 int iFlag =0; 
	 try { 
		iFlag = (int) daoSupport.update("DownloadMapper.updateDownload",pageData);
	 }catch (Exception e){ 
	 e.printStackTrace(); 
	 iFlag=0; 
	}
	 return iFlag; 
	}
	public Download getDownloadforId(String fid) {
	 logger.info("通过ID查询Download");
	Download	download=null;
	 try { 
		download = (Download) daoSupport.findForObject("DownloadMapper.getDownloadForId",fid);
	 }catch (Exception e){ 
	 e.printStackTrace(); 
	 download=null; 
	}
	 return download; 
	}
	public List<Download> getAllDownload(PageData pageData) {
	 logger.info("分页查询Download");
	List<Download>	downloadList=null;
	 try { 
		downloadList = (List<Download>) daoSupport.findForList("DownloadMapper.getAllDownload",pageData);
	 }catch (Exception e){ 
	 e.printStackTrace(); 
	 downloadList=null; 
	}
	 return downloadList; 
	}
	public List<Download> selectDownloadList() {
	 logger.info("查询所有Download");
	List<Download>	downloadList=null;
	 try { 
		downloadList = (List<Download>) daoSupport.findForList("DownloadMapper.selectDownloadList",null);
	 }catch (Exception e){ 
	 e.printStackTrace(); 
	 downloadList=null; 
	}
	 return downloadList; 
	}

	public List<Download> selectDownloadListByUserId(PageData pageData) {
		logger.info("查询个人所有Download");
		List<Download>	downloadList=null;
		try {
			downloadList = (List<Download>) daoSupport.findForList("DownloadMapper.selectDownloadListByUserId",pageData);
		}catch (Exception e){
			e.printStackTrace();
			downloadList=null;
		}
		return downloadList;
	}
}
