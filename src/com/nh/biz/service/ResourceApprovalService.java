package com.nh.biz.service;

import java.util.Date;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.nh.biz.dao.impl.MyActNoticeDao;
import com.nh.biz.dao.impl.ResourceApprovalDao;
import com.nh.biz.dao.impl.ResourceInfoDao;
import com.nh.biz.domain.MyActNotice;
import com.nh.biz.domain.ResourceApproval;
import com.nh.biz.domain.ResourceInfo;
import com.nh.biz.domain.ResourceTitle;
import com.nh.biz.domain.system.User;
import com.nh.core.page.PageQuery;
import com.nh.core.page.Pagination;
import com.nh.core.utils.DateUtil;

@Service("resourceApprovalService")
public class ResourceApprovalService {
	
	/**审核请求状态**/
	public static final Integer SENT = 0;
	public static final Integer RETURNED = 1;
	public static final Integer PASS = 2;
	
	/**文档审核状态**/
	public static final Integer APPROVALSTATUS_DRAFT  = 0 ;
	public static final Integer APPROVALSTATUS_SENT   = 1 ;
	public static final Integer APPROVALSTATUS_RETURN = 2 ;
	public static final Integer APPROVALSTATUS_PASS  = 3 ;

	
	public ResourceApproval getResourceApprovalById(Integer id){
		return resourceApprovalDao.findById(id);
	}
	
	/**我需要审核的请求列表**/
	public Pagination<ResourceApproval> getMyApprovalRequest(User user, PageQuery pageQuery) {
		List<Integer> myApprovalTitleIds = resourceTitleService.getTitleIdsByApprovaller(user.getUserId());
		 Pagination<ResourceApproval>  Pagination  = resourceApprovalDao.lgcPageQueryBy(
					new String[]{"result","titleids"}, 
					new Object[]{SENT,myApprovalTitleIds},
					"sendTime","DESC",
					pageQuery.getPageSize(),pageQuery.getPageNo());
					return Pagination;
	}
	
	/**已经完成审核的文档**/
	public  Pagination<ResourceApproval> getMyFinishedApproval(User user,PageQuery pageQuery) {
		 Pagination<ResourceApproval>  Pagination =  
			 resourceApprovalDao.lgcPageQueryBy(
					 new String[]{"checkerid"}, new Object[]{user.getUserId()},
					 "checktime","DESC",
					 pageQuery.getPageSize(),pageQuery.getPageNo());
		 return Pagination;
	}
	
	/**单个文档的历史审核记录**/
	public List<ResourceApproval> getResourceApprovalHistory(Integer resourceid) {
		 List<ResourceApproval> list = resourceApprovalDao.findByMap(new String[]{"resourceid"}, new Object[]{resourceid},"checktime","DESC");
		return list;
	}
	
	/**提交审核**/
	@Transactional
	public void sendApprovalRequest(ResourceInfo resourceInfo){
		if(resourceInfo.getIsdir() || resourceInfo.getApprovalstatus().equals(APPROVALSTATUS_SENT)) return; //文件夹不能提交审核；不能重复提交审核
		if(!resourceTitleService.isApproval(resourceInfo.getTitleid())){  //无需审核，直接成为已审核状态
			resourceInfo.setApprovalstatus(APPROVALSTATUS_PASS);
			try {
				resourceInfoDao.update(resourceInfo);
			} catch (Exception e) {
				throw new ServiceException("提交审核出错："+e);
			}
			return;
		}
		
		resourceInfo.setApprovalstatus(APPROVALSTATUS_SENT);
		try {
			resourceInfoDao.update(resourceInfo);
			ResourceApproval ra = new ResourceApproval();
			ra.setActdeptid(resourceInfo.getDepartmentid());
			ra.setActdeptname(resourceInfo.getDepartment());
			ra.setActor(resourceInfo.getCreator());
			ra.setActorid(Integer.valueOf(resourceInfo.getCreatorid()));
			ra.setActdeptname(resourceInfo.getDepartment());
			ra.setSendTime(new Date());
			ra.setResourceid(resourceInfo.getId());
			ra.setFiletype(resourceInfo.getFiletype());
			ra.setResourcename(resourceInfo.getFilealiasname());
			ra.setTitleid(resourceInfo.getTitleid());
			ra.setResult(SENT);
			resourceApprovalDao.insert(ra);
		} catch (Exception e) {
			throw new ServiceException(e);
		}
	}
	
	/**批量提交审核**/
	@Transactional
	public void batchSendApprovalRequest(List<ResourceInfo> resourceInfo){
		throw new ServiceException("不可用方法");
	}
	
	
	/**审核通过**/
	@Transactional
	public void approvalPass(ResourceApproval approvalRequest, User checker) {
		ResourceInfo resource = resourceInfoDao.findById(approvalRequest.getResourceid());
		try {
			setApprovalRequestResult(approvalRequest,checker,PASS);
			changeResoureceApprovalStatus(approvalRequest.getResourceid(), APPROVALSTATUS_PASS);
			updateActNotice(resource);
		} catch (Exception e) {
			throw new ServiceException(e);
		}
	}
	
	

	/**审核退回**/
	@Transactional
	public void approvalBack(ResourceApproval approvalRequest, User checker) {
		try {
			setApprovalRequestResult(approvalRequest,checker,RETURNED);
			changeResoureceApprovalStatus(approvalRequest.getResourceid(), APPROVALSTATUS_RETURN);
		} catch (Exception e) {
			throw new ServiceException(e);
		}
	}
	
	/**
	 * 更新提醒
	 * @param resourceid
	 * @throws Exception 
	 */
	private void updateActNotice(ResourceInfo resource) throws Exception {
		MyActNotice actNotice = actNoticeDao.findUniqueByMap(new String[]{"deptid","titleid"}, new Object[]{resource.getDepartmentid(),resource.getTitleid()});
		ResourceTitle title = resourceTitleService.getResourceTitleById(resource.getTitleid());
		if("I".equals(title.getNoticeCycle())){		//立即更新不需要提醒	
			return;
		}
		if(actNotice==null){
			actNotice = new MyActNotice();
			actNotice.setDeptid(resource.getDepartmentid());
			actNotice.setRecentlyact(new Date());
			actNotice.setTitleid(resource.getTitleid());
			actNotice.setTitlename(title.getTitleName());
			actNotice.setCycleType(title.getNoticeCycle());
			actNotice.setActDay(title.getActDay() == null ? 1 : Integer.valueOf(title.getActDay()));
			actNoticeDao.insert(actNotice);
		}else{
			actNotice.setNextact(null); //下次更新日期由批处理统一运算
			actNotice.setRecentlyact(new Date());
			actNoticeDao.update(actNotice);
		}
	}
	
	/**
	 * 修改审核请求状态（自用类）
	 * 
	 * @param approvalRequest
	 * 					审核请求
	 * @param checker
	 * 					审核人
	 * @param result
	 * 					审核结果
	 * @throws Exception
	 */
	private void setApprovalRequestResult(ResourceApproval approvalRequest, User checker,Integer result) throws Exception{
		approvalRequest.setCheckerid(Integer.valueOf(checker.getUserId()));
		approvalRequest.setCheckername(checker.getUserName());
		approvalRequest.setChecktime(DateUtil.format(new Date(),"yyyy-MM-dd HH:mm:ss"));
		approvalRequest.setResult(result);
		resourceApprovalDao.update(approvalRequest);
	}
	
	/**
	 * 改变文档审核状态（自用类）
	 * 
	 * @param resourceId
	 * 					文档ID；
	 * @param approvalStatus
	 * 					改变后的文档状态；
	 * @throws Exception
	 */
	private void changeResoureceApprovalStatus(Integer resourceId,Integer approvalStatus) throws Exception {
		resourceInfoDao.update(resourceId, new String[]{"approvalstatus"}, new Object[]{approvalStatus});
	}
	
	
	//移除未审核的文档
	public void removeApprovalRequest(Integer resourceId) {
		// TODO 自动生成方法存根
		try {
			resourceApprovalDao.deleteByMap(new String[]{"resourceid","result"}, new Object[]{resourceId,ResourceApprovalService.SENT});
		} catch (Exception e) {
			throw new ServiceException(e);
		}
	}

	
	@Resource
	private ResourceApprovalDao resourceApprovalDao;
	@Resource
	private ResourceInfoDao resourceInfoDao;
	@Resource
	private ResourceTitleService resourceTitleService;	
	@Resource
	private MyActNoticeService actNoticeService;
	@Resource
	private MyActNoticeDao actNoticeDao ;


	

	

}
