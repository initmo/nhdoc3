package com.nh.biz.controller;

import java.io.File;
import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;
import java.util.ArrayList;
import java.util.Collection;
import java.util.Collections;
import java.util.Date;
import java.util.Iterator;
import java.util.List;
import java.util.UUID;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.validation.Valid;

import org.apache.commons.lang.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.nh.biz.domain.ResourceInfo;
import com.nh.biz.domain.ResourceTemplate;
import com.nh.biz.domain.ResourceTitle;
import com.nh.biz.domain.system.Department;
import com.nh.biz.domain.system.User;
import com.nh.biz.service.ResourceApprovalService;
import com.nh.biz.service.ResourceInfoService;
import com.nh.biz.service.ResourceTemplateService;
import com.nh.biz.service.ResourceTitleService;
import com.nh.common.web.session.SessionProvider;
import com.nh.core.bean.DhxTree;
import com.nh.core.utils.DateUtil;
import com.nh.core.utils.FileUtil;



@Controller
public class ResourceInfoController {
	private static Logger logger  = LoggerFactory.getLogger(ResourceInfoController.class);

	public static final String RESOURCEINFO_EDIT     = "/resource/resourceinfoedit";
	public static final String RESOURCEINFO_UPLOAD   = "/resource/resourceinfoupload";
	public static final String FOLDER_EDIT           = "/resource/folderedit";
	public static final String RESOURCE_MOVE           = "/resource/resourcemove";
	public static final String UNAUTHORIZED           = "unauthorized";
	
	public static final Integer APPROVALSTATUS_DRAFT  = 0 ;
	public static final Integer APPROVALSTATUS_SENT   = 1 ;
	public static final Integer APPROVALSTATUS_RETURN = 2 ;
	public static final Integer APPROVALSTATUS_PASS  = 3 ;
	public static final Integer APPROVALSTATUS_FOLDER  = 4 ;

	
	/**新建文档**/
	@RequestMapping(value="/resource/resourceinfonew")
	public String resourceInfoNew(@ModelAttribute("resource") ResourceInfo resource, ModelMap modelMap){
		List<ResourceTemplate>  templates=  resourceTemplateService.getResourceTemplateListByTitleId(resource.getTitleid());
		modelMap.addAttribute("templates", templates);
		resource.setApprovalstatus(APPROVALSTATUS_DRAFT);
		return RESOURCEINFO_EDIT;
	}
	
	/**修改文档**/
	@RequestMapping(value="/resource/resourceinfoedit")
	public String resourceInfoEdit(@ModelAttribute("resource") ResourceInfo resource, HttpServletRequest request, ModelMap modelMap){
		resource = resourceInfoService.getResourceInfo(resource.getId());
		if(!isMyActResource(resource,request)) 
			return UNAUTHORIZED;
		modelMap.addAttribute("resource", resource);
		return RESOURCEINFO_EDIT;
	}
	
	
	/**上传文档页面**/
	@RequestMapping(value="/resource/resourceinfoupload")
	public String resourceinfoupload(Integer pid,Integer titleid,ModelMap modelMap){
		ResourceInfo parent = null;
		if(pid==0){			
			parent = new ResourceInfo();
			parent.setFilealiasname("根目录");
			parent.setTitleid(titleid);
			parent.setId(pid);
		}else{
			parent = resourceInfoService.getResourceInfo(pid);
		}
		modelMap.addAttribute("parent",parent);
		return RESOURCEINFO_UPLOAD;
	}
	
	/**装载模板**/
	@RequestMapping(value="/resource/loadtemplate")
	public void loadTemplate(Integer id ,HttpServletResponse response, ModelMap modelMap){
		resourceTemplateService.download(id, response);
	}
	
	/**在线文档保存**/      
	@ResponseBody 
	@RequestMapping(value="/resource/processuploadol")
	public String uploadOnline(HttpServletRequest request, MultipartHttpServletRequest multipartRequest,ModelMap modelMap) throws UnsupportedEncodingException{
		
		String id = request.getParameter("id");
		Integer pid = Integer.valueOf(request.getParameter("pid"));
		Integer titleId = Integer.valueOf(request.getParameter("titleid"));
		String filealiasname = URLDecoder.decode(request.getParameter("filealiasname"),"UTF-8");
		
		User user = sessionProvider.getSessionUser(request);
		Department dept = sessionProvider.getDepartment(request);
		
		for (Iterator it = multipartRequest.getFileNames(); it.hasNext();) {  
	        String key = (String)it.next();  
	        MultipartFile file = multipartRequest.getFile(key);  
	        
	        if (file.getOriginalFilename().length() > 0) {
	        	
	        	if(StringUtils.isNotEmpty(id)){   //update
	    			ResourceInfo resourceInfo = resourceInfoService.getResourceInfo(Integer.valueOf(id));
	    			if(!isMyDeptResource(resourceInfo,request)) 
	    				return "-1";
	    			resourceInfo.setFilealiasname(filealiasname);
	    			resourceInfo.setFilesize(file.getSize()/1024);
	    			resourceInfo.setModifiedtime(new Date());
	    			resourceInfoService.updateResource(resourceInfo,file);
	    			return  id;
	    		}else{ //新增
			        	 // 文件后缀名
			        	String ext = FileUtil.getExtension(file.getOriginalFilename(),"").toLowerCase();  
		                 //	硬盘存储实际文件名
			        	String diskFileName =  UUID.randomUUID().toString()+"."+ext;         
			        	// 文件存储路径：根目录\单位编号\文档标题号\文件名
			        	String diskFilePath = resource_dir + dept.getDeptId() + File.separator + String.valueOf(titleId) + File.separator;
			        	ResourceInfo resourceinfo = new ResourceInfo();
			        	resourceinfo.setApprovalstatus(APPROVALSTATUS_DRAFT);
			        	resourceinfo.setCreator(user.getUserName());
			        	resourceinfo.setCreatorid(user.getUserId());
			        	resourceinfo.setDepartment(dept.getDeptName());
			        	resourceinfo.setDepartmentid(dept.getDeptId());
			        	resourceinfo.setFilename(file.getOriginalFilename());
			        	resourceinfo.setFilealiasname(filealiasname);
			        	resourceinfo.setFiletype(ext);
			        	resourceinfo.setFiledir(diskFilePath);
			        	resourceinfo.setFilerealname(diskFileName);
			        	resourceinfo.setFilesize(file.getSize()/1024);
			        	resourceinfo.setIsdir(false);
			        	resourceinfo.setModifiedtime(new Date());
			        	resourceinfo.setPid(pid);
			        	resourceinfo.setTitleid(titleId);
			        	try{
			        		 return String.valueOf(resourceInfoService.insertResource(resourceinfo,file));
			        	}catch (Exception e) {
			        		return "-1";
						}
	    			}
	        	}
		}
		return "-1";
	}
	
	
	/**上传文档处理**/      
	@ResponseBody 
	@RequestMapping(value="/resource/processupload")
	public String upload(HttpServletRequest request, MultipartHttpServletRequest multipartRequest,Boolean sendApproval, Integer pid,Integer titleid,ModelMap modelMap){
		
		User user = sessionProvider.getSessionUser(request);
		Department dept = sessionProvider.getDepartment(request);
	
		for (Iterator it = multipartRequest.getFileNames(); it.hasNext();) {  
	        String key = (String)it.next();  
	        MultipartFile file = multipartRequest.getFile(key);  
	        
	        if (file.getOriginalFilename().length() > 0) {  
	        	 // 文件后缀名
	        	String ext = FileUtil.getExtension(file.getOriginalFilename(),"").toLowerCase();  
                 //	硬盘存储实际文件名
	        	String diskFileName =  UUID.randomUUID().toString()+"."+ext;         
	        	// 文件存储路径：根目录\单位编号\文档标题号\文件名
	        	String diskFilePath = resource_dir + dept.getDeptId() + File.separator + String.valueOf(titleid) + File.separator;
	        	ResourceInfo resourceinfo = new ResourceInfo();
	        	resourceinfo.setApprovalstatus(APPROVALSTATUS_DRAFT);
	        	resourceinfo.setCreator(user.getUserName());
	        	resourceinfo.setCreatorid(user.getUserId());
	        	resourceinfo.setDepartment(dept.getDeptName());
	        	resourceinfo.setDepartmentid(dept.getDeptId());
	        	resourceinfo.setFilename(file.getOriginalFilename());
	        	resourceinfo.setFilealiasname(file.getOriginalFilename());
	        	resourceinfo.setFiletype(ext);
	        	resourceinfo.setFiledir(diskFilePath);
	        	resourceinfo.setFilerealname(diskFileName);
	        	resourceinfo.setFilesize(file.getSize()/1024);
	        	resourceinfo.setIsdir(false);
	        	resourceinfo.setModifiedtime(new Date());
	        	resourceinfo.setPid(pid);
	        	resourceinfo.setTitleid(titleid);
	        	try{
	        		resourceInfoService.insertResource(resourceinfo,file);
	        		if(sendApproval){	        			
	        			resourceApprovalService.sendApprovalRequest(resourceinfo);
	        		}
	        	}catch (Exception e) {
	        		return e.toString();
				}
	        }
		}
		return "success";
	}
	
	
	/**批量删除文档**/
	@ResponseBody 
	@RequestMapping(value="/resource/batchdeleteresource", method = RequestMethod.POST)
	public String batchDeleteResource(String ids,HttpServletRequest request){
		String[] idArray = ids.split(",");
		for(String id : idArray){
			ResourceInfo resourceInfo = resourceInfoService.getResourceInfo(Integer.valueOf(id));
			if(!isMyActResource(resourceInfo,request)) 
				continue;
			resourceInfoService.deleteResourceInfo(resourceInfo);
		}
		return "success";
	}
	
	
	/**下载单个文档**/
	@RequestMapping(value="/resource/download")
	public void download(Integer id, HttpServletResponse response, ModelMap modelMap){
		resourceInfoService.downloadFile(id, response);
	}
	
	/**打包下载文档**/
	@RequestMapping(value="/resource/packagedownload")
	public void packagedownload(Integer[] ids,HttpServletRequest request, HttpServletResponse response, ModelMap modelMap){
		User user = sessionProvider.getSessionUser(request);
		resourceInfoService.packageDownLoadFile(ids,user.getLoginName(), response);
	}
	
	/**新建文件夹**/
	@RequestMapping(value="/resource/foldernew")
	public String foldernew(@ModelAttribute("folder") ResourceInfo folder,ModelMap modelMap){
		return FOLDER_EDIT;
	}
	
	/**修改文件夹**/
	@RequestMapping(value="/resource/folderedit")
	public String folderedit(Integer id,HttpServletRequest request, ModelMap modelMap){
		ResourceInfo folder = resourceInfoService.getResourceInfo(id);
		if(!isMyActResource(folder,request)) 
			return UNAUTHORIZED;
		modelMap.addAttribute("folder", folder);
		return FOLDER_EDIT;
	}
	
	/**移动文件页面**/
	@RequestMapping(value="/resource/move/view")
	public String moveview(Integer titleId,ModelMap modelMap){
		modelMap.addAttribute("titleId", titleId);
		return RESOURCE_MOVE;
	}
	
	/**移动文件处理**/
	@ResponseBody
	@RequestMapping(value="/resource/move/process")
	public String moveprocess(Integer titleId,String ids,Integer pid){
		String[] idArray = ids.split(",");
		List<Integer> list;
		if(idArray.length > 0){
			list  = new ArrayList<Integer>();
			for(int i = 0 ; i<idArray.length;i++){
				if (StringUtils.isNotEmpty(idArray[i]))
				list.add(Integer.valueOf(idArray[i]));
			}
			resourceInfoService.move(list,pid);
		}
		return "success";
	}
	
	
	/**移动目标**/
	@RequestMapping(value="/resource/move/treeleaf")
	public String treeleaf(Integer id, Integer titleId,HttpServletRequest request, ModelMap modelMap){
		List<DhxTree> list = new ArrayList<DhxTree>();
		Department dept = sessionProvider.getDepartment(request);
		List<ResourceInfo> resourceinfos = null;
		if(id==0){			
			 resourceinfos = resourceInfoService.getResourceInfoList(titleId, id, dept.getDeptId());
		}
		else{
			ResourceInfo parent = resourceInfoService.getResourceInfo(id);
		    resourceinfos = resourceInfoService.getResourceInfoListByParent(parent);
		}

		
		for(ResourceInfo resourceInfo : resourceinfos){
			if(!resourceInfo.getIsdir())
				continue;
			DhxTree dt = new DhxTree();
		    dt.setId(String.valueOf(resourceInfo.getId()));
			dt.setPid(String.valueOf(resourceInfo.getPid()));
			dt.setText(resourceInfo.getFilealiasname());
			dt.setChild(1);
			list.add(dt);
		}
		
		modelMap.addAttribute("list", list);
		modelMap.addAttribute("titleId", titleId);
		modelMap.addAttribute("pid", id);
		
		return "/resource/movetreexml";

	}
	
	
	/**保存文件夹**/
	@RequestMapping(value="/resource/foldersave",method = RequestMethod.POST)
	public String foldersave(@ModelAttribute("folder") @Valid ResourceInfo folder,BindingResult result, HttpServletRequest request, ModelMap modelMap){
		Boolean isNew = (folder.getId()==null);
		if(result.hasErrors()){
			return isNew ? foldernew(folder,modelMap) : folderedit(folder.getId(),  request, modelMap);
		}
		
		User operator = sessionProvider.getSessionUser(request);
		Department dept = sessionProvider.getDepartment(request);
		
		folder.setFilename(folder.getFilealiasname());
		folder.setIsdir(true);
		folder.setApprovalstatus(APPROVALSTATUS_FOLDER);
		folder.setModifiedtime(new Date());
		folder.setCreator(operator.getUserName());
		folder.setCreatorid(operator.getUserId());
		folder.setDepartment(dept.getDeptName());
		folder.setDepartmentid(dept.getDeptId());
		folder.setFiletype("folder");
		if(isNew){	
			resourceInfoService.insertResourceInfo(folder);
		}else{
			if(!isMyDeptResource(folder,request)) 
				return UNAUTHORIZED;
			resourceInfoService.updateResourceInfo(folder);
		}
		modelMap.addAttribute("titleId",folder.getTitleid());
		modelMap.addAttribute("pid",folder.getPid());
		return "redirect:/resource/resourceinfolist";		
	}
	
	/**发送审核**/
	@ResponseBody 
	@RequestMapping(value="/resource/batchsentapproval", method = RequestMethod.POST)
	public String batchSentApproval(String ids,HttpServletRequest request){
		String[] idArray = ids.split(",");
		for(String id : idArray){
			ResourceInfo resourceInfo = resourceInfoService.getResourceInfo(Integer.valueOf(id));
			if(!isMyActResource(resourceInfo,request)) 
				continue;
			resourceApprovalService.sendApprovalRequest(resourceInfo);
		}
		return "success";
	}
	
	private Boolean isMyDeptResource(ResourceInfo resourceInfo,HttpServletRequest request){
		Integer myDept = sessionProvider.getDepartment(request).getDeptId();
		return resourceInfo.getDepartmentid().equals(myDept);
	}
	
	private Boolean isMyPersonResource(ResourceInfo resourceInfo,HttpServletRequest request){
		String userId = sessionProvider.getSessionUser(request).getUserId();
		return resourceInfo.getCreatorid().equals(userId);
	}
	
	private Boolean isMyActResource(ResourceInfo resourceInfo,HttpServletRequest request){
		String userId = sessionProvider.getSessionUser(request).getUserId();
		Boolean IsMyActTitle = resourceTitleService.hasActTitle(Integer.valueOf(userId), resourceInfo.getTitleid());
		return isMyDeptResource(resourceInfo,request) && IsMyActTitle;
	}
	
	
	@Value("${web.resource_dir}")  
	private String resource_dir ;
	
	@Resource
	private SessionProvider sessionProvider;
	@Resource
	private ResourceApprovalService resourceApprovalService;
	@Resource
	private ResourceInfoService resourceInfoService;
	@Resource
	private ResourceTitleService resourceTitleService;
	@Resource
	private ResourceTemplateService resourceTemplateService;
}
