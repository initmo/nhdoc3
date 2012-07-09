package com.nh.biz.service;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.annotation.Resource;
import javax.sql.DataSource;

import org.apache.log4j.Logger;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.jdbc.core.simple.SimpleJdbcTemplate;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.googlecode.ehcache.annotations.Cacheable;
import com.googlecode.ehcache.annotations.TriggersRemove;
import com.nh.biz.dao.impl.PersonDao;
import com.nh.biz.domain.Person;

@Service("personService")
public class PersonService {

	private static Logger logger = Logger.getLogger("service");

	private SimpleJdbcTemplate jdbcTemplate;
	private PersonDao personDao ; 

	@Resource(name = "dataSource")
	public void setDataSource(DataSource dataSource) {
		this.jdbcTemplate = new SimpleJdbcTemplate(dataSource);
	}

	 @Resource
		public void setPersonDao(PersonDao personDao) {
			this.personDao = personDao;
	}
	 
	/**
	 * 查询所有Person
	 */
	public List<Person> getAll() {
		List<Person> personList = personDao.pageQueryBy(new String[]{}, new String[]{}, "pid", "asc", 5, 1);
		return personList;
	}


	/**
	 * 根据ID查询对应的Person.
	 */
	@Cacheable(cacheName="metaColumnCache")
	public Person getPersonById(String id) {
		return personDao.findById(id);
	}

	/**
	 * 新增Person
	 */
	@Transactional
	public void add(Person person) {
		logger.debug("新增Person");
		String uuid = UUID.randomUUID().toString();
		person.setId(uuid);
		try {
			personDao.insert(person);
		} catch (Exception e) {
			throw new ServiceException("新增用户失败。",e);
		}
	}

	/**
	 * 删除指定的Person
	 */
	public void delete(String id) {
		logger.debug("删除指定的Person");
		String sql = "delete from person where id = ?";
		jdbcTemplate.update(sql, new Object[] { id });
	}

	/**
	 * 修改指定的Person
	 * @param person
	 */
	@TriggersRemove(cacheName="metaColumnCache", removeAll=true) 
	public void edit(Person person) {
		logger.debug("修改指定的Person");
		String sql = "update person set firstname = :firstName, "
				+ "lastname = :lastName, money = :money where id = :id";
		Map<String, Object> parameters = new HashMap<String, Object>();
		parameters.put("id", person.getId());
		parameters.put("firstName", person.getFirstName());
		parameters.put("lastName", person.getLastName());
		parameters.put("money", person.getMoney());
		jdbcTemplate.update(sql, parameters);
	}

	 public static final class PersonMapper implements RowMapper<Person>{
		public Person mapRow(ResultSet rs, int rowNum) throws SQLException {
			Person person = new Person();
			person.setId(rs.getString("id"));
			person.setFirstName(rs.getString("firstname"));
			person.setLastName(rs.getString("lastname"));
			person.setMoney(rs.getDouble("money"));
			return person;
		}
	}

	

}
