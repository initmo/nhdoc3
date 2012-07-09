package com.nh.biz.controller.system;

import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;

import com.nh.biz.domain.system.Department;
import com.nh.biz.service.system.DepartmentMng;
import com.nh.common.web.session.SessionProvider;

@Controller
public class DepartmentAct {
	
	@RequestMapping("/system/orgnizationa")
	public String department(ModelMap model){
		model.addAttribute("module", "department");
		return "system/department/orgnizationa";
	}
	
	@RequestMapping("/system/department/list")
	public void list(){}
	

	@RequestMapping("/system/department/edit")
	public String edit(Integer deptId,ModelMap model){
		Department dept = departmentMng.getById(deptId);
		Department pdept = departmentMng.getById(dept.getPid());
		model.addAttribute("dept",dept);
		model.addAttribute("pdept",pdept);
		return "system/department/input";
	}
	
	@RequestMapping("/system/department/add")
	public String add(Integer pid,ModelMap model){
		Department dept = new Department();
		Department pdept = departmentMng.getById(pid);
		dept.setPid(pid);
		model.addAttribute("dept",dept);
		model.addAttribute("pdept",pdept);
		return "system/department/input";
	}
	
	@RequestMapping("/system/department/save")
	public String save(Department dept){
		if (dept.getDeptId() == null){			
			departmentMng.insert(dept);
		}else{
			departmentMng.update(dept);
		}
		return "redirect:list"; 
	}
	
	@RequestMapping(value="/system/department/delete")
	public String delete(Integer deptId){
		departmentMng.delete(deptId);
		return "redirect:list";
	}
	
	
	//xml所有下属部门
	@RequestMapping("/system/department/listxml")
	public void listxml(HttpServletRequest request,ModelMap model){
		Integer myDeptId = sessionProvider.getSessionUser(request).getDeptId();
		List<Department> list =  new ArrayList<Department>();
		list.add(departmentMng.getById(myDeptId));
		list.addAll(departmentMng.getSubList(String.valueOf(myDeptId)));
		model.addAttribute("list",list);
	}
	
	//tree下属部门
	@RequestMapping(value="/system/department/treexml")
	public String getSubDepartment(String id,HttpServletRequest request, ModelMap model){
		Integer myDeptId = sessionProvider.getSessionUser(request).getDeptId();
		if ("0".equals(id)){
			List<Department> list =  new ArrayList<Department>();
			list.add(departmentMng.getById(myDeptId));
			model.addAttribute("list",list);
		}else{			
			model.addAttribute("list", departmentMng.getSubList(id));
		}
		model.addAttribute("pid", id);
		return "/system/department/treexml";      
	}
	
	//部门选择器
	@RequestMapping("/system/department/selectdept")
	public void selectdept(){   
	}
	
	
	@RequestMapping("/system/department/all")
	public String selectdept(String id,HttpServletRequest request, ModelMap model){
		model.addAttribute("list", departmentMng.getSubList(id));
		model.addAttribute("pid", id);
		return "/system/department/treexml";      
	}
	
	
	@Resource
	private SessionProvider sessionProvider;
	@Resource
	private DepartmentMng departmentMng;
}
