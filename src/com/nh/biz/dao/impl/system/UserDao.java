package com.nh.biz.dao.impl.system;

import org.springframework.stereotype.Repository;

import com.nh.biz.domain.system.User;
import com.nh.core.orm.ibatis.GenericSqlMapDao;

@Repository("userDao")
public class UserDao extends GenericSqlMapDao<User,String> {
	public static final String INSERT_USERROLE = ".insertUserRole";
	public static final String DELETE_USERROLE_BY_USERID = ".deleteUserRoleByUserId";
}
