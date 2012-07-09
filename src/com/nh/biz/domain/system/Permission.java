package com.nh.biz.domain.system;

import java.io.Serializable;

public class Permission  implements Serializable{

	private static final long serialVersionUID = -4770515560227819425L;
	private Integer permissionId ;
	private String permissionName ;
	private String permissionDisplay ;
	
	public String getPermissionDisplay() {
		return permissionDisplay;
	}
	public void setPermissionDisplay(String permissionDisplay) {
		this.permissionDisplay = permissionDisplay;
	}
	public Integer getPermissionId() {
		return permissionId;
	}
	public void setPermissionId(Integer permissionId) {
		this.permissionId = permissionId;
	}
	public String getPermissionName() {
		return permissionName;
	}
	public void setPermissionName(String permissionName) {
		this.permissionName = permissionName;
	}
	
	
	
}
