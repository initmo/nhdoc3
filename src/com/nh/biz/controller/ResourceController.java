package com.nh.biz.controller;

import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.apache.commons.lang.StringUtils;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;

import com.nh.biz.domain.ResourceGroup;
import com.nh.biz.domain.ResourceInfo;
import com.nh.biz.domain.ResourceTitle;
import com.nh.biz.domain.ResourceTree;
import com.nh.biz.domain.system.Department;
import com.nh.biz.domain.system.User;
import com.nh.biz.service.ResourceGrpService;
import com.nh.biz.service.ResourceInfoService;
import com.nh.biz.service.ResourceTitleService;
import com.nh.biz.service.ResourceTreeService;
import com.nh.biz.service.system.DepartmentMng;
import com.nh.common.web.session.SessionProvider;
import com.nh.core.page.Pagination;

@Controller
public class ResourceController {

	public  final static String  RESOURCE_TREE_XML  = "/resource/resourcetreexml";
	public static final String RESOURCEINFO_LIST     = "/resource/resourceinfolist";
	public static final String MYACTRESOURCEINFO_LIST     = "/resource/myactresourceinfolist";
	public static final String RESOURCEINFO_LIST_XML = "/resource/resourceinfolistxml";
	public final static String  RESOURCE_TITLE_LIST  = "/resource/resourcetitlelist";
	
	public static final String RESOURCEINFO_LIST_MYACT     = "/resource/myact";
	public static final String RESOURCEINFO_SEARCH     = "/resource/resourcesearch";
	public static final String RESOURCEINFO_SEARCH_XML     = "/resource/resourcesearchxml";
	
	public static final String VIEW_DEPARTMENT = "viewdepartment";
	
	@RequestMapping(value="/")
	public String index(){
		return "redirect:/resource";
	}
	
	@RequestMapping(value="/resource")
	public String resource(ModelMap modelMap){
		modelMap.addAttribute("module", "resource");
		return "resource/main";
	}
	
	//获取指定单位的目录组，若未指定单位（deptId）参数，则默认为本单位。
	@RequestMapping(value="/resourcegroup")
	public String resourcegroup(Integer deptId,HttpServletRequest request,ModelMap model){

		User user = sessionProvider.getSessionUser(request);
		if (deptId==null || user.getDeptId().equals(deptId)) {
			deptId = user.getDeptId();
			sessionProvider.setAttribute(request, VIEW_DEPARTMENT,sessionProvider.getDepartment(request));
		}
		else{			
			sessionProvider.setAttribute(request, VIEW_DEPARTMENT, departmentMng.getById(deptId));
		}
			
		//获取维护部门分组
		List<ResourceGroup> grpList =  resourceGrpService.getResourceGrpByUploadDeptId(deptId);
		
		///获取分组根目录
		List<ResourceTree> list = new ArrayList<ResourceTree>();
		for(ResourceGroup grp : grpList){
			list.addAll(resourceTreeService.getResourceTreeRootByGrpId(grp.getId()));
		}
		
		model.addAttribute("list",list);
		model.addAttribute("pid", 0);
		return RESOURCE_TREE_XML;      
	}
	
	
	@RequestMapping(value="/resource/resourcetitlelist")
	public String viewresourcetitle(Integer treeId,ModelMap modelMap,HttpServletRequest request){
		List<ResourceTitle> titleList =  resourceTitleService.getResourceTitleByTreeId(treeId);
		Map resourceCountMap = resourceTitleService.getReourceCounts(treeId, getViewDepartment(request).getDeptId());
		for(ResourceTitle rt : titleList){
			rt.setResourceCount((Integer)resourceCountMap.get(rt.getId()));	
		}
		modelMap.addAttribute("list",titleList);
		return RESOURCE_TITLE_LIST;
	}
	

	
	//根据分组父节点获取子节点
	@RequestMapping(value="/resourcetree")
	public String resourcetree(Integer id,HttpServletRequest request,ModelMap model){
	   model.addAttribute("list", resourceTreeService.getResourceTreeByPid(id));
	   model.addAttribute("pid", id);
	   return RESOURCE_TREE_XML;      
	}
    //文档列表页面
	@RequestMapping(value="/resource/resourceinfolist")
	public String resourceinfoList(Integer titleId,Integer pid,HttpServletRequest request, ModelMap modelMap){
		String userId = sessionProvider.getSessionUser(request).getUserId();
		
		ResourceTitle title = resourceTitleService.getResourceTitleById(titleId);
		modelMap.addAttribute("resourcepid", pid);
		modelMap.addAttribute("resourcetitle", title);
		
		Boolean canAct = true;
		if(isMyDepartment(request)){
			canAct = resourceTitleService.isActorsTitle(userId, title);
		}else{
			canAct = false;
		}
		modelMap.addAttribute("canAct", canAct);
		return RESOURCEINFO_LIST;
	} 
	
    //文档列表页面-更新提醒
	@RequestMapping(value="/resource/myactresourceinfolist")
	public String myactresourceinfolist(Integer titleId,Integer pid,HttpServletRequest request, ModelMap modelMap){
		String userId = sessionProvider.getSessionUser(request).getUserId();
		
		ResourceTitle title = resourceTitleService.getResourceTitleById(titleId);
		modelMap.addAttribute("resourcepid", pid);
		modelMap.addAttribute("resourcetitle", title);
		
		Boolean canAct  = resourceTitleService.isActorsTitle(userId, title);
		modelMap.addAttribute("canAct", canAct);
		return MYACTRESOURCEINFO_LIST;
	}
	
	//文档列表表格数据
	@RequestMapping(value="/resource/resourceinfolistxml")
	public String resourceinfoListXml(Integer pid,Integer titleId,String my, HttpServletRequest request,ModelMap modelMap){
		ResourceInfo parent = null;
		List<ResourceInfo> list= new ArrayList<ResourceInfo>();		
	    if(pid==0){
	    	parent = new ResourceInfo();
	    	parent.setId(pid);
	    	parent.setTitleid(titleId);
	    	
	    	Department viewdepartment = getViewDepartment(request);
	    	if(StringUtils.isNotEmpty(my) && "true".equals(my)){
	    		viewdepartment = sessionProvider.getDepartment(request);
	    	}
	    	
	    	list = resourceInfoService.getResourceInfoList(titleId, pid, viewdepartment.getDeptId());
	    }else{
	    	parent = resourceInfoService.getResourceInfo(pid);
		    list= resourceInfoService.getResourceInfoListByParent(parent);
	    }

	    modelMap.addAttribute("newdate", new Date((new Date()).getTime() - 300 * 1000));
	    modelMap.addAttribute("parent", parent);
		modelMap.addAttribute("list", list);
		return RESOURCEINFO_LIST_XML;
	}
	
	
	/**我的任务**/
	@RequestMapping(value="/resource/myact")
	public String resourceinfoList(String view, HttpServletRequest request, ModelMap modelMap){
		if(StringUtils.isEmpty(view))
			view = "draft";
		modelMap.addAttribute("view",view);
		return RESOURCEINFO_LIST_MYACT;
	}
	
    //草稿文档列表表格数据
	@RequestMapping(value="/resource/myactresourceinfolistxml")
	public String myactresourceinfolistxml(Integer status,HttpServletRequest request,ModelMap modelMap){
	    String userId = sessionProvider.getSessionUser(request).getUserId();
		List<ResourceInfo> list=  resourceInfoService.getMyActResourceInfoListByStatus(userId,status);
		modelMap.addAttribute("list", list);
		modelMap.addAttribute("newdate", new Date((new Date()).getTime() - 300 * 1000));
		return RESOURCEINFO_LIST_XML;
	}
	
	
	/**搜索页面**/
	@RequestMapping(value="/resource/search")
	public String search(Integer deptId,HttpServletRequest request,ModelMap modelMap){
		return RESOURCEINFO_SEARCH;
	}
	
	/**搜索结果*
	 * @throws UnsupportedEncodingException */
	@RequestMapping(value="/resource/resourcesearchxml")
	public String resourcesearchxml(Integer deptId,String keyval,Integer pageSize,Integer pageNo, HttpServletRequest request,ModelMap modelMap) throws UnsupportedEncodingException{
	   if(null == deptId){		   
		   deptId = sessionProvider.getDepartment(request).getDeptId();
	   }
	    keyval = URLDecoder.decode(keyval, "UTF-8");
		Map<String, Object> searchParamMap = new HashMap<String, Object>();
		searchParamMap.put("like_filealiasname", "%"+keyval+"%");
		searchParamMap.put("departmentid", deptId);
		//List<ResourceInfo> result =  resourceInfoService.search(searchParamMap);
		//modelMap.addAttribute("list", result);
		
		Pagination<ResourceInfo> pagination = resourceInfoService.searchByPage(searchParamMap, pageSize, pageNo); 
		modelMap.addAttribute("pagination",pagination);
		return RESOURCEINFO_SEARCH_XML;
	}
	
	
//	获取当前文档查看单位
	public Department getViewDepartment(HttpServletRequest request){
		Department viewdepartment = (Department)sessionProvider.getAttribute(request, VIEW_DEPARTMENT);
		if (viewdepartment==null)
			viewdepartment = sessionProvider.getDepartment(request);
		return viewdepartment;
	}
	
//判断当前查询是否是本单位
	public Boolean isMyDepartment (HttpServletRequest request){
		return sessionProvider.getDepartment(request).equals(getViewDepartment(request));  
	}
	
	
	@Resource
	private SessionProvider sessionProvider;
	@Resource
	private ResourceGrpService resourceGrpService;
	@Resource
	private ResourceTreeService resourceTreeService;
	@Resource
	private ResourceInfoService resourceInfoService;
	@Resource
	private ResourceTitleService resourceTitleService;	
	@Resource
	private DepartmentMng departmentMng;	
}
