package com.nh.kpi.service;

import java.util.List;

import javax.annotation.Resource;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.nh.biz.domain.MyActNotice;
import com.nh.biz.domain.ResourceApproval;
import com.nh.biz.domain.system.User;
import com.nh.biz.service.MyActNoticeService;
import com.nh.biz.service.ResourceApprovalService;


@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(
locations={
		"classpath:applicationContext.xml", 
	    "classpath:applicationContext-common.xml",
	  }  
)
public class MyNoticeServiceTest {
    
	//@Test
	public void testGetMyActNotice(){
		User user = new User();
		user.setUserId("1");
		user.setDeptId(1001);
		List<MyActNotice> list =  myActNoticeService.getMyActNotice(user);
		System.out.println(list.size());
	}
	

	

	@Resource
	private MyActNoticeService myActNoticeService;
	@Resource
	private ResourceApprovalService resourceApprovalService;
	
	
}
