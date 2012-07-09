package com.nh.kpi.dao;

import static org.junit.Assert.*;

import java.util.UUID;

import javax.annotation.Resource;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.transaction.annotation.Transactional;

import com.nh.biz.dao.impl.PersonDao;
import com.nh.biz.domain.Person;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("classpath:applicationContext.xml") //ָ��Spring�������ļ� /Ϊclasspath��  

public class PersonDaoTest {
	@Resource(name = "personDao")
	private PersonDao personDao;
	
	@Test
	public final void testGetPersonById() {
		Person person = personDao.findById("982a86fd-46f4-4d13-8fca-0c04411f4e7c");
		assertNotNull(person);
		assertEquals("11", person.getFirstName());
	}
	
	@Test
	@Transactional
	public final void  testSave(){
		Person person = new Person();
		String id = UUID.randomUUID().toString();
		person.setId(id);
		person.setFirstName("cc");
		person.setLastName("cc");
		person.setMoney(22.0);
		try {
			personDao.insert(person);
		} catch (Exception e) {
			// TODO 自动生成 catch 块
			e.printStackTrace();
		}
	}
	
}
