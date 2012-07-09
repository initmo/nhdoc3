package com.nh.kpi.dao.account;

import static org.junit.Assert.assertEquals;
import static org.junit.Assert.assertNotNull;

import java.util.List;

import javax.annotation.Resource;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.nh.biz.dao.impl.system.UserDao;
import com.nh.biz.domain.system.Role;
import com.nh.biz.domain.system.User;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("classpath:applicationContext.xml") 
public class UserDaoTest {

	@Resource(name = "userDao")
	private UserDao userDao;
	
	@Test
	public final void testGetUserById() {
		User user = userDao.findById("1");
		assertNotNull(user);
		assertEquals("admin", user.getLoginName());
		List<Role> roleList = user.getRoleList();
		assertNotNull(roleList);
		assertEquals(roleList.size(),2);
		for (Role role : roleList){
			System.out.println(role.getRoleId()+":"+role.getRoleName()+":"+role.getPermissionNames());
		}
	}
	
	@Test
	public final void testGetUserByLoginName() {
		User user = userDao.findUniqueByMap(new String[]{"loginName"}, new String[]{"admin"});
		assertNotNull(user);
		assertEquals("admin", user.getLoginName());
		List<Role> roleList = user.getRoleList();
		assertNotNull(roleList);
		assertEquals(roleList.size(),2);
		for (Role role : roleList){
			System.out.println(role.getRoleId()+":"+role.getRoleName()+":"+role.getPermissionNames());
		}
	}
	
}
