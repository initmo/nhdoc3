package com.nh.biz.service.system;



import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

import javax.annotation.Resource;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.nh.biz.dao.impl.system.RoleDao;
import com.nh.biz.domain.system.Role;
import com.nh.biz.service.ServiceException;

@Service
@Transactional
public class RoleMng {

	private static Logger logger  = LoggerFactory.getLogger(RoleMng.class);

	
	public List<Role> list(){
		return roleDao.findAll();
	}
	
	public Role getById(Integer roleId){
		return roleDao.findById(roleId);
	}
	
	public List<Role> listByIds(Integer[] roleIds){
		List<Role> list = new ArrayList<Role>();
		if(roleIds!=null && roleIds.length > 0 ){
			list = roleDao.findByIds(Arrays.asList(roleIds));
		}
		return list;
	}
	
	@Transactional
	public Integer insert(Role role){
		try {
			Integer roleId = (Integer)roleDao.insert(role);
			role.setRoleId(roleId);
			insertRolePerm(role);
			return roleId;
		} catch (Exception e) {
			logger.error("角色:{}保存出错", role.getRoleName());
			throw new ServiceException("角色保存出错",e);
		}
	}
	
	@Transactional
	public Role update(Role role){
		try {
		    roleDao.update(role);
		    deleteRolePerm(role.getRoleId());
		    insertRolePerm(role);
			return role;
		} catch (Exception e) {
			logger.error("角色:{}更新出错", role.getRoleName());
			throw new ServiceException("角色更新出错",e);
		}
	}
	
	@Transactional
	public void delete(Integer roleId){
		try {
			roleDao.deleteById(roleId);
			deleteRolePerm(roleId);
		} catch (Exception e) {
			logger.error("角色:{}删除出错", roleId);
			throw new ServiceException("角色删除出错",e);
		}
	}
	
	public void insertRolePerm(Role role){
		for(Integer permissionId : role.getPermissionIds()){
			roleDao.insertByStatementPostfix(
				RoleDao.INSERT_ROLEPERMISSIONS,
				new String[]{"roleId","permissionId"},
				new Integer[]{role.getRoleId(),permissionId});
		}
	}
	
	public void deleteRolePerm(Integer roleId){
		roleDao.deleteByStatementPostfix(
				RoleDao.DELETE_ROLEPERM_BY_ROLEID, 
				new String[]{"roleId"}, 
				new Integer[]{roleId});
	}
	
	@Resource
	private RoleDao roleDao;
}
