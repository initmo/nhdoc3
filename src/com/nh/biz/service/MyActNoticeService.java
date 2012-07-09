package com.nh.biz.service;

import java.util.Calendar;
import java.util.Date;
import java.util.GregorianCalendar;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.nh.biz.dao.impl.MyActNoticeDao;
import com.nh.biz.domain.MyActNotice;
import com.nh.biz.domain.ResourceTitle;
import com.nh.biz.domain.system.User;
import com.nh.core.utils.reflaection.CollectionMapper;

@Service("myActNoticeService")
public class MyActNoticeService {

	public List<MyActNotice> getMyActNotice(User user){
		List<ResourceTitle> myActTitle = resourceTitleService.getResourceListByActor(user.getUserId());
		
		List<Integer> myActTitleIds = CollectionMapper.extractToList(myActTitle, "id");
	    Date date=new Date();//取时间
        Calendar calendar = new GregorianCalendar();
        calendar.setTime(date);
        calendar.add(calendar.DATE,3);//把日期往后增加3天.整数往后推,负数往前移动
        date=calendar.getTime(); //这个时间就是日期往后推一天的结果 
		List<MyActNotice> myActNoticeList = myActNoticeDao.findByMap(new String[]{"deptid","titleids","nextact"}, new Object[]{user.getDeptId(),myActTitleIds,date});
		return myActNoticeList;
	}
	
	@Resource
	private MyActNoticeDao myActNoticeDao;
	@Resource
	private ResourceTitleService resourceTitleService;
}
