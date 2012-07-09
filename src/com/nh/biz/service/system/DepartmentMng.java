package com.nh.biz.service.system;

import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.nh.biz.dao.impl.system.DepartmentDao;
import com.nh.biz.domain.system.Department;
import com.nh.biz.service.ServiceException;
import com.nh.core.utils.reflaection.ConvertUtils;

@Service("departmentMng")
public class DepartmentMng {
	
	private static Logger logger  = LoggerFactory.getLogger(DepartmentMng.class);
	
	public List<Department> list(){
		return departmentDao.findAll();
	}
	
	public List<Department> getSubList(String pid){
		return departmentDao.findByMap(new String[]{"pid"}, new String[]{pid}, "deptId", "asc");
	}
	
	public List<Department> getAllSubList(String pid){
		List<Department> result = new ArrayList<Department>();
	    for(Department dept : departmentDao.findByMap(new String[]{"pid"}, new String[]{pid}, "deptId", "asc")){
	    	result.add(dept);
	    	if(dept.isHasChild()) result.addAll(getAllSubList(String.valueOf(dept.getDeptId())));
	    }
		return result;
	}
	
	public Department getById(Integer deptId) {
		return departmentDao.findById(deptId);
	}
	
	public String getNameById(Integer deptId) {
		return getById(deptId).getDeptName();
	}

	//部门新增
	@Transactional
	public Integer insert(Department dept){
		try {
			Integer deptId = (Integer)departmentDao.insert(dept);
			setHasChild(dept.getPid());
			return deptId;
		} catch (Exception e) {
			logger.error("部门:{}保存出错", dept.getDeptName());
			throw new ServiceException("部门保存出错",e);
		}
	}
	
	//部门更新
	@Transactional
	public Department update(Department dept){
		try {
			//更新前父id
			Integer opid =  departmentDao.findById(dept.getDeptId()).getPid();
			departmentDao.update(dept);
			setHasChild(opid);
			setHasChild(dept.getPid());
			return dept;
		} catch (Exception e) {
			logger.error("部门:{}更新出错", dept.getDeptName());
			throw new ServiceException("部门更新出错",e);
		}
	}
	
	//部门删除
	@Transactional
	public void delete(Integer deptId){
		try {
			Department dept = getById(deptId);
			departmentDao.deleteById(deptId);
			setHasChild(dept.getPid());
		} catch (Exception e) {
			logger.error("部门:{}删除出错", deptId);
			throw new ServiceException("部门删除出错",e);
		}
	}
	
	//检查更新是否有下属部门，更新标志位。
	public void setHasChild(Integer deptId){
		Boolean hasChild = (departmentDao.count(new String[]{"pid"}, new Integer[]{deptId}) > 0);
		try {
			departmentDao.update(deptId, new String[]{"hasChild"}, new Object[]{hasChild});
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	public Object getDeptNames(List<Integer> needDeptEvaluateDeptIds) {
		List<Department> list = new ArrayList<Department>();
		if (needDeptEvaluateDeptIds!=null && needDeptEvaluateDeptIds.size()>0){
			list =	departmentDao.findByIds(needDeptEvaluateDeptIds);
		}
		 return ConvertUtils.convertElementPropertyToString(list, "deptName", ",");
	}
	
	@Resource
	private DepartmentDao departmentDao;


}
