package com.nh.biz.controller;

import java.util.HashMap;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.validation.Valid;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.nh.biz.domain.ResourceTitle;
import com.nh.biz.service.ResourceTitleService;

@Controller
public class SettingTitleController {

	public static final String SETTING_TITLE_LIST    = "/setting/titlelist";
	public static final String SETTING_TITLE_EDIT    = "/setting/titleedit";
	
    //文档标题
	@RequestMapping(value="/setting/titlelist")
	public String titlelist(Integer treeId,ModelMap modelMap){
		modelMap.addAttribute("treeId", treeId);
		modelMap.addAttribute("list", resourceTitleService.getResourceTitleByTreeId(treeId));
		return SETTING_TITLE_LIST;
	}
	
    //新增文档标题
	@RequestMapping(value="/setting/titlenew")
	public String titlenew(@ModelAttribute("title") ResourceTitle title, ModelMap modelMap){
		title.setTitleName("--请输入标题名称--");
		title.setNoticeCycle("I");
		title.setIsEnable(true);
		Map<String,String> cycletypes = new HashMap<String,String>();
		cycletypes.put("I", "即时更新");
		cycletypes.put("M", "每月更新");
		cycletypes.put("S", "每季更新");
		cycletypes.put("H", "每年1,6月更新");
		cycletypes.put("Y", "每年1月更新");
		modelMap.addAttribute("cycletypes", cycletypes);
		return SETTING_TITLE_EDIT;
	}
	
	 //修改文档标题	
	@RequestMapping(value="/setting/titleedit")
	public String titleedit(Integer id, ModelMap modelMap){
		modelMap.put("title",  resourceTitleService.getResourceTitleById(id));
		modelMap.addAttribute("title", resourceTitleService.getResourceTitleById(id));
		Map<String,String> cycletypes = new HashMap<String,String>();
		cycletypes.put("I", "即时更新");
		cycletypes.put("M", "每月更新");
		cycletypes.put("S", "每季更新");
		cycletypes.put("H", "每年1,6月更新");
		cycletypes.put("Y", "每年1月更新");
		modelMap.addAttribute("cycletypes", cycletypes);
		return SETTING_TITLE_EDIT;
	}
	
	//保存文档标题信息
	@RequestMapping(value="/setting/titleinfosave",method = RequestMethod.POST)
	public String titleinfosave(@ModelAttribute("title") @Valid ResourceTitle title,BindingResult result, HttpServletRequest request, ModelMap modelMap){
		Boolean isNew = (title.getId()==null);
		if(result.hasErrors()){
			return null;
		}
		
		if(isNew){
			resourceTitleService.newSaveTitleInfo(title);
		}else{
			resourceTitleService.updateTitleInfo(title);
		}

		modelMap.addAttribute("id",title.getId());  
		return "redirect:/setting/titleedit";
	}
	
	//删除文档标题
	@RequestMapping(value="/setting/titledelete")
	public String titledelete(Integer id, ModelMap modelMap){
		Integer treeId = resourceTitleService.getResourceTitleById(id).getTreeId();
		resourceTitleService.deleteTitleById(id);
		modelMap.addAttribute("treeId",treeId);
		return "redirect:/setting/titlelist";
	}
	
	@Resource
	private ResourceTitleService resourceTitleService;
}
