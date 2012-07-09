package com.nh.biz.controller;

import java.io.File;
import java.util.Date;
import java.util.Iterator;
import java.util.UUID;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.nh.biz.domain.ResourceTemplate;
import com.nh.biz.service.ResourceTemplateService;
import com.nh.biz.service.ResourceTitleService;
import com.nh.biz.service.ServiceException;
import com.nh.core.utils.FileUtil;

@Controller
public class SettingTemplateCotroller {
	
	@RequestMapping(value="/setting/template")
	public String template(Integer titleId, ModelMap modelMap){
		modelMap.addAttribute("list", resourceTemplateService.getResourceTemplateListByTitleId(titleId));
		modelMap.addAttribute("title", resourceTitleService.getResourceTitleById(titleId));
		modelMap.addAttribute("titleId", titleId);
		return "/setting/template";
	}


	@RequestMapping(value="/setting/template/upload") 														  
	public String upload(HttpServletRequest request, MultipartHttpServletRequest multipartRequest,Integer titleId,ModelMap modelMap){
		 File uploadfloder = new File(template_dir);
		 if(!uploadfloder.exists())uploadfloder.mkdirs();
		 
		 ResourceTemplate template = new ResourceTemplate();
	
	     for (Iterator it = multipartRequest.getFileNames(); it.hasNext();) {  
	        String key = (String)it.next();  
	        MultipartFile file = multipartRequest.getFile(key);  
	        if (file.getOriginalFilename().length() > 0) {  
	        	String newFileName =  UUID.randomUUID().toString()+"."+FileUtil.getExtension(file.getOriginalFilename(),""); 
	        	
	        	template.setFilename(file.getOriginalFilename());
	        	template.setFilerealname(newFileName);
	        	template.setFiletype(FileUtil.getExtension(file.getOriginalFilename(),""));
	        	template.setTitleid(titleId);
	        	template.setTmpname(file.getOriginalFilename());
	        	template.setUploadtime(new Date());
	        	template.setFiledir(template_dir);
	        	
	        	resourceTemplateService.insert(template);
	        	try {
	        		file.transferTo(new File(template_dir+newFileName));
				} catch (Exception e) {
					throw new ServiceException("文件上传失败："+e);
				}
	        }  
	    }                       
	     modelMap.addAttribute("titleId", titleId);
	     return "redirect:/setting/template";
	}
	
	@RequestMapping(value="/setting/template/delete")
	public String delete(Integer id,Integer titleId, ModelMap modelMap){
		 resourceTemplateService.deleteTemplate(id);
		 modelMap.addAttribute("titleId", titleId);
	     return "redirect:/setting/template";
	}
	
	@RequestMapping(value="/setting/template/download")
	public void getFile(Integer id ,HttpServletResponse response, ModelMap modelMap){
		resourceTemplateService.download(id, response);
	}
	
	
	@Value("${web.template_dir}")  
	private String template_dir ;
	@Resource
	private ResourceTitleService resourceTitleService;
	@Resource
	private ResourceTemplateService resourceTemplateService;
}
