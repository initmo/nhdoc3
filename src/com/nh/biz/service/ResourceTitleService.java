package com.nh.biz.service;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.nh.biz.dao.impl.ResourceActorDao;
import com.nh.biz.dao.impl.ResourceApprovalDao;
import com.nh.biz.dao.impl.ResourceCheckerDao;
import com.nh.biz.dao.impl.ResourceTitleDao;
import com.nh.biz.dao.impl.ResourceUserTitleDao;
import com.nh.biz.domain.ResourceActor;
import com.nh.biz.domain.ResourceChecker;
import com.nh.biz.domain.ResourceGroup;
import com.nh.biz.domain.ResourceTitle;
import com.nh.biz.domain.ResourceUserTitle;
import com.nh.biz.domain.system.User;
import com.nh.core.utils.reflaection.CollectionMapper;


@Service("resourceTitleService")
public class ResourceTitleService {

	public ResourceTitle getResourceTitleById(Integer id){
		return resourceTitleDao.findById(id);
	}
	
	//根据分类目录获取文档标题列表
	public List<ResourceTitle> getResourceTitleByTreeId(Integer treeId){
		return resourceTitleDao.findByMap(new String[]{"treeId"}, new Object[]{treeId},"ID","ASC");
	}
	
	//获取标题下文档数量Map<titleId,resourcecount>
	public Map getReourceCounts(Integer treeId, Integer deptId){
		return resourceTitleDao.getResourceCounts(treeId, deptId);
	}
	
	//根据授权人员ID获取文档标题列表
	public List<ResourceTitle> getResourceListByActor(String userId){
		List<ResourceActor> actorTitles = resourceActorDao.findByMap(new String[]{"userid"}, new Object[]{userId});
		List<Integer> titleIds = CollectionMapper.extractToList(actorTitles, "titleid");
		return resourceTitleDao.findByIds(titleIds);
	}
	
	//判断文档标题是否被授权
	public Boolean isActorsTitle(String userId,ResourceTitle title){
		List<ResourceTitle> myTitles = getResourceListByActor(userId);
		return myTitles.contains(title);
	}
	
	public Boolean isApproval(Integer titleId){		
		ResourceTitle title = this.getResourceTitleById(titleId);
		return title.getIsApproval();
	}
	
	public void newSaveTitleInfo(ResourceTitle title) {
		title.setIsApproval(false);
		try {
			resourceTitleDao.insert(title);
		} catch (Exception e) {
			throw new ServiceException(e);
		}
	}

	public void updateTitleInfo(ResourceTitle title) {
		ResourceTitle rt = resourceTitleDao.findById(title.getId());
		title.setIsApproval(rt.getIsApproval());
		try {
			resourceTitleDao.update(title);
		} catch (Exception e) {
			throw new ServiceException(e);
		}
	}
	
	public void deleteTitleById(Integer id) {
		try {
			resourceTitleDao.deleteById(id);
		} catch (Exception e) {
			throw new ServiceException(e);
		}
		
	}
	
	//获取授权人员id
	public List<ResourceActor> getActors(Integer titleId) {
		return resourceActorDao.findByMap(new String[]{"titleid"}, new Object[]{titleId});
	}
	
	//	根据授权审核人员ID获取文档标题ID
	public List<Integer> getTitleIdsByApprovaller(String userId){
		List<ResourceChecker> approvalTitles = resourceCheckerDao.findByMap(new String[]{"userid"}, new Object[]{userId});
		List<Integer> titleIds = CollectionMapper.extractToList(approvalTitles, "titleid");
		return titleIds;
	}
		
	//判断是否拥有该标题的维护权限
	public Boolean hasActTitle(Integer userId,Integer titleId){
		List<ResourceActor> list =  resourceActorDao.findByMap(new String[]{"userid","titleid"}, new Object[]{userId,titleId});
		return list.size()>0;
	}
	//	判断是否拥有该标题的审核权限
	public Boolean hasApprovalTitle(Integer userId,Integer titleId){
		List<ResourceChecker> list =  resourceCheckerDao.findByMap(new String[]{"userid","titleid"}, new Object[]{userId,titleId});
		return list.size()>0;
	}
	
	//设置是否审核标志
	public void setEnableApproval(Integer titleId, Boolean isApproval) {
		ResourceTitle rt = resourceTitleDao.findById(titleId);
		rt.setIsApproval(isApproval);
		try {
			resourceTitleDao.update(rt);
		} catch (Exception e) {
			throw new ServiceException(e);
		}
	}
	
	
	//批量新增授权人员
	public void insertActors(List<ResourceActor> actors){
		try {
			if(actors.size()>0)
			 resourceActorDao.batchInsert(actors);
		} catch (Exception e) {
			throw new ServiceException(e);
		}
	}
	
	

	//预设审核权限
	public void setAllResourceApprovalToUser(User user) {
		Integer deptId = user.getDeptId();
		List<ResourceGroup> deptGrps =  resourceGrpService.getResourceGrpByUploadDeptId(deptId);
		for(ResourceGroup group : deptGrps){
			setAllResourceApprovalToUser(user.getUserId(),group.getId());
		}
	}

	private void setAllResourceApprovalToUser(String userId, Integer groupId) {
		resourceApprovalDao.insertByStatementPostfix(".setAllResourceApprovalToUser", new String[]{"userId","groupId"}, new Object[]{userId,groupId});
	}												 

	//预设更新权限
	public void setAllResourceActToUser(User user) {
		Integer deptId = user.getDeptId();
		List<ResourceGroup> deptGrps =  resourceGrpService.getResourceGrpByUploadDeptId(deptId);
		for(ResourceGroup group : deptGrps){
			setAllResourceActToUser(user.getUserId(),group.getId());
		}
	}
	
	private void setAllResourceActToUser(String userId, Integer groupId) {
		resourceActorDao.insertByStatementPostfix(".setAllResourceActToUser", new String[]{"userId","groupId"}, new Object[]{userId,groupId});
	}
	
	
	//新增授权人员
	public void insertActor(ResourceActor actor){
		try {
			resourceActorDao.insert(actor);
		} catch (Exception e) {
			throw new ServiceException(e);
		}
	}
	
    //删除授权人员
	public void deleteActorByTitle(Integer titleId){
		try {
			resourceActorDao.deleteByMap(new String[]{"titleid"},new Object[]{titleId});
		} catch (Exception e) {
			throw new ServiceException(e);
		}
	}
	
	//删除该用户该标题的维护授权
	public void deleteUserActTitle(ResourceActor resourceActor){
		try {
			resourceActorDao.deleteByMap(new String[]{"userid","titleid"}, new Object[]{resourceActor.getUserid(),resourceActor.getTitleid()});
		} catch (Exception e) {
			throw new ServiceException(e);
		}
	}
	
	//删除该用户该标题的审核授权
	public void deleteUserApprovalTitle(ResourceChecker resourceChecker){
		try {
			resourceCheckerDao.deleteByMap(new String[]{"userid","titleid"}, new Object[]{resourceChecker.getUserid(),resourceChecker.getTitleid()});
		} catch (Exception e) {
			throw new ServiceException(e);
		}
	}
	
	//更新
	@Transactional
	public void updateActors(Integer titleId, List<ResourceActor> actors) {
		this.deleteActorByTitle(titleId);
		this.insertActors(actors);
	}
	
	//获取审核人员id
	public List<ResourceChecker> getCheckers(Integer titleId) {
		return resourceCheckerDao.findByMap(new String[]{"titleid"}, new Object[]{titleId});
	}
	//批量新增审核人员
	public void insertCheckers(List<ResourceChecker> checkers){
		try {
			if(checkers.size()>0)
			resourceCheckerDao.batchInsert(checkers);
		} catch (Exception e) {
			throw new ServiceException(e);
		}
	}
	
	//新增审核人员
	public void insertChecker(ResourceChecker checker){
		try {
			resourceCheckerDao.insert(checker);
		} catch (Exception e) {
			throw new ServiceException(e);
		}
	}
	
    //	删除审核人员
	public void deleteCheckerByTitle(Integer titleId){
		try {
			resourceCheckerDao.deleteByMap(new String[]{"titleid"},new Object[]{titleId});
		} catch (Exception e) {
			throw new ServiceException(e);
		}
	}
	
	//更新审核人员
	@Transactional
	public void updateCheckers(Integer titleId, List<ResourceChecker> checkers) {
		this.deleteCheckerByTitle(titleId);
		this.insertCheckers(checkers);
	}
	
	public List<ResourceUserTitle> getUserTitles(Integer userId,Integer treeId){
		List<ResourceUserTitle> list =  resourceUserTitleDao.findByMap(new String[]{"userId","treeId"}, new Object[]{userId,treeId});
		return list;
	}
	
	
	@Resource
	private ResourceTitleDao resourceTitleDao;
	@Resource
	private ResourceActorDao resourceActorDao;
	@Resource
	private ResourceCheckerDao resourceCheckerDao;
	@Resource
	private ResourceApprovalDao resourceApprovalDao;
	@Resource
	private ResourceUserTitleDao resourceUserTitleDao;
	@Resource
	private ResourceGrpService resourceGrpService;
}
