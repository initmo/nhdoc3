package com.nh.kpi.service.system;

import java.util.List;

import javax.annotation.Resource;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.transaction.annotation.Transactional;

import com.nh.biz.domain.system.Permission;
import com.nh.biz.domain.system.Role;
import com.nh.biz.service.system.PermissionMng;
import com.nh.biz.service.system.RoleMng;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(
locations={
		"classpath:applicationContext.xml", 
	    "classpath:applicationContext-common.xml",
	  }   		
) 
public class RoleMngTest {

	@Resource
	private RoleMng roleMng;
	@Resource
	private PermissionMng permissionMng;
	
	@Test
	public final void testList(){
		List<Role> list = roleMng.list();
		System.out.println("RoleMngTest.testList():"+list.size());
		for(Role role : list){
			System.out.println(role.getRoleName()+":"+role.getPermissionNames());
		}
	}
	
	@Test
	public final void testGetById(){
		Role role = roleMng.getById(1);
		System.out.println("RoleMngTest.testGetById():"+role.getPermissionIds());
	}
	
	@Test
	@Transactional
	public final void testInsert(){
	    Role role = new Role();
	    role.setRoleName("new");
		List<Permission> permissionList = permissionMng.list();
		System.out.println("permissionList.size():"+permissionList.size());
		role.setPermission(permissionList);
		roleMng.insert(role);
	}
}
