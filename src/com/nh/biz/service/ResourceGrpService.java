package com.nh.biz.service;

import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.nh.biz.dao.impl.GroupDeptDao;
import com.nh.biz.dao.impl.ResourceGroupDao;
import com.nh.biz.dao.impl.ResourceTreeDao;
import com.nh.biz.domain.GroupDept;
import com.nh.biz.domain.ResourceGroup;
import com.nh.biz.domain.ResourceTree;
import com.nh.biz.domain.system.Department;
import com.nh.biz.service.system.DepartmentMng;


@Service("resourceGrpService")
public class ResourceGrpService {
	
	public ResourceGroup getResourceGrpById(Integer id) {
		return resourceGroupDao.findById(id);
	}

	public List<ResourceGroup> getResourceGrpByCreateDeptId(Integer createDeptid){
		List<ResourceGroup> list = resourceGroupDao.findByMap(new String[]{"createDeptid"}, new Object[]{createDeptid});
		return list;
	}
	
	public List<ResourceGroup> getResourceGrpByUploadDeptId(Integer uploadDeptId){
		List<ResourceGroup> list = resourceGroupDao.findByMap(new String[]{"uploadDeptid"}, new Object[]{uploadDeptId});
		return list;
	}
	
	
	//保存分组目录
	@Transactional
	public Integer newSaveGrpInfo(ResourceGroup group){
		try {
			
			Integer groupId =  (Integer)resourceGroupDao.insert(group);
			this.insertGrpDept(group);
			//添加目录树根节点
			ResourceTree treeRoot = new ResourceTree();
			treeRoot.setChild(false);
			treeRoot.setGroupId(groupId);
			treeRoot.setPid(0);
			treeRoot.setTreeName(group.getGrpName());
			resourceTreeDao.insert(treeRoot);
			
			return groupId;
		} catch (Exception e) {
			throw new ServiceException(e);
		}
	}
	
	
    //	更新分组目录
	
	@Transactional
	public ResourceGroup updateGrpInfo(ResourceGroup group){
		try {

			//同时更新树目录树根节点
			ResourceTree treeRoot = resourceTreeDao.findUniqueByMap(new String[]{"groupId","pid"}, new Object[]{group.getId(),0});
			treeRoot.setTreeName(group.getGrpName());
			resourceTreeDao.update(treeRoot);
			this.updateGrpDept(group);
			return resourceGroupDao.update(group);
		} catch (Exception e) {
			throw new ServiceException(e);
		}
	}
	
	//删除文档库
	@Transactional
	public void deleteGroup(Integer groupId) {
		try {
			resourceGroupDao.deleteById(groupId);
			resourceGroupDao.deleteByStatementPostfix(
					".DELETE_RESOURCE_GRP_DEPT",
					new String[]{"groupId"}, new Object[]{groupId});
		} catch (Exception e) {
			throw new ServiceException(e);
		}
	}

	public void insertGrpDept(ResourceGroup group){
		List<GroupDept> list = new ArrayList<GroupDept>();
		for(Integer deptId : group.getInputIds()){
			list.add(new  GroupDept(group.getId(),deptId));
		}
		try {
			groupDeptDao.batchInsert(list);
		} catch (Exception e) {
			throw new ServiceException(e);
		}
	}
	
	public void updateGrpDept(ResourceGroup group){
		List<GroupDept> list = new ArrayList<GroupDept>();
		for(Integer deptId : group.getInputIds()){
			list.add(new  GroupDept(group.getId(),deptId));
		}
		try {
			groupDeptDao.deleteByMap(new String[]{"grpId"}, new Object[]{group.getId()});
			groupDeptDao.batchInsert(list);
		} catch (Exception e) {
			throw new ServiceException(e);
		}
	}
	
	//获取授权单位
	public List<Department> getActDepartments(Integer groupId) {
		List<Department> deptList = new ArrayList<Department>();
		List<GroupDept> groupDeptList = groupDeptDao.findByMap(new String[]{"grpId"}, new Object[]{groupId});
		for(GroupDept groupDept : groupDeptList){
			deptList.add(departmentMng.getById(groupDept.getDeptId()));
		}
		return deptList;
	}
	
	@Resource
	private ResourceGroupDao resourceGroupDao;
	@Resource
	private ResourceTreeDao resourceTreeDao;
	@Resource
	private GroupDeptDao groupDeptDao;
	@Resource
	private DepartmentMng departmentMng;
	
	
}
