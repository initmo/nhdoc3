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
import org.springframework.web.bind.annotation.ResponseBody;

import com.nh.biz.domain.ResourceActor;
import com.nh.biz.domain.ResourceChecker;
import com.nh.biz.domain.ResourceTitle;
import com.nh.biz.domain.ResourceUserTitle;
import com.nh.biz.domain.system.Department;
import com.nh.biz.domain.system.User;
import com.nh.biz.service.ResourceGrpService;
import com.nh.biz.service.ResourceTitleService;
import com.nh.biz.service.ResourceTreeService;
import com.nh.biz.service.system.UserMng;
import com.nh.core.utils.reflaection.ConvertUtils;

@Controller
public class SettingActorController {

	public static final String SETTING_TITLE_ACTIORS    = "/setting/titleactors";
	
	//文档授权
	@RequestMapping(value="/setting/titleactors")
	public String titleactors(Integer titleId,ModelMap modelMap){
		Integer groupId = resourceTreeService.getResourceTreeById(resourceTitleService.getResourceTitleById(titleId).getTreeId()).getGroupId();
		List<Department> actDepartments = resourceGrpService.getActDepartments(groupId);
		modelMap.addAttribute("actDepartments", actDepartments);
		
		List<ResourceActor> actors = resourceTitleService.getActors(titleId);
		String actorIds = ConvertUtils.convertElementPropertyToString(actors, "userid", ",");
		actorIds = StringUtils.isEmpty(actorIds) ? "" : (","+actorIds);
		modelMap.addAttribute("actorIds", actorIds);
		
		modelMap.addAttribute("titleId", titleId);
		
		return SETTING_TITLE_ACTIORS;
	}
	
	//授权人员

	@RequestMapping(value="/setting/titleactors/actors")
	public void actors(Integer deptId,HttpServletResponse response, ModelMap modelMap) throws IOException{
		List<User> actors = usemng.findByDepartment(String.valueOf(deptId));
		JSONArray jsonActors = JSONArray.fromObject(actors);//
		response.setContentType("text/html;charset=UTF-8");
		response.getWriter().print(jsonActors.toString());
	}
	
	//ajax保存授权人员
	@RequestMapping(value="/setting/titleactors/save",method = RequestMethod.POST)
	public void actorssave(Integer titleId,String actorIds,HttpServletResponse response) throws IOException{
		List<ResourceActor> actors = new ArrayList<ResourceActor>();
		String[] actorIdArray = actorIds.split(",");
		if(actorIdArray.length > 0 ){
			for(String actorId : actorIdArray){
				if(StringUtils.isNotEmpty(actorId))
				actors.add(new ResourceActor(titleId,Integer.valueOf(actorId)));
			}
		}
		
		resourceTitleService.updateActors(titleId,actors);
		
		response.setContentType("text/html;charset=UTF-8");
		response.getWriter().print("succ");
	}
	
	
	
	////////////////////////////////人员设置模块设置title权限///////////////////////////////////////
	@RequestMapping(value="/setting/usertitles")
	public String usertitles(Integer userId,ModelMap modelMap){
		modelMap.addAttribute("user", usemng.findById(String.valueOf(userId)));
		modelMap.addAttribute("userId", userId);
		return "/setting/usertitles/main";
	}
	
	@RequestMapping(value="/setting/usertitlelist")
	public String usertitlelist(Integer userId,Integer treeId,ModelMap modelMap){
		List<ResourceTitle> titles = resourceTitleService.getResourceTitleByTreeId(treeId);
		ResourceUserTitle usertitle = null;
		List<ResourceUserTitle> list = new ArrayList<ResourceUserTitle>();
		for(ResourceTitle title : titles){
			usertitle = new ResourceUserTitle(title);
			usertitle.setArrowedAct(resourceTitleService.hasActTitle(userId, title.getId()));
			usertitle.setArrowedApproval(resourceTitleService.hasApprovalTitle(userId, title.getId()));
			list.add(usertitle);
		}
		modelMap.addAttribute("treeId", treeId);
		modelMap.addAttribute("list", list);
		return "/setting/usertitles/usertitlelist";
	}
	
	@RequestMapping(value="/setting/usertitles/setact")
	@ResponseBody
	//?set=on&titleId="+titleId+"&userId="+userId
	public String setAct(ResourceActor resourceActor,String set, ModelMap modelMap){
		if("on".equals(set)){			
			resourceTitleService.insertActor(resourceActor);
		}else{
			resourceTitleService.deleteUserActTitle(resourceActor);
		}
		return "success";
	}
	
	@RequestMapping(value="/setting/usertitles/setapproval")
	@ResponseBody
	public String setApproval(ResourceChecker resourceChecker,String set, ModelMap modelMap){
		if("on".equals(set)){			
			resourceTitleService.insertChecker(resourceChecker);
		}else{
			resourceTitleService.deleteUserApprovalTitle(resourceChecker);
		}
		return "success";
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
