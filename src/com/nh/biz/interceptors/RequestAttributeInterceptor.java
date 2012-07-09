package com.nh.biz.interceptors;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;

public class RequestAttributeInterceptor implements HandlerInterceptor {


	public void afterCompletion(HttpServletRequest req,
			HttpServletResponse res, Object arg2, Exception ex)
			throws Exception {
        // TODO 自动生成方法存根
	}

	public void postHandle(HttpServletRequest req, HttpServletResponse res,
			Object obj, ModelAndView model) throws Exception {
		// TODO 自动生成方法存根
		req.setAttribute("base", req.getContextPath());
	}

	public boolean preHandle(HttpServletRequest req, HttpServletResponse res,
			Object obj) throws Exception {
		// TODO 自动生成方法存根
		return true;
	}

}
