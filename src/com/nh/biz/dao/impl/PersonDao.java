package com.nh.biz.dao.impl;


import org.springframework.stereotype.Repository;

import com.nh.biz.domain.Person;
import com.nh.core.orm.ibatis.GenericSqlMapDao;


@Repository("personDao")
public class PersonDao extends GenericSqlMapDao<Person, String>  {
}
