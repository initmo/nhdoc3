package com.nh.biz.domain.system;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.Collection;
import java.util.List;

import javax.jws.HandlerChain;

import org.apache.commons.lang.StringUtils;

public class Role  implements Serializable{

	private static final long serialVersionUID = 5724973293728057557L;
	private Integer roleId;
    private String roleName;
    private String roleDesc;
    private List<Permission> permission = new ArrayList<Permission>();
    
	public String getRoleName() {
		return roleName;
	}

	public void setRoleName(String roleName) {
		this.roleName = roleName;
	}

	public List<Permission> getPermission() {
		return permission;
	}

	public void setPermission(List<Permission> permission) {
		this.permission = permission;
	}

	public Collection<String> getPermissionList() {
		List<String> permissions = new ArrayList<String>();
		for (Permission permission : getPermission()){
			permissions.add(permission.getPermissionName());
		}
		return permissions;
	}
	
	public String getPermissionNames(){
		return StringUtils.join(getPermissionList(), ",");
	}
	                       
	public List<Integer> getPermissionIds(){
		List<Integer> permissionIds = new ArrayList<Integer>();
		for (Permission permission : getPermission()){
			permissionIds.add(permission.getPermissionId());
		}
		return permissionIds;
	}
	
	public Integer getRoleId() {
		return roleId;
	}

	public void setRoleId(Integer roleId) {
		this.roleId = roleId;
	}

	public String getRoleDesc() {
		return roleDesc;
	}

	public void setRoleDesc(String roleDesc) {
		this.roleDesc = roleDesc;
	}
	

}
