package com.nh.core.bean;

import java.util.Map;

public class DhxTree {

	private String pid;
	private String id;
	private String text;
	private int child;
	private Map userdata;
	
	public int getChild() {
		return child;
	}
	public void setChild(int child) {
		this.child = child;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getPid() {
		return pid;
	}
	public void setPid(String pid) {
		this.pid = pid;
	}
	public String getText() {
		return text;
	}
	public void setText(String text) {
		this.text = text;
	}
	public Map getUserdata() {
		return userdata;
	}
	public void setUserdata(Map userdata) {
		this.userdata = userdata;
	}
	
	
}
