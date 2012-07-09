package com.nh.biz.controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletResponse;

import net.sf.json.JSONArray;

import org.apache.commons.lang.StringUtils;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.nh.biz.domain.ResourceActor;
import com.nh.biz.domain.ResourceChecker;
import com.nh.biz.domain.ResourceTitle;
import com.nh.biz.domain.system.Department;
import com.nh.biz.domain.system.User;
import com.nh.biz.service.ResourceGrpService;
import com.nh.biz.service.ResourceTitleService;
import com.nh.biz.service.ResourceTreeService;
import com.nh.biz.service.system.UserMng;
import com.nh.core.utils.reflaection.ConvertUtils;

@Controller
public class SettingCheckerController {

	public static final String SETTING_TITLE_CHECKERS    = "/setting/titlecheckers";
	
	//文档审核授权
	@RequestMapping(value="/setting/titlecheckers")
	public String titleactors(Integer titleId,ModelMap modelMap){
		ResourceTitle title = resourceTitleService.getResourceTitleById(titleId);
		Integer groupId = resourceTreeService.getResourceTreeById(title.getTreeId()).getGroupId();
		List<Department> actDepartments = resourceGrpService.getActDepartments(groupId);
		modelMap.addAttribute("actDepartments", actDepartments);
		
		List<ResourceChecker> checkers = resourceTitleService.getCheckers(titleId);
		String checkerIds = ConvertUtils.convertElementPropertyToString(checkers, "userid", ",");
		checkerIds = StringUtils.isEmpty(checkerIds) ? "" : (","+checkerIds);
		modelMap.addAttribute("checkerIds", checkerIds);
		modelMap.addAttribute("titleId", titleId);
		modelMap.addAttribute("title", title);
		return SETTING_TITLE_CHECKERS;
	}
	
    //	获取审核人员
	@RequestMapping(value="/setting/titlecheckers/checkers")
	public void checkers(Integer deptId,HttpServletResponse response, ModelMap modelMap) throws IOException{
		List<User> checkers = usemng.findByDepartment(String.valueOf(deptId));
		JSONArray jsonCheckers = JSONArray.fromObject(checkers);//
		response.setContentType("text/html;charset=UTF-8");
		response.getWriter().print(jsonCheckers.toString());
	}
	
	//ajax保存审核人员
	@RequestMapping(value="/setting/titlecheckers/save",method = RequestMethod.POST)
	public void checkerssave(Integer titleId,String checkerIds,String isApproval,HttpServletResponse response) throws IOException{
		
		
		Boolean bIsApproval = "true".equals(isApproval);
		resourceTitleService.setEnableApproval(titleId,bIsApproval);
		
		List<ResourceChecker> checkers = new ArrayList<ResourceChecker>();
		String[] checkerIdArray = checkerIds.split(",");
		if(checkerIdArray.length > 0 ){
			for(String checkerId : checkerIdArray){
				if(StringUtils.isNotEmpty(checkerId))
					checkers.add(new ResourceChecker(titleId,Integer.valueOf(checkerId)));
			}
		}
		
		resourceTitleService.updateCheckers(titleId,checkers);
		
		response.setContentType("text/html;charset=UTF-8");
		response.getWriter().print("succ");
	}
	
	
	
	@Resource
	private ResourceTitleService resourceTitleService;
	@Resource
	private ResourceGrpService resourceGrpService;
	@Resource
	private ResourceTreeService resourceTreeService;
	
	@Resource
	private UserMng usemng;

}
