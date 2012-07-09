package com.nh.kpi.service;

import static org.junit.Assert.*;

import java.util.List;

import javax.persistence.Transient;
import javax.validation.Valid;
import javax.validation.Validation;
import javax.validation.Validator;

import org.junit.After;
import org.junit.Before;
import org.junit.Test;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;
import org.springframework.transaction.annotation.Transactional;



import com.nh.biz.domain.Person;
import com.nh.biz.service.PersonService;


public class PersonServiceTest {

	
	private ApplicationContext context;
	private PersonService personService;
	private Person tperson ;
	
	@Before

	public void init(){
	    context = new ClassPathXmlApplicationContext("applicationContext.xml");   
	    personService = (PersonService)context.getBean("personService");
	    
	    tperson  = new Person();
	    tperson.setFirstName("test_FirstName");
	    tperson.setLastName(null);
	    tperson.setMoney(1.01);
	}
	
	@Test
	public final void testGetAll() {
		List<Person> list = personService.getAll();
		assertNotNull(list);
		assertTrue(list.size()>0);
	}

	@Test
	public final void testGetPersonById() {
		Person person = personService.getPersonById("982a86fd-46f4-4d13-8fca-0c04411f4e7c");
		assertNotNull(person);
		assertTrue("11".equals(person.getFirstName()));
	}

	@Test
	@Transient
	public final void testAdd() {

		personService.add(tperson);
		personService.add(tperson);
		tperson.setMoney(1.0);
		personService.add(tperson);
	}

	
	public final void testDelete() {
		fail("��δʵ��"); // TODO
	}

	public final void testEdit() {
		fail("��δʵ��"); // TODO
	}
	
	

}
