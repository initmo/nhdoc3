package com.nh.kpi.controller;


import static org.junit.Assert.assertEquals;
import static org.junit.Assert.assertNotNull;

import java.util.UUID;

import javax.annotation.Resource;
import javax.validation.constraints.AssertTrue;

import org.junit.Before;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.AbstractJUnit4SpringContextTests;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.transaction.annotation.Transactional;

import com.nh.biz.domain.Person;
import com.nh.biz.service.PersonService;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("classpath:applicationContext.xml") //ָ��Spring�������ļ� /Ϊclasspath��  

public class PersonTest{

	@Resource(name = "personService")
	private PersonService personService;
	

	@Test
	@Transactional
	public void testHandleRequestView() {		
		Person person = new Person();
		person.setFirstName("mo");
		UUID id = UUID.randomUUID();
		person.setId(id.toString());
		person.setLastName("jianjun");
		person.setMoney(2.32);
        assertNotNull(person);
        personService.add(person);
    }
	
	@Test
	@Transactional
	public void testDelete() {
		 personService.delete("ada7e144-d79f-4479-a9af-e68ca868c009");
		 assertEquals(0, personService.getAll().size());
	}
	
	@Test
	public void testGetPersonById() {
		Person person = personService.getPersonById("ada7e144-d79f-4479-a9af-e68ca868c009");
		assertEquals("a", person.getFirstName());
	}

}
