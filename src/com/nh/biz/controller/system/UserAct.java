package com.nh.biz.controller.system;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.apache.commons.lang.StringUtils;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.nh.biz.domain.system.Department;
import com.nh.biz.domain.system.Role;
import com.nh.biz.domain.system.User;
import com.nh.biz.service.system.DepartmentMng;
import com.nh.biz.service.system.RoleMng;
import com.nh.biz.service.system.UserMng;
import com.nh.core.utils.reflaection.CollectionMapper;

@Controller
@RequestMapping("/system/user")             
public class UserAct {

	@RequestMapping(value="")
	public String user(){
		return "/system/user/frame";
	}
	
	@RequestMapping(value="/list")
	public String list(Integer deptId,ModelMap modelMap){
		modelMap.addAttribute("dept",departmentMng.getById(deptId));
		return "system/user/list"; 
	}
	
	@RequestMapping(value="/userxml")
	public void userxml(String deptId, ModelMap model){
		model.addAttribute("list",userMng.findByDepartment(deptId));
	}
	
	@RequestMapping(value="/add")
	public String add(Integer deptId,ModelMap model){
		User user = new User();
		Department dept = departmentMng.getById(deptId);
		user.setDeptId(dept.getDeptId());
		user.setDeptName(dept.getDeptName());
		model.addAttribute("user",user);
		return "system/user/input";
	}
	
	@RequestMapping(value="/edit")
	public String edit(String userId, ModelMap model) {
		User user = userMng.findById(userId);
		model.addAttribute("user", user);
		return "system/user/input";
	}
	
	@RequestMapping("/save")
	public String save (User user,Integer[] roleIds,ModelMap modelMap){
		List<Role> selectedRole = roleMng.listByIds(roleIds);
		user.setRoleList(selectedRole);

	    if (StringUtils.isEmpty(user.getUserId())) {	    	
	    	userMng.insert(user);
	    }
	    else {
	    	userMng.update(user);
	    }
		return list(user.getDeptId(),modelMap);
	}
	
	@RequestMapping(value="/delete")
	public String delete(String userId,Integer deptId,ModelMap modelMap){
		userMng.delete(userId);
		return list(deptId,modelMap);
	}
		
	@SuppressWarnings("unchecked")
	@ModelAttribute("allRoles")
	public Map<Integer,String> allRoles(){
		return CollectionMapper.extractToMap(roleMng.list(), "roleId", "roleName");	
	}
	
	@Resource
	private UserMng userMng; 
	@Resource
	private DepartmentMng departmentMng;
	@Resource
	private RoleMng roleMng;
}
