package com.nh.biz.service.system;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.nh.biz.dao.impl.system.PermissionDao;
import com.nh.biz.domain.system.Permission;

@Service
public class PermissionMng {
	
	public List<Permission> list(){
		return permissionDao.findAll();
	}
	
	public List<Permission> listByIds(String[] permissionIds){
		List<Permission> list = new ArrayList<Permission>();
		if(permissionIds!=null && permissionIds.length > 0 ){
			list = permissionDao.findByIds(Arrays.asList(permissionIds));
		}
		return list;
	}
	
	@Resource
	private PermissionDao permissionDao;
}
