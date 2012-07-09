package com.nh.biz.controller;

import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.validation.Valid;

import org.apache.log4j.Logger;
import org.springframework.beans.propertyeditors.CustomDateEditor;
import org.springframework.beans.propertyeditors.StringTrimmerEditor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;

import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.context.request.WebRequest;


import com.nh.biz.domain.Person;
import com.nh.biz.service.PersonService;

@Controller
@RequestMapping("/main") 
public class PersonController {

	private static Logger logger = Logger.getLogger("controller");

	@Resource(name = "personService")
	private PersonService personService;

	@InitBinder
	public void initBinder(WebDataBinder binder, WebRequest request) {
		SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
		dateFormat.setLenient(false);
		binder.registerCustomEditor(Date.class, new CustomDateEditor(dateFormat, false));
		binder.registerCustomEditor(String.class, new StringTrimmerEditor(false));
	}
	/**
	 * 处理并接受所有的person并显示在JSP 页面.
	 * @return 对应名称的JSP页面.
	 */
	@RequestMapping(value = "/persons", method = RequestMethod.GET)
	public String getPerson(Model model) {
		
		logger.debug("处理并接受所有的person并显示在JSP 页面");
		
		List<Person> persons = personService.getAll();
		
		//查询得到Person后通过model传递至页面.
		model.addAttribute("persons", persons);
		
		//这个方法将返回 至/WEB-INF/jsp/personspage.jsp
		return "bskhZpf";
	}
	
	
	@RequestMapping(value = "/persons", method = RequestMethod.GET)
	public void getPerson1(Model model) {
		model.addAttribute("persons", personService.getAll());
	}

	/**
	 * 显示Add页面.
	 */
	@RequestMapping(value = "/persons/add", method = RequestMethod.GET)
	public String getAdd(Model model) {
		logger.debug("显示Add页面.");
		
		//创建一个Person对象并通过model传递到页面.
		//相当于 formBackingObject 方法.
		Person person = new Person();
		person.setFirstName("22");
		model.addAttribute("person",person);
		//这个方法将返回 至/WEB-INF/jsp/addpage.jsp
		return "addpage";
	}

	/**
	 * 添加一个新的Person
	 */

	@RequestMapping(value = "/persons/add", method = RequestMethod.POST)
	public String add(@Valid Person person,BindingResult result, Model model) {
		
		if (result.hasErrors()){
			logger.error(result.getFieldError("money"));
			return "addpage";
		}
		logger.debug("添加一个新的Person:"+person.getFirstName());
		personService.add(person);
		return "addedpage";
	}

	/**
	 * 删除指定的Person
	 */
	@RequestMapping(value = "/persons/delete/{id}", method = RequestMethod.GET)
	public String delete(
			@PathVariable String id, Model model) {
		logger.debug("删除指定的Person ID:"+id);
		personService.delete(id);
		model.addAttribute("id", id);
		return "deletedpage";
	}

	/**
	 * 显示Edit页面
	 * @return
	 */
	@RequestMapping(value = "/persons/edit/{id}", method = RequestMethod.GET)
	public String getedit(
			@PathVariable(value = "id") String id, Model model,HttpServletRequest request) {
		logger.debug("显示Edit页面");
		
		//通过ID查询得到的Person通过model传递至页面.
		model.addAttribute("personAttribute", personService.getPersonById(id));
		return "editpage";
	}

	/**
	 * Edit指定的Person
	 */
	@RequestMapping(value = "/persons/edit", method = RequestMethod.POST)
	public String saveEdit(@ModelAttribute("personAttribute") Person person,
			@RequestParam(value = "id", required = true) String id, ModelMap model) {
		System.out.println(model.get("others"));
		person.setId(id);
		personService.edit(person);
		model.addAttribute("id", id);
		return "editedpage";

	}

	@RequestMapping(value = "/persons/rsbody")
	@ResponseBody
	public Object handle() throws IOException {
	  List<Person> persons = personService.getAll();
	  return persons;
	}
	
	@ModelAttribute("others")//<——向模型对象中添加一个名为fileTypes的属性
    public String fileTypes() {
		logger.info("向模型对象中添加一个名为others的属性");
        return "add a others";
    }


}
