package com.nh.common.web.session;

import java.io.Serializable;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.nh.biz.domain.system.Department;
import com.nh.biz.domain.system.User;

/**
 * Session提供者
 * 
 * @author liufang
 * 
 */
public interface SessionProvider {
	public Serializable getAttribute(HttpServletRequest request, String name);

	public void setAttribute(HttpServletRequest request,String name, Serializable value);

	public String getSessionId(HttpServletRequest request,
			HttpServletResponse response);

	public User getSessionUser(HttpServletRequest request);
	
	public Department getDepartment(HttpServletRequest request);
	
	public void logout(HttpServletRequest request, HttpServletResponse response);
}
