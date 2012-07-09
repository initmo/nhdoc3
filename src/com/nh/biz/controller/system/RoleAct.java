package com.nh.biz.controller.system;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.nh.biz.domain.system.Permission;
import com.nh.biz.domain.system.Role;
import com.nh.biz.service.system.PermissionMng;
import com.nh.biz.service.system.RoleMng;

@Controller
@RequestMapping("/system/role")
public class RoleAct {

	@RequestMapping("/list")
	public void list(){
	}
	
	@RequestMapping("/listxml")
	public void xmllist(ModelMap model){
		List<Role> list = roleMng.list();
		model.addAttribute("list",list);
	}
	
	@RequestMapping("/edit")
	public String edit(Integer roleId,ModelMap model){
		Role role = roleMng.getById(roleId);
		model.addAttribute(role);
		return "system/role/input";
	}
	
	@RequestMapping("/add")
	public String add(ModelMap model){
		Role role = new Role();
		model.addAttribute(role);
		return "system/role/input";
	}
	
	@RequestMapping("/save")
	public String save(Role role,String[] permissionIds){
		List<Permission> permissions = permissionMng.listByIds(permissionIds);
		role.setPermission(permissions);
		
	    if (role.getRoleId() == null) {	    	
	    	roleMng.insert(role);
	    }
	    else {
	    	roleMng.update(role);
	    }
		return "redirect:list";
	}
	
	@RequestMapping(value="/delete",method=RequestMethod.GET)
	public String delete(Integer roleId){
		roleMng.delete(roleId);
		return "redirect:list";
	}
	
	@ModelAttribute("permissions")
	public Map<Integer,String> getPermissions(){
		Map<Integer, String> permissions = new HashMap<Integer, String>();
		List<Permission> permissionList = permissionMng.list();
		for (Permission permission : permissionList){
			permissions.put(permission.getPermissionId(), permission.getPermissionDisplay());
		}
		permissions.remove(null);
		return permissions;
	}
	
	
	@Resource
	private RoleMng roleMng;
	@Resource
	private PermissionMng permissionMng;
}
