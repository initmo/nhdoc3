package com.nh.biz.domain;

public class ResourceTree {

	private Integer id;
	private String treeName;
	private Integer groupId;
	private Integer pid;
	private boolean child;
	
	public boolean getChild() {
		return child;
	}
	public boolean isChild() {
		return child;
	}
	public void setChild(boolean child) {
		this.child = child;
	}
	public Integer getGroupId() {
		return groupId;
	}
	public void setGroupId(Integer groupId) {
		this.groupId = groupId;
	}
	public Integer getId() {
		return id;
	}
	public void setId(Integer id) {
		this.id = id;
	}
	public Integer getPid() {
		return pid;
	}
	public void setPid(Integer pid) {
		this.pid = pid;
	}
	public String getTreeName() {
		return treeName;
	}
	public void setTreeName(String treeName) {
		this.treeName = treeName;
	}
	
	
}
