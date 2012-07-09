package com.nh.biz.domain.system;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.List;

import com.nh.core.utils.reflaection.ConvertUtils;

public class User implements Serializable{

	private static final long serialVersionUID = 8060780109724104865L;
	private String userId;
	private String loginName;
	private String userName;
	private String passWord;
	private Integer deptId;
	
	//非持久化字段
	private String deptName;
	
    //非持久化字段
	private List<Role> roleList = new ArrayList<Role>();
	
	public String getRoleNames(){
		return ConvertUtils.convertElementPropertyToString(roleList, "roleName", ",");
	}
	
	@SuppressWarnings("unchecked")
	public List<Integer> getRoleIds(){
		return ConvertUtils.convertElementPropertyToList(roleList, "roleId");
	}
	
	public Integer getDeptId() {
		return deptId;
	}
	public void setDeptId(Integer deptId) {
		this.deptId = deptId;
	}
	public String getLoginName() {
		return loginName;
	}
	public void setLoginName(String loginName) {
		this.loginName = loginName;
	}
	public List<Role> getRoleList() {
		return roleList;
	}
	public void setRoleList(List<Role> roleList) {
		this.roleList = roleList;
	}
	public String getUserId() {
		return userId;
	}
	public void setUserId(String userId) {
		this.userId = userId;
	}
	public String getUserName() {
		return userName;
	}
	public void setUserName(String userName) {
		this.userName = userName;
	}
	public String getPassWord() {
		return passWord;
	}
	public void setPassWord(String passWord) {
		this.passWord = passWord;
	}
	public String getDeptName() {
		return deptName;
	}
	public void setDeptName(String deptName) {
		this.deptName = deptName;
	}
	
	

}
