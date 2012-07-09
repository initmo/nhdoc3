package com.nh.biz.controller;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;

import com.nh.biz.domain.system.User;
import com.nh.biz.service.MyActNoticeService;
import com.nh.biz.service.ResourceInfoService;
import com.nh.biz.service.ResourceTitleService;
import com.nh.biz.service.ResourceTreeService;
import com.nh.biz.service.system.DepartmentMng;
import com.nh.common.web.session.SessionProvider;


@Controller
public class MyActNoticeController {

	//更新提醒文档列表
	@RequestMapping(value="/resource/myactnotice")
	public String myactnotice(HttpServletRequest request,ModelMap modelMap){
		User user = sessionProvider.getSessionUser(request);
		modelMap.addAttribute("list", myActNoticeService.getMyActNotice(user));
		return "/resource/myactnotice";
	}
	
	@Resource
	private SessionProvider sessionProvider;
	@Resource
	private MyActNoticeService myActNoticeService;
	@Resource
	private ResourceTreeService resourceTreeService;
	@Resource
	private ResourceInfoService resourceInfoService;
	@Resource
	private ResourceTitleService resourceTitleService;	
	@Resource
	private DepartmentMng departmentMng;	
}
