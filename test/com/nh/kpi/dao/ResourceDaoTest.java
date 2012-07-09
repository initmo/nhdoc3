package com.nh.kpi.dao;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.nh.biz.dao.impl.ResourceInfoDao;
import com.nh.biz.dao.impl.ResourceTitleDao;
import com.nh.biz.domain.ResourceInfo;


@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(
locations={
		"classpath:applicationContext.xml", 
	    "classpath:applicationContext-common.xml",
	  }  
)
public class ResourceDaoTest {
	

	
	//@Test
	public void findByMap(){
		List<ResourceInfo> list = resourceInfoDao.findByMap(new String[]{"titleid","pid","departmentid"}, 
				  new Object[]{1,0,1001});

		System.out.println(list.size());
	
	}
	
@Test
public void atest(){
	System.out.println("我爱你CFGHA".substring(1,3));
}
	
	@Resource
	private ResourceInfoDao resourceInfoDao;
	@Resource
	private ResourceTitleDao resourceTitleDao;

}
