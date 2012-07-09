package com.nh.biz.dao.impl.system;

import org.springframework.stereotype.Repository;

import com.nh.biz.domain.system.Role;
import com.nh.core.orm.ibatis.GenericSqlMapDao;

@Repository
public class RoleDao extends GenericSqlMapDao<Role,Integer> {

	public static final String INSERT_ROLEPERMISSIONS = ".insertRolePermissions";
	public static final String DELETE_ROLEPERM_BY_ROLEID = ".deleteRolePermByRoleId";
}
