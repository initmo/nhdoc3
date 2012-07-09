package com.nh.biz.service;

import java.io.File;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Service;

import com.nh.biz.dao.impl.ResourceTemplateDao;
import com.nh.biz.domain.ResourceInfo;
import com.nh.biz.domain.ResourceTemplate;
import com.nh.core.utils.FileUtil;

@Service("resourceTemplateService")
public class ResourceTemplateService {

	public ResourceTemplate getResourceTemplateById(Integer id){
		return resourceTemplateDao.findById(id);
	}
	
	public List<ResourceTemplate> getResourceTemplateListByTitleId(Integer titleId){
		return resourceTemplateDao.findByMap(new String[]{"titleid"}, new Object[]{titleId});
	}
	
	public void insert(ResourceTemplate template) {
		try {
			resourceTemplateDao.insert(template);
		} catch (Exception e) {
			throw new ServiceException(e);
		}
	}
	
	public void deleteTemplate(Integer id) {
		try {
			removeFile(getResourceTemplateById(id));
			resourceTemplateDao.deleteById(id);
		} catch (Exception e) {
			throw new ServiceException(e);
		}
		
	}
	
	/**删除实际文件**/
	private void removeFile(ResourceTemplate template){
		String path = template.getFullPath();
		File file = new File(path);
		file.delete();
	}
	
	//下载
	public void download(Integer id,HttpServletResponse response){
		ResourceTemplate template = this.getResourceTemplateById(id);
		FileUtil.downLoad(template.getFullPath(),template.getFilename(), response);
	}
	
	@Resource
	private ResourceTemplateDao resourceTemplateDao;

	


	
}
