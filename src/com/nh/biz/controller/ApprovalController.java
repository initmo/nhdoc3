package com.nh.biz.controller;

import java.io.IOException;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.sf.json.JSONArray;
import net.sf.json.util.JSONUtils;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.nh.biz.domain.ResourceApproval;
import com.nh.biz.domain.system.User;
import com.nh.biz.service.ResourceApprovalService;
import com.nh.common.web.session.SessionProvider;
import com.nh.core.page.PageQuery;
import com.nh.core.page.Pagination;

@Controller
public class ApprovalController {
	
	@RequestMapping(value="/resource/myapproval")
	public String myapproval(HttpServletRequest request,ModelMap modelMap){
		return "/resource/myapproval";
	}
	
	//待审核文档列表
	@RequestMapping(value="/resource/myapprovalsentxml")
	public String myapprovalsentxml(PageQuery pageQuery, HttpServletRequest request, ModelMap modelMap){
		User user = sessionProvider.getSessionUser(request);
		modelMap.addAttribute("pagination", resourceApprovalService.getMyApprovalRequest(user, pageQuery));
		return "/resource/myapprovalsentxml";
	}
	
	//已审核文档列表
	@RequestMapping(value="/resource/myapprovalfinishxml")
	public String myapprovalfinishxml(PageQuery pageQuery,HttpServletRequest request,ModelMap modelMap){
		User user = sessionProvider.getSessionUser(request);
		modelMap.addAttribute("pagination", resourceApprovalService.getMyFinishedApproval(user, pageQuery));
		return "/resource/myapprovalsentxml";
	}
	
	//批量审核通过
	@ResponseBody 
	@RequestMapping(value="/resource/batchpassapproval")
	public String batchpassapproval(String ids,HttpServletRequest request,ModelMap modelMap){
		String[] idArray = ids.split(",");
		User checker = sessionProvider.getSessionUser(request);
		for(String id : idArray){
			ResourceApproval  approvalRequest = resourceApprovalService.getResourceApprovalById(Integer.valueOf(id));
			resourceApprovalService.approvalPass(approvalRequest,checker);
		}
		return "success";
	}
	
//	批量审核退回
	@ResponseBody 
	@RequestMapping(value="/resource/batchbackapproval")
	public String batchbackapproval(String ids,HttpServletRequest request,ModelMap modelMap){
		String[] idArray = ids.split(",");
		User checker = sessionProvider.getSessionUser(request);
		for(String id : idArray){
			ResourceApproval  approvalRequest = resourceApprovalService.getResourceApprovalById(Integer.valueOf(id));
			resourceApprovalService.approvalBack(approvalRequest,checker);
		}
		return "success";
	}
	
	//审核界面
	@RequestMapping(value="/resource/approval",method = RequestMethod.GET)
	public String approvalView(Integer id,ModelMap modelMap){
		ResourceApproval resourceApproval = resourceApprovalService.getResourceApprovalById(id);
		modelMap.addAttribute("resourceApproval", resourceApproval);
		return "/resource/resourceapproval";
	}
	
	//审核提交
	@RequestMapping(value="/resource/approval",method = RequestMethod.POST)
	public String approvalPost(ResourceApproval approvalInfo,Boolean approvalFlag,HttpServletRequest request,ModelMap modelMap){
		User checker = sessionProvider.getSessionUser(request);
		ResourceApproval approvalRequest = resourceApprovalService.getResourceApprovalById(approvalInfo.getId());
		approvalRequest.setComments(approvalInfo.getComments());
		if(approvalFlag){			
			resourceApprovalService.approvalPass(approvalRequest, checker);
		}else{
			resourceApprovalService.approvalBack(approvalRequest, checker);
		}
		
		return "redirect:/resource/myapproval";
	}
	
	//单个文档的历史审核记录
	@RequestMapping(value="/resource/approvalhistory")
	public void approvalhistory(Integer resourceId,HttpServletResponse response, ModelMap modelMap) throws IOException{
		List<ResourceApproval> list = resourceApprovalService.getResourceApprovalHistory(resourceId);
		JSONArray json = JSONArray.fromObject(list);
		response.setContentType("text/html;charset=UTF-8");
		response.getWriter().print(json.toString());	 
	}
	
	
	@Resource
	private SessionProvider sessionProvider;
	@Resource
	private ResourceApprovalService resourceApprovalService;
}
