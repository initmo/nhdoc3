package com.nh.kpi.service.system;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.nh.biz.domain.system.Permission;
import com.nh.biz.service.system.PermissionMng;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(
locations={
		"classpath:applicationContext.xml", 
	    "classpath:applicationContext-common.xml",
	  }   		
) 
public class PermissionMngTest {

	@Resource
	private PermissionMng permissionMng;
	
	@Test
	public final void testList(){
		List<Permission> list = permissionMng.list();
		System.out.println("PermissionMngTest.testList():"+list.size());
	}
	
	@Test
	public final void getPermissions(){
		Map<Integer, String> permissions = new HashMap<Integer, String>();
		List<Permission> permissionList = permissionMng.list();
		for (Permission permission : permissionList){
			permissions.put(permission.getPermissionId(), permission.getPermissionDisplay());
		}
		permissions.remove(null);
		System.out.println(permissions);
	}
}
