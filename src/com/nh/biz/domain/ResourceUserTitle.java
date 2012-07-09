package com.nh.biz.domain;

public class ResourceUserTitle {


	private Integer userId;
	private boolean arrowedAct;
	private boolean arrowedApproval;
	private ResourceTitle resourceTitle;
	
	public ResourceUserTitle(){
		
	}
	public ResourceUserTitle(ResourceTitle resourceTitle){
		this.resourceTitle = resourceTitle;
	}
	
	public boolean isArrowedAct() {
		return arrowedAct;
	}
	public void setArrowedAct(boolean arrowedAct) {
		this.arrowedAct = arrowedAct;
	}
	public boolean isArrowedApproval() {
		return arrowedApproval;
	}
	public void setArrowedApproval(boolean arrowedApproval) {
		this.arrowedApproval = arrowedApproval;
	}
	public Integer getUserId() {
		return userId;
	}
	public void setUserId(Integer userId) {
		this.userId = userId;
	}
	public ResourceTitle getResourceTitle() {
		return resourceTitle;
	}
	public void setResourceTitle(ResourceTitle resourceTitle) {
		this.resourceTitle = resourceTitle;
	}
	
}
