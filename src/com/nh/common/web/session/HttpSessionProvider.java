package com.nh.common.web.session;

import java.io.Serializable;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.nh.biz.domain.system.Department;
import com.nh.biz.domain.system.User;
import com.nh.biz.service.system.UserMng;

/**
 * HttpSession提供类
 * 
 * @author liufang
 * 
 */
public class HttpSessionProvider implements SessionProvider {

	public Serializable getAttribute(HttpServletRequest request, String name) {
		HttpSession session = request.getSession(false);
		if (session != null) {
			return (Serializable) session.getAttribute(name);
		} else {
			return null;
		}
	}

	public void setAttribute(HttpServletRequest request,String name, Serializable value) {
		HttpSession session = request.getSession();
		session.setAttribute(name, value);
	}

	public String getSessionId(HttpServletRequest request,
			HttpServletResponse response) {
		return request.getSession().getId();
	}

	public void logout(HttpServletRequest request, HttpServletResponse response) {
		HttpSession session = request.getSession(false);
		if (session != null) {
			session.invalidate();
		}
	}
	
	public User getSessionUser(HttpServletRequest request){
		return (User)getAttribute(request, UserMng.SESSION_USER);
	}

	public Department getDepartment(HttpServletRequest request) {
		User user= getSessionUser(request);
		return new Department(user.getDeptId(),user.getDeptName());
	}
	
}
