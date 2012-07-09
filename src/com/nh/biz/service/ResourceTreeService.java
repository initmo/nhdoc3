package com.nh.biz.service;

import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.nh.biz.dao.impl.ResourceTreeDao;
import com.nh.biz.domain.ResourceTree;

@Service("resourceTreeService")
public class ResourceTreeService {

	public ResourceTree getResourceTreeById(Integer id) {
		// TODO 自动生成方法存根
		return resourceTreeDao.findById(id);
	}
	
	public List<ResourceTree> getResourceTreeByPid(Integer pid){
		return resourceTreeDao.findByMap(new String[]{"pid"}, new Object[]{pid});
	}
	
	public List<ResourceTree> getResourceTreeRootByGrpId(Integer grpId){
		return resourceTreeDao.findByMap(new String[]{"pid","groupId"}, new Object[]{0,grpId});
	}
	
	public void newSaveTree(ResourceTree tree) {
		try {
			resourceTreeDao.insert(tree);
			updateParentChildFlag(tree.getPid());
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	public void updateTree(ResourceTree tree) {
		try {
			resourceTreeDao.update(tree);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	public void updateParentChildFlag(Integer pid){
		ResourceTree parent = getResourceTreeById(pid);
		if(parent!=null && !parent.getChild()){
			parent.setChild(true);
			try {
				resourceTreeDao.update(parent);
			} catch (Exception e) {
				throw new ServiceException(e);
			}
		}
	}
	
	
	
	public void deleteTree(Integer id) {
		try {
			resourceTreeDao.deleteById(id);
		} catch (Exception e) {
			throw new ServiceException(e);
		}
	}
	
	@Resource
	private ResourceTreeDao resourceTreeDao;

	
}
