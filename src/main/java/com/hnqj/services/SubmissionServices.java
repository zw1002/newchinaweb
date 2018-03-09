package com.hnqj.services;

import com.hnqj.core.PageData;

import com.hnqj.model.Submission;

import javax.annotation.Resource;
import com.hnqj.dao.DaoSupportImpl;
import org.springframework.stereotype.Service;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import java.util.List;
@Service("submission")
public class SubmissionServices {

protected final Log logger = LogFactory.getLog(getClass());

	@Resource(name = "daoSupportImpl")

	private DaoSupportImpl daoSupport; 

	public int addSubmission(PageData pageData) {
	 logger.info("增加Submission");
	 int iFlag =0; 
	 try { 
		iFlag = (int) daoSupport.insert("SubmissionMapper.addSubmission",pageData);
	 }catch (Exception e){ 
	 e.printStackTrace(); 
	 iFlag=0; 
	}
	 return iFlag; 
	}
	public int delSubmissionByFid(String fid) {
	 logger.info("删除Submission");
	 int iFlag =0; 
	 try { 
		iFlag = (int) daoSupport.delete("SubmissionMapper.deleteSubmissionByFid",fid);
	 }catch (Exception e){ 
	 e.printStackTrace(); 
	 iFlag=0; 
	}
	 return iFlag; 
	}
	public int updateSubmission(PageData pageData) {
	 logger.info("修改Submission");
	 int iFlag =0; 
	 try { 
		iFlag = (int) daoSupport.update("SubmissionMapper.updateSubmission",pageData);
	 }catch (Exception e){ 
	 e.printStackTrace(); 
	 iFlag=0; 
	}
	 return iFlag; 
	}
	public Submission getSubmissionforId(String fid) {
	 logger.info("通过ID查询Submission");
	Submission	submission=null;
	 try { 
		submission = (Submission) daoSupport.findForObject("SubmissionMapper.getSubmissionForId",fid);
	 }catch (Exception e){ 
	 e.printStackTrace(); 
	 submission=null; 
	}
	 return submission; 
	}
	public List<Submission> getAllSubmission(PageData pageData) {
	 logger.info("分页查询Submission");
	List<Submission>	submissionList=null;
	 try { 
		submissionList = (List<Submission>) daoSupport.findForList("SubmissionMapper.getAllSubmission",pageData);
	 }catch (Exception e){ 
	 e.printStackTrace(); 
	 submissionList=null; 
	}
	 return submissionList; 
	}
	public List<Submission> selectSubmissionList() {
	 logger.info("查询所有Submission");
	List<Submission>	submissionList=null;
	 try { 
		submissionList = (List<Submission>) daoSupport.findForList("SubmissionMapper.selectSubmissionList",null);
	 }catch (Exception e){ 
	 e.printStackTrace(); 
	 submissionList=null; 
	}
	 return submissionList; 
	}

	public List<Submission> getSubmissionByGraphId(String uid) {
		logger.info("通过任务ID查询所有Submission");
		List<Submission>	submissionList=null;
		try {
			submissionList = (List<Submission>) daoSupport.findForList("SubmissionMapper.getSubmissionByGraphId",uid);
		}catch (Exception e){
			e.printStackTrace();
			submissionList=null;
		}
		return submissionList;
	}
}
