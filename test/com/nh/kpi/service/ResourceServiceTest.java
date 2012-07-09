package com.nh.kpi.service;

import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;

import org.apache.commons.lang.StringUtils;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.nh.biz.domain.ResourceActor;
import com.nh.biz.domain.ResourceTitle;
import com.nh.biz.service.ResourceInfoService;
import com.nh.biz.service.ResourceTitleService;


@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(
locations={
		"classpath:applicationContext.xml", 
	    "classpath:applicationContext-common.xml",
	  }  
)
public class ResourceServiceTest {

	
	//@Test
	public void testInsertActors(){
		List<ResourceActor> actors = new ArrayList<ResourceActor>();
		List<Integer> actorIdList = new ArrayList<Integer>();
		String actorIds = "33,31,32,34";
		String[] actorIdArray = actorIds.split(",");
		if(actorIdArray.length > 0 ){
			for(String actorId : actorIdArray){
				actors.add(new ResourceActor(100,Integer.valueOf(actorId)));
				actorIdList.add(Integer.valueOf(actorId));
			}
		}
		
		//批量插入
		//resourceTitleService.insertActors(actors);
		//批量删除
		resourceTitleService.deleteActorByTitle(Integer.valueOf(100));
		
	}
	
	//@Test
	public void testUpdateActors(){
		List<ResourceActor> actors = new ArrayList<ResourceActor>();
		String actorIds = ",1,2,14,,";
		Integer titleId = 301;
		String[] actorIdArray = actorIds.split(",");
		if(actorIdArray.length > 0 ){
			for(String actorId : actorIdArray){
				if (StringUtils.isNotEmpty(actorId)){
					System.out.println("actorId:"+actorId);
					actors.add(new ResourceActor(titleId,Integer.valueOf(actorId)));
				}
			}
		}
		resourceTitleService.updateActors(titleId, actors);
	}
	
	
 	//@Test
 	public void compareResourceTitle(){
 		ResourceTitle rt1 = new ResourceTitle();
 		rt1.setId(1);
 		ResourceTitle rt2 = new ResourceTitle();
 		rt2.setNoticeCycle("11");
 		rt2.setId(1);
 		System.out.println("rt1.equals(rt2):"+rt1.equals(rt2));
 		
 		List<ResourceTitle> list1 = new ArrayList<ResourceTitle>();
 		list1.add(rt1);
 		System.out.println("list1.contains(rt2):"+list1.contains(rt2));
 		
 		System.out.println(rt1.hashCode());
 		System.out.println(rt2.hashCode());
 	}
	

 	@Test
 	public void testPackDownload(){
 		Integer[] resourceIds = new Integer[]{259};
 		resourceInfoService.packageDownLoadFile(resourceIds, "admin", null);
 	}
 	
	@Resource
	private ResourceTitleService resourceTitleService;
	@Resource
	private ResourceInfoService resourceInfoService;
}
