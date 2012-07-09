package com.nh.biz.controller;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.validation.Valid;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.nh.biz.domain.ResourceGroup;
import com.nh.biz.domain.ResourceTree;
import com.nh.biz.domain.system.Department;
import com.nh.biz.domain.system.User;
import com.nh.biz.service.ResourceGrpService;
import com.nh.biz.service.ResourceTreeService;
import com.nh.biz.service.system.DepartmentMng;
import com.nh.biz.service.system.UserMng;
import com.nh.common.web.session.SessionProvider;
import com.nh.core.utils.reflaection.CollectionMapper;

@Controller
public class SettingController {
	
	public static final String SETTING_MAIN          = "/setting/main";	
	public static final String SETTING_GROUP_EDIT    = "/setting/groupedit";
	public  final static String RESOURCE_TREE_XML    = "/resource/resourcetreexml";

	public static final String SETTING_TREE_EDIT     = "/setting/treeedit";
	
	@RequestMapping(value="/setting")
	public String resource(ModelMap modelMap){
		modelMap.addAttribute("module", "setting");
		return SETTING_MAIN;
	}
	
	@RequestMapping(value="/setting/settinggroup")
	public String settinggroup(HttpServletRequest request, ModelMap model){
		User user = sessionProvider.getSessionUser(request);
		Integer myDeptId = user.getDeptId();
		
		//获取维护部门分组
		//List<ResourceGroup> myUploadGrpList =  resourceGrpService.getResourceGrpByUploadDeptId(myDeptId);
        //获取本区域创建的部门分组
		List<ResourceGroup> myCreateGrpList =  resourceGrpService.getResourceGrpByCreateDeptId(myDeptId);
		
		///获取分组根目录
		List<ResourceTree> list = new ArrayList<ResourceTree>();
		for(ResourceGroup grp : myCreateGrpList){
			list.addAll(resourceTreeService.getResourceTreeRootByGrpId(grp.getId()));
		}
		
		model.addAttribute("list",list);
		model.addAttribute("pid", 0);
		return RESOURCE_TREE_XML;      
	}
	
	@RequestMapping(value="/setting/usergroup")
	public String usergroup(Integer userId,HttpServletRequest request, ModelMap model){
		User user = userMng.findById(String.valueOf(userId));
		Integer deptId = user.getDeptId();
		List<ResourceGroup> deptGrp =  resourceGrpService.getResourceGrpByUploadDeptId(deptId);
		
		///获取分组根目录
		List<ResourceTree> list = new ArrayList<ResourceTree>();
		for(ResourceGroup grp : deptGrp){
			list.addAll(resourceTreeService.getResourceTreeRootByGrpId(grp.getId()));
		}
		
		model.addAttribute("list",list);
		model.addAttribute("pid", 0);
		return RESOURCE_TREE_XML;      
	}
	
	
     //	新增文档库
	@RequestMapping(value="/setting/groupnew")
	public String groupnew(@ModelAttribute("group") ResourceGroup group, HttpServletRequest request,ModelMap modelMap){
	    Integer  pdeptId = sessionProvider.getDepartment(request).getDeptId();
	    modelMap.addAttribute("departments", departments(String.valueOf(pdeptId)));
		return SETTING_GROUP_EDIT;
	}
	
	 //修改文档库
	@RequestMapping(value="/setting/groupedit")
	public String groupedit(Integer id,String reloadtree,HttpServletRequest request, ModelMap modelMap){
		Integer  pdeptId = sessionProvider.getDepartment(request).getDeptId();
		modelMap.addAttribute("departments", departments(String.valueOf(pdeptId)));
		    
		modelMap.addAttribute("reloadtree", reloadtree);
		modelMap.addAttribute("group", resourceGrpService.getResourceGrpById(id));
		modelMap.addAttribute("tree", resourceTreeService.getResourceTreeRootByGrpId(id).get(0));
		return SETTING_GROUP_EDIT;
	}
	
	//保存文档库
	@RequestMapping(value="/setting/groupsave",method = RequestMethod.POST)
	public String groupsave(@ModelAttribute("group") @Valid ResourceGroup group,BindingResult result,String[] departmentIds, HttpServletRequest request, ModelMap modelMap){
		Boolean isNew = (group.getId()==null);
		if(result.hasErrors()){
			return isNew ? groupnew(group,request,modelMap) : groupedit(group.getId(),"",request,  modelMap);
		}
		
		if(isNew){
			User user = sessionProvider.getSessionUser(request);
			Integer myDeptId = user.getDeptId();
			group.setCreateDeptid(myDeptId);
			resourceGrpService.newSaveGrpInfo(group);
		}else{
			resourceGrpService.updateGrpInfo(group);
		}
		
		modelMap.addAttribute("reloadtree","true");
		modelMap.addAttribute("id",group.getId());
		modelMap.addAttribute("group",group);
		return "redirect:/setting/groupedit";
	}
	
	/**获取授权机构名称**/
	 @SuppressWarnings("unchecked")
	public Map<Integer,String> departments(String pdeptId){
		Department mydept = departmentMng.getById(Integer.valueOf(pdeptId)); 
		List<Department> subDept = departmentMng.getAllSubList(pdeptId);
		subDept.add(mydept);
		return CollectionMapper.extractToMap(subDept, "deptId", "deptName");	
	}
	
    //	新增子目录
	@RequestMapping(value="/setting/treenew")
	public String treepnew(@ModelAttribute("tree") ResourceTree tree,Integer groupId, Integer pid, ModelMap modelMap){
		ResourceTree parentTree  = null ;
		if(pid==0){
			parentTree = resourceTreeService.getResourceTreeRootByGrpId(groupId).get(0);
		}else{
			parentTree = resourceTreeService.getResourceTreeById(pid);	
		}
		tree.setGroupId(groupId);
		tree.setPid(parentTree.getId());
		tree.setChild(false);
		modelMap.addAttribute("tree", tree);
		modelMap.addAttribute("parentTree", parentTree);
		return SETTING_TREE_EDIT;
	}
	
	 //修改子目录
	@RequestMapping(value="/setting/treeedit")
	public String treeedit(Integer id, ModelMap modelMap){
		modelMap.addAttribute("tree", resourceTreeService.getResourceTreeById(id));
		return SETTING_TREE_EDIT;
	}
	//保存子目录
	@RequestMapping(value="/setting/treesave",method = RequestMethod.POST)
	public String treesave(@ModelAttribute("tree") @Valid ResourceTree tree,BindingResult result, HttpServletRequest request, ModelMap modelMap){
		Boolean isNew = (tree.getId()==null);
		if(result.hasErrors()){
			return null;
		}
		
		if(isNew){
			resourceTreeService.newSaveTree(tree);
		}else{
			resourceTreeService.updateTree(tree);
		}
		
		modelMap.addAttribute("reloadtree","true");
		modelMap.addAttribute("id",tree.getId());
		return "redirect:/setting/treeedit";
	}
	
	
	//删除树节点
	@ResponseBody
	@RequestMapping(value="/setting/treedelete")
	public String treedelete(Integer treeId){
		ResourceTree tree = resourceTreeService.getResourceTreeById(treeId);
		if (tree.getPid()==0){
			//删除文档库信息
			resourceGrpService.deleteGroup(tree.getGroupId());
		}
		//删除树信息
		resourceTreeService.deleteTree(tree.getId());
		return String.valueOf(treeId);
	}
	
	
	@Resource
	private UserMng userMng;
	@Resource
	private ResourceGrpService resourceGrpService;
	@Resource
	private ResourceTreeService resourceTreeService;
	@Resource
	private SessionProvider sessionProvider;
	@Resource
	private DepartmentMng departmentMng;
}
