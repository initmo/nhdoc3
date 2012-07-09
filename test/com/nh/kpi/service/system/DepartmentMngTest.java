package com.nh.kpi.service.system;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.nh.biz.domain.system.Department;
import com.nh.biz.service.system.DepartmentMng;
import com.nh.core.utils.reflaection.CollectionMapper;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(
locations={
		"classpath:applicationContext.xml", 
	    "classpath:applicationContext-common.xml",
	  }   		
) 
public class DepartmentMngTest {
	
	@Resource(name = "departmentMng")
	private DepartmentMng departmentMng;
	
	@Test
	public  final void testGetList(){
		List<Department> list = departmentMng.getAllSubList("0");
		for(Department dept : list){
			System.out.println(dept.getDeptName());
		}
		
	}
	
	//@Test
	public  final void testList(){
		List<Department> list = departmentMng.list();
		System.out.println(list.size());
		Map map =  CollectionMapper.extractToMap(departmentMng.list(), "deptId", "deptName");
		System.out.println(map);
	}
}
